Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261158AbTFAB4Y (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 May 2003 21:56:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261159AbTFAB4Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 May 2003 21:56:24 -0400
Received: from port-212-202-202-240.reverse.qdsl-home.de ([212.202.202.240]:59270
	"EHLO gw.localnet") by vger.kernel.org with ESMTP id S261158AbTFAB4W
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 May 2003 21:56:22 -0400
Message-ID: <3ED96068.8070003@trash.net>
Date: Sun, 01 Jun 2003 04:09:44 +0200
From: Patrick McHardy <kaber@trash.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030527 Debian/1.3.1-2
X-Accept-Language: en
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH]: fix memory leak in ppp filter ioctl error path
Content-Type: multipart/mixed;
 boundary="------------060201010206050509040200"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060201010206050509040200
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

This patch fixes a memory leak in ppp_ioctl,
when copy_from_user fails 'code' isn't freed.
Patch applies to both 2.4 and 2.5.

Best regards,
Patrick


--------------060201010206050509040200
Content-Type: text/plain;
 name="ppp_filter-memleak.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ppp_filter-memleak.diff"

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1248  -> 1.1249 
#	drivers/net/ppp_generic.c	1.19    -> 1.20   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/06/01	kaber@trash.net	1.1249
# [PPP] fix memory leak in ioctl error path
# --------------------------------------------
#
diff -Nru a/drivers/net/ppp_generic.c b/drivers/net/ppp_generic.c
--- a/drivers/net/ppp_generic.c	Sun Jun  1 03:58:58 2003
+++ b/drivers/net/ppp_generic.c	Sun Jun  1 03:58:58 2003
@@ -666,8 +666,10 @@
 			if (code == 0)
 				break;
 			err = -EFAULT;
-			if (copy_from_user(code, uprog.filter, len))
+			if (copy_from_user(code, uprog.filter, len)) {
+				kfree(code);
 				break;
+			}
 			err = sk_chk_filter(code, uprog.len);
 			if (err) {
 				kfree(code);

--------------060201010206050509040200--

