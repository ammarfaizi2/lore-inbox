Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751269AbVJUX0j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751269AbVJUX0j (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 19:26:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751272AbVJUX0j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 19:26:39 -0400
Received: from smtp2.Stanford.EDU ([171.67.16.125]:64445 "EHLO
	smtp2.Stanford.EDU") by vger.kernel.org with ESMTP id S1751269AbVJUX0i
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 19:26:38 -0400
Subject: Re: 2.6.14-rc4-rt7
From: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
To: Ingo Molnar <mingo@elte.hu>
Cc: nando@ccrma.Stanford.EDU, William Weston <weston@lysdexia.org>,
       cc@ccrma.Stanford.EDU, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>,
       david singleton <dsingleton@mvista.com>,
       Steven Rostedt <rostedt@goodmis.org>, Rui Nuno Capela <rncbc@rncbc.org>,
       Mark Knecht <markknecht@gmail.com>
In-Reply-To: <20051021080504.GA5088@elte.hu>
References: <20051017160536.GA2107@elte.hu>
	 <1129576885.4720.3.camel@cmn3.stanford.edu>
	 <1129599029.10429.1.camel@cmn3.stanford.edu>
	 <20051018072844.GB21915@elte.hu>
	 <1129669474.5929.8.camel@cmn3.stanford.edu>
	 <Pine.LNX.4.58.0510181423200.19498@echo.lysdexia.org>
	 <20051019111943.GA31410@elte.hu>
	 <1129835571.14374.11.camel@cmn3.stanford.edu>
	 <20051020191620.GA21367@elte.hu>
	 <1129852531.5227.4.camel@cmn3.stanford.edu> <20051021080504.GA5088@elte.hu>
Content-Type: text/plain
Date: Fri, 21 Oct 2005 16:25:38 -0700
Message-Id: <1129937138.5001.4.camel@cmn3.stanford.edu>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-10-21 at 10:05 +0200, Ingo Molnar wrote:
> * Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU> wrote:
> 
> > Found this on the logs:
> > 
> > Oct 20 15:52:57 cmn3 kernel: BUG in hydrogen:4810, ktimer expired 
> > short without user signal!:
> 
> hm. This suggests that hydrogen executing schedule_ktimer() was waken up 
> 45 microseconds too early, and most likely it was not woken up by the 
> hres timer code (which should have done the wakeup 45 microseconds later 
> anyway).
> 
> I've added special hres-wakeup-debugging code to the scheduler in 
> -rc5-rt2 to catch this particular scenario, you might want to give it a 
> try. The new code is always enabled and it should pinpoint the precise 
> place that does the wrong wakeup. You should see a new type of warning 
> in your log:
> 
>  BUG: foo:1234 waking up bar:4321, expiring ktimer short without user signal!
> 
> in shortly before the usual "BUG: ktimer expired short" message. Both 
> messages will be triggered only once per bootup - but the condition 
> itself likely occurs much more often on your box.

Here's one with rc5-rt3:

Oct 21 15:01:46 cmn3 kernel: BUG: ktimer expired short without user
signal! (hald-addon-stor:4309)
Oct 21 15:01:46 cmn3 kernel: .. expires:   1012/751245500
Oct 21 15:01:46 cmn3 kernel: .. expired:   1012/750908115
Oct 21 15:01:46 cmn3 kernel: .. at line:   942
Oct 21 15:01:46 cmn3 kernel: .. interval:  0/0
Oct 21 15:01:46 cmn3 kernel: .. now:       1012/750908723
Oct 21 15:01:46 cmn3 kernel: .. rem:       0/337385
Oct 21 15:01:46 cmn3 kernel: .. overrun:   0
Oct 21 15:01:46 cmn3 kernel: .. getoffset: 00000000
Oct 21 15:01:46 cmn3 kernel:  [<c014205d>] check_ktimer_signal
+0x16d/0x190 (8)
Oct 21 15:01:46 cmn3 kernel:  [<c0142129>] __ktimer_nanosleep+0xa9/0xf0
(56)
Oct 21 15:01:46 cmn3 kernel:  [<c01421ab>] ktimer_nanosleep+0x3b/0x50
(56)
Oct 21 15:01:46 cmn3 kernel:  [<c0375d20>] nanosleep_restart_mono
+0x0/0x30 (8)
Oct 21 15:01:46 cmn3 kernel:  [<c0141ee0>] ktimer_wake_up+0x0/0x10 (64)
Oct 21 15:01:46 cmn3 kernel:  [<c014225c>] sys_nanosleep+0x4c/0x50 (32)
Oct 21 15:01:46 cmn3 kernel:  [<c0103481>] syscall_call+0x7/0xb (16)

And another (the same?) after a reboot:

Oct 21 16:06:11 cmn3 kernel: BUG: ktimer expired short without user
signal! (udev:317)
Oct 21 16:06:11 cmn3 kernel: .. expires:   9/24925742
Oct 21 16:06:11 cmn3 kernel: .. expired:   9/24924523
Oct 21 16:06:11 cmn3 kernel: .. at line:   942
Oct 21 16:06:11 cmn3 kernel: .. interval:  0/0
Oct 21 16:06:11 cmn3 kernel: .. now:       9/24925385
Oct 21 16:06:11 cmn3 kernel: .. rem:       0/1219
Oct 21 16:06:11 cmn3 kernel: .. overrun:   0
Oct 21 16:06:11 cmn3 kernel: .. getoffset: 00000000
Oct 21 16:06:11 cmn3 kernel:  [<c014205d>] check_ktimer_signal
+0x16d/0x190 (8)
Oct 21 16:06:11 cmn3 kernel:  [<c0142129>] __ktimer_nanosleep+0xa9/0xf0
(56)
Oct 21 16:06:11 cmn3 kernel:  [<c01421ab>] ktimer_nanosleep+0x3b/0x50
(56)
Oct 21 16:06:11 cmn3 kernel:  [<c0375d20>] nanosleep_restart_mono
+0x0/0x30 (8)
Oct 21 16:06:11 cmn3 kernel:  [<c0141ee0>] ktimer_wake_up+0x0/0x10 (64)
Oct 21 16:06:11 cmn3 kernel:  [<c014225c>] sys_nanosleep+0x4c/0x50 (32)
Oct 21 16:06:11 cmn3 kernel:  [<c0103481>] syscall_call+0x7/0xb (16)

In both cases the machine goes catatonic, I don't know if right after
this or not. It responds to the SysRQ key but that's pretty much it, I
should probably try to get a serial console going somehow. 

-- Fernando


