Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265105AbTIDPgD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 11:36:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265116AbTIDPgD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 11:36:03 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:13888 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S265105AbTIDPf4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 11:35:56 -0400
To: "Tolentino, Matthew E" <matthew.e.tolentino@intel.com>
Cc: "Andrew Morton" <akpm@osdl.org>,
       "Matt Tolentino" <metolent@snoqualmie.dp.intel.com>,
       <linux-kernel@vger.kernel.org>, <torvalds@osdl.org>
Subject: Re: [UPDATED PATCH] EFI support for ia32 kernels
References: <D36CE1FCEFD3524B81CA12C6FE5BCAB002FFE677@fmsmsx406.fm.intel.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 04 Sep 2003 09:35:47 -0600
In-Reply-To: <D36CE1FCEFD3524B81CA12C6FE5BCAB002FFE677@fmsmsx406.fm.intel.com>
Message-ID: <m1k78opnvw.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Tolentino, Matthew E" <matthew.e.tolentino@intel.com> writes:

> Ok, I'll be sure to add more comments!  And you're right, this is in the EFI
> spec, but briefly....
> 
> 
> EFI operates in a flat, physical addressing mode.  So in order to call any of
> the EFI runtime services (get_time, set_time, reset_system, etc.) without having
> to thunk back into physical mode, we can call EFI set_virtual_address_space()
> after ioremapping the regions in the memory map that have the runtime attribute
> set (indicating that the region contains something that can be called during OS
> runtime).  This call will "fix up" the EFI runtime services such that we can now
> call them in virtual mode.  This code was stolen from the ia64 tree...

A problem is that set_virtual_address_space cannot be called multiple times,
and so it interacts badly with kexec.  I was just about to disable it
on the ia64 tree, so I could use kexec.  Besides that BIOS calls
should be quite infrequent so flipping to physical mode this should
not matter.  That plus not being in physical mode looks like a great
way to trip up various implementation bugs when there are multiple
implementations.

> I'm not sure what you mean here.  Nothing really, except that the loader passes
> the location of the initrd to the kernel, even though the loader is currently
> putting where the kernel expects it.  However, in the future this may allow the
> initrd to be placed somewhere else.

> 
> > > +struct ia32_boot_params {
> > > +	unsigned long size;
> > > +	unsigned long command_line;
> > > +	efi_system_table_t *efi_sys_tbl;
> > > +	efi_memory_desc_t *efi_mem_map;
> > > +	unsigned long efi_mem_map_size;
> > > +	unsigned long efi_mem_desc_size;	
> > > +	unsigned long efi_mem_desc_version;
> > > +	unsigned long initrd_start;
> > > +	unsigned long initrd_size;
> > > +	unsigned long loader_start;	
> > > +	unsigned long loader_size;
> > > +	unsigned long kernel_start;
> > > +	unsigned long kenrel_size;
> > > +	unsigned long num_cols;
> > > +	unsigned long num_rows;
> > > +	unsigned long orig_x;
> > > +	unsigned long orig_y;
> > > +};
> > 
> > Interesting.  What's all this, and how does the user interact with it?
> 
> It's the boot parameters that the EFI linux boot loader (ELILO) passes to the
> kernel.  It's only used in the early boot process.

Hmm.  You have added additional parameters passed to the kernel, but
have not updated the documentation.  Nor have you bumped the protocol
number in setup.S. 

Beyond that you have duplicated a bunch of variables that already have
perfectly valid ways of being passed to the kernel.

initrd_start, initrd_size, num_cols, num_rows, orig_x, orig_y and the
command line should be passed in their original locations.  At least
baring the creation of a subarch and starting from scratch.  

kernel_start, and kernel_size are not used.
loader_start, and loader_size are not used.

And are probably equally valid in other contexts.  

Eric
