Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267481AbTCESog>; Wed, 5 Mar 2003 13:44:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267482AbTCESog>; Wed, 5 Mar 2003 13:44:36 -0500
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:59354
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id <S267481AbTCESoe>; Wed, 5 Mar 2003 13:44:34 -0500
Message-ID: <3E664836.7040405@redhat.com>
Date: Wed, 05 Mar 2003 10:55:50 -0800
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4a) Gecko/20030303
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Better CLONE_SETTLS support for Hammer
X-Enigmail-Version: 0.73.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Andi,

Please consider using this patch which changes the way CLONE_SETTLS is
handled on Hammer completely.  The old approach was to slavishly follow
what x86 does with the desastrous result that TCBs (and therefore
stacks) could only be allocated in the low 4GB.  This would have been a
really bad limitation going forward.

But as it turns out the kernel already has support for handling %fs in a
different way, to support prctl(ARCH_SET_FS).  So let's just use the
same mechanism.  clone() will simply take an 64-bit address and use it
as if prctl() was called.

The changes are pretty minimal.  The appened patch is relative to the
current BK sources and they also incorporate the bug fix to use the
correct register for the SETTLS clone() parameter.


- --- arch/x86_64/kernel/process.c	2003-02-23 22:02:23.000000000 -0800
+++ arch/x86_64/kernel/process.c-new	2003-03-05 10:14:46.000000000 -0800
@@ -269,11 +269,18 @@

 	p->thread.rip = (unsigned long) ret_from_fork;

- -	p->thread.fs = me->thread.fs;
+	if ((clone_flags & CLONE_SETTLS) && !test_thread_flag(TIF_IA32)) {
+		if (regs->r8 >= TASK_SIZE)
+			return -EPERM;
+		p->thread.fs = regs->r8;
+		p->thread.fsindex = 0;
+	} else {
+		p->thread.fs = me->thread.fs;
+		asm("movl %%fs,%0" : "=m" (p->thread.fsindex));
+	}
 	p->thread.gs = me->thread.gs;

 	asm("movl %%gs,%0" : "=m" (p->thread.gsindex));
- -	asm("movl %%fs,%0" : "=m" (p->thread.fsindex));
 	asm("movl %%es,%0" : "=m" (p->thread.es));
 	asm("movl %%ds,%0" : "=m" (p->thread.ds));

@@ -291,14 +298,12 @@
 	/*
 	 * Set a new TLS for the child thread?
 	 */
- -	if (clone_flags & CLONE_SETTLS) {
+	if ((clone_flags & CLONE_SETTLS) && test_thread_flag(TIF_IA32)) {
 		struct n_desc_struct *desc;
 		struct user_desc info;
 		int idx;

- -		if (copy_from_user(&info, test_thread_flag(TIF_IA32) ?
- -								  (void *)childregs->rsi :
- -								  (void *)childregs->rdx, sizeof(info)))
+		if (copy_from_user(&info, (void *)childregs->rsi))
 			return -EFAULT;
 		if (LDT_empty(&info))
 			return -EINVAL;


- -- 
- --------------.                        ,-.            444 Castro Street
Ulrich Drepper \    ,-----------------'   \ Mountain View, CA 94041 USA
Red Hat         `--' drepper at redhat.com `---------------------------
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+Zkg32ijCOnn/RHQRAr9cAKDL+9bmX26v4P6GRpAq11kzUrgDOwCdFcrk
RO3CMzlLQrEpO28itl0JdxM=
=YxTu
-----END PGP SIGNATURE-----

