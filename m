Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751359AbVKIJ4d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751359AbVKIJ4d (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 04:56:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751360AbVKIJ4c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 04:56:32 -0500
Received: from duempel.org ([81.209.165.42]:61834 "HELO duempel.org")
	by vger.kernel.org with SMTP id S1751359AbVKIJ4c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 04:56:32 -0500
Date: Wed, 9 Nov 2005 10:53:43 +0100
From: Max Kellermann <max@duempel.org>
To: rick@vanrein.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] BadRAM for 2.6.14
Message-ID: <20051109095343.GA17048@roonstrasse.net>
Mail-Followup-To: rick@vanrein.org, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="PNTmBPCT7hxwcZjr"
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Rick,

I have ported your BadRAM patch to the new kernel 2.6.14.  There were
a few tiny formal corrections due to patch conflicts; besides that, I
did not change anything.

To linux-kernel: is there a reason why this patch was never added to
Linus' tree?  It helped me save money more than once.

Max


--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="badram-mk-2.6.14.patch"

diff -urN linux-2.6.14-orig/Documentation/badram.txt linux-2.6.14/Documentation/badram.txt
--- linux-2.6.14-orig/Documentation/badram.txt	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.14/Documentation/badram.txt	2005-11-09 10:06:11.401290000 +0100
@@ -0,0 +1,266 @@
+INFORMATION ON USING BAD RAM MODULES
+====================================
+
+Introduction
+	RAM is getting smaller and smaller, and as a result, also more and more
+	vulnerable. This makes the manufacturing of hardware more expensive,
+	since an excessive amount of RAM chips must be discarded on account of
+	a single cell that is wrong. Similarly, static discharge may damage a
+	RAM module forever, which is usually remedied by replacing it
+	entirely.
+
+	This is not necessary, as the BadRAM code shows: By informing the Linux
+	kernel which addresses in a RAM are damaged, the kernel simply avoids
+	ever allocating such addresses but makes all the rest available.
+
+Reasons for this feature
+	There are many reasons why this kernel feature is useful:
+	- Chip manufacture is resource intensive; waste less and sleep better
+	- It's another chance to promote Linux as "the flexible OS"
+	- Some laptops have their RAM soldered in... and then it fails!
+	- It's plain cool ;-)
+
+Running example
+	To run this project, I was given two DIMMs, 32 MB each. One, that we
+	shall use as a running example in this text, contained 512 faulty bits,
+	spread over 1/4 of the address range in a regular pattern. Some tricks
+	with a RAM tester and a few binary calculations were sufficient to
+	write these faults down in 2 longword numbers.
+
+	The kernel recognised the correct number of pages with faults and did
+	not give them out for allocation. The allocation routines could
+	therefore progress as normally, without any adaption.
+	So, I gained 30 MB of DIMM which would otherwise have been thrown
+	away. After booting the kernel, the kernel behaved exactly as it
+	always had.
+
+Initial checks
+	If you experience RAM trouble, first read /usr/src/linux/memory.txt
+	and try out the mem=4M trick to see if at least some initial parts
+	of your RAM work well. The BadRAM routines halt the kernel in panic
+	if the reserved area of memory (containing kernel stuff) contains
+	a faulty address.
+
+Running a RAM checker
+	The memory checker is not built into the kernel, to avoid delays at
+	runtime. If you experience problems that may be caused by RAM, run
+	a good RAM checker, such as
+		http://reality.sgi.com/cbrady_denver/memtest86
+	The output of a RAM checker provides addresses that went wrong. In
+	the 32 MB chip with 512 faulty bits mentioned above, the errors were
+	found in the 8MB-16MB range (the DIMM was in slot #0) at addresses
+		xxx42f4
+		xxx62f4
+		xxxc2f4
+		xxxe2f4
+	and the error was a "sticky 1 bit", a memory bit that stayed "1" no
+	matter what was written to it. The regularity of this pattern
+	suggests the death of a buffer at the output stages of a row on one of
+	the chips. I expect such regularity to be commonplace. Finding this
+	regularity currently is human effort, but it should not be hard to
+	alter a RAM checker to capture it in some sort of pattern, possibly
+	the BadRAM patterns described below.
+
+	By the way, if you manage to get hold of memtest86 version 2.3 or
+	beyond, you can configure the printing mode to produce BadRAM patterns,
+	which find out exactly what you must enter on the LILO: commandline,
+	except that you shouldn't mention the added spacing. That means that
+	you can skip the following step, which saves you a *lot* of work.
+
+	Also by the way, if your machine has the ISA memory gap in the 15M-16M
+	range unstoppable, Linux can get in trouble. One way of handling that
+	situation is by specifying the total memory size to Linux with a boot
+	parameter mem=... and then to tell it to treat the 15M-16M range as
+	faulty with an additional boot parameter, for instance:
+		mem=24M badram=0x00f00000,0xfff00000
+	if you installed 24MB of RAM in total.
+
+Capturing errors in a pattern
+	Instead of manually providing all 512 errors to the kernel, it's nicer
+	to generate a pattern. Since the regularity is based on address decoding
+	software, which generally takes certain bits into account and ignores
+	others, we shall provide a faulty address F, together with a bit mask M
+	that specifies which bits must be equal to F. In C code, an address A
+	is faulty if and only if
+		(F & M) == (A & M)
+	or alternately (closer to a hardware implementation):
+		~((F ^ A) & M)
+	In the example 32 MB chip, we had the faulty addresses in 8MB-16MB:
+		xxx42f4		....0100....
+		xxx62f4		....0110....
+		xxxc2f4		....1100....
+		xxxe2f4		....1110....
+	The second column represents the alternating hex digit in binary form.
+	Apperantly, the first and one-but last binary digit can be anything,
+	so the binary mask for that part is 0101. The mask for the part after
+	this is 0xfff, and the part before should select anything in the range
+	8MB-16MB, or 0x00800000-0x01000000; this is done with a bitmask
+	0xff80xxxx. Combining these partial masks, we get:
+		F=0x008042f4    M=0xff805fff
+	That covers everything for this DIMM; for more complicated failing
+	DIMMs, or for a combination of multiple failing DIMMs, it can be
+	necessary to set up a number of such F/M pairs.
+
+Rebooting Linux
+	Now that these patterns are known (and double-checked, the calculations
+	are highly error-prone... it would be neat to test them in the RAM
+	checker...) we simply restart Linux with these F/M pairs as a parameter.
+	If you normally boot as follows:
+	       LILO: linux
+	you should now boot with
+	       LILO: linux badram=0x008042f4,0xff805fff
+	or perhaps by mentioning more F/M pairs in an order F0,M0,F1,M1,...
+	When you provide an odd number of arguments to badram, the default mask
+	0xffffffff (only one address matched) is applied to the pattern.
+
+	Beware of the commandline length. At least up to LILO version 0.21,
+	the commandline is cut off after the 78th character; later versions
+	may go as far as the kernel goes, namely 255 characters. In no way is
+	it possible to enter more than 10 numbers to the badram boot option.
+
+	When the kernel now boots, it should not give any trouble with RAM.
+	Mind you, this is under the assumption that the kernel and its data
+	storage do not overlap an erroneous part. If this happens, and the
+	kernel does not choke on it right away, it will stop with a panic.
+	You will need to provide a RAM where the initial, say 2MB, is faultless.
+
+	Now look up your memory status with
+	       dmesg | grep ^Memory:
+	which prints a single line with information like
+		Memory: 158524k/163840k available
+			(940k kernel code,
+			412k reserved,
+			1856k data,
+			60k init,
+			0k highmem,
+			2048k BadRAM)
+	The latter entry, the badram, is 2048k to represent the loss of 2MB
+	of general purpose RAM due to the errors. Or, positively rephrased,
+	instead of throwing out 32MB as useless, you only throw out 2MB.
+
+	If the system is stable (try compiling a few kernels, and do a few
+	finds in / or so) you may add the boot parameter to /etc/lilo.conf
+	as a line to _all_ the kernels that handle this trouble with a line
+		append="badram=0x008042f4,0xff805fff"
+	after which you run "lilo".
+	Warning: Don't experiment with these settings on your only boot image.
+	If the BadRAM overlays kernel code, data, init, or other reserved
+	memory, the kernel will halt in panic. Try settings on a test boot
+	image first, and if you get a panic you should change the order of
+	your DIMMs [which may involve buying a new one just to be able to
+	change the order].
+
+	You are allowed to enter any number of BadRAM patterns in all the
+	places documented in this file. They will all apply. It is even
+	possible to mention several BadRAM patterns in a single place. The
+	completion of an odd number of arguments with the default mask is
+	done separately for each badram=... option.
+
+Kernel Customisation
+	Some people prefer to enter their badram patterns in the kernel, and
+	this is also possible. In mm/page_alloc.c there is an array of unsigned
+	long integers into which the parameters can be entered, prefixed with
+	the number of integers (twice the number of patterns). The array is
+	named badram_custom and it will be added to the BadRAM list whenever an
+	option 'badram' is provided on the commandline when booting, either
+	with or without additional patterns.
+
+	For the previous example, the code would become
+
+	static unsigned long __initdata badram_custom[] = {
+		2,	// Number of longwords that follow, as F/M pairs
+		0x008042f4L, 0xff805fffL,
+	};
+
+	Even on this place you may assume the default mask to be filled in
+	when you enter an odd number of longwords. Specify the number of
+	longwords to be 0 to avoid influence of this custom BadRAM list.
+
+BadRAM classification
+	This technique may start a lively market for "dead" RAM. It is important
+	to realise that some RAMs are more dead than others. So, instead of
+	just providing a RAM size, it is also important to know the BadRAM
+	class, which is defined as follows:
+
+		A BadRAM class N means that at most 2^N bytes have a problem,
+		and that all problems with the RAMs are persistent: They
+		are predictable and always show up.
+
+	The DIMM that serves as an example here was of class 9, since 512=2^9
+	errors were found. Higher classes are worse, "correct" RAM is of class
+	-1 (or even less, at your choice).
+	Class N also means that the bitmask for your chip (if there's just one,
+	that is) counts N bits "0" and it means that (if no faults fall in the
+	same page) an amount of 2^N*PAGESIZE memory is lost, in the example on
+	an i386 architecture that would be 2^9*4k=2MB, which accounts for the
+	initial claim of 30MB RAM gained with this DIMM.
+
+	Note that this scheme has deliberately been defined to be independent
+	of memory technology and of computer architecture.
+
+Known Bugs
+	LILO is known to cut off commandlines which are too long. For the
+	lilo-0.21 distribution, a commandline may not exceed 78 characters,
+	while actually, 255 would be possible [on i386, kernel 2.2.16].
+	LILO does _not_ report too-long commandlines, but the error will
+	show up as either a panic at boot time, stating
+		panic: BadRAM page in initial area
+	or the dmesg line starting with Memory: will mention an unpredicted
+	number of kilobytes. (Note that the latter number only includes
+	errors in accessed memory.)
+
+Future Possibilities
+	It would be possible to use even more of the faulty RAMs by employing
+	them for slabs. The smaller allocation granularity of slabs makes it
+	possible to throw out just, say, 32 bytes surrounding an error. This
+	would mean that the example DIMM only looses 16kB instead of 2MB.
+	It might even be possible to allocate the slabs in such a way that,
+	where possible, the remaining bytes in a slab structure are allocated
+	around the error, reducing the RAM loss to 0 in the optimal situation!
+
+	However, this yield is somewhat faked: It is possible to provide 512
+	pages of 32-byte slabs, but it is not certain that anyone would use
+	that many 32-byte slabs at any time.
+
+	A better solution might be to alter the page allocation for a slab to
+	have a preference for BadRAM pages, and given those a special treatment.
+	This way, the BadRAM would be spread over all the slabs, which seems
+	more likely to be a `true' pay-off. This would yield more overhead at
+	slab allocation time, but on the other hand, by the nature of slabs,
+	such allocations are made as rare as possible, so it might not matter
+	that much. I am uncertain where to go.
+
+	Many suggestions have been made to insert a RAM checker at boot time;
+	since this would leave the time to do only very meager checking, it
+	is not a reasonable option; we already have a BIOS doing that in most
+	systems!
+
+	It would be interesting to integrate this functionality with the
+	self-verifying nature of ECC RAM. These memories can even distinguish
+	between recorable and unrecoverable errors! Such memory has been
+	handled in older operating systems by `testing' once-failed memory
+	blocks for a while, by placing only (reloadable) program code in it.
+	Unfortunately, I possess no faulty ECC modules to work this out.
+
+Names and Places
+	The home page of this project is on
+		http://rick.vanrein.org/linux/badram
+	This page also links to Nico Schmoigl's experimental extensions to
+	this patch (with debugging and a few other fancy things).
+
+	In case you have experiences with the BadRAM software which differ from
+	the test reportings on that site, I hope you will mail me with that
+	new information.
+
+	The BadRAM project is an idea and implementation by
+		Rick van Rein
+		Binnenes 67
+		9407 CX Assen
+		The Netherlands
+		rick@vanrein.org
+	If you like it, a postcard would be much appreciated ;-)
+
+
+							       Enjoy,
+								-Rick.
+
diff -urN linux-2.6.14-orig/Documentation/kernel-parameters.txt linux-2.6.14/Documentation/kernel-parameters.txt
--- linux-2.6.14-orig/Documentation/kernel-parameters.txt	2005-11-09 10:12:34.013201750 +0100
+++ linux-2.6.14/Documentation/kernel-parameters.txt	2005-11-09 10:06:11.405290250 +0100
@@ -26,6 +26,7 @@
 	APIC	APIC support is enabled.
 	APM	Advanced Power Management support is enabled.
 	AX25	Appropriate AX.25 support is enabled.
