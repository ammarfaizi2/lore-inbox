Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262028AbTIGQsn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Sep 2003 12:48:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263355AbTIGQsm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Sep 2003 12:48:42 -0400
Received: from ns.suse.de ([195.135.220.2]:7399 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262028AbTIGQsR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Sep 2003 12:48:17 -0400
To: Matthew Wilcox <willy@debian.org>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] use size_t for the broken ioctl numbers
References: <20030907062248.GX18654@parcelfarce.linux.theplanet.co.uk>
From: Andreas Schwab <schwab@suse.de>
X-Yow: I'm ZIPPY the PINHEAD and I'm totally committed to the festive mode.
Date: Sun, 07 Sep 2003 18:48:14 +0200
In-Reply-To: <20030907062248.GX18654@parcelfarce.linux.theplanet.co.uk> (Matthew
 Wilcox's message of "Sun, 7 Sep 2003 07:22:48 +0100")
Message-ID: <jefzj8lf3l.fsf@sykes.suse.de>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox <willy@debian.org> writes:

> Index: include/linux/i8k.h
> ===================================================================
> RCS file: /var/cvs/linux-2.6/include/linux/i8k.h,v
> retrieving revision 1.1
> diff -u -p -r1.1 i8k.h
> --- include/linux/i8k.h	29 Jul 2003 17:02:12 -0000	1.1
> +++ include/linux/i8k.h	7 Sep 2003 06:19:03 -0000
> @@ -22,12 +22,12 @@
>  
>  #define I8K_BIOS_VERSION	_IOR ('i', 0x80, 4)
>  #define I8K_MACHINE_ID		_IOR ('i', 0x81, 16)

These should probably be changed to use int instead of the number.

Here is a patch that enforces the use of types in the third argument.  It
requires gcc >= 3.1 for the check to work, I couldn't find a method for
previous versions.  This is tested on ia64, both 2.4.21 and 2.6.0-test4
(the former does not have asm-arm26, asm-h8300 and asm-v850, and latter
does not have asm-mips64 and asm-s390x, so you get some rejects in either
case).

Andreas.

--- include/asm-alpha/ioctl.h.~1~	1996-03-24 11:09:36.000000000 +0100
+++ include/asm-alpha/ioctl.h	2003-09-07 16:35:59.000000000 +0200
@@ -43,11 +43,18 @@
 	  ((nr)   << _IOC_NRSHIFT) |		\
 	  ((size) << _IOC_SIZESHIFT)))
 
+#if __GNUC__ > 3 || (__GNUC__ == 3 && __GNUC_MINOR__ >= 1)
+/* This gives a parse error when T is not a type. */
+#define _IOC_CHECK_TYPE(t) ((void)__builtin_types_compatible_p(t, void))
+#else
+#define _IOC_CHECK_TYPE(t) ((void)0)
+#endif
+
 /* used to create numbers */
 #define _IO(type,nr)		_IOC(_IOC_NONE,(type),(nr),0)
-#define _IOR(type,nr,size)	_IOC(_IOC_READ,(type),(nr),sizeof(size))
-#define _IOW(type,nr,size)	_IOC(_IOC_WRITE,(type),(nr),sizeof(size))
-#define _IOWR(type,nr,size)	_IOC(_IOC_READ|_IOC_WRITE,(type),(nr),sizeof(size))
+#define _IOR(type,nr,size)	_IOC(_IOC_READ,(type),(nr),(_IOC_CHECK_TYPE(size),sizeof(size)))
+#define _IOW(type,nr,size)	_IOC(_IOC_WRITE,(type),(nr),(_IOC_CHECK_TYPE(size),sizeof(size)))
+#define _IOWR(type,nr,size)	_IOC(_IOC_READ|_IOC_WRITE,(type),(nr),(_IOC_CHECK_TYPE(size),sizeof(size)))
 
 /* used to decode them.. */
 #define _IOC_DIR(nr)		(((nr) >> _IOC_DIRSHIFT) & _IOC_DIRMASK)
--- include/asm-arm/ioctl.h.~1~	2003-09-07 16:38:05.000000000 +0200
+++ include/asm-arm/ioctl.h	2003-09-07 16:38:22.000000000 +0200
@@ -51,11 +51,18 @@
 	 ((nr)   << _IOC_NRSHIFT) | \
 	 ((size) << _IOC_SIZESHIFT))
 
+#if __GNUC__ > 3 || (__GNUC__ == 3 && __GNUC_MINOR__ >= 1)
+/* This gives a parse error when T is not a type. */
+#define _IOC_CHECK_TYPE(t) ((void)__builtin_types_compatible_p(t, void))
+#else
+#define _IOC_CHECK_TYPE(t) ((void)0)
+#endif
+
 /* used to create numbers */
 #define _IO(type,nr)		_IOC(_IOC_NONE,(type),(nr),0)
