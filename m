Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262202AbUCGQNs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Mar 2004 11:13:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262207AbUCGQNs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Mar 2004 11:13:48 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:14599 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262202AbUCGQNp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Mar 2004 11:13:45 -0500
Date: Sun, 7 Mar 2004 16:13:41 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>
Subject: [PATCH] Fix i2c_use_client()
Message-ID: <20040307161341.A7065@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>,
	Greg KH <greg@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i2c_use_client() contains a bogosity.  If i2c_inc_use_client() returns
success, i2c_use_client() returns an error.  If i2c_inc_use_client()
fails, i2c_use_client() might succeed.

Fix it so that (a) we get the correct sense between these two functions,
and (b) propagate the error code from i2c_inc_use_client(), rather than
making our own one up.

--- orig/drivers/i2c/i2c-core.c	Wed Feb 18 22:33:49 2004
+++ linux/drivers/i2c/i2c-core.c	Sun Mar  7 16:05:27 2004
@@ -437,8 +437,11 @@ static void i2c_dec_use_client(struct i2
 
 int i2c_use_client(struct i2c_client *client)
 {
-	if (!i2c_inc_use_client(client))
-		return -ENODEV;
+	int ret;
+
+	ret = i2c_inc_use_client(client);
+	if (ret)
+		return ret;
 
 	if (client->flags & I2C_CLIENT_ALLOW_USE) {
 		if (client->flags & I2C_CLIENT_ALLOW_MULTIPLE_USE)

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
