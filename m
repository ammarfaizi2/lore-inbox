Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263914AbUCZDgO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 22:36:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263915AbUCZDgO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 22:36:14 -0500
Received: from gate.crashing.org ([63.228.1.57]:63112 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S263914AbUCZDf5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 22:35:57 -0500
Subject: [PATCH] dmasound close timeout
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1080272020.1206.24.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 26 Mar 2004 14:33:41 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

The dmasound driver occasionally hangs a process on exit,
apparently, there is a possible case where the sound HW stops
draining output samples and the driver waits forever in its
release() callback. It should check for signals(), but it
seems signal_pending() never returns 1 when the process is
beeing killed (implicit release() of files on exit).

This patch adds a safety timeout to the release() function
to make sure we can at least close the driver. I'll try to
find the reason we aren't driving samples later, but it is
better to have a safety just incase the sound clock goes
berserk for some reason.

Ben.

diff -urN linux-2.5/sound/oss/dmasound/dmasound_core.c linuxppc-2.5-benh/sound/oss/dmasound/dmasound_core.c
--- linux-2.5/sound/oss/dmasound/dmasound_core.c	2004-03-01 18:13:38.000000000 +1100
+++ linuxppc-2.5-benh/sound/oss/dmasound/dmasound_core.c	2004-03-25 18:41:02.000000000 +1100
@@ -1004,6 +1004,7 @@
 static int sq_fsync(struct file *filp, struct dentry *dentry)
 {
 	int rc = 0;
+	int timeout = 5;
 
 	write_sq.syncing |= 1;
 	sq_play();	/* there may be an incomplete frame waiting */
@@ -1018,6 +1019,12 @@
 			rc = -EINTR;
 			break;
 		}
+		if (!--timeout) {
+			printk(KERN_WARNING "dmasound: Timeout draining output\n");
+			sq_reset_output();
+			rc = -EIO;
+			break;
+		}
 	}
 
 	/* flag no sync regardless of whether we had a DSP_POST or not */


