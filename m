Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262141AbVBJPaC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262141AbVBJPaC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Feb 2005 10:30:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262142AbVBJPaC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Feb 2005 10:30:02 -0500
Received: from aun.it.uu.se ([130.238.12.36]:36259 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S262141AbVBJP3O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Feb 2005 10:29:14 -0500
From: Mikael Pettersson <mikpe@user.it.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16907.32186.211277.994120@alkaid.it.uu.se>
Date: Thu, 10 Feb 2005 16:28:58 +0100
To: linux-kernel@vger.kernel.org
Subject: [PATCH][2.4.30-pre1] preliminary fixes for gcc-4.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a preliminary set of patches to allow gcc-4.0 (20050130)
to compile the 2.4.30-pre1 kernel. I make no claim that the patches
are complete, but they have been tested successfully on i386 (multiple
boxes), x86-64, and ppc32.

The changes fall into these categories:
- static-vs-non-static mismatches cause compile failures in gcc-4.0.
  Typical resolution is to drop bogus extern declarations, but sometimes
  static objects that collide with non-static ones must be renamed.
- CFLAGS += -ffreestanding to avoid gcc magically turning sprintf()
  into calls to non-existent strcpy().
- Add macro for abs() since -ffreestanding apparently prevents it
  from being treated as a compiler intrinsic. (Unsure about this one.)
- Change some u32 to long in acpi, to prevent invalid assembly code on x86-64.
- Change several const function attributes to __attribute_const__
  to silence lots of compiler warnings.
- Add -Wno-pointer-sign to silence lots of compiler warnings.

Most of these changes are already in the 2.6 kernel.

It's up to Marcelo as to whether any of this should go into the 2.4.30 tree.
(Bug fix only feature freeze mode etc.)

/Mikael

diff -rupN linux-2.4.30-pre1/Makefile linux-2.4.30-pre1.gcc4-fixes-v5/Makefile
--- linux-2.4.30-pre1/Makefile	2005-02-10 14:30:03.000000000 +0100
+++ linux-2.4.30-pre1.gcc4-fixes-v5/Makefile	2005-02-10 14:35:01.000000000 +0100
@@ -93,6 +93,7 @@ CPPFLAGS := -D__KERNEL__ -I$(HPATH)
 
 CFLAGS := $(CPPFLAGS) -Wall -Wstrict-prototypes -Wno-trigraphs -O2 \
 	  -fno-strict-aliasing -fno-common
+CFLAGS += -ffreestanding
 ifndef CONFIG_FRAME_POINTER
 CFLAGS += -fomit-frame-pointer
 endif
diff -rupN linux-2.4.30-pre1/arch/i386/Makefile linux-2.4.30-pre1.gcc4-fixes-v5/arch/i386/Makefile
--- linux-2.4.30-pre1/arch/i386/Makefile	2004-11-17 18:36:41.000000000 +0100
+++ linux-2.4.30-pre1.gcc4-fixes-v5/arch/i386/Makefile	2005-02-10 14:35:01.000000000 +0100
@@ -98,6 +98,9 @@ endif
 # due to the lack of sharing of stacklots.
 CFLAGS += $(call check_gcc,-fno-unit-at-a-time,)
 
+# disable pointer signedness warnings in gcc 4.0
+CFLAGS += $(call check_gcc,-Wno-pointer-sign,)
+
 HEAD := arch/i386/kernel/head.o arch/i386/kernel/init_task.o
 
 SUBDIRS += arch/i386/kernel arch/i386/mm arch/i386/lib
diff -rupN linux-2.4.30-pre1/arch/ppc/Makefile linux-2.4.30-pre1.gcc4-fixes-v5/arch/ppc/Makefile
--- linux-2.4.30-pre1/arch/ppc/Makefile	2004-04-14 20:22:20.000000000 +0200
+++ linux-2.4.30-pre1.gcc4-fixes-v5/arch/ppc/Makefile	2005-02-10 14:35:01.000000000 +0100
@@ -25,6 +25,11 @@ CFLAGS		:= $(CFLAGS) -I$(TOPDIR)/arch/$(
 HOSTCFLAGS	+= -I$(TOPDIR)/arch/$(ARCH)
 CPP		= $(CC) -E $(CFLAGS)
 
+check_gcc = $(shell if $(CC) $(1) -S -o /dev/null -xc /dev/null > /dev/null 2>&1; then echo "$(1)"; else echo "$(2)"; fi)
+
+# disable pointer signedness warnings in gcc 4.0
+CFLAGS += $(call check_gcc,-Wno-pointer-sign,)
+
 ifdef CONFIG_4xx
 CFLAGS := $(CFLAGS) -Wa,-m405
 endif
diff -rupN linux-2.4.30-pre1/arch/ppc/kernel/open_pic_defs.h linux-2.4.30-pre1.gcc4-fixes-v5/arch/ppc/kernel/open_pic_defs.h
--- linux-2.4.30-pre1/arch/ppc/kernel/open_pic_defs.h	2003-06-14 13:30:19.000000000 +0200
+++ linux-2.4.30-pre1.gcc4-fixes-v5/arch/ppc/kernel/open_pic_defs.h	2005-02-10 14:35:01.000000000 +0100
@@ -172,9 +172,6 @@ struct OpenPIC {
     OpenPIC_Processor Processor[OPENPIC_MAX_PROCESSORS];
 };
 
-extern volatile struct OpenPIC *OpenPIC;
-
-
     /*
      *  Current Task Priority Register
      */
diff -rupN linux-2.4.30-pre1/arch/ppc/kernel/ppc_ksyms.c linux-2.4.30-pre1.gcc4-fixes-v5/arch/ppc/kernel/ppc_ksyms.c
--- linux-2.4.30-pre1/arch/ppc/kernel/ppc_ksyms.c	2004-04-14 20:22:20.000000000 +0200
+++ linux-2.4.30-pre1.gcc4-fixes-v5/arch/ppc/kernel/ppc_ksyms.c	2005-02-10 14:35:01.000000000 +0100
@@ -70,7 +70,6 @@ extern int sys_sigreturn(struct pt_regs 
 long long __ashrdi3(long long, int);
 long long __ashldi3(long long, int);
 long long __lshrdi3(long long, int);
-int abs(int);
 
 extern unsigned char __res[];
 
@@ -302,8 +301,6 @@ EXPORT_SYMBOL_NOVERS(memscan);
 EXPORT_SYMBOL_NOVERS(memcmp);
 EXPORT_SYMBOL_NOVERS(memchr);
 
-EXPORT_SYMBOL(abs);
-
 #if defined(CONFIG_VGA_CONSOLE) || defined(CONFIG_FB)
 EXPORT_SYMBOL(screen_info);
 #endif
diff -rupN linux-2.4.30-pre1/arch/ppc/kernel/time.c linux-2.4.30-pre1.gcc4-fixes-v5/arch/ppc/kernel/time.c
--- linux-2.4.30-pre1/arch/ppc/kernel/time.c	2003-08-25 20:07:42.000000000 +0200
+++ linux-2.4.30-pre1.gcc4-fixes-v5/arch/ppc/kernel/time.c	2005-02-10 14:35:01.000000000 +0100
@@ -84,7 +84,7 @@ unsigned tb_last_stamp;
 
 extern unsigned long wall_jiffies;
 
-static long time_offset;
+static long ppc_time_offset;
 
 spinlock_t rtc_lock = SPIN_LOCK_UNLOCKED;
 
@@ -187,7 +187,7 @@ int timer_interrupt(struct pt_regs * reg
 		     xtime.tv_sec - last_rtc_update >= 659 &&
 		     abs(xtime.tv_usec - (1000000-1000000/HZ)) < 500000/HZ &&
 		     jiffies - wall_jiffies == 1) {
-		  	if (ppc_md.set_rtc_time(xtime.tv_sec+1 + time_offset) == 0)
+		  	if (ppc_md.set_rtc_time(xtime.tv_sec+1 + ppc_time_offset) == 0)
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
diff -rupN linux-2.4.30-pre1/arch/x86_64/Makefile linux-2.4.30-pre1.gcc4-fixes-v5/arch/x86_64/Makefile
--- linux-2.4.30-pre1/arch/x86_64/Makefile	2004-04-14 20:22:20.000000000 +0200
+++ linux-2.4.30-pre1.gcc4-fixes-v5/arch/x86_64/Makefile	2005-02-10 14:35:01.000000000 +0100
@@ -56,6 +56,9 @@ endif
 # this is needed right now for the 32bit ioctl code
 CFLAGS += $(call check_gcc,-fno-unit-at-a-time,)
 
+# disable pointer signedness warnings in gcc 4.0
+CFLAGS += $(call check_gcc,-Wno-pointer-sign,)
+
 ifdef CONFIG_MK8
 CFLAGS += $(call check_gcc,-march=k8,)
 endif
diff -rupN linux-2.4.30-pre1/drivers/acpi/bus.c linux-2.4.30-pre1.gcc4-fixes-v5/drivers/acpi/bus.c
--- linux-2.4.30-pre1/drivers/acpi/bus.c	2005-01-19 18:00:53.000000000 +0100
+++ linux-2.4.30-pre1.gcc4-fixes-v5/drivers/acpi/bus.c	2005-02-10 14:35:01.000000000 +0100
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
diff -rupN linux-2.4.30-pre1/drivers/sound/sound_firmware.c linux-2.4.30-pre1.gcc4-fixes-v5/drivers/sound/sound_firmware.c
--- linux-2.4.30-pre1/drivers/sound/sound_firmware.c	2001-02-22 15:23:46.000000000 +0100
+++ linux-2.4.30-pre1.gcc4-fixes-v5/drivers/sound/sound_firmware.c	2005-02-10 14:35:01.000000000 +0100
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
diff -rupN linux-2.4.30-pre1/drivers/usb/host/ehci-q.c linux-2.4.30-pre1.gcc4-fixes-v5/drivers/usb/host/ehci-q.c
--- linux-2.4.30-pre1/drivers/usb/host/ehci-q.c	2005-01-19 18:00:53.000000000 +0100
+++ linux-2.4.30-pre1.gcc4-fixes-v5/drivers/usb/host/ehci-q.c	2005-02-10 14:35:01.000000000 +0100
@@ -199,8 +199,6 @@ ehci_urb_done (struct ehci_hcd *ehci, st
 #ifdef	INTR_AUTOMAGIC
 	struct urb		*resubmit = 0;
 	struct usb_device	*dev = 0;
-
-	static int ehci_urb_enqueue (struct usb_hcd *, struct urb *, int);
 #endif
 
 	if (likely (urb->hcpriv != 0)) {
diff -rupN linux-2.4.30-pre1/drivers/usb/inode.c linux-2.4.30-pre1.gcc4-fixes-v5/drivers/usb/inode.c
--- linux-2.4.30-pre1/drivers/usb/inode.c	2004-02-18 15:16:23.000000000 +0100
+++ linux-2.4.30-pre1.gcc4-fixes-v5/drivers/usb/inode.c	2005-02-10 14:35:01.000000000 +0100
@@ -41,6 +41,9 @@
 #include <linux/usbdevice_fs.h>
 #include <asm/uaccess.h>
 
+static struct inode_operations usbdevfs_bus_inode_operations;
+static struct file_operations usbdevfs_bus_file_operations;
+
 /* --------------------------------------------------------------------- */
 
 /*
diff -rupN linux-2.4.30-pre1/fs/hfs/trans.c linux-2.4.30-pre1.gcc4-fixes-v5/fs/hfs/trans.c
--- linux-2.4.30-pre1/fs/hfs/trans.c	2001-02-22 15:23:47.000000000 +0100
+++ linux-2.4.30-pre1.gcc4-fixes-v5/fs/hfs/trans.c	2005-02-10 14:35:01.000000000 +0100
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
diff -rupN linux-2.4.30-pre1/include/asm-i386/byteorder.h linux-2.4.30-pre1.gcc4-fixes-v5/include/asm-i386/byteorder.h
--- linux-2.4.30-pre1/include/asm-i386/byteorder.h	2003-06-14 13:30:27.000000000 +0200
+++ linux-2.4.30-pre1.gcc4-fixes-v5/include/asm-i386/byteorder.h	2005-02-10 14:35:01.000000000 +0100
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
 
 /* gcc should generate this for open coded C now too. May be worth switching to 
    it because inline assembly cannot be scheduled. -AK */
-static __inline__ __const__ __u16 ___arch__swab16(__u16 x)
+static __inline__ __attribute_const__ __u16 ___arch__swab16(__u16 x)
 {
 	__asm__("xchgb %b0,%h0"		/* swap bytes		*/
 		: "=q" (x)
diff -rupN linux-2.4.30-pre1/include/asm-ppc/byteorder.h linux-2.4.30-pre1.gcc4-fixes-v5/include/asm-ppc/byteorder.h
--- linux-2.4.30-pre1/include/asm-ppc/byteorder.h	2003-06-14 13:30:28.000000000 +0200
+++ linux-2.4.30-pre1.gcc4-fixes-v5/include/asm-ppc/byteorder.h	2005-02-10 14:35:01.000000000 +0100
@@ -2,6 +2,7 @@
 #define _PPC_BYTEORDER_H
 
 #include <asm/types.h>
+#include <linux/compiler.h>
 
 #ifdef __GNUC__
 #ifdef __KERNEL__
@@ -50,7 +51,7 @@ extern __inline__ void st_le64(volatile 
 	__asm__ __volatile__ ("stwbrx  %1,0,%2" : "=m" (*addr) : "r" (val), "r" (taddr+4));
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
 
diff -rupN linux-2.4.30-pre1/include/asm-ppc/system.h linux-2.4.30-pre1.gcc4-fixes-v5/include/asm-ppc/system.h
--- linux-2.4.30-pre1/include/asm-ppc/system.h	2003-06-14 13:30:28.000000000 +0200
+++ linux-2.4.30-pre1.gcc4-fixes-v5/include/asm-ppc/system.h	2005-02-10 14:35:01.000000000 +0100
@@ -74,7 +74,6 @@ extern void load_up_altivec(struct task_
 extern void cvt_fd(float *from, double *to, unsigned long *fpscr);
 extern void cvt_df(double *from, float *to, unsigned long *fpscr);
 extern int call_rtas(const char *, int, int, unsigned long *, ...);
-extern int abs(int);
 extern void cacheable_memzero(void *p, unsigned int nb);
 
 struct device_node;
diff -rupN linux-2.4.30-pre1/include/asm-ppc/time.h linux-2.4.30-pre1.gcc4-fixes-v5/include/asm-ppc/time.h
--- linux-2.4.30-pre1/include/asm-ppc/time.h	2003-08-25 20:07:49.000000000 +0200
+++ linux-2.4.30-pre1.gcc4-fixes-v5/include/asm-ppc/time.h	2005-02-10 14:35:01.000000000 +0100
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
diff -rupN linux-2.4.30-pre1/include/asm-x86_64/byteorder.h linux-2.4.30-pre1.gcc4-fixes-v5/include/asm-x86_64/byteorder.h
--- linux-2.4.30-pre1/include/asm-x86_64/byteorder.h	2002-11-30 17:12:31.000000000 +0100
+++ linux-2.4.30-pre1.gcc4-fixes-v5/include/asm-x86_64/byteorder.h	2005-02-10 14:35:01.000000000 +0100
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
diff -rupN linux-2.4.30-pre1/include/linux/byteorder/swab.h linux-2.4.30-pre1.gcc4-fixes-v5/include/linux/byteorder/swab.h
--- linux-2.4.30-pre1/include/linux/byteorder/swab.h	2002-11-30 17:12:31.000000000 +0100
+++ linux-2.4.30-pre1.gcc4-fixes-v5/include/linux/byteorder/swab.h	2005-02-10 14:35:01.000000000 +0100
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
diff -rupN linux-2.4.30-pre1/include/linux/compiler.h linux-2.4.30-pre1.gcc4-fixes-v5/include/linux/compiler.h
--- linux-2.4.30-pre1/include/linux/compiler.h	2004-11-17 18:36:42.000000000 +0100
+++ linux-2.4.30-pre1.gcc4-fixes-v5/include/linux/compiler.h	2005-02-10 14:35:01.000000000 +0100
@@ -27,6 +27,12 @@
 #define __attribute_used__	/* not implemented */
 #endif /* __GNUC__ */
 
+#if __GNUC__ > 2 || (__GNUC__ == 2 && __GNUC_MINOR >= 96)
+#define __attribute_const__	__attribute__((__const__))
+#else
+#define __attribute_const__	/* unimplemented */
+#endif
+
 #if __GNUC__ == 3
 #if __GNUC_MINOR__ >= 1
 # define inline         __inline__ __attribute__((always_inline))
diff -rupN linux-2.4.30-pre1/include/linux/fs.h linux-2.4.30-pre1.gcc4-fixes-v5/include/linux/fs.h
--- linux-2.4.30-pre1/include/linux/fs.h	2005-02-10 14:30:03.000000000 +0100
+++ linux-2.4.30-pre1.gcc4-fixes-v5/include/linux/fs.h	2005-02-10 14:35:01.000000000 +0100
@@ -1559,7 +1559,6 @@ static inline int is_mounted(kdev_t dev)
 unsigned long generate_cluster(kdev_t, int b[], int);
 unsigned long generate_cluster_swab32(kdev_t, int b[], int);
 extern kdev_t ROOT_DEV;
-extern char root_device_name[];
 
 
 extern void show_buffers(void);
diff -rupN linux-2.4.30-pre1/include/linux/kernel.h linux-2.4.30-pre1.gcc4-fixes-v5/include/linux/kernel.h
--- linux-2.4.30-pre1/include/linux/kernel.h	2004-11-17 18:36:42.000000000 +0100
+++ linux-2.4.30-pre1.gcc4-fixes-v5/include/linux/kernel.h	2005-02-10 14:35:01.000000000 +0100
@@ -59,6 +59,11 @@ extern int console_printk[];
 
 struct completion;
 
+#define abs(x) ({				\
+		int __x = (x);			\
+		(__x < 0) ? -__x : __x;		\
+	})
+
 extern struct notifier_block *panic_notifier_list;
 NORET_TYPE void panic(const char * fmt, ...)
 	__attribute__ ((NORET_AND format (printf, 1, 2)));
@@ -66,7 +71,6 @@ asmlinkage NORET_TYPE void do_exit(long 
 	ATTRIB_NORET;
 NORET_TYPE void complete_and_exit(struct completion *, long)
 	ATTRIB_NORET;
-extern int abs(int);
 extern unsigned long simple_strtoul(const char *,char **,unsigned int);
 extern long simple_strtol(const char *,char **,unsigned int);
 extern unsigned long long simple_strtoull(const char *,char **,unsigned int);
diff -rupN linux-2.4.30-pre1/include/linux/netfilter_ipv4/ip_tables.h linux-2.4.30-pre1.gcc4-fixes-v5/include/linux/netfilter_ipv4/ip_tables.h
--- linux-2.4.30-pre1/include/linux/netfilter_ipv4/ip_tables.h	2004-08-08 10:56:31.000000000 +0200
+++ linux-2.4.30-pre1.gcc4-fixes-v5/include/linux/netfilter_ipv4/ip_tables.h	2005-02-10 14:35:01.000000000 +0100
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
diff -rupN linux-2.4.30-pre1/include/linux/usbdevice_fs.h linux-2.4.30-pre1.gcc4-fixes-v5/include/linux/usbdevice_fs.h
--- linux-2.4.30-pre1/include/linux/usbdevice_fs.h	2003-11-29 00:28:14.000000000 +0100
+++ linux-2.4.30-pre1.gcc4-fixes-v5/include/linux/usbdevice_fs.h	2005-02-10 14:35:01.000000000 +0100
@@ -185,8 +185,6 @@ extern struct file_operations usbdevfs_d
 extern struct file_operations usbdevfs_devices_fops;
 extern struct file_operations usbdevfs_device_file_operations;
 extern struct inode_operations usbdevfs_device_inode_operations;
-extern struct inode_operations usbdevfs_bus_inode_operations;
-extern struct file_operations usbdevfs_bus_file_operations;
 extern void usbdevfs_conn_disc_event(void);
 
 #endif /* __KERNEL__ */
diff -rupN linux-2.4.30-pre1/net/ipv4/netfilter/ip_tables.c linux-2.4.30-pre1.gcc4-fixes-v5/net/ipv4/netfilter/ip_tables.c
--- linux-2.4.30-pre1/net/ipv4/netfilter/ip_tables.c	2005-01-19 18:00:53.000000000 +0100
+++ linux-2.4.30-pre1.gcc4-fixes-v5/net/ipv4/netfilter/ip_tables.c	2005-02-10 14:35:01.000000000 +0100
@@ -53,6 +53,8 @@ do {								\
 #endif
 #define SMP_ALIGN(x) (((x) + SMP_CACHE_BYTES-1) & ~(SMP_CACHE_BYTES-1))
 
+static DECLARE_MUTEX(ipt_mutex);
+
 /* Must have mutex */
 #define ASSERT_READ_LOCK(x) IP_NF_ASSERT(down_trylock(&ipt_mutex) != 0)
 #define ASSERT_WRITE_LOCK(x) IP_NF_ASSERT(down_trylock(&ipt_mutex) != 0)
