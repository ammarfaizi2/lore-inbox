Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262459AbSJHNdE>; Tue, 8 Oct 2002 09:33:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262508AbSJHNdE>; Tue, 8 Oct 2002 09:33:04 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:32148 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S262459AbSJHNct>;
	Tue, 8 Oct 2002 09:32:49 -0400
Date: Tue, 8 Oct 2002 15:38:13 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [patch] Input - Beeping and sysrq on m68k [1/23]
Message-ID: <20021008153813.A18515@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.
'bk pull bk://linux-input.bkbits.net/linux-input' should work as well.

===================================================================

ChangeSet@1.573.13.4, 2002-09-23 09:05:56+02:00, rz@linux-m68k.org
  Move beeping and sysrq to input layer on m68k.
  Add an m68k beeper input module.


 arch/m68k/amiga/config.c      |   38 ++-----------------
 arch/m68k/atari/config.c      |   37 +-----------------
 arch/m68k/bvme6000/config.c   |   22 -----------
 arch/m68k/config.in           |    1 
 arch/m68k/hp300/config.c      |   13 ------
 arch/m68k/kernel/setup.c      |   19 ++-------
 arch/m68k/mac/config.c        |   53 +-------------------------
 arch/m68k/mvme147/config.c    |   11 -----
 arch/m68k/mvme16x/config.c    |   24 ------------
 arch/m68k/q40/config.c        |   31 +--------------
 drivers/input/misc/Config.in  |    3 +
 drivers/input/misc/Makefile   |    1 
 drivers/input/misc/m68kspkr.c |   84 ++++++++++++++++++++++++++++++++++++++++++
 include/asm-m68k/machdep.h    |   14 ++-----
 14 files changed, 107 insertions(+), 244 deletions(-)

===================================================================

diff -Nru a/arch/m68k/amiga/config.c b/arch/m68k/amiga/config.c
--- a/arch/m68k/amiga/config.c	Tue Oct  8 15:27:40 2002
+++ b/arch/m68k/amiga/config.c	Tue Oct  8 15:27:40 2002
@@ -33,7 +33,6 @@
 #include <asm/amigaints.h>
 #include <asm/irq.h>
 #include <asm/rtc.h>
-#include <asm/keyboard.h>
 #include <asm/machdep.h>
 #include <asm/io.h>
 
@@ -71,11 +70,6 @@
 extern char m68k_debug_device[];
 
 static void amiga_sched_init(void (*handler)(int, void *, struct pt_regs *));
-/* amiga specific keyboard functions */
-extern int amiga_keyb_init(void);
-extern int amiga_kbdrate (struct kbd_repeat *);
-extern int amiga_kbd_translate(unsigned char keycode, unsigned char *keycodep,
-			       char raw_mode);
 /* amiga specific irq functions */
 extern void amiga_init_IRQ (void);
 extern void (*amiga_default_handler[]) (int, void *, struct pt_regs *);
@@ -94,7 +88,6 @@
 static int a3000_hwclk (int, struct rtc_time *);
 static int a2000_hwclk (int, struct rtc_time *);
 static int amiga_set_clock_mmss (unsigned long);
-extern void amiga_mksound( unsigned int count, unsigned int ticks );
 #ifdef CONFIG_AMIGA_FLOPPY
 extern void amiga_floppy_setup(char *, int *);
 #endif
@@ -116,18 +109,6 @@
 	.index =	-1,
 };
 
