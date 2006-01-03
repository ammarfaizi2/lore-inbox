Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965101AbWACXb4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965101AbWACXb4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 18:31:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965111AbWACX3w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 18:29:52 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:34968 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S965097AbWACX30
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 18:29:26 -0500
To: torvalds@osdl.org
Subject: [PATCH 36/41] m68k: kill mach_floppy_setup, convert to proper __setup() in drivers
Cc: linux-kernel@vger.kernel.org, linux-m68k@vger.kernel.org
Message-Id: <E1Etvan-0003PR-Pe@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Tue, 03 Jan 2006 23:29:25 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>
Date: 1135280594 -0500

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 arch/m68k/amiga/config.c        |    6 ------
 arch/m68k/atari/config.c        |    6 ------
 arch/m68k/kernel/setup.c        |   13 -------------
 arch/m68k/q40/config.c          |    2 --
 arch/ppc/amiga/config.c         |    6 ------
 arch/ppc/platforms/apus_setup.c |   14 --------------
 drivers/block/amiflop.c         |   20 ++++++++++++++------
 drivers/block/ataflop.c         |   18 ++++++++++++++----
 include/asm-m68k/machdep.h      |    1 -
 include/asm-m68knommu/machdep.h |    1 -
 10 files changed, 28 insertions(+), 59 deletions(-)

e48ab92d755cd6c1d7f401700dd21dbc1b3320d2
diff --git a/arch/m68k/amiga/config.c b/arch/m68k/amiga/config.c
index 8eadde9..12e3706 100644
--- a/arch/m68k/amiga/config.c
+++ b/arch/m68k/amiga/config.c
@@ -105,9 +105,6 @@ static int a2000_hwclk (int, struct rtc_
 static int amiga_set_clock_mmss (unsigned long);
 static unsigned int amiga_get_ss (void);
 extern void amiga_mksound( unsigned int count, unsigned int ticks );
-#ifdef CONFIG_AMIGA_FLOPPY
-extern void amiga_floppy_setup(char *, int *);
-#endif
 static void amiga_reset (void);
 extern void amiga_init_sound(void);
 static void amiga_savekmsg_init(void);
@@ -427,9 +424,6 @@ void __init config_amiga(void)
 
   mach_set_clock_mmss  = amiga_set_clock_mmss;
   mach_get_ss          = amiga_get_ss;
-#ifdef CONFIG_AMIGA_FLOPPY
-  mach_floppy_setup    = amiga_floppy_setup;
-#endif
   mach_reset           = amiga_reset;
 #if defined(CONFIG_INPUT_M68K_BEEP) || defined(CONFIG_INPUT_M68K_BEEP_MODULE)
   mach_beep            = amiga_mksound;
diff --git a/arch/m68k/atari/config.c b/arch/m68k/atari/config.c
index f6d266b..1012b08 100644
--- a/arch/m68k/atari/config.c
+++ b/arch/m68k/atari/config.c
@@ -52,9 +52,6 @@ int atari_rtc_year_offset;
 
 /* local function prototypes */
 static void atari_reset( void );
-#ifdef CONFIG_ATARI_FLOPPY
-extern void atari_floppy_setup(char *, int *);
-#endif
 static void atari_get_model(char *model);
 static int atari_get_hardware_list(char *buffer);
 
@@ -244,9 +241,6 @@ void __init config_atari(void)
     mach_get_irq_list	 = show_atari_interrupts;
     mach_gettimeoffset   = atari_gettimeoffset;
     mach_reset           = atari_reset;
-#ifdef CONFIG_ATARI_FLOPPY
-    mach_floppy_setup	 = atari_floppy_setup;
-#endif
     mach_max_dma_address = 0xffffff;
 #if defined(CONFIG_INPUT_M68K_BEEP) || defined(CONFIG_INPUT_M68K_BEEP_MODULE)
     mach_beep          = atari_mksound;
diff --git a/arch/m68k/kernel/setup.c b/arch/m68k/kernel/setup.c
index 583526f..750d5b3 100644
--- a/arch/m68k/kernel/setup.c
+++ b/arch/m68k/kernel/setup.c
@@ -84,9 +84,6 @@ void (*mach_reset)( void );
 void (*mach_halt)( void );
 void (*mach_power_off)( void );
 long mach_max_dma_address = 0x00ffffff; /* default set to the lower 16MB */
-#if defined(CONFIG_AMIGA_FLOPPY) || defined(CONFIG_ATARI_FLOPPY)
-void (*mach_floppy_setup) (char *, int *) __initdata = NULL;
-#endif
 #ifdef CONFIG_HEARTBEAT
 void (*mach_heartbeat) (int);
 EXPORT_SYMBOL(mach_heartbeat);
@@ -527,16 +524,6 @@ int get_hardware_list(char *buffer)
     return(len);
 }
 
