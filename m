Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261811AbTIHNDb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 09:03:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262201AbTIHNDa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 09:03:30 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:35567 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261811AbTIHND2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 09:03:28 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] use size_t for the broken ioctl numbers
Date: Mon, 8 Sep 2003 15:03:20 +0200
User-Agent: KMail/1.5.1
Cc: Andreas Schwab <schwab@suse.de>, <linux-kernel@vger.kernel.org>,
       Matthew Wilcox <willy@debian.org>
References: <Pine.LNX.4.44.0309071617380.21192-100000@home.osdl.org>
In-Reply-To: <Pine.LNX.4.44.0309071617380.21192-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309081503.20459.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 08 September 2003 01:21, Linus Torvalds wrote:

> In fact, what you'd want to do is not just verify that it compiles, but
> also verify that the object code matches.

I have checked now that the object code for arch/s390/kernel/compat_ioctl.o
remains identical and that the whole kernel compiles for s390 and i386,
after fixing the broken ioctl numbers.

> Because there _is_ one case where adding the [1] will still compile, but
> generate wrong code: if the "size" argument to the _IOx() was not a type,
> but a real actual array.

Yes, there had to be a catch. The new version below catches that error
too, making that a link time failure and also checks that the size
field does not overflow.

	Arnd <><

--- 1.1/include/asm-i386/ioctl.h	Tue Feb  5 18:39:44 2002
+++ edited/include/asm-i386/ioctl.h	Mon Sep  8 13:21:28 2003
@@ -52,11 +52,21 @@
 	 ((nr)   << _IOC_NRSHIFT) | \
 	 ((size) << _IOC_SIZESHIFT))
 
+/* provoke compile error for invalid uses of size argument */
+extern int __invalid_size_argument_for_IOC;
+#define _IOC_TYPECHECK(t) \
+	((sizeof(t) == sizeof(t[1]) && \
+	  sizeof(t) < (1 << _IOC_SIZEBITS)) ? \
+	  sizeof(t) : __invalid_size_argument_for_IOC)
+
 /* used to create numbers */
 #define _IO(type,nr)		_IOC(_IOC_NONE,(type),(nr),0)
-#define _IOR(type,nr,size)	_IOC(_IOC_READ,(type),(nr),sizeof(size))
-#define _IOW(type,nr,size)	_IOC(_IOC_WRITE,(type),(nr),sizeof(size))
-#define _IOWR(type,nr,size)	_IOC(_IOC_READ|_IOC_WRITE,(type),(nr),sizeof(size))
+#define _IOR(type,nr,size)	_IOC(_IOC_READ,(type),(nr),(_IOC_TYPECHECK(size)))
+#define _IOW(type,nr,size)	_IOC(_IOC_WRITE,(type),(nr),(_IOC_TYPECHECK(size)))
+#define _IOWR(type,nr,size)	_IOC(_IOC_READ|_IOC_WRITE,(type),(nr),(_IOC_TYPECHECK(size)))
+#define _IOR_BAD(type,nr,size)	_IOC(_IOC_READ,(type),(nr),sizeof(size))
+#define _IOW_BAD(type,nr,size)	_IOC(_IOC_WRITE,(type),(nr),sizeof(size))
+#define _IOWR_BAD(type,nr,size)	_IOC(_IOC_READ|_IOC_WRITE,(type),(nr),sizeof(size))
 
 /* used to decode ioctl numbers.. */
 #define _IOC_DIR(nr)		(((nr) >> _IOC_DIRSHIFT) & _IOC_DIRMASK)
