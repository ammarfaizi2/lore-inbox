Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266004AbUHAPCa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266004AbUHAPCa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Aug 2004 11:02:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266006AbUHAPC3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Aug 2004 11:02:29 -0400
Received: from mail-relay-3.tiscali.it ([213.205.33.43]:57757 "EHLO
	mail-relay-3.tiscali.it") by vger.kernel.org with ESMTP
	id S266004AbUHAPCO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Aug 2004 11:02:14 -0400
Date: Sun, 1 Aug 2004 17:01:19 +0200
From: Andrea Arcangeli <andrea@cpushare.com>
To: chris@scary.beasts.org
Cc: Hans Reiser <reiser@namesys.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: secure computing for 2.6.7
Message-ID: <20040801150119.GE6295@dualathlon.random>
References: <20040704173903.GE7281@dualathlon.random> <40EC4E96.9090800@namesys.com> <20040801102231.GB6295@dualathlon.random> <Pine.LNX.4.58.0408011248040.1368@sphinx.mythic-beasts.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0408011248040.1368@sphinx.mythic-beasts.com>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 01, 2004 at 01:01:10PM +0100, chris@scary.beasts.org wrote:
> Hi Andrea,
> 
> Do you have plans to generalize seccomp into somelike like a "syscall
> firewall"? This _would_ be useful to many apps, and provide good security
> benefits - for example, vsftpd does not need most of the previously-buggy
> syscalls such as sysctl(), mremap() and execve(). But it does need more
> than just read(), write() and exit()!

Seems like a few people is interested in what you suggest above. it'd be
very trivial to add a seccomp-mode = 2 that adds more syscalls like the
socket syscalls like accept/sendfile/send/recv and also the open syscall
(which means you want to use chroot still).  In the code you can see I
wrote it so that more modes can be added freely. I mean it has some
flexibility already.  vsftpd could enable the seccomp mode 2 on itself
after it has initialized.

(this is only a trivial patch example of the extension) 

--- security-sequence/kernel/seccomp.c.~1~	2004-08-01 16:10:46.970806680 +0200
+++ security-sequence/kernel/seccomp.c	2004-08-01 16:17:17.537431528 +0200
@@ -30,12 +30,31 @@ static int mode1_syscalls[] = {
 #endif
 };
 
+/*
+ * Secure computing mode 2 is for network daemons.
+ */
+static int mode2_syscalls[] = {
+#ifdef __NR_sigreturn
+	__NR_rt_sigreturn,
+#endif
+	__NR_open, __NR_sendfile, __NR_sendfile64, __NR_close,
+	__NR_poll, __NR_fork, __NR_wait4, __NR_socketcall, __NR_getdents,
+	__NR_mmap2, __NR_munmap,
+};
+
 void secure_computing(int this_syscall)
 {
 	int mode = current->seccomp_mode;
 	int * syscall;
 
 	switch (mode) {
+	case 2:
+		for (syscall = mode2_syscalls;
+		     syscall < mode2_syscalls + sizeof(mode2_syscalls)/sizeof(int);
+		     syscall++)
+			if (*syscall == this_syscall)
+				return;
+		/* mode 2 extends mode 1: fallthrough */
 	case 1:
 		for (syscall = mode1_syscalls;
 		     syscall < mode1_syscalls + sizeof(mode1_syscalls)/sizeof(int);


the above might be enough to make a network daemon work, but it probably
would still need some userspace modification to ensure it fits, and you
may have to add some reasonably safe syscall that I might have forgotten
in the example.

plus you'd still need a chroot to limit the scope of the "open" syscall.

to make threading work futex and clone and some other is going to be
needed by glibc.

After that it would be _very_ secure thanks to the seccomp mode 2.
Especially the fact they've no way to exec is quite nice since they
always try to find the /bin/sh string somewhere to make the thing work.

I can imagine some people may want a true firewall configurable via
userspace, so that they can filter the syscall parameters too and they
can customize it as they need. the seccomp patch conceptually fits that
need just fine too but you've to write the code and extended it for that ;).
That would be seccomp mode >=3.

I'm posting these emails so much in advance just to raise discussion of
what people would like to see implemented so that it benefits everybody
so any extension is welcome.  OTOH while I will certainly help auditing
any extension of the seccomp mode I'm probably not going to have spare
resources to spend in writing that fully featured syscalltables firewall
mode >=3 that some people would like to see. I hope somebody else will
volounteer for that if there's an agreement that's the way to go ;). The
basic seccomp infrastructure/entry-point is there to build it. The
syscall parameters can be trivially passed down by adding a few more
params to the secure_computing function.

The important thing is to verify the API is extendible and I think it
is. The way this could work is to merge the patch as-is and to later add
a seccomp-mode == 2 for relaxed network daemon usage, and to later make
all seccomp modes from 3 to max-int to be configurable with a firewall
ala iptables when somebody volounteers to implement that. I really like
keeping mode 1 static and dumb (that is a feature), this way I'll never
risk somebody to mess the syscalltables firewall and to create an hole
in its own machine, and most important I would never need to depend on
the code in "case 3:" to be safe, since that is going to be a lot more
complicated and in turn less secure than the "case 1:" code.
