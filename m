Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161176AbWFVSuu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161176AbWFVSuu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 14:50:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161175AbWFVSuu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 14:50:50 -0400
Received: from nz-out-0102.google.com ([64.233.162.193]:24479 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1161176AbWFVSur (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 14:50:47 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=gp1b1DeKep994rawjMJf5q3WlSwCRPDc4HjsfeoPq6/WvwRLp2NMQS8etFSUy70vUnrjOJR0OCfvR5baCpO/hKAO9wXQxhrhuzstPGuWxx9uNzG0J7RXHfoj46EwSlrlmtpIqsRYkTW+8P2X7nJEELcdIIbatpvCdlkh9kT/gus=
Message-ID: <449AE685.3090305@gmail.com>
Date: Thu, 22 Jun 2006 12:50:45 -0600
From: Jim Cromie <jim.cromie@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Linux kernel <linux-kernel@vger.kernel.org>
Subject: [ patch -mm1 03/11 ] gpio-patchset-fixups:  scx200 init undo malloc
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


If platform_device_add() fails,  the add doesnt need to be undone.
What is needed it to undo the previous malloc.

Signed-off-by:   Jim Cromie <jim.cromie@gmail.com>

diff -ruNp -X dontdiff -X exclude-diffs aa-2/drivers/char/scx200_gpio.c aa-3/drivers/char/scx200_gpio.c
--- aa-2/drivers/char/scx200_gpio.c	2006-06-22 09:43:16.000000000 -0600
+++ aa-3/drivers/char/scx200_gpio.c	2006-06-22 09:30:20.000000000 -0600
@@ -91,7 +91,7 @@ static int __init scx200_gpio_init(void)
 
 	rc = platform_device_add(pdev);
 	if (rc)
-		goto undo_platform_device_add;
+		goto undo_malloc;
 
 	/* nsc_gpio uses dev_dbg(), so needs this */
 	scx200_access.dev = &pdev->dev;
@@ -127,7 +127,8 @@ undo_chrdev_region:
 	unregister_chrdev_region(dev, num_pins);
 undo_platform_device_add:
 	platform_device_put(pdev);
-	kfree(pdev);		/* undo platform_device_alloc */
+undo_malloc:
+	kfree(pdev);
 	return rc;
 }
 


