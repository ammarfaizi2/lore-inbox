Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318814AbSG0UHY>; Sat, 27 Jul 2002 16:07:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318815AbSG0UHX>; Sat, 27 Jul 2002 16:07:23 -0400
Received: from sm11.texas.rr.com ([24.93.35.42]:27098 "EHLO sm11.texas.rr.com")
	by vger.kernel.org with ESMTP id <S318814AbSG0UHR>;
	Sat, 27 Jul 2002 16:07:17 -0400
Subject: [PATCH] ide parameter parsing code cleanup
From: Gerald Champagne <gerald@io.com>
To: linux-kernel@vger.kernel.org
Cc: dalecki@evision-ventures.com
Content-Type: multipart/mixed; boundary="=-8EsOD6rvT3jqahXVinxO"
X-Mailer: Ximian Evolution 1.0.8 
Date: 27 Jul 2002 15:10:25 -0500
Message-Id: <1027800626.2569.10.camel@wiley>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-8EsOD6rvT3jqahXVinxO
Content-Type: text/plain
Content-Transfer-Encoding: 7bit


Here's a little patch to clean up some of the ide parameter parsing
code.  I have not tested the module version of this code but the changes
seem pretty minor.  The main change is that it replaces the existing: 

__setup("",ide_setup); 

with: 