+	BADRAM  Support for faulty RAM chips is enabled.
 	CD	Appropriate CD support is enabled.
 	DEVFS	devfs support is enabled.
 	DRM	Direct Rendering Management support is enabled.
@@ -271,6 +272,8 @@
 	aztcd=		[HW,CD] Aztech CD268 CDROM driver
 			Format: <io>,0x79 (?)
 
+	badram=		[BADRAM] Avoid allocating faulty RAM addresses.
+
 	baycom_epp=	[HW,AX25]
 			Format: <io>,<mode>
 
diff -urN linux-2.6.14-orig/Documentation/memory.txt linux-2.6.14/Documentation/memory.txt
--- linux-2.6.14-orig/Documentation/memory.txt	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14/Documentation/memory.txt	2005-11-09 10:06:11.405290250 +0100
@@ -18,6 +18,14 @@
 	   as you add more memory.  Consider exchanging your 
            motherboard.
 
+	4) A static discharge or production fault causes a RAM module
+	   to have (predictable) errors, usually meaning that certain
+	   bits cannot be set or reset. Instead of throwing away your
+	   RAM module, you may read /usr/src/linux/Documentation/badram.txt
+	   to learn how to detect, locate and circuimvent such errors
+	   in your RAM module.
+
+
 All of these problems can be addressed with the "mem=XXXM" boot option
 (where XXX is the size of RAM to use in megabytes).  
 It can also tell Linux to use less memory than is actually installed.
