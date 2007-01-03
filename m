Return-Path: <linux-kernel-owner+w=401wt.eu-S1751068AbXACTDn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751068AbXACTDn (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 14:03:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751070AbXACTDn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 14:03:43 -0500
Received: from smtp.osdl.org ([65.172.181.25]:41210 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751067AbXACTDm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 14:03:42 -0500
Date: Wed, 3 Jan 2007 11:03:32 -0800
From: Andrew Morton <akpm@osdl.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Anton Altaparmakov <aia21@cam.ac.uk>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 PATCH] Export invalidate_mapping_pages() to modules.
Message-Id: <20070103110332.ba3d39a2.akpm@osdl.org>
In-Reply-To: <1167830972.3095.3.camel@laptopd505.fenrus.org>
References: <Pine.LNX.4.64.0701012322050.1218@hermes-1.csi.cam.ac.uk>
	<1167830972.3095.3.camel@laptopd505.fenrus.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 03 Jan 2007 05:29:31 -0800
Arjan van de Ven <arjan@infradead.org> wrote:

> On Mon, 2007-01-01 at 23:28 +0000, Anton Altaparmakov wrote:
> > Hi Linus and Andrew,
> > 
> > Please apply below patch which exports invalidate_mapping_pages() to 
> > modules.  It makes no sense to me to export invalidate_inode_pages() and 
> > not invalidate_mapping_pages() and I actually need 
> > invalidate_mapping_pages() because of its range specification ability...
> > 
> > It would be great if this could make it into 2.6.20!
> 
> 
> yet.. if there's not a single user it makes the kernel binary 100 to 150
> bytes bigger in memory......  

I fixed that.


From: Anton Altaparmakov <aia21@cam.ac.uk>

It makes no sense to me to export invalidate_inode_pages() and not
invalidate_mapping_pages() and I actually need invalidate_mapping_pages()
because of its range specification ability...

akpm: also remove the export of invalidate_inode_pages() by making it an
inlined wrapper.

Signed-off-by: Anton Altaparmakov <aia21@cantab.net>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 include/linux/fs.h |    8 +++++++-
 mm/truncate.c      |    7 +------
 2 files changed, 8 insertions(+), 7 deletions(-)

diff -puN mm/truncate.c~export-invalidate_mapping_pages-to-modules mm/truncate.c
--- a/mm/truncate.c~export-invalidate_mapping_pages-to-modules
+++ a/mm/truncate.c
@@ -303,12 +303,7 @@ unlock:
 	}
 	return ret;
 }
-
-unsigned long invalidate_inode_pages(struct address_space *mapping)
-{
-	return invalidate_mapping_pages(mapping, 0, ~0UL);
-}
-EXPORT_SYMBOL(invalidate_inode_pages);
+EXPORT_SYMBOL(invalidate_mapping_pages);
 
 /*
  * This is like invalidate_complete_page(), except it ignores the page's
diff -puN include/linux/fs.h~export-invalidate_mapping_pages-to-modules include/linux/fs.h
--- a/include/linux/fs.h~export-invalidate_mapping_pages-to-modules
+++ a/include/linux/fs.h
@@ -1571,7 +1571,13 @@ extern int invalidate_partition(struct g
 extern int invalidate_inodes(struct super_block *);
 unsigned long invalidate_mapping_pages(struct address_space *mapping,
 					pgoff_t start, pgoff_t end);
-unsigned long invalidate_inode_pages(struct address_space *mapping);
+
+static inline unsigned long
+invalidate_inode_pages(struct address_space *mapping)
+{
+	return invalidate_mapping_pages(mapping, 0, ~0UL);
+}
+
 static inline void invalidate_remote_inode(struct inode *inode)
 {
 	if (S_ISREG(inode->i_mode) || S_ISDIR(inode->i_mode) ||
_

