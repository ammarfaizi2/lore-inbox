Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262545AbVCVIVs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262545AbVCVIVs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 03:21:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262550AbVCVIVs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 03:21:48 -0500
Received: from miranda.se.axis.com ([193.13.178.8]:54172 "EHLO
	miranda.se.axis.com") by vger.kernel.org with ESMTP id S262545AbVCVIVM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 03:21:12 -0500
From: "Mikael Starvik" <mikael.starvik@axis.com>
To: "'Mikael Pettersson'" <mikpe@csd.uu.se>, <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH][2.4.30-rc1] updated gcc-4.0 patches
Date: Tue, 22 Mar 2005 09:20:56 +0100
Message-ID: <BFECAF9E178F144FAEF2BF4CE739C668014C7848@exmail1.se.axis.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
In-Reply-To: <BFECAF9E178F144FAEF2BF4CE739C66802854EB0@exmail1.se.axis.com>
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>(Thanks to Mikael Starvik for the -fno-builtin-sprintf hint.)

It's really Hans-Peter Nilsson who should have the credit. I only
forwarded his input.

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Mikael Pettersson
Sent: Saturday, March 19, 2005 5:26 PM
To: linux-kernel@vger.kernel.org
Subject: [PATCH][2.4.30-rc1] updated gcc-4.0 patches


Here is a new set of patches to allow gcc-4.0 (20050312)
to compile the 2.4.30-rc1 kernel. Changes since the previous
version of the patch set are:

- Replaced -ffreestanding with -fno-builtin-sprintf.
  freestanding was used to prevent gcc from transforming some
  sprintf() calls to calls to strcpy(), but no-builtin-sprintf
  solves that problem w/o the other problems of freestanding.
  (Thanks to Mikael Starvik for the -fno-builtin-sprintf hint.)
- Removed the abs()-related workarounds I had before because
  of -ffreestanding.
- Fixed typo in <linux/compiler.h>'s #ifdef around the
  __attribute_const__ definition. (Found by Mikael Starvik.)

Tested on i386, ppc32, and x86-64. The only known problem is
that the X server segfaults during PCI probing on x86-64. I'm
currently debugging that.

In addition to this core patch there is a big pile of compile
fixes to drivers etc that haven't been runtime tested. That patch
is too large for sending to LKML, so it's downloadable as
<http://www.csd.uu.se/~mikpe/linux/patches/2.4/patch-more-gcc4-fixes-v1-2.4.
30-rc1>.

/Mikael

diff -rupN linux-2.4.30-rc1/Makefile linux-2.4.30-rc1.gcc4-fixes-v9/Makefile
--- linux-2.4.30-rc1/Makefile	2005-03-19 11:27:37.000000000 +0100
+++ linux-2.4.30-rc1.gcc4-fixes-v9/Makefile	2005-03-19
11:37:32.000000000 +0100
@@ -93,11 +93,17 @@ CPPFLAGS := -D__KERNEL__ -I$(HPATH)
 
 CFLAGS := $(CPPFLAGS) -Wall -Wstrict-prototypes -Wno-trigraphs -O2 \
 	  -fno-strict-aliasing -fno-common
+CFLAGS += -fno-builtin-sprintf
 ifndef CONFIG_FRAME_POINTER
 CFLAGS += -fomit-frame-pointer
 endif
 AFLAGS := -D__ASSEMBLY__ $(CPPFLAGS)
 
+check_gcc = $(shell if $(CC) $(1) -S -o /dev/null -xc /dev/null > /dev/null
2>&1; then echo "$(1)"; else echo "$(2)"; fi)
+
+# disable pointer signedness warnings in gcc 4.0
+CFLAGS += $(call check_gcc,-Wno-pointer-sign,)
+
 #
 # ROOT_DEV specifies the default root-device when making the image.
 # This can be either FLOPPY, CURRENT, /dev/xxxx or empty, in which case
diff -rupN linux-2.4.30-rc1/arch/i386/Makefile
linux-2.4.30-rc1.gcc4-fixes-v9/arch/i386/Makefile
--- linux-2.4.30-rc1/arch/i386/Makefile	2004-11-17 18:36:41.000000000 +0100
+++ linux-2.4.30-rc1.gcc4-fixes-v9/arch/i386/Makefile	2005-03-19
11:37:32.000000000 +0100
@@ -23,8 +23,6 @@ LINKFLAGS =-T $(TOPDIR)/arch/i386/vmlinu
 
 CFLAGS += -pipe
 