-#define _IOR(type,nr,size)	_IOC(_IOC_READ,(type),(nr),sizeof(size))
-#define _IOW(type,nr,size)	_IOC(_IOC_WRITE,(type),(nr),sizeof(size))
-#define _IOWR(type,nr,size)	_IOC(_IOC_READ|_IOC_WRITE,(type),(nr),sizeof(size))
+#define _IOR(type,nr,size)	_IOC(_IOC_READ,(type),(nr),(_IOC_CHECK_TYPE(size),sizeof(size)))
+#define _IOW(type,nr,size)	_IOC(_IOC_WRITE,(type),(nr),(_IOC_CHECK_TYPE(size),sizeof(size)))
+#define _IOWR(type,nr,size)	_IOC(_IOC_READ|_IOC_WRITE,(type),(nr),(_IOC_CHECK_TYPE(size),sizeof(size)))
 
 /* used to decode ioctl numbers.. */
 #define _IOC_DIR(nr)		(((nr) >> _IOC_DIRSHIFT) & _IOC_DIRMASK)
--- include/asm-arm26/ioctl.h.~1~	2003-08-23 01:57:53.000000000 +0200
+++ include/asm-arm26/ioctl.h	2003-09-07 18:39:32.000000000 +0200
@@ -51,11 +51,18 @@
 	 ((nr)   << _IOC_NRSHIFT) | \
 	 ((size) << _IOC_SIZESHIFT))
 
+#if __GNUC__ > 3 || (__GNUC__ == 3 && __GNUC_MINOR__ >= 1)
+/* This gives a syntax error when T is not a type. */
+#define _IOC_CHECK_TYPE(t) (__builtin_types_compatible_p(t, void))
+#else
+#define _IOC_CHECK_TYPE(t) ((void)0)
+#endif
+
 /* used to create numbers */
 #define _IO(type,nr)		_IOC(_IOC_NONE,(type),(nr),0)
-#define _IOR(type,nr,size)	_IOC(_IOC_READ,(type),(nr),sizeof(size))
-#define _IOW(type,nr,size)	_IOC(_IOC_WRITE,(type),(nr),sizeof(size))
-#define _IOWR(type,nr,size)	_IOC(_IOC_READ|_IOC_WRITE,(type),(nr),sizeof(size))
+#define _IOR(type,nr,size)	_IOC(_IOC_READ,(type),(nr),(_IOC_CHECK_TYPE(size),sizeof(size)))
+#define _IOW(type,nr,size)	_IOC(_IOC_WRITE,(type),(nr),(_IOC_CHECK_TYPE(size),sizeof(size)))
+#define _IOWR(type,nr,size)	_IOC(_IOC_READ|_IOC_WRITE,(type),(nr),(_IOC_CHECK_TYPE(size),sizeof(size)))
 
 /* used to decode ioctl numbers.. */
 #define _IOC_DIR(nr)		(((nr) >> _IOC_DIRSHIFT) & _IOC_DIRMASK)
--- include/asm-cris/ioctl.h.~1~	2001-02-09 01:32:44.000000000 +0100
+++ include/asm-cris/ioctl.h	2003-09-07 16:36:36.000000000 +0200
@@ -53,11 +53,18 @@
 	 ((nr)   << _IOC_NRSHIFT) | \
 	 ((size) << _IOC_SIZESHIFT))
 
+#if __GNUC__ > 3 || (__GNUC__ == 3 && __GNUC_MINOR__ >= 1)
+/* This gives a parse error when T is not a type. */
+#define _IOC_CHECK_TYPE(t) ((void)__builtin_types_compatible_p(t, void))
+#else
+#define _IOC_CHECK_TYPE(t) ((void)0)
+#endif
+
 /* used to create numbers */
 #define _IO(type,nr)		_IOC(_IOC_NONE,(type),(nr),0)
-#define _IOR(type,nr,size)	_IOC(_IOC_READ,(type),(nr),sizeof(size))
-#define _IOW(type,nr,size)	_IOC(_IOC_WRITE,(type),(nr),sizeof(size))
-#define _IOWR(type,nr,size)	_IOC(_IOC_READ|_IOC_WRITE,(type),(nr),sizeof(size))
+#define _IOR(type,nr,size)	_IOC(_IOC_READ,(type),(nr),(_IOC_CHECK_TYPE(size),sizeof(size)))
+#define _IOW(type,nr,size)	_IOC(_IOC_WRITE,(type),(nr),(_IOC_CHECK_TYPE(size),sizeof(size)))
+#define _IOWR(type,nr,size)	_IOC(_IOC_READ|_IOC_WRITE,(type),(nr),(_IOC_CHECK_TYPE(size),sizeof(size)))
 
 /* used to decode ioctl numbers.. */
 #define _IOC_DIR(nr)		(((nr) >> _IOC_DIRSHIFT) & _IOC_DIRMASK)
--- include/asm-h8300/ioctl.h.~1~	2003-08-23 01:56:17.000000000 +0200
+++ include/asm-h8300/ioctl.h	2003-09-07 18:41:08.000000000 +0200
@@ -57,11 +57,18 @@
 	 ((nr)   << _IOC_NRSHIFT) | \
 	 ((size) << _IOC_SIZESHIFT))
 
