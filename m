Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285074AbRL3VvF>; Sun, 30 Dec 2001 16:51:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285093AbRL3Vu4>; Sun, 30 Dec 2001 16:50:56 -0500
Received: from noodles.codemonkey.org.uk ([62.49.180.5]:31376 "EHLO
	noodles.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id <S285074AbRL3Vur>; Sun, 30 Dec 2001 16:50:47 -0500
Date: Sun, 30 Dec 2001 21:53:06 +0000
From: Dave Jones <davej@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] Split out unmaintained visws support.
Message-ID: <20011230215306.A16140@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Linus Torvalds <torvalds@transmeta.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,
 The SGI vis workstation support has been unmaintained for moons.
I've even heard comments that it currently doesn't work.
Patch below removes it from generic x86 setup, so it can bitrot
somewhere else.  If no-one steps up to maintain this by the time
we reach 2.6.0pre, I vote for dropping it altogether.

Dave.


diff -urN --exclude-from=/home/davej/.exclude linux-2.5.2pre4/arch/i386/kernel/Makefile linux-2.5/arch/i386/kernel/Makefile
--- linux-2.5.2pre4/arch/i386/kernel/Makefile	Sun Dec 30 19:43:33 2001
+++ linux-2.5/arch/i386/kernel/Makefile	Fri Dec 28 18:47:41 2001
@@ -39,6 +40,9 @@
 obj-$(CONFIG_SMP)		+= smp.o smpboot.o trampoline.o
 obj-$(CONFIG_X86_LOCAL_APIC)	+= mpparse.o apic.o nmi.o
 obj-$(CONFIG_X86_IO_APIC)	+= io_apic.o acpitable.o
+ifdef CONFIG_VISWS
+obj-y += setup-visws.o
 obj-$(CONFIG_X86_VISWS_APIC)	+= visws_apic.o
+endif
 
 include $(TOPDIR)/Rules.make
