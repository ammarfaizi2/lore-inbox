Return-Path: <linux-kernel-owner@vger.kernel.org>
thread-index: AcQVpKgOmrFdQu3jSv279aI8QvQwRw==
Envelope-to: paul@sumlocktest.fsnet.co.uk
Delivery-date: Mon, 05 Jan 2004 06:11:22 +0000
Message-ID: <02bf01c415a4$a80e8440$d100000a@sbs2003.local>
X-Mailer: Microsoft CDO for Exchange 2000
Content-Class: urn:content-classes:message
From: "Dmitry Torokhov" <dtor_core@ameritech.net>
Importance: normal
Priority: normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.0
To: <Administrator@osdl.org>
Subject: Re: [PATCH 2/3] Convert mouse drivers to use module_param
Date: Mon, 29 Mar 2004 16:44:01 +0100
User-Agent: KMail/1.5.4
Cc: "Andrew Morton" <akpm@osdl.org>, <linux-kernel@vger.kernel.org>
References: <200401030350.43437.dtor_core@ameritech.net> <200401050059.25031.dtor_core@ameritech.net> <200401050101.20789.dtor_core@ameritech.net>
In-Reply-To: <200401050101.20789.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: <linux-kernel-owner@vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
X-OriginalArrivalTime: 29 Mar 2004 15:44:01.0234 (UTC) FILETIME=[A81A6B20:01C415A4]

===================================================================


ChangeSet@1.1581, 2004-01-05 00:25:23-05:00, dtor_core@ameritech.net
  Input: convert the rest of mouse devices to the new way of
         handling kernel parameters and document them in
         kernel-parameters.txt


 Documentation/kernel-parameters.txt |   12 ++++++++++--
 drivers/input/mouse/98busmouse.c    |   17 ++++-------------
 drivers/input/mouse/inport.c        |   19 +++++--------------
 drivers/input/mouse/logibm.c        |   17 ++++-------------
 drivers/input/mousedev.c            |   17 +++++++++--------
 5 files changed, 32 insertions(+), 50 deletions(-)


===================================================================



diff -Nru a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
--- a/Documentation/kernel-parameters.txt	Mon Jan  5 00:46:29 2004
+++ b/Documentation/kernel-parameters.txt	Mon Jan  5 00:46:29 2004
@@ -85,6 +85,9 @@
 			See header of drivers/scsi/53c7xx.c.
 			See also Documentation/scsi/ncr53c7xx.txt.
 
+	98busmouse.irq=	[HW,MOUSE] PC-9801 Bus Mouse Driver
+			Format: <irq>, default is 13
+
 	acpi=		[HW,ACPI] Advanced Configuration and Power Interface 
 			Format: { force | off | ht }
 			force -- enables ACPI for systems with default off
@@ -417,7 +420,7 @@
 
 	initrd=		[BOOT] Specify the location of the initial ramdisk
 
-	inport_irq=	[HW] Inport (ATI XL and Microsoft) busmouse driver
+	inport.irq=	[HW] Inport (ATI XL and Microsoft) busmouse driver
 			Format: <irq>
 
 	inttest=	[IA64]
@@ -465,7 +468,7 @@
 
 	lockd.tcpport=	[NFS]
 
-	logibm_irq=	[HW,MOUSE] Logitech Bus Mouse Driver
+	logibm.irq=	[HW,MOUSE] Logitech Bus Mouse Driver
 			Format: <irq>
 
 	log_buf_len=n	Sets the size of the printk ring buffer, in bytes.
@@ -564,6 +567,11 @@
 			See Documentation/video4linux/meye.txt.
 
 	mga=		[HW,DRM]
+
+	mousedev.xres	[MOUSE] Horizontal screen resolution, used for devices
+			reporting absolute coordinates, such as tablets
+	mousedev.yres	[MOUSE] Vertical screen resolution, used for devices
+			reporting absolute coordinates, such as tablets
 
 	mpu401=		[HW,OSS]
 			Format: <io>,<irq>
diff -Nru a/drivers/input/mouse/98busmouse.c b/drivers/input/mouse/98busmouse.c
--- a/drivers/input/mouse/98busmouse.c	Mon Jan  5 00:46:29 2004
+++ b/drivers/input/mouse/98busmouse.c	Mon Jan  5 00:46:29 2004
@@ -33,6 +33,7 @@
 
 #include <linux/config.h>
 #include <linux/module.h>
+#include <linux/moduleparam.h>
 #include <linux/delay.h>
 #include <linux/ioport.h>
 #include <linux/init.h>
@@ -69,9 +70,10 @@
 
 #define PC98BM_IRQ		13
 
-MODULE_PARM(pc98bm_irq, "i");
-
 static int pc98bm_irq = PC98BM_IRQ;
+module_param_named(irq, pc98bm_irq, uint, 0);
+MODULE_PARM_DESC(irq, "IRQ number (13=default)");
+
 static int pc98bm_used = 0;
 
 static irqreturn_t pc98bm_interrupt(int irq, void *dev_id, struct pt_regs *regs);
@@ -140,17 +142,6 @@
 
 	return IRQ_HANDLED;
 }
