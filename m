Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161185AbWI1Vys@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161185AbWI1Vys (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 17:54:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161193AbWI1Vys
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 17:54:48 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:46533 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1161185AbWI1Vyq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 17:54:46 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=jCDIELLKSH9RfRF28iRFE5ISnUacZoVN/UO9Uzyjp54LyjLt+/wMuDnWt50zEUSm5Rs8sZ+ygiDHW4pj3AlhmPb29NriuNsThZEOobPqV87vDtpdPxjvTHJyjtESXl6cwazb5HnfW6Ok+wZTPC7MV7rUqXa5c8469DfikimlAGc=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH] Don't leak 'old_class_name' in drivers/base/core.c::device_rename()
Date: Thu, 28 Sep 2006 23:56:01 +0200
User-Agent: KMail/1.9.4
Cc: linux-kernel@vger.kernel.org, Patrick Mochel <mochel@osdl.org>,
       Patrick Mochel <mochel@infinity.powertie.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609282356.01962.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If kmalloc() fails to allocate space for 'old_symlink_name' in
drivers/base/core.c::device_rename(), then we'll leak 'old_class_name'.

Spotted by the Coverity checker.


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 drivers/base/core.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

--- linux-2.6.18-git10-orig/drivers/base/core.c	2006-09-28 22:39:53.000000000 +0200
+++ linux-2.6.18-git10/drivers/base/core.c	2006-09-28 23:48:51.000000000 +0200
@@ -805,8 +805,10 @@ int device_rename(struct device *dev, ch
 
 	if (dev->class) {
 		old_symlink_name = kmalloc(BUS_ID_SIZE, GFP_KERNEL);
-		if (!old_symlink_name)
-			return -ENOMEM;
+		if (!old_symlink_name) {
+			error = -ENOMEM;
+			goto out_free_old_class;
+		}
 		strlcpy(old_symlink_name, dev->bus_id, BUS_ID_SIZE);
 	}
 
@@ -830,9 +832,10 @@ int device_rename(struct device *dev, ch
 	}
 	put_device(dev);
 
-	kfree(old_class_name);
 	kfree(new_class_name);
 	kfree(old_symlink_name);
+ out_free_old_class:
+	kfree(old_class_name);
 
 	return error;
 }

