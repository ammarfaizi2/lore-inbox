Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318134AbSFTHJr>; Thu, 20 Jun 2002 03:09:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318135AbSFTHJq>; Thu, 20 Jun 2002 03:09:46 -0400
Received: from sm13.texas.rr.com ([24.93.35.40]:59328 "EHLO sm13.texas.rr.com")
	by vger.kernel.org with ESMTP id <S318134AbSFTHJn>;
	Thu, 20 Jun 2002 03:09:43 -0400
Subject: [PATCH] small cleanup of ide parameter parsing
From: Gerald Champagne <gerald@io.com>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-yMImlNBMlj6iBaJemc3S"
X-Mailer: Ximian Evolution 1.0.7 
Date: 20 Jun 2002 02:09:18 -0500
Message-Id: <1024556958.3545.180.camel@wiley>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-yMImlNBMlj6iBaJemc3S
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Attached is a small cleanup of the parameter parsing in the ide driver. 
This patch replaces some of the string parsing code with get_options()
and it starts cleaning up the code that checks for specific chipsets. 

I tried to keep the chipset error checking exactly as it was before, and
now the remaining code looks a little strange.  It does something like
this:

   if (parameter is a chipset name) {
       if (chipset type is already defined for selected port)
           goto bad_option;

       if ((chipset parameter != dc4030) && (hw!=ide0) )
           goto bad_channel;

       if ((chipset parameter != dc4030) && 
            chipset type is already defined for ide1)
           goto bad_option;
   }

Can some of this be removed?  It would allow the remaining code to be
simplified..

Gerald









--=-yMImlNBMlj6iBaJemc3S
Content-Disposition: attachment; filename=ide-parse.diff
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-patch; name=ide-parse.diff; charset=ISO-8859-1

diff -ruN linux-2.5.23.orig/drivers/ide/main.c linux-2.5.23/drivers/ide/mai=
n.c
--- linux-2.5.23.orig/drivers/ide/main.c	Tue Jun 18 21:11:45 2002
+++ linux-2.5.23/drivers/ide/main.c	Thu Jun 20 00:15:27 2002
@@ -638,17 +638,6 @@
  */
=20
 /*
- * stridx() returns the offset of c within s,
- * or -1 if c is '\0' or not found within s.
- */
-static int __init stridx (const char *s, char c)
-{
-	char *i =3D strchr(s, c);
-
-	return (i && c) ? i - s : -1;
-}
-
-/*
  * Parsing for ide_setup():
  *
  * 1. the first char of s must be '=3D'.
@@ -657,14 +646,14 @@
  * 3. if the remainder is a series of no more than max_vals numbers
  *     separated by commas, the numbers are saved in vals[] and a
  *     count of how many were saved is returned.  Base10 is assumed,
- *     and base16 is allowed when prefixed with "0x".
+ *     and base16 is allowed when prefixed with "0x".  The number of=20
+ *     values read will be placed in vals[0], and the values read will
+ *     placed in vals[1] to vals[max_vals].
  * 4. otherwise, zero is returned.
  */
 static int __init match_parm (char *s, const char *keywords[], int vals[],=
 int max_vals)
 {
-	static const char decimal[] =3D "0123456789";
-	static const char hex[] =3D "0123456789abcdef";
-	int i, n;
+	int i;
=20
 	if (*s++ =3D=3D '=3D') {
 		/*
@@ -683,23 +672,10 @@
 		 * or base16 when prefixed with "0x".
 		 * Return a count of how many were found.
 		 */
-		for (n =3D 0; (i =3D stridx(decimal, *s)) >=3D 0;) {
-			vals[n] =3D i;
-			while ((i =3D stridx(decimal, *++s)) >=3D 0)
-				vals[n] =3D (vals[n] * 10) + i;
-			if (*s =3D=3D 'x' && !vals[n]) {
-				while ((i =3D stridx(hex, *++s)) >=3D 0)
-					vals[n] =3D (vals[n] * 0x10) + i;
-			}
-			if (++n =3D=3D max_vals)
-				break;
-			if (*s =3D=3D ',' || *s =3D=3D ';')
-				++s;
-		}
-		if (!*s)
-			return n;
+        	get_options(s, max_vals+1, vals);
+	        return vals[0];
 	}
-	return 0;	/* zero =3D nothing matched */
+	return 0;
 }