-
-#ifndef MODULE
-static int __init pc98bm_setup(char *str)
-{
-        int ints[4];
-        str = get_options(str, ARRAY_SIZE(ints), ints);
-        if (ints[0] > 0) pc98bm_irq = ints[1];
-        return 1;
-}
-__setup("pc98bm_irq=", pc98bm_setup);
-#endif
 
 static int __init pc98bm_init(void)
 {
diff -Nru a/drivers/input/mouse/inport.c b/drivers/input/mouse/inport.c
--- a/drivers/input/mouse/inport.c	Mon Jan  5 00:46:29 2004
+++ b/drivers/input/mouse/inport.c	Mon Jan  5 00:46:29 2004
@@ -35,6 +35,7 @@
  */
 
 #include <linux/module.h>
+#include <linux/moduleparam.h>
 #include <linux/config.h>
 #include <linux/ioport.h>
 #include <linux/init.h>
@@ -80,10 +81,11 @@
 
 #define INPORT_IRQ		5
 
-MODULE_PARM(inport_irq, "i");
-
 static int inport_irq = INPORT_IRQ;
-static int inport_used = 0;
+module_param_named(irq, inport_irq, uint, 0);
+MODULE_PARM_DESC(irq, "IRQ number (5=default)");
+
+static int inport_used;
 
 static irqreturn_t inport_interrupt(int irq, void *dev_id, struct pt_regs *regs);
 
@@ -152,17 +154,6 @@
 	input_sync(&inport_dev);
 	return IRQ_HANDLED;
 }
-
-#ifndef MODULE
-static int __init inport_setup(char *str)
-{
-        int ints[4];
-        str = get_options(str, ARRAY_SIZE(ints), ints);
-        if (ints[0] > 0) inport_irq = ints[1];
-        return 1;
-}
-__setup("inport_irq=", inport_setup);
-#endif
 
 static int __init inport_init(void)
 {
diff -Nru a/drivers/input/mouse/logibm.c b/drivers/input/mouse/logibm.c
--- a/drivers/input/mouse/logibm.c	Mon Jan  5 00:46:29 2004
+++ b/drivers/input/mouse/logibm.c	Mon Jan  5 00:46:29 2004
@@ -36,6 +36,7 @@
  */
 
 #include <linux/module.h>
+#include <linux/moduleparam.h>
 #include <linux/delay.h>
 #include <linux/ioport.h>
 #include <linux/init.h>
@@ -70,9 +71,10 @@
 
 #define LOGIBM_IRQ		5
 
-MODULE_PARM(logibm_irq, "i");
-
 static int logibm_irq = LOGIBM_IRQ;
+module_param_named(irq, logibm_irq, uint, 0);
+MODULE_PARM_DESC(irq, "IRQ number (5=default)");
+
 static int logibm_used = 0;
 
 static irqreturn_t logibm_interrupt(int irq, void *dev_id, struct pt_regs *regs);
@@ -141,17 +143,6 @@
 	outb(LOGIBM_ENABLE_IRQ, LOGIBM_CONTROL_PORT);
 	return IRQ_HANDLED;
 }
-
-#ifndef MODULE
-static int __init logibm_setup(char *str)
-{
-        int ints[4];
-        str = get_options(str, ARRAY_SIZE(ints), ints);
-        if (ints[0] > 0) logibm_irq = ints[1];
-        return 1;
-}
-__setup("logibm_irq=", logibm_setup);
-#endif
 
 static int __init logibm_init(void)
 {
diff -Nru a/drivers/input/mousedev.c b/drivers/input/mousedev.c
--- a/drivers/input/mousedev.c	Mon Jan  5 00:46:29 2004
+++ b/drivers/input/mousedev.c	Mon Jan  5 00:46:29 2004
@@ -15,6 +15,7 @@
 #include <linux/slab.h>
 #include <linux/poll.h>
 #include <linux/module.h>
+#include <linux/moduleparam.h>
 #include <linux/init.h>
 #include <linux/input.h>
 #include <linux/config.h>
@@ -38,6 +39,14 @@
 #define CONFIG_INPUT_MOUSEDEV_SCREEN_Y	768
 #endif
 
+static int xres = CONFIG_INPUT_MOUSEDEV_SCREEN_X;
+module_param(xres, uint, 0);
+MODULE_PARM_DESC(xres, "Horizontal screen resolution");
+
+static int yres = CONFIG_INPUT_MOUSEDEV_SCREEN_Y;
+module_param(yres, uint, 0);
+MODULE_PARM_DESC(yres, "Vertical screen resolution");
+
 struct mousedev {
 	int exist;
 	int open;
@@ -73,9 +82,6 @@
 static struct mousedev *mousedev_table[MOUSEDEV_MINORS];
 static struct mousedev mousedev_mix;
 
-static int xres = CONFIG_INPUT_MOUSEDEV_SCREEN_X;
-static int yres = CONFIG_INPUT_MOUSEDEV_SCREEN_Y;
-
 #define fx(i)  (list->old_x[(list->pkt_count - (i)) & 03])
 #define fy(i)  (list->old_y[(list->pkt_count - (i)) & 03])
 
@@ -582,8 +588,3 @@
 
 module_init(mousedev_init);
 module_exit(mousedev_exit);
-
-MODULE_PARM(xres, "i");
-MODULE_PARM_DESC(xres, "Horizontal screen resolution");
-MODULE_PARM(yres, "i");
-MODULE_PARM_DESC(yres, "Vertical screen resolution");
