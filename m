Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262951AbUCPBLS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 20:11:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262949AbUCPAD1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 19:03:27 -0500
Received: from mail.kroah.org ([65.200.24.183]:2223 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262872AbUCPABz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 19:01:55 -0500
Subject: Re: [PATCH] i2c driver fixes for 2.6.4
In-Reply-To: <1079391393850@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 15 Mar 2004 14:56:33 -0800
Message-Id: <10793913931516@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1597.1.13, 2004/03/03 15:31:01-08:00, greg@kroah.com

[PATCH] I2C: keep i2c-dev numbers in sync with i2c adapter numbers

This makes userspace tools easier to figure out which i2c-dev device is
assigned to which i2c adapter.

Yes, we can overflow the i2c dev array right now, but that would take a
lot of i2c adapter modprobe/rmmod cycles.  That will be fixed up soon.


 drivers/i2c/i2c-dev.c |   29 ++++++++++++-----------------
 1 files changed, 12 insertions(+), 17 deletions(-)


diff -Nru a/drivers/i2c/i2c-dev.c b/drivers/i2c/i2c-dev.c
--- a/drivers/i2c/i2c-dev.c	Mon Mar 15 14:35:25 2004
+++ b/drivers/i2c/i2c-dev.c	Mon Mar 15 14:35:25 2004
@@ -72,24 +72,18 @@
 struct i2c_dev *i2c_dev_get_by_adapter(struct i2c_adapter *adap)
 {
 	struct i2c_dev *i2c_dev = NULL;
-	int i;
 
 	spin_lock(&i2c_dev_array_lock);
-	for (i = 0; i < I2C_MINORS; ++i) {
-		if ((i2c_dev_array[i]) &&
-		    (i2c_dev_array[i]->adap == adap)) {
-			i2c_dev = i2c_dev_array[i];
-			break;
-		}
-	}
+	if ((i2c_dev_array[adap->nr]) &&
+	    (i2c_dev_array[adap->nr]->adap == adap))
+		i2c_dev = i2c_dev_array[adap->nr];
 	spin_unlock(&i2c_dev_array_lock);
 	return i2c_dev;
 }
 
-static struct i2c_dev *get_free_i2c_dev(void)
+static struct i2c_dev *get_free_i2c_dev(struct i2c_adapter *adap)
 {
 	struct i2c_dev *i2c_dev;
-	unsigned int i;
 
 	i2c_dev = kmalloc(sizeof(*i2c_dev), GFP_KERNEL);
 	if (!i2c_dev)
@@ -97,15 +91,16 @@
 	memset(i2c_dev, 0x00, sizeof(*i2c_dev));
 
 	spin_lock(&i2c_dev_array_lock);
-	for (i = 0; i < I2C_MINORS; ++i) {
-		if (i2c_dev_array[i])
-			continue;
-		i2c_dev->minor = i;
-		i2c_dev_array[i] = i2c_dev;
+	if (i2c_dev_array[adap->nr]) {
 		spin_unlock(&i2c_dev_array_lock);
-		return i2c_dev;
+		dev_err(&adap->dev, "i2c-dev already has a device assigned to this adapter\n");
+		goto error;
 	}
+	i2c_dev->minor = adap->nr;
+	i2c_dev_array[adap->nr] = i2c_dev;
 	spin_unlock(&i2c_dev_array_lock);
+	return i2c_dev;
+error:
 	kfree(i2c_dev);
 	return ERR_PTR(-ENODEV);
 }
@@ -446,7 +441,7 @@
 	struct i2c_dev *i2c_dev;
 	int retval;
 
-	i2c_dev = get_free_i2c_dev();
+	i2c_dev = get_free_i2c_dev(adap);
 	if (IS_ERR(i2c_dev))
 		return PTR_ERR(i2c_dev);
 

