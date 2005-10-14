Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750845AbVJNSfz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750845AbVJNSfz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Oct 2005 14:35:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750846AbVJNSfz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Oct 2005 14:35:55 -0400
Received: from smtp2.Stanford.EDU ([171.67.16.125]:4525 "EHLO
	smtp2.Stanford.EDU") by vger.kernel.org with ESMTP id S1750842AbVJNSfy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Oct 2005 14:35:54 -0400
Subject: Re: 2.6.14-rc4-rt1
From: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       Steven Rostedt <rostedt@goodmis.org>, dwalker@mvista.com,
       david singleton <dsingleton@mvista.com>
In-Reply-To: <1129312907.19449.13.camel@cmn3.stanford.edu>
References: <20051011111454.GA15504@elte.hu>
	 <1129064151.5324.6.camel@cmn3.stanford.edu>
	 <20051012061455.GA16586@elte.hu> <20051012071037.GA19018@elte.hu>
	 <1129242595.4623.14.camel@cmn3.stanford.edu>
	 <1129256936.11036.4.camel@cmn3.stanford.edu>
	 <20051014045615.GC13595@elte.hu>  <20051014061546.GA30319@elte.hu>
	 <1129312907.19449.13.camel@cmn3.stanford.edu>
Content-Type: text/plain
Date: Fri, 14 Oct 2005 11:35:39 -0700
Message-Id: <1129314939.4652.4.camel@cmn3.stanford.edu>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-10-14 at 11:01 -0700, Fernando Lopez-Lezcano wrote:
> On Fri, 2005-10-14 at 08:15 +0200, Ingo Molnar wrote:
> > * Ingo Molnar <mingo@elte.hu> wrote:
> > 
> > > could you try:
> > > 
> > > 	strace -o log sleep 10
> > > 
> > > and wait for a failure, and send us the log? Is it perhaps nanosleep 
> > > unexpectedly returning with -EAGAIN or -512? There's a transient 
> > > nanosleep failure that happens on really fast boxes, which we havent 
> > > gotten to the bottom yet. That problem is very sporadic, but maybe 
> > > your box is just too fast and triggers it more likely :-)
> > 
> > is nanosleep returning -ERESTART_RESTARTBLOCK (-516) perhaps?
> 
> Yes, that is probably correct, I saw a few of these:
>   sleep: cannot read realtime clock: Unknown error 516
> 
> I'm building rt5 and will report later. 

Sorry, still getting the same behavior from rt5 (including 516 errors).
I'm getting something out of rt5's debugging code, some examples follow:

