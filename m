Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262057AbTIFEe4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Sep 2003 00:34:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262345AbTIFEe4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Sep 2003 00:34:56 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:3160 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S262057AbTIFEev (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Sep 2003 00:34:51 -0400
To: mgross@linux.co.intel.com
Cc: "Tolentino, Matthew E" <matthew.e.tolentino@intel.com>,
       Andrew Morton <akpm@osdl.org>,
       Matt Tolentino <metolent@snoqualmie.dp.intel.com>,
       linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [UPDATED PATCH] EFI support for ia32 kernels
References: <D36CE1FCEFD3524B81CA12C6FE5BCAB002FFE677@fmsmsx406.fm.intel.com>
	<m1k78opnvw.fsf@ebiederm.dsl.xmission.com>
	<1062799223.7011.80.camel@localhost.localdomain>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 05 Sep 2003 22:34:25 -0600
In-Reply-To: <1062799223.7011.80.camel@localhost.localdomain>
Message-ID: <m11xuupmb2.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Gross <mgross@linux.co.intel.com> writes:

> On Thu, 2003-09-04 at 08:35, Eric W. Biederman wrote:
> > "Tolentino, Matthew E" <matthew.e.tolentino@intel.com> writes:
> > A problem is that set_virtual_address_space cannot be called multiple times,
> > and so it interacts badly with kexec.  I was just about to disable it
> > on the ia64 tree, so I could use kexec.  Besides that BIOS calls
> > should be quite infrequent so flipping to physical mode this should
> > not matter.  That plus not being in physical mode looks like a great
> > way to trip up various implementation bugs when there are multiple
> > implementations.
> 
> Hmmm.  I bet there is some other way to get around this.  

Why enable a slow path case that will make the system less reliable?

> Perhaps use
> efi_set_varriable to implement a counter in NV memory or a page reserved
> by the boot loader that gets initialized by elilo on the first boot up
> and then have the kernel test / write to it in the startup before
> calling set_vertual_address_space.  They would requier a tweak to the
> boot loader to make work.

Sure you can do things like that but then you can't call EFI in physical
address mode.

set_virtual_address_space is unnecessary, on a slow path, tricky to
test, and potentially bug prone.  

Please just deprecate set_virtual_address please.

> > > I'm not sure what you mean here.  Nothing really, except that the loader
> passes
> 
> > > the location of the initrd to the kernel, even though the loader is
> currently
> 
> > > putting where the kernel expects it.  However, in the future this may allow
> the
> 
> > > initrd to be placed somewhere else.
> > 
> > > 
> > > > > +struct ia32_boot_params {
> > > > > +	unsigned long size;
> > > > > +	unsigned long command_line;
> > > > > +	efi_system_table_t *efi_sys_tbl;
> > > > > +	efi_memory_desc_t *efi_mem_map;
> > > > > +	unsigned long efi_mem_map_size;
> > > > > +	unsigned long efi_mem_desc_size;	
> > > > > +	unsigned long efi_mem_desc_version;
> > > > > +	unsigned long initrd_start;
> > > > > +	unsigned long initrd_size;
> > > > > +	unsigned long loader_start;	
> > > > > +	unsigned long loader_size;
> > > > > +	unsigned long kernel_start;
> > > > > +	unsigned long kenrel_size;
> > > > > +	unsigned long num_cols;
> > > > > +	unsigned long num_rows;
> > > > > +	unsigned long orig_x;
> > > > > +	unsigned long orig_y;
> > > > > +};
> > > > 
> > > > Interesting.  What's all this, and how does the user interact with it?
> > > 
> > > It's the boot parameters that the EFI linux boot loader (ELILO) passes to
> the
> 
> > > kernel.  It's only used in the early boot process.
> > 
> > Hmm.  You have added additional parameters passed to the kernel, but
> > have not updated the documentation.  Nor have you bumped the protocol
> > number in setup.S. 
> 
> Bumping the boot protocal in setup.S doesn't make sence as this new boot
> protocal is only possible under EFI platforms.  Legacy BIOS platform
> boot up processing shouldn't know anything about it.  Its ment to be
> orthoganal to the older boot protocal.

Bumping the minor revision indicates new features are present.
You added new features therefore the minor rev needs to be bumped.

> This being said, some EFI boot protocall documentation could be cut and
> pasted out of the OLS talk into a new file the Documentation directory.
> 
> > 
> > Beyond that you have duplicated a bunch of variables that already have
> > perfectly valid ways of being passed to the kernel.
> 
> Actualy this is a step in getting away from those legacy boot
> parrameters scattered about the boot parrameter block for the EFI boot
> up processing.  
> 
> The worst thing about continuing to use the legacy boot parrameters is
> that we then need to go hunting for holes in the existing structure
> where we can put the new EFI specific values as well as ending up
> carrying along baggage that dates way WAY back that doesn't get used or
> make sence any more.

The joy of x86.  And no you don't need to look for holes all you need to
do is to append to the end.

> > initrd_start, initrd_size, num_cols, num_rows, orig_x, orig_y and the
> > command line should be passed in their original locations.  At least
> > baring the creation of a subarch and starting from scratch.  
> > 
> 
> We are hoping to avoid doing a subarch with this boot parrameter design
> and went for a coexistance approach that has zero impact to the current
> booting up on legacy platforms.  

Which is a reasonable way to go.
 
> I think this is THE key issue to get to the bottom of.  EFI enabled
> kernels need not be a new sub-architecture, as we can see that the EFI
> start up design supports booting on legacy firmware/bios, and has zero
> impact on execution flow for the legacy case.  Do you think that doing a
> sub architecture is really needed for this?

If you want a clean slate a sub arch looks necessary.  If you want to 
coexist with the legacy you need to put of with the issues of being
compatible.

But realize you will also want to know you started from efi even if
you were loaded in pcbios compatibility mode with lilo or grub.  So
this is not a boolean kind of thing EFI or no EFI.  It is does my BIOS
have the EFI features.  At least on x86.  And at that point you
probably want EFI detection in Setup.S.

> > kernel_start, and kernel_size are not used.
> > loader_start, and loader_size are not used.
> > 
> 
> They are anticipated to be useful for embedded designs booting linux on
> EFI firmwware.  They could be removed but I'd rather see them stay.

Except when you are directly loading vmlinux you don't have the information
to populate kernel_start and kernel_size properly.  And at that point
you are missing other interesting parts of the kernel.  Like which
boot protocol it supports.

The x86 boot protocol is crusty and has plenty of warts but it works.
Just having a length and no version number or any other way to detect
features is worse, and that is what you are proposing in the EFI case.

Things change and evolve.  So far I know of two distinct versions of
EFI.  The EFI that has been so nicely described by Mark Doran.  And
the version I have actually used with is quite a different animal.


Eric

