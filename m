Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262406AbUCCHZt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 02:25:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262407AbUCCHZt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 02:25:49 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:56725 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S262406AbUCCHZr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 02:25:47 -0500
To: "Tolentino, Matthew E" <matthew.e.tolentino@intel.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [CFT][PATCH] 2.6.4-rc1 remove x86 boot page tables
References: <D36CE1FCEFD3524B81CA12C6FE5BCAB002FFE999@fmsmsx406.fm.intel.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 02 Mar 2004 23:47:41 -0700
In-Reply-To: <D36CE1FCEFD3524B81CA12C6FE5BCAB002FFE999@fmsmsx406.fm.intel.com>
Message-ID: <m18yii4eb6.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Tolentino, Matthew E" <matthew.e.tolentino@intel.com> writes:

> > I have rewritten and compiled tested the boot_ioremap code but I don't
> > have a configuration to test it. This effects the EFI code and the
> > numa srat code.   It might be worth replacing boot_ioremap with __va()
> > to reduce the amount of error checking necessary.
> 
> I just blindly applied this patch and tried it on an x86 EFI system
> with no luck.  It's not mapping correctly for some reason.  I'll look
> at the problem closer in a bit.


I know what the worst of the problem is.  efi_stub.S assumes there are
identity mapped pages, which my patch removes.

However there is at least this chunk of code:
	/*
	 * Show what we know for posterity
	 */
	c16 = (efi_char16_t *) boot_ioremap(efi.systab->fw_vendor, 2);
	if (c16) {
		for (i = 0; i < sizeof(vendor) && *c16; ++i)
			vendor[i] = *c16++;
		vendor[i] = '\0';
	} else
		printk(KERN_ERR PFX "Could not map the firmware vendor!\n");

	printk(KERN_INFO PFX "EFI v%u.%.02u by %s \n",
	       efi.systab->hdr.revision >> 16,
	       efi.systab->hdr.revision & 0xffff, vendor);

That is broken anyway.  boot_ioremap only supports one mapping at
a time and you are using the efi.systab mapping after removing it.

And the it is coded efi_enter_virtual_mode is not even optional.  Ugh.

Eric
