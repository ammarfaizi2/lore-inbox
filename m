Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261837AbTJDF7L (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Oct 2003 01:59:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261838AbTJDF7L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Oct 2003 01:59:11 -0400
Received: from fw.osdl.org ([65.172.181.6]:20623 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261837AbTJDF7H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Oct 2003 01:59:07 -0400
Date: Fri, 3 Oct 2003 23:00:44 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Tolentino, Matthew E" <matthew.e.tolentino@intel.com>
Cc: ebiederm@xmission.com, linux-kernel@vger.kernel.org
Subject: Re: [updated patch] for efi support in ia32 kernels
Message-Id: <20031003230044.76e08ab4.akpm@osdl.org>
In-Reply-To: <D36CE1FCEFD3524B81CA12C6FE5BCAB002FFE713@fmsmsx406.fm.intel.com>
References: <D36CE1FCEFD3524B81CA12C6FE5BCAB002FFE713@fmsmsx406.fm.intel.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Tolentino, Matthew E" <matthew.e.tolentino@intel.com> wrote:
>
>  Attached is another patch that enables EFI boot-up support in ia32 kernels. 

I've added the below patch to fix a few warnings:

arch/i386/kernel/efi.c:446: warning: cast from pointer to integer of different size
arch/i386/kernel/efi.c:455: warning: cast from pointer to integer of different size
arch/i386/kernel/efi.c:455: warning: cast to pointer from integer of different size


Please review, and test 2.6.0-test6-mm3 or later to make sure that things
are all OK.

Also, we really should make the EFI code CONFIGurable - it's another seven
kilobytes which a lot of people won't be needing.  A patch against -mm
which implements that would be appreciated.


 arch/i386/kernel/efi.c |   13 +++++++------
 1 files changed, 7 insertions(+), 6 deletions(-)

diff -puN arch/i386/kernel/efi.c~ia32-efi-support-warning-fixes arch/i386/kernel/efi.c
--- 25/arch/i386/kernel/efi.c~ia32-efi-support-warning-fixes	2003-10-03 22:43:42.000000000 -0700
+++ 25-akpm/arch/i386/kernel/efi.c	2003-10-03 22:51:03.000000000 -0700
@@ -441,18 +441,19 @@ void __init efi_enter_virtual_mode(void)
 
 		if (md->attribute & EFI_MEMORY_RUNTIME) {
 			md->virt_addr =
-				(u64) ioremap((unsigned long) md->phys_addr,
-					      (unsigned long) (md->num_pages
-						<< EFI_PAGE_SHIFT));
+				(unsigned long)ioremap(md->phys_addr,
+					md->num_pages << EFI_PAGE_SHIFT);
 			if (!(unsigned long) md->virt_addr) {
 				printk(KERN_ERR PFX "ioremap of md: 0x%lX failed \n",
 					(unsigned long) md->phys_addr);
 			}
 
 			if (((unsigned long)md->phys_addr <= (unsigned long)efi_phys.systab) && ((unsigned long)efi_phys.systab < md->phys_addr + ((unsigned long) md->num_pages << EFI_PAGE_SHIFT))) {
-				efi.systab = (efi_system_table_t *)
-					((md->virt_addr - md->phys_addr) +
-					(u64)efi_phys.systab);
+				unsigned long addr;
+
+				addr = md->virt_addr - md->phys_addr +
+						(unsigned long)efi_phys.systab;
+				efi.systab = (efi_system_table_t *)addr;
 			}
 		}
 	}

_

