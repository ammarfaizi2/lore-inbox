Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261947AbTILXQx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 19:16:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261950AbTILXQw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 19:16:52 -0400
Received: from natsmtp01.webmailer.de ([192.67.198.81]:47074 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP id S261947AbTILXQk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 19:16:40 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Andreas Schwab <schwab@suse.de>, "Kevin P. Fleming" <kpfleming@cox.net>
Subject: Re: [PATCH] new ioctl type checking causes gcc warning
Date: Fri, 12 Sep 2003 14:53:06 +0200
User-Agent: KMail/1.5.1
Cc: LKML <linux-kernel@vger.kernel.org>
References: <3F621AC4.4070507@cox.net> <je65jx3hdk.fsf@sykes.suse.de>
In-Reply-To: <je65jx3hdk.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309121453.07111.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 12 September 2003 22:02, Andreas Schwab wrote:
> "Kevin P. Fleming" <kpfleming@cox.net> writes:
> >   /* provoke compile error for invalid uses of size argument */
> > -extern int __invalid_size_argument_for_IOC;
> > +extern unsigned int __invalid_size_argument_for_IOC;
>
> Why not make it size_t which is what sizeof actually returns?

I had tried that first, but found that there are places that
use asm/ioctl.h without including asm/posix_types.h first, so 
size_t might not be declared. unsigned int (or unsigned long)
is the better alternative here. Does this look ok to everyone?

	Arnd <><

===== include/asm-i386/ioctl.h 1.2 vs edited =====
--- 1.2/include/asm-i386/ioctl.h	Mon Sep  8 15:21:28 2003
+++ edited/include/asm-i386/ioctl.h	Fri Sep 12 14:42:58 2003
@@ -52,12 +52,16 @@
 	 ((nr)   << _IOC_NRSHIFT) | \
 	 ((size) << _IOC_SIZESHIFT))
 
+#ifdef __KERNEL__
 /* provoke compile error for invalid uses of size argument */
-extern int __invalid_size_argument_for_IOC;
+extern unsigned int __invalid_size_argument_for_IOC;
 #define _IOC_TYPECHECK(t) \
 	((sizeof(t) == sizeof(t[1]) && \
 	  sizeof(t) < (1 << _IOC_SIZEBITS)) ? \
 	  sizeof(t) : __invalid_size_argument_for_IOC)
+#else
+#define _IOC_TYPECHECK(t) sizeof(t)
+#endif
 
 /* used to create numbers */
 #define _IO(type,nr)		_IOC(_IOC_NONE,(type),(nr),0)
===== include/asm-ppc/ioctl.h 1.4 vs edited =====
--- 1.4/include/asm-ppc/ioctl.h	Mon Sep  8 20:14:00 2003
+++ edited/include/asm-ppc/ioctl.h	Fri Sep 12 14:42:42 2003
@@ -37,12 +37,16 @@
 	 ((nr)   << _IOC_NRSHIFT) | \
 	 ((size) << _IOC_SIZESHIFT))
 
+#ifdef __KERNEL__
 /* provoke compile error for invalid uses of size argument */
-extern int __invalid_size_argument_for_IOC;
+extern unsigned int __invalid_size_argument_for_IOC;
 #define _IOC_TYPECHECK(t) \
 	((sizeof(t) == sizeof(t[1]) && \
 	  sizeof(t) < (1 << _IOC_SIZEBITS)) ? \
 	  sizeof(t) : __invalid_size_argument_for_IOC)
+#else
+#define _IOC_TYPECHECK(t) sizeof(t)
+#endif
 
 /* used to create numbers */
 #define _IO(type,nr)		_IOC(_IOC_NONE,(type),(nr),0)
===== include/asm-ppc64/ioctl.h 1.2 vs edited =====
--- 1.2/include/asm-ppc64/ioctl.h	Tue Sep  9 22:23:09 2003
+++ edited/include/asm-ppc64/ioctl.h	Fri Sep 12 14:43:50 2003
@@ -42,12 +42,16 @@
 	 ((nr)   << _IOC_NRSHIFT) | \
 	 ((size) << _IOC_SIZESHIFT))
 
+#ifdef __KERNEL__
 /* provoke compile error for invalid uses of size argument */
-extern int __invalid_size_argument_for_IOC;
+extern unsigned long __invalid_size_argument_for_IOC;
 #define _IOC_TYPECHECK(t) \
        ((sizeof(t) == sizeof(t[1]) && \
          sizeof(t) < (1 << _IOC_SIZEBITS)) ? \
          sizeof(t) : __invalid_size_argument_for_IOC)
+#else
+#define _IOC_TYPECHECK(t) sizeof(t)
+#endif
 
 /* used to create numbers */
 #define _IO(type,nr)		_IOC(_IOC_NONE,(type),(nr),0)

