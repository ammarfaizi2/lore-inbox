Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266953AbTBLE7c>; Tue, 11 Feb 2003 23:59:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266955AbTBLE7c>; Tue, 11 Feb 2003 23:59:32 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:60604 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S266953AbTBLE7a>;
	Tue, 11 Feb 2003 23:59:30 -0500
Date: Wed, 12 Feb 2003 16:09:05 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Linus <torvalds@transmeta.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Andi Kleen <ak@muc.de>
Subject: [PATCH][COMPAT] compat_sys_futex 7/7 x86_64
Message-Id: <20030212160905.7514b848.sfr@canb.auug.org.au>
In-Reply-To: <20030212154716.7c101942.sfr@canb.auug.org.au>
References: <20030212154716.7c101942.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

As per Andi's wishes, here is the x86_64 part of the patch.  This one will
only apply after applying my previous patch "[PATCH][COMPAT] outstanding
compatibility changes 4/4 x86_64".

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.5.60-32bit.1/arch/x86_64/ia32/ia32entry.S 2.5.60-32bit.2/arch/x86_64/ia32/ia32entry.S
--- 2.5.60-32bit.1/arch/x86_64/ia32/ia32entry.S	2003-02-11 12:21:29.000000000 +1100
+++ 2.5.60-32bit.2/arch/x86_64/ia32/ia32entry.S	2003-02-11 12:21:56.000000000 +1100
@@ -440,7 +440,7 @@
 	.quad sys_fremovexattr
 	.quad sys_tkill		/* 238 */ 
 	.quad sys_sendfile64 
-	.quad sys32_futex		/* 240 */
+	.quad compay_sys_futex		/* 240 */
         .quad sys32_sched_setaffinity
         .quad sys32_sched_getaffinity
 	.quad sys_set_thread_area
diff -ruN 2.5.60-32bit.1/arch/x86_64/ia32/sys_ia32.c 2.5.60-32bit.2/arch/x86_64/ia32/sys_ia32.c
--- 2.5.60-32bit.1/arch/x86_64/ia32/sys_ia32.c	2003-02-11 12:21:29.000000000 +1100
+++ 2.5.60-32bit.2/arch/x86_64/ia32/sys_ia32.c	2003-02-11 12:21:56.000000000 +1100
@@ -2199,26 +2199,6 @@
 	return err;
 }
 
-extern int sys_futex(unsigned long uaddr, int op, int val, struct timespec *t); 
-
-asmlinkage long
-sys32_futex(unsigned long uaddr, int op, int val, struct compat_timespec *utime32)
-{
-	struct timespec t;
-	mm_segment_t oldfs = get_fs(); 
-	int err;
-
-	if (utime32 && get_compat_timespec(&t, utime32))
-		return -EFAULT;
-
-	/* the set_fs is safe because futex doesn't use the seg limit 
-	   for valid page checking of uaddr. */ 
-	set_fs(KERNEL_DS); 
-	err = sys_futex(uaddr, op, val, utime32 ? &t : NULL);
-	set_fs(oldfs); 
-	return err; 
-}
-
 extern long sys_io_setup(unsigned nr_reqs, aio_context_t *ctx);
 
 long sys32_io_setup(unsigned nr_reqs, u32 *ctx32p)
