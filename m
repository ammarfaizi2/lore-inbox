Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424353AbWLBSZ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424353AbWLBSZ5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Dec 2006 13:25:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424336AbWLBSZ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Dec 2006 13:25:57 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:2566 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1424353AbWLBSZz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Dec 2006 13:25:55 -0500
Date: Sat, 2 Dec 2006 19:26:00 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] cleanup asm/setup.h userspace visibility (v2)
Message-ID: <20061202182600.GX11084@stusta.de>
References: <20061202175539.GV11084@stusta.de> <20061202180233.GA26111@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061202180233.GA26111@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 02, 2006 at 06:02:33PM +0000, Russell King wrote:
> On Sat, Dec 02, 2006 at 06:55:39PM +0100, Adrian Bunk wrote:
> > This patch makes the contents of the userspace asm/setup.h header 
> > consistent on all architectures:
> > - export setup.h to userspace on all architectures
> > - export only COMMAND_LINE_SIZE to userspace
> 
> On ARM, all the ATAGs are exported to userspace because they are an API
> for boot loaders to use.  Everything down to the comment "Memory map
> description" should be exported.

Is the updated patch below OK?

> Russell King

cu
Adrian


<--  snip  -->


This patch makes the contents of the userspace asm/setup.h header 
consistent on all architectures:
- export setup.h to userspace on all architectures
- export only COMMAND_LINE_SIZE to userspace
- frv: move COMMAND_LINE_SIZE from param.h
- i386: remove duplicate COMMAND_LINE_SIZE from param.h
- arm:
  - export ATAGs to userspace
  - change u8/u16/u32 to __u8/__u16/__u32

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 include/asm-arm/setup.h        |  104 +++++++++++++++++----------------
 include/asm-arm26/setup.h      |    4 +
 include/asm-avr32/setup.h      |    4 +
 include/asm-frv/param.h        |    1 
 include/asm-frv/setup.h        |    6 +
 include/asm-generic/Kbuild.asm |    1 
 include/asm-i386/Kbuild        |    1 
 include/asm-i386/param.h       |    1 
 include/asm-i386/setup.h       |    6 +
 include/asm-ia64/Kbuild        |    1 
 include/asm-m32r/setup.h       |    9 ++
 include/asm-m68k/setup.h       |   12 +--
 include/asm-m68knommu/setup.h  |    5 +
 include/asm-mips/setup.h       |    2 
 include/asm-powerpc/setup.h    |    3 
 include/asm-s390/setup.h       |    3 
 include/asm-sh/setup.h         |    6 +
 include/asm-sh64/setup.h       |    6 +
 include/asm-x86_64/Kbuild      |    1 
 19 files changed, 102 insertions(+), 74 deletions(-)

--- linux-2.6.19-rc6-mm2/include/asm-generic/Kbuild.asm.old	2006-12-02 13:22:46.000000000 +0100
+++ linux-2.6.19-rc6-mm2/include/asm-generic/Kbuild.asm	2006-12-02 13:31:35.000000000 +0100
@@ -14,6 +14,7 @@
 unifdef-y += ptrace.h
 unifdef-y += resource.h
 unifdef-y += sembuf.h
+unifdef-y += setup.h
 unifdef-y += shmbuf.h
 unifdef-y += sigcontext.h
 unifdef-y += siginfo.h
--- linux-2.6.19-rc6-mm2/include/asm-i386/Kbuild.old	2006-12-02 13:23:11.000000000 +0100
+++ linux-2.6.19-rc6-mm2/include/asm-i386/Kbuild	2006-12-02 13:31:35.000000000 +0100
@@ -7,5 +7,4 @@
 header-y += ucontext.h
 
 unifdef-y += mtrr.h
-unifdef-y += setup.h
 unifdef-y += vm86.h
