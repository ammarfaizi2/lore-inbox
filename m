Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265547AbSJSHVX>; Sat, 19 Oct 2002 03:21:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265548AbSJSHVX>; Sat, 19 Oct 2002 03:21:23 -0400
Received: from chunk.voxel.net ([207.99.115.133]:57013 "EHLO chunk.voxel.net")
	by vger.kernel.org with ESMTP id <S265547AbSJSHVX>;
	Sat, 19 Oct 2002 03:21:23 -0400
Date: Sat, 19 Oct 2002 03:27:27 -0400
From: Andres Salomon <dilinger@mp3revolution.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.44 device_add double up() of device_sem
Message-ID: <20021019072727.GA3981@chunk.voxel.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="5vNYLRcllDrimb99"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux chunk 2.4.18-ac3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--5vNYLRcllDrimb99
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I noticed this while tracking down an oops.  If there's any sort of
error in device_add(), register_done is jumped to.  At that point,
device_sem is up()'d twice.  This patch fixes that.


-- 
It's not denial.  I'm just selective about the reality I accept.
	-- Bill Watterson

--5vNYLRcllDrimb99
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="core.c.diff"

--- a/drivers/base/core.c	2002-10-19 02:45:26.000000000 -0400
+++ b/drivers/base/core.c	2002-10-19 03:07:35.000000000 -0400
@@ -59,7 +59,7 @@
 	devclass_add_device(dev);
  register_done:
 	if (error) {
-		up(&device_sem);
+		down(&device_sem);
 		list_del_init(&dev->g_list);
 		list_del_init(&dev->node);
 		up(&device_sem);

--5vNYLRcllDrimb99--