-#ifdef CONFIG_MAGIC_SYSRQ
-static char amiga_sysrq_xlate[128] =
-	"\0001234567890-=\\\000\000"					/* 0x00 - 0x0f */
-	"qwertyuiop[]\000123"							/* 0x10 - 0x1f */
-	"asdfghjkl;'\000\000456"						/* 0x20 - 0x2f */
-	"\000zxcvbnm,./\000+789"						/* 0x30 - 0x3f */
-	" \177\t\r\r\000\177\000\000\000-\000\000\000\000\000"	/* 0x40 - 0x4f */
-	"\000\201\202\203\204\205\206\207\210\211()/*+\000"	/* 0x50 - 0x5f */
-	"\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000"	/* 0x60 - 0x6f */
-	"\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000";	/* 0x70 - 0x7f */
-#endif
-
 
     /*
      *  Motherboard Resources present in all Amiga models
@@ -388,11 +369,6 @@
     request_resource(&iomem_resource, &((struct resource *)&mb_resources)[i]);
 
   mach_sched_init      = amiga_sched_init;
-#ifdef CONFIG_VT
-  mach_keyb_init       = amiga_keyb_init;
-  mach_kbdrate         = amiga_kbdrate;
-  mach_kbd_translate   = amiga_kbd_translate;
-#endif
   mach_init_IRQ        = amiga_init_IRQ;
   mach_default_handler = &amiga_default_handler;
   mach_request_irq     = amiga_request_irq;
@@ -432,16 +408,10 @@
 #ifdef CONFIG_DUMMY_CONSOLE
   conswitchp           = &dummy_con;
 #endif
-#ifdef CONFIG_VT
-  kd_mksound           = amiga_mksound;
-#endif
-#ifdef CONFIG_MAGIC_SYSRQ
-  SYSRQ_KEY            = 0xff;
-  mach_sysrq_key = 0x5f;	     /* HELP */
-  mach_sysrq_shift_state = 0x03; /* SHIFT+ALTGR */
-  mach_sysrq_shift_mask = 0xff;  /* all modifiers except CapsLock */
-  mach_sysrq_xlate = amiga_sysrq_xlate;
+#ifdef CONFIG_INPUT_M68K_BEEP
+  mach_beep            = amiga_mksound;
 #endif
+
 #ifdef CONFIG_HEARTBEAT
   mach_heartbeat = amiga_heartbeat;
 #endif
@@ -709,7 +679,7 @@
   unsigned long jmp_addr040 = virt_to_phys(&&jmp_addr_label040);
   unsigned long jmp_addr = virt_to_phys(&&jmp_addr_label);
 
-  cli();
+  local_irq_disable();
   if (CPU_IS_040_OR_060)
     /* Setup transparent translation registers for mapping
      * of 16 MB kernel segment before disabling translation
diff -Nru a/arch/m68k/atari/config.c b/arch/m68k/atari/config.c
--- a/arch/m68k/atari/config.c	Tue Oct  8 15:27:40 2002
+++ b/arch/m68k/atari/config.c	Tue Oct  8 15:27:40 2002
@@ -39,7 +39,6 @@
 #include <asm/atariints.h>
 #include <asm/atari_stram.h>
 #include <asm/system.h>
-#include <asm/keyboard.h>
 #include <asm/machdep.h>
 #include <asm/hwtest.h>
 #include <asm/io.h>
@@ -59,12 +58,6 @@
 static void atari_get_model(char *model);
 static int atari_get_hardware_list(char *buffer);
 
-/* atari specific keyboard functions */
-extern int atari_keyb_init(void);
-extern int atari_kbdrate (struct kbd_repeat *);
-extern int atari_kbd_translate(unsigned char keycode, unsigned char *keycodep,
-			       char raw_mode);
-extern void atari_kbd_leds (unsigned int);
 /* atari specific irq functions */
 extern void atari_init_IRQ (void);
 extern int atari_request_irq (unsigned int irq, void (*handler)(int, void *, struct pt_regs *),
@@ -73,7 +66,6 @@
 extern void atari_enable_irq (unsigned int);
 extern void atari_disable_irq (unsigned int);
 extern int show_atari_interrupts (struct seq_file *, void *);
-extern void atari_mksound( unsigned int count, unsigned int ticks );
 #ifdef CONFIG_HEARTBEAT
 static void atari_heartbeat( int on );
 #endif
@@ -89,18 +81,6 @@
 /* atari specific debug functions (in debug.c) */
 extern void atari_debug_init(void);
 
-#ifdef CONFIG_MAGIC_SYSRQ
-static char atari_sysrq_xlate[128] =
-	"\000\0331234567890-=\177\t"					/* 0x00 - 0x0f */
-	"qwertyuiop[]\r\000as"							/* 0x10 - 0x1f */
-	"dfghjkl;'`\000\\zxcv"							/* 0x20 - 0x2f */
-	"bnm,./\000\000\000 \000\201\202\203\204\205"	/* 0x30 - 0x3f */
-	"\206\207\210\211\212\000\000\000\000\000-\000\000\000+\000"/* 0x40 - 0x4f */
-	"\000\000\000\177\000\000\000\000\000\000\000\000\000\000\000\000" /* 0x50 - 0x5f */
-	"\000\000\000()/*789456123"						/* 0x60 - 0x6f */
-	"0.\r\000\000\000\000\000\000\000\000\000\000\000\000\000";	/* 0x70 - 0x7f */
-#endif
-
 
 /* I've moved hwreg_present() and hwreg_present_bywrite() out into
  * mm/hwtest.c, to avoid having multiple copies of the same routine
@@ -254,12 +234,6 @@
                                            to 4GB. */
 
     mach_sched_init      = atari_sched_init;
-#ifdef CONFIG_VT
-    mach_keyb_init       = atari_keyb_init;
-    mach_kbdrate         = atari_kbdrate;
-    mach_kbd_translate   = atari_kbd_translate;
-    mach_kbd_leds        = atari_kbd_leds;
-#endif
     mach_init_IRQ        = atari_init_IRQ;
     mach_request_irq     = atari_request_irq;
     mach_free_irq        = atari_free_irq;
@@ -277,15 +251,8 @@
     conswitchp	         = &dummy_con;
 #endif
     mach_max_dma_address = 0xffffff;
-#ifdef CONFIG_VT
-    kd_mksound		 = atari_mksound;
-#endif
-#ifdef CONFIG_MAGIC_SYSRQ
-    SYSRQ_KEY            = 0xff;
-    mach_sysrq_key = 98;          /* HELP */
-    mach_sysrq_shift_state = 8;   /* Alt */
-    mach_sysrq_shift_mask = 0xff; /* all modifiers except CapsLock */
-    mach_sysrq_xlate = atari_sysrq_xlate;
+#ifdef CONFIG_INPUT_M68K_BEEP
+    mach_beep          = atari_mksound;
 #endif
 #ifdef CONFIG_HEARTBEAT
     mach_heartbeat = atari_heartbeat;
diff -Nru a/arch/m68k/bvme6000/config.c b/arch/m68k/bvme6000/config.c
--- a/arch/m68k/bvme6000/config.c	Tue Oct  8 15:27:40 2002
+++ b/arch/m68k/bvme6000/config.c	Tue Oct  8 15:27:40 2002
@@ -45,12 +45,9 @@
 static int  bvme6000_get_hardware_list(char *buffer);
 extern int  bvme6000_request_irq(unsigned int irq, void (*handler)(int, void *, struct pt_regs *), unsigned long flags, const char *devname, void *dev_id);
 extern void bvme6000_sched_init(void (*handler)(int, void *, struct pt_regs *));
-extern int  bvme6000_keyb_init(void);
-extern int  bvme6000_kbdrate (struct kbd_repeat *);
 extern unsigned long bvme6000_gettimeoffset (void);
 extern int bvme6000_hwclk (int, struct rtc_time *);
 extern int bvme6000_set_clock_mmss (unsigned long);
-extern void bvme6000_mksound( unsigned int count, unsigned int ticks );
 extern void bvme6000_reset (void);
 extern void bvme6000_waitbut(void);
 void bvme6000_set_vectors (void);
@@ -72,15 +69,6 @@
 		return 1;
 }
 