--- linux-2.6.19-rc6-mm2/include/asm-ia64/Kbuild.old	2006-12-02 13:23:23.000000000 +0100
+++ linux-2.6.19-rc6-mm2/include/asm-ia64/Kbuild	2006-12-02 13:31:35.000000000 +0100
@@ -10,7 +10,6 @@
 header-y += perfmon_default_smpl.h
 header-y += ptrace_offsets.h
 header-y += rse.h
-header-y += setup.h
 header-y += ucontext.h
 
 unifdef-y += perfmon.h
--- linux-2.6.19-rc6-mm2/include/asm-x86_64/Kbuild.old	2006-12-02 13:23:35.000000000 +0100
+++ linux-2.6.19-rc6-mm2/include/asm-x86_64/Kbuild	2006-12-02 13:31:35.000000000 +0100
@@ -11,7 +11,6 @@
 header-y += msr.h
 header-y += prctl.h
 header-y += ptrace-abi.h
-header-y += setup.h
 header-y += sigcontext32.h
 header-y += ucontext.h
 header-y += vsyscall32.h
--- linux-2.6.19-rc6-mm2/include/asm-arm/setup.h.old	2006-12-02 13:30:16.000000000 +0100
+++ linux-2.6.19-rc6-mm2/include/asm-arm/setup.h	2006-12-02 19:21:54.000000000 +0100
@@ -14,55 +14,57 @@
 #ifndef __ASMARM_SETUP_H
 #define __ASMARM_SETUP_H
 
+#include <asm/types.h>
+
 #define COMMAND_LINE_SIZE 1024
 
 /* The list ends with an ATAG_NONE node. */
 #define ATAG_NONE	0x00000000
 
 struct tag_header {
-	u32 size;
-	u32 tag;
+	__u32 size;
+	__u32 tag;
 };
 
 /* The list must start with an ATAG_CORE node */
 #define ATAG_CORE	0x54410001
 
 struct tag_core {
-	u32 flags;		/* bit 0 = read-only */
-	u32 pagesize;
-	u32 rootdev;
+	__u32 flags;		/* bit 0 = read-only */
+	__u32 pagesize;
+	__u32 rootdev;
 };
 
 /* it is allowed to have multiple ATAG_MEM nodes */
 #define ATAG_MEM	0x54410002
 
 struct tag_mem32 {
-	u32	size;
-	u32	start;	/* physical start address */
+	__u32	size;
+	__u32	start;	/* physical start address */
 };
 
 /* VGA text type displays */
 #define ATAG_VIDEOTEXT	0x54410003
 
 struct tag_videotext {
-	u8		x;
-	u8		y;
-	u16		video_page;
-	u8		video_mode;
-	u8		video_cols;
-	u16		video_ega_bx;
-	u8		video_lines;
-	u8		video_isvga;
-	u16		video_points;
+	__u8		x;
+	__u8		y;
+	__u16		video_page;
+	__u8		video_mode;
+	__u8		video_cols;
+	__u16		video_ega_bx;
+	__u8		video_lines;
+	__u8		video_isvga;
+	__u16		video_points;
 };
 
 /* describes how the ramdisk will be used in kernel */
 #define ATAG_RAMDISK	0x54410004
 
 struct tag_ramdisk {
-	u32 flags;	/* bit 0 = load, bit 1 = prompt */
-	u32 size;	/* decompressed ramdisk size in _kilo_ bytes */
-	u32 start;	/* starting block of floppy-based RAM disk image */
+	__u32 flags;	/* bit 0 = load, bit 1 = prompt */
+	__u32 size;	/* decompressed ramdisk size in _kilo_ bytes */
+	__u32 start;	/* starting block of floppy-based RAM disk image */
 };
 
 /* describes where the compressed ramdisk image lives (virtual address) */