diff -urN --exclude-from=/home/davej/.exclude linux-2.5.2pre4/arch/i386/kernel/setup-visws.c linux-2.5/arch/i386/kernel/setup-visws.c
--- linux-2.5.2pre4/arch/i386/kernel/setup-visws.c	Thu Jan  1 00:00:00 1970
+++ linux-2.5/arch/i386/kernel/setup-visws.c	Fri Dec 28 18:52:20 2001
@@ -0,0 +1,126 @@
+/*
+ *  Unmaintained SGI Visual Workstation support.
+ *  Split out from setup.c by davej@suse.de
+ */
+
+char visws_board_type = -1;
+char visws_board_rev = -1;
+
+#define	PIIX_PM_START		0x0F80
+
+#define	SIO_GPIO_START		0x0FC0
+
+#define	SIO_PM_START		0x0FC8
+
+#define	PMBASE			PIIX_PM_START
+#define	GPIREG0			(PMBASE+0x30)
+#define	GPIREG(x)		(GPIREG0+((x)/8))
+#define	PIIX_GPI_BD_ID1		18
+#define	PIIX_GPI_BD_REG		GPIREG(PIIX_GPI_BD_ID1)
+
+#define	PIIX_GPI_BD_SHIFT	(PIIX_GPI_BD_ID1 % 8)
+
+#define	SIO_INDEX	0x2e
+#define	SIO_DATA	0x2f
+
+#define	SIO_DEV_SEL	0x7
+#define	SIO_DEV_ENB	0x30
+#define	SIO_DEV_MSB	0x60
+#define	SIO_DEV_LSB	0x61
+
+#define	SIO_GP_DEV	0x7
+
+#define	SIO_GP_BASE	SIO_GPIO_START
+#define	SIO_GP_MSB	(SIO_GP_BASE>>8)
+#define	SIO_GP_LSB	(SIO_GP_BASE&0xff)
+
+#define	SIO_GP_DATA1	(SIO_GP_BASE+0)
+
+#define	SIO_PM_DEV	0x8
+
+#define	SIO_PM_BASE	SIO_PM_START
+#define	SIO_PM_MSB	(SIO_PM_BASE>>8)
+#define	SIO_PM_LSB	(SIO_PM_BASE&0xff)
+#define	SIO_PM_INDEX	(SIO_PM_BASE+0)
+#define	SIO_PM_DATA	(SIO_PM_BASE+1)
+
+#define	SIO_PM_FER2	0x1
+
+#define	SIO_PM_GP_EN	0x80
+
+void __init visws_get_board_type_and_rev(void)
+{
+	int raw;
+
+	visws_board_type = (char)(inb_p(PIIX_GPI_BD_REG) & PIIX_GPI_BD_REG)
+							 >> PIIX_GPI_BD_SHIFT;
+/*
+ * Get Board rev.
+ * First, we have to initialize the 307 part to allow us access
+ * to the GPIO registers.  Let's map them at 0x0fc0 which is right
+ * after the PIIX4 PM section.
+ */
+	outb_p(SIO_DEV_SEL, SIO_INDEX);
+	outb_p(SIO_GP_DEV, SIO_DATA);	/* Talk to GPIO regs. */
+
+	outb_p(SIO_DEV_MSB, SIO_INDEX);
+	outb_p(SIO_GP_MSB, SIO_DATA);	/* MSB of GPIO base address */
+
+	outb_p(SIO_DEV_LSB, SIO_INDEX);
+	outb_p(SIO_GP_LSB, SIO_DATA);	/* LSB of GPIO base address */
+
+	outb_p(SIO_DEV_ENB, SIO_INDEX);
+	outb_p(1, SIO_DATA);		/* Enable GPIO registers. */
+
+/*
+ * Now, we have to map the power management section to write
+ * a bit which enables access to the GPIO registers.
+ * What lunatic came up with this shit?
+ */
+	outb_p(SIO_DEV_SEL, SIO_INDEX);
+	outb_p(SIO_PM_DEV, SIO_DATA);	/* Talk to GPIO regs. */
+
+	outb_p(SIO_DEV_MSB, SIO_INDEX);
+	outb_p(SIO_PM_MSB, SIO_DATA);	/* MSB of PM base address */
+
+	outb_p(SIO_DEV_LSB, SIO_INDEX);
+	outb_p(SIO_PM_LSB, SIO_DATA);	/* LSB of PM base address */
+
+	outb_p(SIO_DEV_ENB, SIO_INDEX);
+	outb_p(1, SIO_DATA);		/* Enable PM registers. */
+
+/*
+ * Now, write the PM register which enables the GPIO registers.
+ */
+	outb_p(SIO_PM_FER2, SIO_PM_INDEX);
+	outb_p(SIO_PM_GP_EN, SIO_PM_DATA);
+
+/*
+ * Now, initialize the GPIO registers.
+ * We want them all to be inputs which is the
+ * power on default, so let's leave them alone.
+ * So, let's just read the board rev!
+ */
+	raw = inb_p(SIO_GP_DATA1);
+	raw &= 0x7f;	/* 7 bits of valid board revision ID. */
+
+	if (visws_board_type == VISWS_320) {
+		if (raw < 0x6) {
+			visws_board_rev = 4;
+		} else if (raw < 0xc) {
+			visws_board_rev = 5;
+		} else {
+			visws_board_rev = 6;
+		}
+	} else if (visws_board_type == VISWS_540) {
+			visws_board_rev = 2;
+		} else {
+			visws_board_rev = raw;
+		}
+
+		printk(KERN_INFO "Silicon Graphics %s (rev %d)\n",
+			visws_board_type == VISWS_320 ? "320" :
+			(visws_board_type == VISWS_540 ? "540" :
+					"unknown"), visws_board_rev);
+	}
+}
diff -urN --exclude-from=/home/davej/.exclude linux-2.5.2pre4/arch/i386/kernel/setup.c linux-2.5/arch/i386/kernel/setup.c
--- linux-2.5.2pre4/arch/i386/kernel/setup.c	Sun Dec 30 19:44:10 2001
+++ linux-2.5/arch/i386/kernel/setup.c	Sun Dec 30 13:35:25 2001
@@ -158,6 +157,7 @@
 extern int root_mountflags;
 extern char _text, _etext, _edata, _end;
 extern int blk_nohighio;
+void __init visws_get_board_type_and_rev(void);
 
 static int disable_x86_serial_nr __initdata = 1;
 static int disable_x86_fxsr __initdata = 0;
@@ -191,131 +191,6 @@
 #define RAMDISK_PROMPT_FLAG		0x8000
 #define RAMDISK_LOAD_FLAG		0x4000	
 