+#if __GNUC__ > 3 || (__GNUC__ == 3 && __GNUC_MINOR__ >= 1)
+/* This gives a syntax error when T is not a type. */
+#define _IOC_CHECK_TYPE(t) (__builtin_types_compatible_p(t, void))
+#else
+#define _IOC_CHECK_TYPE(t) ((void)0)
+#endif
+
 /* used to create numbers */
 #define _IO(type,nr)		_IOC(_IOC_NONE,(type),(nr),0)
-#define _IOR(type,nr,size)	_IOC(_IOC_READ,(type),(nr),sizeof(size))
-#define _IOW(type,nr,size)	_IOC(_IOC_WRITE,(type),(nr),sizeof(size))
-#define _IOWR(type,nr,size)	_IOC(_IOC_READ|_IOC_WRITE,(type),(nr),sizeof(size))
+#define _IOR(type,nr,size)	_IOC(_IOC_READ,(type),(nr),(_IOC_CHECK_TYPE(size),sizeof(size)))
+#define _IOW(type,nr,size)	_IOC(_IOC_WRITE,(type),(nr),(_IOC_CHECK_TYPE(size),sizeof(size)))
+#define _IOWR(type,nr,size)	_IOC(_IOC_READ|_IOC_WRITE,(type),(nr),(_IOC_CHECK_TYPE(size),sizeof(size)))
 
 /* used to decode ioctl numbers.. */
 #define _IOC_DIR(nr)		(((nr) >> _IOC_DIRSHIFT) & _IOC_DIRMASK)
--- include/asm-i386/ioctl.h.~1~	1995-11-15 08:15:02.000000000 +0100
+++ include/asm-i386/ioctl.h	2003-09-07 16:38:54.000000000 +0200
@@ -52,11 +52,18 @@
 	 ((nr)   << _IOC_NRSHIFT) | \
 	 ((size) << _IOC_SIZESHIFT))
 
+#if __GNUC__ > 3 || (__GNUC__ == 3 && __GNUC_MINOR__ >= 1)
+/* This gives a parse error when T is not a type. */
+#define _IOC_CHECK_TYPE(t) ((void)__builtin_types_compatible_p(t, void))
+#else
+#define _IOC_CHECK_TYPE(t) ((void)0)
+#endif
+
 /* used to create numbers */
 #define _IO(type,nr)		_IOC(_IOC_NONE,(type),(nr),0)
-#define _IOR(type,nr,size)	_IOC(_IOC_READ,(type),(nr),sizeof(size))
-#define _IOW(type,nr,size)	_IOC(_IOC_WRITE,(type),(nr),sizeof(size))
-#define _IOWR(type,nr,size)	_IOC(_IOC_READ|_IOC_WRITE,(type),(nr),sizeof(size))
+#define _IOR(type,nr,size)	_IOC(_IOC_READ,(type),(nr),(_IOC_CHECK_TYPE(size),sizeof(size)))
+#define _IOW(type,nr,size)	_IOC(_IOC_WRITE,(type),(nr),(_IOC_CHECK_TYPE(size),sizeof(size)))
+#define _IOWR(type,nr,size)	_IOC(_IOC_READ|_IOC_WRITE,(type),(nr),(_IOC_CHECK_TYPE(size),sizeof(size)))
 
 /* used to decode ioctl numbers.. */
 #define _IOC_DIR(nr)		(((nr) >> _IOC_DIRSHIFT) & _IOC_DIRMASK)
--- include/asm-ia64/ioctl.h.~1~	2000-02-07 03:42:40.000000000 +0100
+++ include/asm-ia64/ioctl.h	2003-09-07 16:39:19.000000000 +0200
@@ -54,11 +54,18 @@
 	 ((nr)   << _IOC_NRSHIFT) | \
 	 ((size) << _IOC_SIZESHIFT))
 
+#if __GNUC__ > 3 || (__GNUC__ == 3 && __GNUC_MINOR__ >= 1)
+/* This gives a parse error when T is not a type. */
+#define _IOC_CHECK_TYPE(t) ((void)__builtin_types_compatible_p(t, void))
+#else
+#define _IOC_CHECK_TYPE(t) ((void)0)
+#endif
+
 /* used to create numbers */
 #define _IO(type,nr)		_IOC(_IOC_NONE,(type),(nr),0)
-#define _IOR(type,nr,size)	_IOC(_IOC_READ,(type),(nr),sizeof(size))
-#define _IOW(type,nr,size)	_IOC(_IOC_WRITE,(type),(nr),sizeof(size))
-#define _IOWR(type,nr,size)	_IOC(_IOC_READ|_IOC_WRITE,(type),(nr),sizeof(size))
+#define _IOR(type,nr,size)	_IOC(_IOC_READ,(type),(nr),(_IOC_CHECK_TYPE(size),sizeof(size)))
+#define _IOW(type,nr,size)	_IOC(_IOC_WRITE,(type),(nr),(_IOC_CHECK_TYPE(size),sizeof(size)))
+#define _IOWR(type,nr,size)	_IOC(_IOC_READ|_IOC_WRITE,(type),(nr),(_IOC_CHECK_TYPE(size),sizeof(size)))
 
 /* used to decode ioctl numbers.. */
 #define _IOC_DIR(nr)		(((nr) >> _IOC_DIRSHIFT) & _IOC_DIRMASK)
