Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263696AbUD2Ix0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263696AbUD2Ix0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 04:53:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263714AbUD2Ix0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 04:53:26 -0400
Received: from mail.convergence.de ([212.84.236.4]:28091 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S263696AbUD2IxX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 04:53:23 -0400
Message-ID: <4090C281.5070604@convergence.de>
Date: Thu, 29 Apr 2004 10:53:21 +0200
From: Michael Hunold <hunold@convergence.de>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040208)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH][2.6] DVB:Fix adapter module removal bug
Content-Type: multipart/mixed;
 boundary="------------090907090607040202040405"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090907090607040202040405
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

unfortunately it's possible to remove a DVB adapter module even if a DVB 
network device has been set up using this adapter.

The attached patch fixes this problem. Please apply. Thanks!

CU
Michael.

--------------090907090607040202040405
Content-Type: text/plain;
 name="dvb_net.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dvb_net.diff"

diff -ur xx-linux-2.6.6-rc3/drivers/media/dvb/dvb-core/dvb_net.c linux-2.6.6-rc3/drivers/media/dvb/dvb-core/dvb_net.c
--- xx-linux-2.6.6-rc3/drivers/media/dvb/dvb-core/dvb_net.c	2004-04-29 10:38:36.000000000 +0200
+++ linux-2.6.6-rc3/drivers/media/dvb/dvb-core/dvb_net.c	2004-04-29 10:45:46.000000000 +0200
@@ -1095,9 +1095,15 @@
 		
 		if (!capable(CAP_SYS_ADMIN))
 			return -EPERM;
+			
+		if (!try_module_get(dvbdev->adapter->module))
+			return -EPERM;
+
 		result=dvb_net_add_if(dvbnet, dvbnetif->pid, dvbnetif->feedtype);
-		if (result<0)
+		if (result<0) {
+			module_put(dvbdev->adapter->module);
 			return result;
+		}
 		dvbnetif->if_num=result;
 		break;
 	}
@@ -1120,6 +1126,7 @@
 	case NET_REMOVE_IF:
 		if (!capable(CAP_SYS_ADMIN))
 			return -EPERM;
+		module_put(dvbdev->adapter->module);
 		return dvb_net_remove_if(dvbnet, (int) (long) parg);
 
 	/* binary compatiblity cruft */
@@ -1130,9 +1137,15 @@
 
 		if (!capable(CAP_SYS_ADMIN))
 			return -EPERM;
+
+		if (!try_module_get(dvbdev->adapter->module))
+			return -EPERM;
+
 		result=dvb_net_add_if(dvbnet, dvbnetif->pid, DVB_NET_FEEDTYPE_MPE);
-		if (result<0)
+		if (result<0) {
+			module_put(dvbdev->adapter->module);
 			return result;
+		}
 		dvbnetif->if_num=result;
 		break;
 	}

--------------090907090607040202040405--
