Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265626AbTIFBac (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 21:30:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265633AbTIFBac
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 21:30:32 -0400
Received: from fmr06.intel.com ([134.134.136.7]:8169 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S265626AbTIFBaU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 21:30:20 -0400
Subject: Re: [UPDATED PATCH] EFI support for ia32 kernels
From: Mark Gross <mgross@linux.co.intel.com>
Reply-To: mgross@linux.co.intel.com
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: "Tolentino, Matthew E" <matthew.e.tolentino@intel.com>,
       Andrew Morton <akpm@osdl.org>,
       Matt Tolentino <metolent@snoqualmie.dp.intel.com>,
       linux-kernel@vger.kernel.org, torvalds@osdl.org
In-Reply-To: <m1k78opnvw.fsf@ebiederm.dsl.xmission.com>
References: <D36CE1FCEFD3524B81CA12C6FE5BCAB002FFE677@fmsmsx406.fm.intel.com>
	 <m1k78opnvw.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain
Organization: TSP
Message-Id: <1062799223.7011.80.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 05 Sep 2003 15:00:23 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-09-04 at 08:35, Eric W. Biederman wrote:
> "Tolentino, Matthew E" <matthew.e.tolentino@intel.com> writes:
> 
> > Ok, I'll be sure to add more comments!  And you're right, this is in the EFI
> > spec, but briefly....
> > 
> > 
> > EFI operates in a flat, physical addressing mode.  So in order to call any of
> > the EFI runtime services (get_time, set_time, reset_system, etc.) without having
> > to thunk back into physical mode, we can call EFI set_virtual_address_space()
> > after ioremapping the regions in the memory map that have the runtime attribute
> > set (indicating that the region contains something that can be called during OS
> > runtime).  This call will "fix up" the EFI runtime services such that we can now
> > call them in virtual mode.  This code was stolen from the ia64 tree...
> 
> A problem is that set_virtual_address_space cannot be called multiple times,
> and so it interacts badly with kexec.  I was just about to disable it
> on the ia64 tree, so I could use kexec.  Besides that BIOS calls
> should be quite infrequent so flipping to physical mode this should
> not matter.  That plus not being in physical mode looks like a great
> way to trip up various implementation bugs when there are multiple
> implementations.

Hmmm.  I bet there is some other way to get around this.  Perhaps use
efi_set_varriable to implement a counter in NV memory or a page reserved
by the boot loader that gets initialized by elilo on the first boot up
and then have the kernel test / write to it in the startup before
calling set_vertual_address_space.  They would requier a tweak to the
boot loader to make work.



> 
> > I'm not sure what you mean here.  Nothing really, except that the loader passes
> > the location of the initrd to the kernel, even though the loader is currently
> > putting where the kernel expects it.  However, in the future this may allow the
> > initrd to be placed somewhere else.
> 
> > 
> > > > +struct ia32_boot_params {
> > > > +	unsigned long size;
> > > > +	unsigned long command_line;
> > > > +	efi_system_table_t *efi_sys_tbl;
> > > > +	efi_memory_desc_t *efi_mem_map;
> > > > +	unsigned long efi_mem_map_size;
> > > > +	unsigned long efi_mem_desc_size;	
> > > > +	unsigned long efi_mem_desc_version;
> > > > +	unsigned long initrd_start;
> > > > +	unsigned long initrd_size;
> > > > +	unsigned long loader_start;	
> > > > +	unsigned long loader_size;
> > > > +	unsigned long kernel_start;
> > > > +	unsigned long kenrel_size;
> > > > +	unsigned long num_cols;
> > > > +	unsigned long num_rows;
> > > > +	unsigned long orig_x;
> > > > +	unsigned long orig_y;
> > > > +};
> > > 
> > > Interesting.  What's all this, and how does the user interact with it?
> > 
> > It's the boot parameters that the EFI linux boot loader (ELILO) passes to the
> > kernel.  It's only used in the early boot process.
> 
> Hmm.  You have added additional parameters passed to the kernel, but
> have not updated the documentation.  Nor have you bumped the protocol
> number in setup.S. 

Bumping the boot protocal in setup.S doesn't make sence as this new boot
protocal is only possible under EFI platforms.  Legacy BIOS platform
boot up processing shouldn't know anything about it.  Its ment to be
orthoganal to the older boot protocal.

This being said, some EFI boot protocall documentation could be cut and
pasted out of the OLS talk into a new file the Documentation directory.

> 
> Beyond that you have duplicated a bunch of variables that already have
> perfectly valid ways of being passed to the kernel.

Actualy this is a step in getting away from those legacy boot
parrameters scattered about the boot parrameter block for the EFI boot
up processing.  

The worst thing about continuing to use the legacy boot parrameters is
that we then need to go hunting for holes in the existing structure
where we can put the new EFI specific values as well as ending up
carrying along baggage that dates way WAY back that doesn't get used or
make sence any more.

> 
> initrd_start, initrd_size, num_cols, num_rows, orig_x, orig_y and the
> command line should be passed in their original locations.  At least
> baring the creation of a subarch and starting from scratch.  
> 

We are hoping to avoid doing a subarch with this boot parrameter design
and went for a coexistance approach that has zero impact to the current
booting up on legacy platforms.  

I think this is THE key issue to get to the bottom of.  EFI enabled
kernels need not be a new sub-architecture, as we can see that the EFI
start up design supports booting on legacy firmware/bios, and has zero
impact on execution flow for the legacy case.  Do you think that doing a
sub architecture is really needed for this?

> kernel_start, and kernel_size are not used.
> loader_start, and loader_size are not used.
> 

They are anticipated to be useful for embedded designs booting linux on
EFI firmwware.  They could be removed but I'd rather see them stay.


--mgross