-#ifdef	CONFIG_VISWS
-char visws_board_type = -1;
-char visws_board_rev = -1;
-
-#define	PIIX_PM_START		0x0F80
-
-#define	SIO_GPIO_START		0x0FC0
-
-#define	SIO_PM_START		0x0FC8
-
-#define	PMBASE			PIIX_PM_START
-#define	GPIREG0			(PMBASE+0x30)
-#define	GPIREG(x)		(GPIREG0+((x)/8))
-#define	PIIX_GPI_BD_ID1		18
-#define	PIIX_GPI_BD_REG		GPIREG(PIIX_GPI_BD_ID1)
-
-#define	PIIX_GPI_BD_SHIFT	(PIIX_GPI_BD_ID1 % 8)
-
-#define	SIO_INDEX	0x2e
-#define	SIO_DATA	0x2f
-
-#define	SIO_DEV_SEL	0x7
-#define	SIO_DEV_ENB	0x30
-#define	SIO_DEV_MSB	0x60
-#define	SIO_DEV_LSB	0x61
-
-#define	SIO_GP_DEV	0x7
-
-#define	SIO_GP_BASE	SIO_GPIO_START
-#define	SIO_GP_MSB	(SIO_GP_BASE>>8)
-#define	SIO_GP_LSB	(SIO_GP_BASE&0xff)
-
-#define	SIO_GP_DATA1	(SIO_GP_BASE+0)
-
-#define	SIO_PM_DEV	0x8
-
-#define	SIO_PM_BASE	SIO_PM_START
-#define	SIO_PM_MSB	(SIO_PM_BASE>>8)
-#define	SIO_PM_LSB	(SIO_PM_BASE&0xff)
-#define	SIO_PM_INDEX	(SIO_PM_BASE+0)
-#define	SIO_PM_DATA	(SIO_PM_BASE+1)
-
-#define	SIO_PM_FER2	0x1
-
-#define	SIO_PM_GP_EN	0x80
-
-static void __init visws_get_board_type_and_rev(void)
-{
-	int raw;
-
-	visws_board_type = (char)(inb_p(PIIX_GPI_BD_REG) & PIIX_GPI_BD_REG)
-							 >> PIIX_GPI_BD_SHIFT;
-/*
- * Get Board rev.
- * First, we have to initialize the 307 part to allow us access
- * to the GPIO registers.  Let's map them at 0x0fc0 which is right
- * after the PIIX4 PM section.
- */
-	outb_p(SIO_DEV_SEL, SIO_INDEX);
-	outb_p(SIO_GP_DEV, SIO_DATA);	/* Talk to GPIO regs. */
-    
-	outb_p(SIO_DEV_MSB, SIO_INDEX);
-	outb_p(SIO_GP_MSB, SIO_DATA);	/* MSB of GPIO base address */
-
-	outb_p(SIO_DEV_LSB, SIO_INDEX);
-	outb_p(SIO_GP_LSB, SIO_DATA);	/* LSB of GPIO base address */
-
-	outb_p(SIO_DEV_ENB, SIO_INDEX);
-	outb_p(1, SIO_DATA);		/* Enable GPIO registers. */
-    
-/*
- * Now, we have to map the power management section to write
- * a bit which enables access to the GPIO registers.
- * What lunatic came up with this shit?
- */
-	outb_p(SIO_DEV_SEL, SIO_INDEX);
-	outb_p(SIO_PM_DEV, SIO_DATA);	/* Talk to GPIO regs. */
-
-	outb_p(SIO_DEV_MSB, SIO_INDEX);
-	outb_p(SIO_PM_MSB, SIO_DATA);	/* MSB of PM base address */
-    
-	outb_p(SIO_DEV_LSB, SIO_INDEX);
-	outb_p(SIO_PM_LSB, SIO_DATA);	/* LSB of PM base address */
-
-	outb_p(SIO_DEV_ENB, SIO_INDEX);
-	outb_p(1, SIO_DATA);		/* Enable PM registers. */
-    
-/*
- * Now, write the PM register which enables the GPIO registers.
- */
-	outb_p(SIO_PM_FER2, SIO_PM_INDEX);
-	outb_p(SIO_PM_GP_EN, SIO_PM_DATA);
-    
-/*
- * Now, initialize the GPIO registers.
- * We want them all to be inputs which is the
- * power on default, so let's leave them alone.
- * So, let's just read the board rev!
- */
-	raw = inb_p(SIO_GP_DATA1);
-	raw &= 0x7f;	/* 7 bits of valid board revision ID. */
-
-	if (visws_board_type == VISWS_320) {
-		if (raw < 0x6) {
-			visws_board_rev = 4;
-		} else if (raw < 0xc) {
-			visws_board_rev = 5;
-		} else {
-			visws_board_rev = 6;
-	
-		}
-	} else if (visws_board_type == VISWS_540) {
-			visws_board_rev = 2;
-		} else {
-			visws_board_rev = raw;
-		}
-
-		printk(KERN_INFO "Silicon Graphics %s (rev %d)\n",
-			visws_board_type == VISWS_320 ? "320" :
-			(visws_board_type == VISWS_540 ? "540" :
-					"unknown"),
-					visws_board_rev);
-	}
-#endif
-
 
 static char command_line[COMMAND_LINE_SIZE];
        char saved_command_line[COMMAND_LINE_SIZE];


-- 
Dave Jones.                    http://www.codemonkey.org.uk
SuSE Labs.