@@ -49,6 +57,8 @@
 	  Linux to using a very small amount of memory. Use "memmap="-option
 	  together with "mem=" on systems with PCI to avoid physical address
 	  space collisions.
+	  If this helps, read Documentation/badram.txt to learn how to
+	  find and circumvent memory errors.
 
 
 Other tricks:
diff -urN linux-2.6.14-orig/arch/i386/Kconfig linux-2.6.14/arch/i386/Kconfig
--- linux-2.6.14-orig/arch/i386/Kconfig	2005-11-09 10:12:34.153210500 +0100
+++ linux-2.6.14/arch/i386/Kconfig	2005-11-09 10:06:11.397289750 +0100
@@ -756,6 +756,23 @@
 	depends on HIGHMEM64G
 	default y
 
+config BADRAM
+	bool "Work around bad spots in RAM"
+	default y
+	help
+	  This small kernel extension makes it possible to use memory chips
+	  which are not entirely correct. It works by never allocating the
+	  places that are wrong. Those places are specified with the badram
+	  boot option to LILO. Read Documentation/badram.txt and/or visit
+	  http://home.zonnet.nl/vanrein/badram for information.
+
+	  This option co-operates well with a second boot option from LILO
+	  that starts memtest86, which is able to automatically produce the
+	  patterns for the commandline in case of memory trouble.
+
+	  It is safe to say 'Y' here, and it is advised because there is no
+	  performance impact.
+
 # Common NUMA Features
 config NUMA
 	bool "Numa Memory Allocation and Scheduler Support"
