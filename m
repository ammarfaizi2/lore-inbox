Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267650AbUJTPfB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267650AbUJTPfB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 11:35:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267362AbUJTPaY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 11:30:24 -0400
Received: from mo01.iij4u.or.jp ([210.130.0.20]:38336 "EHLO mo01.iij4u.or.jp")
	by vger.kernel.org with ESMTP id S268315AbUJTP2Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 11:28:16 -0400
Date: Thu, 21 Oct 2004 00:27:57 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: akpm@osdl.org
Cc: yuasa@hh.iij4u.or.jp, ralf@linux-mips.org, linux-kernel@vger.kernel.org,
       macro@linux-mips.org
Subject: [PATCH update] mips: fixed MIPS Makefile
Message-Id: <20041021002757.6935b2f7.yuasa@hh.iij4u.or.jp>
In-Reply-To: <Pine.LNX.4.58L.0410191834230.28336@blysk.ds.pg.gda.pl>
References: <20041020003351.4f9ee7c0.yuasa@hh.iij4u.or.jp>
	<Pine.LNX.4.58L.0410191834230.28336@blysk.ds.pg.gda.pl>
X-Mailer: Sylpheed version 0.9.99 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andrew,

I had updated my patch.
Please apply latest one.

On Tue, 19 Oct 2004 18:37:12 +0100 (BST)
"Maciej W. Rozycki" <macro@linux-mips.org> wrote:

> On Wed, 20 Oct 2004, Yoichi Yuasa wrote:
> 
> >  #
> > +# If you need data offset, please set up as follows.
> > +#
> > +# dataoffset-$(CONFIG_FOO) := <data offset value>
> > +# 
> > +
> > +DATAOFFSET	:= $(shell if [ -z $(dataoffset-y) ] ; then echo "0"; \
> > +			   else echo $(dataoffset-y); fi ;)
> 
>  Ugh, please consider using $(if ...).

Maciej,
Thank you for your comment.
My patch is updated.

The MIPS Makefile was changed so that the offset of data section
may not be dependent on a specific machine header file.

Signed-off-by: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>

diff -urN -X dontdiff a-orig/arch/mips/Makefile a/arch/mips/Makefile
--- a-orig/arch/mips/Makefile	Tue Oct 19 06:53:06 2004
+++ a/arch/mips/Makefile	Wed Oct 20 23:47:05 2004
@@ -527,6 +527,7 @@
 #load-$(CONFIG_SGI_IP27)	+= 0xa80000000001c000
 ifdef CONFIG_MAPPED_KERNEL
 load-$(CONFIG_SGI_IP27)		+= 0xc001c000
+dataoffset-$(CONFIG_SGI_IP27)	+= 0x01000000
 else
 load-$(CONFIG_SGI_IP27)		+= 0x8001c000
 endif
@@ -644,7 +645,7 @@
 CPPFLAGS_vmlinux.lds := \
 	-D"LOADADDR=$(load-y)" \
 	-D"JIFFIES=$(JIFFIES)" \
-	-imacros $(srctree)/include/asm-$(ARCH)/sn/mapped_kernel.h
+	-D"DATAOFFSET=$(if $(dataoffset-y),$(dataoffset-y),0)"
 
 AFLAGS		+= $(cflags-y)
 CFLAGS		+= $(cflags-y)
diff -urN -X dontdiff a-orig/arch/mips/kernel/vmlinux.lds.S a/arch/mips/kernel/vmlinux.lds.S
--- a-orig/arch/mips/kernel/vmlinux.lds.S	Tue Oct 19 06:53:46 2004
+++ a/arch/mips/kernel/vmlinux.lds.S	Wed Oct 20 23:46:31 2004
@@ -49,7 +49,7 @@
 
   /* writeable */
   .data : {			/* Data */
-    . = . + MAPPED_OFFSET;	/* for CONFIG_MAPPED_KERNEL */
+    . = . + DATAOFFSET;		/* for CONFIG_MAPPED_KERNEL */
     *(.data.init_task)
 
     *(.data)
diff -urN -X dontdiff a-orig/include/asm-mips/sn/mapped_kernel.h a/include/asm-mips/sn/mapped_kernel.h
--- a-orig/include/asm-mips/sn/mapped_kernel.h	Tue Oct 19 06:54:07 2004
+++ a/include/asm-mips/sn/mapped_kernel.h	Wed Oct 20 23:46:32 2004
@@ -39,13 +39,11 @@
 #define MAPPED_KERN_RW_TO_PHYS(x) \
 				((unsigned long)MAPPED_ADDR_RW_TO_PHYS(x) | \
 				MAPPED_KERN_RW_PHYSBASE(get_compact_nodeid()))
-#define MAPPED_OFFSET			16777216
 
 #else /* CONFIG_MAPPED_KERNEL */
 
 #define MAPPED_KERN_RO_TO_PHYS(x)	(x - CKSEG0)
 #define MAPPED_KERN_RW_TO_PHYS(x)	(x - CKSEG0)
-#define MAPPED_OFFSET			0
 
 #endif /* CONFIG_MAPPED_KERNEL */
 


