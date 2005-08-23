Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932087AbVHWNNn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932087AbVHWNNn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 09:13:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751016AbVHWNNn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 09:13:43 -0400
Received: from anubis.fi.muni.cz ([147.251.54.96]:15525 "EHLO
	anubis.fi.muni.cz") by vger.kernel.org with ESMTP id S1750789AbVHWNNn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 09:13:43 -0400
Date: Tue, 23 Aug 2005 15:14:14 +0200
From: Lukas Hejtmanek <xhejtman@mail.muni.cz>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] asus_acpi M6000A model support
Message-ID: <20050823131414.GC12364@mail.muni.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="wzJLGUyc3ArbnUjN"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-echelon: NSA, CIA, CI5, MI5, FBI, KGB, BIS, Plutonium, Bin Laden, bomb
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--wzJLGUyc3ArbnUjN
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hello,

here is patch for Asus M6A laptop support. It works fine for me.

-- 
Luká¹ Hejtmánek

--wzJLGUyc3ArbnUjN
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: attachment; filename=acpi-patch

--- asus_acpi.c.old	2005-04-21 02:03:13.000000000 +0200
+++ asus_acpi.c	2005-05-08 18:22:49.000000000 +0200
@@ -128,6 +128,7 @@
 		L8L,      //L8400L
 		M1A,      //M1300A
 		M2E,      //M2400E, L4400L
+		M6A,      //M6000A
 		M6N,      //M6800N
 		M6R,      //M6700R
 		P30,	  //Samsung P30
@@ -304,7 +305,20 @@
 		.display_set       = "SDSP",
 		.display_get       = "\\INFB"
 	},
-
+	{
+		.name              = "M6A",
+		/* M6A does not have MLED */
+		.mt_wled           = "WLED",
+		.mt_lcd_switch     = xxN_PREFIX "_Q10",
+		.lcd_status        = "\\RGPL",
+		.brightness_set    = "SPLV",
+		.brightness_get    = "GPLV",
+		.display_set       = "SDSP",
+		/* FIXME: this is not correct display_get.
+		 * It always returns 1 
+		 * */
+		.display_get       = "\\ADVG"
+	},
 	{
 		.name              = "M6N",
 		.mt_mled           = "MLED",
@@ -622,7 +636,7 @@
 {
 	int lcd = 0;
 
-	if (hotk->model != L3H) {
+	if (hotk->model != L3H && hotk->model != M6A) {
 	/* We don't have to check anything if we are here */
 		if (!read_acpi_int(NULL, hotk->methods->lcd_status, &lcd))
 			printk(KERN_WARNING "Asus ACPI: Error reading LCD status\n");
@@ -638,22 +652,33 @@
 		
 		input.count = 2;
 		input.pointer = mt_params;
-		/* Note: the following values are partly guessed up, but 
-		   otherwise they seem to work */
 		mt_params[0].type = ACPI_TYPE_INTEGER;
-		mt_params[0].integer.value = 0x02;
 		mt_params[1].type = ACPI_TYPE_INTEGER;
-		mt_params[1].integer.value = 0x02;
+		if(hotk->model == L3H) {
+			/* Note: the following values are partly guessed up, 
+			 * but otherwise they seem to work */
+			mt_params[0].integer.value = 0x02;
+			mt_params[1].integer.value = 0x02;
+		} else if(hotk->model == M6A) {
+			mt_params[0].integer.value = 0x15;
+			mt_params[1].integer.value = 0x01;
+		}
 
 		output.length = sizeof(out_obj);
 		output.pointer = &out_obj;
 		
-		status = acpi_evaluate_object(NULL, hotk->methods->lcd_status, &input, &output);
+		status = acpi_evaluate_object(NULL, hotk->methods->lcd_status, 
+				&input, &output);
 		if (status != AE_OK)
 			return -1;
-		if (out_obj.type == ACPI_TYPE_INTEGER)
-			/* That's what the AML code does */
-			lcd = out_obj.integer.value >> 8;
+		if (out_obj.type == ACPI_TYPE_INTEGER) {
+			if(hotk->model== L3H) {
+				/* That's what the AML code does */
+				lcd = out_obj.integer.value >> 8;
+			} else if(hotk->model == M6A) {
+				lcd = out_obj.integer.value;
+			}
+		}
 	}
 	
 	return (lcd & 1);
@@ -1029,6 +1054,8 @@
 		hotk->model = M6N;
 	else if (strncmp(model->string.pointer, "M6R", 3) == 0)
 		hotk->model = M6R;
+	else if (strncmp(model->string.pointer, "M6A", 3) == 0)
+		hotk->model = M6A;
 	else if (strncmp(model->string.pointer, "M2N", 3) == 0 ||
 		 strncmp(model->string.pointer, "M3N", 3) == 0 ||
 		 strncmp(model->string.pointer, "M5N", 3) == 0 ||
@@ -1058,8 +1085,9 @@
 		hotk->model = L5x;
 
 	if (hotk->model == END_MODEL) {
-		printk("unsupported, trying default values, supply the "
-		       "developers with your DSDT\n");
+		printk("unsupported model %s, trying default values, supply "
+		       "the developers with your DSDT\n", 
+		       model->string.pointer);
 		hotk->model = M2E;
 	} else {
 		printk("supported\n");

--wzJLGUyc3ArbnUjN--
