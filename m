Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264874AbUAAURF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jan 2004 15:17:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265375AbUAAUPs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jan 2004 15:15:48 -0500
Received: from amsfep15-int.chello.nl ([213.46.243.28]:38928 "EHLO
	amsfep15-int.chello.nl") by vger.kernel.org with ESMTP
	id S265030AbUAAUKI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jan 2004 15:10:08 -0500
Date: Thu, 1 Jan 2004 21:01:59 +0100
Message-Id: <200401012001.i01K1xG3031793@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 359] Mac ESP SCSI setup
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mac ESP SCSI: Update argument parsing (from Matthias Urlichs)

--- linux-2.6.0/drivers/scsi/mac_esp.c	Tue Jul 29 18:19:10 2003
+++ linux-m68k-2.6.0/drivers/scsi/mac_esp.c	Mon Oct 20 21:41:46 2003
@@ -151,92 +151,98 @@
 #define DRIVER_SETUP
 
 /*
- * Function : mac_esp_setup(char *str, int *ints)
+ * Function : mac_esp_setup(char *str)
  *
  * Purpose : booter command line initialization of the overrides array,
  *
- * Inputs : str - unused, ints - array of integer parameters with ints[0]
- *	equal to the number of ints.
+ * Inputs : str - parameters, separated by commas.
  *
  * Currently unused in the new driver; need to add settable parameters to the 
  * detect function.
  *
  */
 
-static int __init mac_esp_setup(char *str, int *ints) {
+static int __init mac_esp_setup(char *str) {
 #ifdef DRIVER_SETUP
 	/* Format of mac53c9x parameter is:
 	 *   mac53c9x=<num_esps>,<disconnect>,<nosync>,<can_queue>,<cmd_per_lun>,<sg_tablesize>,<hostid>,<use_tags>
 	 * Negative values mean don't change.
 	 */
 	
-	/* Grmbl... the standard parameter parsing can't handle negative numbers
-	 * :-( So let's do it ourselves!
-	 */
+	char *this_opt;
+	long opt;
+
+	this_opt = strsep (&str, ",");
+	if(this_opt) {
+		opt = simple_strtol( this_opt, NULL, 0 );
 
-	int i = ints[0]+1, fact;
+		if (opt >= 0 && opt <= 2)
+			setup_num_esps = opt;
+		else if (opt > 2)
+			printk( "mac_esp_setup: invalid number of hosts %ld !\n", opt );
 
-	while( str && (isdigit(*str) || *str == '-') && i <= 10) {
-		if (*str == '-')
-			fact = -1, ++str;
-		else
-			fact = 1;
-		ints[i++] = simple_strtoul( str, NULL, 0 ) * fact;
-		if ((str = strchr( str, ',' )) != NULL)
-			++str;
+		this_opt = strsep (&str, ",");
 	}
-	ints[0] = i-1;
+	if(this_opt) {
+		opt = simple_strtol( this_opt, NULL, 0 );
 	
-	if (ints[0] < 1) {
-		printk( "mac_esp_setup: no arguments!\n" );
-		return 0;
-	}
-
-	if (ints[0] >= 1) {
-		if (ints[1] > 0)
-			/* no limits on this, just > 0 */
-		if (ints[1] >= 0 && ints[1] <= 2)
-			setup_num_esps = ints[1];
-		else if (ints[1] > 2)
-			printk( "mac_esp_setup: invalid number of hosts %d !\n", ints[1] );
-	}
-	if (ints[0] >= 2) {
-		if (ints[2] > 0)
-			setup_disconnect = ints[2];
-	}
-	if (ints[0] >= 3) {
-		if (ints[3] >= 0) {
-			setup_nosync = ints[3];
-		}
+		if (opt > 0)
+			setup_disconnect = opt;
+
+		this_opt = strsep (&str, ",");
+	}
+	if(this_opt) {
+		opt = simple_strtol( this_opt, NULL, 0 );
+
+		if (opt >= 0)
+			setup_nosync = opt;
+
+		this_opt = strsep (&str, ",");
+	}
+	if(this_opt) {
+		opt = simple_strtol( this_opt, NULL, 0 );
+
+		if (opt > 0)
+			setup_can_queue = opt;
+
+		this_opt = strsep (&str, ",");
 	}
-	if (ints[0] >= 4) {
-		if (ints[4] > 0)
-			/* no limits on this, just > 0 */
-			setup_can_queue = ints[4];
-	}
-	if (ints[0] >= 5) {
-		if (ints[5] > 0)
-			setup_cmd_per_lun = ints[5];
-	}
-	if (ints[0] >= 6) {
-		if (ints[6] >= 0) {
-			setup_sg_tablesize = ints[6];
+	if(this_opt) {
+		opt = simple_strtol( this_opt, NULL, 0 );
+
+		if (opt > 0)
+			setup_cmd_per_lun = opt;
+
+		this_opt = strsep (&str, ",");
+	}
+	if(this_opt) {
+		opt = simple_strtol( this_opt, NULL, 0 );
+
+		if (opt >= 0) {
+			setup_sg_tablesize = opt;
 			/* Must be <= SG_ALL (255) */
 			if (setup_sg_tablesize > SG_ALL)
 				setup_sg_tablesize = SG_ALL;
 		}
+
+		this_opt = strsep (&str, ",");
 	}
-	if (ints[0] >= 7) {
+	if(this_opt) {
+		opt = simple_strtol( this_opt, NULL, 0 );
+
 		/* Must be between 0 and 7 */
-		if (ints[7] >= 0 && ints[7] <= 7)
-			setup_hostid = ints[7];
-		else if (ints[7] > 7)
-			printk( "mac_esp_setup: invalid host ID %d !\n", ints[7] );
+		if (opt >= 0 && opt <= 7)
+			setup_hostid = opt;
+		else if (opt > 7)
+			printk( "mac_esp_setup: invalid host ID %ld !\n", opt);
+
+		this_opt = strsep (&str, ",");
 	}
 #ifdef SUPPORT_TAGS
-	if (ints[0] >= 8) {
-		if (ints[8] >= 0)
-			setup_use_tagged_queuing = !!ints[8];
+	if(this_opt) {
+		opt = simple_strtol( this_opt, NULL, 0 );
+		if (opt >= 0)
+			setup_use_tagged_queuing = !!opt;
 	}
 #endif
 #endif
@@ -244,6 +250,7 @@
 }
 
 __setup("mac53c9x=", mac_esp_setup);
+
 
 /*
  * ESP address 'detection'

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
