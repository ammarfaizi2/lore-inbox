Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262126AbTCRCuG>; Mon, 17 Mar 2003 21:50:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262120AbTCRCuG>; Mon, 17 Mar 2003 21:50:06 -0500
Received: from blowme.phunnypharm.org ([65.207.35.140]:46605 "EHLO
	blowme.phunnypharm.org") by vger.kernel.org with ESMTP
	id <S262126AbTCRCuF>; Mon, 17 Mar 2003 21:50:05 -0500
Date: Mon, 17 Mar 2003 22:00:45 -0500
From: Ben Collins <bcollins@debian.org>
To: Patrick Mochel <mochel@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] increase BUS_ID_SIZE to 20
Message-ID: <20030318030045.GA367@phunnypharm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've tried to figure a way around this without adding back a lot of
overhead, but I can't.

The reasoning, is the ieee1394 node's onyl way of a real unique
identifier is the EUI (the 64bit GUID). It's represented as a 16 digit
hex. However, each node additionally ca have unit directories.

Note that an ieee1394's node-id can change with each bus reset. The
software has no control of this. So I cannot use the node-id as a unique
identifier since the driver model has no way to rename a device once it
has been registered. A bus reset should not require unregister/register
for devices which did not change.

So, I want to use the format of "%016Lx" and "%016Lx-%d" for the formats
of the bus ID in ieee1394. The second format would be used for unit
directories of a node. However, current bus-id limit is 16 characters.
The increase to 20 would give me 16 for the hex EUI, -, and 2 digits for
the unit directories (I don't think it's even possible to have > 100
unit directories).

I looked at keeping an internal ID for the node internally, but that is
just way too much overhead in our underlying system. As it is now, a
driver can reference the GUID, which will never change, not even if the
node moves to another bus, on a seperate physical ieee1394 card.

Please consider applying this patch.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
Deqo       - http://www.deqo.com/


--- linux-2.5.65.orig/include/linux/device.h	2003-03-17 19:16:02.000000000 -0500
+++ linux-2.5.65/include/linux/device.h	2003-03-17 21:50:05.000000000 -0500
@@ -35,7 +35,7 @@
 #define DEVICE_NAME_SIZE	50
 #define DEVICE_NAME_HALF	__stringify(20)	/* Less than half to accommodate slop */
 #define DEVICE_ID_SIZE		32
-#define BUS_ID_SIZE		16
+#define BUS_ID_SIZE		20
 
 
 enum {