--- include/asm-m68k/ioctl.h.~1~	1997-04-24 04:01:27.000000000 +0200
+++ include/asm-m68k/ioctl.h	2003-09-07 16:39:40.000000000 +0200
@@ -57,11 +57,18 @@
 	 ((nr)   << _IOC_NRSHIFT) | \
 	 ((size) << _IOC_SIZESHIFT))
 
+#if __GNUC__ > 3 || (__GNUC__ == 3 && __GNUC_MINOR__ >= 1)
+/* This gives a parse error when T is not a type. */
+#define _IOC_CHECK_TYPE(t) ((void)__builtin_types_compatible_p(t, void))
+#else
+#define _IOC_CHECK_TYPE(t) ((void)0)
+#endif
+
 /* used to create numbers */
 #define _IO(type,nr)		_IOC(_IOC_NONE,(type),(nr),0)
-#define _IOR(type,nr,size)	_IOC(_IOC_READ,(type),(nr),sizeof(size))
-#define _IOW(type,nr,size)	_IOC(_IOC_WRITE,(type),(nr),sizeof(size))
-#define _IOWR(type,nr,size)	_IOC(_IOC_READ|_IOC_WRITE,(type),(nr),sizeof(size))
+#define _IOR(type,nr,size)	_IOC(_IOC_READ,(type),(nr),(_IOC_CHECK_TYPE(size),sizeof(size)))
+#define _IOW(type,nr,size)	_IOC(_IOC_WRITE,(type),(nr),(_IOC_CHECK_TYPE(size),sizeof(size)))
+#define _IOWR(type,nr,size)	_IOC(_IOC_READ|_IOC_WRITE,(type),(nr),(_IOC_CHECK_TYPE(size),sizeof(size)))
 
 /* used to decode ioctl numbers.. */
 #define _IOC_DIR(nr)		(((nr) >> _IOC_DIRSHIFT) & _IOC_DIRMASK)
--- include/asm-mips/ioctl.h.~1~	2001-07-02 22:56:40.000000000 +0200
+++ include/asm-mips/ioctl.h	2003-09-07 16:43:02.000000000 +0200
@@ -62,11 +62,18 @@
 	 ((nr)   << _IOC_NRSHIFT) | \
 	 ((size) << _IOC_SIZESHIFT))
 
+#if __GNUC__ > 3 || (__GNUC__ == 3 && __GNUC_MINOR__ >= 1)
+/* This gives a parse error when T is not a type. */
+#define _IOC_CHECK_TYPE(t) ((void)__builtin_types_compatible_p(t, void))
+#else
+#define _IOC_CHECK_TYPE(t) ((void)0)
+#endif
+
 /* used to create numbers */
 #define _IO(type,nr)		_IOC(_IOC_NONE,(type),(nr),0)
-#define _IOR(type,nr,size)	_IOC(_IOC_READ,(type),(nr),sizeof(size))
-#define _IOW(type,nr,size)	_IOC(_IOC_WRITE,(type),(nr),sizeof(size))
-#define _IOWR(type,nr,size)	_IOC(_IOC_READ|_IOC_WRITE,(type),(nr),sizeof(size))
+#define _IOR(type,nr,size)	_IOC(_IOC_READ,(type),(nr),(_IOC_CHECK_TYPE(size),sizeof(size)))
+#define _IOW(type,nr,size)	_IOC(_IOC_WRITE,(type),(nr),(_IOC_CHECK_TYPE(size),sizeof(size)))
+#define _IOWR(type,nr,size)	_IOC(_IOC_READ|_IOC_WRITE,(type),(nr),(_IOC_CHECK_TYPE(size),sizeof(size)))
 
 /* used to decode them.. */
 #define _IOC_DIR(nr)		(((nr) >> _IOC_DIRSHIFT) & _IOC_DIRMASK)
--- include/asm-mips64/ioctl.h.~1~	2001-09-09 19:43:02.000000000 +0200
+++ include/asm-mips64/ioctl.h	2003-09-07 16:41:13.000000000 +0200
@@ -65,11 +65,18 @@
 	 ((nr)   << _IOC_NRSHIFT) | \
 	 ((size) << _IOC_SIZESHIFT))
 
+#if __GNUC__ > 3 || (__GNUC__ == 3 && __GNUC_MINOR__ >= 1)
+/* This gives a parse error when T is not a type. */
+#define _IOC_CHECK_TYPE(t) ((void)__builtin_types_compatible_p(t, void))
+#else
+#define _IOC_CHECK_TYPE(t) ((void)0)
+#endif
+
 /* used to create numbers */
 #define _IO(type,nr)		_IOC(_IOC_NONE,(type),(nr),0)
