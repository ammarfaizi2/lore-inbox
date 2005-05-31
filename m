Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261978AbVEaQls@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261978AbVEaQls (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 12:41:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261959AbVEaQiL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 12:38:11 -0400
Received: from [194.90.237.34] ([194.90.237.34]:14720 "EHLO
	mtlex01.yok.mtl.com") by vger.kernel.org with ESMTP id S261963AbVEaQgQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 12:36:16 -0400
Date: Tue, 31 May 2005 19:36:19 +0300
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>,
       linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Subject: [PATCH] pci-sysfs: backport fix for 2.6.11.12
Message-ID: <20050531163619.GA6711@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg, before 2.6.12, pci_write_config in pci-sysfs.c was broken, causing
incorrect data being written to the configuration register,
which in the case of my userspace driver results in system failure.

This has been fixed in 2.6.12-rc5:

http://www.kernel.org/diff/diffview.cgi?file=%2Fpub%2Flinux%2Fkernel%2Fv2.6%2Ftesting%2Fpatch-2.6.12-rc5.bz2;z=2656

Would you please consider merging the fix for 2.6.11.12 as well?

Alternatively (since there were multiple other changes in pci-sysfs.c), here's
a small patch to fix just this issue.

Thanks,
MST


cast from (signed) char to unsigned int in pci_write_config
causes the result to be sign extended, clobbering high bits in the result.
Thus:

# setpci -s 07:00.0 14.L=E4
# setpci -s 07:00.0 14.L
ffffffe4

Signed-off-by: Michael S. Tsirkin <mst@mellanox.co.il>

--- linux-2.6.11-openib/drivers/pci/pci-sysfs.c.bad	2005-05-30 13:45:02.000000000 +0300
+++ linux-2.6.11-openib/drivers/pci/pci-sysfs.c	2005-05-30 13:51:39.000000000 +0300
@@ -161,10 +161,10 @@ pci_write_config(struct kobject *kobj, c
 	}
 
 	while (size > 3) {
-		unsigned int val = buf[off - init_off];
-		val |= (unsigned int) buf[off - init_off + 1] << 8;
-		val |= (unsigned int) buf[off - init_off + 2] << 16;
-		val |= (unsigned int) buf[off - init_off + 3] << 24;
+		unsigned int val = (u8)buf[off - init_off];
+		val |= (unsigned int)(u8)buf[off - init_off + 1] << 8;
+		val |= (unsigned int)(u8)buf[off - init_off + 2] << 16;
+		val |= (unsigned int)(u8)buf[off - init_off + 3] << 24;
 		pci_write_config_dword(dev, off, val);
 		off += 4;
 		size -= 4;

-- 
MST - Michael S. Tsirkin
