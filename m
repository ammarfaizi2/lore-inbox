Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262053AbVEDHeE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262053AbVEDHeE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 03:34:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262068AbVEDHd0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 03:33:26 -0400
Received: from smtp.seznam.cz ([212.80.76.43]:12218 "HELO smtp.seznam.cz")
	by vger.kernel.org with SMTP id S262072AbVEDHaL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 03:30:11 -0400
Date: Wed, 4 May 2005 08:14:38 +0200
To: Greg KH <greg@kroah.com>
Cc: Jean Delvare <khali@linux-fr.org>, LKML <linux-kernel@vger.kernel.org>,
       LM Sensors <sensors@Stimpy.netroedge.com>,
       James Chapman <jchapman@katalix.com>
Subject: [PATCH] ds1337 3/3
Message-ID: <20050504061438.GD1439@orphique>
References: <20050407231848.GD27226@orphique> <u5mZNEX1.1112954918.3200720.khali@localhost> <20050408130639.GC7054@orphique> <20050502204136.GE32713@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050502204136.GE32713@kroah.com>
User-Agent: Mutt/1.5.9i
From: Ladislav Michl <ladis@linux-mips.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chip is searched by bus number rather than its own proprietary id.

Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
Signed-off-by: James Chapman <jchapman@katalix.com>

--- linux-omap/drivers/i2c/chips/ds1337.c.orig	2005-04-20 20:34:31.622721568 +0200
+++ linux-omap/drivers/i2c/chips/ds1337.c	2005-04-20 20:50:05.043819992 +0200
@@ -69,13 +69,11 @@
 struct ds1337_data {
 	struct i2c_client client;
 	struct list_head list;
-	int id;
 };
 
 /*
  * Internal variables
  */
-static int ds1337_id;
 static LIST_HEAD(ds1337_clients);
 
 static inline int ds1337_read(struct i2c_client *client, u8 reg, u8 *value)
@@ -213,7 +211,7 @@
  * Public API for access to specific device. Useful for low-level
  * RTC access from kernel code.
  */
-int ds1337_do_command(int id, int cmd, void *arg)
+int ds1337_do_command(int bus, int cmd, void *arg)
 {
 	struct list_head *walk;
 	struct list_head *tmp;
@@ -221,7 +219,7 @@
 
 	list_for_each_safe(walk, tmp, &ds1337_clients) {
 		data = list_entry(walk, struct ds1337_data, list);
-		if (data->id == id)
+		if (data->client.adapter->nr == bus)
 			return ds1337_command(&data->client, cmd, arg);
 	}
 
@@ -331,7 +329,6 @@
 	ds1337_init_client(new_client);
 
 	/* Add client to local list */
-	data->id = ds1337_id++;
 	list_add(&data->list, &ds1337_clients);
 
 	return 0;
