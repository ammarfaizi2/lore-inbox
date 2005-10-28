Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965174AbVJ1GnB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965174AbVJ1GnB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 02:43:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965136AbVJ1GmL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 02:42:11 -0400
Received: from mail.kroah.org ([69.55.234.183]:24554 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S965123AbVJ1GbM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 02:31:12 -0400
Cc: gregkh@suse.de
Subject: [PATCH] Driver Core: fix up all callers of class_device_create()
In-Reply-To: <11304810232592@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 27 Oct 2005 23:30:23 -0700
Message-Id: <11304810231763@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] Driver Core: fix up all callers of class_device_create()

The previous patch adding the ability to nest struct class_device
changed the paramaters to the call class_device_create().  This patch
fixes up all in-kernel users of the function.

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit c5d4abda2b87357d5ba32b0c8babb532eb75d9c7
tree 0e91246ed9a9a2e8e057e553e6028afbc25bd336
parent a82c307b63c2e516090c702ed409cb89ef633a1c
author Greg Kroah-Hartman <gregkh@suse.de> Thu, 27 Oct 2005 22:25:43 -0700
committer Greg Kroah-Hartman <gregkh@suse.de> Thu, 27 Oct 2005 22:48:02 -0700

 arch/i386/kernel/cpuid.c                |    2 +-
 arch/i386/kernel/msr.c                  |    2 +-
 drivers/block/aoe/aoechr.c              |    2 +-
 drivers/block/paride/pg.c               |    2 +-
 drivers/block/paride/pt.c               |    4 ++--
 drivers/char/dsp56k.c                   |    2 +-
 drivers/char/ftape/zftape/zftape-init.c |   12 ++++++------
 drivers/char/ip2main.c                  |   10 ++++++----
 drivers/char/ipmi/ipmi_devintf.c        |    2 +-
 drivers/char/istallion.c                |    3 ++-
 drivers/char/lp.c                       |    2 +-
 drivers/char/mem.c                      |    3 ++-
 drivers/char/misc.c                     |    2 +-
 drivers/char/ppdev.c                    |    2 +-
 drivers/char/raw.c                      |    4 ++--
 drivers/char/snsc.c                     |    2 +-
 drivers/char/stallion.c                 |    4 +++-
 drivers/char/tipar.c                    |    2 +-
 drivers/char/tty_io.c                   |   10 +++++-----
 drivers/char/vc_screen.c                |   10 ++++++----
 drivers/char/viotape.c                  |    4 ++--
 drivers/hwmon/hwmon.c                   |    2 +-
 drivers/ide/ide-tape.c                  |    4 ++--
 drivers/ieee1394/dv1394.c               |    2 +-
 drivers/ieee1394/raw1394.c              |    2 +-
 drivers/ieee1394/video1394.c            |    2 +-
 drivers/infiniband/core/ucm.c           |    2 +-
 drivers/input/evdev.c                   |    2 +-
 drivers/input/joydev.c                  |    2 +-
 drivers/input/mousedev.c                |    4 ++--
 drivers/input/tsdev.c                   |    2 +-
 drivers/isdn/capi/capi.c                |    2 +-
 drivers/macintosh/adb.c                 |    2 +-
 drivers/media/dvb/dvb-core/dvbdev.c     |    2 +-
 drivers/message/i2o/iop.c               |    2 +-
 drivers/mtd/mtdchar.c                   |    4 ++--
 drivers/net/ppp_generic.c               |    2 +-
 drivers/net/wan/cosa.c                  |    2 +-
 drivers/s390/char/tape_class.c          |    1 +
 drivers/s390/char/vmlogrdr.c            |    1 +
 drivers/scsi/ch.c                       |    2 +-
 drivers/scsi/osst.c                     |    2 +-
 drivers/scsi/sg.c                       |    2 +-
 drivers/scsi/st.c                       |    2 +-
 drivers/usb/core/devio.c                |    2 +-
 drivers/usb/core/file.c                 |    4 +++-
 drivers/usb/core/hcd.c                  |    3 ++-
 drivers/video/fbmem.c                   |    2 +-
 fs/coda/psdev.c                         |    4 ++--
 sound/core/sound.c                      |    2 +-
 sound/oss/soundcard.c                   |    4 ++--
 sound/sound_core.c                      |    2 +-
 52 files changed, 86 insertions(+), 73 deletions(-)