-#define _IOR(type,nr,size)	_IOC(_IOC_READ,(type),(nr),sizeof(size))
-#define _IOW(type,nr,size)	_IOC(_IOC_WRITE,(type),(nr),sizeof(size))
-#define _IOWR(type,nr,size)	_IOC(_IOC_READ|_IOC_WRITE,(type),(nr),sizeof(size))
+#define _IOR(type,nr,size)	_IOC(_IOC_READ,(type),(nr),(_IOC_CHECK_TYPE(size),sizeof(size)))
+#define _IOW(type,nr,size)	_IOC(_IOC_WRITE,(type),(nr),(_IOC_CHECK_TYPE(size),sizeof(size)))
+#define _IOWR(type,nr,size)	_IOC(_IOC_READ|_IOC_WRITE,(type),(nr),(_IOC_CHECK_TYPE(size),sizeof(size)))
 
 /* used to decode them.. */
 #define _IOC_DIR(nr)		(((nr) >> _IOC_DIRSHIFT) & _IOC_DIRMASK)
--- include/asm-parisc/ioctl.h.~1~	2000-12-05 21:29:39.000000000 +0100
+++ include/asm-parisc/ioctl.h	2003-09-07 16:41:35.000000000 +0200
@@ -44,11 +44,18 @@
 	 ((nr)   << _IOC_NRSHIFT) | \
 	 ((size) << _IOC_SIZESHIFT))
 
+#if __GNUC__ > 3 || (__GNUC__ == 3 && __GNUC_MINOR__ >= 1)
+/* This gives a parse error when T is not a type. */
+#define _IOC_CHECK_TYPE(t) ((void)__builtin_types_compatible_p(t, void))
+#else
+#define _IOC_CHECK_TYPE(t) ((void)0)
+#endif
+
 /* used to create numbers */
 #define _IO(type,nr)		_IOC(_IOC_NONE,(type),(nr),0)
-#define _IOR(type,nr,size)	_IOC(_IOC_READ,(type),(nr),sizeof(size))
-#define _IOW(type,nr,size)	_IOC(_IOC_WRITE,(type),(nr),sizeof(size))
-#define _IOWR(type,nr,size)	_IOC(_IOC_READ|_IOC_WRITE,(type),(nr),sizeof(size))
+#define _IOR(type,nr,size)	_IOC(_IOC_READ,(type),(nr),(_IOC_CHECK_TYPE(size),sizeof(size)))
+#define _IOW(type,nr,size)	_IOC(_IOC_WRITE,(type),(nr),(_IOC_CHECK_TYPE(size),sizeof(size)))
+#define _IOWR(type,nr,size)	_IOC(_IOC_READ|_IOC_WRITE,(type),(nr),(_IOC_CHECK_TYPE(size),sizeof(size)))
 
 /* used to decode ioctl numbers.. */
 #define _IOC_DIR(nr)		(((nr) >> _IOC_DIRSHIFT) & _IOC_DIRMASK)
--- include/asm-ppc/ioctl.h.~1~	2003-06-13 16:51:38.000000000 +0200
+++ include/asm-ppc/ioctl.h	2003-09-07 16:43:42.000000000 +0200
@@ -37,11 +37,18 @@
 	 ((nr)   << _IOC_NRSHIFT) | \
 	 ((size) << _IOC_SIZESHIFT))
 
+#if __GNUC__ > 3 || (__GNUC__ == 3 && __GNUC_MINOR__ >= 1)
+/* This gives a parse error when T is not a type. */
+#define _IOC_CHECK_TYPE(t) ((void)__builtin_types_compatible_p(t, void))
+#else
+#define _IOC_CHECK_TYPE(t) ((void)0)
+#endif
+
 /* used to create numbers */
 #define _IO(type,nr)		_IOC(_IOC_NONE,(type),(nr),0)
-#define _IOR(type,nr,size)	_IOC(_IOC_READ,(type),(nr),sizeof(size))
-#define _IOW(type,nr,size)	_IOC(_IOC_WRITE,(type),(nr),sizeof(size))
-#define _IOWR(type,nr,size)	_IOC(_IOC_READ|_IOC_WRITE,(type),(nr),sizeof(size))
+#define _IOR(type,nr,size)	_IOC(_IOC_READ,(type),(nr),(_IOC_CHECK_TYPE(size),sizeof(size)))
+#define _IOW(type,nr,size)	_IOC(_IOC_WRITE,(type),(nr),(_IOC_CHECK_TYPE(size),sizeof(size)))
+#define _IOWR(type,nr,size)	_IOC(_IOC_READ|_IOC_WRITE,(type),(nr),(_IOC_CHECK_TYPE(size),sizeof(size)))
 
 /* used to decode them.. */
 #define _IOC_DIR(nr)		(((nr) >> _IOC_DIRSHIFT) & _IOC_DIRMASK)
