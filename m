Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265478AbSJSCfH>; Fri, 18 Oct 2002 22:35:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265482AbSJSCfH>; Fri, 18 Oct 2002 22:35:07 -0400
Received: from roc-24-93-20-125.rochester.rr.com ([24.93.20.125]:27385 "EHLO
	www.kroptech.com") by vger.kernel.org with ESMTP id <S265478AbSJSCfE>;
	Fri, 18 Oct 2002 22:35:04 -0400
Date: Fri, 18 Oct 2002 22:41:02 -0400
From: Adam Kropelin <akropel1@rochester.rr.com>
To: jgarzik@pobox.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5: ewrk3 signature cleanup, changelog, and revision bump
Message-ID: <20021019024102.GB10058@www.kroptech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Last patch for now. Updates the changelog to cover previous patches, bumps the
revision number, and replaces the horrific EthwrkSignature function with
something (slightly) less horrific.

Applies against 2.5.43 + ewrk3-ethtool + ewrk3-clisti + ewrk3-ioctllock.

--Adam

--- linux-2.5.43-mm1/drivers/net/ewrk3.c	Fri Oct 18 22:17:11 2002
+++ linux-2.5.43-mm1/drivers/net/ewrk3.c.new	Fri Oct 18 22:32:21 2002
@@ -137,6 +137,8 @@
    0.45    19-Jul-02   fix unaligned access on alpha <martin@bruli.net>
    0.46    10-Oct-02   Multiple NIC support when module <akropel1@rochester.rr.com>
    0.47    18-Oct-02   ethtool support <akropel1@rochester.rr.com>
+   0.48    18-Oct-02   cli/sti removal for 2.5 <vda@port.imtp.ilyichevsk.odessa.ua>
+   ioctl locking, signature search cleanup <akropel1@rochester.rr.com>
 
    =========================================================================
  */
@@ -171,10 +173,10 @@
 #include "ewrk3.h"
 
 #define DRV_NAME	"ewrk3"
-#define DRV_VERSION	"0.47"
+#define DRV_VERSION	"0.48"
 
 static char version[] __initdata =
-DRV_NAME ":v" DRV_VERSION " 2002/10/17 davies@maniac.ultranet.com\n";
+DRV_NAME ":v" DRV_VERSION " 2002/10/18 davies@maniac.ultranet.com\n";
 
 #ifdef EWRK3_DEBUG
 static int ewrk3_debug = EWRK3_DEBUG;
@@ -1476,27 +1478,20 @@
  */
 static void __init EthwrkSignature(char *name, char *eeprom_image)
 {
-	u_long i, j, k;
+	int i;
 	char *signatures[] = EWRK3_SIGNATURE;
 
-	strcpy(name, "");
-	for (i = 0; *signatures[i] != '\0' && *name == '\0'; i++) {
-		for (j = EEPROM_PNAME7, k = 0; j <= EEPROM_PNAME0 && k < strlen(signatures[i]); j++) {
-			if (signatures[i][k] == eeprom_image[j]) {	/* track signature */
-				k++;
-			} else {	/* lost signature; begin search again */
-				k = 0;
-			}
-		}
-		if (k == strlen(signatures[i])) {
-			for (k = 0; k < EWRK3_STRLEN; k++) {
-				name[k] = eeprom_image[EEPROM_PNAME7 + k];
-				name[EWRK3_STRLEN] = '\0';
-			}
-		}
-	}
+	for (i=0; *signatures[i] != '\0'; i++)
+		if( !strncmp(eeprom_image+EEPROM_PNAME7, signatures[i], strlen(signatures[i])) )
+			break;
 
-	return;			/* return the device name string */
+	if (*signatures[i] != '\0') {
+		memcpy(name, eeprom_image+EEPROM_PNAME7, EWRK3_STRLEN);
+		name[EWRK3_STRLEN] = '\0';
+	} else
+		name[0] = '\0';
+
+	return;
 }
 
 /*

