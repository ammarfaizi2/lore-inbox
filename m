Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264865AbTFESey (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 14:34:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264840AbTFESey
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 14:34:54 -0400
Received: from [213.187.75.233] ([213.187.75.233]:10415 "EHLO hwinkel")
	by vger.kernel.org with ESMTP id S264865AbTFESex (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 14:34:53 -0400
From: Andreas Schultz <aschultz@warp10.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH][I2C] fix unsafe usage of list_for_each in i2c-core
Date: Thu, 5 Jun 2003 20:48:21 +0200
User-Agent: KMail/1.5.2
Cc: greg@kroah.com
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200306052048.21409.aschultz@warp10.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

i2c-core.c contains 2 loops that iterate over the list of the clients attached 
to an adapter and detaches them. Detaching the clients will actually remove 
them from the list the loop is iterating over. Therefore the 
list_for_each_safe() method has to be used.

Andreas

===== i2c-core.c 1.38 vs edited =====
--- 1.38/drivers/i2c/i2c-core.c	Mon May 26 02:00:00 2003
+++ edited/i2c-core.c	Thu Jun  5 15:48:40 2003
@@ -124,7 +125,7 @@
 
 int i2c_del_adapter(struct i2c_adapter *adap)
 {
-	struct list_head  *item;
+	struct list_head  *item, *_n;
 	struct i2c_driver *driver;
 	struct i2c_client *client;
 	int res = 0;
@@ -144,7 +145,7 @@
 
 	/* detach any active clients. This must be done first, because
 	 * it can fail; in which case we give upp. */
-	list_for_each(item,&adap->clients) {
+	list_for_each_safe(item, _n, &adap->clients) {
 		client = list_entry(item, struct i2c_client, list);
 
 		/* detaching devices is unconditional of the set notify
@@ -215,8 +216,7 @@
 
 int i2c_del_driver(struct i2c_driver *driver)
 {
-	struct list_head   *item1;
-	struct list_head   *item2;
+	struct list_head   *item1, *item2, *_n;
 	struct i2c_client  *client;
 	struct i2c_adapter *adap;
 	
@@ -245,7 +245,7 @@
 				goto out_unlock;
 			}
 		} else {
-			list_for_each(item2,&adap->clients) {
+			list_for_each_safe(item2, _n, &adap->clients) {
 				client = list_entry(item2, struct i2c_client, list);
 				if (client->driver != driver)
 					continue;