--- include/asm-ppc64/ioctl.h.~1~	2002-08-03 02:39:45.000000000 +0200
+++ include/asm-ppc64/ioctl.h	2003-09-07 16:42:26.000000000 +0200
@@ -42,11 +42,18 @@
 	 ((nr)   << _IOC_NRSHIFT) | \
 	 ((size) << _IOC_SIZESHIFT))
 
+#if __GNUC__ > 3 || (__GNUC__ == 3 && __GNUC_MINOR__ >= 1)
+/* This gives a parse error when T is not a type. */
+#define _IOC_CHECK_TYPE(t) ((void)__builtin_types_compatible_p(t, void))
+#else
+#define _IOC_CHECK_TYPE(t) ((void)0)
+#endif
+
 /* used to create numbers */
 #define _IO(type,nr)		_IOC(_IOC_NONE,(type),(nr),0)
-#define _IOR(type,nr,size)	_IOC(_IOC_READ,(type),(nr),sizeof(size))
-#define _IOW(type,nr,size)	_IOC(_IOC_WRITE,(type),(nr),sizeof(size))
-#define _IOWR(type,nr,size)	_IOC(_IOC_READ|_IOC_WRITE,(type),(nr),sizeof(size))
+#define _IOR(type,nr,size)	_IOC(_IOC_READ,(type),(nr),(_IOC_CHECK_TYPE(size),sizeof(size)))
+#define _IOW(type,nr,size)	_IOC(_IOC_WRITE,(type),(nr),(_IOC_CHECK_TYPE(size),sizeof(size)))
+#define _IOWR(type,nr,size)	_IOC(_IOC_READ|_IOC_WRITE,(type),(nr),(_IOC_CHECK_TYPE(size),sizeof(size)))
 
 /* used to decode them.. */
 #define _IOC_DIR(nr)		(((nr) >> _IOC_DIRSHIFT) & _IOC_DIRMASK)
--- include/asm-s390/ioctl.h.~1~	2000-05-12 20:41:44.000000000 +0200
+++ include/asm-s390/ioctl.h	2003-09-07 16:43:20.000000000 +0200
@@ -55,11 +55,18 @@
 	 ((nr)   << _IOC_NRSHIFT) | \
 	 ((size) << _IOC_SIZESHIFT))
 
+#if __GNUC__ > 3 || (__GNUC__ == 3 && __GNUC_MINOR__ >= 1)
+/* This gives a parse error when T is not a type. */
+#define _IOC_CHECK_TYPE(t) ((void)__builtin_types_compatible_p(t, void))
+#else
+#define _IOC_CHECK_TYPE(t) ((void)0)
+#endif
+
 /* used to create numbers */
 #define _IO(type,nr)		_IOC(_IOC_NONE,(type),(nr),0)
-#define _IOR(type,nr,size)	_IOC(_IOC_READ,(type),(nr),sizeof(size))
-#define _IOW(type,nr,size)	_IOC(_IOC_WRITE,(type),(nr),sizeof(size))
-#define _IOWR(type,nr,size)	_IOC(_IOC_READ|_IOC_WRITE,(type),(nr),sizeof(size))
+#define _IOR(type,nr,size)	_IOC(_IOC_READ,(type),(nr),(_IOC_CHECK_TYPE(size),sizeof(size)))
+#define _IOW(type,nr,size)	_IOC(_IOC_WRITE,(type),(nr),(_IOC_CHECK_TYPE(size),sizeof(size)))
+#define _IOWR(type,nr,size)	_IOC(_IOC_READ|_IOC_WRITE,(type),(nr),(_IOC_CHECK_TYPE(size),sizeof(size)))
 
 /* used to decode ioctl numbers.. */
 #define _IOC_DIR(nr)		(((nr) >> _IOC_DIRSHIFT) & _IOC_DIRMASK)
--- include/asm-s390x/ioctl.h.~1~	2001-02-13 23:13:44.000000000 +0100
+++ include/asm-s390x/ioctl.h	2003-09-07 16:42:08.000000000 +0200
@@ -55,11 +55,18 @@
 	 ((nr)   << _IOC_NRSHIFT) | \
 	 ((size) << _IOC_SIZESHIFT))
 
+#if __GNUC__ > 3 || (__GNUC__ == 3 && __GNUC_MINOR__ >= 1)
+/* This gives a parse error when T is not a type. */
+#define _IOC_CHECK_TYPE(t) ((void)__builtin_types_compatible_p(t, void))
+#else
+#define _IOC_CHECK_TYPE(t) ((void)0)
+#endif
+
 /* used to create numbers */
 #define _IO(type,nr)		_IOC(_IOC_NONE,(type),(nr),0)
