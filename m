Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265086AbUFVR5U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265086AbUFVR5U (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 13:57:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265095AbUFVRyL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 13:54:11 -0400
Received: from mail.kroah.org ([65.200.24.183]:51893 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265088AbUFVRnm convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 13:43:42 -0400
X-Donotread: and you are reading this why?
Subject: Re: [PATCH] Driver Core patches for 2.6.7
In-Reply-To: <1087926112482@kroah.com>
X-Patch: quite boring stuff, it's just source code...
Date: Tue, 22 Jun 2004 10:41:52 -0700
Message-Id: <10879261122448@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1722.111.23, 2004/06/10 12:52:02-07:00, greg@kroah.com

I2C: sparse cleanups for drivers/i2c/*

Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/i2c/chips/it87.c |    5 ++++-
 drivers/i2c/i2c-dev.c    |    7 +++----
 2 files changed, 7 insertions(+), 5 deletions(-)


diff -Nru a/drivers/i2c/chips/it87.c b/drivers/i2c/chips/it87.c
--- a/drivers/i2c/chips/it87.c	Tue Jun 22 09:47:03 2004
+++ b/drivers/i2c/chips/it87.c	Tue Jun 22 09:47:03 2004
@@ -170,8 +170,11 @@
 static int DIV_TO_REG(int val)
 {
 	int answer = 0;
-	while ((val >>= 1))
+	val >>= 1;
+	while (val) {
 		answer++;
+		val >>= 1;
+	}
 	return answer;
 }
 #define DIV_FROM_REG(val) (1 << (val))
diff -Nru a/drivers/i2c/i2c-dev.c b/drivers/i2c/i2c-dev.c
--- a/drivers/i2c/i2c-dev.c	Tue Jun 22 09:47:03 2004
+++ b/drivers/i2c/i2c-dev.c	Tue Jun 22 09:47:03 2004
@@ -181,7 +181,7 @@
 	struct i2c_smbus_ioctl_data data_arg;
 	union i2c_smbus_data temp;
 	struct i2c_msg *rdwr_pa;
-	u8 **data_ptrs;
+	u8 __user **data_ptrs;
 	int i,datasize,res;
 	unsigned long funcs;
 
@@ -238,8 +238,7 @@
 			return -EFAULT;
 		}
 
-		data_ptrs = (u8 **) kmalloc(rdwr_arg.nmsgs * sizeof(u8 *),
-					    GFP_KERNEL);
+		data_ptrs = kmalloc(rdwr_arg.nmsgs * sizeof(u8 __user *), GFP_KERNEL);
 		if (data_ptrs == NULL) {
 			kfree(rdwr_pa);
 			return -ENOMEM;
@@ -252,7 +251,7 @@
 				res = -EINVAL;
 				break;
 			}
-			data_ptrs[i] = rdwr_pa[i].buf;
+			data_ptrs[i] = (u8 __user *)rdwr_pa[i].buf;
 			rdwr_pa[i].buf = kmalloc(rdwr_pa[i].len, GFP_KERNEL);
 			if(rdwr_pa[i].buf == NULL) {
 				res = -ENOMEM;

