Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262971AbUCPDEl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 22:04:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262963AbUCPDCR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 22:02:17 -0500
Received: from mail.kroah.org ([65.200.24.183]:22191 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262896AbUCPACW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 19:02:22 -0500
Subject: Re: [PATCH] i2c driver fixes for 2.6.4
In-Reply-To: <10793913931477@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 15 Mar 2004 14:56:33 -0800
Message-Id: <10793913932181@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1608.74.3, 2004/03/09 14:58:25-08:00, rmk+lkml@arm.linux.org.uk

[PATCH] I2C: Fix i2c_use_client()

i2c_use_client() contains a bogosity.  If i2c_inc_use_client() returns
success, i2c_use_client() returns an error.  If i2c_inc_use_client()
fails, i2c_use_client() might succeed.

Fix it so that (a) we get the correct sense between these two functions,
and (b) propagate the error code from i2c_inc_use_client(), rather than
making our own one up.


 drivers/i2c/i2c-core.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)


diff -Nru a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
--- a/drivers/i2c/i2c-core.c	Mon Mar 15 14:35:07 2004
+++ b/drivers/i2c/i2c-core.c	Mon Mar 15 14:35:07 2004
@@ -437,8 +437,11 @@
 
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