__setup("hd",hd_setup); 
__setup(ide",ide_setup); 

The setup routine is split into two routines; one to process hd
parameters specific to a device, and one to process ide parameters
specific to a controller.  The ide code was the only code in the kernel
that abused the __setup macro by calling it with a null string, and this
patch gets rid of that.

This is a small change, but it makes it obvious that some of the hd
parameters are actually setting controller parameters, not just device
parameters.

Gerald 


--=-8EsOD6rvT3jqahXVinxO
Content-Disposition: attachment; filename=ide_parms.diff
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-patch; name=ide_parms.diff; charset=ISO-8859-1

diff -ur linux-2.5.29.orig/drivers/ide/main.c linux-2.5.29/drivers/ide/main=
.c
--- linux-2.5.29.orig/drivers/ide/main.c	Fri Jul 26 21:58:24 2002
+++ linux-2.5.29/drivers/ide/main.c	Sat Jul 27 11:30:39 2002
@@ -701,79 +701,46 @@
=20
 /*
  * This gets called VERY EARLY during initialization, to handle kernel "co=
mmand
- * line" strings beginning with "hdx=3D" or "ide".It gets called even befo=
re the
- * actual module gets initialized.
+ * line" strings beginning with "hdx=3D".  It gets called even before the =
actual
+ * module gets initialized.
  *
  * Please look at Documentation/ide.txt to see the complete list of suppor=
ted
  * options.
  */
-int __init ide_setup(char *s)
+int __init hd_setup(char *s)
 {
-	int i, vals[4];
-	struct ata_channel *ch;
+	int vals[4];
+	struct ata_channel *ch;	/* FIXME:  Channel parms should not be accessed i=
n hd_setup */
 	struct ata_device *drive;
 	unsigned int hw, unit;
 	const char max_drive =3D 'a' + ((MAX_HWIFS * MAX_DRIVES) - 1);
-	const char max_ch  =3D '0' + (MAX_HWIFS - 1);
-
-	if (!strncmp(s, "hd=3D", 3))	/* hd=3D is for hd.c driver and not us */
-		return 0;
=20
-	if (strncmp(s,"ide",3) &&
-	    strncmp(s,"hd",2))		/* hdx=3D & hdxlun=3D */
+	if (s[0] =3D=3D '=3D')	/* hd=3D is for hd.c driver and not us */
 		return 0;
=20
-	printk(KERN_INFO  "ide_setup: %s", s);
+	printk(KERN_INFO  "hd_setup: hd%s", s);
 	init_global_data();
=20
-#ifdef CONFIG_BLK_DEV_IDEDOUBLER
-	if (!strcmp(s, "ide=3Ddoubler")) {
-		extern int ide_doubler;
-
-		printk(KERN_INFO" : Enabled support for IDE doublers\n");
-		ide_doubler =3D 1;
-
-		return 1;
-	}
-#endif
-
-	if (!strcmp(s, "ide=3Dnodma")) {
-		printk(KERN_INFO "ATA: Prevented DMA\n");
-		noautodma =3D 1;
-
-		return 1;
-	}
-
-#ifdef CONFIG_PCI
-	if (!strcmp(s, "ide=3Dreverse")) {
-		ide_scan_direction =3D 1;
-		printk(" : Enabled support for IDE inverse scan order.\n");
-
-		return 1;
-	}
-#endif
-
-	/*
-	 * Look for drive options:  "hdx=3D"
-	 */
-	if (!strncmp(s, "hd", 2) && s[2] >=3D 'a' && s[2] <=3D max_drive) {
+	if (s[0] >=3D 'a' && s[0] <=3D max_drive) {
 		const char *hd_words[] =3D {"none", "noprobe", "nowerr", "cdrom",
 				"serialize", "autotune", "noautotune",
 				"slow", "flash", "remap", "noremap", "scsi", NULL};
-		unit =3D s[2] - 'a';
+		unit =3D s[0] - 'a';
 		hw   =3D unit / MAX_DRIVES;
 		unit =3D unit % MAX_DRIVES;
 		ch =3D &ide_hwifs[hw];
 		drive =3D &ch->drives[unit];
-		if (!strncmp(s+3, "=3Dide-", 5)) {
-			strncpy(drive->driver_req, s + 4, 9);
+
+		/* Look for hdx=3Dide-* */
+		if (!strncmp(s+1, "=3Dide-", 5)) {
+			strncpy(drive->driver_req, s+2, 9);
 			goto done;
 		}
 		/*
 		 * Look for last lun option:  "hdxlun=3D"
 		 */
-		if (!strncmp(s+3, "lun=3D", 4)) {
-	                if (*get_options(s+7, 2, vals) || vals[0]!=3D1)
+		if (!strncmp(s+1, "lun=3D", 4)) {
+	                if (*get_options(s+5, 2, vals) || vals[0]!=3D1)
 				goto bad_option;
 			if (vals[1] >=3D 0 && vals[1] <=3D 7) {
 				drive->last_lun =3D vals[1];
@@ -782,7 +749,7 @@
 				printk(" -- BAD LAST LUN! Expected value from 0 to 7");
 			goto done;
 		}
-		switch (match_parm(s+3, hd_words, vals, 3)) {
+		switch (match_parm(s+1, hd_words, vals, 3)) {
 			case -1: /* "none" */
 				drive->nobios =3D 1;  /* drop into "noprobe" */
 			case -2: /* "noprobe" */
@@ -790,16 +757,16 @@
 				goto done;
 			case -3: /* "nowerr" */
 				drive->bad_wstat =3D BAD_R_STAT;
-				ch->noprobe =3D 0;
+				ch->noprobe =3D 0;	/* FIXME:  Channel parm */
 				goto done;
 			case -4: /* "cdrom" */
 				drive->present =3D 1;
 				drive->type =3D ATA_ROM;
-				ch->noprobe =3D 0;
+				ch->noprobe =3D 0;	/* FIXME:  Channel parm */
 				goto done;
 			case -5: /* "serialize" */
 				printk(" -- USE \"ide%d=3Dserialize\" INSTEAD", hw);
-				goto do_serialize;
+				goto bad_option;
 			case -6: /* "autotune" */
 				drive->autotune =3D 1;
 				goto done;
@@ -807,7 +774,7 @@
 				drive->autotune =3D 2;
 				goto done;
 			case -8: /* "slow" */
-				ch->slow =3D 1;
+				ch->slow =3D 1;		/* FIXME:  Channel parm */
 				goto done;
 			case -9: /* "flash" */
 				drive->ata_flash =3D 1;
@@ -840,11 +807,63 @@
 		}
 	}
=20
+bad_option:
+	printk(" -- BAD OPTION\n");
+	return 1;
+
+done:
+	printk("\n");
+
+	return 1;
+}
+
+/*
+ * This gets called VERY EARLY during initialization, to handle kernel "co=
mmand
+ * line" strings beginning with "ide".  It gets called even before the act=
ual
+ * module gets initialized.
+ *
+ * Please look at Documentation/ide.txt to see the complete list of suppor=
ted
+ * options.
+ */
+int __init ide_setup(char *s)
+{
+	int i, vals[4];
+	struct ata_channel *ch;
+	unsigned int hw;
+	const char max_ch  =3D '0' + (MAX_HWIFS - 1);
+
+	printk(KERN_INFO  "ide_setup: ide%s", s);
+	init_global_data();
+
+#ifdef CONFIG_BLK_DEV_IDEDOUBLER
+	if (!strcmp(s, "=3Ddoubler")) {
+		extern int ide_doubler;
+
+		printk(KERN_INFO" : Enabled support for IDE doublers\n");
+		ide_doubler =3D 1;
+		return 1;
+	}
+#endif
+
+	if (!strcmp(s, "=3Dnodma")) {
+		printk(KERN_INFO "ATA: Prevented DMA\n");
+		noautodma =3D 1;
+		return 1;
+	}
+
+#ifdef CONFIG_PCI
+	if (!strcmp(s, "=3Dreverse")) {
+		ide_scan_direction =3D 1;
+		printk(" : Enabled support for IDE inverse scan order.\n");
+		return 1;
+	}
+#endif
+
 	/*
 	 * Look for bus speed option:  "idebus=3D"
 	 */
-	if (!strncmp(s, "idebus=3D", 7)) {
-		if (*get_options(s+7, 2, vals) || vals[0] !=3D 1)
+	if (!strncmp(s, "bus=3D", 4)) {
+		if (*get_options(s+4, 2, vals) || vals[0] !=3D 1)
 			goto bad_option;
 		idebus_parameter =3D vals[1];
 		goto done;
@@ -853,7 +872,7 @@
 	/*
 	 * Look for interface options:  "idex=3D"
 	 */
-	if (!strncmp(s, "ide", 3) && s[3] >=3D '0' && s[3] <=3D max_ch) {
+	if (s[0] >=3D '0' && s[0] <=3D max_ch) {
 		/*
 		 * Be VERY CAREFUL changing this: note hardcoded indexes below
 		 */
@@ -861,11 +880,11 @@
 			"noprobe", "serialize", "autotune", "noautotune", "reset", "dma", "ata6=
6", NULL };
 		const char *ide_words[] =3D {
 			"qd65xx", "ht6560b", "cmd640_vlb", "dtc2278", "umc8672", "ali14xx", "dc=
4030", NULL };
-		hw =3D s[3] - '0';
+		hw =3D s[0] - '0';
 		ch =3D &ide_hwifs[hw];
=20
=20
-		switch (match_parm(s+4, ide_options, vals, 1)) {
+		switch (match_parm(s+1, ide_options, vals, 1)) {
 			case -7: /* ata66 */
 #ifdef CONFIG_PCI
 				ch->udma_four =3D 1;
@@ -889,7 +908,6 @@
 				ch->drives[1].autotune =3D 1;
 				goto done;
 			case -2: /* "serialize" */
-			do_serialize:
 				{
 					struct ata_channel *mate;
=20
@@ -904,7 +922,10 @@
 				goto done;
 		}
=20
-		i =3D match_parm(&s[4], ide_words, vals, 3);
+		/*
+		 * Check for specific chipset name
+		 */
+		i =3D match_parm(s+1, ide_words, vals, 3);
=20
 		/*
 		 * Cryptic check to ensure chipset not already set for a channel:
@@ -913,7 +934,7 @@
 			if (ide_hwifs[hw].chipset !=3D ide_unknown)
 				goto bad_option;	/* chipset already specified */
 			if (i !=3D -7 && hw !=3D 0)
-				goto bad_channel;		/* chipset drivers are for "ide0=3D" only */
+				goto bad_channel;	/* chipset drivers are for "ide0=3D" only */
 			if (i !=3D -7 && ide_hwifs[1].chipset !=3D ide_unknown)
 				goto bad_option;	/* chipset for 2nd port already specified */
 			printk("\n");
@@ -1432,8 +1453,14 @@
 		while ((options =3D next) !=3D NULL) {
 			if ((next =3D strchr(options,' ')) !=3D NULL)
 				*next++ =3D 0;
-			if (!ide_setup(options))
-				printk(KERN_ERR "Unknown option '%s'\n", options);
+			if (!strncmp(options,"hd",2)) {
+				if (!hd_setup(options+2))
+					printk(KERN_ERR "Unknown option '%s'\n", options);
+			}
+			else if (!strncmp(options,"ide",3)) {
+				if (!ide_setup(options+3))
+					printk(KERN_ERR "Unknown option '%s'\n", options);
+			}
 		}
 	}
 	return ata_module_init();
@@ -1457,6 +1484,7 @@
 #ifndef MODULE
=20
 /* command line option parser */
-__setup("", ide_setup);
+__setup("ide", ide_setup);
+__setup("hd", hd_setup);
=20
 #endif

--=-8EsOD6rvT3jqahXVinxO--