@@ -76,23 +78,23 @@
 #define ATAG_INITRD2	0x54420005
 
 struct tag_initrd {
-	u32 start;	/* physical start address */
-	u32 size;	/* size of compressed ramdisk image in bytes */
+	__u32 start;	/* physical start address */
+	__u32 size;	/* size of compressed ramdisk image in bytes */
 };
 
 /* board serial number. "64 bits should be enough for everybody" */
 #define ATAG_SERIAL	0x54410006
 
 struct tag_serialnr {
-	u32 low;
-	u32 high;
+	__u32 low;
+	__u32 high;
 };
 
 /* board revision */
 #define ATAG_REVISION	0x54410007
 
 struct tag_revision {
-	u32 rev;
+	__u32 rev;
 };
 
 /* initial values for vesafb-type framebuffers. see struct screen_info
@@ -101,20 +103,20 @@
 #define ATAG_VIDEOLFB	0x54410008
 
 struct tag_videolfb {
-	u16		lfb_width;
-	u16		lfb_height;
-	u16		lfb_depth;
-	u16		lfb_linelength;
-	u32		lfb_base;
-	u32		lfb_size;
-	u8		red_size;
-	u8		red_pos;
-	u8		green_size;
-	u8		green_pos;
-	u8		blue_size;
-	u8		blue_pos;
-	u8		rsvd_size;
-	u8		rsvd_pos;
+	__u16		lfb_width;
+	__u16		lfb_height;
+	__u16		lfb_depth;
+	__u16		lfb_linelength;
+	__u32		lfb_base;
+	__u32		lfb_size;
+	__u8		red_size;
+	__u8		red_pos;
+	__u8		green_size;
+	__u8		green_pos;
+	__u8		blue_size;
+	__u8		blue_pos;
+	__u8		rsvd_size;
+	__u8		rsvd_pos;
 };
 
 /* command line: \0 terminated string */
@@ -128,17 +130,17 @@
 #define ATAG_ACORN	0x41000101
 
 struct tag_acorn {
-	u32 memc_control_reg;
-	u32 vram_pages;
-	u8 sounddefault;
-	u8 adfsdrives;
+	__u32 memc_control_reg;
+	__u32 vram_pages;
+	__u8 sounddefault;
+	__u8 adfsdrives;
 };
 
 /* footbridge memory clock, see arch/arm/mach-footbridge/arch.c */
 #define ATAG_MEMCLK	0x41000402
 
 struct tag_memclk {
-	u32 fmemclk;
+	__u32 fmemclk;
 };
 
 struct tag {
@@ -167,24 +169,26 @@
 };
 
 struct tagtable {
-	u32 tag;
+	__u32 tag;
 	int (*parse)(const struct tag *);
 };
 
-#define __tag __attribute_used__ __attribute__((__section__(".taglist.init")))
-#define __tagtable(tag, fn) \
-static struct tagtable __tagtable_##fn __tag = { tag, fn }
-
 #define tag_member_present(tag,member)				\
 	((unsigned long)(&((struct tag *)0L)->member + 1)	\
 		<= (tag)->hdr.size * 4)
 
-#define tag_next(t)	((struct tag *)((u32 *)(t) + (t)->hdr.size))
+#define tag_next(t)	((struct tag *)((__u32 *)(t) + (t)->hdr.size))
 #define tag_size(type)	((sizeof(struct tag_header) + sizeof(struct type)) >> 2)
 
 #define for_each_tag(t,base)		\
 	for (t = base; t->hdr.size; t = tag_next(t))
 
+#ifdef __KERNEL__
+
+#define __tag __attribute_used__ __attribute__((__section__(".taglist.init")))
+#define __tagtable(tag, fn) \
+static struct tagtable __tagtable_##fn __tag = { tag, fn }
+
 /*
  * Memory map description
  */
@@ -217,4 +221,6 @@
 static struct early_params __early_##fn __attribute_used__	\
 __attribute__((__section__(".early_param.init"))) = { name, fn }
 
+#endif  /*  __KERNEL__  */
+
 #endif
