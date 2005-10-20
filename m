Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932161AbVJTTNv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932161AbVJTTNv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Oct 2005 15:13:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932175AbVJTTNv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Oct 2005 15:13:51 -0400
Received: from smtp3.Stanford.EDU ([171.67.16.138]:38278 "EHLO
	smtp3.Stanford.EDU") by vger.kernel.org with ESMTP id S932161AbVJTTNu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Oct 2005 15:13:50 -0400
Subject: Re: 2.6.14-rc4-rt7
From: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
To: Ingo Molnar <mingo@elte.hu>
Cc: nando@ccrma.Stanford.EDU, William Weston <weston@lysdexia.org>,
       cc@ccrma.Stanford.EDU, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>,
       david singleton <dsingleton@mvista.com>,
       Steven Rostedt <rostedt@goodmis.org>, Rui Nuno Capela <rncbc@rncbc.org>,
       Mark Knecht <markknecht@gmail.com>
In-Reply-To: <20051019111943.GA31410@elte.hu>
References: <20051017160536.GA2107@elte.hu>
	 <1129576885.4720.3.camel@cmn3.stanford.edu>
	 <1129599029.10429.1.camel@cmn3.stanford.edu>
	 <20051018072844.GB21915@elte.hu>
	 <1129669474.5929.8.camel@cmn3.stanford.edu>
	 <Pine.LNX.4.58.0510181423200.19498@echo.lysdexia.org>
	 <20051019111943.GA31410@elte.hu>
Content-Type: text/plain
Date: Thu, 20 Oct 2005 12:12:51 -0700
Message-Id: <1129835571.14374.11.camel@cmn3.stanford.edu>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-10-19 at 13:19 +0200, Ingo Molnar wrote:
> * William Weston <weston@lysdexia.org> wrote:
> 
> > Hello,
> > 
> > Getting up to speed on the latest -rt changes again.  Just happened to 
> > notice this warning with -rt8 and -rt9:
> > 
> > kernel/ktimers.c: In function `check_ktimer_signal': 
> > kernel/ktimers.c:1209: warning: passing argument 1 of 
> > `unlock_ktimer_base' from incompatible pointer type
> > 
> > And the obvious fix:
> > 
> > --- linux/kernel/ktimers.c.orig	2005-10-18 14:10:48.000000000 -0700
> > +++ linux/kernel/ktimers.c	2005-10-18 14:24:43.000000000 -0700
> > @@ -1206,7 +1206,7 @@
> >  		struct ktimer_base *base = lock_ktimer_base(timer, &flags);
> >  		ktime_t now = base->get_time();
> >  
> > -		unlock_ktimer_base(base, &flags);
> > +		unlock_ktimer_base(timer, &flags);
> >  
> 
> indeed - and this could explain some of the lockups reported. I've 
> uploaded -rt10 with your fix included.

No lockups so far with -rt12 (running for 1/2 a day already). 

I'm getting BUG messages again, some examples below...
-- Fernando


expires:   63460/186377996
expired:   63459/262930743
      at:  857
interval:  0/0
now:       63459/262931265
rem:       0/923447253
overrun:   0
getoffset: 00000000
gpm/4215[CPU#1]: BUG in check_ktimer_signal at kernel/ktimers.c:1345
 [<c01280a7>] __WARN_ON+0x67/0x90 (8)
 [<c01421ba>] check_ktimer_signal+0x12a/0x140 (48)
 [<c0142279>] ktimer_nanosleep+0xa9/0xf0 (52)
 [<c01422fb>] ktimer_nanosleep_mono+0x3b/0x50 (56)
 [<c03751b0>] nanosleep_restart_mono+0x0/0x30 (8)
 [<c0142080>] process_ktimer+0x0/0x10 (64)
 [<c01423ac>] sys_nanosleep+0x4c/0x50 (32)
 [<c0103481>] syscall_call+0x7/0xb (16)
SELinux: initialized (dev 0:19, type nfs), uses genfs_contexts
SELinux: initialized (dev 0:19, type nfs), uses genfs_contexts

expires:   63652/92742733
expired:   63652/77934422
      at:  857
interval:  0/0
now:       63652/77934985
rem:       0/14808311
overrun:   0
getoffset: 00000000
hydrogen/14762[CPU#0]: BUG in check_ktimer_signal at
kernel/ktimers.c:1345
 [<c01280a7>] __WARN_ON+0x67/0x90 (8)
 [<c01421ba>] check_ktimer_signal+0x12a/0x140 (48)
 [<c0142279>] ktimer_nanosleep+0xa9/0xf0 (52)
 [<c01422fb>] ktimer_nanosleep_mono+0x3b/0x50 (56)
 [<c03751b0>] nanosleep_restart_mono+0x0/0x30 (8)
 [<c0142080>] process_ktimer+0x0/0x10 (64)
 [<c01423ac>] sys_nanosleep+0x4c/0x50 (32)
 [<c0103481>] syscall_call+0x7/0xb (16)

expires:   63730/580407432
expired:   63730/580219182
      at:  857
interval:  0/0
now:       63730/580220260
rem:       0/188250
overrun:   0
getoffset: 00000000
hald-addon-stor/4308[CPU#1]: BUG in check_ktimer_signal at
kernel/ktimers.c:1345 [<c01280a7>] __WARN_ON+0x67/0x90 (8)
 [<c01421ba>] check_ktimer_signal+0x12a/0x140 (48)
 [<c0142279>] ktimer_nanosleep+0xa9/0xf0 (52)
 [<c01422fb>] ktimer_nanosleep_mono+0x3b/0x50 (56)
 [<c03751b0>] nanosleep_restart_mono+0x0/0x30 (8)
 [<c0142080>] process_ktimer+0x0/0x10 (64)
 [<c01423ac>] sys_nanosleep+0x4c/0x50 (32)
 [<c0103481>] syscall_call+0x7/0xb (16)

expires:   63748/350884596
expired:   63748/259469299
      at:  857
interval:  0/0
now:       63748/259469761
rem:       0/91415297
overrun:   0
getoffset: 00000000
hydrogen/14762[CPU#0]: BUG in check_ktimer_signal at
kernel/ktimers.c:1345
 [<c01280a7>] __WARN_ON+0x67/0x90 (8)
 [<c01421ba>] check_ktimer_signal+0x12a/0x140 (48)
 [<c0142279>] ktimer_nanosleep+0xa9/0xf0 (52)
 [<c01422fb>] ktimer_nanosleep_mono+0x3b/0x50 (56)
 [<c03751b0>] nanosleep_restart_mono+0x0/0x30 (8)
 [<c0142080>] process_ktimer+0x0/0x10 (64)
 [<c01423ac>] sys_nanosleep+0x4c/0x50 (32)
 [<c0103481>] syscall_call+0x7/0xb (16)

expires:   63749/750924523
expired:   63748/261658939
      at:  857
interval:  0/0
now:       63748/261660137
rem:       1/489265584
overrun:   0
getoffset: 00000000
gpm/4215[CPU#1]: BUG in check_ktimer_signal at kernel/ktimers.c:1345
 [<c01280a7>] __WARN_ON+0x67/0x90 (8)
 [<c01421ba>] check_ktimer_signal+0x12a/0x140 (48)
 [<c0142279>] ktimer_nanosleep+0xa9/0xf0 (52)
 [<c01422fb>] ktimer_nanosleep_mono+0x3b/0x50 (56)
 [<c03751b0>] nanosleep_restart_mono+0x0/0x30 (8)
 [<c0142080>] process_ktimer+0x0/0x10 (64)
 [<c01423ac>] sys_nanosleep+0x4c/0x50 (32)
 [<c0103481>] syscall_call+0x7/0xb (16)

expires:   63759/124237114
expired:   63759/123513573
      at:  857
interval:  0/0
now:       63759/123514487
rem:       0/723541
overrun:   0
getoffset: 00000000
hald-addon-stor/4308[CPU#1]: BUG in check_ktimer_signal at
kernel/ktimers.c:1345 [<c01280a7>] __WARN_ON+0x67/0x90 (8)
 [<c01421ba>] check_ktimer_signal+0x12a/0x140 (48)
 [<c0142279>] ktimer_nanosleep+0xa9/0xf0 (52)
 [<c01422fb>] ktimer_nanosleep_mono+0x3b/0x50 (56)
 [<c03751b0>] nanosleep_restart_mono+0x0/0x30 (8)
 [<c0142080>] process_ktimer+0x0/0x10 (64)
 [<c01423ac>] sys_nanosleep+0x4c/0x50 (32)
 [<c0103481>] syscall_call+0x7/0xb (16)

expires:   63759/779202647
expired:   63759/778470948
      at:  857
interval:  0/0
now:       63759/778471567
rem:       0/731699
overrun:   0
getoffset: 00000000
hydrogen/14762[CPU#1]: BUG in check_ktimer_signal at
kernel/ktimers.c:1345
 [<c01280a7>] __WARN_ON+0x67/0x90 (8)
 [<c01421ba>] check_ktimer_signal+0x12a/0x140 (48)
 [<c0142279>] ktimer_nanosleep+0xa9/0xf0 (52)
 [<c01422fb>] ktimer_nanosleep_mono+0x3b/0x50 (56)
 [<c03751b0>] nanosleep_restart_mono+0x0/0x30 (8)
 [<c0142080>] process_ktimer+0x0/0x10 (64)
 [<c01423ac>] sys_nanosleep+0x4c/0x50 (32)
 [<c0103481>] syscall_call+0x7/0xb (16)

expires:   63764/938411799
expired:   63764/937703455
      at:  857
interval:  0/0
now:       63764/937704138
rem:       0/708344
overrun:   0
getoffset: 00000000
ypbind/3729[CPU#1]: BUG in check_ktimer_signal at kernel/ktimers.c:1345
 [<c01280a7>] __WARN_ON+0x67/0x90 (8)
 [<c01421ba>] check_ktimer_signal+0x12a/0x140 (48)
 [<c0142279>] ktimer_nanosleep+0xa9/0xf0 (52)
 [<c01422fb>] ktimer_nanosleep_mono+0x3b/0x50 (56)
 [<c03751b0>] nanosleep_restart_mono+0x0/0x30 (8)
 [<c0142080>] process_ktimer+0x0/0x10 (64)
 [<c01423ac>] sys_nanosleep+0x4c/0x50 (32)
 [<c0103481>] syscall_call+0x7/0xb (16)
SELinux: initialized (dev 0:19, type nfs), uses genfs_contexts

expires:   63779/216066094
expired:   63779/215384514
      at:  857
interval:  0/0
now:       63779/215385152
rem:       0/681580
overrun:   0
getoffset: 00000000
hydrogen/14762[CPU#1]: BUG in check_ktimer_signal at
kernel/ktimers.c:1345
 [<c01280a7>] __WARN_ON+0x67/0x90 (8)
 [<c01421ba>] check_ktimer_signal+0x12a/0x140 (48)
 [<c0142279>] ktimer_nanosleep+0xa9/0xf0 (52)
 [<c01422fb>] ktimer_nanosleep_mono+0x3b/0x50 (56)
 [<c03751b0>] nanosleep_restart_mono+0x0/0x30 (8)
 [<c0142080>] process_ktimer+0x0/0x10 (64)
 [<c01423ac>] sys_nanosleep+0x4c/0x50 (32)
 [<c0103481>] syscall_call+0x7/0xb (16)
SELinux: initialized (dev 0:19, type nfs), uses genfs_contexts