=20
 /*
@@ -744,7 +720,7 @@
  */
 int __init ide_setup(char *s)
 {
-	int i, vals[3];
+	int i, vals[4];
 	struct ata_channel *ch;
 	struct ata_device *drive;
 	unsigned int hw, unit;
@@ -755,7 +731,6 @@
 		return 0;
=20
 	if (strncmp(s,"ide",3) &&
-	    strncmp(s,"idebus",6) &&
 	    strncmp(s,"hd",2))		/* hdx=3D & hdxlun=3D */
 		return 0;
=20
@@ -801,24 +776,24 @@
 		unit =3D unit % MAX_DRIVES;
 		ch =3D &ide_hwifs[hw];
 		drive =3D &ch->drives[unit];
-		if (!strncmp(s + 4, "ide-", 4)) {
+		if (!strncmp(s+3, "=3Dide-", 5)) {
 			strncpy(drive->driver_req, s + 4, 9);
 			goto done;
 		}
 		/*
 		 * Look for last lun option:  "hdxlun=3D"
 		 */
-		if (!strncmp(&s[3], "lun", 3)) {
-			if (match_parm(&s[6], NULL, vals, 1) !=3D 1)
+		if (!strncmp(s+3, "lun=3D", 4)) {
+	                if (*get_options(s+7, 2, vals) || vals[0]!=3D1)
 				goto bad_option;
-			if (vals[0] >=3D 0 && vals[0] <=3D 7) {
-				drive->last_lun =3D vals[0];
+			if (vals[1] >=3D 0 && vals[1] <=3D 7) {
+				drive->last_lun =3D vals[1];
 				drive->forced_lun =3D 1;
 			} else
 				printk(" -- BAD LAST LUN! Expected value from 0 to 7");
 			goto done;
 		}
-		switch (match_parm(&s[3], hd_words, vals, 3)) {
+		switch (match_parm(s+3, hd_words, vals, 3)) {
 			case -1: /* "none" */
 				drive->nobios =3D 1;  /* drop into "noprobe" */
 			case -2: /* "noprobe" */
@@ -864,9 +839,9 @@
 #endif
 			case 3: /* cyl,head,sect */
 				drive->type	=3D ATA_DISK;
-				drive->cyl	=3D drive->bios_cyl  =3D vals[0];
-				drive->head	=3D drive->bios_head =3D vals[1];
-				drive->sect	=3D drive->bios_sect =3D vals[2];
+				drive->cyl	=3D drive->bios_cyl  =3D vals[1];
+				drive->head	=3D drive->bios_head =3D vals[2];
+				drive->sect	=3D drive->bios_sect =3D vals[3];
 				drive->present	=3D 1;
 				drive->forced_geom =3D 1;
 				ch->noprobe =3D 0;
@@ -879,10 +854,10 @@
 	/*
 	 * Look for bus speed option:  "idebus=3D"
 	 */
-	if (!strncmp(s, "idebus", 6)) {
-		if (match_parm(&s[6], NULL, vals, 1) !=3D 1)
+	if (!strncmp(s, "idebus=3D", 7)) {
+		if (*get_options(s+7, 2, vals) || vals[0] !=3D 1)
 			goto bad_option;
-		idebus_parameter =3D vals[0];
+		idebus_parameter =3D vals[1];
 		goto done;
 	}
=20
@@ -892,33 +867,72 @@
 	if (!strncmp(s, "ide", 3) && s[3] >=3D '0' && s[3] <=3D max_ch) {
 		/*
 		 * Be VERY CAREFUL changing this: note hardcoded indexes below
-		 * -8,-9,-10. -11 : are reserved for future idex calls to ease the hardc=
oding.
 		 */
+		const char *ide_options[] =3D {
+			"noprobe", "serialize", "autotune", "noautotune", "reset", "dma", "ata6=
6", NULL };
 		const char *ide_words[] =3D {
-			"noprobe", "serialize", "autotune", "noautotune", "reset", "dma", "ata6=
6",
-			"minus8", "minus9", "minus10", "minus11",
 			"qd65xx", "ht6560b", "cmd640_vlb", "dtc2278", "umc8672", "ali14xx", "dc=
4030", NULL };
 		hw =3D s[3] - '0';
 		ch =3D &ide_hwifs[hw];
=20
+
+		switch (match_parm(s+4, ide_options, vals, 1)) {
+			case -7: /* ata66 */
+#ifdef CONFIG_PCI
+				ch->udma_four =3D 1;
+				goto done;
+#else
+				ch->udma_four =3D 0;
+				goto bad_channel;
+#endif
+			case -6: /* dma */
+				ch->autodma =3D 1;
+				goto done;
+			case -5: /* reset */
+				ch->reset =3D 1;
+				goto done;
+			case -4: /* noautotune */
+				ch->drives[0].autotune =3D 2;
+				ch->drives[1].autotune =3D 2;
+				goto done;
+			case -3: /* autotune */
+				ch->drives[0].autotune =3D 1;
+				ch->drives[1].autotune =3D 1;
+				goto done;
+			case -2: /* "serialize" */
+			do_serialize:
+				{
+					struct ata_channel *mate;
+
+					mate =3D &ide_hwifs[hw ^ 1];
+					ch->serialized =3D 1;
+					mate->serialized =3D 1;
+				}
+				goto done;
+
+			case -1: /* "noprobe" */
+				ch->noprobe =3D 1;
+				goto done;
+		}
+
 		i =3D match_parm(&s[4], ide_words, vals, 3);
=20
 		/*
 		 * Cryptic check to ensure chipset not already set for a channel:
 		 */
-		if (i > 0 || i <=3D -11) {			/* is parameter a chipset name? */
-			if (ch->chipset !=3D ide_unknown)
+		if (i) {			/* is parameter a chipset name? */
+			if (ide_hwifs[hw].chipset !=3D ide_unknown)
 				goto bad_option;	/* chipset already specified */
-			if (i <=3D -11 && i !=3D -18 && hw !=3D 0)
+			if (i !=3D -7 && hw !=3D 0)
 				goto bad_channel;		/* chipset drivers are for "ide0=3D" only */
-			if (i <=3D -11 && i !=3D -18 && ide_hwifs[hw+1].chipset !=3D ide_unknow=
n)
+			if (i !=3D -7 && ide_hwifs[1].chipset !=3D ide_unknown)
 				goto bad_option;	/* chipset for 2nd port already specified */
 			printk("\n");
 		}
=20
 		switch (i) {
 #ifdef CONFIG_BLK_DEV_PDC4030
-			case -18: /* "dc4030" */
+			case -7:  /* "dc4030" */
 			{
 				extern void init_pdc4030(void);
 				init_pdc4030();
@@ -926,7 +940,7 @@
 			}
 #endif
 #ifdef CONFIG_BLK_DEV_ALI14XX
-			case -17: /* "ali14xx" */
+			case -6:  /* "ali14xx" */
 			{
 				extern void init_ali14xx (void);
 				init_ali14xx();
@@ -934,7 +948,7 @@
 			}
 #endif
 #ifdef CONFIG_BLK_DEV_UMC8672
-			case -16: /* "umc8672" */
+			case -5:  /* "umc8672" */
 			{
 				extern void init_umc8672 (void);
 				init_umc8672();
@@ -942,7 +956,7 @@
 			}
 #endif
 #ifdef CONFIG_BLK_DEV_DTC2278
-			case -15: /* "dtc2278" */
+			case -4:  /* "dtc2278" */
 			{
 				extern void init_dtc2278 (void);
 				init_dtc2278();
@@ -950,7 +964,7 @@
 			}
 #endif
 #ifdef CONFIG_BLK_DEV_CMD640
-			case -14: /* "cmd640_vlb" */
+			case -3:  /* "cmd640_vlb" */
 			{
 				extern int cmd640_vlb; /* flag for cmd640.c */
 				cmd640_vlb =3D 1;
@@ -958,7 +972,7 @@
 			}
 #endif
 #ifdef CONFIG_BLK_DEV_HT6560B
-			case -13: /* "ht6560b" */
+			case -2:  /* "ht6560b" */
 			{
 				extern void init_ht6560b (void);
 				init_ht6560b();
@@ -966,64 +980,22 @@
 			}
 #endif
 #if CONFIG_BLK_DEV_QD65XX
-			case -12: /* "qd65xx" */
+			case -1:  /* "qd65xx" */
 			{
 				extern void init_qd65xx (void);
 				init_qd65xx();
 				goto done;
 			}
 #endif
-			case -11: /* minus11 */
-			case -10: /* minus10 */
-			case -9: /* minus9 */
-			case -8: /* minus8 */
-				goto bad_option;
-			case -7: /* ata66 */
-#ifdef CONFIG_PCI
-				ch->udma_four =3D 1;
-				goto done;
-#else
-				ch->udma_four =3D 0;
-				goto bad_channel;
-#endif
-			case -6: /* dma */
-				ch->autodma =3D 1;
-				goto done;
-			case -5: /* reset */
-				ch->reset =3D 1;
-				goto done;
-			case -4: /* noautotune */
-				ch->drives[0].autotune =3D 2;
-				ch->drives[1].autotune =3D 2;
-				goto done;
-			case -3: /* autotune */
-				ch->drives[0].autotune =3D 1;
-				ch->drives[1].autotune =3D 1;
-				goto done;
-			case -2: /* "serialize" */
-			do_serialize:
-				{
-					struct ata_channel *mate;
-
-					mate =3D &ide_hwifs[hw ^ 1];
-					ch->serialized =3D 1;
-					mate->serialized =3D 1;
-				}
-				goto done;
-
-			case -1: /* "noprobe" */
-				ch->noprobe =3D 1;
-				goto done;
-
 			case 1:	/* base */
-				vals[1] =3D vals[0] + 0x206; /* default ctl */
+				vals[2] =3D vals[1] + 0x206; /* default ctl */
 			case 2: /* base,ctl */
-				vals[2] =3D 0;	/* default irq =3D probe for it */
+				vals[3] =3D 0;	/* default irq =3D probe for it */
 			case 3: /* base,ctl,irq */
-				ch->hw.irq =3D vals[2];
-				ide_init_hwif_ports(&ch->hw, (ide_ioreg_t) vals[0], (ide_ioreg_t) vals=
[1], &ch->irq);
+				ch->hw.irq =3D vals[3];
+				ide_init_hwif_ports(&ch->hw, (ide_ioreg_t) vals[1], (ide_ioreg_t) vals=
[2], &ch->irq);
 				memcpy(ch->io_ports, ch->hw.io_ports, sizeof(ch->io_ports));
-				ch->irq =3D vals[2];
+				ch->irq =3D vals[3];
 				ch->noprobe  =3D 0;
 				ch->chipset  =3D ide_generic;
 				goto done;

--=-yMImlNBMlj6iBaJemc3S--

