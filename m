Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161045AbWHDFuF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161045AbWHDFuF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 01:50:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030338AbWHDFod
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 01:44:33 -0400
Received: from ns2.suse.de ([195.135.220.15]:64943 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030335AbWHDFoT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 01:44:19 -0400
Date: Thu, 3 Aug 2006 22:39:42 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org, torvalds@osdl.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, jes@trained-monkey.org,
       Jes Sorensen <jes@sgi.com>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 12/23] invalidate_bdev() speedup
Message-ID: <20060804053942.GM769@kroah.com>
References: <20060804053258.391158155@quad.kroah.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="invalidate_bdev-speedup.patch"
In-Reply-To: <20060804053807.GA769@kroah.com>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Andrew Morton <akpm@osdl.org>

We can immediately bale from invalidate_bdev() if the blockdev has no
pagecache.

This solves the huge IPI storms which hald is causing on the big ia64
machines when it polls CDROM drives.

Acked-by: Jes Sorensen <jes@sgi.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 fs/buffer.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- linux-2.6.17.7.orig/fs/buffer.c
+++ linux-2.6.17.7/fs/buffer.c
@@ -473,13 +473,18 @@ out:
    pass does the actual I/O. */
 void invalidate_bdev(struct block_device *bdev, int destroy_dirty_buffers)
 {
+	struct address_space *mapping = bdev->bd_inode->i_mapping;
+
+	if (mapping->nrpages == 0)
+		return;
+
 	invalidate_bh_lrus();
 	/*
 	 * FIXME: what about destroy_dirty_buffers?
 	 * We really want to use invalidate_inode_pages2() for
 	 * that, but not until that's cleaned up.
 	 */
-	invalidate_inode_pages(bdev->bd_inode->i_mapping);
+	invalidate_inode_pages(mapping);
 }
 
 /*

--
