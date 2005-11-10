Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932169AbVKJVsf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932169AbVKJVsf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 16:48:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932175AbVKJVsf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 16:48:35 -0500
Received: from smtp1-g19.free.fr ([212.27.42.27]:48537 "EHLO smtp1-g19.free.fr")
	by vger.kernel.org with ESMTP id S932169AbVKJVse (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 16:48:34 -0500
Message-ID: <4373C03F.1070301@free.fr>
Date: Thu, 10 Nov 2005 22:48:47 +0100
From: matthieu castet <castet.matthieu@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: fr-fr, en, en-us
MIME-Version: 1.0
CC: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix leakes in request_firmware_nowait
References: <4373BF82.40003@free.fr>
In-Reply-To: <4373BF82.40003@free.fr>
Content-Type: multipart/mixed;
 boundary="------------030105030402020205020808"
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030105030402020205020808
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

matthieu castet wrote:
> Hi,
> 
> 
> request_firmware_nowait wasn't checking return error and forgot to free 
> memory in some case.
> 
> This patch should fix it.
> 
> Signed-off-by: Matthieu CASTET <castet.matthieu@free.fr>
> 
> 
And I forgot a case when _request_firmware return an error.

This one should be correct.

Signed-off-by: Matthieu CASTET <castet.matthieu@free.fr>

--------------030105030402020205020808
Content-Type: text/plain;
 name="firmware_nowait_leak"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="firmware_nowait_leak"

Index: linux-2.6.14/drivers/base/firmware_class.c
===================================================================
--- linux-2.6.14.orig/drivers/base/firmware_class.c	2005-10-28 02:02:08.000000000 +0200
+++ linux-2.6.14/drivers/base/firmware_class.c	2005-11-10 22:47:23.000000000 +0100
@@ -511,18 +511,23 @@
 {
 	struct firmware_work *fw_work = arg;
 	const struct firmware *fw;
+	int ret;
 	if (!arg) {
 		WARN_ON(1);
 		return 0;
 	}
 	daemonize("%s/%s", "firmware", fw_work->name);
-	_request_firmware(&fw, fw_work->name, fw_work->device,
+	ret = _request_firmware(&fw, fw_work->name, fw_work->device,
 		fw_work->hotplug);
-	fw_work->cont(fw, fw_work->context);
-	release_firmware(fw);
+	if (ret < 0)
+		fw_work->cont(NULL, fw_work->context);
+	else {
+		fw_work->cont(fw, fw_work->context);
+		release_firmware(fw);
+	}
 	module_put(fw_work->module);
 	kfree(fw_work);
-	return 0;
+	return ret;
 }
 
 /**
@@ -573,6 +578,8 @@
 
 	if (ret < 0) {
 		fw_work->cont(NULL, fw_work->context);
+		module_put(fw_work->module);
+		kfree(fw_work);
 		return ret;
 	}
 	return 0;

--------------030105030402020205020808--
