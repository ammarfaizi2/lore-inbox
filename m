Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S155304AbPIEB5c>; Sat, 4 Sep 1999 21:57:32 -0400
Received: by vger.rutgers.edu id <S155090AbPIEB5W>; Sat, 4 Sep 1999 21:57:22 -0400
Received: from false.com ([198.65.171.171]:20586 "EHLO mystic.false.com") by vger.rutgers.edu with ESMTP id <S154991AbPIEB5I>; Sat, 4 Sep 1999 21:57:08 -0400
From: Solar Designer <solar@false.com>
Message-Id: <199909050153.FAA01843@false.com>
Subject: Re: 2.2.12 & strnlen_user()
In-Reply-To: <E11MEyo-0003RR-00@the-village.bc.nu> from Alan Cox at "Sep 1, 99 07:19:29 pm"
To: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Sun, 5 Sep 1999 05:53:51 +0400 (MSD)
Cc: security-audit@ferret.lmh.ox.ac.uk, linux-kernel@vger.rutgers.edu
X-Mailer: ELM [version 2.4ME+ PL31 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux-kernel@vger.rutgers.edu

Hello,

[ I'm including the strnlen_user() patch at the end. ]

> > > We need strnlen_user() basically.
> > 
> > In fact, we wouldn't need a plain strlen_user() then.  I've looked
> > through the references to strlen_user(), and all of them appear to
> > need this feature.  So we can simply update the code, and rename the
> > function.
> 
> Sounds good to me

I've decided to keep strlen_user() as well, but only as a wrapper to
the new strnlen_user().  No duplicate code this way.  (Well, it's now
a #define on x86, and an extra entry point into the code on Alpha.
Other architectures may do it either way.)

> I imagine Dave will want to do the sparc himself.

I've updated the code for x86 and Alpha for now.  The thing compiles
on other architectures, but continues to use plain strlen_user(), so
execve(2) can still be used to halt the system there.

[ Some non-security stuff below, just skip to the next paragraph if
you're not interested. ]

As for the performance, I've decided against porting the x86 code
from glibc (after having done that for my testing, actually).  The
performance increase it could achieve is within 50% on relatively
short strings that we're likely to see, but the code is far more
complicated (especially as we would need to make sure it doesn't
cross an extra page boundary when accessing more than a byte at a
time), and thus it would probably take longer until we see it in a
stable kernel.

However, I was able to make both the x86 and the Alpha code have
the same performance as strlen_user() did.  This is due to the fact
that "repne scasb" on x86 already checked for both events, and that
the loads have such a large latency on Alpha.  Of course, the Alpha
code could be made faster instead, by processing 2 quadwords at a
time, instead of just one, but that'd make the startup code larger,
as it would then have to ensure the alignment.  Again, I've decided
to keep the things simple for now.  (I've only made sure the code
runs just as fast as it used to on my 21164PC; this should also be
true for EV4, despite its worse dual-issue capabilities, as loads had
an even larger latency there.  I'm not familiar with EV6 enough to be
sure I haven't made things slower there, but I think I've got the two
branch instructions far enough from each other not to cause a stall.)

> If we do this for 2.3.x first (which for asm stuff I prefer we do) we can
> gratuitiously break other platforms, which I would prefer to see done

Well, I didn't have to break anything so far, and I've tested the two
pieces of assembly code against an obviously correct C implementation
in user-space on data from /dev/urandom, but it's okay with me if we
only get this into 2.3 first.  I'm going to include these changes in
my 2.2 patches, which I'll be maintaining anyway.

Alan, in the patch below I've also included the /proc/0...0pid fix
once again.  Is there a reason you've only included the 0...0fd one
in 2.2.13pre3?  Anyway, the patch is against 2.2.12, but intended as
an addition to the changes already made in 2.2.13pre3.  Thus, I am
not including the things that you've already fixed.

diff -urPX nopatch linux-2.2.12/arch/alpha/lib/strlen_user.S linux/arch/alpha/lib/strlen_user.S
--- linux-2.2.12/arch/alpha/lib/strlen_user.S	Sun Apr 25 04:54:08 1999
+++ linux/arch/alpha/lib/strlen_user.S	Sun Sep  5 05:02:40 1999
@@ -3,6 +3,13 @@
  *
  * Return the length of the string including the NUL terminator
  * (strlen+1) or zero if an error occurred.
+ *
+ * In places where it is critical to limit the processing time,
+ * and the data is not trusted, strnlen_user() should be used.
+ * It will return a value greater than its second argument if
+ * that limit would be exceeded. This implementation is allowed
+ * to access memory beyond the limit, but will not cross a page
+ * boundary when doing so.
  */
 
 #include <alpha/regdef.h>
@@ -27,6 +34,14 @@
 
 	.align 3
 __strlen_user:
+	ldah	a1, 32767(zero)	# do not use plain strlen_user() for strings
+				# that might be almost 2 GB long; you should
+				# be using strnlen_user() instead
+
+	.globl __strnlen_user
+
+	.align 3
+__strnlen_user:
 	ldgp	$29,0($27)	# we do exceptions -- we need the gp.
 	.prologue 1
 
@@ -37,9 +52,17 @@
 	or      t1, t0, t0
 	subq	a0, 1, a0	# get our +1 for the return 
 	cmpbge  zero, t0, t1	# t1 <- bitmask: bit i == 1 <==> i-th byte == 0
+	subq	a1, 7, t2
+	subq	a0, v0, t0
 	bne     t1, $found
 
-$loop:	EX( ldq t0, 8(v0) )
+	addq	t2, t0, t2
+	addq	a1, 1, a1
+
+	.align 3
+$loop:	ble	t2, $limit
+	EX( ldq t0, 8(v0) )
+	subq	t2, 8, t2
 	addq    v0, 8, v0	# addr += 8
 	cmpbge  zero, t0, t1
 	beq     t1, $loop
@@ -59,6 +82,11 @@
 	nop			# dual issue next two on ev4 and ev5
 	subq    v0, a0, v0
 $exception:
+	ret
+
+	.align 3		# currently redundant
+$limit:
+	subq	a1, t2, v0
 	ret
 
 	.end __strlen_user
diff -urPX nopatch linux-2.2.12/arch/i386/lib/usercopy.c linux/arch/i386/lib/usercopy.c
--- linux-2.2.12/arch/i386/lib/usercopy.c	Sun Dec 27 21:36:38 1998
+++ linux/arch/i386/lib/usercopy.c	Sun Sep  5 05:02:40 1999
@@ -117,26 +117,31 @@
 /*
  * Return the size of a string (including the ending 0)
  *
- * Return 0 for error
+ * Return 0 on exception, a value greater than N if too long
  */
 
-long strlen_user(const char *s)
+long strnlen_user(const char *s, long n)
 {
+	unsigned long mask = -__addr_ok(s);
 	unsigned long res;
 
 	__asm__ __volatile__(
+		"	andl %0,%%ecx\n"
 		"0:	repne; scasb\n"
-		"	notl %0\n"
+		"	setne %%al\n"
+		"	subl %%ecx,%0\n"
+		"	addl %0,%%eax\n"
 		"1:\n"
 		".section .fixup,\"ax\"\n"
-		"2:	xorl %0,%0\n"
+		"2:	xorl %%eax,%%eax\n"
 		"	jmp 1b\n"
 		".previous\n"
 		".section __ex_table,\"a\"\n"
 		"	.align 4\n"
 		"	.long 0b,2b\n"
 		".previous"
-		:"=c" (res), "=D" (s)
-		:"1" (s), "a" (0), "0" (-__addr_ok(s)));
-	return res & -__addr_ok(s);
+		:"=r" (n), "=D" (s), "=a" (res)
+		:"0" (n), "1" (s), "2" (0), "c" (mask)
+		:"cx", "cc");
+	return res & mask;
 }
diff -urPX nopatch linux-2.2.12/fs/exec.c linux/fs/exec.c
--- linux-2.2.12/fs/exec.c	Tue Aug 31 04:05:31 1999
+++ linux/fs/exec.c	Sun Sep  5 05:02:40 1999
@@ -244,8 +244,8 @@
 	char *str;
 	mm_segment_t old_fs;
 
-	if (!p)
-		return 0;	/* bullet-proofing */
+	if ((long)p <= 0)
+		return p;	/* bullet-proofing */
 	old_fs = get_fs();
 	if (from_kmem==2)
 		set_fs(KERNEL_DS);
@@ -259,15 +259,19 @@
 		if (!str)
 		{
 			set_fs(old_fs);
-			return 0;
+			return -EFAULT;
 //			panic("VFS: argc is wrong");
 		}
 		if (from_kmem == 1)
 			set_fs(old_fs);
+#if defined(__i386__) || defined(__alpha__)
+		len = strnlen_user(str, p);	/* includes the '\0' */
+#else
 		len = strlen_user(str);	/* includes the '\0' */
-		if (p < len) {	/* this shouldn't happen - 128kB */
+#endif
+		if (!len || len > p) {	/* EFAULT or E2BIG */
 			set_fs(old_fs);
-			return 0;
+			return len ? -E2BIG : -EFAULT;
 		}
 		p -= len;
 		pos = p;
@@ -281,7 +285,7 @@
 			      (unsigned long *) get_free_page(GFP_USER))) {
 				if (from_kmem==2)
 					set_fs(old_fs);
-				return 0;
+				return -EFAULT;
 			}
 			bytes_to_copy = PAGE_SIZE - offset;
 			if (bytes_to_copy > len)
@@ -840,8 +844,8 @@
 		bprm.exec = bprm.p;
 		bprm.p = copy_strings(bprm.envc,envp,bprm.page,bprm.p,0);
 		bprm.p = copy_strings(bprm.argc,argv,bprm.page,bprm.p,0);
-		if (!bprm.p)
-			retval = -E2BIG;
+		if ((long)bprm.p < 0)
+			retval = (long)bprm.p;
 	}
 
 	if (retval >= 0)