crond/4144[CPU#1]: BUG in check_ktimer_signal at kernel/ktimers.c:1117
 [<c0128277>] __WARN_ON+0x67/0x90 (8)
 [<c01416e7>] check_ktimer_signal+0x127/0x130 (48)
 [<c01417a1>] ktimer_nanosleep+0xb1/0xf0 (52)
 [<c014181b>] ktimer_nanosleep_mono+0x3b/0x50 (60)
 [<c0374f60>] nanosleep_restart_mono+0x0/0x30 (8)
 [<c01415b0>] process_ktimer+0x0/0x10 (60)
 [<c01418cc>] sys_nanosleep+0x4c/0x50 (36)
 [<c0103481>] syscall_call+0x7/0xb (16)


expires:   1736/464432941
expired:   1721/862640520
      at:  657
interval:  0/0
now:       1721/862641188
rem:       14/601792421
overrun:   0
getoffset: 00000000
crond/4144[CPU#1]: BUG in check_ktimer_signal at kernel/ktimers.c:1117
 [<c0128277>] __WARN_ON+0x67/0x90 (8)
 [<c01416e7>] check_ktimer_signal+0x127/0x130 (48)
 [<c01417a1>] ktimer_nanosleep+0xb1/0xf0 (52)
 [<c014181b>] ktimer_nanosleep_mono+0x3b/0x50 (60)
 [<c0374f60>] nanosleep_restart_mono+0x0/0x30 (8)
 [<c01415b0>] process_ktimer+0x0/0x10 (60)
 [<c01418cc>] sys_nanosleep+0x4c/0x50 (36)
 [<c0103481>] syscall_call+0x7/0xb (16)

expires:   6116/908892557
expired:   1721/862993769
      at:  657
interval:  0/0
now:       1721/862994253
rem:       4395/45898788
overrun:   0
getoffset: 00000000
gpm/4136[CPU#1]: BUG in check_ktimer_signal at kernel/ktimers.c:1117
 [<c0128277>] __WARN_ON+0x67/0x90 (8)
 [<c01416e7>] check_ktimer_signal+0x127/0x130 (48)
 [<c01417a1>] ktimer_nanosleep+0xb1/0xf0 (52)
 [<c014181b>] ktimer_nanosleep_mono+0x3b/0x50 (60)
 [<c0374f60>] nanosleep_restart_mono+0x0/0x30 (8)
 [<c01415b0>] process_ktimer+0x0/0x10 (60)
 [<c01418cc>] sys_nanosleep+0x4c/0x50 (36)
 [<c0103481>] syscall_call+0x7/0xb (16)
expires:   1730/917836219
expired:   1721/862633260
      at:  657
interval:  0/0
now:       1721/862633539
rem:       9/55202959
overrun:   0
getoffset: 00000000
sleep/5299[CPU#1]: BUG in check_ktimer_signal at kernel/ktimers.c:1117
 [<c0128277>] __WARN_ON+0x67/0x90 (8)
 [<c01416e7>] check_ktimer_signal+0x127/0x130 (48)
 [<c01417a1>] ktimer_nanosleep+0xb1/0xf0 (52)
 [<c014181b>] ktimer_nanosleep_mono+0x3b/0x50 (60)
 [<c0374f60>] nanosleep_restart_mono+0x0/0x30 (8)
 [<c01415b0>] process_ktimer+0x0/0x10 (60)
 [<c01418cc>] sys_nanosleep+0x4c/0x50 (36)
 [<c0103481>] syscall_call+0x7/0xb (16)

expires:   1739/273286972
expired:   1739/272964651
      at:  657
interval:  0/0
now:       1739/272965670
rem:       0/322321
overrun:   0
getoffset: 00000000
hald-addon-stor/4229[CPU#1]: BUG in check_ktimer_signal at
kernel/ktimers.c:1117 [<c0128277>] __WARN_ON+0x67/0x90 (8)
 [<c01416e7>] check_ktimer_signal+0x127/0x130 (48)
 [<c01417a1>] ktimer_nanosleep+0xb1/0xf0 (52)
 [<c014181b>] ktimer_nanosleep_mono+0x3b/0x50 (60)
 [<c0374f60>] nanosleep_restart_mono+0x0/0x30 (8)
 [<c01415b0>] process_ktimer+0x0/0x10 (60)
 [<c01418cc>] sys_nanosleep+0x4c/0x50 (36)
 [<c0103481>] syscall_call+0x7/0xb (16)

expires:   1751/956279550
expired:   1751/955896702
      at:  657
interval:  0/0
now:       1751/955897242
rem:       0/382848
overrun:   0
getoffset: 00000000
sleep/5321[CPU#1]: BUG in check_ktimer_signal at kernel/ktimers.c:1117
 [<c0128277>] __WARN_ON+0x67/0x90 (8)
 [<c01416e7>] check_ktimer_signal+0x127/0x130 (48)
 [<c01417a1>] ktimer_nanosleep+0xb1/0xf0 (52)
 [<c014181b>] ktimer_nanosleep_mono+0x3b/0x50 (60)
 [<c0374f60>] nanosleep_restart_mono+0x0/0x30 (8)
 [<c01415b0>] process_ktimer+0x0/0x10 (60)
 [<c01418cc>] sys_nanosleep+0x4c/0x50 (36)
 [<c0103481>] syscall_call+0x7/0xb (16)

expires:   1753/316840062
expired:   1753/316460409
      at:  657
interval:  0/0
now:       1753/316461329
rem:       0/379653
overrun:   0
getoffset: 00000000
hald-addon-stor/4229[CPU#1]: BUG in check_ktimer_signal at
kernel/ktimers.c:1117 [<c0128277>] __WARN_ON+0x67/0x90 (8)
 [<c01416e7>] check_ktimer_signal+0x127/0x130 (48)
 [<c01417a1>] ktimer_nanosleep+0xb1/0xf0 (52)
 [<c014181b>] ktimer_nanosleep_mono+0x3b/0x50 (60)
 [<c0374f60>] nanosleep_restart_mono+0x0/0x30 (8)
 [<c01415b0>] process_ktimer+0x0/0x10 (60)
 [<c01418cc>] sys_nanosleep+0x4c/0x50 (36)
 [<c0103481>] syscall_call+0x7/0xb (16)

-- Fernando


