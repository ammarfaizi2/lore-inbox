Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262007AbUDNWhW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 18:37:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262009AbUDNWfV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 18:35:21 -0400
Received: from mail.kroah.org ([65.200.24.183]:59551 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262008AbUDNWZ2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 18:25:28 -0400
Subject: Re: [PATCH] I2C update for 2.6.5
In-Reply-To: <10819814523538@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 14 Apr 2004 15:24:12 -0700
Message-Id: <10819814521837@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1643.36.24, 2004/04/12 15:15:36-07:00, khali@linux-fr.org

[PATCH] I2C: Error paths in it87 and via686a drivers

Here comes the patch that fixes error paths in the it87 and via686a
detection functions. The it87 part also adds missing error values.


 drivers/i2c/chips/it87.c    |   33 ++++++++++++++++++---------------
 drivers/i2c/chips/via686a.c |    2 +-
 2 files changed, 19 insertions(+), 16 deletions(-)


diff -Nru a/drivers/i2c/chips/it87.c b/drivers/i2c/chips/it87.c
--- a/drivers/i2c/chips/it87.c	Wed Apr 14 15:12:51 2004
+++ b/drivers/i2c/chips/it87.c	Wed Apr 14 15:12:51 2004
@@ -533,12 +533,12 @@
 			/* We need the timeouts for at least some IT87-like chips. But only
 			   if we read 'undefined' registers. */
 			i = inb_p(address + 1);
-			if (inb_p(address + 2) != i)
-				goto ERROR1;
-			if (inb_p(address + 3) != i)
-				goto ERROR1;
-			if (inb_p(address + 7) != i)
+			if (inb_p(address + 2) != i
+			 || inb_p(address + 3) != i
+			 || inb_p(address + 7) != i) {
+		 		err = -ENODEV;
 				goto ERROR1;
+			}
 #undef REALLY_SLOW_IO
 
 			/* Let's just hope nothing breaks here */
@@ -546,7 +546,8 @@
 			outb_p(~i & 0x7f, address + 5);
 			if ((inb_p(address + 5) & 0x7f) != (~i & 0x7f)) {
 				outb_p(i, address + 5);
-				return 0;
+				err = -ENODEV;
+				goto ERROR1;
 			}
 		}
 	}
@@ -573,11 +574,12 @@
 	/* Now, we do the remaining detection. */
 
 	if (kind < 0) {
-		if (it87_read_value(new_client, IT87_REG_CONFIG) & 0x80)
-			goto ERROR1;
-		if (!is_isa
-			&& (it87_read_value(new_client, IT87_REG_I2C_ADDR) !=
-			address)) goto ERROR1;
+		if ((it87_read_value(new_client, IT87_REG_CONFIG) & 0x80)
+		  || (!is_isa
+		   && it87_read_value(new_client, IT87_REG_I2C_ADDR) != address)) {
+		   	err = -ENODEV;
+			goto ERROR2;
+		}
 	}
 
 	/* Determine the chip type. */
@@ -592,7 +594,8 @@
 					"Ignoring 'force' parameter for unknown chip at "
 					"adapter %d, address 0x%02x\n",
 					i2c_adapter_id(adapter), address);
-			goto ERROR1;
+			err = -ENODEV;
+			goto ERROR2;
 		}
 	}
 
@@ -611,7 +614,7 @@
 
 	/* Tell the I2C layer a new client has arrived */
 	if ((err = i2c_attach_client(new_client)))
-		goto ERROR1;
+		goto ERROR2;
 
 	/* Initialize the IT87 chip */
 	it87_init_client(new_client, data);
@@ -667,9 +670,9 @@
 
 	return 0;
 
-ERROR1:
+ERROR2:
 	kfree(data);
-
+ERROR1:
 	if (is_isa)
 		release_region(address, IT87_EXTENT);
 ERROR0:
diff -Nru a/drivers/i2c/chips/via686a.c b/drivers/i2c/chips/via686a.c
--- a/drivers/i2c/chips/via686a.c	Wed Apr 14 15:12:51 2004
+++ b/drivers/i2c/chips/via686a.c	Wed Apr 14 15:12:51 2004
@@ -748,9 +748,9 @@
 	return 0;
 
       ERROR3:
-	release_region(address, VIA686A_EXTENT);
 	kfree(data);
       ERROR0:
+	release_region(address, VIA686A_EXTENT);
 	return err;
 }
 

