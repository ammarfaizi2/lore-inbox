Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261946AbSKCOZK>; Sun, 3 Nov 2002 09:25:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261945AbSKCOZK>; Sun, 3 Nov 2002 09:25:10 -0500
Received: from kuix.de ([217.160.75.209]:49423 "EHLO p10068181.pureserver.de")
	by vger.kernel.org with ESMTP id <S261946AbSKCOZJ>;
	Sun, 3 Nov 2002 09:25:09 -0500
Message-ID: <3DC5333A.3090808@gmx.de>
Date: Sun, 03 Nov 2002 15:31:22 +0100
From: Kai Engert <kai.engert@gmx.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: james@cobaltmountain.com, alan@redhat.com
Subject: Regression in 2.4.20 radeonfb.c
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In 2.4.19-rc3-ac2, Alan Cox / James Mayer added a modeline entry to 
modedb.c that enables a 1280x600 console screen on Vaio C1M* devices. 
The patch works fine for me in 2.4.19.

In 2.4.20-pre* kernels, it does no longer work for me, the console 
remains at the default setting.

I identified the hunk below to be the culprit. That check was removed in 
2.4.20-* kernels. When I revert the hunk below, adding back the null 
check, my system again switches to full screen console mode.

I propose to revert the hunk for 2.4.20.
Tested with 2.4.20-rc1.

Thanks,
Kai

(Please CC me on replys)


diff -ru 2419/drivers/video/radeonfb.c 2420/drivers/video/radeonfb.c
--- 2419/drivers/video/radeonfb.c       Sun Nov  3 14:44:07 2002
+++ 2420/drivers/video/radeonfb.c       Sun Nov  3 13:48:47 2002
@@ -877,14 +871,6 @@
         /* mem size is bits [28:0], mask off the rest */
         rinfo->video_ram = tmp & CONFIG_MEMSIZE_MASK;

-       /* According to XFree86 4.2.0, some production M6's return 0
-          for 8MB. */
-       if (rinfo->video_ram == 0 &&
-           (pdev->device == PCI_DEVICE_ID_RADEON_LY ||
-            pdev->device == PCI_DEVICE_ID_RADEON_LZ)) {
-           rinfo->video_ram = 8192 * 1024;
-         }
-
         /* ram type */
         tmp = INREG(MEM_SDRAM_MODE_REG);
         switch ((MEM_CFG_TYPE & tmp) >> 30) {


