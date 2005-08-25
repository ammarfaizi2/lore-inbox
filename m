Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964796AbVHYVka@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964796AbVHYVka (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 17:40:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964855AbVHYVka
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 17:40:30 -0400
Received: from wproxy.gmail.com ([64.233.184.197]:8968 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964796AbVHYVk2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 17:40:28 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=h8QwLPbJJSqfSwLe8Qz4PfmljE5EDgZ6qLe+kskH/Q2/v8I4TTWw3lDXPKdcB+HdZwPMbeJoidmnqXkEhD0sn+RLNxpUMFvV4ygZcKxjBferup27pVWFDpqOhSpcdI8jCf3YANM/3EJH6aBkKPD8Q+Qv1ygWm2emCeVNyJmU7fM=
Date: Fri, 26 Aug 2005 01:49:14 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Greg Kroah-Hartman <greg@kroah.com>, Jean Delvare <khali@linux-fr.org>
Cc: torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       lm-sensors@lm-sensors.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH] drivers/hwmon/*: kfree() correct pointers
Message-ID: <20050825214913.GA31605@mipter.zuzino.mipt.ru>
References: <20050825205629.22372.qmail@lwn.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050825205629.22372.qmail@lwn.net>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The adm9240 driver, in adm9240_detect(), allocates a structure.  The
error path attempts to kfree() ->client field of it (second one),
resulting in an oops (or slab corruption) if the hardware is not present.

->client field in adm1026, adm1031, smsc47b397 and smsc47m1 is the first in
${HWMON}_data structure, but fix them too.

Signed-off-by: Jonathan Corbet <corbet@lwn.net
Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 drivers/hwmon/adm1026.c    |    2 +-
 drivers/hwmon/adm1031.c    |    2 +-
 drivers/hwmon/adm9240.c    |    2 +-
 drivers/hwmon/smsc47b397.c |    2 +-
 drivers/hwmon/smsc47m1.c   |    2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff -uprN linux-vanilla/drivers/hwmon/adm1026.c linux-hwmon/drivers/hwmon/adm1026.c
--- linux-vanilla/drivers/hwmon/adm1026.c	2005-08-25 18:57:18.000000000 +0400
+++ linux-hwmon/drivers/hwmon/adm1026.c	2005-08-26 01:16:07.000000000 +0400
@@ -1691,7 +1691,7 @@ int adm1026_detect(struct i2c_adapter *a
 
 	/* Error out and cleanup code */
 exitfree:
-	kfree(new_client);
+	kfree(data);
 exit:
 	return err;
 }
diff -uprN linux-vanilla/drivers/hwmon/adm1031.c linux-hwmon/drivers/hwmon/adm1031.c
--- linux-vanilla/drivers/hwmon/adm1031.c	2005-08-25 18:57:18.000000000 +0400
+++ linux-hwmon/drivers/hwmon/adm1031.c	2005-08-26 01:16:26.000000000 +0400
@@ -834,7 +834,7 @@ static int adm1031_detect(struct i2c_ada
 	return 0;
 
 exit_free:
-	kfree(new_client);
+	kfree(data);
 exit:
 	return err;
 }
diff -uprN linux-vanilla/drivers/hwmon/adm9240.c linux-hwmon/drivers/hwmon/adm9240.c
--- linux-vanilla/drivers/hwmon/adm9240.c	2005-08-25 18:57:18.000000000 +0400
+++ linux-hwmon/drivers/hwmon/adm9240.c	2005-08-26 01:16:40.000000000 +0400
@@ -616,7 +616,7 @@ static int adm9240_detect(struct i2c_ada
 
 	return 0;
 exit_free:
-	kfree(new_client);
+	kfree(data);
 exit:
 	return err;
 }
diff -uprN linux-vanilla/drivers/hwmon/smsc47b397.c linux-hwmon/drivers/hwmon/smsc47b397.c
--- linux-vanilla/drivers/hwmon/smsc47b397.c	2005-08-25 18:57:18.000000000 +0400
+++ linux-hwmon/drivers/hwmon/smsc47b397.c	2005-08-26 01:21:11.000000000 +0400
@@ -298,7 +298,7 @@ static int smsc47b397_detect(struct i2c_
 	return 0;
 
 error_free:
-	kfree(new_client);
+	kfree(data);
 error_release:
 	release_region(addr, SMSC_EXTENT);
 	return err;
diff -uprN linux-vanilla/drivers/hwmon/smsc47m1.c linux-hwmon/drivers/hwmon/smsc47m1.c
--- linux-vanilla/drivers/hwmon/smsc47m1.c	2005-08-25 18:57:18.000000000 +0400
+++ linux-hwmon/drivers/hwmon/smsc47m1.c	2005-08-26 01:21:28.000000000 +0400
@@ -495,7 +495,7 @@ static int smsc47m1_detect(struct i2c_ad
 	return 0;
 
 error_free:
-	kfree(new_client);
+	kfree(data);
 error_release:
 	release_region(address, SMSC_EXTENT);
 	return err;

