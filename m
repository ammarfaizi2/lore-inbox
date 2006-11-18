Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756161AbWKRCqI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756161AbWKRCqI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 21:46:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756162AbWKRCqH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 21:46:07 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:61338 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1756161AbWKRCqE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 21:46:04 -0500
Date: Fri, 17 Nov 2006 21:45:29 -0500
From: Vivek Goyal <vgoyal@in.ibm.com>
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Reloc Kernel List <fastboot@lists.osdl.org>, ebiederm@xmission.com,
       akpm@osdl.org, ak@suse.de, hpa@zytor.com, lwang@redhat.com,
       dzickus@redhat.com, pavel@suse.cz, rjw@sisk.pl
Subject: Re: [PATCH 17/20] x86_64: Remove CONFIG_PHYSICAL_START
Message-ID: <20061118024529.GC25205@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <20061117223432.GA15449@in.ibm.com> <20061117225628.GR15449@in.ibm.com> <aec7e5c30611171714p23c00fdbgea4a1097cfdf4ec0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aec7e5c30611171714p23c00fdbgea4a1097cfdf4ec0@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 18, 2006 at 10:14:31AM +0900, Magnus Damm wrote:
> Hi Vivek,
> 
> Sorry for not commenting on an earlier version.
> 
> On 11/18/06, Vivek Goyal <vgoyal@in.ibm.com> wrote:
> >I am about to add relocatable kernel support which has essentially
> >no cost so there is no point in retaining CONFIG_PHYSICAL_START
> >and retaining CONFIG_PHYSICAL_START makes implementation of and
> >testing of a relocatable kernel more difficult.
> >
> >Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
> >Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
> >---
> >
> > arch/x86_64/Kconfig                |   19 -------------------
> > arch/x86_64/boot/compressed/head.S |    6 +++---
> > arch/x86_64/boot/compressed/misc.c |    6 +++---
> > arch/x86_64/defconfig              |    1 -
> > arch/x86_64/kernel/vmlinux.lds.S   |    2 +-
> > arch/x86_64/mm/fault.c             |    4 ++--
> > include/asm-x86_64/page.h          |    2 --
> > 7 files changed, 9 insertions(+), 31 deletions(-)
> 
> [snip]
> 
> >diff -puN arch/x86_64/mm/fault.c~x86_64-Remove-CONFIG_PHYSICAL_START 
> >arch/x86_64/mm/fault.c
> >--- 
> >linux-2.6.19-rc6-reloc/arch/x86_64/mm/fault.c~x86_64-Remove-CONFIG_PHYSICAL_START   2006-11-17 00:12:50.000000000 -0500
> >+++ linux-2.6.19-rc6-reloc-root/arch/x86_64/mm/fault.c  2006-11-17 
> >00:12:50.000000000 -0500
> >@@ -644,9 +644,9 @@ void vmalloc_sync_all(void)
> >                        start = address + PGDIR_SIZE;
> >        }
> >        /* Check that there is no need to do the same for the modules 
> >        area. */
> >-       BUILD_BUG_ON(!(MODULES_VADDR > __START_KERNEL));
> >+       BUILD_BUG_ON(!(MODULES_VADDR > __START_KERNEL_map));
> >        BUILD_BUG_ON(!(((MODULES_END - 1) & PGDIR_MASK) ==
> >-                               (__START_KERNEL & PGDIR_MASK)));
> >+                               (__START_KERNEL_map & PGDIR_MASK)));
> > }
> 
> This code looks either like a bugfix or a bug. If it's a fix then
> maybe it should be broken out and submitted separately for the
> rc-kernels?
> 

Magnus, Eric got rid of __START_KERNEL because he was compiling kernel
for physical addr zero which made __START_KERNEL and __START_KERNEL_map
same, hence he got rid of __START_KERNEL. That's why above change.

But compiling for physical address zero has got drawback that one can
not directly load a vmlinux as it shall have to be loaded at physical
addr zero. Hence I changed the behavior back to compile the kernel for
physical addr 2MB. So now __START_KERNEL = __START_KERNEL_map + 2MB.

Now it makes sense to retain __START_KERNEL. I have done the changes.


