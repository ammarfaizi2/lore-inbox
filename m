Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312962AbSDGFr0>; Sun, 7 Apr 2002 00:47:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312970AbSDGFrZ>; Sun, 7 Apr 2002 00:47:25 -0500
Received: from horse08.daimi.au.dk ([130.225.18.248]:21634 "EHLO
	horse08.daimi.au.dk") by vger.kernel.org with ESMTP
	id <S312962AbSDGFrY>; Sun, 7 Apr 2002 00:47:24 -0500
Message-ID: <3CAFDBDE.3BF3321D@daimi.au.dk>
Date: Sun, 07 Apr 2002 07:40:46 +0200
From: Kasper Dupont <kasperd@daimi.au.dk>
Organization: daimi.au.dk
X-Mozilla-Draft-Info: internal/draft; vcard=0; receipt=0; uuencode=0; html=0; linewidth=0
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.9-12smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] sb_card.c no_hlt option
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On some hardware combinations halting the CPU generates
noice on the sound output. Until now the solution has
been to give the kernel a no-hlt argument. This option
allows turning off halting only while the sb module is
loaded.

Is this an option that others consider usefull? I have
been using this patch for half a year with different
2.4.x kernels and have had no problems.

Also avilable by HTTP
http://www.daimi.au.dk/~kasperd/linux_kernel/sb_no_hlt.2.4.17.patch

-- 
Kasper Dupont -- der bruger for meget tid på usenet.
For sending spam use mailto:razor-report@daimi.au.dk
diff -Nur linux-2.4.17/drivers/sound/sb_card.c linux-2.4.17-kd/drivers/sound/sb_card.c
--- linux-2.4.17/drivers/sound/sb_card.c	Fri Dec 21 18:41:55 2001
+++ linux-2.4.17-kd/drivers/sound/sb_card.c	Sat Jan 19 14:38:44 2002
@@ -54,6 +54,14 @@
  * 28-10-2000 Added pnplegacy support
  * 	Daniel Church <dchurch@mbhs.edu>
  *
+ * 06-08-2001 Added no_hlt option
+ * 	On some hardware combinations halting the CPU generates
+ * 	noice on the sound output. Until now the solution has
+ * 	been to give the kernel a no-hlt argument. This option
+ * 	allows turning off halting only while the sb module is
+ * 	loaded.
+ * 	Kasper Dupont <kasperd@daimi.au.dk>
+ *
  * 01-10-2001 Added a new flavor of Creative SB AWE64 PnP (CTL00E9).
  *      Jerome Cornet <jcornet@free.fr>
  */
@@ -212,6 +220,7 @@
 static int multiple	= 0;
 static int pnplegacy	= 0;
 #endif
+static int no_hlt       = 0;
 
 MODULE_DESCRIPTION("Soundblaster driver");
 MODULE_LICENSE("GPL");
@@ -225,6 +234,7 @@
 MODULE_PARM(sm_games,	"i");
 MODULE_PARM(esstype,	"i");
 MODULE_PARM(acer,	"i");
+MODULE_PARM(no_hlt,	"i");
 
 #if defined CONFIG_ISAPNP || defined CONFIG_ISAPNP_MODULE
 MODULE_PARM(isapnp,	"i");
@@ -250,6 +260,7 @@
 MODULE_PARM_DESC(sm_games,	"Enable support for Logitech soundman games");
 MODULE_PARM_DESC(esstype,	"ESS chip type");
 MODULE_PARM_DESC(acer,		"Set this to detect cards in some ACER notebooks");
+MODULE_PARM_DESC(no_hlt,	"Used to avoid noice on some hardware combinations");
 
 #if defined CONFIG_ISAPNP || defined CONFIG_ISAPNP_MODULE
 
@@ -982,6 +993,10 @@
 			sbmpu[card] = 1;
 	}
 
+#ifdef HAVE_DISABLE_HLT
+	if (no_hlt) disable_hlt();
+#endif
+
 	if(isapnp)
 		printk(KERN_NOTICE "sb: %d Soundblaster PnP card(s) found.\n", sb_cards_num);
 
@@ -992,6 +1007,10 @@
 {
 	int i;
 	
+#ifdef HAVE_DISABLE_HLT
+	if (no_hlt) enable_hlt();
+#endif
+
 	if (smw_free) {
 		vfree(smw_free);
 		smw_free = NULL;