-check_gcc = $(shell if $(CC) $(1) -S -o /dev/null -xc /dev/null > /dev/null
2>&1; then echo "$(1)"; else echo "$(2)"; fi)
-
 # prevent gcc from keeping the stack 16 byte aligned
 CFLAGS += $(call check_gcc,-mpreferred-stack-boundary=2,)
 
diff -rupN linux-2.4.30-rc1/arch/mips/Makefile
linux-2.4.30-rc1.gcc4-fixes-v9/arch/mips/Makefile
--- linux-2.4.30-rc1/arch/mips/Makefile	2005-01-19 18:00:52.000000000 +0100
+++ linux-2.4.30-rc1.gcc4-fixes-v9/arch/mips/Makefile	2005-03-19
11:37:32.000000000 +0100
@@ -30,8 +30,6 @@ endif
 
 MAKEBOOT = $(MAKE) -C arch/$(ARCH)/boot
 
-check_gcc = $(shell if $(CC) $(1) -S -o /dev/null -xc /dev/null > /dev/null
2>&1; then echo "$(1)"; else echo "$(2)"; fi)
-
 #
 #
 # GCC uses -G 0 -mabicalls -fpic as default.  We don't want PIC in the
kernel
diff -rupN linux-2.4.30-rc1/arch/mips64/Makefile
linux-2.4.30-rc1.gcc4-fixes-v9/arch/mips64/Makefile
--- linux-2.4.30-rc1/arch/mips64/Makefile	2005-01-19
18:00:52.000000000 +0100
+++ linux-2.4.30-rc1.gcc4-fixes-v9/arch/mips64/Makefile	2005-03-19
11:37:32.000000000 +0100
@@ -26,7 +26,6 @@ ifdef CONFIG_CROSSCOMPILE
 CROSS_COMPILE	= $(tool-prefix)
 endif
 
-check_gcc = $(shell if $(CC) $(1) -S -o /dev/null -xc /dev/null > /dev/null
2>&1; then echo "$(1)"; else echo "$(2)"; fi)
 check_gas = $(shell if $(CC) $(1) -Wa,-Z -c -o /dev/null -xassembler
/dev/null > /dev/null 2>&1; then echo "$(1)"; else echo "$(2)"; fi)
 
 #
diff -rupN linux-2.4.30-rc1/arch/ppc/kernel/open_pic_defs.h
linux-2.4.30-rc1.gcc4-fixes-v9/arch/ppc/kernel/open_pic_defs.h
--- linux-2.4.30-rc1/arch/ppc/kernel/open_pic_defs.h	2003-06-14
13:30:19.000000000 +0200
+++ linux-2.4.30-rc1.gcc4-fixes-v9/arch/ppc/kernel/open_pic_defs.h
2005-03-19 11:37:32.000000000 +0100
@@ -172,9 +172,6 @@ struct OpenPIC {
     OpenPIC_Processor Processor[OPENPIC_MAX_PROCESSORS];
 };
 
-extern volatile struct OpenPIC *OpenPIC;
-
-
     /*
      *  Current Task Priority Register
      */
diff -rupN linux-2.4.30-rc1/arch/ppc/kernel/time.c
linux-2.4.30-rc1.gcc4-fixes-v9/arch/ppc/kernel/time.c
--- linux-2.4.30-rc1/arch/ppc/kernel/time.c	2003-08-25
20:07:42.000000000 +0200
+++ linux-2.4.30-rc1.gcc4-fixes-v9/arch/ppc/kernel/time.c	2005-03-19
11:37:32.000000000 +0100
@@ -84,7 +84,7 @@ unsigned tb_last_stamp;
 
 extern unsigned long wall_jiffies;
 
-static long time_offset;
+static long ppc_time_offset;
 
 spinlock_t rtc_lock = SPIN_LOCK_UNLOCKED;
 
