Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262160AbVBAWqI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262160AbVBAWqI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 17:46:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262152AbVBAWoc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 17:44:32 -0500
Received: from fmr18.intel.com ([134.134.136.17]:3281 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S262158AbVBAWj1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 17:39:27 -0500
Date: Tue, 1 Feb 2005 14:39:21 -0800
From: Mitch Williams <mitch.a.williams@intel.com>
X-X-Sender: mawilli1@mawilli1-desk2.amr.corp.intel.com
To: linux-kernel@vger.kernel.org
cc: greg@kroah.com
Subject: [PATCH] reject sysfs writes with nonzero position
Message-ID: <Pine.CYG.4.58.0502011432430.396@mawilli1-desk2.amr.corp.intel.com>
ReplyTo: "Mitch Williams" <mitch.a.williams@intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch causes an error to be returned if the user attempts to write a
sysfs file at a nonzero offset.  Because sysfs store methods do not
support a position parameter, the behavior in this case would be
unpredictable.  Thus, we return an error, because at least now we're
consistent.

This patch generated from 2.6.11-rc1.

Now with tabs.

Signed-off-by:  Mitch Williams <mitch.a.williams@intel.com>

diff -urpN -X dontdiff linux-2.6.11-clean/fs/sysfs/file.c linux-2.6.11/fs/sysfs/file.c
--- linux-2.6.11-clean/fs/sysfs/file.c	2004-12-24 13:33:50.000000000 -0800
+++ linux-2.6.11/fs/sysfs/file.c	2005-01-25 10:47:15.000000000 -0800
@@ -232,6 +232,8 @@ sysfs_write_file(struct file *file, cons
 {
 	struct sysfs_buffer * buffer = file->private_data;

+	if (*ppos > 0)
+		return -EIO;
 	down(&buffer->sem);
 	count = fill_write_buffer(buffer,buf,count);
 	if (count > 0)