--- linux-2.6.19-rc6-mm2/include/asm-arm26/setup.h.old	2006-12-02 13:30:16.000000000 +0100
+++ linux-2.6.19-rc6-mm2/include/asm-arm26/setup.h	2006-12-02 13:31:35.000000000 +0100
@@ -16,6 +16,8 @@
 
 #define COMMAND_LINE_SIZE 1024
 
+#ifdef __KERNEL__
+
 /* The list ends with an ATAG_NONE node. */
 #define ATAG_NONE	0x00000000
 
@@ -202,4 +204,6 @@
 
 extern struct meminfo meminfo;
 
+#endif  /*  __KERNEL__  */
+
 #endif
--- linux-2.6.19-rc6-mm2/include/asm-frv/param.h.old	2006-12-02 13:30:16.000000000 +0100
+++ linux-2.6.19-rc6-mm2/include/asm-frv/param.h	2006-12-02 13:31:35.000000000 +0100
@@ -18,6 +18,5 @@
 #endif
 
 #define MAXHOSTNAMELEN		64	/* max length of hostname */
-#define COMMAND_LINE_SIZE	512
 
 #endif /* _ASM_PARAM_H */
--- linux-2.6.19-rc6-mm2/include/asm-frv/setup.h.old	2006-12-02 13:30:16.000000000 +0100
+++ linux-2.6.19-rc6-mm2/include/asm-frv/setup.h	2006-12-02 13:31:35.000000000 +0100
@@ -12,6 +12,10 @@
 #ifndef _ASM_SETUP_H
 #define _ASM_SETUP_H
 
+#define COMMAND_LINE_SIZE       512
+
+#ifdef __KERNEL__
+
 #include <linux/init.h>
 
 #ifndef __ASSEMBLY__
@@ -22,4 +26,6 @@
 
 #endif /* !__ASSEMBLY__ */
 
+#endif  /*  __KERNEL__  */
+
 #endif /* _ASM_SETUP_H */
--- linux-2.6.19-rc6-mm2/include/asm-i386/param.h.old	2006-12-02 13:30:16.000000000 +0100
+++ linux-2.6.19-rc6-mm2/include/asm-i386/param.h	2006-12-02 13:31:35.000000000 +0100
@@ -18,6 +18,5 @@
 #endif
 
 #define MAXHOSTNAMELEN	64	/* max length of hostname */
-#define COMMAND_LINE_SIZE 256
 
 #endif
--- linux-2.6.19-rc6-mm2/include/asm-i386/setup.h.old	2006-12-02 13:30:16.000000000 +0100
+++ linux-2.6.19-rc6-mm2/include/asm-i386/setup.h	2006-12-02 13:43:43.000000000 +0100
@@ -6,6 +6,8 @@
 #ifndef _i386_SETUP_H
 #define _i386_SETUP_H
 
+#define COMMAND_LINE_SIZE 256
+
 #ifdef __KERNEL__
 #include <linux/pfn.h>
 
@@ -14,10 +16,8 @@
  */
 #define MAXMEM_PFN	PFN_DOWN(MAXMEM)
 #define MAX_NONPAE_PFN	(1 << 20)
-#endif
 
 #define PARAM_SIZE 4096
-#define COMMAND_LINE_SIZE 256
 
 #define OLD_CL_MAGIC_ADDR	0x90020
 #define OLD_CL_MAGIC		0xA33F
@@ -79,4 +79,6 @@
 
 #endif /* __ASSEMBLY__ */
 
+#endif  /*  __KERNEL__  */
+
 #endif /* _i386_SETUP_H */
--- linux-2.6.19-rc6-mm2/include/asm-m32r/setup.h.old	2006-12-02 13:30:16.000000000 +0100
+++ linux-2.6.19-rc6-mm2/include/asm-m32r/setup.h	2006-12-02 13:38:45.000000000 +0100
@@ -1,6 +1,11 @@
 /*
  * This is set up by the setup-routine at boot-time
  */