diff -urPX nopatch linux-2.2.12/fs/proc/root.c linux/fs/proc/root.c
--- linux-2.2.12/fs/proc/root.c	Mon Aug  9 23:04:41 1999
+++ linux/fs/proc/root.c	Sun Sep  5 05:02:40 1999
@@ -845,6 +845,7 @@
 		}
 		pid *= 10;
 		pid += c;
+		if (!pid) break;
 		if (pid & 0xffff0000) {
 			pid = 0;
 			break;
diff -urPX nopatch linux-2.2.12/include/asm-alpha/uaccess.h linux/include/asm-alpha/uaccess.h
--- linux-2.2.12/include/asm-alpha/uaccess.h	Sun Apr 25 04:54:08 1999
+++ linux/include/asm-alpha/uaccess.h	Sun Sep  5 05:02:40 1999
@@ -487,6 +487,15 @@
 	return access_ok(VERIFY_READ,str,0) ? __strlen_user(str) : 0;
 }
 
+/* Returns: 0 if exception before NUL or reaching the supplied limit (N),
+ * a value greater than N if the limit would be exceeded, else strlen.  */
+extern long __strnlen_user(const char *, long);
+
+extern inline long strnlen_user(const char *str, long n)
+{
+	return access_ok(VERIFY_READ,str,0) ? __strnlen_user(str, n) : 0;
+}
+
 /*
  * About the exception table:
  *
diff -urPX nopatch linux-2.2.12/include/asm-i386/uaccess.h linux/include/asm-i386/uaccess.h
--- linux-2.2.12/include/asm-i386/uaccess.h	Tue May 11 21:35:46 1999
+++ linux/include/asm-i386/uaccess.h	Sun Sep  5 05:02:40 1999
@@ -597,7 +597,8 @@
 
 long strncpy_from_user(char *dst, const char *src, long count);
 long __strncpy_from_user(char *dst, const char *src, long count);
-long strlen_user(const char *str);
+#define strlen_user(str) strnlen_user(str, ~0UL >> 1)
+long strnlen_user(const char *str, long n);
 unsigned long clear_user(void *mem, unsigned long len);
 unsigned long __clear_user(void *mem, unsigned long len);
 
diff -urPX nopatch linux-2.2.12/include/linux/capability.h linux/include/linux/capability.h
--- linux-2.2.12/include/linux/capability.h	Mon Aug  9 23:04:41 1999
+++ linux/include/linux/capability.h	Sun Sep  5 05:02:40 1999
@@ -89,9 +89,9 @@
 /* Overrides the following restrictions that the effective user ID
    shall match the file owner ID when setting the S_ISUID and S_ISGID
    bits on that file; that the effective group ID (or one of the
-   supplementary group IDs shall match the file owner ID when setting
+   supplementary group IDs) shall match the file owner ID when setting
    the S_ISGID bit on that file; that the S_ISUID and S_ISGID bits are
-   cleared on successful return from chown(2). */
+   cleared on successful return from chown(2) (not implemented). */
 
 #define CAP_FSETID           4
 
Signed,
Solar Designer

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
