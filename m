Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261966AbUCBVmr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 16:42:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261950AbUCBVme
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 16:42:34 -0500
Received: from gate.crashing.org ([63.228.1.57]:39875 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261916AbUCBVmI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 16:42:08 -0500
Subject: [PATCH] ppc32: Fix crash on load  in DACA sound driver
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1078263053.21573.176.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 03 Mar 2004 08:30:54 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

The DACA sound driver (early iBook models) doesn't clear the i2c_client
structure. That cause the embedded struct device (and thus kobject) to
contain garbage in the "k_name" field, which kobject_set_name will
later try to kfree... 
Also removes references to unused struct data_data.

===== sound/oss/dmasound/dac3550a.c 1.2 vs edited =====
--- 1.2/sound/oss/dmasound/dac3550a.c	Tue Sep 30 10:25:28 2003
+++ edited/sound/oss/dmasound/dac3550a.c	Tue Mar  2 21:32:04 2004
@@ -42,11 +42,6 @@
 /* Unique ID allocation */
 static int daca_id;
 
-struct daca_data
-{
-	int arf; /* place holder for furture use */
-};
-
 struct i2c_driver daca_driver = {  
 	.owner			= THIS_MODULE,
 	.name			= "DAC3550A driver  V " DACA_VERSION,
@@ -168,12 +163,12 @@
 {
 	const char *client_name = "DAC 3550A Digital Equalizer";
 	struct i2c_client *new_client;
-	struct daca_data *data;
 	int rc = -ENODEV;
 
-	new_client = kmalloc(sizeof(*new_client) + sizeof(*data), GFP_KERNEL);
+	new_client = kmalloc(sizeof(*new_client), GFP_KERNEL);
 	if (!new_client)
 		return -ENOMEM;
+	memset(new_client, 0, sizeof(*new_client));
 
 	new_client->addr = address;
 	new_client->adapter = adapter;
@@ -181,9 +176,6 @@
 	new_client->flags = 0;
 	strcpy(new_client->name, client_name);
 	new_client->id = daca_id++; /* racy... */
-
-	data = (struct daca_data *)(new_client+1);
-	dev_set_drvdata(&new_client->dev, data);
 
 	if (daca_init_client(new_client))
 		goto bail;


