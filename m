Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264520AbTDXXvh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 19:51:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264513AbTDXXvN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 19:51:13 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:49309 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264545AbTDXXpG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 19:45:06 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <1051228746305@kroah.com>
Subject: Re: [PATCH] i2c driver changes for 2.5.68
In-Reply-To: <10512287461640@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 24 Apr 2003 16:59:06 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1179.3.7, 2003/04/24 11:13:08-07:00, greg@kroah.com

[PATCH] i2c: removed unused flags paramater in found_proc callback.


 drivers/i2c/i2c-core.c |    8 ++++----
 include/linux/i2c.h    |    5 +----
 2 files changed, 5 insertions(+), 8 deletions(-)


diff -Nru a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
--- a/drivers/i2c/i2c-core.c	Thu Apr 24 16:46:44 2003
+++ b/drivers/i2c/i2c-core.c	Thu Apr 24 16:46:44 2003
@@ -618,8 +618,8 @@
  * ----------------------------------------------------
  */
 int i2c_probe(struct i2c_adapter *adapter,
-                   struct i2c_client_address_data *address_data,
-                   i2c_client_found_addr_proc *found_proc)
+	      struct i2c_client_address_data *address_data,
+	      int (*found_proc) (struct i2c_adapter *, int, int))
 {
 	int addr,i,found,err;
 	int adap_id = i2c_adapter_id(adapter);
@@ -644,7 +644,7 @@
 			     (addr == address_data->force[i+1])) {
 				DEB2(printk(KERN_DEBUG "i2c-core.o: found force parameter for adapter %d, addr %04x\n",
 				            adap_id,addr));
-				if ((err = found_proc(adapter,addr,0,0)))
+				if ((err = found_proc(adapter,addr,0)))
 					return err;
 				found = 1;
 			}
@@ -732,7 +732,7 @@
 		/* OK, so we really should examine this address. First check
 		   whether there is some client here at all! */
 		if (i2c_smbus_xfer(adapter,addr,0,0,0,I2C_SMBUS_QUICK,NULL) >= 0)
-			if ((err = found_proc(adapter,addr,0,-1)))
+			if ((err = found_proc(adapter,addr,-1)))
 				return err;
 	}
 	return 0;
diff -Nru a/include/linux/i2c.h b/include/linux/i2c.h
--- a/include/linux/i2c.h	Thu Apr 24 16:46:44 2003
+++ b/include/linux/i2c.h	Thu Apr 24 16:46:44 2003
@@ -338,12 +338,9 @@
  * It will only call found_proc if some client is connected at the
  * specific address (unless a 'force' matched);
  */
-typedef int i2c_client_found_addr_proc (struct i2c_adapter *adapter,
-                                     int addr, unsigned short flags,int kind);
-
 extern int i2c_probe(struct i2c_adapter *adapter, 
 		struct i2c_client_address_data *address_data,
-		i2c_client_found_addr_proc *found_proc);
+		int (*found_proc) (struct i2c_adapter *, int, int));
 
 /* An ioctl like call to set div. parameters of the adapter.
  */

