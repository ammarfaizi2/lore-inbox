Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264396AbTEZOa5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 10:30:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264394AbTEZOa5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 10:30:57 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:39810 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S264396AbTEZOaq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 10:30:46 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: torvalds@transmeta.com, alan@redhat.com
Subject: [PATCH] Probe legacy IDE chipsets in ide_init() instead of in ide_setup()
Date: Mon, 26 May 2003 16:44:03 +0200
User-Agent: KMail/1.4.1
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200305261644.03740.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Incremental to previous "biostimings" patch.
Please apply.
--
Bartlomiej

Probe legacy IDE chipsets in ide_init() instead of in ide_setup().

Legacy here means pdc4030, ali14xx, umc8672, dtc2278, ht6560b and qd65xx.
They cannot be probed and initialized at a boot parameters' parsing time,
because probing code depends on not yet ready kernel subsystems.

This change also fixes boot parameters' ordering issue, fe. you could
pass "ide0=dtc2278 ide0=noautotune" and "noautotune" was catched too late.

 drivers/ide/ide.c |  119 ++++++++++++++++++++++++++++++++++++------------------
 1 files changed, 80 insertions(+), 39 deletions(-)

diff -puN drivers/ide/ide.c~legacy_ide_probe_fix drivers/ide/ide.c
--- linux-2.5.69-bk17/drivers/ide/ide.c~legacy_ide_probe_fix	Mon May 26 13:23:23 2003
+++ linux-2.5.69-bk17-root/drivers/ide/ide.c	Mon May 26 13:24:00 2003
@@ -1695,6 +1695,33 @@ static int __init match_parm (char *s, c
 	return 0;	/* zero = nothing matched */
 }
 
+#ifdef CONFIG_BLK_DEV_PDC4030
+static int __initdata probe_pdc4030;
+extern void init_pdc4030(void);
+#endif
+#ifdef CONFIG_BLK_DEV_ALI14XX
+static int __initdata probe_ali14xx;
+extern void init_ali14xx(void);
+#endif
+#ifdef CONFIG_BLK_DEV_UMC8672
+static int __initdata probe_umc8672;
+extern void init_umc8672(void);
+#endif
+#ifdef CONFIG_BLK_DEV_DTC2278
+static int __initdata probe_dtc2278;
+extern void init_dtc2278(void);
+#endif
+#ifdef CONFIG_BLK_DEV_HT6560B
+static int __initdata probe_ht6560b;
+extern void init_ht6560b(void);
+#endif
+#ifdef CONFIG_BLK_DEV_QD65XX
+static int __initdata probe_qd65xx;
+extern void init_qd65xx(void);
+#endif
+
+static int __initdata is_chipset_set[MAX_HWIFS];
+
 /*
  * ide_setup() gets called VERY EARLY during initialization,
  * to handle kernel "command line" strings beginning with "hdx="
@@ -1951,51 +1978,46 @@ int __init ide_setup (char *s)
 		i = match_parm(&s[4], ide_words, vals, 3);
 
 		/*
-		 * Cryptic check to ensure chipset not already set for hwif:
+		 * Cryptic check to ensure chipset not already set for hwif.
+		 * Note: we can't depend on hwif->chipset here.
 		 */
