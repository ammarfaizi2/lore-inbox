Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265121AbTFEVOd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 17:14:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265124AbTFEVNG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 17:13:06 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:33427 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S265092AbTFEUqd convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 16:46:33 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10548465592488@kroah.com>
Subject: Re: [PATCH] i2c driver changes for 2.5.70
In-Reply-To: <1054846559915@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 5 Jun 2003 13:55:59 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1259.3.3, 2003/06/05 12:45:18-07:00, aschultz@warp10.net

[PATCH] I2C: fix unsafe usage of list_for_each in i2c-core

i2c-core.c contains 2 loops that iterate over the list of the clients attached
to an adapter and detaches them. Detaching the clients will actually remove
them from the list the loop is iterating over. Therefore the
list_for_each_safe() method has to be used.


 drivers/i2c/i2c-core.c |    9 ++++-----
 1 files changed, 4 insertions(+), 5 deletions(-)


diff -Nru a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
--- a/drivers/i2c/i2c-core.c	Thu Jun  5 13:50:05 2003
+++ b/drivers/i2c/i2c-core.c	Thu Jun  5 13:50:05 2003
@@ -124,7 +124,7 @@
 
 int i2c_del_adapter(struct i2c_adapter *adap)
 {
-	struct list_head  *item;
+	struct list_head  *item, *_n;
 	struct i2c_driver *driver;
 	struct i2c_client *client;
 	int res = 0;
@@ -144,7 +144,7 @@
 
 	/* detach any active clients. This must be done first, because
 	 * it can fail; in which case we give upp. */
-	list_for_each(item,&adap->clients) {
+	list_for_each_safe(item, _n, &adap->clients) {
 		client = list_entry(item, struct i2c_client, list);
 
 		/* detaching devices is unconditional of the set notify
@@ -215,8 +215,7 @@
 
 int i2c_del_driver(struct i2c_driver *driver)
 {
-	struct list_head   *item1;
-	struct list_head   *item2;
+	struct list_head   *item1, *item2, *_n;
 	struct i2c_client  *client;
 	struct i2c_adapter *adap;
 	
@@ -245,7 +244,7 @@
 				goto out_unlock;
 			}
 		} else {
-			list_for_each(item2,&adap->clients) {
+			list_for_each_safe(item2, _n, &adap->clients) {
 				client = list_entry(item2, struct i2c_client, list);
 				if (client->driver != driver)
 					continue;

