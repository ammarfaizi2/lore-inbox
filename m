Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262221AbTD3QPH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 12:15:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262225AbTD3QPH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 12:15:07 -0400
Received: from verein.lst.de ([212.34.181.86]:22285 "EHLO verein.lst.de")
	by vger.kernel.org with ESMTP id S262221AbTD3QPF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 12:15:05 -0400
Date: Wed, 30 Apr 2003 18:27:24 +0200
From: Christoph Hellwig <hch@lst.de>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] remove devfs hack from misc_register
Message-ID: <20030430182724.A4681@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There's an (fortunately unused) devfs in misc_register currently,
when the name of the miscdevice contains a slash the name is used
as devfs name instead of misc/<name>.  Kill if as we have .devfs_name
for this kind of stuff now.


--- 1.17/drivers/char/misc.c	Sat Apr 19 11:56:45 2003
+++ edited/drivers/char/misc.c	Wed Apr 30 18:01:16 2003
@@ -192,21 +192,12 @@
 		}
 		misc->minor = i;
 	}
+
 	if (misc->minor < DYNAMIC_MINORS)
 		misc_minors[misc->minor >> 3] |= 1 << (misc->minor & 7);
-
-
-	/*
-	 * please use it if you want to do fancy things with your
-	 * name...
-	 */
 	if (misc->devfs_name[0] == '\0') {
-		/* yuck, yet another stupid special-casing.
-		   whos actually using this?  Please switch over
-		   to ->devfs_name ASAP */
 		snprintf(misc->devfs_name, sizeof(misc->devfs_name),
-				strchr(misc->name, '/') ?
-				  "%s" : "misc/%s", misc->name);
+				"misc/%s", misc->name);
 	}
 
 	devfs_register(NULL, misc->devfs_name, 0, MISC_MAJOR, misc->minor,
