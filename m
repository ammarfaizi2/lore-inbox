Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267387AbUJBQvs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267387AbUJBQvs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Oct 2004 12:51:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267385AbUJBQvs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Oct 2004 12:51:48 -0400
Received: from postfix3-2.free.fr ([213.228.0.169]:63410 "EHLO
	postfix3-2.free.fr") by vger.kernel.org with ESMTP id S267387AbUJBQvl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Oct 2004 12:51:41 -0400
From: Duncan Sands <baldrick@free.fr>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] firmware_class: avoid double free
Date: Sat, 2 Oct 2004 18:51:40 +0200
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200410021851.40249.baldrick@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The error exit path in request_firmware frees the allocated
struct firmware *firmware, which is good.  What is not so good
is that the value of firmware has already been copied out to the
caller as *firmware_p.  The risk is that the caller will pass this
to release_firmware, a double free.  This is exactly what will
happen if the caller copied the example code

         if(request_firmware(&fw_entry, $FIRMWARE, device) == 0)
                copy_fw_to_device(fw_entry->data, fw_entry->size);
         release(fw_entry);

from the firmware documentation.

--- mm/drivers/base/firmware_class.c.orig	2004-10-02 18:43:00.323005656 +0200
+++ mm/drivers/base/firmware_class.c	2004-10-02 18:43:37.500448654 +0200
@@ -441,6 +441,7 @@
 
 error_kfree_fw:
 	kfree(firmware);
+	*firmware_p = NULL;
 out:
 	return retval;
 }