-		if (i > 0 || i <= -11) {			/* is parameter a chipset name? */
-			if (hwif->chipset != ide_unknown)
-				goto bad_option;	/* chipset already specified */
-			if (i <= -11 && i != -18 && hw != 0)
-				goto bad_hwif;		/* chipset drivers are for "ide0=" only */
-			if (i <= -11 && i != -18 && ide_hwifs[hw+1].chipset != ide_unknown)
-				goto bad_option;	/* chipset for 2nd port already specified */
+		if ((i >= -18 && i <= -11) || (i > 0 && i <= 3)) {
+			/* chipset already specified */
+			if (is_chipset_set[hw])
+				goto bad_option;
+			if (i > -18 && i <= -11) {
+				/* these drivers are for "ide0=" only */
+				if (hw != 0)
+					goto bad_hwif;
+				/* chipset already specified for 2nd port */
+				if (is_chipset_set[hw+1])
+					goto bad_option;
+			}
+			is_chipset_set[hw] = 1;
 			printk("\n");
 		}
 
 		switch (i) {
 #ifdef CONFIG_BLK_DEV_PDC4030
 			case -18: /* "dc4030" */
-			{
-				extern void init_pdc4030(void);
-				init_pdc4030();
+				probe_pdc4030 = 1;
 				goto done;
-			}
-#endif /* CONFIG_BLK_DEV_PDC4030 */
+#endif
 #ifdef CONFIG_BLK_DEV_ALI14XX
 			case -17: /* "ali14xx" */
-			{
-				extern void init_ali14xx (void);
-				init_ali14xx();
+				probe_ali14xx = 1;
 				goto done;
-			}
-#endif /* CONFIG_BLK_DEV_ALI14XX */
+#endif
 #ifdef CONFIG_BLK_DEV_UMC8672
 			case -16: /* "umc8672" */
-			{
-				extern void init_umc8672 (void);
-				init_umc8672();
+				probe_umc8672 = 1;
 				goto done;
-			}
-#endif /* CONFIG_BLK_DEV_UMC8672 */
+#endif
 #ifdef CONFIG_BLK_DEV_DTC2278
 			case -15: /* "dtc2278" */
-			{
-				extern void init_dtc2278 (void);
-				init_dtc2278();
+				probe_dtc2278 = 1;
 				goto done;
-			}
-#endif /* CONFIG_BLK_DEV_DTC2278 */
+#endif
 #ifdef CONFIG_BLK_DEV_CMD640
 			case -14: /* "cmd640_vlb" */
 			{
@@ -2003,23 +2025,17 @@ int __init ide_setup (char *s)
 				cmd640_vlb = 1;
 				goto done;
 			}
-#endif /* CONFIG_BLK_DEV_CMD640 */
+#endif
 #ifdef CONFIG_BLK_DEV_HT6560B
 			case -13: /* "ht6560b" */
-			{
-				extern void init_ht6560b (void);
-				init_ht6560b();
+				probe_ht6560b = 1;
 				goto done;
-			}
-#endif /* CONFIG_BLK_DEV_HT6560B */
+#endif
 #ifdef CONFIG_BLK_DEV_QD65XX
 			case -12: /* "qd65xx" */
-			{
-				extern void init_qd65xx (void);
-				init_qd65xx();
+				probe_qd65xx = 1;
 				goto done;
-			}
-#endif /* CONFIG_BLK_DEV_QD65XX */
+#endif
 #ifdef CONFIG_BLK_DEV_4DRIVES
 			case -11: /* "four" drives on one set of ports */
 			{
@@ -2477,6 +2493,31 @@ int __init ide_init (void)
 
 	init_ide_data();
 
+#ifdef CONFIG_BLK_DEV_PDC4030
+	if (probe_pdc4030)
+		init_pdc4030();
+#endif
+#ifdef CONFIG_BLK_DEV_ALI14XX
+	if (probe_ali14xx)
+		init_ali14xx();
+#endif
+#ifdef CONFIG_BLK_DEV_UMC8672
+	if (probe_umc8672)
+		init_umc8672();
+#endif
+#ifdef CONFIG_BLK_DEV_DTC2278
+	if (probe_dtc2278)
+		init_dtc2278();
+#endif
+#ifdef CONFIG_BLK_DEV_HT6560B
+	if (probe_ht6560b)
+		init_ht6560b();
+#endif
+#ifdef CONFIG_BLK_DEV_QD65XX
+	if (probe_qd65xx)
+		init_qd65xx();
+#endif
+
 	initializing = 1;
 	ide_init_builtin_drivers();
 	initializing = 0;

_