-#define _IOR(type,nr,size)	_IOC(_IOC_READ,(type),(nr),sizeof(size))
-#define _IOW(type,nr,size)	_IOC(_IOC_WRITE,(type),(nr),sizeof(size))
-#define _IOWR(type,nr,size)	_IOC(_IOC_READ|_IOC_WRITE,(type),(nr),sizeof(size))
+#define _IOR(type,nr,size)	_IOC(_IOC_READ,(type),(nr),(_IOC_CHECK_TYPE(size),sizeof(size)))
+#define _IOW(type,nr,size)	_IOC(_IOC_WRITE,(type),(nr),(_IOC_CHECK_TYPE(size),sizeof(size)))
+#define _IOWR(type,nr,size)	_IOC(_IOC_READ|_IOC_WRITE,(type),(nr),(_IOC_CHECK_TYPE(size),sizeof(size)))
 
 /* used to decode ioctl numbers.. */
 #define _IOC_DIR(nr)		(((nr) >> _IOC_DIRSHIFT) & _IOC_DIRMASK)
--- include/asm-sh/ioctl.h.~1~	2001-10-15 22:36:48.000000000 +0200
+++ include/asm-sh/ioctl.h	2003-09-07 16:40:30.000000000 +0200
@@ -52,11 +52,18 @@
 	 ((nr)   << _IOC_NRSHIFT) | \
 	 ((size) << _IOC_SIZESHIFT))
 
+#if __GNUC__ > 3 || (__GNUC__ == 3 && __GNUC_MINOR__ >= 1)
+/* This gives a parse error when T is not a type. */
+#define _IOC_CHECK_TYPE(t) ((void)__builtin_types_compatible_p(t, void))
+#else
+#define _IOC_CHECK_TYPE(t) ((void)0)
+#endif
+
 /* used to create numbers */
 #define _IO(type,nr)		_IOC(_IOC_NONE,(type),(nr),0)
-#define _IOR(type,nr,size)	_IOC(_IOC_READ,(type),(nr),sizeof(size))
-#define _IOW(type,nr,size)	_IOC(_IOC_WRITE,(type),(nr),sizeof(size))
-#define _IOWR(type,nr,size)	_IOC(_IOC_READ|_IOC_WRITE,(type),(nr),sizeof(size))
+#define _IOR(type,nr,size)	_IOC(_IOC_READ,(type),(nr),(_IOC_CHECK_TYPE(size),sizeof(size)))
+#define _IOW(type,nr,size)	_IOC(_IOC_WRITE,(type),(nr),(_IOC_CHECK_TYPE(size),sizeof(size)))
+#define _IOWR(type,nr,size)	_IOC(_IOC_READ|_IOC_WRITE,(type),(nr),(_IOC_CHECK_TYPE(size),sizeof(size)))
 
 /* used to decode ioctl numbers.. */
 #define _IOC_DIR(nr)		(((nr) >> _IOC_DIRSHIFT) & _IOC_DIRMASK)
--- include/asm-sparc/ioctl.h.~1~	2003-06-13 16:51:38.000000000 +0200
+++ include/asm-sparc/ioctl.h	2003-09-07 16:42:42.000000000 +0200
@@ -42,10 +42,17 @@
          ((nr)   << _IOC_NRSHIFT) | \
          ((size) << _IOC_SIZESHIFT))
 
+#if __GNUC__ > 3 || (__GNUC__ == 3 && __GNUC_MINOR__ >= 1)
+/* This gives a parse error when T is not a type. */
+#define _IOC_CHECK_TYPE(t) ((void)__builtin_types_compatible_p(t, void))
+#else
+#define _IOC_CHECK_TYPE(t) ((void)0)
+#endif
+
 #define _IO(type,nr)        _IOC(_IOC_NONE,(type),(nr),0)
-#define _IOR(type,nr,size)  _IOC(_IOC_READ,(type),(nr),sizeof(size))
-#define _IOW(type,nr,size)  _IOC(_IOC_WRITE,(type),(nr),sizeof(size))
-#define _IOWR(type,nr,size) _IOC(_IOC_READ|_IOC_WRITE,(type),(nr),sizeof(size))
+#define _IOR(type,nr,size)  _IOC(_IOC_READ,(type),(nr),(_IOC_CHECK_TYPE(size),sizeof(size)))
+#define _IOW(type,nr,size)  _IOC(_IOC_WRITE,(type),(nr),(_IOC_CHECK_TYPE(size),sizeof(size)))
+#define _IOWR(type,nr,size) _IOC(_IOC_READ|_IOC_WRITE,(type),(nr),(_IOC_CHECK_TYPE(size),sizeof(size)))
 
 /* Used to decode ioctl numbers in drivers despite the leading underscore... */
 #define _IOC_DIR(nr)    \
--- include/asm-sparc64/ioctl.h.~1~	2003-06-13 16:51:38.000000000 +0200
+++ include/asm-sparc64/ioctl.h	2003-09-07 16:43:59.000000000 +0200
@@ -42,10 +42,17 @@
          ((nr)   << _IOC_NRSHIFT) | \
          ((size) << _IOC_SIZESHIFT))
 
+#if __GNUC__ > 3 || (__GNUC__ == 3 && __GNUC_MINOR__ >= 1)
+/* This gives a parse error when T is not a type. */
+#define _IOC_CHECK_TYPE(t) ((void)__builtin_types_compatible_p(t, void))
+#else
+#define _IOC_CHECK_TYPE(t) ((void)0)
+#endif
+
 #define _IO(type,nr)        _IOC(_IOC_NONE,(type),(nr),0)
