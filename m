Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261924AbVCSXUB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261924AbVCSXUB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Mar 2005 18:20:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261909AbVCSXUA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Mar 2005 18:20:00 -0500
Received: from relay00.pair.com ([209.68.1.20]:17934 "HELO relay.pair.com")
	by vger.kernel.org with SMTP id S261929AbVCSXS3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Mar 2005 18:18:29 -0500
X-pair-Authenticated: 24.126.76.52
Message-ID: <423CA616.1040400@kegel.com>
Date: Sat, 19 Mar 2005 14:22:14 -0800
From: Dan Kegel <dank@kegel.com>
User-Agent: Mozilla/4.0 (compatible;MSIE 5.5; Windows 98)
X-Accept-Language: en, de-de
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] gcc-4.0 compatibility fixes for i386, m68k, ppc64, x86_64
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

gcc-4.0 fails with
"error: array type has incomplete element type"
(see http://gcc.gnu.org/ml/gcc/2005-02/msg00053.html)
on several files in linux-2.6.11.3.

Who knows, maybe all this is fixed in the -mm tree already,
but what the heck, here are a few fixes I haven't seen anyone
else post yet.  These fix build problems for me, and
are all trivial.  I haven't tested the resulting binaries.

See also related sets of fixes at
http://user.it.uu.se/~mikpe/linux/patches/2.6/patch-gcc4-fixes-v2-2.6.11
and
http://archives.andrew.net.au/lm-sensors/msg29809.html
I don't duplicate any of those here, I think.

--- part 1 ---
Fixes

In file included from include/asm/thread_info.h:16,
                  from include/linux/thread_info.h:21,
                  from include/linux/spinlock.h:12,
                  from include/linux/capability.h:45,
                  from include/linux/sched.h:7,
                  from arch/i386/kernel/asm-offsets.c:7:
include/asm/processor.h:87: error: array type has incomplete element type
make[1]: *** [arch/i386/kernel/asm-offsets.asm] Error 1

--- linux-2.6.11.3/include/asm-i386/processor.h.old	Tue Mar 15 06:45:26 2005
+++ linux-2.6.11.3/include/asm-i386/processor.h	Tue Mar 15 06:46:45 2005
@@ -81,6 +81,64 @@
  #define X86_VENDOR_UNKNOWN 0xff

  /*
+ * Size of io_bitmap.
+ */
+#define IO_BITMAP_BITS  65536
+#define IO_BITMAP_BYTES (IO_BITMAP_BITS/8)
+#define IO_BITMAP_LONGS (IO_BITMAP_BYTES/sizeof(long))
+#define INVALID_IO_BITMAP_OFFSET 0x8000
+#define INVALID_IO_BITMAP_OFFSET_LAZY 0x9000
+
+struct tss_struct {
+	unsigned short	back_link,__blh;
+	unsigned long	esp0;
+	unsigned short	ss0,__ss0h;
+	unsigned long	esp1;
+	unsigned short	ss1,__ss1h;	/* ss1 is used to cache MSR_IA32_SYSENTER_CS */
+	unsigned long	esp2;
+	unsigned short	ss2,__ss2h;
+	unsigned long	__cr3;
+	unsigned long	eip;
+	unsigned long	eflags;
+	unsigned long	eax,ecx,edx,ebx;
+	unsigned long	esp;
+	unsigned long	ebp;
+	unsigned long	esi;
+	unsigned long	edi;
+	unsigned short	es, __esh;
+	unsigned short	cs, __csh;
+	unsigned short	ss, __ssh;
+	unsigned short	ds, __dsh;
+	unsigned short	fs, __fsh;
+	unsigned short	gs, __gsh;
+	unsigned short	ldt, __ldth;
+	unsigned short	trace, io_bitmap_base;
+	/*
+	 * The extra 1 is there because the CPU will access an
+	 * additional byte beyond the end of the IO permission
+	 * bitmap. The extra byte must be all 1 bits, and must
+	 * be within the limit.
+	 */
+	unsigned long	io_bitmap[IO_BITMAP_LONGS + 1];
+	/*
+	 * Cache the current maximum and the last task that used the bitmap:
+	 */
+	unsigned long io_bitmap_max;
+	struct thread_struct *io_bitmap_owner;
+	/*
+	 * pads the TSS to be cacheline-aligned (size is 0x100)
+	 */
+	unsigned long __cacheline_filler[35];
+	/*
+	 * .. and then another 0x100 bytes for emergency kernel stack
+	 */
+	unsigned long stack[64];
+} __attribute__((packed));
+
+#define IO_BITMAP_OFFSET offsetof(struct tss_struct,io_bitmap)
+#define ARCH_MIN_TASKALIGN	16
+
+/*
   * capabilities of CPUs
   */

@@ -308,16 +366,6 @@

  #define HAVE_ARCH_PICK_MMAP_LAYOUT

-/*
- * Size of io_bitmap.
- */
-#define IO_BITMAP_BITS  65536
-#define IO_BITMAP_BYTES (IO_BITMAP_BITS/8)
-#define IO_BITMAP_LONGS (IO_BITMAP_BYTES/sizeof(long))
-#define IO_BITMAP_OFFSET offsetof(struct tss_struct,io_bitmap)
-#define INVALID_IO_BITMAP_OFFSET 0x8000
-#define INVALID_IO_BITMAP_OFFSET_LAZY 0x9000
-
  struct i387_fsave_struct {
  	long	cwd;
  	long	swd;
@@ -371,54 +419,6 @@
  } mm_segment_t;

  struct thread_struct;
-
-struct tss_struct {
-	unsigned short	back_link,__blh;
-	unsigned long	esp0;
-	unsigned short	ss0,__ss0h;
-	unsigned long	esp1;
-	unsigned short	ss1,__ss1h;	/* ss1 is used to cache MSR_IA32_SYSENTER_CS */
-	unsigned long	esp2;
-	unsigned short	ss2,__ss2h;
-	unsigned long	__cr3;
-	unsigned long	eip;
-	unsigned long	eflags;
-	unsigned long	eax,ecx,edx,ebx;
-	unsigned long	esp;
-	unsigned long	ebp;
-	unsigned long	esi;
-	unsigned long	edi;
-	unsigned short	es, __esh;
-	unsigned short	cs, __csh;
-	unsigned short	ss, __ssh;
-	unsigned short	ds, __dsh;
-	unsigned short	fs, __fsh;
-	unsigned short	gs, __gsh;
-	unsigned short	ldt, __ldth;
-	unsigned short	trace, io_bitmap_base;
-	/*
-	 * The extra 1 is there because the CPU will access an
-	 * additional byte beyond the end of the IO permission
-	 * bitmap. The extra byte must be all 1 bits, and must
-	 * be within the limit.
-	 */
-	unsigned long	io_bitmap[IO_BITMAP_LONGS + 1];
-	/*
-	 * Cache the current maximum and the last task that used the bitmap:
-	 */
-	unsigned long io_bitmap_max;
-	struct thread_struct *io_bitmap_owner;
-	/*
-	 * pads the TSS to be cacheline-aligned (size is 0x100)
-	 */
-	unsigned long __cacheline_filler[35];
-	/*
-	 * .. and then another 0x100 bytes for emergency kernel stack
-	 */
-	unsigned long stack[64];
-} __attribute__((packed));
-
-#define ARCH_MIN_TASKALIGN	16

  struct thread_struct {
  /* cached TLS descriptors. */
--- part 2 ---
Fixes

In file included from include/asm/setup.h:8,
                  from include/asm/machdep.h:8,
                  from include/asm/irq.h:6,
                  from include/asm/hardirq.h:8,
                  from include/linux/hardirq.h:6,
                  from include/asm-generic/local.h:6,
                  from include/asm/local.h:4,
                  from include/linux/module.h:21,
                  from init/main.c:16:
include/asm-m68k/setup.h:365: error: array type has incomplete element type

when compiling with gcc-4.0.  (Affects ppc, too, for some reason.)

--- linux-2.6.11.3/include/asm-m68k/setup.h.old	Fri Mar 18 13:48:03 2005
+++ linux-2.6.11.3/include/asm-m68k/setup.h	Fri Mar 18 13:48:14 2005
@@ -362,12 +362,13 @@
  #ifndef __ASSEMBLY__
  extern int m68k_num_memory;		/* # of memory blocks found (and used) */
  extern int m68k_realnum_memory;		/* real # of memory blocks found */
-extern struct mem_info m68k_memory[NUM_MEMINFO];/* memory description */

  struct mem_info {
  	unsigned long addr;		/* physical address of memory chunk */
  	unsigned long size;		/* length of memory chunk (in bytes) */
  };
+
+extern struct mem_info m68k_memory[NUM_MEMINFO];/* memory description */
  #endif

  #endif /* __KERNEL__ */
--- part 3 ---
Fixes

In file included from include/asm/current.h:4,
                  from include/linux/wait.h:27,
                  from include/asm/semaphore.h:15,
                  from include/linux/sched.h:19,
                  from arch/ppc64/kernel/asm-offsets.c:18:
include/asm/paca.h:25: error: array type has incomplete element type
make[1]: *** [arch/ppc64/kernel/asm-offsets.s] Error 1

when building with gcc-4.0

--- linux-2.6.11.3/include/asm-ppc64/paca.h.old	Fri Mar 18 13:23:40 2005
+++ linux-2.6.11.3/include/asm-ppc64/paca.h	Fri Mar 18 13:24:04 2005
@@ -22,7 +22,6 @@
  #include	<asm/iSeries/ItLpRegSave.h>
  #include	<asm/mmu.h>

-extern struct paca_struct paca[];
  register struct paca_struct *local_paca asm("r13");
  #define get_paca()	local_paca

@@ -114,5 +113,7 @@
  	struct ItLpRegSave reg_save;
  #endif
  };
+
+extern struct paca_struct paca[];

  #endif /* _PPC64_PACA_H */
--- part 4 ---
Fixes:

In file included from include/linux/spinlock.h:16,
                  from include/linux/capability.h:45,
                  from include/linux/sched.h:7,
                  from arch/x86_64/kernel/asm-offsets.c:7:
include/asm/processor.h:79: error: array type has incomplete element type
make[1]: *** [arch/x86_64/kernel/asm-offsets.asm] Error 1

--- linux-2.6.11.3/include/asm-x86_64/processor.h.old	Tue Mar 15 07:05:07 2005
+++ linux-2.6.11.3/include/asm-x86_64/processor.h	Tue Mar 15 07:09:53 2005
@@ -179,7 +179,6 @@
  #define IO_BITMAP_BITS  65536
  #define IO_BITMAP_BYTES (IO_BITMAP_BITS/8)
  #define IO_BITMAP_LONGS (IO_BITMAP_BYTES/sizeof(long))
-#define IO_BITMAP_OFFSET offsetof(struct tss_struct,io_bitmap)
  #define INVALID_IO_BITMAP_OFFSET 0x8000

  struct i387_fxsave_struct {
@@ -222,6 +221,8 @@
  	 */
  	unsigned long io_bitmap[IO_BITMAP_LONGS + 1];
  } __attribute__((packed)) ____cacheline_aligned;
+
+#define IO_BITMAP_OFFSET offsetof(struct tss_struct,io_bitmap)

  extern struct cpuinfo_x86 boot_cpu_data;
  DECLARE_PER_CPU(struct tss_struct,init_tss);

-- 
Trying to get a job as a c++ developer?  See http://kegel.com/academy/getting-hired.html