-
-#if defined(CONFIG_AMIGA_FLOPPY) || defined(CONFIG_ATARI_FLOPPY)
-void __init floppy_setup(char *str, int *ints)
-{
-	if (mach_floppy_setup)
-		mach_floppy_setup (str, ints);
-}
-
-#endif
-
 void check_bugs(void)
 {
 #ifndef CONFIG_M68KFPU_EMU
diff --git a/arch/m68k/q40/config.c b/arch/m68k/q40/config.c
index 67e88a4..5e0f9b0 100644
--- a/arch/m68k/q40/config.c
+++ b/arch/m68k/q40/config.c
@@ -36,8 +36,6 @@
 #include <asm/machdep.h>
 #include <asm/q40_master.h>
 
-extern void floppy_setup(char *str, int *ints);
-
 extern irqreturn_t q40_process_int (int level, struct pt_regs *regs);
 extern irqreturn_t (*q40_default_handler[]) (int, void *, struct pt_regs *);  /* added just for debugging */
 extern void q40_init_IRQ (void);
diff --git a/arch/ppc/amiga/config.c b/arch/ppc/amiga/config.c
index 55794d1..60e2da1 100644
--- a/arch/ppc/amiga/config.c
+++ b/arch/ppc/amiga/config.c
@@ -90,9 +90,6 @@ static void a3000_gettod (int *, int *, 
 static void a2000_gettod (int *, int *, int *, int *, int *, int *);
 static int amiga_hwclk (int, struct hwclk_time *);
 static int amiga_set_clock_mmss (unsigned long);
-#ifdef CONFIG_AMIGA_FLOPPY
-extern void amiga_floppy_setup(char *, int *);
-#endif
 static void amiga_reset (void);
 extern void amiga_init_sound(void);
 static void amiga_savekmsg_init(void);
@@ -419,9 +416,6 @@ void __init config_amiga(void)
 
   mach_hwclk           = amiga_hwclk;
   mach_set_clock_mmss  = amiga_set_clock_mmss;
-#ifdef CONFIG_AMIGA_FLOPPY
-  mach_floppy_setup    = amiga_floppy_setup;
-#endif
   mach_reset           = amiga_reset;
 #ifdef CONFIG_HEARTBEAT
   mach_heartbeat = amiga_heartbeat;
diff --git a/arch/ppc/platforms/apus_setup.c b/arch/ppc/platforms/apus_setup.c
index f62179f..c42c500 100644
--- a/arch/ppc/platforms/apus_setup.c
+++ b/arch/ppc/platforms/apus_setup.c
@@ -55,9 +55,6 @@ int (*mach_hwclk) (int, struct hwclk_tim
 int (*mach_set_clock_mmss) (unsigned long) = NULL;
 void (*mach_reset)( void );
 long mach_max_dma_address = 0x00ffffff; /* default set to the lower 16MB */
-#if defined(CONFIG_AMIGA_FLOPPY)
-void (*mach_floppy_setup) (char *, int *) __initdata = NULL;
-#endif
 #ifdef CONFIG_HEARTBEAT
 void (*mach_heartbeat) (int) = NULL;
 extern void apus_heartbeat (void);
@@ -76,7 +73,6 @@ struct mem_info m68k_memory[NUM_MEMINFO]
 
 struct mem_info ramdisk;
 
-extern void amiga_floppy_setup(char *, int *);
 extern void config_amiga(void);
 
 static int __60nsram = 0;
@@ -305,16 +301,6 @@ void kbd_reset_setup(char *str, int *int
 {
 }
 
-/*********************************************************** FLOPPY */
-#if defined(CONFIG_AMIGA_FLOPPY)
-__init
-void floppy_setup(char *str, int *ints)
-{
-	if (mach_floppy_setup)
-		mach_floppy_setup (str, ints);
-}
-#endif
-
 /*********************************************************** MEMORY */
 #define KMAP_MAX 32
 unsigned long kmap_chunks[KMAP_MAX*3];
diff --git a/drivers/block/amiflop.c b/drivers/block/amiflop.c
index ac58521..7f0c073 100644
--- a/drivers/block/amiflop.c
+++ b/drivers/block/amiflop.c
@@ -1654,12 +1654,6 @@ static struct block_device_operations fl
 	.media_changed	= amiga_floppy_change,
 };
 
-void __init amiga_floppy_setup (char *str, int *ints)
-{
-	printk (KERN_INFO "amiflop: Setting default df0 to %x\n", ints[1]);
-	fd_def_df0 = ints[1];
-}
-
 static int __init fd_probe_drives(void)
 {
 	int drive,drives,nomem;
@@ -1845,4 +1839,18 @@ void cleanup_module(void)
 	unregister_blkdev(FLOPPY_MAJOR, "fd");
 }
 #endif
+
+#else
+static int __init amiga_floppy_setup (char *str)
+{
+	int n;
+	if (!MACH_IS_AMIGA)
+		return 0;
+	if (!get_option(&str, &n))
+		return 0;
+	printk (KERN_INFO "amiflop: Setting default df0 to %x\n", n);
+	fd_def_df0 = n;
+}
+
+__setup("floppy=", amiga_floppy_setup);
 #endif
diff --git a/drivers/block/ataflop.c b/drivers/block/ataflop.c
index 577698d..58b6b66 100644
--- a/drivers/block/ataflop.c
+++ b/drivers/block/ataflop.c
@@ -1951,14 +1951,20 @@ Enomem:
 	return -ENOMEM;
 }
 
-
-void __init atari_floppy_setup( char *str, int *ints )
+#ifndef MODULE
+static int __init atari_floppy_setup(char *str)
 {
+	int ints[3 + FD_MAX_UNITS];
 	int i;
+
+	if (!MACH_IS_ATARI)
+		return 0;
+
+	str = get_options(str, 3 + FD_MAX_UNITS, ints);
 	
 	if (ints[0] < 1) {
 		printk(KERN_ERR "ataflop_setup: no arguments!\n" );
-		return;
+		return 0;
 	}
 	else if (ints[0] > 2+FD_MAX_UNITS) {
 		printk(KERN_ERR "ataflop_setup: too many arguments\n" );
@@ -1978,9 +1984,13 @@ void __init atari_floppy_setup( char *st
 		else
 			UserSteprate[i-3] = ints[i];
 	}
+	return 1;
 }
 
-static void atari_floppy_exit(void)
+__setup("floppy=", atari_floppy_setup);
+#endif
+
+static void __exit atari_floppy_exit(void)
 {
 	int i;
 	blk_unregister_region(MKDEV(FLOPPY_MAJOR, 0), 256);
diff --git a/include/asm-m68k/machdep.h b/include/asm-m68k/machdep.h
index a0dd5c4..7d3fee3 100644
--- a/include/asm-m68k/machdep.h
+++ b/include/asm-m68k/machdep.h
@@ -34,7 +34,6 @@ extern void (*mach_power_off)( void );
 extern unsigned long (*mach_hd_init) (unsigned long, unsigned long);
 extern void (*mach_hd_setup)(char *, int *);
 extern long mach_max_dma_address;
-extern void (*mach_floppy_setup)(char *, int *);
 extern void (*mach_heartbeat) (int);
 extern void (*mach_l2_flush) (int);
 extern void (*mach_beep) (unsigned int, unsigned int);
diff --git a/include/asm-m68knommu/machdep.h b/include/asm-m68knommu/machdep.h
index 5a9f9c2..27c90af 100644
--- a/include/asm-m68knommu/machdep.h
+++ b/include/asm-m68knommu/machdep.h
@@ -38,7 +38,6 @@ extern void (*mach_power_off)( void );
 extern unsigned long (*mach_hd_init) (unsigned long, unsigned long);
 extern void (*mach_hd_setup)(char *, int *);
 extern long mach_max_dma_address;
-extern void (*mach_floppy_setup)(char *, int *);
 extern void (*mach_floppy_eject)(void);
 extern void (*mach_heartbeat) (int);
 extern void (*mach_l2_flush) (int);
-- 
0.99.9.GIT