+
+#define COMMAND_LINE_SIZE       512
+
+#ifdef __KERNEL__
+
 #define PARAM			((unsigned char *)empty_zero_page)
 
 #define MOUNT_ROOT_RDONLY	(*(unsigned long *) (PARAM+0x000))
@@ -18,8 +23,6 @@
 
 #define SCREEN_INFO		(*(struct screen_info *) (PARAM+0x200))
 
-#define COMMAND_LINE_SIZE	(512)
-
 #define RAMDISK_IMAGE_START_MASK	(0x07FF)
 #define RAMDISK_PROMPT_FLAG		(0x8000)
 #define RAMDISK_LOAD_FLAG		(0x4000)
@@ -27,3 +30,5 @@
 extern unsigned long memory_start;
 extern unsigned long memory_end;
 
+#endif  /*  __KERNEL__  */
+
--- linux-2.6.19-rc6-mm2/include/asm-m68k/setup.h.old	2006-12-02 13:30:16.000000000 +0100
+++ linux-2.6.19-rc6-mm2/include/asm-m68k/setup.h	2006-12-02 13:31:35.000000000 +0100
@@ -23,7 +23,11 @@
 #ifndef _M68K_SETUP_H
 #define _M68K_SETUP_H
 
+#define COMMAND_LINE_SIZE 256
 
+#ifdef __KERNEL__
+
+#define CL_SIZE COMMAND_LINE_SIZE
 
     /*
      *  Linux/m68k Architectures
@@ -41,8 +45,6 @@
 #define MACH_Q40     10
 #define MACH_SUN3X   11
 
-#ifdef __KERNEL__
-
 #ifndef __ASSEMBLY__
 extern unsigned long m68k_machtype;
 #endif /* !__ASSEMBLY__ */
@@ -189,8 +191,6 @@
 #  define MACH_TYPE (m68k_machtype)
 #endif
 
-#endif /* __KERNEL__ */
-
 
     /*
      *  CPU, FPU and MMU types
@@ -239,8 +239,6 @@
 #define MMU_SUN3       (1<<MMUB_SUN3)
 #define MMU_APOLLO     (1<<MMUB_APOLLO)
 
-#ifdef __KERNEL__
-
 #ifndef __ASSEMBLY__
 extern unsigned long m68k_cputype;
 extern unsigned long m68k_fputype;
@@ -355,8 +353,6 @@
      */
 
 #define NUM_MEMINFO	4