-int bvme6000_kbdrate (struct kbd_repeat *k)
-{
-	return 0;
-}
-
-void bvme6000_mksound( unsigned int count, unsigned int ticks )
-{
-}
-
 void bvme6000_reset()
 {
 	volatile PitRegsPtr pit = (PitRegsPtr)BVME_PIT_BASE;
@@ -133,15 +121,10 @@
 
     mach_max_dma_address = 0xffffffff;
     mach_sched_init      = bvme6000_sched_init;
-#ifdef CONFIG_VT
-    mach_keyb_init       = bvme6000_keyb_init;
-    mach_kbdrate         = bvme6000_kbdrate;
-#endif
     mach_init_IRQ        = bvme6000_init_IRQ;
     mach_gettimeoffset   = bvme6000_gettimeoffset;
     mach_hwclk           = bvme6000_hwclk;
     mach_set_clock_mmss	 = bvme6000_set_clock_mmss;
-/*  mach_mksound         = bvme6000_mksound; */
     mach_reset		 = bvme6000_reset;
     mach_free_irq	 = bvme6000_free_irq;
     mach_process_int	 = bvme6000_process_int;
@@ -394,8 +377,3 @@
 	return retval;
 }
 
-
-int bvme6000_keyb_init (void)
-{
-	return 0;
-}
diff -Nru a/arch/m68k/config.in b/arch/m68k/config.in
--- a/arch/m68k/config.in	Tue Oct  8 15:27:40 2002
+++ b/arch/m68k/config.in	Tue Oct  8 15:27:40 2002
@@ -3,6 +3,7 @@
 # see Documentation/kbuild/config-language.txt.
 #
 
+define_bool CONFIG_M68K y
 define_bool CONFIG_UID16 y
 define_bool CONFIG_RWSEM_GENERIC_SPINLOCK y
 define_bool CONFIG_RWSEM_XCHGADD_ALGORITHM n
