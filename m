Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266582AbUJTVjn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266582AbUJTVjn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 17:39:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267928AbUJTViw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 17:38:52 -0400
Received: from tron.kn.vutbr.cz ([147.229.191.152]:22282 "EHLO
	tron.kn.vutbr.cz") by vger.kernel.org with ESMTP id S269059AbUJTVeE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 17:34:04 -0400
Message-ID: <4176D9CC.5010107@stud.feec.vutbr.cz>
Date: Wed, 20 Oct 2004 23:34:04 +0200
From: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
User-Agent: Mozilla Thunderbird 0.7 (X11/20040615)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@Raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-rc4-mm1-U8
References: <20041014234202.GA26207@elte.hu> <20041015102633.GA20132@elte.hu> <20041016153344.GA16766@elte.hu> <20041018145008.GA25707@elte.hu> <20041019124605.GA28896@elte.hu> <20041019180059.GA23113@elte.hu> <20041020094508.GA29080@elte.hu> <4176403B.5@stud.feec.vutbr.cz> <20041020105630.GB2614@elte.hu> <417645A4.7000802@stud.feec.vutbr.cz> <20041020120434.GA6297@elte.hu>
In-Reply-To: <20041020120434.GA6297@elte.hu>
Content-Type: multipart/mixed;
 boundary="------------010103010407070000080505"
X-Spam-Flag: NO
X-Spam-Report: Spam detection software, running on the system "tron.kn.vutbr.cz", has
  identified this incoming email as possible spam.  The original message
  has been attached to this so you can view it (if it isn't spam) or block
  similar future email.  If you have any questions, see
  the administrator of that system for details.
  ____
  Content analysis details:   (0.7 points, 6.0 required)
  ____
   pts rule name              description
  ---- ---------------------- --------------------------------------------
   0.7 FROM_ENDS_IN_NUMS      From: ends in numbers
  -0.0 BAYES_40               BODY: Bayesian spam probability is 40 to 44%
                              [score: 0.4016]
  ____
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010103010407070000080505
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Ingo Molnar wrote:
> disable_irq() should work fine though. (it doesnt disable local
> interrupts, it only disables that particular irq line.) So something
> else disabled interrupts - ah, netconsole.c itself. Does the patch below
> fix things up for you?
> 
> 	Ingo
 > [patch snipped]

That patch was not enough. The BUGs were still showing up the same as 
before.
I tried to debug it myself. I've found an interesting thing in 
kernel/printk.c:release_console_sem(). There is the following sequence:

   spin_lock_irqsave(&logbuf_lock, flags);
   /* ... some code ... */
   spin_unlock(&logbuf_lock);
   call_console_drivers(...);
   local_irq_restore(flags);

I know very little about locking, but I didn't like this two-phased 
unlock. So I replaced it with a single spin_unlock_irqrestore. Patch 
attached.
I'm almost certain that there is a reason for the two-phased unlocking 
and that this patch will break something, but so far it works for me. 
netconsole now works without complaining.

Michal

--------------010103010407070000080505
Content-Type: text/x-patch;
 name="printk-console-sem.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="printk-console-sem.diff"

diff -Nurp linux-2.6.9-rc4-mm1-RT-U8/kernel/printk.c linux-2.6.9-rc4-mm1-RT-U8-m/kernel/printk.c
--- linux-2.6.9-rc4-mm1-RT-U8/kernel/printk.c	2004-10-20 22:20:55.000000000 +0200
+++ linux-2.6.9-rc4-mm1-RT-U8-m/kernel/printk.c	2004-10-20 22:24:40.000000000 +0200
@@ -646,9 +646,8 @@ void release_console_sem(void)
 		_con_start = con_start;
 		_log_end = log_end;
 		con_start = log_end;		/* Flush */
-		spin_unlock(&logbuf_lock);
+		spin_unlock_irqrestore(&logbuf_lock, flags);
 		call_console_drivers(_con_start, _log_end);
-		local_irq_restore(flags);
 	}
 	console_locked = 0;
 	console_may_schedule = 0;

--------------010103010407070000080505--