-#define CL_SIZE		256
-#define COMMAND_LINE_SIZE	CL_SIZE
 
 #ifndef __ASSEMBLY__
 struct mem_info {
--- linux-2.6.19-rc6-mm2/include/asm-m68knommu/setup.h.old	2006-12-02 13:30:16.000000000 +0100
+++ linux-2.6.19-rc6-mm2/include/asm-m68knommu/setup.h	2006-12-02 13:31:35.000000000 +0100
@@ -1,5 +1,10 @@
+#ifdef __KERNEL__
+
 #include <asm-m68k/setup.h>
 
 /* We have a bigger command line buffer. */
 #undef COMMAND_LINE_SIZE
+
+#endif  /*  __KERNEL__  */
+
 #define COMMAND_LINE_SIZE	512
--- linux-2.6.19-rc6-mm2/include/asm-mips/setup.h.old	2006-12-02 13:30:16.000000000 +0100
+++ linux-2.6.19-rc6-mm2/include/asm-mips/setup.h	2006-12-02 13:31:35.000000000 +0100
@@ -1,8 +1,6 @@
-#ifdef __KERNEL__
 #ifndef _MIPS_SETUP_H
 #define _MIPS_SETUP_H
 
 #define COMMAND_LINE_SIZE	256
 
 #endif /* __SETUP_H */
-#endif /* __KERNEL__ */
--- linux-2.6.19-rc6-mm2/include/asm-powerpc/setup.h.old	2006-12-02 13:30:16.000000000 +0100
+++ linux-2.6.19-rc6-mm2/include/asm-powerpc/setup.h	2006-12-02 13:31:35.000000000 +0100
@@ -1,9 +1,6 @@
 #ifndef _ASM_POWERPC_SETUP_H
 #define _ASM_POWERPC_SETUP_H
 
-#ifdef __KERNEL__
-
 #define COMMAND_LINE_SIZE	512
 
-#endif	/* __KERNEL__ */
 #endif	/* _ASM_POWERPC_SETUP_H */
--- linux-2.6.19-rc6-mm2/include/asm-s390/setup.h.old	2006-12-02 13:30:16.000000000 +0100
+++ linux-2.6.19-rc6-mm2/include/asm-s390/setup.h	2006-12-02 13:35:07.000000000 +0100
@@ -8,12 +8,13 @@
 #ifndef _ASM_S390_SETUP_H
 #define _ASM_S390_SETUP_H
 
+#define COMMAND_LINE_SIZE 	896
+
 #ifdef __KERNEL__
 
 #include <asm/types.h>
 
 #define PARMAREA		0x10400
-#define COMMAND_LINE_SIZE 	896
 #define MEMORY_CHUNKS		16	/* max 0x7fff */
 #define IPL_PARMBLOCK_ORIGIN	0x2000
 
--- linux-2.6.19-rc6-mm2/include/asm-sh/setup.h.old	2006-12-02 13:30:16.000000000 +0100
+++ linux-2.6.19-rc6-mm2/include/asm-sh/setup.h	2006-12-02 13:35:50.000000000 +0100
@@ -1,10 +1,12 @@
-#ifdef __KERNEL__
 #ifndef _SH_SETUP_H
 #define _SH_SETUP_H
 
 #define COMMAND_LINE_SIZE 256
 
+#ifdef __KERNEL__
+
 int setup_early_printk(char *);
 
-#endif /* _SH_SETUP_H */
 #endif /* __KERNEL__ */
+
+#endif /* _SH_SETUP_H */
--- linux-2.6.19-rc6-mm2/include/asm-sh64/setup.h.old	2006-12-02 13:30:16.000000000 +0100
+++ linux-2.6.19-rc6-mm2/include/asm-sh64/setup.h	2006-12-02 13:31:35.000000000 +0100
@@ -1,6 +1,10 @@
 #ifndef __ASM_SH64_SETUP_H
 #define __ASM_SH64_SETUP_H
 
+#define COMMAND_LINE_SIZE 256
+
+#ifdef __KERNEL__
+
 #define PARAM ((unsigned char *)empty_zero_page)
 #define MOUNT_ROOT_RDONLY (*(unsigned long *) (PARAM+0x000))
 #define RAMDISK_FLAGS (*(unsigned long *) (PARAM+0x004))
@@ -12,5 +16,7 @@
 #define COMMAND_LINE ((char *) (PARAM+256))
 #define COMMAND_LINE_SIZE 256
 
+#endif  /*  __KERNEL__  */
+
 #endif /* __ASM_SH64_SETUP_H */
 
--- linux-2.6.19-rc6-mm2/include/asm-avr32/setup.h.old	2006-12-02 13:33:07.000000000 +0100
+++ linux-2.6.19-rc6-mm2/include/asm-avr32/setup.h	2006-12-02 13:33:33.000000000 +0100
@@ -13,6 +13,8 @@
 
 #define COMMAND_LINE_SIZE 256
 
+#ifdef __KERNEL__
+
 /* Magic number indicating that a tag table is present */
 #define ATAG_MAGIC	0xa2a25441
 
@@ -138,4 +140,6 @@
 
 #endif /* !__ASSEMBLY__ */
 
+#endif  /*  __KERNEL__  */
+
 #endif /* __ASM_AVR32_SETUP_H__ */