diff -Nru a/arch/m68k/hp300/config.c b/arch/m68k/hp300/config.c
--- a/arch/m68k/hp300/config.c	Tue Oct  8 15:27:40 2002
+++ b/arch/m68k/hp300/config.c	Tue Oct  8 15:27:40 2002
@@ -17,7 +17,6 @@
 #include <linux/init.h>
 #include <asm/machdep.h>
 #include <asm/blinken.h>
-#include <asm/io.h>                               /* readb() and writeb() */
 #include <asm/hwtest.h>                           /* hwreg_present() */
 
 #include "ints.h"
@@ -27,14 +26,6 @@
 extern void (*hp300_default_handler[])(int, void *, struct pt_regs *);
 extern int show_hp300_interrupts(struct seq_file *, void *);
 
-#ifdef CONFIG_VT
-extern int hp300_keyb_init(void);
-static int hp300_kbdrate(struct kbd_repeat *k)
-{
-  return 0;
-}
-#endif
-
 #ifdef CONFIG_HEARTBEAT
 static void hp300_pulse(int x)
 {
@@ -53,10 +44,6 @@
 void __init config_hp300(void)
 {
   mach_sched_init      = hp300_sched_init;
-#ifdef CONFIG_VT
-  mach_keyb_init       = hp300_keyb_init;
-  mach_kbdrate         = hp300_kbdrate;
-#endif
   mach_init_IRQ        = hp300_init_IRQ;
   mach_request_irq     = hp300_request_irq;
   mach_free_irq        = hp300_free_irq;
diff -Nru a/arch/m68k/kernel/setup.c b/arch/m68k/kernel/setup.c
--- a/arch/m68k/kernel/setup.c	Tue Oct  8 15:27:40 2002
+++ b/arch/m68k/kernel/setup.c	Tue Oct  8 15:27:40 2002
@@ -71,13 +71,6 @@
 char m68k_debug_device[6] = "";
 
 void (*mach_sched_init) (void (*handler)(int, void *, struct pt_regs *)) __initdata = NULL;
-/* machine dependent keyboard functions */
-#ifdef CONFIG_VT
-int (*mach_keyb_init) (void) __initdata = NULL;
-int (*mach_kbdrate) (struct kbd_repeat *) = NULL;
-void (*mach_kbd_leds) (unsigned int) = NULL;
-int (*mach_kbd_translate)(unsigned char scancode, unsigned char *keycode, char raw_mode) = NULL;
-#endif
 /* machine dependent irq functions */
 void (*mach_init_IRQ) (void) __initdata = NULL;
 void (*(*mach_default_handler)[]) (int, void *, struct pt_regs *) = NULL;
@@ -89,6 +82,8 @@
 unsigned long (*mach_gettimeoffset) (void);
 int (*mach_hwclk) (int, struct rtc_time*) = NULL;
 int (*mach_set_clock_mmss) (unsigned long) = NULL;
+int (*mach_get_rtc_pll)(struct rtc_pll_info *) = NULL;
+int (*mach_set_rtc_pll)(struct rtc_pll_info *) = NULL;
 void (*mach_reset)( void );
 void (*mach_halt)( void ) = NULL;
 void (*mach_power_off)( void ) = NULL;
@@ -103,15 +98,9 @@
 #ifdef CONFIG_M68K_L2_CACHE
 void (*mach_l2_flush) (int) = NULL;
 #endif
-
-#ifdef CONFIG_MAGIC_SYSRQ
-unsigned int SYSRQ_KEY;
-int mach_sysrq_key = -1;
-int mach_sysrq_shift_state = 0;
-int mach_sysrq_shift_mask = 0;
-char *mach_sysrq_xlate = NULL;
+#ifdef CONFIG_INPUT_M68K_BEEP
+void (*mach_beep)(unsigned int, unsigned int) = NULL;
 #endif
-
 #if defined(CONFIG_ISA) && defined(MULTI_ISA)
 int isa_type;
 int isa_sex;
diff -Nru a/arch/m68k/mac/config.c b/arch/m68k/mac/config.c
--- a/arch/m68k/mac/config.c	Tue Oct  8 15:27:40 2002
+++ b/arch/m68k/mac/config.c	Tue Oct  8 15:27:40 2002
@@ -78,27 +78,12 @@
 extern void psc_init(void);
 extern void baboon_init(void);
 
-extern void mac_mksound(unsigned int, unsigned int);
-
 extern void nubus_sweep_video(void);
 
 /* Mac specific debug functions (in debug.c) */
 extern void mac_debug_init(void);
 extern void mac_debugging_long(int, long);
 
-extern int mackbd_init_hw(void);
-extern void mackbd_leds(unsigned int leds);
-extern int mackbd_translate(unsigned char keycode, unsigned char *keycodep, char raw_mode);
-
-extern void mac_hid_init_hw(void);
-extern int mac_hid_kbd_translate(unsigned char scancode, unsigned char *keycode, char raw_mode);
-
-#ifdef CONFIG_MAGIC_SYSRQ
-extern unsigned char mac_hid_kbd_sysrq_xlate[128];
-extern unsigned char pckbd_sysrq_xlate[128];
-extern unsigned char mackbd_sysrq_xlate[128];
-#endif /* CONFIG_MAGIC_SYSRQ */
-
 static void mac_get_model(char *str);
 
 void mac_bang(int irq, void *vector, struct pt_regs *p)
@@ -207,33 +192,6 @@
 	  printk("ERROR: no Mac, but config_mac() called!! \n");
 	}
 
-#ifdef CONFIG_VT
-#ifdef CONFIG_INPUT_ADBHID
-	mach_keyb_init       = mac_hid_init_hw;
-	mach_kbd_translate   = mac_hid_kbd_translate;
-#ifdef CONFIG_MAGIC_SYSRQ
-#ifdef CONFIG_MAC_ADBKEYCODES
-	if (!keyboard_sends_linux_keycodes) {
-		mach_sysrq_xlate = mac_hid_kbd_sysrq_xlate;
-		SYSRQ_KEY = 0x69;
-	} else
-#endif /* CONFIG_MAC_ADBKEYCODES */
-	{
-		mach_sysrq_xlate = pckbd_sysrq_xlate;
-		SYSRQ_KEY = 0x54;
-	}
-#endif /* CONFIG_MAGIC_SYSRQ */
-#elif defined(CONFIG_ADB_KEYBOARD)
-	mach_keyb_init       = mackbd_init_hw;
-	mach_kbd_leds        = mackbd_leds;
-	mach_kbd_translate   = mackbd_translate;
-#ifdef CONFIG_MAGIC_SYSRQ
-	mach_sysrq_xlate     = mackbd_sysrq_xlate;
-	SYSRQ_KEY = 0x69;
-#endif /* CONFIG_MAGIC_SYSRQ */
-#endif /* CONFIG_INPUT_ADBHID */
-#endif /* CONFIG_VT */
-
 	mach_sched_init      = mac_sched_init;
 	mach_init_IRQ        = mac_init_IRQ;
 	mach_request_irq     = mac_request_irq;
@@ -249,9 +207,6 @@
 	mach_hwclk           = mac_hwclk;
 #endif
 	mach_set_clock_mmss	 = mac_set_clock_mmss;
-#if 0
-	mach_mksound         = mac_mksound;
-#endif
 	mach_reset           = mac_reset;
 	mach_halt            = mac_poweroff;
 	mach_power_off       = mac_poweroff;
@@ -262,8 +217,8 @@
 #if 0
 	mach_debug_init	 = mac_debug_init;
 #endif
-#ifdef CONFIG_VT
-	kd_mksound		 = mac_mksound;
+#ifdef CONFIG_INPUT_M68K_BEEP
+        mach_beep            = mac_mksound;
 #endif
 #ifdef CONFIG_HEARTBEAT
 #if 0
@@ -287,10 +242,6 @@
 	    || macintosh_config->ident == MAC_MODEL_IIFX) {
 		mach_l2_flush = mac_cache_card_flush;
 	}
