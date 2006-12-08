Return-Path: <linux-kernel-owner+willy=40w.ods.org-S938017AbWLHJQw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S938017AbWLHJQw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Dec 2006 04:16:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S938018AbWLHJQw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 04:16:52 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:45936 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S938017AbWLHJQu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 04:16:50 -0500
Date: Fri, 8 Dec 2006 09:16:49 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] more work_struct mess
Message-ID: <20061208091649.GL4587@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
diff --git a/sound/oss/dmasound/tas3001c.c b/sound/oss/dmasound/tas3001c.c
index f227c9f..2f21a3c 100644
--- a/sound/oss/dmasound/tas3001c.c
+++ b/sound/oss/dmasound/tas3001c.c
@@ -50,6 +50,7 @@ struct tas3001c_data_t {
 	int output_id;
 	int speaker_id;
 	struct tas_drce_t drce_state;
+	struct work_struct change;
 };
 
 
@@ -667,14 +668,13 @@ tas3001c_update_device_parameters(struct
 }
 
 static void
-tas3001c_device_change_handler(void *self)
+tas3001c_device_change_handler(struct work_struct *work)
 {
-	if (self)
-		tas3001c_update_device_parameters(self);
+	struct tas3001c_data_t *self;
+	self = container_of(work, struct tas3001c_data_t, change);
+	tas3001c_update_device_parameters(self);
 }
 
-static struct work_struct device_change;
-
 static int
 tas3001c_output_device_change(	struct tas3001c_data_t *self,
 				int device_id,
@@ -685,7 +685,7 @@ tas3001c_output_device_change(	struct ta
 	self->output_id=output_id;
 	self->speaker_id=speaker_id;
 
-	schedule_work(&device_change);
+	schedule_work(&self->change);
 	return 0;
 }
 
@@ -823,7 +823,7 @@ tas3001c_init(struct i2c_client *client)
 			tas3001c_write_biquad_shadow(self, i, j,
 				&tas3001c_eq_unity);
 
-	INIT_WORK(&device_change, tas3001c_device_change_handler, self);
+	INIT_WORK(&self->change, tas3001c_device_change_handler);
 	return 0;
 }
 
diff --git a/sound/oss/dmasound/tas3004.c b/sound/oss/dmasound/tas3004.c
index 82eaaca..af34fb3 100644
--- a/sound/oss/dmasound/tas3004.c
+++ b/sound/oss/dmasound/tas3004.c
@@ -48,6 +48,7 @@ struct tas3004_data_t {
 	int output_id;
 	int speaker_id;
 	struct tas_drce_t drce_state;
+	struct work_struct change;
 };
 
 #define MAKE_TIME(sec,usec) (((sec)<<12) + (50000+(usec/10)*(1<<12))/100000)
@@ -914,15 +915,13 @@ tas3004_update_device_parameters(struct 
 }
 
 static void
-tas3004_device_change_handler(void *self)
+tas3004_device_change_handler(struct work_struct *work)
 {
-	if (!self) return;
-
-	tas3004_update_device_parameters((struct tas3004_data_t *)self);
+	struct tas3004_data_t *self;
+	self = container_of(work, struct tas3004_data_t, change);
+	tas3004_update_device_parameters(self);
 }
 
-static struct work_struct device_change;
-
 static int
 tas3004_output_device_change(	struct tas3004_data_t *self,
 				int device_id,
@@ -933,7 +932,7 @@ tas3004_output_device_change(	struct tas
 	self->output_id=output_id;
 	self->speaker_id=speaker_id;
 
-	schedule_work(&device_change);
+	schedule_work(&self->change);
 
 	return 0;
 }
@@ -1112,7 +1111,7 @@ tas3004_init(struct i2c_client *client)
 	tas3004_write_register(self, TAS3004_REG_MCR2, &mcr2, WRITE_SHADOW);
 	tas3004_write_register(self, TAS3004_REG_DRC, drce_init, WRITE_SHADOW);
 
-	INIT_WORK(&device_change, tas3004_device_change_handler, self);
+	INIT_WORK(&self->change, tas3004_device_change_handler);
 	return 0;
 }
 
