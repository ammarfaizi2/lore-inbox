Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132343AbRAXOSw>; Wed, 24 Jan 2001 09:18:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132380AbRAXOSk>; Wed, 24 Jan 2001 09:18:40 -0500
Received: from smtp1.mail.yahoo.com ([128.11.69.60]:4111 "HELO
	smtp1.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S132315AbRAXOSZ>; Wed, 24 Jan 2001 09:18:25 -0500
X-Apparently-From: <p?gortmaker@yahoo.com>
Message-ID: <3A6EDDD3.1509716C@yahoo.com>
Date: Wed, 24 Jan 2001 08:51:15 -0500
From: Paul Gortmaker <p_gortmaker@yahoo.com>
X-Mailer: Mozilla 3.04 (X11; I; Linux 2.4.1-pre8 i486)
MIME-Version: 1.0
To: fero@drama.obuda.kando.hu
CC: geert@linux-m68k.org, linux-kernel@vger.kernel.org
Subject: [PATCH]: hgafb crash on MDA only cards
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Current (2.4.0pre8) hgafb will misdetect MDA only cards and
then crash - last message briefly seen before screen clears is

hgafb: <NULL> with 32K of memory detected.

A comparison to the detection code in XFree86 shows that hgafb 
forgets to return failure if the status port doesn't show 
any active changes associated with counting vertical syncs.

Paul.

--- drivers/video/hgafb.c~	Sun Aug 20 03:06:13 2000
+++ drivers/video/hgafb.c	Tue Jan 23 13:38:12 2001
@@ -7,6 +7,8 @@
  *
  * History:
  *
+ * - Revision 0.1.7 (23 Jan 2001): fix crash resulting from MDA only cards 
+ *				   being detected as Hercules.	 (Paul G.)
  * - Revision 0.1.6 (17 Aug 2000): new style structs
  *                                 documentation
  * - Revision 0.1.5 (13 Mar 2000): spinlocks instead of saveflags();cli();etc
@@ -358,21 +360,22 @@
 		udelay(2);
 	}
 
-	if (p_save != q_save) {
-		switch (inb_p(HGA_STATUS_PORT) & 0x70) {
-			case 0x10:
-				hga_type = TYPE_HERCPLUS;
-				hga_type_name = "HerculesPlus";
-				break;
-			case 0x50:
-				hga_type = TYPE_HERCCOLOR;
-				hga_type_name = "HerculesColor";
-				break;
-			default:
-				hga_type = TYPE_HERC;
-				hga_type_name = "Hercules";
-				break;
-		}
+	if (p_save == q_save) 
+		return 0;
+
+	switch (inb_p(HGA_STATUS_PORT) & 0x70) {
+		case 0x10:
+			hga_type = TYPE_HERCPLUS;
+			hga_type_name = "HerculesPlus";
+			break;
+		case 0x50:
+			hga_type = TYPE_HERCCOLOR;
+			hga_type_name = "HerculesColor";
+			break;
+		default:
+			hga_type = TYPE_HERC;
+			hga_type_name = "Hercules";
+			break;
 	}
 	return 1;
 }





_________________________________________________________
Do You Yahoo!?
Get your free @yahoo.com address at http://mail.yahoo.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
