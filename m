Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263335AbUDMIsT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Apr 2004 04:48:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263424AbUDMIrh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Apr 2004 04:47:37 -0400
Received: from amsfep16-int.chello.nl ([213.46.243.26]:8250 "EHLO
	amsfep16-int.chello.nl") by vger.kernel.org with ESMTP
	id S263335AbUDMIie (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Apr 2004 04:38:34 -0400
Date: Tue, 13 Apr 2004 10:38:11 +0200
Message-Id: <200404130838.i3D8cBxO018467@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 431] M68k initializers cleanup
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

M68k: Clean up initializers:
  - Convert struct/array initializers to C99 style
  - Do not initialize data to 0 or NULL explicitly so it can move to bss

--- linux-2.6.5-rc2/arch/m68k/amiga/amiints.c	2004-03-11 10:20:31.000000000 +0100
+++ linux-m68k-2.6.5-rc2/arch/m68k/amiga/amiints.c	2004-03-21 13:21:11.000000000 +0100
@@ -61,11 +61,25 @@
 static irq_node_t *ami_irq_list[AMI_STD_IRQS];
 
 static unsigned short amiga_intena_vals[AMI_STD_IRQS] = {
-	IF_VERTB, IF_COPER, IF_AUD0, IF_AUD1, IF_AUD2, IF_AUD3, IF_BLIT,
-	IF_DSKSYN, IF_DSKBLK, IF_RBF, IF_TBE, IF_SOFT, IF_PORTS, IF_EXTER
+	[IRQ_AMIGA_VERTB]	= IF_VERTB,
+	[IRQ_AMIGA_COPPER]	= IF_COPER,
+	[IRQ_AMIGA_AUD0]	= IF_AUD0,
+	[IRQ_AMIGA_AUD1]	= IF_AUD1,
+	[IRQ_AMIGA_AUD2]	= IF_AUD2,
+	[IRQ_AMIGA_AUD3]	= IF_AUD3,
+	[IRQ_AMIGA_BLIT]	= IF_BLIT,
+	[IRQ_AMIGA_DSKSYN]	= IF_DSKSYN,
+	[IRQ_AMIGA_DSKBLK]	= IF_DSKBLK,
+	[IRQ_AMIGA_RBF]		= IF_RBF,
+	[IRQ_AMIGA_TBE]		= IF_TBE,
+	[IRQ_AMIGA_SOFT]	= IF_SOFT,
+	[IRQ_AMIGA_PORTS]	= IF_PORTS,
+	[IRQ_AMIGA_EXTER]	= IF_EXTER
 };
 static const unsigned char ami_servers[AMI_STD_IRQS] = {
-	1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1
+	[IRQ_AMIGA_VERTB]	= 1,
+	[IRQ_AMIGA_PORTS]	= 1,
+	[IRQ_AMIGA_EXTER]	= 1
 };
 
 static short ami_ablecount[AMI_IRQS];
@@ -469,8 +483,14 @@
 }
 
 irqreturn_t (*amiga_default_handler[SYS_IRQS])(int, void *, struct pt_regs *) = {
-	ami_badint, ami_int1, ami_badint, ami_int3,
-	ami_int4, ami_int5, ami_badint, ami_int7
+	[0] = ami_badint,
+	[1] = ami_int1,
+	[2] = ami_badint,
+	[3] = ami_int3,
+	[4] = ami_int4,
+	[5] = ami_int5,
+	[6] = ami_badint,
+	[7] = ami_int7
 };
 
 int show_amiga_interrupts(struct seq_file *p, void *v)
--- linux-2.6.5-rc2/arch/m68k/amiga/amisound.c	2004-01-21 22:03:12.000000000 +0100
+++ linux-m68k-2.6.5-rc2/arch/m68k/amiga/amisound.c	2004-03-21 22:25:43.000000000 +0100
@@ -17,7 +17,7 @@
 #include <asm/system.h>
 #include <asm/amigahw.h>
 
-static unsigned short *snd_data = NULL;
+static unsigned short *snd_data;
 static const signed char sine_data[] = {
 	0,  39,  75,  103,  121,  127,  121,  103,  75,  39,
 	0, -39, -75, -103, -121, -127, -121, -103, -75, -39
--- linux-2.6.5-rc2/arch/m68k/amiga/cia.c	2003-05-27 19:02:32.000000000 +0200
+++ linux-m68k-2.6.5-rc2/arch/m68k/amiga/cia.c	2004-03-21 13:21:11.000000000 +0100
@@ -31,15 +31,19 @@
 	char *name;
 	irq_handler_t irq_list[CIA_IRQS];
 } ciaa_base = {
-	&ciaa, 0, 0, IF_PORTS,
-	IRQ_AMIGA_AUTO_2, IRQ_AMIGA_CIAA,
-	IRQ_AMIGA_PORTS,
-	"CIAA handler"
+	.cia		= &ciaa,
+	.int_mask	= IF_PORTS,
+	.handler_irq	= IRQ_AMIGA_AUTO_2,
+	.cia_irq	= IRQ_AMIGA_CIAA,
+	.server_irq	= IRQ_AMIGA_PORTS,
+	.name		= "CIAA handler"
 }, ciab_base = {
-	&ciab, 0, 0, IF_EXTER,
-	IRQ_AMIGA_AUTO_6, IRQ_AMIGA_CIAB,
-	IRQ_AMIGA_EXTER,
-	"CIAB handler"
+	.cia		= &ciab,
+	.int_mask	= IF_EXTER,
+	.handler_irq	= IRQ_AMIGA_AUTO_6,
+	.cia_irq	= IRQ_AMIGA_CIAB,
+	.server_irq	= IRQ_AMIGA_EXTER,
+	.name		= "CIAB handler"
 };
 
 /*
--- linux-2.6.5-rc2/arch/m68k/amiga/config.c	2004-01-21 22:03:12.000000000 +0100
+++ linux-m68k-2.6.5-rc2/arch/m68k/amiga/config.c	2004-03-28 11:40:13.000000000 +0200
@@ -63,8 +63,21 @@
 static char s_cd32[] __initdata = "CD32";
 static char s_draco[] __initdata = "Draco";
 static char *amiga_models[] __initdata = {
-    s_a500, s_a500p, s_a600, s_a1000, s_a1200, s_a2000, s_a2500, s_a3000,
-    s_a3000t, s_a3000p, s_a4000, s_a4000t, s_cdtv, s_cd32, s_draco,
+    [AMI_500-AMI_500]		= s_a500,
+    [AMI_500PLUS-AMI_500]	= s_a500p,
+    [AMI_600-AMI_500]		= s_a600,
+    [AMI_1000-AMI_500]		= s_a1000,
+    [AMI_1200-AMI_500]		= s_a1200,
+    [AMI_2000-AMI_500]		= s_a2000,
+    [AMI_2500-AMI_500]		= s_a2500,
+    [AMI_3000-AMI_500]		= s_a3000,
+    [AMI_3000T-AMI_500]		= s_a3000t,
+    [AMI_3000PLUS-AMI_500]	= s_a3000p,
+    [AMI_4000-AMI_500]		= s_a4000,
+    [AMI_4000T-AMI_500]		= s_a4000t,
+    [AMI_CDTV-AMI_500]		= s_cdtv,
+    [AMI_CD32-AMI_500]		= s_cd32,
+    [AMI_DRACO-AMI_500]		= s_draco,
 };
 
 static char amiga_model_name[13] = "Amiga ";
@@ -793,7 +833,7 @@
     char data[0];
 };
 
-static struct savekmsg *savekmsg = NULL;
+static struct savekmsg *savekmsg;
 
 static void amiga_mem_console_write(struct console *co, const char *s,
 				    unsigned int count)
--- linux-2.6.5-rc2/arch/m68k/apollo/config.c	2003-07-29 18:18:35.000000000 +0200
+++ linux-m68k-2.6.5-rc2/arch/m68k/apollo/config.c	2004-03-28 11:42:57.000000000 +0200
@@ -49,11 +49,12 @@
 static irqreturn_t (*sched_timer_handler)(int, void *, struct pt_regs *)=NULL;
 static void dn_get_model(char *model);
 static const char *apollo_models[] = {
-	"DN3000 (Otter)",
-	"DN3010 (Otter)",
-	"DN3500 (Cougar II)",
-	"DN4000 (Mink)",
-	"DN4500 (Roadrunner)" };
+	[APOLLO_DN3000-APOLLO_DN3000] = "DN3000 (Otter)",
+	[APOLLO_DN3010-APOLLO_DN3000] = "DN3010 (Otter)",
+	[APOLLO_DN3500-APOLLO_DN3000] = "DN3500 (Cougar II)",
+	[APOLLO_DN4000-APOLLO_DN3000] = "DN4000 (Mink)",
+	[APOLLO_DN4500-APOLLO_DN3000] = "DN4500 (Roadrunner)"
+};
 
 int apollo_parse_bootinfo(const struct bi_record *record) {
 
--- linux-2.6.5-rc2/arch/m68k/atari/ataints.c	2003-05-27 19:02:32.000000000 +0200
+++ linux-m68k-2.6.5-rc2/arch/m68k/atari/ataints.c	2004-03-21 22:08:57.000000000 +0100
@@ -138,7 +138,7 @@
  * (new vectors starting from 0x70 can be allocated by
  * atari_register_vme_int())
  */
-static int free_vme_vec_bitmap = 0;
+static int free_vme_vec_bitmap;
 
 /* check for valid int number (complex, sigh...) */
 #define	IS_VALID_INTNO(n)											\
@@ -233,38 +233,38 @@
 BUILD_SLOW_IRQ(31);
 
 asm_irq_handler slow_handlers[32] = {
-	atari_slow_irq_0_handler,
-	atari_slow_irq_1_handler,
-	atari_slow_irq_2_handler,
-	atari_slow_irq_3_handler,
-	atari_slow_irq_4_handler,
-	atari_slow_irq_5_handler,
-	atari_slow_irq_6_handler,
-	atari_slow_irq_7_handler,
-	atari_slow_irq_8_handler,
-	atari_slow_irq_9_handler,
-	atari_slow_irq_10_handler,
-	atari_slow_irq_11_handler,
-	atari_slow_irq_12_handler,
-	atari_slow_irq_13_handler,
-	atari_slow_irq_14_handler,
-	atari_slow_irq_15_handler,
-	atari_slow_irq_16_handler,
-	atari_slow_irq_17_handler,
-	atari_slow_irq_18_handler,
-	atari_slow_irq_19_handler,
-	atari_slow_irq_20_handler,
-	atari_slow_irq_21_handler,
-	atari_slow_irq_22_handler,
-	atari_slow_irq_23_handler,
-	atari_slow_irq_24_handler,
-	atari_slow_irq_25_handler,
-	atari_slow_irq_26_handler,
-	atari_slow_irq_27_handler,
-	atari_slow_irq_28_handler,
-	atari_slow_irq_29_handler,
-	atari_slow_irq_30_handler,
-	atari_slow_irq_31_handler
+	[0]	= atari_slow_irq_0_handler,
+	[1]	= atari_slow_irq_1_handler,
+	[2]	= atari_slow_irq_2_handler,
+	[3]	= atari_slow_irq_3_handler,
+	[4]	= atari_slow_irq_4_handler,
+	[5]	= atari_slow_irq_5_handler,
+	[6]	= atari_slow_irq_6_handler,
+	[7]	= atari_slow_irq_7_handler,
+	[8]	= atari_slow_irq_8_handler,
+	[9]	= atari_slow_irq_9_handler,
+	[10]	= atari_slow_irq_10_handler,
+	[11]	= atari_slow_irq_11_handler,
+	[12]	= atari_slow_irq_12_handler,
+	[13]	= atari_slow_irq_13_handler,
+	[14]	= atari_slow_irq_14_handler,
+	[15]	= atari_slow_irq_15_handler,
+	[16]	= atari_slow_irq_16_handler,
+	[17]	= atari_slow_irq_17_handler,
+	[18]	= atari_slow_irq_18_handler,
+	[19]	= atari_slow_irq_19_handler,
+	[20]	= atari_slow_irq_20_handler,
+	[21]	= atari_slow_irq_21_handler,
+	[22]	= atari_slow_irq_22_handler,
+	[23]	= atari_slow_irq_23_handler,
+	[24]	= atari_slow_irq_24_handler,
+	[25]	= atari_slow_irq_25_handler,
+	[26]	= atari_slow_irq_26_handler,
+	[27]	= atari_slow_irq_27_handler,
+	[28]	= atari_slow_irq_28_handler,
+	[29]	= atari_slow_irq_29_handler,
+	[30]	= atari_slow_irq_30_handler,
+	[31]	= atari_slow_irq_31_handler
 };
 
 asmlinkage void atari_fast_irq_handler( void );