> >diff -puN include/asm-x86_64/page.h~x86_64-Remove-CONFIG_PHYSICAL_START 
> >include/asm-x86_64/page.h
> >--- 
> >linux-2.6.19-rc6-reloc/include/asm-x86_64/page.h~x86_64-Remove-CONFIG_PHYSICAL_START        2006-11-17 00:12:50.000000000 -0500
> >+++ linux-2.6.19-rc6-reloc-root/include/asm-x86_64/page.h       2006-11-17 
> >00:12:50.000000000 -0500
> >@@ -75,8 +75,6 @@ typedef struct { unsigned long pgprot; }
> >
> > #endif /* !__ASSEMBLY__ */
> >
> >-#define __PHYSICAL_START       _AC(CONFIG_PHYSICAL_START,UL)
> >-#define __START_KERNEL         (__START_KERNEL_map + __PHYSICAL_START)
> > #define __START_KERNEL_map     _AC(0xffffffff80000000,UL)
> > #define __PAGE_OFFSET           _AC(0xffff810000000000,UL)
> 
> I understand that you want to remove the Kconfig option
> CONFIG_PHYSICAL_START and that is fine with me. I don't however like
> the idea of replacing __PHYSICAL_START and __START_KERNEL with
> hardcoded values. Is there any special reason behind this?
> 

All the hardcodings for 2MB have disappeared in final version. See next
patch in the series which actually implements relocatable kernel. Actually
the whole logic itself has changed hence we did not require these
hardcodings. This patch retains these hardcodings so that even if somebody
removes the top patch, kernel can be compiled and booted.

So bottom line, all the hardcodings are not present once all the patches
have been applied.

> The code in page.h already has constants for __START_KERNEL_map and
> __PAGE_OFFSET (thank god) and none of them are adjustable via Kconfig.
> Why not change as little as possible and keep __PHYSICAL_START and
> __START_KERNEL in page.h and the places that use them but remove
> references to CONFIG_PHYSICAL_START in Kconfig, defconfig, and page.h?

Good suggestion. Now I have retained __START_KERNEL. But did not feel 
the need to retain __PHYSICAL_START. It will be used only at one place
in page.h

Please find attached the regenerated patch.

Thanks
Vivek



I am about to add relocatable kernel support which has essentially
no cost so there is no point in retaining CONFIG_PHYSICAL_START
and retaining CONFIG_PHYSICAL_START makes implementation of and
testing of a relocatable kernel more difficult.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
---

 arch/x86_64/Kconfig                |   19 -------------------
 arch/x86_64/boot/compressed/head.S |    6 +++---
 arch/x86_64/boot/compressed/misc.c |    6 +++---
 arch/x86_64/defconfig              |    1 -
 include/asm-x86_64/page.h          |    3 +--
 5 files changed, 7 insertions(+), 28 deletions(-)

diff -puN arch/x86_64/boot/compressed/head.S~x86_64-Remove-CONFIG_PHYSICAL_START arch/x86_64/boot/compressed/head.S
--- linux-2.6.19-rc6-reloc/arch/x86_64/boot/compressed/head.S~x86_64-Remove-CONFIG_PHYSICAL_START	2006-11-17 00:12:50.000000000 -0500
+++ linux-2.6.19-rc6-reloc-root/arch/x86_64/boot/compressed/head.S	2006-11-17 04:20:21.000000000 -0500
@@ -76,7 +76,7 @@ startup_32:
 	jnz  3f
 	addl $8,%esp
 	xorl %ebx,%ebx
-	ljmp $(__KERNEL_CS), $__PHYSICAL_START
+	ljmp $(__KERNEL_CS), $0x200000
 
 /*
  * We come here, if we were loaded high.
@@ -102,7 +102,7 @@ startup_32:
 	popl %ecx	# lcount
 	popl %edx	# high_buffer_start
 	popl %eax	# hcount
-	movl $__PHYSICAL_START,%edi
+	movl $0x200000,%edi
 	cli		# make sure we don't get interrupted
 	ljmp $(__KERNEL_CS), $0x1000 # and jump to the move routine
 
@@ -127,7 +127,7 @@ move_routine_start:
 	movsl
 	movl %ebx,%esi	# Restore setup pointer
 	xorl %ebx,%ebx
-	ljmp $(__KERNEL_CS), $__PHYSICAL_START
+	ljmp $(__KERNEL_CS), $0x200000
 move_routine_end:
 
 
diff -puN arch/x86_64/boot/compressed/misc.c~x86_64-Remove-CONFIG_PHYSICAL_START arch/x86_64/boot/compressed/misc.c
--- linux-2.6.19-rc6-reloc/arch/x86_64/boot/compressed/misc.c~x86_64-Remove-CONFIG_PHYSICAL_START	2006-11-17 00:12:50.000000000 -0500
+++ linux-2.6.19-rc6-reloc-root/arch/x86_64/boot/compressed/misc.c	2006-11-17 04:20:21.000000000 -0500
@@ -288,7 +288,7 @@ static void setup_normal_output_buffer(v
 #else
 	if ((RM_ALT_MEM_K > RM_EXT_MEM_K ? RM_ALT_MEM_K : RM_EXT_MEM_K) < 1024) error("Less than 2MB of memory");
 #endif
-	output_data = (unsigned char *)__PHYSICAL_START; /* Normally Points to 1M */
+	output_data = (unsigned char *)0x200000;
 	free_mem_end_ptr = (long)real_mode;
 }
 
