Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266505AbUJTBqZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266505AbUJTBqZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 21:46:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270246AbUJTAzC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 20:55:02 -0400
Received: from mail.kroah.org ([69.55.234.183]:948 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266505AbUJTAT1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 20:19:27 -0400
Subject: Re: [PATCH] I2C update for 2.6.9
In-Reply-To: <10982315052484@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 19 Oct 2004 17:18:25 -0700
Message-Id: <10982315051472@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1867.7.6, 2004/09/21 16:39:31-07:00, mhoffman@lightlink.com

[PATCH] i2c: Add Intel VRD 10.0 and AMD Opteron VID support

This patch adds support for Intel VRD 10.0 and AMD Opteron VID calculations.
It is based on the lm_sensors project CVS, r1.6.

Signed-off-by: Mark M. Hoffman <mhoffman@lightlink.com>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 include/linux/i2c-vid.h |   36 +++++++++++++++++++++++++++++++++++-
 1 files changed, 35 insertions(+), 1 deletion(-)


diff -Nru a/include/linux/i2c-vid.h b/include/linux/i2c-vid.h
--- a/include/linux/i2c-vid.h	2004-10-19 16:55:01 -07:00
+++ b/include/linux/i2c-vid.h	2004-10-19 16:55:01 -07:00
@@ -29,7 +29,22 @@
 */
 
 /*
-    Legal val values 00 - 1F.
+    AMD Opteron processors don't follow the Intel VRM spec.
+    I'm going to "make up" 2.4 as the VRM spec for the Opterons.
+    No good reason just a mnemonic for the 24x Opteron processor
+    series
+
+    Opteron VID encoding is:
+
+       00000  =  1.550 V
+       00001  =  1.525 V
+        . . . .
+       11110  =  0.800 V
+       11111  =  0.000 V (off)
+ */
+
+/*
+    Legal val values 0x00 - 0x1f; except for VRD 10.0, 0x00 - 0x3f.
     vrm is the Intel VRM document version.
     Note: vrm version is scaled by 10 and the return value is scaled by 1000
     to avoid floating point in the kernel.
@@ -41,9 +56,28 @@
 
 static inline int vid_from_reg(int val, int vrm)
 {
+	int vid;
+
 	switch(vrm) {
+
 	case  0:
 		return 0;
+
+	case 100:               /* VRD 10.0 */
+		if((val & 0x1f) == 0x1f)
+			return 0;
+		if((val & 0x1f) <= 0x09 || val == 0x0a)
+			vid = 10875 - (val & 0x1f) * 250;
+		else
+			vid = 18625 - (val & 0x1f) * 250;
+		if(val & 0x20)
+			vid -= 125;
+		vid /= 10;      /* only return 3 dec. places for now */
+		return vid;
+
+	case 24:                /* Opteron processor */
+		return(val == 0x1f ? 0 : 1550 - val * 25);
+
 	case 91:		/* VRM 9.1 */
 	case 90:		/* VRM 9.0 */
 		return(val == 0x1f ? 0 :

