Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261405AbUKOBNh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261405AbUKOBNh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Nov 2004 20:13:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261403AbUKOBN3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Nov 2004 20:13:29 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:48028 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S261404AbUKOBLx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Nov 2004 20:11:53 -0500
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
X-Message-Flag: Warning: May contain useful information
From: Roland Dreier <roland@topspin.com>
Date: Sun, 14 Nov 2004 17:11:47 -0800
Message-ID: <52u0rrq5kc.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: roland@topspin.com
Subject: [PATCH] cdev_init: zero out cdev before kobject_init()
Content-Type: text/plain; charset=us-ascii
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on eddore)
X-OriginalArrivalTime: 15 Nov 2004 01:11:52.0638 (UTC) FILETIME=[174095E0:01C4CAB0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Right now, cdev_init() works in a way that is not very intuitive.  If
a driver passes an uninitialized struct cdev to cdev_init(), then an
uninitialized struct kobject will be passed to kobject_init(), which
does kset_get() on kobj->kset, which probably points off into space
and causes an oops.  Drivers can work around this by zeroing out their
struct cdev in advance (and indeed most if not all of the things
passed to cdev_init() come from BSS) but I think it makes more sense
for cdev_init() to live up to its name and actually work on an
uninitialized cdev.

Signed-off-by: Roland Dreier <roland@topspin.com>

Index: x/fs/char_dev.c
===================================================================
--- x.orig/fs/char_dev.c	2004-11-14 17:02:48.000000000 -0800
+++ x/fs/char_dev.c	2004-11-14 17:03:39.000000000 -0800
@@ -417,6 +417,7 @@
 
 void cdev_init(struct cdev *cdev, struct file_operations *fops)
 {
+	memset(cdev, 0, sizeof *cdev);	
 	INIT_LIST_HEAD(&cdev->list);
 	cdev->kobj.ktype = &ktype_cdev_default;
 	kobject_init(&cdev->kobj);