@@ -311,8 +311,8 @@ static void setup_output_buffer_if_we_ru
 	low_buffer_size = low_buffer_end - LOW_BUFFER_START;
 	high_loaded = 1;
 	free_mem_end_ptr = (long)high_buffer_start;
-	if ( (__PHYSICAL_START + low_buffer_size) > ((ulg)high_buffer_start)) {
-		high_buffer_start = (uch *)(__PHYSICAL_START + low_buffer_size);
+	if ( (0x200000 + low_buffer_size) > ((ulg)high_buffer_start)) {
+		high_buffer_start = (uch *)(0x200000 + low_buffer_size);
 		mv->hcount = 0; /* say: we need not to move high_buffer */
 	}
 	else mv->hcount = -1;
diff -puN arch/x86_64/defconfig~x86_64-Remove-CONFIG_PHYSICAL_START arch/x86_64/defconfig
--- linux-2.6.19-rc6-reloc/arch/x86_64/defconfig~x86_64-Remove-CONFIG_PHYSICAL_START	2006-11-17 00:12:50.000000000 -0500
+++ linux-2.6.19-rc6-reloc-root/arch/x86_64/defconfig	2006-11-17 00:12:50.000000000 -0500
@@ -165,7 +165,6 @@ CONFIG_X86_MCE_INTEL=y
 CONFIG_X86_MCE_AMD=y
 # CONFIG_KEXEC is not set
 # CONFIG_CRASH_DUMP is not set
-CONFIG_PHYSICAL_START=0x200000
 CONFIG_SECCOMP=y
 # CONFIG_CC_STACKPROTECTOR is not set
 # CONFIG_HZ_100 is not set
diff -puN arch/x86_64/Kconfig~x86_64-Remove-CONFIG_PHYSICAL_START arch/x86_64/Kconfig
--- linux-2.6.19-rc6-reloc/arch/x86_64/Kconfig~x86_64-Remove-CONFIG_PHYSICAL_START	2006-11-17 00:12:50.000000000 -0500
+++ linux-2.6.19-rc6-reloc-root/arch/x86_64/Kconfig	2006-11-17 00:12:50.000000000 -0500
@@ -513,25 +513,6 @@ config CRASH_DUMP
 	  PHYSICAL_START.
           For more details see Documentation/kdump/kdump.txt
 
-config PHYSICAL_START
-	hex "Physical address where the kernel is loaded" if (EMBEDDED || CRASH_DUMP)
-	default "0x1000000" if CRASH_DUMP
-	default "0x200000"
-	help
-	  This gives the physical address where the kernel is loaded. Normally
-	  for regular kernels this value is 0x200000 (2MB). But in the case
-	  of kexec on panic the fail safe kernel needs to run at a different
-	  address than the panic-ed kernel. This option is used to set the load
-	  address for kernels used to capture crash dump on being kexec'ed
-	  after panic. The default value for crash dump kernels is
-	  0x1000000 (16MB). This can also be set based on the "X" value as
-	  specified in the "crashkernel=YM@XM" command line boot parameter
-	  passed to the panic-ed kernel. Typically this parameter is set as
-	  crashkernel=64M@16M. Please take a look at
-	  Documentation/kdump/kdump.txt for more details about crash dumps.
-
-	  Don't change this unless you know what you are doing.
-
 config SECCOMP
 	bool "Enable seccomp to safely compute untrusted bytecode"
 	depends on PROC_FS
diff -puN include/asm-x86_64/page.h~x86_64-Remove-CONFIG_PHYSICAL_START include/asm-x86_64/page.h
--- linux-2.6.19-rc6-reloc/include/asm-x86_64/page.h~x86_64-Remove-CONFIG_PHYSICAL_START	2006-11-17 00:12:50.000000000 -0500
+++ linux-2.6.19-rc6-reloc-root/include/asm-x86_64/page.h	2006-11-17 04:20:21.000000000 -0500
@@ -75,8 +75,7 @@ typedef struct { unsigned long pgprot; }
 
 #endif /* !__ASSEMBLY__ */
 
-#define __PHYSICAL_START	_AC(CONFIG_PHYSICAL_START,UL)
-#define __START_KERNEL		(__START_KERNEL_map + __PHYSICAL_START)
+#define __START_KERNEL		(__START_KERNEL_map + 0x200000)
 #define __START_KERNEL_map	_AC(0xffffffff80000000,UL)
 #define __PAGE_OFFSET           _AC(0xffff810000000000,UL)
 
_
