Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263786AbTDUIIe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 04:08:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263787AbTDUIIe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 04:08:34 -0400
Received: from main.gmane.org ([80.91.224.249]:32965 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S263786AbTDUIIc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 04:08:32 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: "Andres Salomon" <dilinger@voxel.net>
Subject: [PATCH] ppc32 compilation fixes for 2.5.68
Date: Mon, 21 Apr 2003 04:20:31 -0400
Message-ID: <pan.2003.04.21.08.19.15.748399@voxel.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Complaints-To: usenet@main.gmane.org
User-Agent: Pan/0.13.4 (She had eyes like strange sins. (Debian GNU/Linux))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

These patches are mostly simple compilation fixes, needed in order to get
2.5.68 compiling for my ti-book.  The kernel boots up fine w/ them (gnome
is severely broken, but that's a separate issue).

Also, I've submitted these as bugs #609, 610, and 611 to bugme.osdl.org. 
I'm not sure how active developers are w/ that BTS, so I'm posting here as
well, just in case.


--- a/drivers/macintosh/adbhid.c	2003-04-19 22:51:22.000000000 -0400
+++ b/drivers/macintosh/adbhid.c	2003-04-20 21:17:21.000000000 -0400
@@ -84,7 +84,7 @@
 
 static void adbhid_probe(void);
 
-static void adbhid_input_keycode(int, int, int);
+static void adbhid_input_keycode(int, int, int, struct pt_regs*);
 static void leds_done(struct adb_request *);
 
 static void init_trackpad(int id);
@@ -140,7 +140,7 @@
 }
 
 static void
-adbhid_input_keycode(int id, int keycode, int repeat, pt_regs *regs)
+adbhid_input_keycode(int id, int keycode, int repeat, struct pt_regs *regs)
 {
 	int up_flag;
 
diff -urN a/include/asm-ppc/agp.h b/include/asm-ppc/agp.h
--- a/include/asm-ppc/agp.h	1969-12-31 19:00:00.000000000 -0500
+++ b/include/asm-ppc/agp.h	2003-04-20 20:52:15.000000000 -0400
@@ -0,0 +1,11 @@
+#ifndef AGP_H
+#define AGP_H 1
+
+/* dummy for now */
+
+#define map_page_into_agp(page) 
+#define unmap_page_from_agp(page) 
+#define flush_agp_mappings() 
+#define flush_agp_cache() mb()
+
+#endif
--- tmp/linux-2.5.68/sound/ppc/keywest.c	2003-04-19 22:51:12.000000000 -0400
+++ linux-2.5.68/sound/ppc/keywest.c	2003-04-20 21:48:55.000000000 -0400
@@ -57,20 +57,20 @@
 	if (! keywest_ctx)
 		return -EINVAL;
 
-	if (strncmp(adapter->name, "mac-io", 6))
+	if (strncmp(adapter->dev.name, "mac-io", 6))
 		return 0; /* ignored */
 
 	new_client = kmalloc(sizeof(struct i2c_client), GFP_KERNEL);
 	if (! new_client)
 		return -ENOMEM;
 
+	i2c_set_clientdata(new_client, (void *) keywest_ctx);
 	new_client->addr = keywest_ctx->addr;
-	new_client->data = keywest_ctx;
 	new_client->adapter = adapter;
 	new_client->driver = &keywest_driver;
 	new_client->flags = 0;
 
-	strcpy(new_client->name, keywest_ctx->name);
+	strcpy(i2c_clientname(new_client), keywest_ctx->name);
 
 	new_client->id = keywest_ctx->id++; /* Automatically unique */
 	keywest_ctx->client = new_client;