diff -urN linux-2.6.14-orig/arch/i386/defconfig linux-2.6.14/arch/i386/defconfig
--- linux-2.6.14-orig/arch/i386/defconfig	2005-11-09 10:12:34.157210750 +0100
+++ linux-2.6.14/arch/i386/defconfig	2005-11-09 10:06:11.393289500 +0100
@@ -114,6 +114,7 @@
 CONFIG_NOHIGHMEM=y
 # CONFIG_HIGHMEM4G is not set
 # CONFIG_HIGHMEM64G is not set
+CONFIG_BADRAM=y
 # CONFIG_MATH_EMULATION is not set
 CONFIG_MTRR=y
 # CONFIG_EFI is not set
diff -urN linux-2.6.14-orig/arch/i386/mm/init.c linux-2.6.14/arch/i386/mm/init.c
--- linux-2.6.14-orig/arch/i386/mm/init.c	2005-11-09 10:12:34.197213250 +0100
+++ linux-2.6.14/arch/i386/mm/init.c	2005-11-09 10:10:21.776937500 +0100
@@ -266,25 +266,38 @@
 	pkmap_page_table = pte;	
 }
 
-void __init one_highpage_init(struct page *page, int pfn, int bad_ppro)
+/**
+ * @param bad  set on return to whether the page is bad RAM
+ */
+void __init one_highpage_init(struct page *page, int pfn, int bad_ppro,
+		int *bad)
 {
+	*bad = 0;
 	if (page_is_ram(pfn) && !(bad_ppro && page_kills_ppro(pfn))) {
 		ClearPageReserved(page);
 		set_page_count(page, 1);
-		__free_page(page);
+#ifdef CONFIG_BADRAM
+		if (PageBad(page))
+			*bad = 1;
+		else
+#endif
+			__free_page(page);
 		totalhigh_pages++;
 	} else
 		SetPageReserved(page);
 }
 
 #ifdef CONFIG_NUMA
