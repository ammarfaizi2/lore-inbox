Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263430AbRFFApG>; Tue, 5 Jun 2001 20:45:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263431AbRFFAo4>; Tue, 5 Jun 2001 20:44:56 -0400
Received: from pop1.netcis.com ([199.227.10.105]:12160 "HELO pop1.netcis.com")
	by vger.kernel.org with SMTP id <S263430AbRFFAoh>;
	Tue, 5 Jun 2001 20:44:37 -0400
Date: Tue, 5 Jun 2001 20:44:42 -0400 (EDT)
From: Adam Slattery <aslattery@sunriselinux.com>
To: linux-kernel@vger.kernel.org
Subject: SysRq bug for tErm and kIll with init
Message-ID: <Pine.LNX.4.10.10106051957520.1954-100000@pop1.netcis.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Good evening,

The problem is annoying, the fix is trivial.
I am not subscribed to the list, so PLEASE CC ME when replying.


Summary:

Magic SysRq behaves improperly with tErm and kIll in regards to how it
deals with init. killalL is fine (ignoring the 0x8000 "Ugly hack" :)


Description:

When you use these features of SysRq, the kernel is supposed to send a
signal to all processes except init.  Well in reality the kernel sends a
signal to "all" processes including init.  The reason nobody has ever
noticed this is that sysvinit doesn't do anything on SIGTERM, and the
kernel won't kill pid 1.


Affected kernels:

All current. This is present in both 2.2.19 and 2.4.6-pre1 kernels. I
didn't check 2.0.x, but i believe 2.0.x lacked the magic sysrq hack
anyway.

   $Id: sysrq.c,v 1.15 1998/08/23 14:56:41 mj Exp $




Solution:


drivers/char/sysrq.c
send_sig_all()
line 47 in 2.4.6-pre1

// -- Evil code --
for_each_task(p) {
  if (p->mm) {              /* Not swapper nor kernel thread */
    if (p->pid == 1 && even_init)           /* Ugly hack to kill init */
        p->pid = 0x8000;
    force_sig(sig, p);
  }
}
// --end--


So what happens is if send_sig_all is supposed to kill init then p->pid is
set to 0x8000.  This is bad, but it works fine so who really cares.  Now,
if even_init is 0 (like with tErm and kIll), p->pid is still 1 when
force_sig() is called.  If p->pid is 1 and even_init is 0, nothing should
be done.


// -- Fixed code --
for_each_task(p) {
  if (p->mm) {            /* Not swapper nor kernel thread */
    if (p->pid == 1 && even_init)        /* Ugly hack to kill init */
        p->pid = 0x8000;
    if (p->pid != 1)
        force_sig(sig, p);
  }
}
// --end--

Amazing what 1 line of code fixes, isn't it?




How the problem was found:

The busybox (busybox.lineo.com) init reboots when it sees SIGTERM :).



Since this is a 1 line fix I'd like to see it go into the kernel soon,
maybe even for the 2.4.6-pre2 kernel. I don't want to sound
like a jerk, but it would be cool if I was listed at the top of
sysrq.c for submitting a bugfix or something =].

Remember to cc me when replying.

Thanks,
Adam Slattery
Sunrise Linux Development Team
aslattery@sunriselinux.com


