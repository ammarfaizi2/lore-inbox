Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756765AbWKXRAQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756765AbWKXRAQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Nov 2006 12:00:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757654AbWKXRAQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Nov 2006 12:00:16 -0500
Received: from 41.150.104.212.access.eclipse.net.uk ([212.104.150.41]:31201
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id S1756765AbWKXRAO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Nov 2006 12:00:14 -0500
Date: Fri, 24 Nov 2006 16:59:10 +0000
To: Andrew Morton <akpm@osdl.org>
Cc: Andy Whitcroft <apw@shadowen.org>,
       Artiom Myaskouvskey <artiom.myaskouvskey@intel.com>,
       Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: [PATCH] efi_limit_regions triggers link failure when CONFIG_EFI is not defined
Message-ID: <35d909969a9b883d8ee15ee1df497fd9@pinky>
References: <20061123021703.8550e37e.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
InReply-To: <20061123021703.8550e37e.akpm@osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
From: Andy Whitcroft <apw@shadowen.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patch is needed to get 2.6.19-rc6-mm1 to compile with
CONFIG_EFI disabled.  This is the 'shortest' fix.  However, it does
appear that there is some overlap with EFI implmentation partly
being in e820.c and partly in efi.c.  It might make sense to move
everything efi related over to efi.c.

-apw

=== 8< ===
efi_limit_regions triggers link failure when CONFIG_EFI is not defined

The changes in the patch x86_64-mm-i386-efi-memmap extracted
the guts of limit_regions out into a new efi_limit_regions().
This exposes this code to the compiler uncondionally, previously
it was under an if (efi_enabled) which allowed it to be optimised
away without comment.  This leads to link errors looking for an
undefined memmap.  Make the routine body conditional on CONFIG_EFI.

Signed-off-by: Andy Whitcroft <apw@shadowen.org>
---
diff --git a/arch/i386/kernel/e820.c b/arch/i386/kernel/e820.c
index 6f3fda4..393b87a 100644
--- a/arch/i386/kernel/e820.c
+++ b/arch/i386/kernel/e820.c
@@ -743,6 +743,7 @@ void __init print_memory_map(char *who)
 
 static __init void efi_limit_regions(unsigned long long size)
 {
+#ifdef CONFIG_EFI
 	unsigned long long current_addr = 0;
 	efi_memory_desc_t *md, *next_md;
 	void *p, *p1;
@@ -779,6 +780,7 @@ static __init void efi_limit_regions(uns
 	memmap.nr_map = j;
 	memmap.map_end = memmap.map +
 		(memmap.nr_map * memmap.desc_size);
+#endif /* CONFIG_EFI */
 }
 
 void __init limit_regions(unsigned long long size)