-extern void set_highmem_pages_init(int);
+extern void set_highmem_pages_init(int, *int);
 #else
-static void __init set_highmem_pages_init(int bad_ppro)
+static void __init set_highmem_pages_init(int bad_ppro, int *pbad)
 {
 	int pfn;
-	for (pfn = highstart_pfn; pfn < highend_pfn; pfn++)
-		one_highpage_init(pfn_to_page(pfn), pfn, bad_ppro);
+	int bad;
+	for (pfn = highstart_pfn; pfn < highend_pfn; pfn++) {
+		one_highpage_init(pfn_to_page(pfn), pfn, bad_ppro, &bad);
+		if (bad) *pbad++;
+	}
 	totalram_pages += totalhigh_pages;
 }
 #endif /* CONFIG_FLATMEM */
@@ -292,7 +305,7 @@
 #else
 #define kmap_init() do { } while (0)
 #define permanent_kmaps_init(pgd_base) do { } while (0)
-#define set_highmem_pages_init(bad_ppro) do { } while (0)
+#define set_highmem_pages_init(bad_ppro, pbad) do { } while (0)
 #endif /* CONFIG_HIGHMEM */
 
 unsigned long long __PAGE_KERNEL = _PAGE_KERNEL;
@@ -537,7 +550,7 @@
 void __init mem_init(void)
 {
 	extern int ppro_with_ram_bug(void);
-	int codesize, reservedpages, datasize, initsize;
+	int codesize, reservedpages, badpages, datasize, initsize;
 	int tmp;
 	int bad_ppro;
 
@@ -570,14 +583,20 @@
 	totalram_pages += free_all_bootmem();
 
 	reservedpages = 0;
-	for (tmp = 0; tmp < max_low_pfn; tmp++)
+	badpages = 0;
+	for (tmp = 0; tmp < max_low_pfn; tmp++) {
 		/*
-		 * Only count reserved RAM pages
+		 * Only count reserved and bad RAM pages
 		 */
 		if (page_is_ram(tmp) && PageReserved(pfn_to_page(tmp)))
 			reservedpages++;
+#ifdef CONFIG_BADRAM
+		if (page_is_ram(tmp) && PageBad(pfn_to_page(tmp)))
+			badpages++;
+#endif
+	}
 
-	set_highmem_pages_init(bad_ppro);
+	set_highmem_pages_init(bad_ppro, &badpages);
 
 	codesize =  (unsigned long) &_etext - (unsigned long) &_text;
 	datasize =  (unsigned long) &_edata - (unsigned long) &_etext;
@@ -587,6 +606,18 @@
 	kclist_add(&kcore_vmalloc, (void *)VMALLOC_START, 
 		   VMALLOC_END-VMALLOC_START);
 
+#ifdef CONFIG_BADRAM
+	printk(KERN_INFO "Memory: %luk/%luk available (%dk kernel code, %dk reserved, %dk data, %dk init, %ldk highmem, %dk BadRAM)\n",
+		(unsigned long) nr_free_pages() << (PAGE_SHIFT-10),
+		num_physpages << (PAGE_SHIFT-10),
+		codesize >> 10,
+		reservedpages << (PAGE_SHIFT-10),
+		datasize >> 10,
+		initsize >> 10,
+		(unsigned long) (totalhigh_pages << (PAGE_SHIFT-10)),
+		badpages << (PAGE_SHIFT-10)
+	       );
+#else
 	printk(KERN_INFO "Memory: %luk/%luk available (%dk kernel code, %dk reserved, %dk data, %dk init, %ldk highmem)\n",
 		(unsigned long) nr_free_pages() << (PAGE_SHIFT-10),
 		num_physpages << (PAGE_SHIFT-10),
@@ -596,6 +627,7 @@
 		initsize >> 10,
 		(unsigned long) (totalhigh_pages << (PAGE_SHIFT-10))
 	       );
+#endif
 
 #ifdef CONFIG_X86_PAE
 	if (!cpu_has_pae)
diff -urN linux-2.6.14-orig/arch/i386/mm/pgtable.c linux-2.6.14/arch/i386/mm/pgtable.c
--- linux-2.6.14-orig/arch/i386/mm/pgtable.c	2005-11-09 10:12:34.197213250 +0100
+++ linux-2.6.14/arch/i386/mm/pgtable.c	2005-11-09 10:10:56.363099000 +0100
@@ -24,7 +24,7 @@
 
 void show_mem(void)
 {
-	int total = 0, reserved = 0;
+	int total = 0, reserved = 0, badram = 0;
 	int shared = 0, cached = 0;
 	int highmem = 0;
 	struct page *page;
@@ -43,6 +43,10 @@
 				highmem++;
 			if (PageReserved(page))
 				reserved++;
+#ifdef CONFIG_BADRAM
+			else if (PageBad(page))
+				badram++;
+#endif
 			else if (PageSwapCache(page))
 				cached++;
 			else if (page_count(page))
@@ -52,6 +56,9 @@
 	printk(KERN_INFO "%d pages of RAM\n", total);
 	printk(KERN_INFO "%d pages of HIGHMEM\n", highmem);
 	printk(KERN_INFO "%d reserved pages\n", reserved);
+#ifdef CONFIG_BADRAM
+	printk(KERN_INFO "%d pages of BadRAM\n",badram);
+#endif
 	printk(KERN_INFO "%d pages shared\n", shared);
 	printk(KERN_INFO "%d pages swap cached\n", cached);
 
diff -urN linux-2.6.14-orig/include/asm-i386/page.h linux-2.6.14/include/asm-i386/page.h
--- linux-2.6.14-orig/include/asm-i386/page.h	2005-11-09 10:12:37.029390250 +0100
+++ linux-2.6.14/include/asm-i386/page.h	2005-11-09 10:06:11.409290500 +0100
@@ -131,6 +131,7 @@
 #define pfn_valid(pfn)		((pfn) < max_mapnr)
 #endif /* CONFIG_FLATMEM */
 #define virt_to_page(kaddr)	pfn_to_page(__pa(kaddr) >> PAGE_SHIFT)
+#define phys_to_page(x)		(mem_map + ((unsigned long)(x) >> PAGE_SHIFT))
 
 #define virt_addr_valid(kaddr)	pfn_valid(__pa(kaddr) >> PAGE_SHIFT)
 
diff -urN linux-2.6.14-orig/include/linux/page-flags.h linux-2.6.14/include/linux/page-flags.h
--- linux-2.6.14-orig/include/linux/page-flags.h	2005-11-09 10:12:37.309407750 +0100
+++ linux-2.6.14/include/linux/page-flags.h	2005-11-09 10:11:28.181087500 +0100
@@ -75,6 +75,7 @@
 #define PG_reclaim		17	/* To be reclaimed asap */
 #define PG_nosave_free		18	/* Free, should not be written */
 #define PG_uncached		19	/* Page has been mapped as uncached */
+#define PG_badram		21      /* BadRam page */
 
 /*
  * Global page accounting.  One instance per CPU.  Only unsigned longs are
@@ -162,6 +163,10 @@
 		__mod_page_state(offset, (delta));				\
 	} while (0)
 
+#define PageBad(page)		test_bit(PG_badram, &(page)->flags)
+#define PageSetBad(page)	set_bit(PG_badram, &(page)->flags)
+#define PageTestandSetBad(page)	test_and_set_bit(PG_badram, &(page)->flags)
+
 /*
  * Manipulation of page state flags
  */
diff -urN linux-2.6.14-orig/mm/bootmem.c linux-2.6.14/mm/bootmem.c
--- linux-2.6.14-orig/mm/bootmem.c	2005-11-09 10:12:37.469417750 +0100
+++ linux-2.6.14/mm/bootmem.c	2005-11-09 10:06:11.413290750 +0100
@@ -286,10 +286,12 @@
 	pfn = bdata->node_boot_start >> PAGE_SHIFT;
 	idx = bdata->node_low_pfn - (bdata->node_boot_start >> PAGE_SHIFT);
 	map = bdata->node_bootmem_map;
+#ifndef CONFIG_BADRAM /* no idea if this is really needed */
 	/* Check physaddr is O(LOG2(BITS_PER_LONG)) page aligned */
 	if (bdata->node_boot_start == 0 ||
 	    ffs(bdata->node_boot_start) - PAGE_SHIFT > ffs(BITS_PER_LONG))
 		gofast = 1;
+#endif
 	for (i = 0; i < idx; ) {
 		unsigned long v = ~map[i / BITS_PER_LONG];
 
@@ -317,8 +319,13 @@
 				if (v & m) {
 					count++;
 					__ClearPageReserved(page);
-					set_page_refs(page, 0);
-					__free_page(page);
+#ifdef CONFIG_BADRAM
+					if (!PageBad(page))
+#endif
+					{
+						set_page_count(page, 1);
+						__free_page(page);
+					}
 				}
 			}
 		} else {
@@ -337,8 +344,13 @@
 	for (i = 0; i < ((bdata->node_low_pfn-(bdata->node_boot_start >> PAGE_SHIFT))/8 + PAGE_SIZE-1)/PAGE_SIZE; i++,page++) {
 		count++;
 		__ClearPageReserved(page);
-		set_page_count(page, 1);
-		__free_page(page);
+#ifdef CONFIG_BADRAM
+		if (!PageBad(page))
+#endif
+		{
+			set_page_count(page, 1);
+			__free_page(page);
+		}
 	}
 	total += count;
 	bdata->node_bootmem_map = NULL;
diff -urN linux-2.6.14-orig/mm/page_alloc.c linux-2.6.14/mm/page_alloc.c
--- linux-2.6.14-orig/mm/page_alloc.c	2005-11-09 10:12:37.477418250 +0100
+++ linux-2.6.14/mm/page_alloc.c	2005-11-09 10:06:11.417291000 +0100
@@ -10,6 +10,7 @@
  *  Reshaped it to be a zoned allocator, Ingo Molnar, Red Hat, 1999
  *  Discontiguous memory support, Kanoj Sarcar, SGI, Nov 1999
  *  Zone balancing, Kanoj Sarcar, SGI, Jan 2000
+ *  BadRAM handling, Rick van Rein, Feb 2001
  *  Per cpu hot/cold page lists, bulk allocation, Martin J. Bligh, Sept 2002
  *          (lots of bits borrowed from Ingo Molnar & Andrew Morton)
  */
@@ -2569,3 +2570,94 @@
 
 	return table;
 }
+
+#ifdef CONFIG_BADRAM
+
+/* Given a pointed-at address and a mask, increment the page so that the
+ * mask hides the increment. Return 0 if no increment is possible.
+ */
+static int __init next_masked_address (unsigned long *addrp, unsigned long mask)
+{
+	unsigned long inc=1;
+	unsigned long newval = *addrp;
+	while (inc & mask)
+		inc += inc;
+	while (inc != 0) {
+		newval += inc;
+		newval &= ~mask;
+		newval |= ((*addrp) & mask);
+		if (newval > *addrp) {
+			*addrp = newval;
+			return 1;
+		}
+		do {
+			inc += inc;
+		} while (inc & ~mask);
+		while (inc & mask)
+			inc += inc;
+	}
+	return 0;
+}
+
+
+void __init badram_markpages (int argc, unsigned long *argv) {
+	unsigned long addr, mask;
+	while (argc-- > 0) {
+		addr = *argv++;
+		mask = (argc-- > 0) ? *argv++ : ~0L;
+		mask |= ~PAGE_MASK;	/* Optimalisation */
+		addr &= mask;		/* Normalisation */
+		do {
+			struct page *pg = phys_to_page(addr);
+			printk ("%05lx ", __pa(__va(addr)) >> PAGE_SHIFT);
+			printk ("=%05lx/%05lx ", (unsigned long)(pg-mem_map),
+					max_mapnr);
+			/* if (VALID_PAGE(pg)) {*/
+				if (PageTestandSetBad (pg)) {
+					reserve_bootmem (addr, PAGE_SIZE);
+					printk ("BAD ");
+				}
+				else printk ("BFR ");
+			/* }*/
+			/* else printk ("INV ");*/
+		} while (next_masked_address (&addr,mask));
+	}
+}
+
+
+/*********** CONFIG_BADRAM: CUSTOMISABLE SECTION STARTS HERE ******************/
+
+
+/* Enter your custom BadRAM patterns here as pairs of unsigned long integers. */
+/* For more information on these F/M pairs, refer to Documentation/badram.txt */
+
+
+static unsigned long __initdata badram_custom[] = {
+       0,      /* Number of longwords that follow, as F/M pairs */
+};
+
+
+/*********** CONFIG_BADRAM: CUSTOMISABLE SECTION ENDS HERE ********************/
+
+
+static int __init badram_setup (char *str)
+{
+	unsigned long opts[3];
+	if (!mem_map) BUG();
+	printk ("PAGE_OFFSET=0x%08lx\n", PAGE_OFFSET);
+	printk ("BadRAM option is %s\n", str);
+	if (*str++ == '=')
+		while ((str = get_options (str, 3, (int *) opts), *opts)) {
+			printk ("   --> marking 0x%08lx, 0x%08lx  [%ld]\n",
+					opts[1], opts[2], opts[0]);
+			badram_markpages (*opts, opts+1);
+			if (*opts == 1)
+				break;
+		};
+	badram_markpages (*badram_custom, badram_custom+1);
+	return 0;
+}
+
+__setup("badram", badram_setup);
+
+#endif /* CONFIG_BADRAM */

--PNTmBPCT7hxwcZjr--
