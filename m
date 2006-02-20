Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932678AbWBTHkL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932678AbWBTHkL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 02:40:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932685AbWBTHkL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 02:40:11 -0500
Received: from zproxy.gmail.com ([64.233.162.204]:4185 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932678AbWBTHkJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 02:40:09 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=a6QSBNcTCSXHaLsxAyNZjZRo6QKzUe3X3Li1BogpOFG9fijun1kELVKE5POANaJTYuiCs0862eu8FKOoXJEAPvS5i0elXcbk5U/vyHjVEWWRnWk9N8GR+SghutSTpXXZamOGFWVYco82SUORfPe1pA2MSdQxJvVBHSazUNJZJds=
Message-ID: <489ecd0c0602192340h710b5807r4bc3e66b25c59bd9@mail.gmail.com>
Date: Mon, 20 Feb 2006 15:40:08 +0800
From: "Luke Yang" <luke.adi@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: [PATCH] Fix undefined symbols for nommu architecture --improved version
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060219223944.1a70aee1.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <489ecd0c0602192233y1cbd7d27s47755a14db115a79@mail.gmail.com>
	 <20060219223944.1a70aee1.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

  This is renewed patch. Tested on Blackfin platform.

  Signed-off-by: Luke Yang <luke.adi@gmail.com>

Index: git/linux-2.6/mm/nommu.c
===================================================================
--- git.orig/linux-2.6/mm/nommu.c	2006-02-20 12:33:25.000000000 +0800
+++ git/linux-2.6/mm/nommu.c	2006-02-20 15:12:08.000000000 +0800
@@ -57,6 +57,8 @@
 EXPORT_SYMBOL(vfree);
 EXPORT_SYMBOL(vmalloc_to_page);
 EXPORT_SYMBOL(vmalloc_32);
+EXPORT_SYMBOL(vmap);
+EXPORT_SYMBOL(vunmap);

 /*
  * Handle all mappings that got truncated by a "truncate()"
Index: git/linux-2.6/include/linux/mm.h
===================================================================
--- git.orig/linux-2.6/include/linux/mm.h	2006-02-20 15:25:21.000000000 +0800
+++ git/linux-2.6/include/linux/mm.h	2006-02-20 15:26:24.000000000 +0800
@@ -1051,7 +1051,11 @@
 void drop_pagecache(void);
 void drop_slab(void);

+#ifndef CONFIG_MMU
+#define randomize_va_space 0
+#else
 extern int randomize_va_space;
+#endif

 #endif /* __KERNEL__ */
 #endif /* _LINUX_MM_H */
Index: git/linux-2.6/kernel/sysctl.c
===================================================================
--- git.orig/linux-2.6/kernel/sysctl.c	2006-02-20 15:26:47.000000000 +0800
+++ git/linux-2.6/kernel/sysctl.c	2006-02-20 15:27:22.000000000 +0800
@@ -638,6 +638,7 @@
 		.proc_handler	= &proc_dointvec,
 	},
 #endif
+#if defined(CONFIG_MMU)
 	{
 		.ctl_name	= KERN_RANDOMIZE,
 		.procname	= "randomize_va_space",
@@ -646,6 +647,7 @@
 		.mode		= 0644,
 		.proc_handler	= &proc_dointvec,
 	},
+#endif
 #if defined(CONFIG_S390) && defined(CONFIG_SMP)
 	{
 		.ctl_name	= KERN_SPIN_RETRY,


On 2/20/06, Andrew Morton <akpm@osdl.org> wrote:
> "Luke Yang" <luke.adi@gmail.com> wrote:
> >
> > Index: git/linux-2.6/mm/nommu.c
> >  ===================================================================
> >  --- git.orig/linux-2.6/mm/nommu.c       2006-02-17 17:40:34.000000000 +0800
> >  +++ git/linux-2.6/mm/nommu.c    2006-02-20 12:09:32.000000000 +0800
> >  @@ -57,7 +57,10 @@
> >   EXPORT_SYMBOL(vfree);
> >   EXPORT_SYMBOL(vmalloc_to_page);
> >   EXPORT_SYMBOL(vmalloc_32);
> >  +EXPORT_SYMBOL(vmap);
> >  +EXPORT_SYMBOL(vunmap);
> >
> >  +#define randomize_va_space 0
> >   /*
> >   * Handle all mappings that got truncated by a "truncate()"
> >   * system call.
>
> That can't be right - the #define should be in a header file - mm.h:
>
> #ifdef CONFIG_NOMMU
> #define randomize_va_space 0
> #else
> extern int randomize_va_space;
> #endif
>
> Are you sure you test-compiled this?
 Sorry, nommu.c was compiled but the error still exists at the end of
compilation.  This time it is right.

>


--
Best regards,
Luke Yang
magic.yyang@gmail.com; luke.adi@gmail.com