-#ifdef MAC_DEBUG_SOUND
-	/* goes on forever if timers broken */
-	mac_mksound(1000,10);
-#endif
 
 	/*
 	 * Check for machine specific fixups.
diff -Nru a/arch/m68k/mvme147/config.c b/arch/m68k/mvme147/config.c
--- a/arch/m68k/mvme147/config.c	Tue Oct  8 15:27:40 2002
+++ b/arch/m68k/mvme147/config.c	Tue Oct  8 15:27:40 2002
@@ -45,8 +45,6 @@
 static int  mvme147_get_hardware_list(char *buffer);
 extern int mvme147_request_irq (unsigned int irq, void (*handler)(int, void *, struct pt_regs *), unsigned long flags, const char *devname, void *dev_id);
 extern void mvme147_sched_init(void (*handler)(int, void *, struct pt_regs *));
-extern int mvme147_keyb_init(void);
-extern int mvme147_kbdrate (struct kbd_repeat *);
 extern unsigned long mvme147_gettimeoffset (void);
 extern int mvme147_hwclk (int, struct rtc_time *);
 extern int mvme147_set_clock_mmss (unsigned long);
@@ -70,11 +68,6 @@
 		return 1;
 }
 
-int mvme147_kbdrate (struct kbd_repeat *k)
-{
-	return 0;
-}
-
 void mvme147_reset()
 {
 	printk ("\r\n\nCalled mvme147_reset\r\n");
@@ -102,10 +95,6 @@
 {
 	mach_max_dma_address	= 0x01000000;
 	mach_sched_init		= mvme147_sched_init;
-#ifdef CONFIG_VT
-	mach_keyb_init		= mvme147_keyb_init;
-	mach_kbdrate		= mvme147_kbdrate;
-#endif
 	mach_init_IRQ		= mvme147_init_IRQ;
 	mach_gettimeoffset	= mvme147_gettimeoffset;
 	mach_hwclk		= mvme147_hwclk;
diff -Nru a/arch/m68k/mvme16x/config.c b/arch/m68k/mvme16x/config.c
--- a/arch/m68k/mvme16x/config.c	Tue Oct  8 15:27:40 2002
+++ b/arch/m68k/mvme16x/config.c	Tue Oct  8 15:27:40 2002
@@ -49,12 +49,9 @@
 static int  mvme16x_get_hardware_list(char *buffer);
 extern int  mvme16x_request_irq(unsigned int irq, void (*handler)(int, void *, struct pt_regs *), unsigned long flags, const char *devname, void *dev_id);
 extern void mvme16x_sched_init(void (*handler)(int, void *, struct pt_regs *));
-extern int  mvme16x_keyb_init(void);
-extern int  mvme16x_kbdrate (struct kbd_repeat *);
 extern unsigned long mvme16x_gettimeoffset (void);
 extern int mvme16x_hwclk (int, struct rtc_time *);
 extern int mvme16x_set_clock_mmss (unsigned long);
-extern void mvme16x_mksound( unsigned int count, unsigned int ticks );
 extern void mvme16x_reset (void);
 extern void mvme16x_waitbut(void);
 
@@ -77,15 +74,6 @@
 		return 1;
 }
 
-int mvme16x_kbdrate (struct kbd_repeat *k)
-{
-	return 0;
-}
-
-void mvme16x_mksound( unsigned int count, unsigned int ticks )
-{
-}
-
 void mvme16x_reset()
 {
 	printk ("\r\n\nCalled mvme16x_reset\r\n"
@@ -144,17 +132,10 @@
 
     mach_max_dma_address = 0xffffffff;
     mach_sched_init      = mvme16x_sched_init;
-#ifdef CONFIG_VT
-    mach_keyb_init       = mvme16x_keyb_init;
-    mach_kbdrate         = mvme16x_kbdrate;
-#endif
     mach_init_IRQ        = mvme16x_init_IRQ;
     mach_gettimeoffset   = mvme16x_gettimeoffset;
     mach_hwclk           = mvme16x_hwclk;
     mach_set_clock_mmss	 = mvme16x_set_clock_mmss;
-#ifdef CONFIG_VT
-/*  kd_mksound           = mvme16x_mksound; */
-#endif
     mach_reset		 = mvme16x_reset;
     mach_free_irq	 = mvme16x_free_irq;
     mach_process_int	 = mvme16x_process_int;
