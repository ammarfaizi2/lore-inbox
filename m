Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261372AbUKIF1x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261372AbUKIF1x (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 00:27:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261369AbUKIF0X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 00:26:23 -0500
Received: from mail.kroah.org ([69.55.234.183]:49054 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261370AbUKIFYx convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 00:24:53 -0500
Subject: Re: [PATCH] I2C update for 2.6.10-rc1
In-Reply-To: <10999778574012@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 8 Nov 2004 21:24:17 -0800
Message-Id: <10999778572385@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2014.1.21, 2004/11/08 16:45:21-08:00, khali@linux-fr.org

[PATCH] I2C: Check for unregistered adapter in i2c_del_adapter

The patch adds a check at the beginning of i2c_del_adapter in case
someone attempts to remove an adapter that was never added in the first
place. This sounds like a good safety, as doing so will lead to an oops
at the moment. Also, I have a need for it in the latest version of my
i2c-amd756-s4882 patch. I need to remove the original adapter and
install the virtual ones instead, but I have no way to know if the
original adapter was succesfully added beforehand or not.


Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/i2c/i2c-core.c |   13 +++++++++++++
 1 files changed, 13 insertions(+)


diff -Nru a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
--- a/drivers/i2c/i2c-core.c	2004-11-08 18:54:39 -08:00
+++ b/drivers/i2c/i2c-core.c	2004-11-08 18:54:39 -08:00
@@ -177,11 +177,24 @@
 int i2c_del_adapter(struct i2c_adapter *adap)
 {
 	struct list_head  *item, *_n;
+	struct i2c_adapter *adap_from_list;
 	struct i2c_driver *driver;
 	struct i2c_client *client;
 	int res = 0;
 
 	down(&core_lists);
+
+	/* First make sure that this adapter was ever added */
+	list_for_each_entry(adap_from_list, &adapters, list) {
+		if (adap_from_list == adap)
+			break;
+	}
+	if (adap_from_list != adap) {
+		pr_debug("I2C: Attempting to delete an unregistered "
+			 "adapter\n");
+		res = -EINVAL;
+		goto out_unlock;
+	}
 
 	list_for_each(item,&drivers) {
 		driver = list_entry(item, struct i2c_driver, list);

