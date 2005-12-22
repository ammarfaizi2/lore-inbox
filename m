Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965059AbVLVFBU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965059AbVLVFBU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 00:01:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965048AbVLVEtj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 23:49:39 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:21456 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S965047AbVLVEtU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 23:49:20 -0500
To: linux-m68k@vger.kernel.org
Subject: [PATCH 03/36] m68k: namespace pollution fix (custom->amiga_custom)
Cc: linux-kernel@vger.kernel.org
Message-Id: <E1EpIOF-0004q4-FH@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Thu, 22 Dec 2005 04:49:19 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>
Date: 1134847109 -0500

in amigahw.h custom renamed to amiga_custom, in drivers with few instances
the same replacement, in the rest - #define custom amiga_custom in driver
itself

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 arch/m68k/amiga/amiints.c           |   46 ++++++++++++++++++-----------------
 arch/m68k/amiga/amisound.c          |    2 ++
 arch/m68k/amiga/cia.c               |    8 +++---
 arch/m68k/amiga/config.c            |   18 +++++++-------
 arch/m68k/kernel/asm-offsets.c      |    2 +-
 arch/ppc/amiga/amiints.c            |   40 +++++++++++++++---------------
 arch/ppc/amiga/cia.c                |    8 +++---
 arch/ppc/amiga/config.c             |   18 +++++++-------
 arch/ppc/platforms/apus_setup.c     |   16 ++++++------
 drivers/block/amiflop.c             |    2 ++
 drivers/char/amiserial.c            |    1 +
 drivers/input/joystick/amijoy.c     |    4 ++-
 drivers/input/mouse/amimouse.c      |    6 ++---
 drivers/scsi/blz1230.c              |    4 ++-
 drivers/scsi/blz2060.c              |    4 ++-
 drivers/scsi/cyberstorm.c           |    4 ++-
 drivers/scsi/cyberstormII.c         |    4 ++-
 drivers/scsi/fastlane.c             |    4 ++-
 drivers/scsi/oktagon_esp.c          |    2 +-
 drivers/video/amifb.c               |    2 ++
 include/asm-m68k/amigahw.h          |   12 +++++----
 sound/oss/dmasound/dmasound_paula.c |    1 +
 22 files changed, 108 insertions(+), 100 deletions(-)

5eaa74e5dd96439162a9a8f6e750fc276494a9a8
diff --git a/arch/m68k/amiga/amiints.c b/arch/m68k/amiga/amiints.c
index d9edf2d..b0aa61b 100644
--- a/arch/m68k/amiga/amiints.c
+++ b/arch/m68k/amiga/amiints.c
@@ -126,9 +126,9 @@ void __init amiga_init_IRQ(void)
 		gayle.inten = GAYLE_IRQ_IDE;
 
 	/* turn off all interrupts and enable the master interrupt bit */
-	custom.intena = 0x7fff;
-	custom.intreq = 0x7fff;
-	custom.intena = IF_SETCLR | IF_INTEN;
+	amiga_custom.intena = 0x7fff;
+	amiga_custom.intreq = 0x7fff;
+	amiga_custom.intena = IF_SETCLR | IF_INTEN;
 
 	cia_init_IRQ(&ciaa_base);
 	cia_init_IRQ(&ciab_base);
@@ -245,7 +245,7 @@ int amiga_request_irq(unsigned int irq,
 
 	/* enable the interrupt */
 	if (irq < IRQ_AMIGA_PORTS && !ami_ablecount[irq])
-		custom.intena = IF_SETCLR | amiga_intena_vals[irq];
+		amiga_custom.intena = IF_SETCLR | amiga_intena_vals[irq];
 
 	return error;
 }
@@ -274,7 +274,7 @@ void amiga_free_irq(unsigned int irq, vo
 		amiga_delete_irq(&ami_irq_list[irq], dev_id);
 		/* if server list empty, disable the interrupt */
 		if (!ami_irq_list[irq] && irq < IRQ_AMIGA_PORTS)
-			custom.intena = amiga_intena_vals[irq];
+			amiga_custom.intena = amiga_intena_vals[irq];
 	} else {
 		if (ami_irq_list[irq]->dev_id != dev_id)
 			printk("%s: removing probably wrong IRQ %d from %s\n",
@@ -283,7 +283,7 @@ void amiga_free_irq(unsigned int irq, vo
 		ami_irq_list[irq]->flags   = 0;
 		ami_irq_list[irq]->dev_id  = NULL;
 		ami_irq_list[irq]->devname = NULL;
-		custom.intena = amiga_intena_vals[irq];
+		amiga_custom.intena = amiga_intena_vals[irq];
 	}
 }
 
@@ -327,7 +327,7 @@ void amiga_enable_irq(unsigned int irq)
 	}
 
 	/* enable the interrupt */
-	custom.intena = IF_SETCLR | amiga_intena_vals[irq];
+	amiga_custom.intena = IF_SETCLR | amiga_intena_vals[irq];
 }
 
 void amiga_disable_irq(unsigned int irq)
@@ -358,7 +358,7 @@ void amiga_disable_irq(unsigned int irq)
 	}
 
 	/* disable the interrupt */
