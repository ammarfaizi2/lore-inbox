Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268734AbUJUOSx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268734AbUJUOSx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 10:18:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270683AbUJUOSr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 10:18:47 -0400
Received: from mx2.elte.hu ([157.181.151.9]:8403 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S268734AbUJUOQa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 10:16:30 -0400
Date: Thu, 21 Oct 2004 16:14:39 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Mark_H_Johnson@raytheon.com
Cc: Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       "K.R. Foley" <kr@cybsft.com>, linux-kernel@vger.kernel.org,
       Florian Schmidt <mista.tapas@gmx.net>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-rc4-mm1-U8
Message-ID: <20041021141439.GB2875@elte.hu>
References: <OF7C037699.07E90948-ON86256F34.0047151D@raytheon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF7C037699.07E90948-ON86256F34.0047151D@raytheon.com>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-2.201, required 5.9,
	BAYES_00 -4.90, SORTED_RECIPS 2.70
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Mark_H_Johnson@raytheon.com <Mark_H_Johnson@raytheon.com> wrote:

> I was about to run my normal stress tests when the system locked up.
> 
> The symptom was the display stopped updating / no mouse motion.
> Apparently caused while I was dragging a window with the mouse (USB).
> We may still have problems in that area. No apparent response to
> Alt-Sysrq keys; hardware reset was sufficient to reboot.

the soundcard IRQ trace you got is interesting:

 BUG: sleeping function called from invalid context X(2948) at kernel/mutex.c:25 Oct 21 07:53:02 localhost kernel: in_atomic():1 [00010000], irqs_disabled():0
  [<c011f06a>] __might_sleep+0xca/0xe0 (12)
  [<c01387e6>] _mutex_lock+0x26/0x50 (36)
  [<e0a549b6>] snd_audiopci_interrupt+0x46/0xf0 [snd_ens1371] (20)
  [<c01436f6>] handle_IRQ_event+0x46/0x80 (24)
  [<c0143837>] __do_IRQ+0x107/0x160 (32)
  [<c010a299>] do_IRQ+0x59/0x90 (36)
  [<c0108510>] common_interrupt+0x18/0x20 (20)
 preempt count: 00010001

do you have PREEMPT_REALTIME enabled? The above trace is a direct
interrupt - only the timer interrupt is allowed to execute directly in
the PREEMPT_REALTIME model - things break badly if it happens for any
other interrupt (such as the soundcard IRQ).

	Ingo