diff --git a/arch/i386/kernel/cpuid.c b/arch/i386/kernel/cpuid.c
index 4647db4..13bae79 100644
--- a/arch/i386/kernel/cpuid.c
+++ b/arch/i386/kernel/cpuid.c
@@ -163,7 +163,7 @@ static int cpuid_class_device_create(int
 	int err = 0;
 	struct class_device *class_err;
 
-	class_err = class_device_create(cpuid_class, MKDEV(CPUID_MAJOR, i), NULL, "cpu%d",i);
+	class_err = class_device_create(cpuid_class, NULL, MKDEV(CPUID_MAJOR, i), NULL, "cpu%d",i);
 	if (IS_ERR(class_err))
 		err = PTR_ERR(class_err);
 	return err;
diff --git a/arch/i386/kernel/msr.c b/arch/i386/kernel/msr.c
index 03100d6..44470fe 100644
--- a/arch/i386/kernel/msr.c
+++ b/arch/i386/kernel/msr.c
@@ -246,7 +246,7 @@ static int msr_class_device_create(int i
 	int err = 0;
 	struct class_device *class_err;
 
-	class_err = class_device_create(msr_class, MKDEV(MSR_MAJOR, i), NULL, "msr%d",i);
+	class_err = class_device_create(msr_class, NULL, MKDEV(MSR_MAJOR, i), NULL, "msr%d",i);
 	if (IS_ERR(class_err)) 
 		err = PTR_ERR(class_err);
 	return err;
diff --git a/drivers/block/aoe/aoechr.c b/drivers/block/aoe/aoechr.c
index 45a2430..41ae0ed 100644
--- a/drivers/block/aoe/aoechr.c
+++ b/drivers/block/aoe/aoechr.c
@@ -224,7 +224,7 @@ aoechr_init(void)
 		return PTR_ERR(aoe_class);
 	}
 	for (i = 0; i < ARRAY_SIZE(chardevs); ++i)
-		class_device_create(aoe_class,
+		class_device_create(aoe_class, NULL,
 					MKDEV(AOE_MAJOR, chardevs[i].minor),
 					NULL, chardevs[i].name);
 
diff --git a/drivers/block/paride/pg.c b/drivers/block/paride/pg.c
index b398239..82f2d6d 100644
--- a/drivers/block/paride/pg.c
+++ b/drivers/block/paride/pg.c
@@ -674,7 +674,7 @@ static int __init pg_init(void)
 	for (unit = 0; unit < PG_UNITS; unit++) {
 		struct pg *dev = &devices[unit];
 		if (dev->present) {
-			class_device_create(pg_class, MKDEV(major, unit),
+			class_device_create(pg_class, NULL, MKDEV(major, unit),
 					NULL, "pg%u", unit);
 			err = devfs_mk_cdev(MKDEV(major, unit),
 				      S_IFCHR | S_IRUSR | S_IWUSR, "pg/%u",
diff --git a/drivers/block/paride/pt.c b/drivers/block/paride/pt.c
index d8d3523..686c955 100644
--- a/drivers/block/paride/pt.c
+++ b/drivers/block/paride/pt.c
@@ -971,7 +971,7 @@ static int __init pt_init(void)
 	devfs_mk_dir("pt");
 	for (unit = 0; unit < PT_UNITS; unit++)
 		if (pt[unit].present) {
-			class_device_create(pt_class, MKDEV(major, unit),
+			class_device_create(pt_class, NULL, MKDEV(major, unit),
 					NULL, "pt%d", unit);
 			err = devfs_mk_cdev(MKDEV(major, unit),
 				      S_IFCHR | S_IRUSR | S_IWUSR,
@@ -980,7 +980,7 @@ static int __init pt_init(void)
 				class_device_destroy(pt_class, MKDEV(major, unit));
 				goto out_class;
 			}
-			class_device_create(pt_class, MKDEV(major, unit + 128),
+			class_device_create(pt_class, NULL, MKDEV(major, unit + 128),
 					NULL, "pt%dn", unit);
 			err = devfs_mk_cdev(MKDEV(major, unit + 128),
 				      S_IFCHR | S_IRUSR | S_IWUSR,
diff --git a/drivers/char/dsp56k.c b/drivers/char/dsp56k.c
index 26271e3..8693835 100644
--- a/drivers/char/dsp56k.c
+++ b/drivers/char/dsp56k.c
@@ -515,7 +515,7 @@ static int __init dsp56k_init_driver(voi
 		err = PTR_ERR(dsp56k_class);
 		goto out_chrdev;
 	}
-	class_device_create(dsp56k_class, MKDEV(DSP56K_MAJOR, 0), NULL, "dsp56k");
+	class_device_create(dsp56k_class, NULL, MKDEV(DSP56K_MAJOR, 0), NULL, "dsp56k");
 
 	err = devfs_mk_cdev(MKDEV(DSP56K_MAJOR, 0),
 		      S_IFCHR | S_IRUSR | S_IWUSR, "dsp56k");
diff --git a/drivers/char/ftape/zftape/zftape-init.c b/drivers/char/ftape/zftape/zftape-init.c
index 5745b74..821357c 100644
--- a/drivers/char/ftape/zftape/zftape-init.c
+++ b/drivers/char/ftape/zftape/zftape-init.c
@@ -331,27 +331,27 @@ KERN_INFO
 
 	zft_class = class_create(THIS_MODULE, "zft");
 	for (i = 0; i < 4; i++) {
-		class_device_create(zft_class, MKDEV(QIC117_TAPE_MAJOR, i), NULL, "qft%i", i);
+		class_device_create(zft_class, NULL, MKDEV(QIC117_TAPE_MAJOR, i), NULL, "qft%i", i);
 		devfs_mk_cdev(MKDEV(QIC117_TAPE_MAJOR, i),
 				S_IFCHR | S_IRUSR | S_IWUSR,
 				"qft%i", i);
-		class_device_create(zft_class, MKDEV(QIC117_TAPE_MAJOR, i + 4), NULL, "nqft%i", i);
+		class_device_create(zft_class, NULL, MKDEV(QIC117_TAPE_MAJOR, i + 4), NULL, "nqft%i", i);
 		devfs_mk_cdev(MKDEV(QIC117_TAPE_MAJOR, i + 4),
 				S_IFCHR | S_IRUSR | S_IWUSR,
 				"nqft%i", i);
-		class_device_create(zft_class, MKDEV(QIC117_TAPE_MAJOR, i + 16), NULL, "zqft%i", i);
+		class_device_create(zft_class, NULL, MKDEV(QIC117_TAPE_MAJOR, i + 16), NULL, "zqft%i", i);
 		devfs_mk_cdev(MKDEV(QIC117_TAPE_MAJOR, i + 16),
 				S_IFCHR | S_IRUSR | S_IWUSR,
 				"zqft%i", i);
-		class_device_create(zft_class, MKDEV(QIC117_TAPE_MAJOR, i + 20), NULL, "nzqft%i", i);
+		class_device_create(zft_class, NULL, MKDEV(QIC117_TAPE_MAJOR, i + 20), NULL, "nzqft%i", i);
 		devfs_mk_cdev(MKDEV(QIC117_TAPE_MAJOR, i + 20),
 				S_IFCHR | S_IRUSR | S_IWUSR,
 				"nzqft%i", i);
-		class_device_create(zft_class, MKDEV(QIC117_TAPE_MAJOR, i + 32), NULL, "rawqft%i", i);
+		class_device_create(zft_class, NULL, MKDEV(QIC117_TAPE_MAJOR, i + 32), NULL, "rawqft%i", i);
 		devfs_mk_cdev(MKDEV(QIC117_TAPE_MAJOR, i + 32),
 				S_IFCHR | S_IRUSR | S_IWUSR,
 				"rawqft%i", i);
-		class_device_create(zft_class, MKDEV(QIC117_TAPE_MAJOR, i + 36), NULL, "nrawrawqft%i", i);
+		class_device_create(zft_class, NULL, MKDEV(QIC117_TAPE_MAJOR, i + 36), NULL, "nrawrawqft%i", i);
 		devfs_mk_cdev(MKDEV(QIC117_TAPE_MAJOR, i + 36),
 				S_IFCHR | S_IRUSR | S_IWUSR,
 				"nrawqft%i", i);
diff --git a/drivers/char/ip2main.c b/drivers/char/ip2main.c
index 9e4e26a..d815d19 100644
--- a/drivers/char/ip2main.c
+++ b/drivers/char/ip2main.c
@@ -721,8 +721,9 @@ ip2_loadmain(int *iop, int *irqp, unsign
 			}
 
 			if ( NULL != ( pB = i2BoardPtrTable[i] ) ) {
-				class_device_create(ip2_class, MKDEV(IP2_IPL_MAJOR,
-						4 * i), NULL, "ipl%d", i);
+				class_device_create(ip2_class, NULL,
+						MKDEV(IP2_IPL_MAJOR, 4 * i),
+						NULL, "ipl%d", i);
 				err = devfs_mk_cdev(MKDEV(IP2_IPL_MAJOR, 4 * i),
 						S_IRUSR | S_IWUSR | S_IRGRP | S_IFCHR,
 						"ip2/ipl%d", i);
@@ -732,8 +733,9 @@ ip2_loadmain(int *iop, int *irqp, unsign
 					goto out_class;
 				}
 
-				class_device_create(ip2_class, MKDEV(IP2_IPL_MAJOR,
-						4 * i + 1), NULL, "stat%d", i);
+				class_device_create(ip2_class, NULL,
+						MKDEV(IP2_IPL_MAJOR, 4 * i + 1),
+						NULL, "stat%d", i);
 				err = devfs_mk_cdev(MKDEV(IP2_IPL_MAJOR, 4 * i + 1),
 						S_IRUSR | S_IWUSR | S_IRGRP | S_IFCHR,
 						"ip2/stat%d", i);
diff --git a/drivers/char/ipmi/ipmi_devintf.c b/drivers/char/ipmi/ipmi_devintf.c
index a09ff10..7c0684d 100644
--- a/drivers/char/ipmi/ipmi_devintf.c
+++ b/drivers/char/ipmi/ipmi_devintf.c
@@ -798,7 +798,7 @@ static void ipmi_new_smi(int if_num)
 	devfs_mk_cdev(dev, S_IFCHR | S_IRUSR | S_IWUSR,
 		      "ipmidev/%d", if_num);
 
-	class_device_create(ipmi_class, dev, NULL, "ipmi%d", if_num);
+	class_device_create(ipmi_class, NULL, dev, NULL, "ipmi%d", if_num);
 }
 
 static void ipmi_smi_gone(int if_num)
diff --git a/drivers/char/istallion.c b/drivers/char/istallion.c
index 9c19e54..e3ddbdb 100644
--- a/drivers/char/istallion.c
+++ b/drivers/char/istallion.c
@@ -5246,7 +5246,8 @@ int __init stli_init(void)
 		devfs_mk_cdev(MKDEV(STL_SIOMEMMAJOR, i),
 			       S_IFCHR | S_IRUSR | S_IWUSR,
 			       "staliomem/%d", i);
-		class_device_create(istallion_class, MKDEV(STL_SIOMEMMAJOR, i),
+		class_device_create(istallion_class, NULL,
+				MKDEV(STL_SIOMEMMAJOR, i),
 				NULL, "staliomem%d", i);
 	}
 
diff --git a/drivers/char/lp.c b/drivers/char/lp.c
index 2afb903..e572605 100644
--- a/drivers/char/lp.c
+++ b/drivers/char/lp.c
@@ -805,7 +805,7 @@ static int lp_register(int nr, struct pa
 	if (reset)
 		lp_reset(nr);
 
-	class_device_create(lp_class, MKDEV(LP_MAJOR, nr), NULL,
+	class_device_create(lp_class, NULL, MKDEV(LP_MAJOR, nr), NULL,
 				"lp%d", nr);
 	devfs_mk_cdev(MKDEV(LP_MAJOR, nr), S_IFCHR | S_IRUGO | S_IWUGO,
 			"printers/%d", nr);
diff --git a/drivers/char/mem.c b/drivers/char/mem.c
index f182752..38be4b0 100644
--- a/drivers/char/mem.c
+++ b/drivers/char/mem.c
@@ -920,7 +920,8 @@ static int __init chr_dev_init(void)
 
 	mem_class = class_create(THIS_MODULE, "mem");
 	for (i = 0; i < ARRAY_SIZE(devlist); i++) {
-		class_device_create(mem_class, MKDEV(MEM_MAJOR, devlist[i].minor),
+		class_device_create(mem_class, NULL,
+					MKDEV(MEM_MAJOR, devlist[i].minor),
 					NULL, devlist[i].name);
 		devfs_mk_cdev(MKDEV(MEM_MAJOR, devlist[i].minor),
 				S_IFCHR | devlist[i].mode, devlist[i].name);
diff --git a/drivers/char/misc.c b/drivers/char/misc.c
index 0c83751..3e4c041 100644
--- a/drivers/char/misc.c
+++ b/drivers/char/misc.c
@@ -234,7 +234,7 @@ int misc_register(struct miscdevice * mi
 	}
 	dev = MKDEV(MISC_MAJOR, misc->minor);
 
-	misc->class = class_device_create(misc_class, dev, misc->dev,
+	misc->class = class_device_create(misc_class, NULL, dev, misc->dev,
 					  "%s", misc->name);
 	if (IS_ERR(misc->class)) {
 		err = PTR_ERR(misc->class);
diff --git a/drivers/char/ppdev.c b/drivers/char/ppdev.c
index 0e22880..306ee0f 100644
--- a/drivers/char/ppdev.c
+++ b/drivers/char/ppdev.c
@@ -752,7 +752,7 @@ static struct file_operations pp_fops = 
 
 static void pp_attach(struct parport *port)
 {
-	class_device_create(ppdev_class, MKDEV(PP_MAJOR, port->number),
+	class_device_create(ppdev_class, NULL, MKDEV(PP_MAJOR, port->number),
 			NULL, "parport%d", port->number);
 }
 
diff --git a/drivers/char/raw.c b/drivers/char/raw.c
index f13e5de..30e4cbe 100644
--- a/drivers/char/raw.c
+++ b/drivers/char/raw.c
@@ -128,7 +128,7 @@ raw_ioctl(struct inode *inode, struct fi
 static void bind_device(struct raw_config_request *rq)
 {
 	class_device_destroy(raw_class, MKDEV(RAW_MAJOR, rq->raw_minor));
-	class_device_create(raw_class, MKDEV(RAW_MAJOR, rq->raw_minor),
+	class_device_create(raw_class, NULL, MKDEV(RAW_MAJOR, rq->raw_minor),
 				      NULL, "raw%d", rq->raw_minor);
 }
 
@@ -307,7 +307,7 @@ static int __init raw_init(void)
 		unregister_chrdev_region(dev, MAX_RAW_MINORS);
 		goto error;
 	}
-	class_device_create(raw_class, MKDEV(RAW_MAJOR, 0), NULL, "rawctl");
+	class_device_create(raw_class, NULL, MKDEV(RAW_MAJOR, 0), NULL, "rawctl");
 
 	devfs_mk_cdev(MKDEV(RAW_MAJOR, 0),
 		      S_IFCHR | S_IRUGO | S_IWUGO,
diff --git a/drivers/char/snsc.c b/drivers/char/snsc.c
index 261a41b..1758a83 100644
--- a/drivers/char/snsc.c
+++ b/drivers/char/snsc.c
@@ -437,7 +437,7 @@ scdrv_init(void)
 				continue;
 			}
 
-			class_device_create(snsc_class, dev, NULL,
+			class_device_create(snsc_class, NULL, dev, NULL,
 						"%s", devname);
 
 			ia64_sn_irtr_intr_enable(scd->scd_nasid,
diff --git a/drivers/char/stallion.c b/drivers/char/stallion.c
index 951545a..1c68641 100644
--- a/drivers/char/stallion.c
+++ b/drivers/char/stallion.c
@@ -3095,7 +3095,9 @@ static int __init stl_init(void)
 		devfs_mk_cdev(MKDEV(STL_SIOMEMMAJOR, i),
 				S_IFCHR|S_IRUSR|S_IWUSR,
 				"staliomem/%d", i);
-		class_device_create(stallion_class, MKDEV(STL_SIOMEMMAJOR, i), NULL, "staliomem%d", i);
+		class_device_create(stallion_class, NULL,
+				    MKDEV(STL_SIOMEMMAJOR, i), NULL,
+				    "staliomem%d", i);
 	}
 
 	stl_serial->owner = THIS_MODULE;
diff --git a/drivers/char/tipar.c b/drivers/char/tipar.c
index ec78d2f..41a94bc 100644
--- a/drivers/char/tipar.c
+++ b/drivers/char/tipar.c
@@ -436,7 +436,7 @@ tipar_register(int nr, struct parport *p
 		goto out;
 	}
 
-	class_device_create(tipar_class, MKDEV(TIPAR_MAJOR,
+	class_device_create(tipar_class, NULL, MKDEV(TIPAR_MAJOR,
 			TIPAR_MINOR + nr), NULL, "par%d", nr);
 	/* Use devfs, tree: /dev/ticables/par/[0..2] */
 	err = devfs_mk_cdev(MKDEV(TIPAR_MAJOR, TIPAR_MINOR + nr),
diff --git a/drivers/char/tty_io.c b/drivers/char/tty_io.c
index e5953f3..f5649a3 100644
--- a/drivers/char/tty_io.c
+++ b/drivers/char/tty_io.c
@@ -2728,7 +2728,7 @@ void tty_register_device(struct tty_driv
 		pty_line_name(driver, index, name);
 	else
 		tty_line_name(driver, index, name);
-	class_device_create(tty_class, dev, device, name);
+	class_device_create(tty_class, NULL, dev, device, "%s", name);
 }
 
 /**
@@ -2983,14 +2983,14 @@ static int __init tty_init(void)
 	    register_chrdev_region(MKDEV(TTYAUX_MAJOR, 0), 1, "/dev/tty") < 0)
 		panic("Couldn't register /dev/tty driver\n");
 	devfs_mk_cdev(MKDEV(TTYAUX_MAJOR, 0), S_IFCHR|S_IRUGO|S_IWUGO, "tty");
-	class_device_create(tty_class, MKDEV(TTYAUX_MAJOR, 0), NULL, "tty");
+	class_device_create(tty_class, NULL, MKDEV(TTYAUX_MAJOR, 0), NULL, "tty");
 
 	cdev_init(&console_cdev, &console_fops);
 	if (cdev_add(&console_cdev, MKDEV(TTYAUX_MAJOR, 1), 1) ||
 	    register_chrdev_region(MKDEV(TTYAUX_MAJOR, 1), 1, "/dev/console") < 0)
 		panic("Couldn't register /dev/console driver\n");
 	devfs_mk_cdev(MKDEV(TTYAUX_MAJOR, 1), S_IFCHR|S_IRUSR|S_IWUSR, "console");
-	class_device_create(tty_class, MKDEV(TTYAUX_MAJOR, 1), NULL, "console");
+	class_device_create(tty_class, NULL, MKDEV(TTYAUX_MAJOR, 1), NULL, "console");
 
 #ifdef CONFIG_UNIX98_PTYS
 	cdev_init(&ptmx_cdev, &ptmx_fops);
@@ -2998,7 +2998,7 @@ static int __init tty_init(void)
 	    register_chrdev_region(MKDEV(TTYAUX_MAJOR, 2), 1, "/dev/ptmx") < 0)
 		panic("Couldn't register /dev/ptmx driver\n");
 	devfs_mk_cdev(MKDEV(TTYAUX_MAJOR, 2), S_IFCHR|S_IRUGO|S_IWUGO, "ptmx");
-	class_device_create(tty_class, MKDEV(TTYAUX_MAJOR, 2), NULL, "ptmx");
+	class_device_create(tty_class, NULL, MKDEV(TTYAUX_MAJOR, 2), NULL, "ptmx");
 #endif
 
 #ifdef CONFIG_VT
@@ -3007,7 +3007,7 @@ static int __init tty_init(void)
 	    register_chrdev_region(MKDEV(TTY_MAJOR, 0), 1, "/dev/vc/0") < 0)
 		panic("Couldn't register /dev/tty0 driver\n");
 	devfs_mk_cdev(MKDEV(TTY_MAJOR, 0), S_IFCHR|S_IRUSR|S_IWUSR, "vc/0");
-	class_device_create(tty_class, MKDEV(TTY_MAJOR, 0), NULL, "tty0");
+	class_device_create(tty_class, NULL, MKDEV(TTY_MAJOR, 0), NULL, "tty0");
 
 	vty_init();
 #endif
diff --git a/drivers/char/vc_screen.c b/drivers/char/vc_screen.c
index 79c2928..f66c7ad 100644
--- a/drivers/char/vc_screen.c
+++ b/drivers/char/vc_screen.c
@@ -484,8 +484,10 @@ void vcs_make_devfs(struct tty_struct *t
 	devfs_mk_cdev(MKDEV(VCS_MAJOR, tty->index + 129),
 			S_IFCHR|S_IRUSR|S_IWUSR,
 			"vcc/a%u", tty->index + 1);
-	class_device_create(vc_class, MKDEV(VCS_MAJOR, tty->index + 1), NULL, "vcs%u", tty->index + 1);
-	class_device_create(vc_class, MKDEV(VCS_MAJOR, tty->index + 129), NULL, "vcsa%u", tty->index + 1);
+	class_device_create(vc_class, NULL, MKDEV(VCS_MAJOR, tty->index + 1),
+			NULL, "vcs%u", tty->index + 1);
+	class_device_create(vc_class, NULL, MKDEV(VCS_MAJOR, tty->index + 129),
+			NULL, "vcsa%u", tty->index + 1);
 }
 void vcs_remove_devfs(struct tty_struct *tty)
 {
@@ -503,7 +505,7 @@ int __init vcs_init(void)
 
 	devfs_mk_cdev(MKDEV(VCS_MAJOR, 0), S_IFCHR|S_IRUSR|S_IWUSR, "vcc/0");
 	devfs_mk_cdev(MKDEV(VCS_MAJOR, 128), S_IFCHR|S_IRUSR|S_IWUSR, "vcc/a0");
-	class_device_create(vc_class, MKDEV(VCS_MAJOR, 0), NULL, "vcs");
-	class_device_create(vc_class, MKDEV(VCS_MAJOR, 128), NULL, "vcsa");
+	class_device_create(vc_class, NULL, MKDEV(VCS_MAJOR, 0), NULL, "vcs");
+	class_device_create(vc_class, NULL, MKDEV(VCS_MAJOR, 128), NULL, "vcsa");
 	return 0;
 }
diff --git a/drivers/char/viotape.c b/drivers/char/viotape.c
index 0aff45f..a5e104f 100644
--- a/drivers/char/viotape.c
+++ b/drivers/char/viotape.c
@@ -956,9 +956,9 @@ static int viotape_probe(struct vio_dev 
 	state[i].cur_part = 0;
 	for (j = 0; j < MAX_PARTITIONS; ++j)
 		state[i].part_stat_rwi[j] = VIOT_IDLE;
-	class_device_create(tape_class, MKDEV(VIOTAPE_MAJOR, i), NULL,
+	class_device_create(tape_class, NULL, MKDEV(VIOTAPE_MAJOR, i), NULL,
 			"iseries!vt%d", i);
-	class_device_create(tape_class, MKDEV(VIOTAPE_MAJOR, i | 0x80),
+	class_device_create(tape_class, NULL, MKDEV(VIOTAPE_MAJOR, i | 0x80),
 			NULL, "iseries!nvt%d", i);
 	devfs_mk_cdev(MKDEV(VIOTAPE_MAJOR, i), S_IFCHR | S_IRUSR | S_IWUSR,
 			"iseries/vt%d", i);
diff --git a/drivers/hwmon/hwmon.c b/drivers/hwmon/hwmon.c
index 9b41c9b..6f48579 100644
--- a/drivers/hwmon/hwmon.c
+++ b/drivers/hwmon/hwmon.c
@@ -45,7 +45,7 @@ struct class_device *hwmon_device_regist
 		return ERR_PTR(-ENOMEM);
 
 	id = id & MAX_ID_MASK;
-	cdev = class_device_create(hwmon_class, MKDEV(0,0), dev,
+	cdev = class_device_create(hwmon_class, NULL, MKDEV(0,0), dev,
 					HWMON_ID_FORMAT, id);
 
 	if (IS_ERR(cdev))
diff --git a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
index 95abe98..47f2b83 100644
--- a/drivers/ide/ide-tape.c
+++ b/drivers/ide/ide-tape.c
@@ -4884,9 +4884,9 @@ static int ide_tape_probe(struct device 
 
 	idetape_setup(drive, tape, minor);
 
-	class_device_create(idetape_sysfs_class,
+	class_device_create(idetape_sysfs_class, NULL,
 			MKDEV(IDETAPE_MAJOR, minor), dev, "%s", tape->name);
-	class_device_create(idetape_sysfs_class,
+	class_device_create(idetape_sysfs_class, NULL,
 			MKDEV(IDETAPE_MAJOR, minor + 128), dev, "n%s", tape->name);
 
 	devfs_mk_cdev(MKDEV(HWIF(drive)->major, minor),
diff --git a/drivers/ieee1394/dv1394.c b/drivers/ieee1394/dv1394.c
index e34730c..cbbbe14 100644
--- a/drivers/ieee1394/dv1394.c
+++ b/drivers/ieee1394/dv1394.c
@@ -2361,7 +2361,7 @@ static void dv1394_add_host (struct hpsb
 
 	ohci = (struct ti_ohci *)host->hostdata;
 
-	class_device_create(hpsb_protocol_class, MKDEV(
+	class_device_create(hpsb_protocol_class, NULL, MKDEV(
 		IEEE1394_MAJOR,	IEEE1394_MINOR_BLOCK_DV1394 * 16 + (id<<2)), 
 		NULL, "dv1394-%d", id);
 	devfs_mk_dir("ieee1394/dv/host%d", id);
diff --git a/drivers/ieee1394/raw1394.c b/drivers/ieee1394/raw1394.c
index 0470f77..24411e6 100644
--- a/drivers/ieee1394/raw1394.c
+++ b/drivers/ieee1394/raw1394.c
@@ -2912,7 +2912,7 @@ static int __init init_raw1394(void)
 
 	hpsb_register_highlevel(&raw1394_highlevel);
 
-	if (IS_ERR(class_device_create(hpsb_protocol_class, MKDEV(
+	if (IS_ERR(class_device_create(hpsb_protocol_class, NULL, MKDEV(
 		IEEE1394_MAJOR,	IEEE1394_MINOR_BLOCK_RAW1394 * 16), 
 		NULL, RAW1394_DEVICE_NAME))) {
 		ret = -EFAULT;
diff --git a/drivers/ieee1394/video1394.c b/drivers/ieee1394/video1394.c
index 11be9c9..23911da 100644
--- a/drivers/ieee1394/video1394.c
+++ b/drivers/ieee1394/video1394.c
@@ -1370,7 +1370,7 @@ static void video1394_add_host (struct h
 	hpsb_set_hostinfo_key(&video1394_highlevel, host, ohci->host->id);
 
 	minor = IEEE1394_MINOR_BLOCK_VIDEO1394 * 16 + ohci->host->id;
-	class_device_create(hpsb_protocol_class, MKDEV(
+	class_device_create(hpsb_protocol_class, NULL, MKDEV(
 		IEEE1394_MAJOR,	minor), 
 		NULL, "%s-%d", VIDEO1394_DRIVER_NAME, ohci->host->id);
 	devfs_mk_cdev(MKDEV(IEEE1394_MAJOR, minor),
diff --git a/drivers/infiniband/core/ucm.c b/drivers/infiniband/core/ucm.c
index d0f0b0a..021b8f1 100644
--- a/drivers/infiniband/core/ucm.c
+++ b/drivers/infiniband/core/ucm.c
@@ -1300,7 +1300,7 @@ static int __init ib_ucm_init(void)
 		goto err_class;
 	}
 
-	class_device_create(ib_ucm_class, IB_UCM_DEV, NULL, "ucm");
+	class_device_create(ib_ucm_class, NULL, IB_UCM_DEV, NULL, "ucm");
 
 	idr_init(&ctx_id_table);
 	init_MUTEX(&ctx_id_mutex);
diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
index 3738d17..83b694c 100644
--- a/drivers/input/evdev.c
+++ b/drivers/input/evdev.c
@@ -689,7 +689,7 @@ static struct input_handle *evdev_connec
 
 	devfs_mk_cdev(MKDEV(INPUT_MAJOR, EVDEV_MINOR_BASE + minor),
 			S_IFCHR|S_IRUGO|S_IWUSR, "input/event%d", minor);
-	class_device_create(input_class,
+	class_device_create(input_class, NULL,
 			MKDEV(INPUT_MAJOR, EVDEV_MINOR_BASE + minor),
 			dev->dev, "event%d", minor);
 
diff --git a/drivers/input/joydev.c b/drivers/input/joydev.c
index e0938d1..c696fb2 100644
--- a/drivers/input/joydev.c
+++ b/drivers/input/joydev.c
@@ -516,7 +516,7 @@ static struct input_handle *joydev_conne
 
 	devfs_mk_cdev(MKDEV(INPUT_MAJOR, JOYDEV_MINOR_BASE + minor),
 			S_IFCHR|S_IRUGO|S_IWUSR, "input/js%d", minor);
-	class_device_create(input_class,
+	class_device_create(input_class, NULL,
 			MKDEV(INPUT_MAJOR, JOYDEV_MINOR_BASE + minor),
 			dev->dev, "js%d", minor);
 
diff --git a/drivers/input/mousedev.c b/drivers/input/mousedev.c
index c6194a9..d7144e1 100644
--- a/drivers/input/mousedev.c
+++ b/drivers/input/mousedev.c
@@ -651,7 +651,7 @@ static struct input_handle *mousedev_con
 
 	devfs_mk_cdev(MKDEV(INPUT_MAJOR, MOUSEDEV_MINOR_BASE + minor),
 			S_IFCHR|S_IRUGO|S_IWUSR, "input/mouse%d", minor);
-	class_device_create(input_class,
+	class_device_create(input_class, NULL,
 			MKDEV(INPUT_MAJOR, MOUSEDEV_MINOR_BASE + minor),
 			dev->dev, "mouse%d", minor);
 
@@ -740,7 +740,7 @@ static int __init mousedev_init(void)
 
 	devfs_mk_cdev(MKDEV(INPUT_MAJOR, MOUSEDEV_MINOR_BASE + MOUSEDEV_MIX),
 			S_IFCHR|S_IRUGO|S_IWUSR, "input/mice");
-	class_device_create(input_class,
+	class_device_create(input_class, NULL,
 			MKDEV(INPUT_MAJOR, MOUSEDEV_MINOR_BASE + MOUSEDEV_MIX), NULL, "mice");
 
 #ifdef CONFIG_INPUT_MOUSEDEV_PSAUX
diff --git a/drivers/input/tsdev.c b/drivers/input/tsdev.c
index 50c63a1..fbb35c9 100644
--- a/drivers/input/tsdev.c
+++ b/drivers/input/tsdev.c
@@ -414,7 +414,7 @@ static struct input_handle *tsdev_connec
 			S_IFCHR|S_IRUGO|S_IWUSR, "input/ts%d", minor);
 	devfs_mk_cdev(MKDEV(INPUT_MAJOR, TSDEV_MINOR_BASE + minor + TSDEV_MINORS/2),
 			S_IFCHR|S_IRUGO|S_IWUSR, "input/tsraw%d", minor);
-	class_device_create(input_class,
+	class_device_create(input_class, NULL,
 			MKDEV(INPUT_MAJOR, TSDEV_MINOR_BASE + minor),
 			dev->dev, "ts%d", minor);
 
diff --git a/drivers/isdn/capi/capi.c b/drivers/isdn/capi/capi.c
index 04fb606..11ae0fd 100644
--- a/drivers/isdn/capi/capi.c
+++ b/drivers/isdn/capi/capi.c
@@ -1505,7 +1505,7 @@ static int __init capi_init(void)
 		return PTR_ERR(capi_class);
 	}
 
-	class_device_create(capi_class, MKDEV(capi_major, 0), NULL, "capi");
+	class_device_create(capi_class, NULL, MKDEV(capi_major, 0), NULL, "capi");
 	devfs_mk_cdev(MKDEV(capi_major, 0), S_IFCHR | S_IRUSR | S_IWUSR,
 			"isdn/capi20");
 
diff --git a/drivers/macintosh/adb.c b/drivers/macintosh/adb.c
index c0dc1e3..d2ead17 100644
--- a/drivers/macintosh/adb.c
+++ b/drivers/macintosh/adb.c
@@ -905,5 +905,5 @@ adbdev_init(void)
 	adb_dev_class = class_create(THIS_MODULE, "adb");
 	if (IS_ERR(adb_dev_class))
 		return;
-	class_device_create(adb_dev_class, MKDEV(ADB_MAJOR, 0), NULL, "adb");
+	class_device_create(adb_dev_class, NULL, MKDEV(ADB_MAJOR, 0), NULL, "adb");
 }
diff --git a/drivers/media/dvb/dvb-core/dvbdev.c b/drivers/media/dvb/dvb-core/dvbdev.c
index 4b7adca..477b4fa 100644
--- a/drivers/media/dvb/dvb-core/dvbdev.c
+++ b/drivers/media/dvb/dvb-core/dvbdev.c
@@ -235,7 +235,7 @@ int dvb_register_device(struct dvb_adapt
 			S_IFCHR | S_IRUSR | S_IWUSR,
 			"dvb/adapter%d/%s%d", adap->num, dnames[type], id);
 
-	class_device_create(dvb_class, MKDEV(DVB_MAJOR, nums2minor(adap->num, type, id)),
+	class_device_create(dvb_class, NULL, MKDEV(DVB_MAJOR, nums2minor(adap->num, type, id)),
 			    NULL, "dvb%d.%s%d", adap->num, dnames[type], id);
 
 	dprintk("DVB: register adapter%d/%s%d @ minor: %i (0x%02x)\n",
diff --git a/drivers/message/i2o/iop.c b/drivers/message/i2o/iop.c
index 176fb57..361da8d 100644
--- a/drivers/message/i2o/iop.c
+++ b/drivers/message/i2o/iop.c
@@ -1141,7 +1141,7 @@ int i2o_iop_add(struct i2o_controller *c
 		goto iop_reset;
 	}
 
-	c->classdev = class_device_create(i2o_controller_class, 0,
+	c->classdev = class_device_create(i2o_controller_class, NULL, MKDEV(0,0),
 			&c->device, "iop%d", c->unit);
 	if (IS_ERR(c->classdev)) {
 		osm_err("%s: could not add controller class\n", c->name);
diff --git a/drivers/mtd/mtdchar.c b/drivers/mtd/mtdchar.c
index 1ed602a..c534fd5 100644
--- a/drivers/mtd/mtdchar.c
+++ b/drivers/mtd/mtdchar.c
@@ -24,10 +24,10 @@ static void mtd_notify_add(struct mtd_in
 	if (!mtd)
 		return;
 
-	class_device_create(mtd_class, MKDEV(MTD_CHAR_MAJOR, mtd->index*2),
+	class_device_create(mtd_class, NULL, MKDEV(MTD_CHAR_MAJOR, mtd->index*2),
 			    NULL, "mtd%d", mtd->index);
 	
-	class_device_create(mtd_class, 
+	class_device_create(mtd_class, NULL,
 			    MKDEV(MTD_CHAR_MAJOR, mtd->index*2+1),
 			    NULL, "mtd%dro", mtd->index);
 }
diff --git a/drivers/net/ppp_generic.c b/drivers/net/ppp_generic.c
index 0df7e92..d3c9958 100644
--- a/drivers/net/ppp_generic.c
+++ b/drivers/net/ppp_generic.c
@@ -863,7 +863,7 @@ static int __init ppp_init(void)
 			err = PTR_ERR(ppp_class);
 			goto out_chrdev;
 		}
-		class_device_create(ppp_class, MKDEV(PPP_MAJOR, 0), NULL, "ppp");
+		class_device_create(ppp_class, NULL, MKDEV(PPP_MAJOR, 0), NULL, "ppp");
 		err = devfs_mk_cdev(MKDEV(PPP_MAJOR, 0),
 				S_IFCHR|S_IRUSR|S_IWUSR, "ppp");
 		if (err)
diff --git a/drivers/net/wan/cosa.c b/drivers/net/wan/cosa.c
index 7ff814f..ace68e5 100644
--- a/drivers/net/wan/cosa.c
+++ b/drivers/net/wan/cosa.c
@@ -400,7 +400,7 @@ static int __init cosa_init(void)
 		goto out_chrdev;
 	}
 	for (i=0; i<nr_cards; i++) {
-		class_device_create(cosa_class, MKDEV(cosa_major, i),
+		class_device_create(cosa_class, NULL, MKDEV(cosa_major, i),
 				NULL, "cosa%d", i);
 		err = devfs_mk_cdev(MKDEV(cosa_major, i),
 				S_IFCHR|S_IRUSR|S_IWUSR,
diff --git a/drivers/s390/char/tape_class.c b/drivers/s390/char/tape_class.c
index ed0cb1f..fcaee44 100644
--- a/drivers/s390/char/tape_class.c
+++ b/drivers/s390/char/tape_class.c
@@ -72,6 +72,7 @@ struct tape_class_device *register_tape_
 
 	tcd->class_device = class_device_create(
 				tape_class,
+				NULL,
 				tcd->char_device->dev,
 				device,
 				"%s", tcd->device_name
diff --git a/drivers/s390/char/vmlogrdr.c b/drivers/s390/char/vmlogrdr.c
index 491f00c..a107fec 100644
--- a/drivers/s390/char/vmlogrdr.c
+++ b/drivers/s390/char/vmlogrdr.c
@@ -787,6 +787,7 @@ vmlogrdr_register_device(struct vmlogrdr
 		return ret;
 	}
 	priv->class_device = class_device_create(
+				NULL,
 				vmlogrdr_class,
 				MKDEV(vmlogrdr_major, priv->minor_num),
 				dev,
diff --git a/drivers/scsi/ch.c b/drivers/scsi/ch.c
index da6e51c..540147c 100644
--- a/drivers/scsi/ch.c
+++ b/drivers/scsi/ch.c
@@ -936,7 +936,7 @@ static int ch_probe(struct device *dev)
 	if (init)
 		ch_init_elem(ch);
 
-	class_device_create(ch_sysfs_class,
+	class_device_create(ch_sysfs_class, NULL,
 			    MKDEV(SCSI_CHANGER_MAJOR,ch->minor),
 			    dev, "s%s", ch->name);
 
diff --git a/drivers/scsi/osst.c b/drivers/scsi/osst.c
index 3f2f246..0bb60de 100644
--- a/drivers/scsi/osst.c
+++ b/drivers/scsi/osst.c
@@ -5627,7 +5627,7 @@ static void osst_sysfs_add(dev_t dev, st
 
 	if (!osst_sysfs_valid) return;
 
-	osst_class_member = class_device_create(osst_sysfs_class, dev, device, "%s", name);
+	osst_class_member = class_device_create(osst_sysfs_class, NULL, dev, device, "%s", name);
 	if (IS_ERR(osst_class_member)) {
 		printk(KERN_WARNING "osst :W: Unable to add sysfs class member %s\n", name);
 		return;
diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
index f0d8b4e..40886e1 100644
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -1550,7 +1550,7 @@ sg_add(struct class_device *cl_dev, stru
 	if (sg_sysfs_valid) {
 		struct class_device * sg_class_member;
 
-		sg_class_member = class_device_create(sg_sysfs_class,
+		sg_class_member = class_device_create(sg_sysfs_class, NULL,
 				MKDEV(SCSI_GENERIC_MAJOR, k), 
 				cl_dev->dev, "%s", 
 				disk->disk_name);
diff --git a/drivers/scsi/st.c b/drivers/scsi/st.c
index d001c04..d45ba48 100644
--- a/drivers/scsi/st.c
+++ b/drivers/scsi/st.c
@@ -4375,7 +4375,7 @@ static void do_create_class_files(struct
 		snprintf(name, 10, "%s%s%s", rew ? "n" : "",
 			 STp->disk->disk_name, st_formats[i]);
 		st_class_member =
-			class_device_create(st_sysfs_class,
+			class_device_create(st_sysfs_class, NULL,
 					    MKDEV(SCSI_TAPE_MAJOR,
 						  TAPE_MINOR(dev_num, mode, rew)),
 					    &STp->device->sdev_gendev, "%s", name);
diff --git a/drivers/usb/core/devio.c b/drivers/usb/core/devio.c
index 487ff67..befe0c7 100644
--- a/drivers/usb/core/devio.c
+++ b/drivers/usb/core/devio.c
@@ -1509,7 +1509,7 @@ void usbdev_add(struct usb_device *dev)
 {
 	int minor = ((dev->bus->busnum-1) * 128) + (dev->devnum-1);
 
-	dev->class_dev = class_device_create(usb_device_class,
+	dev->class_dev = class_device_create(usb_device_class, NULL,
 				MKDEV(USB_DEVICE_MAJOR, minor), &dev->dev,
 				"usbdev%d.%d", dev->bus->busnum, dev->devnum);
 
diff --git a/drivers/usb/core/file.c b/drivers/usb/core/file.c
index 65ca131..78cb4be 100644
--- a/drivers/usb/core/file.c
+++ b/drivers/usb/core/file.c
@@ -172,7 +172,9 @@ int usb_register_dev(struct usb_interfac
 		++temp;
 	else
 		temp = name;
-	intf->class_dev = class_device_create(usb_class, MKDEV(USB_MAJOR, minor), &intf->dev, "%s", temp);
+	intf->class_dev = class_device_create(usb_class, NULL,
+					      MKDEV(USB_MAJOR, minor),
+					      &intf->dev, "%s", temp);
 	if (IS_ERR(intf->class_dev)) {
 		spin_lock (&minor_lock);
 		usb_minors[intf->minor] = NULL;
diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
index 1017a97..c3eb66f 100644
--- a/drivers/usb/core/hcd.c
+++ b/drivers/usb/core/hcd.c
@@ -782,7 +782,8 @@ static int usb_register_bus(struct usb_b
 		return -E2BIG;
 	}
 
-	bus->class_dev = class_device_create(usb_host_class, MKDEV(0,0), bus->controller, "usb_host%d", busnum);
+	bus->class_dev = class_device_create(usb_host_class, NULL, MKDEV(0,0),
+					     bus->controller, "usb_host%d", busnum);
 	if (IS_ERR(bus->class_dev)) {
 		clear_bit(busnum, busmap.busmap);
 		up(&usb_bus_list_lock);
diff --git a/drivers/video/fbmem.c b/drivers/video/fbmem.c
index 70be700..9073be4 100644
--- a/drivers/video/fbmem.c
+++ b/drivers/video/fbmem.c
@@ -1031,7 +1031,7 @@ register_framebuffer(struct fb_info *fb_
 			break;
 	fb_info->node = i;
 
-	fb_info->class_device = class_device_create(fb_class, MKDEV(FB_MAJOR, i),
+	fb_info->class_device = class_device_create(fb_class, NULL, MKDEV(FB_MAJOR, i),
 				    fb_info->device, "fb%d", i);
 	if (IS_ERR(fb_info->class_device)) {
 		/* Not fatal */
diff --git a/fs/coda/psdev.c b/fs/coda/psdev.c
index 3d1cce3..6a3df88 100644
--- a/fs/coda/psdev.c
+++ b/fs/coda/psdev.c
@@ -370,8 +370,8 @@ static int init_coda_psdev(void)
 	}		
 	devfs_mk_dir ("coda");
 	for (i = 0; i < MAX_CODADEVS; i++) {
-		class_device_create(coda_psdev_class, MKDEV(CODA_PSDEV_MAJOR,i),
-				NULL, "cfs%d", i);
+		class_device_create(coda_psdev_class, NULL,
+				MKDEV(CODA_PSDEV_MAJOR,i), NULL, "cfs%d", i);
 		err = devfs_mk_cdev(MKDEV(CODA_PSDEV_MAJOR, i),
 				S_IFCHR|S_IRUSR|S_IWUSR, "coda/%d", i);
 		if (err)
diff --git a/sound/core/sound.c b/sound/core/sound.c
index 9e76bdd..b57519a 100644
--- a/sound/core/sound.c
+++ b/sound/core/sound.c
@@ -231,7 +231,7 @@ int snd_register_device(int type, snd_ca
 		devfs_mk_cdev(MKDEV(major, minor), S_IFCHR | device_mode, "snd/%s", name);
 	if (card)
 		device = card->dev;
-	class_device_create(sound_class, MKDEV(major, minor), device, "%s", name);
+	class_device_create(sound_class, NULL, MKDEV(major, minor), device, "%s", name);
 
 	up(&sound_mutex);
 	return 0;
diff --git a/sound/oss/soundcard.c b/sound/oss/soundcard.c
index 95fa81e..d33bb46 100644
--- a/sound/oss/soundcard.c
+++ b/sound/oss/soundcard.c
@@ -567,7 +567,7 @@ static int __init oss_init(void)
 		devfs_mk_cdev(MKDEV(SOUND_MAJOR, dev_list[i].minor),
 				S_IFCHR | dev_list[i].mode,
 				"sound/%s", dev_list[i].name);
-		class_device_create(sound_class,
+		class_device_create(sound_class, NULL,
 				    MKDEV(SOUND_MAJOR, dev_list[i].minor),
 				    NULL, "%s", dev_list[i].name);
 
@@ -579,7 +579,7 @@ static int __init oss_init(void)
 						dev_list[i].minor + (j*0x10)),
 					S_IFCHR | dev_list[i].mode,
 					"sound/%s%d", dev_list[i].name, j);
-			class_device_create(sound_class,
+			class_device_create(sound_class, NULL,
 					    MKDEV(SOUND_MAJOR, dev_list[i].minor + (j*0x10)),
 					    NULL, "%s%d", dev_list[i].name, j);
 		}
diff --git a/sound/sound_core.c b/sound/sound_core.c
index 954f994..394b53e 100644
--- a/sound/sound_core.c
+++ b/sound/sound_core.c
@@ -174,7 +174,7 @@ static int sound_insert_unit(struct soun
 
 	devfs_mk_cdev(MKDEV(SOUND_MAJOR, s->unit_minor),
 			S_IFCHR | mode, s->name);
-	class_device_create(sound_class, MKDEV(SOUND_MAJOR, s->unit_minor),
+	class_device_create(sound_class, NULL, MKDEV(SOUND_MAJOR, s->unit_minor),
 			    dev, s->name+6);
 	return r;
 