@@ -297,11 +278,6 @@
 }
 
 int mvme16x_set_clock_mmss (unsigned long nowtime)
-{
-	return 0;
-}
-
-int mvme16x_keyb_init (void)
 {
 	return 0;
 }
diff -Nru a/arch/m68k/q40/config.c b/arch/m68k/q40/config.c
--- a/arch/m68k/q40/config.c	Tue Oct  8 15:27:40 2002
+++ b/arch/m68k/q40/config.c	Tue Oct  8 15:27:40 2002
@@ -36,12 +36,9 @@
 #include <asm/rtc.h>
 #include <asm/machdep.h>
 #include <asm/q40_master.h>
-#include <asm/keyboard.h>
 
 extern void floppy_setup(char *str, int *ints);
 
-extern int q40kbd_translate(unsigned char scancode, unsigned char *keycode,
-			    char raw_mode);
 extern void q40_process_int (int level, struct pt_regs *regs);
 extern void (*q40_sys_default_handler[]) (int, void *, struct pt_regs *);  /* added just for debugging */
 extern void q40_init_IRQ (void);
@@ -62,8 +59,6 @@
 extern void q40_waitbut(void);
 void q40_set_vectors (void);
 
-void q40_mksound(unsigned int /*freq*/, unsigned int /*ticks*/ );
-
 extern char *saved_command_line;
 extern char m68k_debug_device[];
 static void q40_mem_console_write(struct console *co, const char *b,
@@ -82,14 +77,6 @@
 extern char *q40_mem_cptr; /*=(char *)0xff020000;*/
 static int _cpleft;
 
-#if 0
-int q40_kbd_translate(unsigned char keycode, unsigned char *keycodep, char raw_mode)
-{
-        *keycodep = keycode;
-        return 1;
-}
-#endif
-
 static void q40_mem_console_write(struct console *co, const char *s,
 				  unsigned int count)
 {
@@ -117,13 +104,6 @@
 }
 #endif
 
-#if 0
-int q40_kbdrate (struct kbd_repeat *k)
-{
-	return 0;
-}
-#endif
-
 static int halted=0;
 
 #ifdef CONFIG_HEARTBEAT
@@ -185,10 +165,6 @@
 {
     mach_sched_init      = q40_sched_init;
 
-#ifdef CONFIG_VT
-    mach_keyb_init       = q40kbd_init_hw;
-    mach_kbd_translate   = q40kbd_translate;
-#endif
     mach_init_IRQ        = q40_init_IRQ;   
     mach_gettimeoffset   = q40_gettimeoffset; 
     mach_hwclk           = q40_hwclk; 
@@ -204,12 +180,9 @@
     mach_default_handler = &q40_sys_default_handler;
     mach_get_model       = q40_get_model;
     mach_get_hardware_list = q40_get_hardware_list;
-#ifdef CONFIG_VT
-    kd_mksound             = q40_mksound;
-#endif
 
-#ifdef CONFIG_MAGIC_SYSRQ
-    mach_sysrq_key       = 0x54;
+#ifdef CONFIG_INPUT_M68K_BEEP
+    mach_beep            = q40_mksound;
 #endif
 #ifdef CONFIG_HEARTBEAT
     mach_heartbeat = q40_heartbeat;
diff -Nru a/drivers/input/misc/Config.in b/drivers/input/misc/Config.in
--- a/drivers/input/misc/Config.in	Tue Oct  8 15:27:40 2002
+++ b/drivers/input/misc/Config.in	Tue Oct  8 15:27:40 2002
@@ -8,4 +8,7 @@
 if [ "$CONFIG_SPARC32" = "y" -o "$CONFIG_SPARC64" = "y" ]; then
    dep_tristate '  SPARC Speaker support' CONFIG_INPUT_SPARCSPKR $CONFIG_INPUT $CONFIG_INPUT_MISC
 fi
+if [ "$CONFIG_M68K" = "y" ]; then
+dep_tristate '  M68K Beeper support' CONFIG_INPUT_M68K_BEEP $CONFIG_INPUT $CONFIG_INPUT_MISC
+fi
 dep_tristate '  User level driver support' CONFIG_INPUT_UINPUT $CONFIG_INPUT $CONFIG_INPUT_MISC
diff -Nru a/drivers/input/misc/Makefile b/drivers/input/misc/Makefile
--- a/drivers/input/misc/Makefile	Tue Oct  8 15:27:40 2002
+++ b/drivers/input/misc/Makefile	Tue Oct  8 15:27:40 2002
@@ -6,6 +6,7 @@
 
 obj-$(CONFIG_INPUT_SPARCSPKR)		+= sparcspkr.o
 obj-$(CONFIG_INPUT_PCSPKR)		+= pcspkr.o
+obj-$(CONFIG_INPUT_M68K_BEEP)		+= m68kspkr.o
 obj-$(CONFIG_INPUT_UINPUT)		+= uinput.o
 
 # The global Rules.make.
diff -Nru a/drivers/input/misc/m68kspkr.c b/drivers/input/misc/m68kspkr.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/drivers/input/misc/m68kspkr.c	Tue Oct  8 15:27:40 2002
@@ -0,0 +1,84 @@
+/*
+ *  m68k beeper driver for Linux
+ *
+ *  Copyright (c) 2002 Richard Zidlicky
+ *  Copyright (c) 2002 Vojtech Pavlik
+ *  Copyright (c) 1992 Orest Zborowski
+ *
+ */
+
+/*
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/input.h>
+#include <asm/machdep.h>
+#include <asm/io.h>
+
+MODULE_AUTHOR("Richard Zidlicky <rz@linux-m68k.org>");
+MODULE_DESCRIPTION("m68k beeper driver");
+MODULE_LICENSE("GPL");
+
+static char m68kspkr_name[] = "m68k beeper";
+static char m68kspkr_phys[] = "m68k/generic";
+static struct input_dev m68kspkr_dev;
+
+static int m68kspkr_event(struct input_dev *dev, unsigned int type, unsigned int code, int value)
+{
+	unsigned int count = 0;
+	unsigned long flags;
+
+	if (type != EV_SND)
+		return -1;
+
+	switch (code) {
+		case SND_BELL: if (value) value = 1000;
+		case SND_TONE: break;
+		default: return -1;
+	} 
+
+	if (value > 20 && value < 32767)
+		count = 1193182 / value;
+	
+	mach_beep(count, -1);
+
+	return 0;
+}
+
+static int __init m68kspkr_init(void)
+{
+        if (!mach_beep){
+		printk("%s: no lowlevel beep support\n", m68kspkr_name);
+		return -1;
+        }
+
+	m68kspkr_dev.evbit[0] = BIT(EV_SND);
+	m68kspkr_dev.sndbit[0] = BIT(SND_BELL) | BIT(SND_TONE);
+	m68kspkr_dev.event = m68kspkr_event;
+
+	m68kspkr_dev.name = m68kspkr_name;
+	m68kspkr_dev.phys = m68kspkr_phys;
+	m68kspkr_dev.id.bustype = BUS_HOST;
+	m68kspkr_dev.id.vendor = 0x001f;
+	m68kspkr_dev.id.product = 0x0001;
+	m68kspkr_dev.id.version = 0x0100;
+
+	input_register_device(&m68kspkr_dev);
+
+        printk(KERN_INFO "input: %s\n", m68kspkr_name);
+
+	return 0;
+}
+
+static void __exit m68kspkr_exit(void)
+{
+        input_unregister_device(&m68kspkr_dev);
+}
+
+module_init(m68kspkr_init);
+module_exit(m68kspkr_exit);
diff -Nru a/include/asm-m68k/machdep.h b/include/asm-m68k/machdep.h
--- a/include/asm-m68k/machdep.h	Tue Oct  8 15:27:40 2002
+++ b/include/asm-m68k/machdep.h	Tue Oct  8 15:27:40 2002
@@ -4,17 +4,12 @@
 #include <linux/seq_file.h>
 
 struct pt_regs;
-struct kbd_repeat;
 struct mktime;
 struct rtc_time;
+struct rtc_pll_info;
 struct buffer_head;
 
 extern void (*mach_sched_init) (void (*handler)(int, void *, struct pt_regs *));
-/* machine dependent keyboard functions */
-extern int (*mach_keyb_init) (void);
-extern int (*mach_kbdrate) (struct kbd_repeat *);
-extern void (*mach_kbd_leds) (unsigned int);
-extern int (*mach_kbd_translate)(unsigned char scancode, unsigned char *keycode, char raw_mode);
 /* machine dependent irq functions */
 extern void (*mach_init_IRQ) (void);
 extern void (*(*mach_default_handler)[]) (int, void *, struct pt_regs *);
@@ -28,6 +23,8 @@
 /* machine dependent timer functions */
 extern unsigned long (*mach_gettimeoffset)(void);
 extern int (*mach_hwclk)(int, struct rtc_time*);
+extern int (*mach_get_rtc_pll)(struct rtc_pll_info *);
+extern int (*mach_set_rtc_pll)(struct rtc_pll_info *);
 extern int (*mach_set_clock_mmss)(unsigned long);
 extern void (*mach_reset)( void );
 extern void (*mach_halt)( void );
@@ -38,9 +35,6 @@
 extern void (*mach_floppy_setup)(char *, int *);
 extern void (*mach_heartbeat) (int);
 extern void (*mach_l2_flush) (int);
-extern int mach_sysrq_key;
-extern int mach_sysrq_shift_state;
-extern int mach_sysrq_shift_mask;
-extern char *mach_sysrq_xlate;
+extern void (*mach_beep) (unsigned int, unsigned int);
 
 #endif /* _M68K_MACHDEP_H */

===================================================================

This BitKeeper patch contains the following changesets:
1.573.13.4
## Wrapped with gzip_uu ##


begin 664 bkpatch18473
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
$:3(`````
`
end