-#define _IOR(type,nr,size)  _IOC(_IOC_READ,(type),(nr),sizeof(size))
-#define _IOW(type,nr,size)  _IOC(_IOC_WRITE,(type),(nr),sizeof(size))
-#define _IOWR(type,nr,size) _IOC(_IOC_READ|_IOC_WRITE,(type),(nr),sizeof(size))
+#define _IOR(type,nr,size)  _IOC(_IOC_READ,(type),(nr),(_IOC_CHECK_TYPE(size),sizeof(size)))
+#define _IOW(type,nr,size)  _IOC(_IOC_WRITE,(type),(nr),(_IOC_CHECK_TYPE(size),sizeof(size)))
+#define _IOWR(type,nr,size) _IOC(_IOC_READ|_IOC_WRITE,(type),(nr),(_IOC_CHECK_TYPE(size),sizeof(size)))
 
 /* Used to decode ioctl numbers in drivers despite the leading underscore... */
 #define _IOC_DIR(nr)    \
--- include/asm-v850/ioctl.h.~1~	2003-08-23 01:52:59.000000000 +0200
+++ include/asm-v850/ioctl.h	2003-09-07 18:42:51.000000000 +0200
@@ -57,11 +57,18 @@
 	 ((nr)   << _IOC_NRSHIFT) | \
 	 ((size) << _IOC_SIZESHIFT))
 
+#if __GNUC__ > 3 || (__GNUC__ == 3 && __GNUC_MINOR__ >= 1)
+/* This gives a syntax error when T is not a type. */
+#define _IOC_CHECK_TYPE(t) (__builtin_types_compatible_p(t, void))
+#else
+#define _IOC_CHECK_TYPE(t) ((void)0)
+#endif
+
 /* used to create numbers */
 #define _IO(type,nr)		_IOC(_IOC_NONE,(type),(nr),0)
-#define _IOR(type,nr,size)	_IOC(_IOC_READ,(type),(nr),sizeof(size))
-#define _IOW(type,nr,size)	_IOC(_IOC_WRITE,(type),(nr),sizeof(size))
-#define _IOWR(type,nr,size)	_IOC(_IOC_READ|_IOC_WRITE,(type),(nr),sizeof(size))
+#define _IOR(type,nr,size)	_IOC(_IOC_READ,(type),(nr),(_IOC_CHECK_TYPE(size),sizeof(size)))
+#define _IOW(type,nr,size)	_IOC(_IOC_WRITE,(type),(nr),(_IOC_CHECK_TYPE(size),sizeof(size)))
+#define _IOWR(type,nr,size)	_IOC(_IOC_READ|_IOC_WRITE,(type),(nr),(_IOC_CHECK_TYPE(size),sizeof(size)))
 
 /* used to decode ioctl numbers.. */
 #define _IOC_DIR(nr)		(((nr) >> _IOC_DIRSHIFT) & _IOC_DIRMASK)
--- include/asm-x86_64/ioctl.h.~1~	2002-11-29 00:53:15.000000000 +0100
+++ include/asm-x86_64/ioctl.h	2003-09-07 16:41:51.000000000 +0200
@@ -52,11 +52,18 @@
 	 ((nr)   << _IOC_NRSHIFT) | \
 	 ((size) << _IOC_SIZESHIFT))
 
+#if __GNUC__ > 3 || (__GNUC__ == 3 && __GNUC_MINOR__ >= 1)
+/* This gives a parse error when T is not a type. */
+#define _IOC_CHECK_TYPE(t) ((void)__builtin_types_compatible_p(t, void))
+#else
+#define _IOC_CHECK_TYPE(t) ((void)0)
+#endif
+
 /* used to create numbers */
 #define _IO(type,nr)		_IOC(_IOC_NONE,(type),(nr),0)
-#define _IOR(type,nr,size)	_IOC(_IOC_READ,(type),(nr),sizeof(size))
-#define _IOW(type,nr,size)	_IOC(_IOC_WRITE,(type),(nr),sizeof(size))
-#define _IOWR(type,nr,size)	_IOC(_IOC_READ|_IOC_WRITE,(type),(nr),sizeof(size))
+#define _IOR(type,nr,size)	_IOC(_IOC_READ,(type),(nr),(_IOC_CHECK_TYPE(size),sizeof(size)))
+#define _IOW(type,nr,size)	_IOC(_IOC_WRITE,(type),(nr),(_IOC_CHECK_TYPE(size),sizeof(size)))
+#define _IOWR(type,nr,size)	_IOC(_IOC_READ|_IOC_WRITE,(type),(nr),(_IOC_CHECK_TYPE(size),sizeof(size)))
 
 /* used to decode ioctl numbers.. */
 #define _IOC_DIR(nr)		(((nr) >> _IOC_DIRSHIFT) & _IOC_DIRMASK)

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux AG, Deutschherrnstr. 15-19, D-90429 Nürnberg
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
