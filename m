Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750768AbWDIPFE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750768AbWDIPFE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Apr 2006 11:05:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750767AbWDIPFB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Apr 2006 11:05:01 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:48676 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1750764AbWDIPFA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Apr 2006 11:05:00 -0400
Message-ID: <44392347.406@sw.ru>
Date: Sun, 09 Apr 2006 19:07:51 +0400
From: Vasily Averin <vvs@sw.ru>
Organization: SW-soft
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.12) Gecko/20050921
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: Len Brown <len.brown@intel.com>, linux-acpi@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Kirill Korotaev <dev@sw.ru>,
       devel@openvz.org
Subject: [PATCH ACPI] memory leak in acpi_evaluate_integer()
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------030307080301040809040306"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030307080301040809040306
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

acpi_evaluate_integer() does not release allocated memory on the error path.

Signed-off-by: Vasily Averin <vvs@sw.ru>

Thank you,
	Vasily Averin

SWsoft Virtuozzo/OpenVZ Linux kernel team

--------------030307080301040809040306
Content-Type: text/plain;
 name="diff-ms-acpi-evint-20060409"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff-ms-acpi-evint-20060409"

--- a/drivers/acpi/utils.c	2006-04-09 14:31:39.000000000 +0400
+++ b/drivers/acpi/utils.c	2006-04-09 14:35:02.000000000 +0400
@@ -273,11 +273,13 @@ acpi_evaluate_integer(acpi_handle handle
 	status = acpi_evaluate_object(handle, pathname, arguments, &buffer);
 	if (ACPI_FAILURE(status)) {
 		acpi_util_eval_error(handle, pathname, status);
+		kfree(element);
 		return_ACPI_STATUS(status);
 	}
 
 	if (element->type != ACPI_TYPE_INTEGER) {
 		acpi_util_eval_error(handle, pathname, AE_BAD_DATA);
+		kfree(element);
 		return_ACPI_STATUS(AE_BAD_DATA);
 	}
 

--------------030307080301040809040306--
