Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932150AbVLFMms@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932150AbVLFMms (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 07:42:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932525AbVLFMms
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 07:42:48 -0500
Received: from TYO206.gate.nec.co.jp ([202.32.8.206]:11959 "EHLO
	tyo202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S932184AbVLFMmq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 07:42:46 -0500
From: "Takashi Sato" <sho@tnes.nec.co.jp>
To: <shaggy@austin.ibm.com>
Cc: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
Subject: Re: stat64 for over 2TB file returned invalid st_blocks
Date: Tue, 6 Dec 2005 21:42:37 +0900
Message-ID: <000301c5fa62$8d1bb730$4168010a@bsd.tnes.nec.co.jp>
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> > >> 2. Change the type of architecture dependent stat64.st_blocks in
> > >>    include/asm/asm-*/stat.h from unsigned long to unsigned long long.
> > >>    I tried modifying only stat64 of 32bit architecture
> > >>    (include/asm-i386/stat.h).
> > >
> > >This changes the API, but the structure does suggest that the 4-byte pad
> > >should be used for the high-order bytes of st_blocks, so that's not
> > >really a problem.  A correct fix would replace __pad4 with
> > >st_blocks_high (or something like that) and ensure that the high-order
> > >word was stored there.  Your proposed fix would only be correct on
> > >little-endian hardware, as Jörn pointed out.
> >
> > Thank you for your advice.  I'll research for glibc and consider
> > how to implement.
> > By the way I think, as Avi Kivity said, it's always little-endian on i386,
> > is it correct?
>
> That's true.  The patch does fix i386 without any bad side-effects.  A
> generic fix that would fix all architectures would be a little more
> complicated, since the size of st_blocks varies.  32-bit big-endian
> would have to explicitly copy the high and low words.  (The first time I
> looked at this, I ignored the fact that the change was in asm-i386.)

I realized some 32-bit big-endian architectures such as sh and m68k
have a padding before 32-bit st_blocks, though mips and ppc have
64-bit st_blocks.

- asm-sh
#if defined(__BIG_ENDIAN__)
        unsigned long   __pad4;         /* Future possible st_blocks hi bits */
        unsigned long   st_blocks;      /* Number 512-byte blocks allocated. */
#else /* Must be little */
        unsigned long   st_blocks;      /* Number 512-byte blocks allocated. */
        unsigned long   __pad4;         /* Future possible st_blocks hi bits */
#endif

- asm-m68k
        unsigned long   __pad4;         /* future possible st_blocks high bits */
        unsigned long   st_blocks;      /* Number 512-byte blocks allocated. */

So I updated the patch.  Any feedback and comments are welcome.

Signed-off-by: Takashi Sato <sho@tnes.nec.co.jp>
Signed-off-by: ASANO Masahiro <masano@tnes.nec.co.jp>

diff -uprN -X linux-2.6.15-rc5.org/Documentation/dontdiff linux-2.6.15-rc5.org/include/asm-i386/stat.h
linux-2.6.15-rc5-blocks/include/asm-i386/stat.h
--- linux-2.6.15-rc5.org/include/asm-i386/stat.h	2005-10-28 09:02:08.000000000 +0900
+++ linux-2.6.15-rc5-blocks/include/asm-i386/stat.h	2005-12-06 16:24:31.000000000 +0900
@@ -58,8 +58,7 @@ struct stat64 {
 	long long	st_size;
 	unsigned long	st_blksize;

-	unsigned long	st_blocks;	/* Number 512-byte blocks allocated. */
-	unsigned long	__pad4;		/* future possible st_blocks high bits */
+	unsigned long long	st_blocks;	/* Number 512-byte blocks allocated. */

 	unsigned long	st_atime;
 	unsigned long	st_atime_nsec;
diff -uprN -X linux-2.6.15-rc5.org/Documentation/dontdiff linux-2.6.15-rc5.org/include/asm-m68k/stat.h
linux-2.6.15-rc5-blocks/include/asm-m68k/stat.h
--- linux-2.6.15-rc5.org/include/asm-m68k/stat.h	2005-10-28 09:02:08.000000000 +0900
+++ linux-2.6.15-rc5-blocks/include/asm-m68k/stat.h	2005-12-06 16:29:50.000000000 +0900
@@ -60,8 +60,7 @@ struct stat64 {
 	long long	st_size;
 	unsigned long	st_blksize;

-	unsigned long	__pad4;		/* future possible st_blocks high bits */
-	unsigned long	st_blocks;	/* Number 512-byte blocks allocated. */
+	unsigned long long	st_blocks;	/* Number 512-byte blocks allocated. */

 	unsigned long	st_atime;
 	unsigned long	st_atime_nsec;
diff -uprN -X linux-2.6.15-rc5.org/Documentation/dontdiff linux-2.6.15-rc5.org/include/asm-sh/stat.h
linux-2.6.15-rc5-blocks/include/asm-sh/stat.h
--- linux-2.6.15-rc5.org/include/asm-sh/stat.h	2005-10-28 09:02:08.000000000 +0900
+++ linux-2.6.15-rc5-blocks/include/asm-sh/stat.h	2005-12-06 16:28:37.000000000 +0900
@@ -60,13 +60,7 @@ struct stat64 {
 	long long	st_size;
 	unsigned long	st_blksize;

-#if defined(__BIG_ENDIAN__)
-	unsigned long	__pad4;		/* Future possible st_blocks hi bits */
-	unsigned long	st_blocks;	/* Number 512-byte blocks allocated. */
-#else /* Must be little */
-	unsigned long	st_blocks;	/* Number 512-byte blocks allocated. */
-	unsigned long	__pad4;		/* Future possible st_blocks hi bits */
-#endif
+	unsigned long long	st_blocks;	/* Number 512-byte blocks allocated. */

 	unsigned long	st_atime;
 	unsigned long	st_atime_nsec;
diff -uprN -X linux-2.6.15-rc5.org/Documentation/dontdiff linux-2.6.15-rc5.org/include/linux/fs.h
linux-2.6.15-rc5-blocks/include/linux/fs.h
--- linux-2.6.15-rc5.org/include/linux/fs.h	2005-12-06 16:20:21.000000000 +0900
+++ linux-2.6.15-rc5-blocks/include/linux/fs.h	2005-12-06 16:26:01.000000000 +0900
@@ -450,7 +450,7 @@ struct inode {
 	unsigned int		i_blkbits;
 	unsigned long		i_blksize;
 	unsigned long		i_version;
-	unsigned long		i_blocks;
+	unsigned long long	i_blocks;
 	unsigned short          i_bytes;
 	spinlock_t		i_lock;	/* i_blocks, i_bytes, maybe i_size */
 	struct semaphore	i_sem;
diff -uprN -X linux-2.6.15-rc5.org/Documentation/dontdiff linux-2.6.15-rc5.org/include/linux/stat.h
linux-2.6.15-rc5-blocks/include/linux/stat.h
--- linux-2.6.15-rc5.org/include/linux/stat.h	2005-10-28 09:02:08.000000000 +0900
+++ linux-2.6.15-rc5-blocks/include/linux/stat.h	2005-12-06 16:26:26.000000000 +0900
@@ -69,7 +69,7 @@ struct kstat {
 	struct timespec	mtime;
 	struct timespec	ctime;
 	unsigned long	blksize;
-	unsigned long	blocks;
+	unsigned long long	blocks;
 };

 #endif

-- Takashi Sato


