Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267483AbUIWWOj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267483AbUIWWOj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 18:14:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267370AbUIWWOH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 18:14:07 -0400
Received: from cantor.suse.de ([195.135.220.2]:45501 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S267451AbUIWWKZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 18:10:25 -0400
Date: Fri, 24 Sep 2004 00:10:18 +0200
From: Olaf Hering <olh@suse.de>
To: Ben Collins <bcollins@debian.org>
Cc: linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH] rmmod ohci1394 hangs
Message-ID: <20040923221018.GA15788@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ben,

this sequence of commands will hang the final rmmod.

init=/bin/bash --login
mount proc
modprove -v ohci1394
rmmod ohci1394
modprobe -v ohci1394
rmmod ohci1394  ->  hangs

It is stuck here:

rmmod         D 0FF7D030     0  4518      1                4517 (NOTLB)
Call trace:
 [c000a188] __switch_to+0x48/0x70
 [c0171588] schedule+0x2b0/0x5d0
 [c0171b28] wait_for_completion+0x7c/0xec
 [e90492fc] nodemgr_remove_host+0x70/0x108 [ieee1394]
 [e904606c] __unregister_host+0xd8/0x10c [ieee1394]
 [e9046170] highlevel_remove_host+0x9c/0x15c [ieee1394]
 [e9044e7c] hpsb_remove_host+0x8c/0xdc [ieee1394]
 [e9065c80] ohci1394_pci_remove+0xd8/0x418 [ohci1394]
 [c00b487c] pci_device_remove+0x60/0x64
 [c00e8a68] device_release_driver+0x84/0x88
 [c00e8b1c] bus_remove_driver+0xb0/0x12c
 [c00e9270] driver_unregister+0x1c/0xa0
 [c00b4ac4] pci_unregister_driver+0x20/0x88
 [e9068698] ohci1394_cleanup+0x44/0x1054 [ohci1394]
 [c00352f8] sys_delete_module+0x1d0/0x2a8


knodemgrd_0 exits on the first rmmod, but leaves nodemgr_serialize
in down state. This patch fixes it for me.

Signed-off-by: Olaf Hering <olh@suse.de>

diff -purN linux-2.6.9-rc2-bk6.orig/drivers/ieee1394/nodemgr.c linux-2.6.9-rc2-bk6/drivers/ieee1394/nodemgr.c
--- linux-2.6.9-rc2-bk6.orig/drivers/ieee1394/nodemgr.c	2004-09-13 07:32:54.000000000 +0200
+++ linux-2.6.9-rc2-bk6/drivers/ieee1394/nodemgr.c	2004-09-23 23:59:28.523829697 +0200
@@ -1490,7 +1490,10 @@ static int nodemgr_host_thread(void *__h
 		}
 
 		if (hi->kill_me)
+		{
+			up(&nodemgr_serialize);
 			break;
+		}
 
 		/* Pause for 1/4 second in 1/16 second intervals,
 		 * to make sure things settle down. */
@@ -1515,7 +1518,10 @@ static int nodemgr_host_thread(void *__h
 
 			/* Check the kill_me again */
 			if (hi->kill_me)
+			{
+				up(&nodemgr_serialize);
 				goto caught_signal;
+			}
 		}
 
 		if (!nodemgr_check_irm_capability(host, reset_cycles)) {
-- 
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG
