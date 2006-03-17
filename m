Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751619AbWCQXwk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751619AbWCQXwk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 18:52:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751630AbWCQXwj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 18:52:39 -0500
Received: from smtp.osdl.org ([65.172.181.4]:46996 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751580AbWCQXwi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 18:52:38 -0500
Date: Fri, 17 Mar 2006 15:54:45 -0800
From: Andrew Morton <akpm@osdl.org>
To: Matt Domsch <Matt_Domsch@dell.com>
Cc: linux-ia64@vger.kernel.org, ak@suse.de,
       openipmi-developer@lists.sourceforge.net, matthew.e.tolentino@intel.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.15] ia64: use i386 dmi_scan.c
Message-Id: <20060317155445.602f07b9.akpm@osdl.org>
In-Reply-To: <20060106223932.GB9230@lists.us.dell.com>
References: <20060104221627.GA26064@lists.us.dell.com>
	<20060106172140.GB19605@lists.us.dell.com>
	<20060106223932.GB9230@lists.us.dell.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Domsch <Matt_Domsch@dell.com> wrote:
>
> +dmi_scan-y			+= ../../i386/kernel/dmi_scan.o
>

There's a patch in Andi's queue
(ftp://ftp.firstfloor.org/pub/ak/x86_64/quilt-current/patches/feature/dmi-early)
which adds

#include <asm/dmi.h>

into arch/i386/kernel/dmi_scan.c.

hence with both your patch and Andi's patch applied, ia64 won't compile due
to missing asm/dmi.h.

I've been reverting Andi's patch due to this, but it seems reasonable that
dmi_scan.c be able to include asm/dmi.h..

So to get these thing to play together properly we'll need an
include/asm-ia64/dmi.h which does the stuff which is in the two dmi.h's
which Andi's patch creates.

Is that something you could take a look at, please?

You'll need a kernel to patch, so I'll include this in next -mm:

--- /dev/null	Thu Apr 11 07:25:15 2002
+++ 25-akpm/include/asm-ia64/dmi.h	Fri Mar 17 15:49:50 2006
@@ -0,0 +1,6 @@
+#ifndef _ASM_DMI_H
+#define _ASM_DMI_H 1
+
+#include <asm/io.h>
+
+#endif
diff -puN arch/i386/kernel/dmi_scan.c~ia64-use-i386-dmi_scanc-fix arch/i386/kernel/dmi_scan.c
--- 25/arch/i386/kernel/dmi_scan.c~ia64-use-i386-dmi_scanc-fix	Fri Mar 17 15:49:37 2006
+++ 25-akpm/arch/i386/kernel/dmi_scan.c	Fri Mar 17 15:49:37 2006
@@ -224,7 +224,7 @@ void __init dmi_scan_machine(void)
                 * needed during early boot.  This also means we can
                 * iounmap the space when we're done with it.
 		*/
-		p = ioremap((unsigned long)efi.smbios, 0x10000);
+		p = dmi_ioremap((unsigned long)efi.smbios, 0x10000);
 		if (p == NULL)
 			goto out;
 
@@ -235,11 +235,11 @@ void __init dmi_scan_machine(void)
 	}
 	else {
 		/*
-		 * no iounmap() for that ioremap(); it would be a no-op, but it's
-		 * so early in setup that sucker gets confused into doing what
-		 * it shouldn't if we actually call it.
+		 * no iounmap() for that ioremap(); it would be a no-op, but
+		 * it's so early in setup that sucker gets confused into doing
+		 * what it shouldn't if we actually call it.
 		 */
-		p = ioremap(0xF0000, 0x10000);
+		p = dmi_ioremap(0xF0000, 0x10000);
 		if (p == NULL)
 			goto out;
 
_


I assume that those ioremap->dmi_ioremap conversions are appropriate.

It could be that Andi's changes break the ia64 dmi impementation - I don't
know.  I guess it's OK if ia64 is not doing a scan "early".

The above might not compile, but I'll make sure that it does so before
releasing next -mm.

So.  Bottom line: please test the ia64 dmi patches in next -mm, send any
needed fixups, thanks.


We should move this code into drivers/ or something - #including other
architecture's stuff like this is awful.