@@ -187,7 +187,7 @@ int timer_interrupt(struct pt_regs * reg
 		     xtime.tv_sec - last_rtc_update >= 659 &&
 		     abs(xtime.tv_usec - (1000000-1000000/HZ)) < 500000/HZ
&&
 		     jiffies - wall_jiffies == 1) {
-		  	if (ppc_md.set_rtc_time(xtime.tv_sec+1 +
time_offset) == 0)
+		  	if (ppc_md.set_rtc_time(xtime.tv_sec+1 +
ppc_time_offset) == 0)
 				last_rtc_update = xtime.tv_sec+1;
 			else
 				/* Try again one minute later */
@@ -297,7 +297,7 @@ void __init time_init(void)
 	unsigned old_stamp, stamp, elapsed;
 
         if (ppc_md.time_init != NULL)
-                time_offset = ppc_md.time_init();
+                ppc_time_offset = ppc_md.time_init();
 
 	if (__USE_RTC()) {
 		/* 601 processor: dec counts down by 128 every 128ns */
@@ -344,9 +344,9 @@ void __init time_init(void)
 	/* If platform provided a timezone (pmac), we correct the time
 	 * using do_sys_settimeofday() which in turn calls warp_clock()
 	 */
-        if (time_offset) {
+        if (ppc_time_offset) {
         	struct timezone tz;
-        	tz.tz_minuteswest = -time_offset / 60;
+        	tz.tz_minuteswest = -ppc_time_offset / 60;
         	tz.tz_dsttime = 0;
         	do_sys_settimeofday(NULL, &tz);
         }
diff -rupN linux-2.4.30-rc1/arch/x86_64/Makefile
linux-2.4.30-rc1.gcc4-fixes-v9/arch/x86_64/Makefile
--- linux-2.4.30-rc1/arch/x86_64/Makefile	2004-04-14
20:22:20.000000000 +0200
+++ linux-2.4.30-rc1.gcc4-fixes-v9/arch/x86_64/Makefile	2005-03-19
11:37:32.000000000 +0100
@@ -38,8 +38,6 @@ OBJCOPY=$(CROSS_COMPILE)objcopy -O binar
 LDFLAGS=-e stext
 LINKFLAGS =-T $(TOPDIR)/arch/x86_64/vmlinux.lds $(LDFLAGS)
 
-check_gcc = $(shell if $(CC) $(1) -S -o /dev/null -xc /dev/null > /dev/null
2>&1 ; then echo "$(1)"; else echo "$(2)"; fi)
-
 CFLAGS += -mno-red-zone
 CFLAGS += -mcmodel=kernel
 CFLAGS += -pipe
diff -rupN linux-2.4.30-rc1/drivers/acpi/bus.c
linux-2.4.30-rc1.gcc4-fixes-v9/drivers/acpi/bus.c
--- linux-2.4.30-rc1/drivers/acpi/bus.c	2005-01-19 18:00:53.000000000 +0100
+++ linux-2.4.30-rc1.gcc4-fixes-v9/drivers/acpi/bus.c	2005-03-19
11:37:32.000000000 +0100
@@ -623,7 +623,7 @@ acpi_bus_generate_event (
 	int			data)
 {
 	struct acpi_bus_event	*event = NULL;
-	u32			flags = 0;
+	unsigned long		flags = 0;
 
 	ACPI_FUNCTION_TRACE("acpi_bus_generate_event");
 
@@ -656,7 +656,7 @@ int
 acpi_bus_receive_event (
 	struct acpi_bus_event	*event)
 {
-	u32			flags = 0;
+	unsigned long		flags = 0;
 	struct acpi_bus_event	*entry = NULL;
 
 	DECLARE_WAITQUEUE(wait, current);
diff -rupN linux-2.4.30-rc1/drivers/sound/sound_firmware.c
linux-2.4.30-rc1.gcc4-fixes-v9/drivers/sound/sound_firmware.c
--- linux-2.4.30-rc1/drivers/sound/sound_firmware.c	2001-02-22
15:23:46.000000000 +0100
+++ linux-2.4.30-rc1.gcc4-fixes-v9/drivers/sound/sound_firmware.c
2005-03-19 11:37:32.000000000 +0100
@@ -4,10 +4,11 @@
 #include <linux/fs.h>
 #include <linux/mm.h>
 #include <linux/slab.h>
-#include <linux/unistd.h>
+static int my_errno;
+#define errno my_errno
+#include <asm/unistd.h>
 #include <asm/uaccess.h>
 
-static int errno;
 static int do_mod_firmware_load(const char *fn, char **fp)
 {
 	int fd;
diff -rupN linux-2.4.30-rc1/drivers/usb/host/ehci-q.c
linux-2.4.30-rc1.gcc4-fixes-v9/drivers/usb/host/ehci-q.c
--- linux-2.4.30-rc1/drivers/usb/host/ehci-q.c	2005-01-19
18:00:53.000000000 +0100
+++ linux-2.4.30-rc1.gcc4-fixes-v9/drivers/usb/host/ehci-q.c	2005-03-19
11:37:32.000000000 +0100
@@ -199,8 +199,6 @@ ehci_urb_done (struct ehci_hcd *ehci, st
 #ifdef	INTR_AUTOMAGIC
 	struct urb		*resubmit = 0;
 	struct usb_device	*dev = 0;
-
-	static int ehci_urb_enqueue (struct usb_hcd *, struct urb *, int);
 #endif
 
 	if (likely (urb->hcpriv != 0)) {
diff -rupN linux-2.4.30-rc1/drivers/usb/inode.c
linux-2.4.30-rc1.gcc4-fixes-v9/drivers/usb/inode.c
--- linux-2.4.30-rc1/drivers/usb/inode.c	2004-02-18
15:16:23.000000000 +0100
+++ linux-2.4.30-rc1.gcc4-fixes-v9/drivers/usb/inode.c	2005-03-19
11:37:32.000000000 +0100
@@ -41,6 +41,9 @@
 #include <linux/usbdevice_fs.h>
 #include <asm/uaccess.h>
 
+static struct inode_operations usbdevfs_bus_inode_operations;
+static struct file_operations usbdevfs_bus_file_operations;
+
 /* --------------------------------------------------------------------- */
 
 /*
diff -rupN linux-2.4.30-rc1/fs/hfs/trans.c
linux-2.4.30-rc1.gcc4-fixes-v9/fs/hfs/trans.c
--- linux-2.4.30-rc1/fs/hfs/trans.c	2001-02-22 15:23:47.000000000 +0100
+++ linux-2.4.30-rc1.gcc4-fixes-v9/fs/hfs/trans.c	2005-03-19
11:37:32.000000000 +0100
@@ -33,6 +33,7 @@
 #include <linux/hfs_fs_sb.h>
 #include <linux/hfs_fs_i.h>
 #include <linux/hfs_fs.h>
+#include <linux/compiler.h>
 
 /*================ File-local variables ================*/
 
@@ -78,7 +79,7 @@ static unsigned char mac2latin_map[128] 
  *
  * Given a hexadecimal digit in ASCII, return the integer representation.
  */
-static inline const unsigned char dehex(char c) {
+static inline __attribute_const__ unsigned char dehex(char c) {
 	if ((c>='0')&&(c<='9')) {
 		return c-'0';
 	}
diff -rupN linux-2.4.30-rc1/include/asm-i386/byteorder.h
linux-2.4.30-rc1.gcc4-fixes-v9/include/asm-i386/byteorder.h
--- linux-2.4.30-rc1/include/asm-i386/byteorder.h	2003-06-14
13:30:27.000000000 +0200
+++ linux-2.4.30-rc1.gcc4-fixes-v9/include/asm-i386/byteorder.h	2005-03-19
11:37:32.000000000 +0100
@@ -2,6 +2,7 @@
 #define _I386_BYTEORDER_H
 
 #include <asm/types.h>
+#include <linux/compiler.h>
 
 #ifdef __GNUC__
 
@@ -10,7 +11,7 @@
 #include <linux/config.h>
 #endif
 
-static __inline__ __const__ __u32 ___arch__swab32(__u32 x)
+static __inline__ __attribute_const__ __u32 ___arch__swab32(__u32 x)
 {
 #ifdef CONFIG_X86_BSWAP
 	__asm__("bswap %0" : "=r" (x) : "0" (x));
@@ -26,7 +27,7 @@ static __inline__ __const__ __u32 ___arc
 
 /* gcc should generate this for open coded C now too. May be worth
switching to 
    it because inline assembly cannot be scheduled. -AK */
-static __inline__ __const__ __u16 ___arch__swab16(__u16 x)
+static __inline__ __attribute_const__ __u16 ___arch__swab16(__u16 x)
 {
 	__asm__("xchgb %b0,%h0"		/* swap bytes		*/
 		: "=q" (x)
diff -rupN linux-2.4.30-rc1/include/asm-i386/processor.h
linux-2.4.30-rc1.gcc4-fixes-v9/include/asm-i386/processor.h
--- linux-2.4.30-rc1/include/asm-i386/processor.h	2004-02-18
15:16:24.000000000 +0100
+++ linux-2.4.30-rc1.gcc4-fixes-v9/include/asm-i386/processor.h	2005-03-19
11:37:32.000000000 +0100
@@ -72,7 +72,6 @@ struct cpuinfo_x86 {
  */
 
 extern struct cpuinfo_x86 boot_cpu_data;
-extern struct tss_struct init_tss[NR_CPUS];
 
 #ifdef CONFIG_SMP
 extern struct cpuinfo_x86 cpu_data[];
@@ -357,6 +356,8 @@ struct tss_struct {
 	unsigned long __cacheline_filler[5];
 };
 
+extern struct tss_struct init_tss[NR_CPUS];
+
 struct thread_struct {
 	unsigned long	esp0;
 	unsigned long	eip;
diff -rupN linux-2.4.30-rc1/include/asm-i386/string.h
linux-2.4.30-rc1.gcc4-fixes-v9/include/asm-i386/string.h
--- linux-2.4.30-rc1/include/asm-i386/string.h	2001-08-12
11:35:53.000000000 +0200
+++ linux-2.4.30-rc1.gcc4-fixes-v9/include/asm-i386/string.h	2005-03-19
11:37:32.000000000 +0100
@@ -337,7 +337,7 @@ extern void __struct_cpy_bug (void);
 #define struct_cpy(x,y) 			\
 ({						\
 	if (sizeof(*(x)) != sizeof(*(y))) 	\
-		__struct_cpy_bug;		\
+		__struct_cpy_bug();		\
 	memcpy(x, y, sizeof(*(x)));		\
 })
 
diff -rupN linux-2.4.30-rc1/include/asm-m68k/setup.h
linux-2.4.30-rc1.gcc4-fixes-v9/include/asm-m68k/setup.h
--- linux-2.4.30-rc1/include/asm-m68k/setup.h	2000-01-29
13:07:40.000000000 +0100
+++ linux-2.4.30-rc1.gcc4-fixes-v9/include/asm-m68k/setup.h	2005-03-19
11:37:32.000000000 +0100
@@ -361,12 +361,13 @@ extern int m68k_is040or060;
 #ifndef __ASSEMBLY__
 extern int m68k_num_memory;		/* # of memory blocks found (and
used) */
 extern int m68k_realnum_memory;		/* real # of memory blocks
found */
-extern struct mem_info m68k_memory[NUM_MEMINFO];/* memory description */
 
 struct mem_info {
 	unsigned long addr;		/* physical address of memory chunk
*/
 	unsigned long size;		/* length of memory chunk (in bytes)
*/
 };
+
+extern struct mem_info m68k_memory[NUM_MEMINFO];/* memory description */
 #endif
 
 #endif /* __KERNEL__ */
diff -rupN linux-2.4.30-rc1/include/asm-ppc/byteorder.h
linux-2.4.30-rc1.gcc4-fixes-v9/include/asm-ppc/byteorder.h
--- linux-2.4.30-rc1/include/asm-ppc/byteorder.h	2003-06-14
13:30:28.000000000 +0200
+++ linux-2.4.30-rc1.gcc4-fixes-v9/include/asm-ppc/byteorder.h	2005-03-19
11:37:32.000000000 +0100
@@ -2,6 +2,7 @@
 #define _PPC_BYTEORDER_H
 
 #include <asm/types.h>
+#include <linux/compiler.h>
 
 #ifdef __GNUC__
 #ifdef __KERNEL__
@@ -50,7 +51,7 @@ extern __inline__ void st_le64(volatile 
 	__asm__ __volatile__ ("stwbrx  %1,0,%2" : "=m" (*addr) : "r" (val),
"r" (taddr+4));
 }
 
-static __inline__ __const__ __u16 ___arch__swab16(__u16 value)
+static __inline__ __attribute_const__ __u16 ___arch__swab16(__u16 value)
 {
 	__u16 result;
 
@@ -58,7 +59,7 @@ static __inline__ __const__ __u16 ___arc
 	return result;
 }
 
-static __inline__ __const__ __u32 ___arch__swab32(__u32 value)
+static __inline__ __attribute_const__ __u32 ___arch__swab32(__u32 value)
 {
 	__u32 result;
 
diff -rupN linux-2.4.30-rc1/include/asm-ppc/time.h
linux-2.4.30-rc1.gcc4-fixes-v9/include/asm-ppc/time.h
--- linux-2.4.30-rc1/include/asm-ppc/time.h	2003-08-25
20:07:49.000000000 +0200
+++ linux-2.4.30-rc1.gcc4-fixes-v9/include/asm-ppc/time.h	2005-03-19
11:37:32.000000000 +0100
@@ -12,6 +12,7 @@
 #include <linux/config.h>
 #include <linux/mc146818rtc.h>
 #include <linux/threads.h>
+#include <linux/compiler.h>
 
 #include <asm/processor.h>
 
@@ -57,7 +58,7 @@ static __inline__ void set_dec(unsigned 
 /* Accessor functions for the timebase (RTC on 601) registers. */
 /* If one day CONFIG_POWER is added just define __USE_RTC as 1 */
 #ifdef CONFIG_6xx
-extern __inline__ int const __USE_RTC(void) {
+extern __inline__ int __attribute_const__ __USE_RTC(void) {
 	return (mfspr(SPRN_PVR)>>16) == 1;
 }
 #else
diff -rupN linux-2.4.30-rc1/include/asm-x86_64/byteorder.h
linux-2.4.30-rc1.gcc4-fixes-v9/include/asm-x86_64/byteorder.h
--- linux-2.4.30-rc1/include/asm-x86_64/byteorder.h	2002-11-30
17:12:31.000000000 +0100
+++ linux-2.4.30-rc1.gcc4-fixes-v9/include/asm-x86_64/byteorder.h
2005-03-19 11:37:32.000000000 +0100
@@ -2,16 +2,17 @@
 #define _X86_64_BYTEORDER_H
 
 #include <asm/types.h>
+#include <linux/compiler.h>
 
 #ifdef __GNUC__
 
-static __inline__ __const__ __u64 ___arch__swab64(__u64 x)
+static __inline__ __attribute_const__ __u64 ___arch__swab64(__u64 x)
 {
 	__asm__("bswapq %0" : "=r" (x) : "0" (x));
 	return x;
 }
 
-static __inline__ __const__ __u32 ___arch__swab32(__u32 x)
+static __inline__ __attribute_const__ __u32 ___arch__swab32(__u32 x)
 {
 	__asm__("bswapl %0" : "=r" (x) : "0" (x));
 	return x;
diff -rupN linux-2.4.30-rc1/include/asm-x86_64/processor.h
linux-2.4.30-rc1.gcc4-fixes-v9/include/asm-x86_64/processor.h
--- linux-2.4.30-rc1/include/asm-x86_64/processor.h	2004-04-14
20:22:21.000000000 +0200
+++ linux-2.4.30-rc1.gcc4-fixes-v9/include/asm-x86_64/processor.h
2005-03-19 11:37:32.000000000 +0100
@@ -68,7 +68,6 @@ struct cpuinfo_x86 {
 #define X86_VENDOR_UNKNOWN 0xff
 
 extern struct cpuinfo_x86 boot_cpu_data;
-extern struct tss_struct init_tss[NR_CPUS];
 
 #ifdef CONFIG_SMP
 extern struct cpuinfo_x86 cpu_data[];
@@ -299,6 +298,8 @@ struct tss_struct {
 	u32 io_bitmap[IO_BITMAP_SIZE];
 } __attribute__((packed)) ____cacheline_aligned;
 
+extern struct tss_struct init_tss[NR_CPUS];
+
 struct thread_struct {
 	unsigned long	rsp0;
 	unsigned long	rip;
diff -rupN linux-2.4.30-rc1/include/linux/byteorder/swab.h
linux-2.4.30-rc1.gcc4-fixes-v9/include/linux/byteorder/swab.h
--- linux-2.4.30-rc1/include/linux/byteorder/swab.h	2002-11-30
17:12:31.000000000 +0100
+++ linux-2.4.30-rc1.gcc4-fixes-v9/include/linux/byteorder/swab.h
2005-03-19 11:37:32.000000000 +0100
@@ -15,6 +15,8 @@
  *
  */
 
+#include <linux/compiler.h>
+
 /* casts are necessary for constants, because we never know how for sure
  * how U/UL/ULL map to __u16, __u32, __u64. At least not in a portable way.
  */
@@ -156,7 +158,7 @@
 #endif /* OPTIMIZE */
 
 
-static __inline__ __const__ __u16 __fswab16(__u16 x)
+static __inline__ __attribute_const__ __u16 __fswab16(__u16 x)
 {
 	return __arch__swab16(x);
 }
@@ -169,7 +171,7 @@ static __inline__ void __swab16s(__u16 *
 	__arch__swab16s(addr);
 }
 
-static __inline__ __const__ __u32 __fswab24(__u32 x)
+static __inline__ __attribute_const__ __u32 __fswab24(__u32 x)
 {
 	return __arch__swab24(x);
 }
@@ -182,7 +184,7 @@ static __inline__ void __swab24s(__u32 *
 	__arch__swab24s(addr);
 }
 
-static __inline__ __const__ __u32 __fswab32(__u32 x)
+static __inline__ __attribute_const__ __u32 __fswab32(__u32 x)
 {
 	return __arch__swab32(x);
 }
@@ -196,7 +198,7 @@ static __inline__ void __swab32s(__u32 *
 }
 
 #ifdef __BYTEORDER_HAS_U64__
-static __inline__ __const__ __u64 __fswab64(__u64 x)
+static __inline__ __attribute_const__ __u64 __fswab64(__u64 x)
 {
 #  ifdef __SWAB_64_THRU_32__
 	__u32 h = x >> 32;
diff -rupN linux-2.4.30-rc1/include/linux/compiler.h
linux-2.4.30-rc1.gcc4-fixes-v9/include/linux/compiler.h
--- linux-2.4.30-rc1/include/linux/compiler.h	2004-11-17
18:36:42.000000000 +0100
+++ linux-2.4.30-rc1.gcc4-fixes-v9/include/linux/compiler.h	2005-03-19
11:37:32.000000000 +0100
@@ -27,6 +27,12 @@
 #define __attribute_used__	/* not implemented */
 #endif /* __GNUC__ */
 
+#if __GNUC__ > 2 || (__GNUC__ == 2 && __GNUC_MINOR__ >= 96)
+#define __attribute_const__	__attribute__((__const__))
+#else
+#define __attribute_const__	/* unimplemented */
+#endif
+
 #if __GNUC__ == 3
 #if __GNUC_MINOR__ >= 1
 # define inline         __inline__ __attribute__((always_inline))
diff -rupN linux-2.4.30-rc1/include/linux/fs.h
linux-2.4.30-rc1.gcc4-fixes-v9/include/linux/fs.h
--- linux-2.4.30-rc1/include/linux/fs.h	2005-03-19 11:27:38.000000000 +0100
+++ linux-2.4.30-rc1.gcc4-fixes-v9/include/linux/fs.h	2005-03-19
11:37:32.000000000 +0100
@@ -1559,7 +1559,6 @@ static inline int is_mounted(kdev_t dev)
 unsigned long generate_cluster(kdev_t, int b[], int);
 unsigned long generate_cluster_swab32(kdev_t, int b[], int);
 extern kdev_t ROOT_DEV;
-extern char root_device_name[];
 
 
 extern void show_buffers(void);
diff -rupN linux-2.4.30-rc1/include/linux/netfilter_ipv4/ip_tables.h
linux-2.4.30-rc1.gcc4-fixes-v9/include/linux/netfilter_ipv4/ip_tables.h
--- linux-2.4.30-rc1/include/linux/netfilter_ipv4/ip_tables.h	2004-08-08
10:56:31.000000000 +0200
+++ linux-2.4.30-rc1.gcc4-fixes-v9/include/linux/netfilter_ipv4/ip_tables.h
2005-03-19 11:37:32.000000000 +0100
@@ -283,8 +283,6 @@ struct ipt_get_entries
 	struct ipt_entry entrytable[0];
 };
 
-extern struct semaphore ipt_mutex;
-
 /* Standard return verdict, or do jump. */
 #define IPT_STANDARD_TARGET ""
 /* Error verdict. */
@@ -336,7 +334,6 @@ ipt_get_target(struct ipt_entry *e)
 /*
  *	Main firewall chains definitions and global var's definitions.
  */
-static DECLARE_MUTEX(ipt_mutex);
 #ifdef __KERNEL__
 
 #include <linux/init.h>
diff -rupN linux-2.4.30-rc1/include/linux/ufs_fs.h
linux-2.4.30-rc1.gcc4-fixes-v9/include/linux/ufs_fs.h
--- linux-2.4.30-rc1/include/linux/ufs_fs.h	2001-11-23
22:40:15.000000000 +0100
+++ linux-2.4.30-rc1.gcc4-fixes-v9/include/linux/ufs_fs.h	2005-03-19
11:37:32.000000000 +0100
@@ -555,7 +555,6 @@ extern struct buffer_head * ufs_bread (s
 extern struct file_operations ufs_dir_operations;
         
 /* super.c */
-extern struct file_system_type ufs_fs_type;
 extern void ufs_warning (struct super_block *, const char *, const char *,
...) __attribute__ ((format (printf, 3, 4)));
 extern void ufs_error (struct super_block *, const char *, const char *,
...) __attribute__ ((format (printf, 3, 4)));
 extern void ufs_panic (struct super_block *, const char *, const char *,
...) __attribute__ ((format (printf, 3, 4)));
diff -rupN linux-2.4.30-rc1/include/linux/usbdevice_fs.h
linux-2.4.30-rc1.gcc4-fixes-v9/include/linux/usbdevice_fs.h
--- linux-2.4.30-rc1/include/linux/usbdevice_fs.h	2003-11-29
00:28:14.000000000 +0100
+++ linux-2.4.30-rc1.gcc4-fixes-v9/include/linux/usbdevice_fs.h	2005-03-19
11:37:32.000000000 +0100
@@ -185,8 +185,6 @@ extern struct file_operations usbdevfs_d
 extern struct file_operations usbdevfs_devices_fops;
 extern struct file_operations usbdevfs_device_file_operations;
 extern struct inode_operations usbdevfs_device_inode_operations;
-extern struct inode_operations usbdevfs_bus_inode_operations;
-extern struct file_operations usbdevfs_bus_file_operations;
 extern void usbdevfs_conn_disc_event(void);
 
 #endif /* __KERNEL__ */
diff -rupN linux-2.4.30-rc1/include/net/icmp.h
linux-2.4.30-rc1.gcc4-fixes-v9/include/net/icmp.h
--- linux-2.4.30-rc1/include/net/icmp.h	2001-04-28 12:35:26.000000000 +0200
+++ linux-2.4.30-rc1.gcc4-fixes-v9/include/net/icmp.h	2005-03-19
11:37:32.000000000 +0100
@@ -23,6 +23,7 @@
 
 #include <net/sock.h>
 #include <net/protocol.h>
+#include <net/snmp.h>
 
 struct icmp_err {
   int		errno;
diff -rupN linux-2.4.30-rc1/include/net/ipv6.h
linux-2.4.30-rc1.gcc4-fixes-v9/include/net/ipv6.h
--- linux-2.4.30-rc1/include/net/ipv6.h	2004-11-17 18:36:43.000000000 +0100
+++ linux-2.4.30-rc1.gcc4-fixes-v9/include/net/ipv6.h	2005-03-19
11:37:32.000000000 +0100
@@ -101,6 +101,7 @@ struct frag_hdr {
 #ifdef __KERNEL__
 
 #include <net/sock.h>
+#include <net/snmp.h>
 
 /* sysctls */
 extern int sysctl_ipv6_bindv6only;
diff -rupN linux-2.4.30-rc1/net/ipv4/netfilter/ip_tables.c
linux-2.4.30-rc1.gcc4-fixes-v9/net/ipv4/netfilter/ip_tables.c
--- linux-2.4.30-rc1/net/ipv4/netfilter/ip_tables.c	2005-01-19
18:00:53.000000000 +0100
+++ linux-2.4.30-rc1.gcc4-fixes-v9/net/ipv4/netfilter/ip_tables.c
2005-03-19 11:37:32.000000000 +0100
@@ -53,6 +53,8 @@ do {
\
 #endif
 #define SMP_ALIGN(x) (((x) + SMP_CACHE_BYTES-1) & ~(SMP_CACHE_BYTES-1))
 
+static DECLARE_MUTEX(ipt_mutex);
+
 /* Must have mutex */
 #define ASSERT_READ_LOCK(x) IP_NF_ASSERT(down_trylock(&ipt_mutex) != 0)
 #define ASSERT_WRITE_LOCK(x) IP_NF_ASSERT(down_trylock(&ipt_mutex) != 0)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

