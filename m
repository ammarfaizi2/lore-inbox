Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030486AbWJ3CfH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030486AbWJ3CfH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Oct 2006 21:35:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751921AbWJ3CfH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Oct 2006 21:35:07 -0500
Received: from ozlabs.org ([203.10.76.45]:16364 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1751909AbWJ3CfF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Oct 2006 21:35:05 -0500
Subject: Re: [PATCH 1/4] Prep for paravirt: Be careful about touching BIOS
	address space
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andrew Morton <akpm@osdl.org>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Pavel Machek <pavel@ucw.cz>,
       virtualization <virtualization@lists.osdl.org>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20061027215037.cd69b2a3.akpm@osdl.org>
References: <1161920325.17807.29.camel@localhost.localdomain>
	 <1161920535.17807.33.camel@localhost.localdomain>
	 <20061027113001.GB8095@elf.ucw.cz> <45427ABD.6070407@goop.org>
	 <20061027144157.f23fcf89.akpm@osdl.org> <4542DD84.3070006@goop.org>
	 <20061027215037.cd69b2a3.akpm@osdl.org>
Content-Type: text/plain
Date: Mon, 30 Oct 2006 13:35:01 +1100
Message-Id: <1162175701.9802.24.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-10-27 at 21:50 -0700, Andrew Morton wrote:
> On Fri, 27 Oct 2006 21:33:08 -0700
> Jeremy Fitzhardinge <jeremy@goop.org> wrote:
> 
> > Andrew Morton wrote:
> > > It'd be better to use include/linux/uaccess.h:probe_kernel_address() for
> > > this operation.
> > >   
> > Ah, yes, that was the precedent I was thinking of,
> 
> We've done open-coded __get_user() in various places in the past.  The difference with
> probe_kernel_address() is that it doesn't get deadlocked on mmap_sem().
> 
> >  but I guess it would 
> > be better to just use it directly.  It's a relatively new interface, 
> > isn't it?
> 
> Yeah.  New enough that nobody's tried using it on non-x86 ;) It needs
> to do set_fs(KERNEL_DS).

And the function name is misleading: it really does get a value, not
merely probe an address.  And the arguments are reversed from
__get_user, just to add fun.

Andrew, please replace
prep-for-paravirt-be-careful-about-touching-bios-warning-fix.patch

Subject: Be careful about touching BIOS address space

BIOS ROM areas may not be mapped into the guest address space, so be careful
when touching those addresses to make sure they appear to be mapped.

At Andrew's request, fix probe_kernel_address for non-x86.

Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>
Signed-off-by: Rusty Russell <rusty@rustcorp.com.au> (modified)

diff -r 9a6c8ceba677 arch/i386/kernel/setup.c
--- a/arch/i386/kernel/setup.c	Mon Oct 30 11:34:30 2006 +1100
+++ b/arch/i386/kernel/setup.c	Mon Oct 30 13:15:33 2006 +1100
@@ -47,6 +47,7 @@
 #include <linux/crash_dump.h>
 #include <linux/dmi.h>
 #include <linux/pfn.h>
+#include <linux/uaccess.h>
 
 #include <video/edid.h>
 
@@ -270,7 +271,14 @@ static struct resource standard_io_resou
 	.flags	= IORESOURCE_BUSY | IORESOURCE_IO
 } };
 
-#define romsignature(x) (*(unsigned short *)(x) == 0xaa55)
+static inline int romsignature(const unsigned char *x)
+{
+     unsigned short sig;
+     int ret = 0;
+     if (probe_kernel_address((const unsigned short *)x, sig) == 0)
+	  ret = (sig == 0xaa55);
+     return ret;
+}
 
 static int __init romchecksum(unsigned char *rom, unsigned long length)
 {
diff -r 9a6c8ceba677 arch/i386/pci/pcbios.c
--- a/arch/i386/pci/pcbios.c	Mon Oct 30 11:34:30 2006 +1100
+++ b/arch/i386/pci/pcbios.c	Mon Oct 30 13:15:02 2006 +1100
@@ -5,6 +5,7 @@
 #include <linux/pci.h>
 #include <linux/init.h>
 #include <linux/module.h>
+#include <linux/uaccess.h>
 #include "pci.h"
 #include "pci-functions.h"
 
@@ -314,6 +315,10 @@ static struct pci_raw_ops * __devinit pc
 	for (check = (union bios32 *) __va(0xe0000);
 	     check <= (union bios32 *) __va(0xffff0);
 	     ++check) {
+		long sig;
+		if (probe_kernel_address(&check->fields.signature, sig))
+			continue;
+
 		if (check->fields.signature != BIOS32_SIGNATURE)
 			continue;
 		length = check->fields.length * 16;
diff -r 9a6c8ceba677 include/linux/uaccess.h
--- a/include/linux/uaccess.h	Mon Oct 30 11:34:30 2006 +1100
+++ b/include/linux/uaccess.h	Mon Oct 30 13:10:39 2006 +1100
@@ -34,10 +34,13 @@ static inline unsigned long __copy_from_
 #define probe_kernel_address(addr, retval)		\
 	({						\
 		long ret;				\
+		mm_segment_t old_fs = get_fs();		\
 							\
+		set_fs(KERNEL_DS);			\
 		inc_preempt_count();			\
 		ret = __get_user(retval, addr);		\
 		dec_preempt_count();			\
+		set_fs(old_fs);				\
 		ret;					\
 	})
 


