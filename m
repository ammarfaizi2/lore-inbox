Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261620AbTIBUDT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 16:03:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262085AbTIBUDT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 16:03:19 -0400
Received: from hermes.py.intel.com ([146.152.216.3]:17393 "EHLO
	hermes.py.intel.com") by vger.kernel.org with ESMTP id S261620AbTIBUCo convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 16:02:44 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: RE: [UPDATED PATCH] EFI support for ia32 kernels
Date: Tue, 2 Sep 2003 13:02:33 -0700
Message-ID: <D36CE1FCEFD3524B81CA12C6FE5BCAB002FFE677@fmsmsx406.fm.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [UPDATED PATCH] EFI support for ia32 kernels
Thread-Index: AcNuf891xBTjHfNtSy603vyeUJOCjQDBQZsg
From: "Tolentino, Matthew E" <matthew.e.tolentino@intel.com>
To: "Andrew Morton" <akpm@osdl.org>,
       "Matt Tolentino" <metolent@snoqualmie.dp.intel.com>
Cc: <linux-kernel@vger.kernel.org>, <torvalds@osdl.org>
X-OriginalArrivalTime: 02 Sep 2003 20:02:33.0719 (UTC) FILETIME=[25EE0870:01C3718D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Just for my edification: why does EFI exist?  
> 
>   "The EFI specification defines a new model for the interface between
>    operating systems and platform firmware.  The interface 
> consists of data
>    tables that contain platform-related information, plus 
> boot and runtime
>    service calls that are available to the operating system 
> and its loader.
>     Together, these provide a standard environment for 
> booting an operating
>    system and running pre-boot applications.
> 
>   "The EFI specification is primarily intended for the next generation
>    of IA-32 and Itanium Architecture-based computers, and is 
> an outgrowth
>    of the "Intel Boot Initiative" (IBI) program that began in 1998."
> 
> It sounds like it's filling in some gaps in ACPI?  What is 
> its relationship to ACPI?

Not really.  EFI is a broader interface to platform firmware and the hardware that has been designed to be generic, such that it may be implemented on any architecture and/or any platform.  You can think of it as an interface to the traditional BIOS.  In a pure EFI environment, the device model, various defined services and protocols, and structure negate the need for traditional BIOS calls.  For example, you would no longer call int10h to change the video modes - instead you would call a function of a video/console protocol for the video device.  Another example is the int15h call to get the e820 memory map is no longer required - instead EFI provides a memory map of all usable memory in the system, along with attributes, ranges, types, etc.  

As for its relationship to ACPI it is complementary.  The EFI specification does not rewrite or redefine accepted standards such as ACPI.  Instead it enables this type of platform configuration information to be obtained in a standard fashion.  

> Well, having now learnt that this is in fact not electronic 
> fuel injection,
> let me give some feedback from the point of view of an 
> experienced kernel
> developer who wants to understand it - exactly the target audience for
> those who wish to develop maintainable code, yes?

Indeed.  It's funny that you mention that...  It's funny to see ubiquitous acronyms (slapped on so many vehicles) reused like this  ;-)

> Mainly I am reduced to picking over trivia...  Excuse me 
> while I ask some
> dumb questions as well.

I'm just glad someone bit!  
 
> pleeeze never declare things in .c files.  Put this 
> declaration into efi.h
> so the same declaration is visible to the users as well as 
> the definition.

Gotcha.  I'll fix this up...
 
> > +static int efi_pte = 0;
> > +static unsigned long efi_temp_page_table[1024]
> > +    __attribute__ ((aligned(4096))) __initdata ;
> 
> We have two early ioremap-style functions already.  Are they 
> not suitable
> for accessing the EFI tables?

I'm looking at that now...   
 
> > +extern pgd_t swapper_pg_dir[1024];
> 
> This should be in a header.

Indeed.  Hopefully once converted to use the early ioremap mechanism this won't even be needed!
 
> 
> > +void efi_gettimeofday(struct timespec *tv)
> > +{
> > +	efi_time_t tm;
> > +
> > +	memset(tv, 0, sizeof(tv));
> 
> buglet: sizeof(*tv)

Ouch, thanks.

> > +/*
> > + * Walks the EFI memory map and calls CALLBACK once for each EFI
> > + * memory descriptor that has memory that is available for 
> kernel use.
> > + */
> > +void efi_memmap_walk(efi_freemem_callback_t callback, void *arg)
> > +{
> > +	int prev_valid = 0;
> > +	struct range {
> > +		unsigned long start;
> > +		unsigned long end;
> > +	} prev, curr;
> > +	efi_memory_desc_t *md;
> > +	unsigned long start, end;
> > +	int i;
> > +
> > +	for (i = 0; i < memmap.nr_map; i++) {
> > +		md = &memmap.map[i];
> > +
> > +		if (md->num_pages == 0)	/* no pages means 
> nothing to do... */
> > +			continue;
> > +		if (is_available_memory(md)) {
> > +			curr.start = md->phys_addr;
> > +			curr.end = curr.start + 
> > +					(md->num_pages << 
> EFI_PAGE_SHIFT);
> > +
> > +			if (!prev_valid) {
> > +				prev = curr;
> > +				prev_valid = 1;
> > +			} else {
> > +				if (curr.start < prev.start)
> > +					printk(PFX "Unordered 
> memory map\n");
> > +				if (prev.end == curr.start)
> > +					prev.end = curr.end;
> > +				else {
> > +					start =
> > +					    (unsigned long) 
> (PAGE_ALIGN(prev.start));
> > +					end = (unsigned long) 
> (prev.end & PAGE_MASK);
> > +					if ((end > start)
> > +					    && (*callback) 
> (start, end, arg) < 0)
> > +						return;
> > +					prev = curr;
> > +				}
> > +			}
> > +		} else
> > +			continue;
> > +	}
> 
> The final `continue' here isn't needed.  Would be neater to do
> 
> 	if (!is_available_memory(md))
> 		continue;
> 	curr.start = md->phys_addr;
> 	curr.end = curr.start + (md->num_pages << EFI_PAGE_SHIFT);
> 	...

Sounds good...thanks!
 
> > +
> > +/*
> > + * mem_start is a physical address.
> > + */
> > +unsigned long __init 
> > +efi_setup_temp_page_table(unsigned long mem_start, 
> unsigned long size)
> > +{
> 
> Again, there's an awful lot of pagetable bashing here.  We do 
> need to work
> out whether it is all really needed, or whether there are 
> consolidation
> opportunities with existing code.

Indeed.  Like I said above, I'm looking at nuking this...
 
> > +
> > +void __init efi_enter_virtual_mode(void)
> > +{
> > +	int i;
> > +	efi_memory_desc_t *md;
> > +	efi_status_t status;
> > +
> > +	memmap.map = ioremap((unsigned long) memmap.phys_map, 
> EFI_MEMMAP_SIZE);
> 
> Now what is this function doing?  I guess the reader should 
> be familiar
> with the EFI spec, but some decriptive roadmap-style 
> commentary over key
> data structures such as `struct efi_memory_map' would make 
> this code much
> more approachable by occasional readers.

Ok, I'll be sure to add more comments!  And you're right, this is in the EFI spec, but briefly....

EFI operates in a flat, physical addressing mode.  So in order to call any of the EFI runtime services (get_time, set_time, reset_system, etc.) without having to thunk back into physical mode, we can call EFI set_virtual_address_space() after ioremapping the regions in the memory map that have the runtime attribute set (indicating that the region contains something that can be called during OS runtime).  This call will "fix up" the EFI runtime services such that we can now call them in virtual mode.  This code was stolen from the ia64 tree...    
  
 
> > --- linux-2.6.0-test4/arch/i386/kernel/Makefile	
> 2003-08-22 16:52:57.000000000 -0700
> > +++ linux-2.6.0-test4-efi/arch/i386/kernel/Makefile	
> 2003-08-28 16:05:49.000000000 -0700
> > @@ -7,7 +7,7 @@
> >  obj-y	:= process.o semaphore.o signal.o entry.o 
> traps.o irq.o vm86.o \
> >  		ptrace.o i8259.o ioport.o ldt.o setup.o time.o 
> sys_i386.o \
> >  		pci-dma.o i386_ksyms.o i387.o dmi_scan.o bootflag.o \
> > -		doublefault.o
> > +		doublefault.o efi.o efi_stub.o
> 
> Doesn't this mean we're linking all the EFI code even if 
> CONFIG_ACPI_EFI=n?

Arrrr.  The config options need some work.  

> >  #ifdef CONFIG_BLK_DEV_INITRD
> > -	if (LOADER_TYPE && INITRD_START) {
> > -		if (INITRD_START + INITRD_SIZE <= (max_low_pfn 
> << PAGE_SHIFT)) {
> > -			reserve_bootmem(INITRD_START, INITRD_SIZE);
> > -			initrd_start =
> > -				INITRD_START ? INITRD_START + 
> PAGE_OFFSET : 0;
> > -			initrd_end = initrd_start+INITRD_SIZE;
> > -		}
> > -		else {
> > -			printk(KERN_ERR "initrd extends beyond 
> end of memory "
> > -			    "(0x%08lx > 0x%08lx)\ndisabling initrd\n",
> > -			    INITRD_START + INITRD_SIZE,
> > -			    max_low_pfn << PAGE_SHIFT);
> > -			initrd_start = 0;
> > +	if (efi_enabled) {
> > +		if (efi_boot_params.initrd_start) {
> > +			if (efi_boot_params.initrd_start + 
> efi_boot_params.initrd_size <= (max_low_pfn << PAGE_SHIFT)) {
> > +				
> reserve_bootmem(efi_boot_params.initrd_start, 
> efi_boot_params.initrd_size);
> > +				initrd_start = 
> efi_boot_params.initrd_start + PAGE_OFFSET;
> > +				initrd_end = initrd_start + 
> efi_boot_params.initrd_size;
> > +			} else {
> > +				printk(KERN_ERR "initrd extends 
> beyond end of memory! "
> > +						"(0x%08lx > 
> 0x%08lx)\n disabling initrd\n",
> > +						
> efi_boot_params.initrd_start + efi_boot_params.initrd_size,
> > +						max_low_pfn << 
> PAGE_SHIFT);
> > +				initrd_start = 0;
> > +			}
> > +		}
> 
> What is the relationship between EFI and initrd?

I'm not sure what you mean here.  Nothing really, except that the loader passes the location of the initrd to the kernel, even though the loader is currently putting where the kernel expects it.  However, in the future this may allow the initrd to be placed somewhere else.

> > @@ -817,11 +912,26 @@
> >  			 *  so we try it repeatedly and let the 
> resource manager
> >  			 *  test it.
> >  			 */
> > -			request_resource(res, &code_resource);
> > -			request_resource(res, &data_resource);
> > +			request_resource(res, code_resource);
> > +			request_resource(res, data_resource);
> 
> hm, request_resource() can fail...

So, is there a reason there hasn't been a check here before?

> > +/*
> > + * This is called before the RT mappings are in place, so we
> > + * need to be able to get the time in physical mode.
> > + */
> > +unsigned long efi_get_time(void)
> 
> What is an "RT mapping"?

Sorry, runtime mapping - meaning that the code to make the call in physical mode is needed before the call to EFI's set_virtual_address_space() is made.  

> >  config ACPI_EFI
> > -	bool
> > -	depends on ACPI
> > -	depends on IA64
> > +	bool "Obtain RSDP from EFI Configuration Table"
> > +	depends on IA64 && (!IA64_HP_SIM || IA64_SGI_SN) || X86 && ACPI
> > +	help
> > +	   On EFI Systems the RSDP pointer is passed to the kernel via
> > +	   the EFI Configuration Table.  On Itanium systems this is 
> > +	   standard and required.  For IA-32, systems that have
> > +	   EFI firmware should leave this enabled.  Platforms with 
> > +	   traditional legacy BIOS should disable this option.
> 
> Poor users ;)
> 
> Vendors will ship kernels with CONFIG_ACPI_EFI=y.  I assume 
> those kernels
> will work OK on machines which have legacy BIOSes?

This is more a matter of how the RSDP is obtained.  On EFI systems, this is passed to the kernel via the EFI Configuration Table.  So, we can look there, instead of scanning memory.  However, if the kernel doesn't detect that it was loaded from EFI (i.e. no efi boot parameters), then the code this enables won't even be executed.  


> > +struct ia32_boot_params {
> > +	unsigned long size;
> > +	unsigned long command_line;
> > +	efi_system_table_t *efi_sys_tbl;
> > +	efi_memory_desc_t *efi_mem_map;
> > +	unsigned long efi_mem_map_size;
> > +	unsigned long efi_mem_desc_size;	
> > +	unsigned long efi_mem_desc_version;
> > +	unsigned long initrd_start;
> > +	unsigned long initrd_size;
> > +	unsigned long loader_start;	
> > +	unsigned long loader_size;
> > +	unsigned long kernel_start;
> > +	unsigned long kenrel_size;
> > +	unsigned long num_cols;
> > +	unsigned long num_rows;
> > +	unsigned long orig_x;
> > +	unsigned long orig_y;
> > +};
> 
> Interesting.  What's all this, and how does the user interact with it?

It's the boot parameters that the EFI linux boot loader (ELILO) passes to the kernel.  It's only used in the early boot process.  
 
> > diff -urN linux-2.6.0-test4/include/linux/efi.h 
> linux-2.6.0-test4-efi/include/linux/efi.h
> > --- linux-2.6.0-test4/include/linux/efi.h	2003-08-22 
> 17:00:39.000000000 -0700
> > +++ linux-2.6.0-test4-efi/include/linux/efi.h	
> 2003-08-28 16:49:01.000000000 -0700
> > @@ -16,6 +16,8 @@
> >  #include <linux/time.h>
> >  #include <linux/types.h>
> >  #include <linux/proc_fs.h>
> > +#include <linux/rtc.h>
> > +#include <linux/ioport.h>
> >  
> >  #include <asm/page.h>
> >  #include <asm/system.h>
> > @@ -96,6 +98,9 @@
> >  	u64 virt_addr;
> >  	u64 num_pages;
> >  	u64 attribute;
> > +#if defined (__i386__)
> > +	u64 pad1;
> > +#endif
> >  } efi_memory_desc_t;
> 
> Obscure things like this rather need a comment.

Yes, indeed.  Comment to be added shortly...

thanks,
matt