-	custom.intena = amiga_intena_vals[irq];
+	amiga_custom.intena = amiga_intena_vals[irq];
 }
 
 inline void amiga_do_irq(int irq, struct pt_regs *fp)
@@ -373,7 +373,7 @@ void amiga_do_irq_list(int irq, struct p
 
 	kstat_cpu(0).irqs[SYS_IRQS + irq]++;
 
-	custom.intreq = amiga_intena_vals[irq];
+	amiga_custom.intreq = amiga_intena_vals[irq];
 
 	for (node = ami_irq_list[irq]; node; node = node->next)
 		node->handler(irq, node->dev_id, fp);
@@ -385,23 +385,23 @@ void amiga_do_irq_list(int irq, struct p
 
 static irqreturn_t ami_int1(int irq, void *dev_id, struct pt_regs *fp)
 {
-	unsigned short ints = custom.intreqr & custom.intenar;
+	unsigned short ints = amiga_custom.intreqr & amiga_custom.intenar;
 
 	/* if serial transmit buffer empty, interrupt */
 	if (ints & IF_TBE) {
-		custom.intreq = IF_TBE;
+		amiga_custom.intreq = IF_TBE;
 		amiga_do_irq(IRQ_AMIGA_TBE, fp);
 	}
 
 	/* if floppy disk transfer complete, interrupt */
 	if (ints & IF_DSKBLK) {
-		custom.intreq = IF_DSKBLK;
+		amiga_custom.intreq = IF_DSKBLK;
 		amiga_do_irq(IRQ_AMIGA_DSKBLK, fp);
 	}
 
 	/* if software interrupt set, interrupt */
 	if (ints & IF_SOFT) {
-		custom.intreq = IF_SOFT;
+		amiga_custom.intreq = IF_SOFT;
 		amiga_do_irq(IRQ_AMIGA_SOFT, fp);
 	}
 	return IRQ_HANDLED;
@@ -409,17 +409,17 @@ static irqreturn_t ami_int1(int irq, voi
 
 static irqreturn_t ami_int3(int irq, void *dev_id, struct pt_regs *fp)
 {
-	unsigned short ints = custom.intreqr & custom.intenar;
+	unsigned short ints = amiga_custom.intreqr & amiga_custom.intenar;
 
 	/* if a blitter interrupt */
 	if (ints & IF_BLIT) {
-		custom.intreq = IF_BLIT;
+		amiga_custom.intreq = IF_BLIT;
 		amiga_do_irq(IRQ_AMIGA_BLIT, fp);
 	}
 
 	/* if a copper interrupt */
 	if (ints & IF_COPER) {
-		custom.intreq = IF_COPER;
+		amiga_custom.intreq = IF_COPER;
 		amiga_do_irq(IRQ_AMIGA_COPPER, fp);
 	}
 
@@ -431,29 +431,29 @@ static irqreturn_t ami_int3(int irq, voi
 
 static irqreturn_t ami_int4(int irq, void *dev_id, struct pt_regs *fp)
 {
-	unsigned short ints = custom.intreqr & custom.intenar;
+	unsigned short ints = amiga_custom.intreqr & amiga_custom.intenar;
 
 	/* if audio 0 interrupt */
 	if (ints & IF_AUD0) {
-		custom.intreq = IF_AUD0;
+		amiga_custom.intreq = IF_AUD0;
 		amiga_do_irq(IRQ_AMIGA_AUD0, fp);
 	}
 
 	/* if audio 1 interrupt */
 	if (ints & IF_AUD1) {
-		custom.intreq = IF_AUD1;
+		amiga_custom.intreq = IF_AUD1;
 		amiga_do_irq(IRQ_AMIGA_AUD1, fp);
 	}
 
 	/* if audio 2 interrupt */
 	if (ints & IF_AUD2) {
-		custom.intreq = IF_AUD2;
+		amiga_custom.intreq = IF_AUD2;
 		amiga_do_irq(IRQ_AMIGA_AUD2, fp);
 	}
 
 	/* if audio 3 interrupt */
 	if (ints & IF_AUD3) {
-		custom.intreq = IF_AUD3;
+		amiga_custom.intreq = IF_AUD3;
 		amiga_do_irq(IRQ_AMIGA_AUD3, fp);
 	}
 	return IRQ_HANDLED;
@@ -461,7 +461,7 @@ static irqreturn_t ami_int4(int irq, voi
 
 static irqreturn_t ami_int5(int irq, void *dev_id, struct pt_regs *fp)
 {
-	unsigned short ints = custom.intreqr & custom.intenar;
+	unsigned short ints = amiga_custom.intreqr & amiga_custom.intenar;
 
 	/* if serial receive buffer full interrupt */
 	if (ints & IF_RBF) {
@@ -471,7 +471,7 @@ static irqreturn_t ami_int5(int irq, voi
 
 	/* if a disk sync interrupt */
 	if (ints & IF_DSKSYN) {
-		custom.intreq = IF_DSKSYN;
+		amiga_custom.intreq = IF_DSKSYN;
 		amiga_do_irq(IRQ_AMIGA_DSKSYN, fp);
 	}
 	return IRQ_HANDLED;
diff --git a/arch/m68k/amiga/amisound.c b/arch/m68k/amiga/amisound.c
index bd5d134..ae94db5 100644
--- a/arch/m68k/amiga/amisound.c
+++ b/arch/m68k/amiga/amisound.c
@@ -24,6 +24,8 @@ static const signed char sine_data[] = {
 };
 #define DATA_SIZE	(sizeof(sine_data)/sizeof(sine_data[0]))
 
+#define custom amiga_custom
+
     /*
      * The minimum period for audio may be modified by the frame buffer
      * device since it depends on htotal (for OCS/ECS/AGA)
diff --git a/arch/m68k/amiga/cia.c b/arch/m68k/amiga/cia.c
index 7d55682..9476eb9 100644
--- a/arch/m68k/amiga/cia.c
+++ b/arch/m68k/amiga/cia.c
@@ -60,7 +60,7 @@ unsigned char cia_set_irq(struct ciabase
 	else
 		base->icr_data &= ~mask;
 	if (base->icr_data & base->icr_mask)
-		custom.intreq = IF_SETCLR | base->int_mask;
+		amiga_custom.intreq = IF_SETCLR | base->int_mask;
 	return old & base->icr_mask;
 }
 
@@ -89,7 +89,7 @@ unsigned char cia_able_irq(struct ciabas
 		}
 	}
 	if (base->icr_data & base->icr_mask)
-		custom.intreq = IF_SETCLR | base->int_mask;
+		amiga_custom.intreq = IF_SETCLR | base->int_mask;
 	return old;
 }
 
@@ -133,7 +133,7 @@ static irqreturn_t cia_handler(int irq, 
 	mach_irq = base->cia_irq;
 	irq = SYS_IRQS + mach_irq;
 	ints = cia_set_irq(base, CIA_ICR_ALL);
-	custom.intreq = base->int_mask;
+	amiga_custom.intreq = base->int_mask;
 	for (i = 0; i < CIA_IRQS; i++, irq++, mach_irq++) {
 		if (ints & 1) {
 			kstat_cpu(0).irqs[irq]++;
@@ -162,7 +162,7 @@ void __init cia_init_IRQ(struct ciabase 
 	/* install CIA handler */
 	request_irq(base->handler_irq, cia_handler, 0, base->name, base);
 
-	custom.intena = IF_SETCLR | base->int_mask;
+	amiga_custom.intena = IF_SETCLR | base->int_mask;
 }
 
 int cia_get_irq_list(struct ciabase *base, struct seq_file *p)
diff --git a/arch/m68k/amiga/config.c b/arch/m68k/amiga/config.c
index 4775e18..da24476 100644
--- a/arch/m68k/amiga/config.c
+++ b/arch/m68k/amiga/config.c
@@ -290,7 +290,7 @@ static void __init amiga_identify(void)
     case CS_OCS:
     case CS_ECS:
     case CS_AGA:
-      switch (custom.deniseid & 0xf) {
+      switch (amiga_custom.deniseid & 0xf) {
       case 0x0c:
 	AMIGAHW_SET(DENISE_HR);
 	break;
@@ -303,7 +303,7 @@ static void __init amiga_identify(void)
       AMIGAHW_SET(DENISE);
       break;
     }
-    switch ((custom.vposr>>8) & 0x7f) {
+    switch ((amiga_custom.vposr>>8) & 0x7f) {
     case 0x00:
       AMIGAHW_SET(AGNUS_PAL);
       break;
@@ -447,9 +447,9 @@ void __init config_amiga(void)
   amiga_colorclock = 5*amiga_eclock;	/* 3.5 MHz */
 
   /* clear all DMA bits */
-  custom.dmacon = DMAF_ALL;
+  amiga_custom.dmacon = DMAF_ALL;
   /* ensure that the DMA master bit is set */
-  custom.dmacon = DMAF_SETCLR | DMAF_MASTER;
+  amiga_custom.dmacon = DMAF_SETCLR | DMAF_MASTER;
 
   /* don't use Z2 RAM as system memory on Z3 capable machines */
   if (AMIGAHW_PRESENT(ZORRO3)) {
@@ -830,8 +830,8 @@ static void amiga_savekmsg_init(void)
 
 static void amiga_serial_putc(char c)
 {
-    custom.serdat = (unsigned char)c | 0x100;
-    while (!(custom.serdatr & 0x2000))
+    amiga_custom.serdat = (unsigned char)c | 0x100;
+    while (!(amiga_custom.serdatr & 0x2000))
 	;
 }
 
@@ -855,11 +855,11 @@ int amiga_serial_console_wait_key(struct
 {
     int ch;
 
-    while (!(custom.intreqr & IF_RBF))
+    while (!(amiga_custom.intreqr & IF_RBF))
 	barrier();
-    ch = custom.serdatr & 0xff;
+    ch = amiga_custom.serdatr & 0xff;
     /* clear the interrupt, so that another character can be read */
-    custom.intreq = IF_RBF;
+    amiga_custom.intreq = IF_RBF;
     return ch;
 }
 
diff --git a/arch/m68k/kernel/asm-offsets.c b/arch/m68k/kernel/asm-offsets.c
index c787c5b..246a882 100644
--- a/arch/m68k/kernel/asm-offsets.c
+++ b/arch/m68k/kernel/asm-offsets.c
@@ -92,7 +92,7 @@ int main(void)
 	DEFINE(TRAP_TRACE, TRAP_TRACE);
 
 	/* offsets into the custom struct */
-	DEFINE(CUSTOMBASE, &custom);
+	DEFINE(CUSTOMBASE, &amiga_custom);
 	DEFINE(C_INTENAR, offsetof(struct CUSTOM, intenar));
 	DEFINE(C_INTREQR, offsetof(struct CUSTOM, intreqr));
 	DEFINE(C_INTENA, offsetof(struct CUSTOM, intena));
diff --git a/arch/ppc/amiga/amiints.c b/arch/ppc/amiga/amiints.c
index 91195e2..5f35cf3 100644
--- a/arch/ppc/amiga/amiints.c
+++ b/arch/ppc/amiga/amiints.c
@@ -96,8 +96,8 @@ void amiga_init_IRQ(void)
 		gayle.inten = GAYLE_IRQ_IDE;
 
 	/* turn off all interrupts... */
-	custom.intena = 0x7fff;
-	custom.intreq = 0x7fff;
+	amiga_custom.intena = 0x7fff;
+	amiga_custom.intreq = 0x7fff;
 
 #ifdef CONFIG_APUS
 	/* Clear any inter-CPU interrupt requests. Circumvents bug in
@@ -110,7 +110,7 @@ void amiga_init_IRQ(void)
 	APUS_WRITE(APUS_IPL_EMU, IPLEMU_SETRESET | IPLEMU_IPLMASK);
 #endif
 	/* ... and enable the master interrupt bit */
-	custom.intena = IF_SETCLR | IF_INTEN;
+	amiga_custom.intena = IF_SETCLR | IF_INTEN;
 
 	cia_init_IRQ(&ciaa_base);
 	cia_init_IRQ(&ciab_base);
@@ -151,7 +151,7 @@ void amiga_enable_irq(unsigned int irq)
 	}
 
 	/* enable the interrupt */
-	custom.intena = IF_SETCLR | ami_intena_vals[irq];
+	amiga_custom.intena = IF_SETCLR | ami_intena_vals[irq];
 }
 
 void amiga_disable_irq(unsigned int irq)
@@ -177,7 +177,7 @@ void amiga_disable_irq(unsigned int irq)
 	}
 
 	/* disable the interrupt */
-	custom.intena = ami_intena_vals[irq];
+	amiga_custom.intena = ami_intena_vals[irq];
 }
 
 inline void amiga_do_irq(int irq, struct pt_regs *fp)
@@ -196,7 +196,7 @@ void amiga_do_irq_list(int irq, struct p
 
 	kstat_cpu(0).irqs[irq]++;
 
-	custom.intreq = ami_intena_vals[irq];
+	amiga_custom.intreq = ami_intena_vals[irq];
 
 	for (action = desc->action; action; action = action->next)
 		action->handler(irq, action->dev_id, fp);
@@ -208,40 +208,40 @@ void amiga_do_irq_list(int irq, struct p
 
 static void ami_int1(int irq, void *dev_id, struct pt_regs *fp)
 {
-	unsigned short ints = custom.intreqr & custom.intenar;
+	unsigned short ints = amiga_custom.intreqr & amiga_custom.intenar;
 
 	/* if serial transmit buffer empty, interrupt */
 	if (ints & IF_TBE) {
-		custom.intreq = IF_TBE;
+		amiga_custom.intreq = IF_TBE;
 		amiga_do_irq(IRQ_AMIGA_TBE, fp);
 	}
 
 	/* if floppy disk transfer complete, interrupt */
 	if (ints & IF_DSKBLK) {
-		custom.intreq = IF_DSKBLK;
+		amiga_custom.intreq = IF_DSKBLK;
 		amiga_do_irq(IRQ_AMIGA_DSKBLK, fp);
 	}
 
 	/* if software interrupt set, interrupt */
 	if (ints & IF_SOFT) {
-		custom.intreq = IF_SOFT;
+		amiga_custom.intreq = IF_SOFT;
 		amiga_do_irq(IRQ_AMIGA_SOFT, fp);
 	}
 }
 
 static void ami_int3(int irq, void *dev_id, struct pt_regs *fp)
 {
-	unsigned short ints = custom.intreqr & custom.intenar;
+	unsigned short ints = amiga_custom.intreqr & amiga_custom.intenar;
 
 	/* if a blitter interrupt */
 	if (ints & IF_BLIT) {
-		custom.intreq = IF_BLIT;
+		amiga_custom.intreq = IF_BLIT;
 		amiga_do_irq(IRQ_AMIGA_BLIT, fp);
 	}
 
 	/* if a copper interrupt */
 	if (ints & IF_COPER) {
-		custom.intreq = IF_COPER;
+		amiga_custom.intreq = IF_COPER;
 		amiga_do_irq(IRQ_AMIGA_COPPER, fp);
 	}
 
@@ -252,36 +252,36 @@ static void ami_int3(int irq, void *dev_
 
 static void ami_int4(int irq, void *dev_id, struct pt_regs *fp)
 {
-	unsigned short ints = custom.intreqr & custom.intenar;
+	unsigned short ints = amiga_custom.intreqr & amiga_custom.intenar;
 
 	/* if audio 0 interrupt */
 	if (ints & IF_AUD0) {
-		custom.intreq = IF_AUD0;
+		amiga_custom.intreq = IF_AUD0;
 		amiga_do_irq(IRQ_AMIGA_AUD0, fp);
 	}
 
 	/* if audio 1 interrupt */
 	if (ints & IF_AUD1) {
-		custom.intreq = IF_AUD1;
+		amiga_custom.intreq = IF_AUD1;
 		amiga_do_irq(IRQ_AMIGA_AUD1, fp);
 	}
 
 	/* if audio 2 interrupt */
 	if (ints & IF_AUD2) {
-		custom.intreq = IF_AUD2;
+		amiga_custom.intreq = IF_AUD2;
 		amiga_do_irq(IRQ_AMIGA_AUD2, fp);
 	}
 
 	/* if audio 3 interrupt */
 	if (ints & IF_AUD3) {
-		custom.intreq = IF_AUD3;
+		amiga_custom.intreq = IF_AUD3;
 		amiga_do_irq(IRQ_AMIGA_AUD3, fp);
 	}
 }
 
 static void ami_int5(int irq, void *dev_id, struct pt_regs *fp)
 {
-	unsigned short ints = custom.intreqr & custom.intenar;
+	unsigned short ints = amiga_custom.intreqr & amiga_custom.intenar;
 
 	/* if serial receive buffer full interrupt */
 	if (ints & IF_RBF) {
@@ -291,7 +291,7 @@ static void ami_int5(int irq, void *dev_
 
 	/* if a disk sync interrupt */
 	if (ints & IF_DSKSYN) {
-		custom.intreq = IF_DSKSYN;
+		amiga_custom.intreq = IF_DSKSYN;
 		amiga_do_irq(IRQ_AMIGA_DSKSYN, fp);
 	}
 }
diff --git a/arch/ppc/amiga/cia.c b/arch/ppc/amiga/cia.c
index ad96146..4431c58 100644
--- a/arch/ppc/amiga/cia.c
+++ b/arch/ppc/amiga/cia.c
@@ -66,7 +66,7 @@ static unsigned char cia_set_irq_private
 	else
 		base->icr_data &= ~mask;
 	if (base->icr_data & base->icr_mask)
-		custom.intreq = IF_SETCLR | base->int_mask;
+		amiga_custom.intreq = IF_SETCLR | base->int_mask;
 	return old & base->icr_mask;
 }
 
@@ -114,7 +114,7 @@ static unsigned char cia_able_irq_privat
 	base->icr_mask &= CIA_ICR_ALL;
 
 	if (base->icr_data & base->icr_mask)
-		custom.intreq = IF_SETCLR | base->int_mask;
+		amiga_custom.intreq = IF_SETCLR | base->int_mask;
 	return old;
 }
 
@@ -145,7 +145,7 @@ static void cia_handler(int irq, void *d
 	irq = base->cia_irq;
 	desc = irq_desc + irq;
 	ints = cia_set_irq_private(base, CIA_ICR_ALL);
-	custom.intreq = base->int_mask;
+	amiga_custom.intreq = base->int_mask;
 	for (i = 0; i < CIA_IRQS; i++, irq++) {
 		if (ints & 1) {
 			kstat_cpu(0).irqs[irq]++;
@@ -174,5 +174,5 @@ void __init cia_init_IRQ(struct ciabase 
 	action->name = base->name;
 	setup_irq(base->handler_irq, &amiga_sys_irqaction[base->handler_irq-IRQ_AMIGA_AUTO]);
 
-	custom.intena = IF_SETCLR | base->int_mask;
+	amiga_custom.intena = IF_SETCLR | base->int_mask;
 }
diff --git a/arch/ppc/amiga/config.c b/arch/ppc/amiga/config.c
index af881d7..55794d1 100644
--- a/arch/ppc/amiga/config.c
+++ b/arch/ppc/amiga/config.c
@@ -281,7 +281,7 @@ static void __init amiga_identify(void)
     case CS_OCS:
     case CS_ECS:
     case CS_AGA:
-      switch (custom.deniseid & 0xf) {
+      switch (amiga_custom.deniseid & 0xf) {
       case 0x0c:
 	AMIGAHW_SET(DENISE_HR);
 	break;
@@ -294,7 +294,7 @@ static void __init amiga_identify(void)
       AMIGAHW_SET(DENISE);
       break;
     }
-    switch ((custom.vposr>>8) & 0x7f) {
+    switch ((amiga_custom.vposr>>8) & 0x7f) {
     case 0x00:
       AMIGAHW_SET(AGNUS_PAL);
       break;
@@ -432,9 +432,9 @@ void __init config_amiga(void)
   amiga_colorclock = 5*amiga_eclock;	/* 3.5 MHz */
 
   /* clear all DMA bits */
-  custom.dmacon = DMAF_ALL;
+  amiga_custom.dmacon = DMAF_ALL;
   /* ensure that the DMA master bit is set */
-  custom.dmacon = DMAF_SETCLR | DMAF_MASTER;
+  amiga_custom.dmacon = DMAF_SETCLR | DMAF_MASTER;
 
   /* request all RAM */
   for (i = 0; i < m68k_num_memory; i++) {
@@ -753,9 +753,9 @@ static void amiga_savekmsg_init(void)
 
 static void amiga_serial_putc(char c)
 {
-    custom.serdat = (unsigned char)c | 0x100;
+    amiga_custom.serdat = (unsigned char)c | 0x100;
     mb();
-    while (!(custom.serdatr & 0x2000))
+    while (!(amiga_custom.serdatr & 0x2000))
        ;
 }
 
@@ -785,11 +785,11 @@ int amiga_serial_console_wait_key(struct
 {
     int ch;
 
-    while (!(custom.intreqr & IF_RBF))
+    while (!(amiga_custom.intreqr & IF_RBF))
 	barrier();
-    ch = custom.serdatr & 0xff;
+    ch = amiga_custom.serdatr & 0xff;
     /* clear the interrupt, so that another character can be read */
-    custom.intreq = IF_RBF;
+    amiga_custom.intreq = IF_RBF;
     return ch;
 }
 
diff --git a/arch/ppc/platforms/apus_setup.c b/arch/ppc/platforms/apus_setup.c
index 2f74fde..f62179f 100644
--- a/arch/ppc/platforms/apus_setup.c
+++ b/arch/ppc/platforms/apus_setup.c
@@ -574,9 +574,9 @@ static __inline__ void ser_RTSon(void)
 
 int __debug_ser_out( unsigned char c )
 {
-	custom.serdat = c | 0x100;
+	amiga_custom.serdat = c | 0x100;
 	mb();
-	while (!(custom.serdatr & 0x2000))
+	while (!(amiga_custom.serdatr & 0x2000))
 		barrier();
 	return 1;
 }
@@ -586,11 +586,11 @@ unsigned char __debug_ser_in( void )
 	unsigned char c;
 
 	/* XXX: is that ok?? derived from amiga_ser.c... */
-	while( !(custom.intreqr & IF_RBF) )
+	while( !(amiga_custom.intreqr & IF_RBF) )
 		barrier();
-	c = custom.serdatr;
+	c = amiga_custom.serdatr;
 	/* clear the interrupt, so that another character can be read */
-	custom.intreq = IF_RBF;
+	amiga_custom.intreq = IF_RBF;
 	return c;
 }
 
@@ -601,10 +601,10 @@ int __debug_serinit( void )
 	local_irq_save(flags);
 
 	/* turn off Rx and Tx interrupts */
-	custom.intena = IF_RBF | IF_TBE;
+	amiga_custom.intena = IF_RBF | IF_TBE;
 
 	/* clear any pending interrupt */
-	custom.intreq = IF_RBF | IF_TBE;
+	amiga_custom.intreq = IF_RBF | IF_TBE;
 
 	local_irq_restore(flags);
 
@@ -617,7 +617,7 @@ int __debug_serinit( void )
 
 #ifdef CONFIG_KGDB
 	/* turn Rx interrupts on for GDB */
-	custom.intena = IF_SETCLR | IF_RBF;
+	amiga_custom.intena = IF_SETCLR | IF_RBF;
 	ser_RTSon();
 #endif
 
diff --git a/drivers/block/amiflop.c b/drivers/block/amiflop.c
index 0acbfff..8c69533 100644
--- a/drivers/block/amiflop.c
+++ b/drivers/block/amiflop.c
@@ -194,6 +194,8 @@ static DECLARE_WAIT_QUEUE_HEAD(ms_wait);
  */
 #define MAX_ERRORS 12
 
+#define custom amiga_custom
+
 /* Prevent "aliased" accesses. */
 static int fd_ref[4] = { 0,0,0,0 };
 static int fd_device[4] = { 0, 0, 0, 0 };
diff --git a/drivers/char/amiserial.c b/drivers/char/amiserial.c
index a124f8c..2bf4fe3 100644
--- a/drivers/char/amiserial.c
+++ b/drivers/char/amiserial.c
@@ -99,6 +99,7 @@ static char *serial_version = "4.30";
 #define _INLINE_ inline
 #endif
 
+#define custom amiga_custom
 static char *serial_name = "Amiga-builtin serial driver";
 
 static struct tty_driver *serial_driver;
diff --git a/drivers/input/joystick/amijoy.c b/drivers/input/joystick/amijoy.c
index 8558a99..ec55a29 100644
--- a/drivers/input/joystick/amijoy.c
+++ b/drivers/input/joystick/amijoy.c
@@ -64,8 +64,8 @@ static irqreturn_t amijoy_interrupt(int 
 		if (amijoy[i]) {
 
 			switch (i) {
-				case 0: data = ~custom.joy0dat; button = (~ciaa.pra >> 6) & 1; break;
-				case 1: data = ~custom.joy1dat; button = (~ciaa.pra >> 7) & 1; break;
+				case 0: data = ~amiga_custom.joy0dat; button = (~ciaa.pra >> 6) & 1; break;
+				case 1: data = ~amiga_custom.joy1dat; button = (~ciaa.pra >> 7) & 1; break;
 			}
 
 			input_regs(amijoy_dev[i], fp);
diff --git a/drivers/input/mouse/amimouse.c b/drivers/input/mouse/amimouse.c
index d13d4c8..c8b2cc9 100644
--- a/drivers/input/mouse/amimouse.c
+++ b/drivers/input/mouse/amimouse.c
@@ -41,7 +41,7 @@ static irqreturn_t amimouse_interrupt(in
 	unsigned short joy0dat, potgor;
 	int nx, ny, dx, dy;
 
-	joy0dat = custom.joy0dat;
+	joy0dat = amiga_custom.joy0dat;
 
 	nx = joy0dat & 0xff;
 	ny = joy0dat >> 8;
@@ -57,7 +57,7 @@ static irqreturn_t amimouse_interrupt(in
 	amimouse_lastx = nx;
 	amimouse_lasty = ny;
 
-	potgor = custom.potgor;
+	potgor = amiga_custom.potgor;
 
 	input_regs(amimouse_dev, fp);
 
@@ -77,7 +77,7 @@ static int amimouse_open(struct input_de
 {
 	unsigned short joy0dat;
 
-	joy0dat = custom.joy0dat;
+	joy0dat = amiga_custom.joy0dat;
 
 	amimouse_lastx = joy0dat & 0xff;
 	amimouse_lasty = joy0dat >> 8;
diff --git a/drivers/scsi/blz1230.c b/drivers/scsi/blz1230.c
index 763e409..3867ac2 100644
--- a/drivers/scsi/blz1230.c
+++ b/drivers/scsi/blz1230.c
@@ -224,7 +224,7 @@ static int dma_can_transfer(struct NCR_E
 static void dma_dump_state(struct NCR_ESP *esp)
 {
 	ESPLOG(("intreq:<%04x>, intena:<%04x>\n",
-		custom.intreqr, custom.intenar));
+		amiga_custom.intreqr, amiga_custom.intenar));
 }
 
 void dma_init_read(struct NCR_ESP *esp, __u32 addr, int length)
@@ -298,7 +298,7 @@ static int dma_irq_p(struct NCR_ESP *esp
 
 static int dma_ports_p(struct NCR_ESP *esp)
 {
-	return ((custom.intenar) & IF_PORTS);
+	return ((amiga_custom.intenar) & IF_PORTS);
 }
 
 static void dma_setup(struct NCR_ESP *esp, __u32 addr, int count, int write)
diff --git a/drivers/scsi/blz2060.c b/drivers/scsi/blz2060.c
index d72d05f..4ebe69e 100644
--- a/drivers/scsi/blz2060.c
+++ b/drivers/scsi/blz2060.c
@@ -190,7 +190,7 @@ static int dma_can_transfer(struct NCR_E
 static void dma_dump_state(struct NCR_ESP *esp)
 {
 	ESPLOG(("intreq:<%04x>, intena:<%04x>\n",
-		custom.intreqr, custom.intenar));
+		amiga_custom.intreqr, amiga_custom.intenar));
 }
 
 static void dma_init_read(struct NCR_ESP *esp, __u32 addr, int length)
@@ -251,7 +251,7 @@ static void dma_led_on(struct NCR_ESP *e
 
 static int dma_ports_p(struct NCR_ESP *esp)
 {
-	return ((custom.intenar) & IF_PORTS);
+	return ((amiga_custom.intenar) & IF_PORTS);
 }
 
 static void dma_setup(struct NCR_ESP *esp, __u32 addr, int count, int write)
diff --git a/drivers/scsi/cyberstorm.c b/drivers/scsi/cyberstorm.c
index f9b940e..a4a4fac 100644
--- a/drivers/scsi/cyberstorm.c
+++ b/drivers/scsi/cyberstorm.c
@@ -223,7 +223,7 @@ static void dma_dump_state(struct NCR_ES
 		esp->esp_id, ((struct cyber_dma_registers *)
 			      (esp->dregs))->cond_reg));
 	ESPLOG(("intreq:<%04x>, intena:<%04x>\n",
-		custom.intreqr, custom.intenar));
+		amiga_custom.intreqr, amiga_custom.intenar));
 }
 
 static void dma_init_read(struct NCR_ESP *esp, __u32 addr, int length)
@@ -322,7 +322,7 @@ static void dma_led_on(struct NCR_ESP *e
 
 static int dma_ports_p(struct NCR_ESP *esp)
 {
-	return ((custom.intenar) & IF_PORTS);
+	return ((amiga_custom.intenar) & IF_PORTS);
 }
 
 static void dma_setup(struct NCR_ESP *esp, __u32 addr, int count, int write)
diff --git a/drivers/scsi/cyberstormII.c b/drivers/scsi/cyberstormII.c
index a3caabf..3a803d7 100644
--- a/drivers/scsi/cyberstormII.c
+++ b/drivers/scsi/cyberstormII.c
@@ -200,7 +200,7 @@ static void dma_dump_state(struct NCR_ES
 		esp->esp_id, ((struct cyberII_dma_registers *)
 			      (esp->dregs))->cond_reg));
 	ESPLOG(("intreq:<%04x>, intena:<%04x>\n",
-		custom.intreqr, custom.intenar));
+		amiga_custom.intreqr, amiga_custom.intenar));
 }
 
 static void dma_init_read(struct NCR_ESP *esp, __u32 addr, int length)
@@ -259,7 +259,7 @@ static void dma_led_on(struct NCR_ESP *e
 
 static int dma_ports_p(struct NCR_ESP *esp)
 {
-	return ((custom.intenar) & IF_PORTS);
+	return ((amiga_custom.intenar) & IF_PORTS);
 }
 
 static void dma_setup(struct NCR_ESP *esp, __u32 addr, int count, int write)
diff --git a/drivers/scsi/fastlane.c b/drivers/scsi/fastlane.c
index ccee68b..8ae9c40 100644
--- a/drivers/scsi/fastlane.c
+++ b/drivers/scsi/fastlane.c
@@ -268,7 +268,7 @@ static void dma_dump_state(struct NCR_ES
 		esp->esp_id, ((struct fastlane_dma_registers *)
 			      (esp->dregs))->cond_reg));
 	ESPLOG(("intreq:<%04x>, intena:<%04x>\n",
-		custom.intreqr, custom.intenar));
+		amiga_custom.intreqr, amiga_custom.intenar));
 }
 
 static void dma_init_read(struct NCR_ESP *esp, __u32 addr, int length)
@@ -368,7 +368,7 @@ static void dma_led_on(struct NCR_ESP *e
 
 static int dma_ports_p(struct NCR_ESP *esp)
 {
-	return ((custom.intenar) & IF_PORTS);
+	return ((amiga_custom.intenar) & IF_PORTS);
 }
 
 static void dma_setup(struct NCR_ESP *esp, __u32 addr, int count, int write)
diff --git a/drivers/scsi/oktagon_esp.c b/drivers/scsi/oktagon_esp.c
index 5d9c9ad..dee426f 100644
--- a/drivers/scsi/oktagon_esp.c
+++ b/drivers/scsi/oktagon_esp.c
@@ -490,7 +490,7 @@ static void dma_led_on(struct NCR_ESP *e
 
 static int dma_ports_p(struct NCR_ESP *esp)
 {
-	return ((custom.intenar) & IF_PORTS);
+	return ((amiga_custom.intenar) & IF_PORTS);
 }
 
 static void dma_setup(struct NCR_ESP *esp, __u32 addr, int count, int write)
diff --git a/drivers/video/amifb.c b/drivers/video/amifb.c
index d549e21..8cfba10 100644
--- a/drivers/video/amifb.c
+++ b/drivers/video/amifb.c
@@ -590,6 +590,8 @@ static u_short maxfmode, chipset;
 #define highw(x)	((u_long)(x)>>16 & 0xffff)
 #define loww(x)		((u_long)(x) & 0xffff)
 
+#define custom		amiga_custom
+
 #define VBlankOn()	custom.intena = IF_SETCLR|IF_COPER
 #define VBlankOff()	custom.intena = IF_COPER
 
diff --git a/include/asm-m68k/amigahw.h b/include/asm-m68k/amigahw.h
index 3ae5d8d..a16fe4e 100644
--- a/include/asm-m68k/amigahw.h
+++ b/include/asm-m68k/amigahw.h
@@ -274,7 +274,7 @@ struct CIA {
 #define ZTWO_VADDR(x) (((unsigned long)(x))+zTwoBase)
 
 #define CUSTOM_PHYSADDR     (0xdff000)
-#define custom ((*(volatile struct CUSTOM *)(zTwoBase+CUSTOM_PHYSADDR)))
+#define amiga_custom ((*(volatile struct CUSTOM *)(zTwoBase+CUSTOM_PHYSADDR)))
 
 #define CIAA_PHYSADDR	  (0xbfe001)
 #define CIAB_PHYSADDR	  (0xbfd000)
@@ -294,12 +294,12 @@ static inline void amifb_video_off(void)
 {
 	if (amiga_chipset == CS_ECS || amiga_chipset == CS_AGA) {
 		/* program Denise/Lisa for a higher maximum play rate */
-		custom.htotal = 113;        /* 31 kHz */
-		custom.vtotal = 223;        /* 70 Hz */
-		custom.beamcon0 = 0x4390;   /* HARDDIS, VAR{BEAM,VSY,HSY,CSY}EN */
+		amiga_custom.htotal = 113;        /* 31 kHz */
+		amiga_custom.vtotal = 223;        /* 70 Hz */
+		amiga_custom.beamcon0 = 0x4390;   /* HARDDIS, VAR{BEAM,VSY,HSY,CSY}EN */
 		/* suspend the monitor */
-		custom.hsstrt = custom.hsstop = 116;
-		custom.vsstrt = custom.vsstop = 226;
+		amiga_custom.hsstrt = amiga_custom.hsstop = 116;
+		amiga_custom.vsstrt = amiga_custom.vsstop = 226;
 		amiga_audio_min_period = 57;
 	}
 }
diff --git a/sound/oss/dmasound/dmasound_paula.c b/sound/oss/dmasound/dmasound_paula.c
index d59f60b..f163868 100644
--- a/sound/oss/dmasound/dmasound_paula.c
+++ b/sound/oss/dmasound/dmasound_paula.c
@@ -34,6 +34,7 @@
 #define DMASOUND_PAULA_REVISION 0
 #define DMASOUND_PAULA_EDITION 4
 
+#define custom amiga_custom
    /*
     *	The minimum period for audio depends on htotal (for OCS/ECS/AGA)
     *	(Imported from arch/m68k/amiga/amisound.c)
-- 
0.99.9.GIT

