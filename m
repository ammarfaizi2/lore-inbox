Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318246AbSG3Mj4>; Tue, 30 Jul 2002 08:39:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318247AbSG3Mj4>; Tue, 30 Jul 2002 08:39:56 -0400
Received: from mout1.freenet.de ([194.97.50.132]:17120 "EHLO mout1.freenet.de")
	by vger.kernel.org with ESMTP id <S318246AbSG3Mjz>;
	Tue, 30 Jul 2002 08:39:55 -0400
Message-ID: <3D4689E5.5000504@gmx.de>
Date: Tue, 30 Jul 2002 14:43:17 +0200
From: Kai Engert <kai.engert@gmx.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020718
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: ajoshi@unixbox.com
Subject: Sync bit bug in drivers/video/radeonfb.c ?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I suspect the line
         v_sync_pol = sync & FB_SYNC_VERT_HIGH_ACT ? 0 : 1;
is incorrect, and probably also line
         h_sync_pol = sync & FB_SYNC_HOR_HIGH_ACT ? 0 : 1;

If I use "fbset -vsync low" the uppermost line is only halfway displayed 
on my system. With "fbset -vsync high" the uppermost line is fully visible.

I'm using 2.4.19-rc3-ac4 which has an entry in drivers/video/modedb.c to 
support a 1280x600 screen resolution on Sony C1M*. That entry defines
   fb_videomode->sync = FB_SYNC_VERT_HIGH_ACT

However, after booting the top level line is not fully visible.
I have to correct that manually with "fbset -vsync high".

The patch below makes it work on boot.

Also note, the variables vSyncPol and hSyncPol use the same assignments, 
but seem to be unused, and should probably get removed.

Kai

PS: I'm not subscribed, please cc me on replys. Thanks.


--- bad/drivers/video/radeonfb.c        Tue Jul 30 14:38:29 2002
+++ good/drivers/video/radeonfb.c       Tue Jul 30 14:39:10 2002
@@ -2401,8 +2401,8 @@
         }

         sync = mode->sync;
-       h_sync_pol = sync & FB_SYNC_HOR_HIGH_ACT ? 0 : 1;
-       v_sync_pol = sync & FB_SYNC_VERT_HIGH_ACT ? 0 : 1;
+       h_sync_pol = sync & FB_SYNC_HOR_HIGH_ACT ? 1 : 0;
+       v_sync_pol = sync & FB_SYNC_VERT_HIGH_ACT ? 1 : 0;

         RTRACE("hStart = %d, hEnd = %d, hTotal = %d\n",
                 hSyncStart, hSyncEnd, hTotal);


