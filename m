Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261362AbVDQRHT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261362AbVDQRHT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Apr 2005 13:07:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261366AbVDQRHT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Apr 2005 13:07:19 -0400
Received: from ylpvm01-ext.prodigy.net ([207.115.57.32]:31192 "EHLO
	ylpvm01.prodigy.net") by vger.kernel.org with ESMTP id S261362AbVDQRHJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Apr 2005 13:07:09 -0400
From: David Brownell <david-b@pacbell.net>
To: mpm@selenic.com, akpm@osdl.org, Linus Torvalds <torvalds@osdl.org>
Subject: [patch 2.6.12-rc2] revert fs/char_dev.c CONFIG_BASE_FULL change
Date: Sun, 17 Apr 2005 10:06:53 -0700
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_tepYC6KrMIQNQ2o"
Message-Id: <200504171006.53328.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_tepYC6KrMIQNQ2o
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I tracked down a regression in PCMCIA (and other software) to a
new bogus register_chrdev() behavior that got merged last month;
a patch from Matt Mackall that misbehaves.

This patch just reverts Matt's, restoring the previous behavior
but at the cost of about a Kbyte of static memory on 32bit CPUs.
Someday a Real Fix(tm) would be good.

- Dave


--Boundary-00=_tepYC6KrMIQNQ2o
Content-Type: text/x-diff;
  charset="us-ascii";
  name="chrdev.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="chrdev.patch"

This reverts a fs/char_dev.c patch that was merged into BK on March 3.

The problem is that it breaks things ... __register_chrdev_region() has
a block of code, commented "temporary" for over two years now, which
fails rudely during PCMCIA initialization or other register_chrdev()
calls, because it doesn't "degrade to linked list".  This keeps whole
subsystems from working.

A real fix to that "temporary" code should be possible, using some better
scheme to allocate major numbers, but it's not something I want to spend
time on just now.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>

--- 1.38/fs/char_dev.c	2005-03-09 09:03:28 -08:00
+++ edited/fs/char_dev.c	2005-04-17 08:45:19 -07:00
@@ -26,8 +26,7 @@
 
 static struct kobj_map *cdev_map;
 
-/* degrade to linked list for small systems */
-#define MAX_PROBE_HASH (CONFIG_BASE_SMALL ? 1 : 255)
+#define MAX_PROBE_HASH 255	/* random */
 
 static DECLARE_MUTEX(chrdevs_lock);
 

--Boundary-00=_tepYC6KrMIQNQ2o--
