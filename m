Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262154AbVAZBBX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262154AbVAZBBX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 20:01:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262236AbVAYXkm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 18:40:42 -0500
Received: from fmr18.intel.com ([134.134.136.17]:55441 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S262239AbVAYXSt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 18:18:49 -0500
Date: Tue, 25 Jan 2005 15:18:45 -0800
From: Mitch Williams <mitch.a.williams@intel.com>
X-X-Sender: mawilli1@mawilli1-desk2.amr.corp.intel.com
To: linux-kernel@vger.kernel.org
cc: greg@kroah.com
Subject: Resubmittal [PATCH 1/2] Disallow appends to sysfs files
Message-ID: <Pine.CYG.4.58.0501251517001.3148@mawilli1-desk2.amr.corp.intel.com>
ReplyTo: "Mitch Williams" <mitch.a.williams@intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch returns an error code if the caller attempts to open a sysfs
file for appending.

Generated from 2.6.11-rc2.

Signed-off-by:  Mitch Williams <mitch.a.williams@intel.com>

diff -urpN -X dontdiff linux-2.6.11-clean/fs/sysfs/file.c linux-2.6.11/fs/sysfs/file.c
--- linux-2.6.11-clean/fs/sysfs/file.c	2004-12-24 13:33:50.000000000 -0800
+++ linux-2.6.11/fs/sysfs/file.c	2005-01-25 14:59:33.000000000 -0800
@@ -275,6 +275,15 @@ static int check_perm(struct inode * ino
 	if (!ops)
 		goto Eaccess;

+        /* Return error if the file is open for append.
+         * Sysfs can't support append because the kobject
+         * store methods don't take an offset into the buffer
+         * as an argument.  They end up thinking the appended
+         * data is the entire contents of the file.
+         */
+	if (file->f_flags & O_APPEND)
+		goto Einval;
+
 	/* File needs write support.
 	 * The inode's perms must say it's ok,
 	 * and we must have a store method.