--- linux-2.6.5-rc2/arch/m68k/atari/config.c	2004-02-29 09:30:36.000000000 +0100
+++ linux-m68k-2.6.5-rc2/arch/m68k/atari/config.c	2004-03-21 22:09:39.000000000 +0100
@@ -44,10 +44,10 @@
 #include <asm/io.h>
 
 u_long atari_mch_cookie;
-u_long atari_mch_type = 0;
+u_long atari_mch_type;
 struct atari_hw_present atari_hw_present;
-u_long atari_switches = 0;
-int atari_dont_touch_floppy_select = 0;
+u_long atari_switches;
+int atari_dont_touch_floppy_select;
 int atari_rtc_year_offset;
 
 /* local function prototypes */
@@ -99,7 +99,7 @@
 {
     int		ret;
     long	save_sp, save_vbr;
-    static long tmp_vectors[3] = { 0, 0, (long)&&after_test };
+    static long tmp_vectors[3] = { [2] = (long)&&after_test };
 	
     __asm__ __volatile__
 	(	"movec	%/vbr,%2\n\t"	/* save vbr value            */
--- linux-2.6.5-rc2/arch/m68k/atari/debug.c	2002-07-25 12:53:33.000000000 +0200
+++ linux-m68k-2.6.5-rc2/arch/m68k/atari/debug.c	2004-03-21 22:10:04.000000000 +0100
@@ -23,12 +23,12 @@
 extern char m68k_debug_device[];
 
 /* Flag that Modem1 port is already initialized and used */
-int atari_MFP_init_done = 0;
+int atari_MFP_init_done;
 /* Flag that Modem1 port is already initialized and used */
-int atari_SCC_init_done = 0;
+int atari_SCC_init_done;
 /* Can be set somewhere, if a SCC master reset has already be done and should
  * not be repeated; used by kgdb */
-int atari_SCC_reset_done = 0;
+int atari_SCC_reset_done;
 
 static struct console atari_console_driver = {
 	.name =		"debug",
--- linux-2.6.5-rc2/arch/m68k/atari/hades-pci.c	2004-01-21 22:03:12.000000000 +0100
+++ linux-m68k-2.6.5-rc2/arch/m68k/atari/hades-pci.c	2004-03-21 21:01:16.000000000 +0100
@@ -299,11 +299,11 @@
 static void __init hades_fixup(int pci_modify)
 {
 	char irq_tab[4] = {
-			    IRQ_TT_MFP_IO0,	/* Slot 0. */
-			    IRQ_TT_MFP_IO1,	/* Slot 1. */
-			    IRQ_TT_MFP_SCC,	/* Slot 2. */
-			    IRQ_TT_MFP_SCSIDMA	/* Slot 3. */
-			  };
+		[0] = IRQ_TT_MFP_IO0,		/* Slot 0. */
+		[1] = IRQ_TT_MFP_IO1,		/* Slot 1. */
+		[2] = IRQ_TT_MFP_SCC,		/* Slot 2. */
+		[3] = IRQ_TT_MFP_SCSIDMA	/* Slot 3. */
+	};
 	struct pci_dev *dev = NULL;
 	unsigned char slot;
 
--- linux-2.6.5-rc2/arch/m68k/atari/stdma.c	2003-05-27 19:02:32.000000000 +0200
+++ linux-m68k-2.6.5-rc2/arch/m68k/atari/stdma.c	2004-03-21 22:26:33.000000000 +0100
@@ -41,10 +41,10 @@
 #include <asm/io.h>
 #include <asm/irq.h>
 
-static int stdma_locked = 0;			/* the semaphore */
+static int stdma_locked;			/* the semaphore */
 						/* int func to be called */
-static irqreturn_t (*stdma_isr)(int, void *, struct pt_regs *) = NULL;
-static void *stdma_isr_data = NULL;		/* data passed to isr */
+static irqreturn_t (*stdma_isr)(int, void *, struct pt_regs *);
+static void *stdma_isr_data;			/* data passed to isr */
 static DECLARE_WAIT_QUEUE_HEAD(stdma_wait);	/* wait queue for ST-DMA */
 
 
--- linux-2.6.5-rc2/arch/m68k/atari/stram.c	2003-10-09 10:02:24.000000000 +0200
+++ linux-m68k-2.6.5-rc2/arch/m68k/atari/stram.c	2004-03-21 22:27:04.000000000 +0100
@@ -150,7 +150,7 @@
 
 /* set after memory_init() executed and allocations via start_mem aren't
  * possible anymore */
-static int mem_init_done = 0;
+static int mem_init_done;
 
 /* set if kernel is in ST-RAM */
 static int kernel_in_stram;
@@ -170,7 +170,7 @@
 #define BLOCK_INSWAP	0x10	/* block allocated in swap space */
 
 /* list of allocated blocks */
-static BLOCK *alloc_list = NULL;
+static BLOCK *alloc_list;
 
 /* We can't always use kmalloc() to allocate BLOCK structures, since
  * stram_alloc() can be called rather early. So we need some pool of
@@ -210,9 +210,9 @@
 #define MAGIC_FILE_P	(struct file *)0xffffdead
 
 #ifdef DO_PROC
-static unsigned stat_swap_read = 0;
-static unsigned stat_swap_write = 0;
-static unsigned stat_swap_force = 0;
+static unsigned stat_swap_read;
+static unsigned stat_swap_write;
+static unsigned stat_swap_force;
 #endif /* DO_PROC */
 
 #endif /* CONFIG_STRAM_SWAP */
@@ -967,7 +967,7 @@
 /*								ST-RAM device								*/
 /* ------------------------------------------------------------------------ */
 
-static int refcnt = 0;
+static int refcnt;
 
 static void do_stram_request(request_queue_t *q)
 {
--- linux-2.6.5-rc2/arch/m68k/bvme6000/rtc.c	2004-01-21 22:03:12.000000000 +0100
+++ linux-m68k-2.6.5-rc2/arch/m68k/bvme6000/rtc.c	2004-03-21 22:12:47.000000000 +0100
@@ -36,7 +36,7 @@
 static unsigned char days_in_mo[] =
 {0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};
 
-static char rtc_status = 0;
+static char rtc_status;
 
 static int rtc_ioctl(struct inode *inode, struct file *file, unsigned int cmd,
 		     unsigned long arg)
--- linux-2.6.5-rc2/arch/m68k/hp300/ints.c	2003-05-27 19:02:32.000000000 +0200
+++ linux-m68k-2.6.5-rc2/arch/m68k/hp300/ints.c	2004-03-21 21:02:03.000000000 +0100
@@ -37,7 +37,7 @@
  */
 
 /* we start with no entries in any list */
-static irq_node_t *hp300_irq_list[HP300_NUM_IRQS] = { [0 ... HP300_NUM_IRQS-1] = NULL };
+static irq_node_t *hp300_irq_list[HP300_NUM_IRQS];
 
 static spinlock_t irqlist_lock;
 
@@ -58,8 +58,13 @@
 }
 
 irqreturn_t (*hp300_default_handler[SYS_IRQS])(int, void *, struct pt_regs *) = {
-	hp300_int_handler, hp300_int_handler, hp300_int_handler, hp300_int_handler,
-	hp300_int_handler, hp300_int_handler, hp300_int_handler, NULL
+	[0] = hp300_int_handler,
+	[1] = hp300_int_handler,
+	[2] = hp300_int_handler,
+	[3] = hp300_int_handler,
+	[4] = hp300_int_handler,
+	[5] = hp300_int_handler,
+	[6] = hp300_int_handler,
 };
 
 /* dev_id had better be unique to each handler because it's the only way we have
--- linux-2.6.5-rc2/arch/m68k/kernel/bios32.c	2004-02-16 23:25:51.000000000 +0100
+++ linux-m68k-2.6.5-rc2/arch/m68k/kernel/bios32.c	2004-03-21 22:13:26.000000000 +0100
@@ -70,9 +70,9 @@
 static struct pci_bus_info *bus_info;
 
 static int pci_modify = 1;		/* If set, layout the PCI bus ourself. */
-static int skip_vga = 0;		/* If set do not modify base addresses
+static int skip_vga;			/* If set do not modify base addresses
 					   of vga cards.*/
-static int disable_pci_burst = 0;	/* If set do not allow PCI bursts. */
+static int disable_pci_burst;		/* If set do not allow PCI bursts. */
 
 static unsigned int io_base;
 static unsigned int mem_base;
--- linux-2.6.5-rc2/arch/m68k/kernel/ints.c	2004-03-11 10:20:31.000000000 +0100
+++ linux-m68k-2.6.5-rc2/arch/m68k/kernel/ints.c	2004-03-21 13:21:11.000000000 +0100
@@ -48,8 +48,14 @@
 static irq_handler_t irq_list[SYS_IRQS];
 
 static const char *default_names[SYS_IRQS] = {
-	"spurious int", "int1 handler", "int2 handler", "int3 handler",
-	"int4 handler", "int5 handler", "int6 handler", "int7 handler"
+	[0] = "spurious int",
+	[1] = "int1 handler",
+	[2] = "int2 handler",
+	[3] = "int3 handler",
+	[4] = "int4 handler",
+	[5] = "int5 handler",
+	[6] = "int6 handler",
+	[7] = "int7 handler"
 };
 
 /* The number of spurious interrupts */
--- linux-2.6.5-rc2/arch/m68k/kernel/ptrace.c	2003-05-27 19:02:33.000000000 +0200
+++ linux-m68k-2.6.5-rc2/arch/m68k/kernel/ptrace.c	2004-03-21 21:03:31.000000000 +0100
@@ -46,11 +46,25 @@
    saved.  Notice that usp has no stack-slot and needs to be treated
    specially (see get_reg/put_reg below). */
 static int regoff[] = {
-	PT_REG(d1), PT_REG(d2), PT_REG(d3), PT_REG(d4),
-	PT_REG(d5), SW_REG(d6), SW_REG(d7), PT_REG(a0),
-	PT_REG(a1), PT_REG(a2), SW_REG(a3), SW_REG(a4),
-	SW_REG(a5), SW_REG(a6), PT_REG(d0), -1,
-	PT_REG(orig_d0), PT_REG(sr), PT_REG(pc),
+	[0]	= PT_REG(d1),
+	[1]	= PT_REG(d2),
+	[2]	= PT_REG(d3),
+	[3]	= PT_REG(d4),
+	[4]	= PT_REG(d5),
+	[5]	= SW_REG(d6),
+	[6]	= SW_REG(d7),
+	[7]	= PT_REG(a0),
+	[8]	= PT_REG(a1),
+	[9]	= PT_REG(a2),
+	[10]	= SW_REG(a3),
+	[11]	= SW_REG(a4),
+	[12]	= SW_REG(a5),
+	[13]	= SW_REG(a6),
+	[14]	= PT_REG(d0),
+	[15]	= -1,
+	[16]	= PT_REG(orig_d0),
+	[17]	= PT_REG(sr),
+	[18]	= PT_REG(pc),
 };
 
 /*
--- linux-2.6.5-rc2/arch/m68k/kernel/setup.c	2004-03-04 11:30:25.000000000 +0100
+++ linux-m68k-2.6.5-rc2/arch/m68k/kernel/setup.c	2004-03-21 22:28:18.000000000 +0100
@@ -49,17 +49,17 @@
 unsigned long vme_brdtype;
 #endif
 
-int m68k_is040or060 = 0;
+int m68k_is040or060;
 
 extern int end;
 extern unsigned long availmem;
 
-int m68k_num_memory = 0;
-int m68k_realnum_memory = 0;
+int m68k_num_memory;
+int m68k_realnum_memory;
 unsigned long m68k_memoffset;
 struct mem_info m68k_memory[NUM_MEMINFO];
 
-static struct mem_info m68k_ramdisk = { 0, 0 };
+static struct mem_info m68k_ramdisk;
 
 static char m68k_command_line[CL_SIZE];
 char saved_command_line[CL_SIZE];
@@ -69,34 +69,34 @@
 void (*mach_sched_init) (irqreturn_t (*handler)(int, void *, struct pt_regs *)) __initdata = NULL;
 /* machine dependent irq functions */
 void (*mach_init_IRQ) (void) __initdata = NULL;
-irqreturn_t (*(*mach_default_handler)[]) (int, void *, struct pt_regs *) = NULL;
-void (*mach_get_model) (char *model) = NULL;
-int (*mach_get_hardware_list) (char *buffer) = NULL;
-int (*mach_get_irq_list) (struct seq_file *, void *) = NULL;
-irqreturn_t (*mach_process_int) (int, struct pt_regs *) = NULL;
+irqreturn_t (*(*mach_default_handler)[]) (int, void *, struct pt_regs *);
+void (*mach_get_model) (char *model);
+int (*mach_get_hardware_list) (char *buffer);
+int (*mach_get_irq_list) (struct seq_file *, void *);
+irqreturn_t (*mach_process_int) (int, struct pt_regs *);
 /* machine dependent timer functions */
 unsigned long (*mach_gettimeoffset) (void);
-int (*mach_hwclk) (int, struct rtc_time*) = NULL;
-int (*mach_set_clock_mmss) (unsigned long) = NULL;
-unsigned int (*mach_get_ss)(void) = NULL;
-int (*mach_get_rtc_pll)(struct rtc_pll_info *) = NULL;
-int (*mach_set_rtc_pll)(struct rtc_pll_info *) = NULL;
+int (*mach_hwclk) (int, struct rtc_time*);
+int (*mach_set_clock_mmss) (unsigned long);
+unsigned int (*mach_get_ss)(void);
+int (*mach_get_rtc_pll)(struct rtc_pll_info *);
+int (*mach_set_rtc_pll)(struct rtc_pll_info *);
 void (*mach_reset)( void );
-void (*mach_halt)( void ) = NULL;
-void (*mach_power_off)( void ) = NULL;
+void (*mach_halt)( void );
+void (*mach_power_off)( void );
 long mach_max_dma_address = 0x00ffffff; /* default set to the lower 16MB */
 #if defined(CONFIG_AMIGA_FLOPPY) || defined(CONFIG_ATARI_FLOPPY) 
 void (*mach_floppy_setup) (char *, int *) __initdata = NULL;
 #endif
 #ifdef CONFIG_HEARTBEAT
-void (*mach_heartbeat) (int) = NULL;
+void (*mach_heartbeat) (int);
 EXPORT_SYMBOL(mach_heartbeat);
 #endif
 #ifdef CONFIG_M68K_L2_CACHE
-void (*mach_l2_flush) (int) = NULL;
+void (*mach_l2_flush) (int);
 #endif
 #if defined(CONFIG_INPUT_M68K_BEEP) || defined(CONFIG_INPUT_M68K_BEEP_MODULE)
-void (*mach_beep)(unsigned int, unsigned int) = NULL;
+void (*mach_beep)(unsigned int, unsigned int);
 #endif
 #if defined(CONFIG_ISA) && defined(MULTI_ISA)
 int isa_type;
--- linux-2.6.5-rc2/arch/m68k/kernel/signal.c	2004-02-29 09:30:37.000000000 +0100
+++ linux-m68k-2.6.5-rc2/arch/m68k/kernel/signal.c	2004-03-21 22:15:18.000000000 +0100
@@ -54,22 +54,21 @@
 asmlinkage int do_signal(sigset_t *oldset, struct pt_regs *regs);
 
 const int frame_extra_sizes[16] = {
-  0,
-  -1, /* sizeof(((struct frame *)0)->un.fmt1), */
-  sizeof(((struct frame *)0)->un.fmt2),
-  sizeof(((struct frame *)0)->un.fmt3),
-  sizeof(((struct frame *)0)->un.fmt4),
-  -1, /* sizeof(((struct frame *)0)->un.fmt5), */
-  -1, /* sizeof(((struct frame *)0)->un.fmt6), */
-  sizeof(((struct frame *)0)->un.fmt7),
-  -1, /* sizeof(((struct frame *)0)->un.fmt8), */
-  sizeof(((struct frame *)0)->un.fmt9),
-  sizeof(((struct frame *)0)->un.fmta),
-  sizeof(((struct frame *)0)->un.fmtb),
-  -1, /* sizeof(((struct frame *)0)->un.fmtc), */
-  -1, /* sizeof(((struct frame *)0)->un.fmtd), */
-  -1, /* sizeof(((struct frame *)0)->un.fmte), */
-  -1, /* sizeof(((struct frame *)0)->un.fmtf), */
+  [1]	= -1, /* sizeof(((struct frame *)0)->un.fmt1), */
+  [2]	= sizeof(((struct frame *)0)->un.fmt2),
+  [3]	= sizeof(((struct frame *)0)->un.fmt3),
+  [4]	= sizeof(((struct frame *)0)->un.fmt4),
+  [5]	= -1, /* sizeof(((struct frame *)0)->un.fmt5), */
+  [6]	= -1, /* sizeof(((struct frame *)0)->un.fmt6), */
+  [7]	= sizeof(((struct frame *)0)->un.fmt7),
+  [8]	= -1, /* sizeof(((struct frame *)0)->un.fmt8), */
+  [9]	= sizeof(((struct frame *)0)->un.fmt9),
+  [10]	= sizeof(((struct frame *)0)->un.fmta),
+  [11]	= sizeof(((struct frame *)0)->un.fmtb),
+  [12]	= -1, /* sizeof(((struct frame *)0)->un.fmtc), */
+  [13]	= -1, /* sizeof(((struct frame *)0)->un.fmtd), */
+  [14]	= -1, /* sizeof(((struct frame *)0)->un.fmte), */
+  [15]	= -1, /* sizeof(((struct frame *)0)->un.fmtf), */
 };
 
 /*
@@ -191,7 +190,7 @@
 };
 
 
-static unsigned char fpu_version = 0;	/* version number of fpu, set by setup_frame */
+static unsigned char fpu_version;	/* version number of fpu, set by setup_frame */
 
 static inline int restore_fpu_state(struct sigcontext *sc)
 {
--- linux-2.6.5-rc2/arch/m68k/kernel/traps.c	2004-02-29 09:30:37.000000000 +0100
+++ linux-m68k-2.6.5-rc2/arch/m68k/kernel/traps.c	2004-03-21 20:44:20.000000000 +0100
@@ -52,15 +52,52 @@
 #endif
 
 e_vector vectors[256] = {
-	0, 0, buserr, trap, trap, trap, trap, trap,
-	trap, trap, trap, trap, trap, trap, trap, trap,
-	trap, trap, trap, trap, trap, trap, trap, trap,
-	inthandler, inthandler, inthandler, inthandler,
-	inthandler, inthandler, inthandler, inthandler,
-	/* TRAP #0-15 */
-	system_call, trap, trap, trap, trap, trap, trap, trap,
-	trap, trap, trap, trap, trap, trap, trap, trap,
-	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
+	[VEC_BUSERR]	= buserr,
+	[VEC_ADDRERR]	= trap,
+	[VEC_ILLEGAL]	= trap,
+	[VEC_ZERODIV]	= trap,
+	[VEC_CHK]	= trap,
+	[VEC_TRAP]	= trap,
+	[VEC_PRIV]	= trap,
+	[VEC_TRACE]	= trap,
+	[VEC_LINE10]	= trap,
+	[VEC_LINE11]	= trap,
+	[VEC_RESV12]	= trap,
+	[VEC_COPROC]	= trap,
+	[VEC_FORMAT]	= trap,
+	[VEC_UNINT]	= trap,
+	[VEC_RESV16]	= trap,
+	[VEC_RESV17]	= trap,
+	[VEC_RESV18]	= trap,
+	[VEC_RESV19]	= trap,
+	[VEC_RESV20]	= trap,
+	[VEC_RESV21]	= trap,
+	[VEC_RESV22]	= trap,
+	[VEC_RESV23]	= trap,
+	[VEC_SPUR]	= inthandler,
+	[VEC_INT1]	= inthandler,
+	[VEC_INT2]	= inthandler,
+	[VEC_INT3]	= inthandler,
+	[VEC_INT4]	= inthandler,
+	[VEC_INT5]	= inthandler,
+	[VEC_INT6]	= inthandler,
+	[VEC_INT7]	= inthandler,
+	[VEC_SYS]	= system_call,
+	[VEC_TRAP1]	= trap,
+	[VEC_TRAP2]	= trap,
+	[VEC_TRAP3]	= trap,
+	[VEC_TRAP4]	= trap,
+	[VEC_TRAP5]	= trap,
+	[VEC_TRAP6]	= trap,
+	[VEC_TRAP7]	= trap,
+	[VEC_TRAP8]	= trap,
+	[VEC_TRAP9]	= trap,
+	[VEC_TRAP10]	= trap,
+	[VEC_TRAP11]	= trap,
+	[VEC_TRAP12]	= trap,
+	[VEC_TRAP13]	= trap,
+	[VEC_TRAP14]	= trap,
+	[VEC_TRAP15]	= trap,
 };
 
 /* nmi handler for the Amiga */
@@ -160,39 +197,87 @@
 }
 
 
-static char *vec_names[] = {
-	"RESET SP", "RESET PC", "BUS ERROR", "ADDRESS ERROR",
-	"ILLEGAL INSTRUCTION", "ZERO DIVIDE", "CHK", "TRAPcc",
-	"PRIVILEGE VIOLATION", "TRACE", "LINE 1010", "LINE 1111",
-	"UNASSIGNED RESERVED 12", "COPROCESSOR PROTOCOL VIOLATION",
-	"FORMAT ERROR", "UNINITIALIZED INTERRUPT",
-	"UNASSIGNED RESERVED 16", "UNASSIGNED RESERVED 17",
-	"UNASSIGNED RESERVED 18", "UNASSIGNED RESERVED 19",
-	"UNASSIGNED RESERVED 20", "UNASSIGNED RESERVED 21",
-	"UNASSIGNED RESERVED 22", "UNASSIGNED RESERVED 23",
-	"SPURIOUS INTERRUPT", "LEVEL 1 INT", "LEVEL 2 INT", "LEVEL 3 INT",
-	"LEVEL 4 INT", "LEVEL 5 INT", "LEVEL 6 INT", "LEVEL 7 INT",
-	"SYSCALL", "TRAP #1", "TRAP #2", "TRAP #3",
-	"TRAP #4", "TRAP #5", "TRAP #6", "TRAP #7",
-	"TRAP #8", "TRAP #9", "TRAP #10", "TRAP #11",
-	"TRAP #12", "TRAP #13", "TRAP #14", "TRAP #15",
-	"FPCP BSUN", "FPCP INEXACT", "FPCP DIV BY 0", "FPCP UNDERFLOW",
-	"FPCP OPERAND ERROR", "FPCP OVERFLOW", "FPCP SNAN",
-	"FPCP UNSUPPORTED OPERATION",
-	"MMU CONFIGURATION ERROR"
-	};
+static const char *vec_names[] = {
+	[VEC_RESETSP]	= "RESET SP",
+	[VEC_RESETPC]	= "RESET PC",
+	[VEC_BUSERR]	= "BUS ERROR",
+	[VEC_ADDRERR]	= "ADDRESS ERROR",
+	[VEC_ILLEGAL]	= "ILLEGAL INSTRUCTION",
+	[VEC_ZERODIV]	= "ZERO DIVIDE",
+	[VEC_CHK]	= "CHK",
+	[VEC_TRAP]	= "TRAPcc",
+	[VEC_PRIV]	= "PRIVILEGE VIOLATION",
+	[VEC_TRACE]	= "TRACE",
+	[VEC_LINE10]	= "LINE 1010",
+	[VEC_LINE11]	= "LINE 1111",
+	[VEC_RESV12]	= "UNASSIGNED RESERVED 12",
+	[VEC_COPROC]	= "COPROCESSOR PROTOCOL VIOLATION",
+	[VEC_FORMAT]	= "FORMAT ERROR",
+	[VEC_UNINT]	= "UNINITIALIZED INTERRUPT",
+	[VEC_RESV16]	= "UNASSIGNED RESERVED 16",
+	[VEC_RESV17]	= "UNASSIGNED RESERVED 17",
+	[VEC_RESV18]	= "UNASSIGNED RESERVED 18",
+	[VEC_RESV19]	= "UNASSIGNED RESERVED 19",
+	[VEC_RESV20]	= "UNASSIGNED RESERVED 20",
+	[VEC_RESV21]	= "UNASSIGNED RESERVED 21",
+	[VEC_RESV22]	= "UNASSIGNED RESERVED 22",
+	[VEC_RESV23]	= "UNASSIGNED RESERVED 23",
+	[VEC_SPUR]	= "SPURIOUS INTERRUPT",
+	[VEC_INT1]	= "LEVEL 1 INT",
+	[VEC_INT2]	= "LEVEL 2 INT",
+	[VEC_INT3]	= "LEVEL 3 INT",
+	[VEC_INT4]	= "LEVEL 4 INT",
+	[VEC_INT5]	= "LEVEL 5 INT",
+	[VEC_INT6]	= "LEVEL 6 INT",
+	[VEC_INT7]	= "LEVEL 7 INT",
+	[VEC_SYS]	= "SYSCALL",
+	[VEC_TRAP1]	= "TRAP #1",
+	[VEC_TRAP2]	= "TRAP #2",
+	[VEC_TRAP3]	= "TRAP #3",
+	[VEC_TRAP4]	= "TRAP #4",
+	[VEC_TRAP5]	= "TRAP #5",
+	[VEC_TRAP6]	= "TRAP #6",
+	[VEC_TRAP7]	= "TRAP #7",
+	[VEC_TRAP8]	= "TRAP #8",
+	[VEC_TRAP9]	= "TRAP #9",
+	[VEC_TRAP10]	= "TRAP #10",
+	[VEC_TRAP11]	= "TRAP #11",
+	[VEC_TRAP12]	= "TRAP #12",
+	[VEC_TRAP13]	= "TRAP #13",
+	[VEC_TRAP14]	= "TRAP #14",
+	[VEC_TRAP15]	= "TRAP #15",
+	[VEC_FPBRUC]	= "FPCP BSUN",
+	[VEC_FPIR]	= "FPCP INEXACT",
+	[VEC_FPDIVZ]	= "FPCP DIV BY 0",
+	[VEC_FPUNDER]	= "FPCP UNDERFLOW",
+	[VEC_FPOE]	= "FPCP OPERAND ERROR",
+	[VEC_FPOVER]	= "FPCP OVERFLOW",
+	[VEC_FPNAN]	= "FPCP SNAN",
+	[VEC_FPUNSUP]	= "FPCP UNSUPPORTED OPERATION",
+	[VEC_MMUCFG]	= "MMU CONFIGURATION ERROR",
+	[VEC_MMUILL]	= "MMU ILLEGAL OPERATION ERROR",
+	[VEC_MMUACC]	= "MMU ACCESS LEVEL VIOLATION ERROR",
+	[VEC_RESV59]	= "UNASSIGNED RESERVED 59",
+	[VEC_UNIMPEA]	= "UNASSIGNED RESERVED 60",
+	[VEC_UNIMPII]	= "UNASSIGNED RESERVED 61",
+	[VEC_RESV62]	= "UNASSIGNED RESERVED 62",
+	[VEC_RESV63]	= "UNASSIGNED RESERVED 63",
+};
 
+static const char *space_names[] = {
+	[0]		= "Space 0",
+	[USER_DATA]	= "User Data",
+	[USER_PROGRAM]	= "User Program",
 #ifndef CONFIG_SUN3
-static char *space_names[] = {
-	"Space 0", "User Data", "User Program", "Space 3",
-	"Space 4", "Super Data", "Super Program", "CPU"
-	};
+	[3]		= "Space 3",
 #else
-static char *space_names[] = {
-	"Space 0", "User Data", "User Program", "Control",
-	"Space 4", "Super Data", "Super Program", "CPU"
-	};
+	[FC_CONTROL]	= "Control",
 #endif
+	[4]		= "Space 4",
+	[SUPER_DATA]	= "Super Data",
+	[SUPER_PROGRAM]	= "Super Program",
+	[CPU_SPACE]	= "CPU"
+};
 
 void die_if_kernel(char *,struct pt_regs *,int);
 asmlinkage int do_page_fault(struct pt_regs *regs, unsigned long address,
--- linux-2.6.5-rc2/arch/m68k/mac/config.c	2004-01-21 22:03:12.000000000 +0100
+++ linux-m68k-2.6.5-rc2/arch/m68k/mac/config.c	2004-03-28 12:26:59.000000000 +0200
@@ -46,7 +46,7 @@
 
 /* Mac bootinfo struct */
 
-struct mac_booter_data mac_bi_data = {0,};
+struct mac_booter_data mac_bi_data;
 int mac_bisize = sizeof mac_bi_data;
 
 struct mac_hw_present mac_hw_present;
@@ -276,17 +276,54 @@
 	 *	We'll pretend to be a Macintosh II, that's pretty safe.
 	 */
 
-	{	MAC_MODEL_II,	"Unknown",	MAC_ADB_II,	MAC_VIA_II,	MAC_SCSI_OLD,	MAC_IDE_NONE,	MAC_SCC_II,	MAC_ETHER_NONE,	MAC_NUBUS},
+	{
+		.ident		= MAC_MODEL_II,
+		.name		= "Unknown",
+		.adb_type	= MAC_ADB_II,
+		.via_type	= MAC_VIA_II,
+		.scsi_type	= MAC_SCSI_OLD,
+		.scc_type	= MAC_SCC_II,
+		.nubus_type	= MAC_NUBUS
+	},
 
 	/*
 	 *	Original MacII hardware
 	 *	
 	 */
 	 
-	{	MAC_MODEL_II,	"II",		MAC_ADB_II,	MAC_VIA_II,	MAC_SCSI_OLD,	MAC_IDE_NONE,	MAC_SCC_II,	MAC_ETHER_NONE,	MAC_NUBUS},
-	{	MAC_MODEL_IIX,	"IIx",		MAC_ADB_II,	MAC_VIA_II,	MAC_SCSI_OLD,	MAC_IDE_NONE,	MAC_SCC_II,	MAC_ETHER_NONE,	MAC_NUBUS},
-	{	MAC_MODEL_IICX,	"IIcx",		MAC_ADB_II,	MAC_VIA_II,	MAC_SCSI_OLD,	MAC_IDE_NONE,	MAC_SCC_II,	MAC_ETHER_NONE,	MAC_NUBUS},
-	{	MAC_MODEL_SE30, "SE/30",	MAC_ADB_II,	MAC_VIA_II,	MAC_SCSI_OLD,	MAC_IDE_NONE,	MAC_SCC_II,	MAC_ETHER_NONE,	MAC_NUBUS},
+	{
+		.ident		= MAC_MODEL_II,
+		.name		= "II",
+		.adb_type	= MAC_ADB_II,
+		.via_type	= MAC_VIA_II,
+		.scsi_type	= MAC_SCSI_OLD,
+		.scc_type	= MAC_SCC_II,
+		.nubus_type	= MAC_NUBUS
+	}, {
+		.ident		= MAC_MODEL_IIX,
+		.name		= "IIx",
+		.adb_type	= MAC_ADB_II,
+		.via_type	= MAC_VIA_II,
+		.scsi_type	= MAC_SCSI_OLD,
+		.scc_type	= MAC_SCC_II,
+		.nubus_type	= MAC_NUBUS
+	}, {
+		.ident		= MAC_MODEL_IICX,
+		.name		= "IIcx",
+		.adb_type	= MAC_ADB_II,
+		.via_type	= MAC_VIA_II,
+		.scsi_type	= MAC_SCSI_OLD,
+		.scc_type	= MAC_SCC_II,
+		.nubus_type	= MAC_NUBUS
+	}, {
+		.ident		= MAC_MODEL_SE30,
+		.name		= "SE/30",
+		.adb_type	= MAC_ADB_II,
+		.via_type	= MAC_VIA_II,
+		.scsi_type	= MAC_SCSI_OLD,
+		.scc_type	= MAC_SCC_II,
+		.nubus_type	= MAC_NUBUS
+	},
 	
 	/*
 	 *	Weirdified MacII hardware - all subtley different. Gee thanks
@@ -295,26 +332,98 @@
 	 * CSA: see http://developer.apple.com/technotes/hw/hw_09.html
 	 */
 
-	{	MAC_MODEL_IICI,	"IIci",	MAC_ADB_II,	MAC_VIA_IIci,	MAC_SCSI_OLD,	MAC_IDE_NONE,	MAC_SCC_II,	MAC_ETHER_NONE,	MAC_NUBUS},
-	{	MAC_MODEL_IIFX,	"IIfx",	MAC_ADB_IOP,	MAC_VIA_IIci,	MAC_SCSI_OLD,	MAC_IDE_NONE,	MAC_SCC_IOP,	MAC_ETHER_NONE,	MAC_NUBUS},
-	{	MAC_MODEL_IISI, "IIsi",	MAC_ADB_IISI,	MAC_VIA_IIci,	MAC_SCSI_OLD,	MAC_IDE_NONE,	MAC_SCC_II,	MAC_ETHER_NONE,	MAC_NUBUS},
-	{	MAC_MODEL_IIVI,	"IIvi",	MAC_ADB_IISI,	MAC_VIA_IIci,	MAC_SCSI_OLD,	MAC_IDE_NONE,	MAC_SCC_II,	MAC_ETHER_NONE,	MAC_NUBUS},
-	{	MAC_MODEL_IIVX,	"IIvx",	MAC_ADB_IISI,	MAC_VIA_IIci,	MAC_SCSI_OLD,	MAC_IDE_NONE,	MAC_SCC_II,	MAC_ETHER_NONE,	MAC_NUBUS},
+	{
+		.ident		= MAC_MODEL_IICI,
+		.name		= "IIci",
+		.adb_type	= MAC_ADB_II,
+		.via_type	= MAC_VIA_IIci,
+		.scsi_type	= MAC_SCSI_OLD,
+		.scc_type	= MAC_SCC_II,
+		.nubus_type	= MAC_NUBUS
+	}, {
+		.ident		= MAC_MODEL_IIFX,
+		.name		= "IIfx",
+		.adb_type	= MAC_ADB_IOP,
+		.via_type	= MAC_VIA_IIci,
+		.scsi_type	= MAC_SCSI_OLD,
+		.scc_type	= MAC_SCC_IOP,
+		.nubus_type	= MAC_NUBUS
+	}, {
+		.ident		= MAC_MODEL_IISI,
+		.name		= "IIsi",
+		.adb_type	= MAC_ADB_IISI,
+		.via_type	= MAC_VIA_IIci,
+		.scsi_type	= MAC_SCSI_OLD,
+		.scc_type	= MAC_SCC_II,
+		.nubus_type	= MAC_NUBUS
+	}, {
+		.ident		= MAC_MODEL_IIVI,
+		.name		= "IIvi",
+		.adb_type	= MAC_ADB_IISI,
+		.via_type	= MAC_VIA_IIci,
+		.scsi_type	= MAC_SCSI_OLD,
+		.scc_type	= MAC_SCC_II,
+		.nubus_type	= MAC_NUBUS
+	}, {
+		.ident		= MAC_MODEL_IIVX,
+		.name		= "IIvx",
+		.adb_type	= MAC_ADB_IISI,
+		.via_type	= MAC_VIA_IIci,
+		.scsi_type	= MAC_SCSI_OLD,
+		.scc_type	= MAC_SCC_II,
+		.nubus_type	= MAC_NUBUS
+	},
 	
 	/*
 	 *	Classic models (guessing: similar to SE/30 ?? Nope, similar to LC ...)
 	 */
 
-	{	MAC_MODEL_CLII, "Classic II",		MAC_ADB_IISI,	MAC_VIA_IIci,	MAC_SCSI_OLD,	MAC_IDE_NONE,	MAC_SCC_II,     MAC_ETHER_NONE,	MAC_NUBUS},
-	{	MAC_MODEL_CCL,  "Color Classic",	MAC_ADB_CUDA,	MAC_VIA_IIci,	MAC_SCSI_OLD,	MAC_IDE_NONE,	MAC_SCC_II,     MAC_ETHER_NONE,	MAC_NUBUS},
+	{
+		.ident		= MAC_MODEL_CLII,
+		.name		= "Classic II",
+		.adb_type	= MAC_ADB_IISI,
+		.via_type	= MAC_VIA_IIci,
+		.scsi_type	= MAC_SCSI_OLD,
+		.scc_type	= MAC_SCC_II,
+		.nubus_type	= MAC_NUBUS
+	}, {
+		.ident		= MAC_MODEL_CCL,
+		.name		= "Color Classic",
+		.adb_type	= MAC_ADB_CUDA,
+		.via_type	= MAC_VIA_IIci,
+		.scsi_type	= MAC_SCSI_OLD,
+		.scc_type	= MAC_SCC_II,
+		.nubus_type	= MAC_NUBUS},
 
 	/*
 	 *	Some Mac LC machines. Basically the same as the IIci, ADB like IIsi
 	 */
 	
-	{	MAC_MODEL_LC,	"LC",	  MAC_ADB_IISI,	MAC_VIA_IIci,	MAC_SCSI_OLD,	MAC_IDE_NONE,	MAC_SCC_II,	MAC_ETHER_NONE,	MAC_NUBUS},
-	{	MAC_MODEL_LCII,	"LC II",  MAC_ADB_IISI,	MAC_VIA_IIci,	MAC_SCSI_OLD,	MAC_IDE_NONE,	MAC_SCC_II,	MAC_ETHER_NONE,	MAC_NUBUS},
-	{	MAC_MODEL_LCIII,"LC III", MAC_ADB_IISI,	MAC_VIA_IIci,	MAC_SCSI_OLD,	MAC_IDE_NONE,	MAC_SCC_II,	MAC_ETHER_NONE,	MAC_NUBUS},
+	{
+		.ident		= MAC_MODEL_LC,
+		.name		= "LC",
+		.adb_type	= MAC_ADB_IISI,
+		.via_type	= MAC_VIA_IIci,
+		.scsi_type	= MAC_SCSI_OLD,
+		.scc_type	= MAC_SCC_II,
+		.nubus_type	= MAC_NUBUS
+	}, {
+		.ident		= MAC_MODEL_LCII,
+		.name		= "LC II",
+		.adb_type	= MAC_ADB_IISI,
+		.via_type	= MAC_VIA_IIci,
+		.scsi_type	= MAC_SCSI_OLD,
+		.scc_type	= MAC_SCC_II,
+		.nubus_type	= MAC_NUBUS
+	}, {
+		.ident		= MAC_MODEL_LCIII,
+		.name		= "LC III",
+		.adb_type	= MAC_ADB_IISI,
+		.via_type	= MAC_VIA_IIci,
+		.scsi_type	= MAC_SCSI_OLD,
+		.scc_type	= MAC_SCC_II,
+		.nubus_type	= MAC_NUBUS
+	},
 
 	/*
 	 *	Quadra. Video is at 0xF9000000, via is like a MacII. We label it differently 
@@ -326,41 +435,215 @@
 	 *	the 660AV).
 	 */	 
 	 
-	{	MAC_MODEL_Q605, "Quadra 605", MAC_ADB_CUDA, MAC_VIA_QUADRA, MAC_SCSI_QUADRA,  MAC_IDE_NONE,   MAC_SCC_QUADRA,	MAC_ETHER_NONE,		MAC_NUBUS},
-	{	MAC_MODEL_Q605_ACC, "Quadra 605", MAC_ADB_CUDA, MAC_VIA_QUADRA, MAC_SCSI_QUADRA,  MAC_IDE_NONE,   MAC_SCC_QUADRA,	MAC_ETHER_NONE,		MAC_NUBUS},
-	{	MAC_MODEL_Q610, "Quadra 610", MAC_ADB_II,   MAC_VIA_QUADRA, MAC_SCSI_QUADRA,  MAC_IDE_NONE,   MAC_SCC_QUADRA,	MAC_ETHER_SONIC,	MAC_NUBUS},
-	{	MAC_MODEL_Q630, "Quadra 630", MAC_ADB_CUDA, MAC_VIA_QUADRA, MAC_SCSI_QUADRA,  MAC_IDE_QUADRA, MAC_SCC_QUADRA,	MAC_ETHER_SONIC,	MAC_NUBUS},
- 	{	MAC_MODEL_Q650, "Quadra 650", MAC_ADB_II,   MAC_VIA_QUADRA, MAC_SCSI_QUADRA,  MAC_IDE_NONE,   MAC_SCC_QUADRA,	MAC_ETHER_SONIC,	MAC_NUBUS},
+	{
+		.ident		= MAC_MODEL_Q605,
+		.name		= "Quadra 605",
+		.adb_type	= MAC_ADB_CUDA,
+		.via_type	= MAC_VIA_QUADRA,
+		.scsi_type	= MAC_SCSI_QUADRA,
+		.scc_type	= MAC_SCC_QUADRA,
+		.nubus_type	= MAC_NUBUS
+	}, {
+		.ident		= MAC_MODEL_Q605_ACC,
+		.name		= "Quadra 605",
+		.adb_type	= MAC_ADB_CUDA,
+		.via_type	= MAC_VIA_QUADRA,
+		.scsi_type	= MAC_SCSI_QUADRA,
+		.scc_type	= MAC_SCC_QUADRA,
+		.nubus_type	= MAC_NUBUS
+	}, {
+		.ident		= MAC_MODEL_Q610,
+		.name		= "Quadra 610",
+		.adb_type	= MAC_ADB_II,
+		.via_type	= MAC_VIA_QUADRA,
+		.scsi_type	= MAC_SCSI_QUADRA,
+		.scc_type	= MAC_SCC_QUADRA,
+		.ether_type	= MAC_ETHER_SONIC,
+		.nubus_type	= MAC_NUBUS
+	}, {
+		.ident		= MAC_MODEL_Q630,
+		.name		= "Quadra 630",
+		.adb_type	= MAC_ADB_CUDA,
+		.via_type	= MAC_VIA_QUADRA,
+		.scsi_type	= MAC_SCSI_QUADRA,
+		.ide_type	= MAC_IDE_QUADRA,
+		.scc_type	= MAC_SCC_QUADRA,
+		.ether_type	= MAC_ETHER_SONIC,
+		.nubus_type	= MAC_NUBUS
+	}, {
+		.ident		= MAC_MODEL_Q650,
+		.name		= "Quadra 650",
+		.adb_type	= MAC_ADB_II,
+		.via_type	= MAC_VIA_QUADRA,
+		.scsi_type	= MAC_SCSI_QUADRA,
+		.scc_type	= MAC_SCC_QUADRA,
+		.ether_type	= MAC_ETHER_SONIC,
+		.nubus_type	= MAC_NUBUS
+	},
 	/*	The Q700 does have a NS Sonic */
-	{	MAC_MODEL_Q700, "Quadra 700", MAC_ADB_II,   MAC_VIA_QUADRA, MAC_SCSI_QUADRA2, MAC_IDE_NONE,   MAC_SCC_QUADRA,	MAC_ETHER_SONIC,	MAC_NUBUS},
-	{	MAC_MODEL_Q800, "Quadra 800", MAC_ADB_II,   MAC_VIA_QUADRA, MAC_SCSI_QUADRA,  MAC_IDE_NONE,   MAC_SCC_QUADRA,	MAC_ETHER_SONIC,	MAC_NUBUS},
-	{	MAC_MODEL_Q840, "Quadra 840AV", MAC_ADB_CUDA, MAC_VIA_QUADRA, MAC_SCSI_QUADRA3, MAC_IDE_NONE, MAC_SCC_PSC,	MAC_ETHER_MACE,		MAC_NUBUS},
-	{	MAC_MODEL_Q900, "Quadra 900", MAC_ADB_IOP, MAC_VIA_QUADRA, MAC_SCSI_QUADRA2, MAC_IDE_NONE,   MAC_SCC_IOP,	MAC_ETHER_SONIC,	MAC_NUBUS},
-	{	MAC_MODEL_Q950, "Quadra 950", MAC_ADB_IOP, MAC_VIA_QUADRA, MAC_SCSI_QUADRA2, MAC_IDE_NONE,   MAC_SCC_IOP,	MAC_ETHER_SONIC,	MAC_NUBUS},
+	{
+		.ident		= MAC_MODEL_Q700,
+		.name		= "Quadra 700",
+		.adb_type	= MAC_ADB_II,
+		.via_type	= MAC_VIA_QUADRA,
+		.scsi_type	= MAC_SCSI_QUADRA2,
+		.scc_type	= MAC_SCC_QUADRA,
+		.ether_type	= MAC_ETHER_SONIC,
+		.nubus_type	= MAC_NUBUS
+	}, {
+		.ident		= MAC_MODEL_Q800,
+		.name		= "Quadra 800",
+		.adb_type	= MAC_ADB_II,
+		.via_type	= MAC_VIA_QUADRA,
+		.scsi_type	= MAC_SCSI_QUADRA,
+		.scc_type	= MAC_SCC_QUADRA,
+		.ether_type	= MAC_ETHER_SONIC,
+		.nubus_type	= MAC_NUBUS
+	}, {
+		.ident		= MAC_MODEL_Q840,
+		.name		= "Quadra 840AV",
+		.adb_type	= MAC_ADB_CUDA,
+		.via_type	= MAC_VIA_QUADRA,
+		.scsi_type	= MAC_SCSI_QUADRA3,
+		.scc_type	= MAC_SCC_PSC,
+		.ether_type	= MAC_ETHER_MACE,
+		.nubus_type	= MAC_NUBUS
+	}, {
+		.ident		= MAC_MODEL_Q900,
+		.name		= "Quadra 900",
+		.adb_type	= MAC_ADB_IOP,
+		.via_type	= MAC_VIA_QUADRA,
+		.scsi_type	= MAC_SCSI_QUADRA2,
+		.scc_type	= MAC_SCC_IOP,
+		.ether_type	= MAC_ETHER_SONIC,
+		.nubus_type	= MAC_NUBUS
+	}, {
+		.ident		= MAC_MODEL_Q950,
+		.name		= "Quadra 950",
+		.adb_type	= MAC_ADB_IOP,
+		.via_type	= MAC_VIA_QUADRA,
+		.scsi_type	= MAC_SCSI_QUADRA2,
+		.scc_type	= MAC_SCC_IOP,
+		.ether_type	= MAC_ETHER_SONIC,
+		.nubus_type	= MAC_NUBUS
+	},
 
 	/* 
 	 *	Performa - more LC type machines
 	 */
 
-	{	MAC_MODEL_P460,  "Performa 460", MAC_ADB_IISI, MAC_VIA_IIci,   MAC_SCSI_OLD, 	MAC_IDE_NONE,   MAC_SCC_II,	MAC_ETHER_NONE,	MAC_NUBUS},
-	{	MAC_MODEL_P475,  "Performa 475", MAC_ADB_CUDA, MAC_VIA_QUADRA, MAC_SCSI_QUADRA, MAC_IDE_NONE,   MAC_SCC_II,	MAC_ETHER_NONE, MAC_NUBUS},
-	{	MAC_MODEL_P475F, "Performa 475", MAC_ADB_CUDA, MAC_VIA_QUADRA, MAC_SCSI_QUADRA, MAC_IDE_NONE,   MAC_SCC_II,	MAC_ETHER_NONE, MAC_NUBUS},
-	{	MAC_MODEL_P520,  "Performa 520", MAC_ADB_CUDA, MAC_VIA_IIci,   MAC_SCSI_OLD,    MAC_IDE_NONE,   MAC_SCC_II,	MAC_ETHER_NONE,	MAC_NUBUS},
-	{	MAC_MODEL_P550,  "Performa 550", MAC_ADB_CUDA, MAC_VIA_IIci,   MAC_SCSI_OLD,    MAC_IDE_NONE,   MAC_SCC_II,	MAC_ETHER_NONE,	MAC_NUBUS},
+	{
+		.ident		= MAC_MODEL_P460,
+		.name		=  "Performa 460",
+		.adb_type	= MAC_ADB_IISI,
+		.via_type	= MAC_VIA_IIci,
+		.scsi_type	= MAC_SCSI_OLD,
+		.scc_type	= MAC_SCC_II,
+		.nubus_type	= MAC_NUBUS
+	}, {
+		.ident		= MAC_MODEL_P475,
+		.name		=  "Performa 475",
+		.adb_type	= MAC_ADB_CUDA,
+		.via_type	= MAC_VIA_QUADRA,
+		.scsi_type	= MAC_SCSI_QUADRA,
+		.scc_type	= MAC_SCC_II,
+		.nubus_type	= MAC_NUBUS
+	}, {
+		.ident		= MAC_MODEL_P475F,
+		.name		=  "Performa 475",
+		.adb_type	= MAC_ADB_CUDA,
+		.via_type	= MAC_VIA_QUADRA,
+		.scsi_type	= MAC_SCSI_QUADRA,
+		.scc_type	= MAC_SCC_II,
+		.nubus_type	= MAC_NUBUS
+	}, {
+		.ident		= MAC_MODEL_P520,
+		.name		=  "Performa 520",
+		.adb_type	= MAC_ADB_CUDA,
+		.via_type	= MAC_VIA_IIci,
+		.scsi_type	= MAC_SCSI_OLD,
+		.scc_type	= MAC_SCC_II,
+		.nubus_type	= MAC_NUBUS
+	}, {
+		.ident		= MAC_MODEL_P550,
+		.name		=  "Performa 550",
+		.adb_type	= MAC_ADB_CUDA,
+		.via_type	= MAC_VIA_IIci,
+		.scsi_type	= MAC_SCSI_OLD,
+		.scc_type	= MAC_SCC_II,
+		.nubus_type	= MAC_NUBUS
+	},
 	/* These have the comm slot, and therefore the possibility of SONIC ethernet */
-	{	MAC_MODEL_P575,  "Performa 575", MAC_ADB_CUDA, MAC_VIA_QUADRA, MAC_SCSI_QUADRA, MAC_IDE_NONE,   MAC_SCC_II,	MAC_ETHER_SONIC, MAC_NUBUS},
-	{	MAC_MODEL_P588,  "Performa 588", MAC_ADB_CUDA, MAC_VIA_QUADRA, MAC_SCSI_QUADRA, MAC_IDE_QUADRA, MAC_SCC_II,	MAC_ETHER_SONIC, MAC_NUBUS},
-	{	MAC_MODEL_TV,    "TV",           MAC_ADB_CUDA, MAC_VIA_QUADRA, MAC_SCSI_OLD,	MAC_IDE_NONE,   MAC_SCC_II,	MAC_ETHER_NONE,	MAC_NUBUS},
-	{	MAC_MODEL_P600,  "Performa 600", MAC_ADB_IISI, MAC_VIA_IIci,   MAC_SCSI_OLD,	MAC_IDE_NONE,   MAC_SCC_II,	MAC_ETHER_NONE,	MAC_NUBUS},
+	{
+		.ident		= MAC_MODEL_P575,
+		.name		= "Performa 575",
+		.adb_type	= MAC_ADB_CUDA,
+		.via_type	= MAC_VIA_QUADRA,
+		.scsi_type	= MAC_SCSI_QUADRA,
+		.scc_type	= MAC_SCC_II,
+		.ether_type	= MAC_ETHER_SONIC,
+		.nubus_type	= MAC_NUBUS
+	}, {
+		.ident		= MAC_MODEL_P588,
+		.name		= "Performa 588",
+		.adb_type	= MAC_ADB_CUDA,
+		.via_type	= MAC_VIA_QUADRA,
+		.scsi_type	= MAC_SCSI_QUADRA,
+		.ide_type	= MAC_IDE_QUADRA,
+		.scc_type	= MAC_SCC_II,
+		.ether_type	= MAC_ETHER_SONIC,
+		.nubus_type	= MAC_NUBUS
+	}, {
+		.ident		= MAC_MODEL_TV,
+		.name		= "TV",
+		.adb_type	= MAC_ADB_CUDA,
+		.via_type	= MAC_VIA_QUADRA,
+		.scsi_type	= MAC_SCSI_OLD,
+		.scc_type	= MAC_SCC_II,
+		.nubus_type	= MAC_NUBUS
+	}, {
+		.ident		= MAC_MODEL_P600,
+		.name		= "Performa 600",
+		.adb_type	= MAC_ADB_IISI,
+		.via_type	= MAC_VIA_IIci,
+		.scsi_type	= MAC_SCSI_OLD,
+		.scc_type	= MAC_SCC_II,
+		.nubus_type	= MAC_NUBUS
+	},
 
 	/*
 	 *	Centris - just guessing again; maybe like Quadra
 	 */
 
 	/* The C610 may or may not have SONIC.  We probe to make sure */
-	{	MAC_MODEL_C610, "Centris 610",   MAC_ADB_II,   MAC_VIA_QUADRA, MAC_SCSI_QUADRA,  MAC_IDE_NONE, MAC_SCC_QUADRA,	MAC_ETHER_SONIC,	MAC_NUBUS},
-	{	MAC_MODEL_C650, "Centris 650",   MAC_ADB_II,   MAC_VIA_QUADRA, MAC_SCSI_QUADRA,  MAC_IDE_NONE, MAC_SCC_QUADRA,	MAC_ETHER_SONIC,	MAC_NUBUS},
-	{	MAC_MODEL_C660, "Centris 660AV", MAC_ADB_CUDA, MAC_VIA_QUADRA, MAC_SCSI_QUADRA3, MAC_IDE_NONE, MAC_SCC_PSC,	MAC_ETHER_MACE,		MAC_NUBUS},
+	{
+		.ident		= MAC_MODEL_C610,
+		.name		= "Centris 610",
+		.adb_type	= MAC_ADB_II,
+		.via_type	= MAC_VIA_QUADRA,
+		.scsi_type	= MAC_SCSI_QUADRA,
+		.scc_type	= MAC_SCC_QUADRA,
+		.ether_type	= MAC_ETHER_SONIC,
+		.nubus_type	= MAC_NUBUS
+	}, {
+		.ident		= MAC_MODEL_C650,
+		.name		= "Centris 650",
+		.adb_type	= MAC_ADB_II,
+		.via_type	= MAC_VIA_QUADRA,
+		.scsi_type	= MAC_SCSI_QUADRA,
+		.scc_type	= MAC_SCC_QUADRA,
+		.ether_type	= MAC_ETHER_SONIC,
+		.nubus_type	= MAC_NUBUS
+	}, {
+		.ident		= MAC_MODEL_C660,
+		.name		= "Centris 660AV",
+		.adb_type	= MAC_ADB_CUDA,
+		.via_type	= MAC_VIA_QUADRA,
+		.scsi_type	= MAC_SCSI_QUADRA3,
+		.scc_type	= MAC_SCC_PSC,
+		.ether_type	= MAC_ETHER_MACE,
+		.nubus_type	= MAC_NUBUS
+	},
 
 	/*
 	 * The PowerBooks all the same "Combo" custom IC for SCSI and SCC
@@ -368,17 +651,98 @@
 	 * Quadra-style VIAs. A few models also have IDE from hell.
 	 */
 
-	{	MAC_MODEL_PB140,  "PowerBook 140",   MAC_ADB_PB1, MAC_VIA_QUADRA, MAC_SCSI_OLD,  MAC_IDE_NONE,	 MAC_SCC_QUADRA, MAC_ETHER_NONE,	MAC_NUBUS},
-	{	MAC_MODEL_PB145,  "PowerBook 145",   MAC_ADB_PB1, MAC_VIA_QUADRA, MAC_SCSI_OLD,  MAC_IDE_NONE,	 MAC_SCC_QUADRA, MAC_ETHER_NONE,	MAC_NUBUS},
-	{	MAC_MODEL_PB150,  "PowerBook 150",   MAC_ADB_PB1, MAC_VIA_IIci,   MAC_SCSI_OLD,  MAC_IDE_PB,	 MAC_SCC_QUADRA, MAC_ETHER_NONE,	MAC_NUBUS},
-	{	MAC_MODEL_PB160,  "PowerBook 160",   MAC_ADB_PB1, MAC_VIA_QUADRA, MAC_SCSI_OLD,  MAC_IDE_NONE,	 MAC_SCC_QUADRA, MAC_ETHER_NONE,	MAC_NUBUS},
-	{	MAC_MODEL_PB165,  "PowerBook 165",   MAC_ADB_PB1, MAC_VIA_QUADRA, MAC_SCSI_OLD,  MAC_IDE_NONE,	 MAC_SCC_QUADRA, MAC_ETHER_NONE,	MAC_NUBUS},
-	{	MAC_MODEL_PB165C, "PowerBook 165c",  MAC_ADB_PB1, MAC_VIA_QUADRA, MAC_SCSI_OLD,  MAC_IDE_NONE,	 MAC_SCC_QUADRA, MAC_ETHER_NONE,	MAC_NUBUS},
-	{	MAC_MODEL_PB170,  "PowerBook 170",   MAC_ADB_PB1, MAC_VIA_QUADRA, MAC_SCSI_OLD,  MAC_IDE_NONE,	 MAC_SCC_QUADRA, MAC_ETHER_NONE,	MAC_NUBUS},
-	{	MAC_MODEL_PB180,  "PowerBook 180",   MAC_ADB_PB1, MAC_VIA_QUADRA, MAC_SCSI_OLD,  MAC_IDE_NONE,	 MAC_SCC_QUADRA, MAC_ETHER_NONE,	MAC_NUBUS},
-	{	MAC_MODEL_PB180C, "PowerBook 180c",  MAC_ADB_PB1, MAC_VIA_QUADRA, MAC_SCSI_OLD,  MAC_IDE_NONE,	 MAC_SCC_QUADRA, MAC_ETHER_NONE,	MAC_NUBUS},
-	{	MAC_MODEL_PB190,  "PowerBook 190",   MAC_ADB_PB2, MAC_VIA_QUADRA, MAC_SCSI_OLD,  MAC_IDE_BABOON, MAC_SCC_QUADRA, MAC_ETHER_NONE,	MAC_NUBUS},
-	{	MAC_MODEL_PB520,  "PowerBook 520",   MAC_ADB_PB2, MAC_VIA_QUADRA, MAC_SCSI_OLD,  MAC_IDE_NONE,	 MAC_SCC_QUADRA, MAC_ETHER_SONIC, MAC_NUBUS},
+	{
+		.ident		= MAC_MODEL_PB140,
+		.name		= "PowerBook 140",
+		.adb_type	= MAC_ADB_PB1,
+		.via_type	= MAC_VIA_QUADRA,
+		.scsi_type	= MAC_SCSI_OLD,
+		.scc_type	= MAC_SCC_QUADRA,
+		.nubus_type	= MAC_NUBUS
+	}, {
+		.ident		= MAC_MODEL_PB145,
+		.name		= "PowerBook 145",
+		.adb_type	= MAC_ADB_PB1,
+		.via_type	= MAC_VIA_QUADRA,
+		.scsi_type	= MAC_SCSI_OLD,
+		.scc_type	= MAC_SCC_QUADRA,
+		.nubus_type	= MAC_NUBUS
+	}, {
+		.ident		= MAC_MODEL_PB150,
+		.name		= "PowerBook 150",
+		.adb_type	= MAC_ADB_PB1,
+		.via_type	= MAC_VIA_IIci,
+		.scsi_type	= MAC_SCSI_OLD,
+		.ide_type	= MAC_IDE_PB,
+		.scc_type	= MAC_SCC_QUADRA,
+		.nubus_type	= MAC_NUBUS
+	}, {
+		.ident		= MAC_MODEL_PB160,
+		.name		= "PowerBook 160",
+		.adb_type	= MAC_ADB_PB1,
+		.via_type	= MAC_VIA_QUADRA,
+		.scsi_type	= MAC_SCSI_OLD,
+		.scc_type	= MAC_SCC_QUADRA,
+		.nubus_type	= MAC_NUBUS
+	}, {
+		.ident		= MAC_MODEL_PB165,
+		.name		= "PowerBook 165",
+		.adb_type	= MAC_ADB_PB1,
+		.via_type	= MAC_VIA_QUADRA,
+		.scsi_type	= MAC_SCSI_OLD,
+		.scc_type	= MAC_SCC_QUADRA,
+		.nubus_type	= MAC_NUBUS
+	}, {
+		.ident		= MAC_MODEL_PB165C,
+		.name		= "PowerBook 165c",
+		.adb_type	= MAC_ADB_PB1,
+		.via_type	= MAC_VIA_QUADRA,
+		.scsi_type	= MAC_SCSI_OLD,
+		.scc_type	= MAC_SCC_QUADRA,
+		.nubus_type	= MAC_NUBUS
+	}, {
+		.ident		= MAC_MODEL_PB170,
+		.name		= "PowerBook 170",
+		.adb_type	= MAC_ADB_PB1,
+		.via_type	= MAC_VIA_QUADRA,
+		.scsi_type	= MAC_SCSI_OLD,
+		.scc_type	= MAC_SCC_QUADRA,
+		.nubus_type	= MAC_NUBUS
+	}, {
+		.ident		= MAC_MODEL_PB180,
+		.name		= "PowerBook 180",
+		.adb_type	= MAC_ADB_PB1,
+		.via_type	= MAC_VIA_QUADRA,
+		.scsi_type	= MAC_SCSI_OLD,
+		.scc_type	= MAC_SCC_QUADRA,
+		.nubus_type	= MAC_NUBUS
+	}, {
+		.ident		= MAC_MODEL_PB180C,
+		.name		= "PowerBook 180c",
+		.adb_type	= MAC_ADB_PB1,
+		.via_type	= MAC_VIA_QUADRA,
+		.scsi_type	= MAC_SCSI_OLD,
+		.scc_type	= MAC_SCC_QUADRA,
+		.nubus_type	= MAC_NUBUS
+	}, {
+		.ident		= MAC_MODEL_PB190,
+		.name		= "PowerBook 190",
+		.adb_type	= MAC_ADB_PB2,
+		.via_type	= MAC_VIA_QUADRA,
+		.scsi_type	= MAC_SCSI_OLD,
+		.ide_type	= MAC_IDE_BABOON,
+		.scc_type	= MAC_SCC_QUADRA,
+		.nubus_type	= MAC_NUBUS
+	}, {
+		.ident		= MAC_MODEL_PB520,
+		.name		= "PowerBook 520",
+		.adb_type	= MAC_ADB_PB2,
+		.via_type	= MAC_VIA_QUADRA,
+		.scsi_type	= MAC_SCSI_OLD,
+		.scc_type	= MAC_SCC_QUADRA,
+		.ether_type	= MAC_ETHER_SONIC,
+		.nubus_type	= MAC_NUBUS
+	},
 
 	/*
 	 * PowerBook Duos are pretty much like normal PowerBooks
@@ -390,17 +754,62 @@
 	 * the other PowerBooks which would imply MAC_VIA_QUADRA.
 	 */
 
-	{	MAC_MODEL_PB210,  "PowerBook Duo 210",  MAC_ADB_PB2,  MAC_VIA_IIci, MAC_SCSI_OLD, MAC_IDE_NONE, MAC_SCC_QUADRA,	MAC_ETHER_NONE,	MAC_NUBUS},
-	{	MAC_MODEL_PB230,  "PowerBook Duo 230",  MAC_ADB_PB2,  MAC_VIA_IIci, MAC_SCSI_OLD, MAC_IDE_NONE, MAC_SCC_QUADRA,	MAC_ETHER_NONE,	MAC_NUBUS},
-	{	MAC_MODEL_PB250,  "PowerBook Duo 250",  MAC_ADB_PB2,  MAC_VIA_IIci, MAC_SCSI_OLD, MAC_IDE_NONE, MAC_SCC_QUADRA,	MAC_ETHER_NONE,	MAC_NUBUS},
-	{	MAC_MODEL_PB270C, "PowerBook Duo 270c", MAC_ADB_PB2,  MAC_VIA_IIci, MAC_SCSI_OLD, MAC_IDE_NONE, MAC_SCC_QUADRA,	MAC_ETHER_NONE,	MAC_NUBUS},
-	{	MAC_MODEL_PB280,  "PowerBook Duo 280",  MAC_ADB_PB2,  MAC_VIA_IIci, MAC_SCSI_OLD, MAC_IDE_NONE, MAC_SCC_QUADRA,	MAC_ETHER_NONE,	MAC_NUBUS},
-	{	MAC_MODEL_PB280C, "PowerBook Duo 280c", MAC_ADB_PB2,  MAC_VIA_IIci, MAC_SCSI_OLD, MAC_IDE_NONE, MAC_SCC_QUADRA,	MAC_ETHER_NONE,	MAC_NUBUS},
+	{
+		.ident		= MAC_MODEL_PB210,
+		.name		= "PowerBook Duo 210",
+		.adb_type	= MAC_ADB_PB2,
+		.via_type	= MAC_VIA_IIci,
+		.scsi_type	= MAC_SCSI_OLD,
+		.scc_type	= MAC_SCC_QUADRA,
+		.nubus_type	= MAC_NUBUS
+	}, {
+		.ident		= MAC_MODEL_PB230,
+		.name		= "PowerBook Duo 230",
+		.adb_type	= MAC_ADB_PB2,
+		.via_type	= MAC_VIA_IIci,
+		.scsi_type	= MAC_SCSI_OLD,
+		.scc_type	= MAC_SCC_QUADRA,
+		.nubus_type	= MAC_NUBUS
+	}, {
+		.ident		= MAC_MODEL_PB250,
+		.name		= "PowerBook Duo 250",
+		.adb_type	= MAC_ADB_PB2,
+		.via_type	= MAC_VIA_IIci,
+		.scsi_type	= MAC_SCSI_OLD,
+		.scc_type	= MAC_SCC_QUADRA,
+		.nubus_type	= MAC_NUBUS
+	}, {
+		.ident		= MAC_MODEL_PB270C,
+		.name		= "PowerBook Duo 270c",
+		.adb_type	= MAC_ADB_PB2,
+		.via_type	= MAC_VIA_IIci,
+		.scsi_type	= MAC_SCSI_OLD,
+		.scc_type	= MAC_SCC_QUADRA,
+		.nubus_type	= MAC_NUBUS
+	}, {
+		.ident		= MAC_MODEL_PB280,
+		.name		= "PowerBook Duo 280",
+		.adb_type	= MAC_ADB_PB2,
+		.via_type	= MAC_VIA_IIci,
+		.scsi_type	= MAC_SCSI_OLD,
+		.scc_type	= MAC_SCC_QUADRA,
+		.nubus_type	= MAC_NUBUS
+	}, {
+		.ident		= MAC_MODEL_PB280C,
+		.name		= "PowerBook Duo 280c",
+		.adb_type	= MAC_ADB_PB2,
+		.via_type	= MAC_VIA_IIci,
+		.scsi_type	= MAC_SCSI_OLD,
+		.scc_type	= MAC_SCC_QUADRA,
+		.nubus_type	= MAC_NUBUS
+	},
 
 	/*
 	 *	Other stuff ??
 	 */
-	{	-1, NULL, 0,0,0,}
+	{
+		.ident		= -1
+	}
 };
 
 void mac_identify(void)
--- linux-2.6.5-rc2/arch/m68k/mac/debug.c	2002-07-25 12:53:34.000000000 +0200
+++ linux-m68k-2.6.5-rc2/arch/m68k/mac/debug.c	2004-03-28 12:06:39.000000000 +0200
@@ -151,10 +151,10 @@
 # define scc (*((volatile struct mac_SCC*)mac_bi_data.sccbase))
 
 /* Flag that serial port is already initialized and used */
-int mac_SCC_init_done = 0;
+int mac_SCC_init_done;
 /* Can be set somewhere, if a SCC master reset has already be done and should
  * not be repeated; used by kgdb */
-int mac_SCC_reset_done = 0;
+int mac_SCC_reset_done;
 
 static int scc_port = -1;
 
--- linux-2.6.5-rc2/arch/m68k/mac/macboing.c	2003-01-02 12:53:57.000000000 +0100
+++ linux-m68k-2.6.5-rc2/arch/m68k/mac/macboing.c	2004-03-21 22:28:54.000000000 +0100
@@ -15,7 +15,7 @@
 #include <asm/macintosh.h>
 #include <asm/mac_asc.h>
 
-static int mac_asc_inited = 0;
+static int mac_asc_inited;
 /*
  * dumb triangular wave table
  */
@@ -39,7 +39,7 @@
  * sample rate; is this a good default value? 
  */
 static unsigned long mac_asc_samplespersec = 11050;  
-static int mac_bell_duration = 0;
+static int mac_bell_duration;
 static unsigned long mac_bell_phase; /* 0..2*Pi -> 0..0x800 (wavetable size) */
 static unsigned long mac_bell_phasepersample;
 
@@ -51,7 +51,7 @@
 static void mac_quadra_start_bell( unsigned int, unsigned int, unsigned int );
 static void mac_quadra_ring_bell( unsigned long );
 static void mac_av_start_bell( unsigned int, unsigned int, unsigned int );
-static void ( *mac_special_bell )( unsigned int, unsigned int, unsigned int ) = NULL;
+static void ( *mac_special_bell )( unsigned int, unsigned int, unsigned int );
 
 /*
  * our timer to start/continue/stop the bell
--- linux-2.6.5-rc2/arch/m68k/mac/macints.c	2004-03-11 10:20:31.000000000 +0100
+++ linux-m68k-2.6.5-rc2/arch/m68k/mac/macints.c	2004-03-21 22:18:13.000000000 +0100
@@ -644,7 +644,7 @@
 #endif
 }
 
-static int num_debug[8] = { 0, 0, 0, 0, 0, 0, 0, 0 };
+static int num_debug[8];
 
 irqreturn_t mac_debug_handler(int irq, void *dev_id, struct pt_regs *regs)
 {
@@ -655,8 +655,8 @@
 	return IRQ_HANDLED;
 }
 
-static int in_nmi = 0;
-static volatile int nmi_hold = 0;
+static int in_nmi;
+static volatile int nmi_hold;
 
 irqreturn_t mac_nmi_handler(int irq, void *dev_id, struct pt_regs *fp)
 {
--- linux-2.6.5-rc2/arch/m68k/mac/via.c	2004-03-11 10:20:31.000000000 +0100
+++ linux-m68k-2.6.5-rc2/arch/m68k/mac/via.c	2004-03-21 22:19:21.000000000 +0100
@@ -61,7 +61,7 @@
 #define MAC_CLOCK_LOW		(MAC_CLOCK_TICK&0xFF)
 #define MAC_CLOCK_HIGH		(MAC_CLOCK_TICK>>8)
 
-static int  nubus_active = 0;
+static int  nubus_active;
 
 void via_debug_dump(void);
 irqreturn_t via1_irq(int, void *, struct pt_regs *);
--- linux-2.6.5-rc2/arch/m68k/mm/kmap.c	2002-05-25 14:27:01.000000000 +0200
+++ linux-m68k-2.6.5-rc2/arch/m68k/mm/kmap.c	2004-03-21 22:29:28.000000000 +0100
@@ -52,7 +52,7 @@
 
 #define IO_SIZE		(256*1024)
 
-static struct vm_struct *iolist = NULL;
+static struct vm_struct *iolist;
 
 static struct vm_struct *get_io_area(unsigned long size)
 {
--- linux-2.6.5-rc2/arch/m68k/mm/motorola.c	2004-01-21 22:03:13.000000000 +0100
+++ linux-m68k-2.6.5-rc2/arch/m68k/mm/motorola.c	2004-03-21 22:22:15.000000000 +0100
@@ -40,7 +40,7 @@
  * For 68020/030 this is 0.
  * For 68040, this is _PAGE_CACHE040 (cachable, copyback)
  */
-unsigned long mm_cachebits = 0;
+unsigned long mm_cachebits;
 EXPORT_SYMBOL(mm_cachebits);
 #endif
 
--- linux-2.6.5-rc2/arch/m68k/q40/q40ints.c	2004-03-11 10:20:31.000000000 +0100
+++ linux-m68k-2.6.5-rc2/arch/m68k/q40/q40ints.c	2004-03-21 20:53:11.000000000 +0100
@@ -423,8 +423,14 @@
 }
 
 irqreturn_t (*q40_default_handler[SYS_IRQS])(int, void *, struct pt_regs *) = {
-	 default_handler, default_handler, default_handler, default_handler,
-	 default_handler, default_handler, default_handler, default_handler
+	 [0] = default_handler,
+	 [1] = default_handler,
+	 [2] = default_handler,
+	 [3] = default_handler,
+	 [4] = default_handler,
+	 [5] = default_handler,
+	 [6] = default_handler,
+	 [7] = default_handler
 };
 
 
--- linux-2.6.5-rc2/arch/m68k/sun3/mmu_emu.c	2002-11-05 10:09:42.000000000 +0100
+++ linux-m68k-2.6.5-rc2/arch/m68k/sun3/mmu_emu.c	2004-03-21 22:23:33.000000000 +0100
@@ -45,15 +45,17 @@
 ** Globals
 */
 
-unsigned long vmalloc_end = 0;
+unsigned long vmalloc_end;
 unsigned long pmeg_vaddr[PMEGS_NUM];
 unsigned char pmeg_alloc[PMEGS_NUM];
 unsigned char pmeg_ctx[PMEGS_NUM];
 
 /* pointers to the mm structs for each task in each
    context. 0xffffffff is a marker for kernel context */
-struct mm_struct *ctx_alloc[CONTEXTS_NUM] = {(struct mm_struct *)0xffffffff, 
-					     0, 0, 0, 0, 0, 0, 0};
+struct mm_struct *ctx_alloc[CONTEXTS_NUM] = {
+    [0] = (struct mm_struct *)0xffffffff
+};
+
 /* has this context been mmdrop'd? */
 static unsigned char ctx_avail = CONTEXTS_NUM-1;
 
--- linux-2.6.5-rc2/arch/m68k/sun3/sun3dvma.c	2003-04-06 10:28:29.000000000 +0200
+++ linux-m68k-2.6.5-rc2/arch/m68k/sun3/sun3dvma.c	2004-03-21 22:24:16.000000000 +0100
@@ -47,10 +47,10 @@
 
 #ifdef DVMA_DEBUG
 
-static unsigned long dvma_allocs = 0;
-static unsigned long dvma_frees = 0;
-static unsigned long long dvma_alloc_bytes = 0;
-static unsigned long long dvma_free_bytes = 0;
+static unsigned long dvma_allocs;
+static unsigned long dvma_frees;
+static unsigned long long dvma_alloc_bytes;
+static unsigned long long dvma_free_bytes;
 
 static void print_use(void) 
 {
--- linux-2.6.5-rc2/arch/m68k/sun3/sun3ints.c	2004-03-11 10:20:31.000000000 +0100
+++ linux-m68k-2.6.5-rc2/arch/m68k/sun3/sun3ints.c	2004-03-21 20:56:04.000000000 +0100
@@ -94,15 +94,24 @@
 /* handle requested ints, excepting 5 and 7, which always do the same
    thing */
 irqreturn_t (*sun3_default_handler[SYS_IRQS])(int, void *, struct pt_regs *) = {
-	sun3_inthandle, sun3_inthandle, sun3_inthandle, sun3_inthandle,
-	sun3_inthandle, sun3_int5, sun3_inthandle, sun3_int7
+	[0] = sun3_inthandle,
+	[1] = sun3_inthandle,
+	[2] = sun3_inthandle,
+	[3] = sun3_inthandle,
+	[4] = sun3_inthandle,
+	[5] = sun3_int5,
+	[6] = sun3_inthandle,
+	[7] = sun3_int7
 };
 
-static const char *dev_names[SYS_IRQS] = { NULL, NULL, NULL, NULL, 
-				     NULL, "timer", NULL, "int7 handler" };
+static const char *dev_names[SYS_IRQS] = {
+	[5] = "timer",
+	[7] = "int7 handler"
+};
 static void *dev_ids[SYS_IRQS];
 static irqreturn_t (*sun3_inthandler[SYS_IRQS])(int, void *, struct pt_regs *) = {
-	NULL, NULL, NULL, NULL, NULL, sun3_int5, NULL, sun3_int7
+	[5] = sun3_int5,
+	[7] = sun3_int7
 };
 static irqreturn_t (*sun3_vechandler[SUN3_INT_VECS])(int, void *, struct pt_regs *);
 static void *vec_ids[SUN3_INT_VECS];

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
