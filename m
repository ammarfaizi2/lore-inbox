Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262636AbVCXPaI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262636AbVCXPaI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 10:30:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262798AbVCXPXP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 10:23:15 -0500
Received: from mailfe10.swipnet.se ([212.247.155.33]:31664 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S262526AbVCXPS7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 10:18:59 -0500
X-T2-Posting-ID: dB8bZLHXm6KAmbp1mi7F+A==
Subject: Re: Strange memory leak in 2.6.x
From: Alexander Nyberg <alexn@dsv.su.se>
To: Tobias Hennerich <Tobias@Hennerich.de>
Cc: Timo Hennerich <Timo@Hennerich.de>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Vladimir Saveliev <vs@namesys.com>
In-Reply-To: <20050323175745.A25998@bart.hennerich.de>
References: <20050311183207.A22397@bart.hennerich.de>
	 <1110565420.2501.12.camel@boxen> <20050312133241.A11469@bart.hennerich.de>
	 <1110640085.2376.22.camel@boxen> <20050312214216.A24046@bart.hennerich.de>
	 <1110661479.3360.11.camel@boxen>
	 <026101c52891$2a618410$0404010a@hennerich.de>
	 <1110812292.2492.21.camel@localhost.localdomain>
	 <20050317133026.A4515@bart.hennerich.de>
	 <1111585276.2441.1.camel@localhost.localdomain>
	 <20050323175745.A25998@bart.hennerich.de>
Content-Type: multipart/mixed; boundary="=-ax60y7afElL/36xQ/Uq0"
Date: Thu, 24 Mar 2005 16:18:55 +0100
Message-Id: <1111677535.2369.4.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ax60y7afElL/36xQ/Uq0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

> > Just to follow up, did the problems go away when switching to ext3?
> 
> The switch has been delayed. Up to now we just reboot the machine every
> 48h - the administrator responsible for the machine is on holiday... 
> 
> Meanwhile, I noticed, that the latest release candidate has several
> changes which could be quite interesting for us:
> 
> <andrea@suse.de>
>     [PATCH] orphaned pagecache memleak fix
> 
>     Chris found that with data journaling a reiserfs pagecache may
>     be truncate while still pinned.  The truncation removes the
>     page->mapping, but the page is still listed in the VM queues
>     because it still has buffers.  Then during the journaling process,
>     a buffer is marked dirty and that sets the PG_dirty bitflag as well
>     (in mark_buffer_dirty).  After that the page is leaked because it's
>     both dirty and without a mapping.
> 
> <mason@suse.com>
>     [PATCH] reiserfs: make sure data=journal buffers are cleaned on free
> 
>     In data=journal mode, when blocks are freed and their buffers
>     are dirty, reiserfs can remove them from the transaction without
>     cleaning them. These buffers never get cleaned, resulting in an
>     unfreeable page.
> 
> On the other side we don't want to install a rc1-kernel on a important
> system. Up to now we still plan to do the switch to ext3...
> 
> If someone would recommend to install a special reiserfs-patch (*not*
> the 12mb of patch-2.6.12-rc1) we would consider that, too! So some
> feedback from "the big sharks" is still very welcome.
> 

I've attached the two (small) patches that you mentioned above if you
decide to take another try with reiserfs.

Alex

--=-ax60y7afElL/36xQ/Uq0
Content-Disposition: attachment; filename=reiserfs_page_leak.patch
Content-Type: text/x-patch; name=reiserfs_page_leak.patch; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2005/03/13 16:16:16-08:00 mason@suse.com 
#   [PATCH] reiserfs: make sure data=journal buffers are cleaned on free
#   
#   In data=journal mode, when blocks are freed and their buffers are dirty,
#   reiserfs can remove them from the transaction without cleaning them.  These
#   buffers never get cleaned, resulting in an unfreeable page.
#   
#   Signed-off-by: Chris Mason <mason@suse.com>
#   Signed-off-by: Andrew Morton <akpm@osdl.org>
#   Signed-off-by: Linus Torvalds <torvalds@osdl.org>
# 
# fs/reiserfs/journal.c
#   2005/03/13 15:29:39-08:00 mason@suse.com +4 -0
#   reiserfs: make sure data=journal buffers are cleaned on free
# 
diff -Nru a/fs/reiserfs/journal.c b/fs/reiserfs/journal.c
--- a/fs/reiserfs/journal.c	2005-03-24 16:05:24 +01:00
+++ b/fs/reiserfs/journal.c	2005-03-24 16:05:24 +01:00
@@ -3011,6 +3011,8 @@
 
   if (!already_cleaned) {
     clear_buffer_journal_dirty (bh);
+    clear_buffer_dirty(bh);
+    clear_buffer_journal_test (bh);
     put_bh(bh) ;
     if (atomic_read(&(bh->b_count)) < 0) {
       reiserfs_warning (p_s_sb, "journal-1752: remove from trans, b_count < 0");
@@ -3317,6 +3319,8 @@
 	    ** in the current trans
 	    */
             clear_buffer_journal_dirty (cn->bh);
+	    clear_buffer_dirty(cn->bh);
+	    clear_buffer_journal_test(cn->bh);
 	    cleaned = 1 ;
 	    put_bh(cn->bh) ;
 	    if (atomic_read(&(cn->bh->b_count)) < 0) {

--=-ax60y7afElL/36xQ/Uq0
Content-Disposition: attachment; filename=vm_orphaned_pages.patch
Content-Type: text/x-patch; name=vm_orphaned_pages.patch; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2005/03/13 16:15:58-08:00 andrea@suse.de 
#   [PATCH] orphaned pagecache memleak fix
#   
#   Chris found that with data journaling a reiserfs pagecache may be truncate
#   while still pinned.  The truncation removes the page->mapping, but the page
#   is still listed in the VM queues because it still has buffers.  Then during
#   the journaling process, a buffer is marked dirty and that sets the PG_dirty
#   bitflag as well (in mark_buffer_dirty).  After that the page is leaked
#   because it's both dirty and without a mapping.
#   
#   So we must allow pages without mapping and dirty to reach the PagePrivate
#   check.  The page->mapping will be checked again right after the PagePrivate
#   check.
#   
#   Signed-off-by: Andrea Arcangeli <andrea@suse.de>
#   Signed-off-by: Andrew Morton <akpm@osdl.org>
#   Signed-off-by: Linus Torvalds <torvalds@osdl.org>
# 
# mm/vmscan.c
#   2005/03/13 15:29:39-08:00 andrea@suse.de +13 -1
#   orphaned pagecache memleak fix
# 
diff -Nru a/mm/vmscan.c b/mm/vmscan.c
--- a/mm/vmscan.c	2005-03-24 16:12:42 +01:00
+++ b/mm/vmscan.c	2005-03-24 16:12:42 +01:00
@@ -313,8 +313,20 @@
 	 */
 	if (!is_page_cache_freeable(page))
 		return PAGE_KEEP;
-	if (!mapping)
+	if (!mapping) {
+		/*
+		 * Some data journaling orphaned pages can have
+		 * page->mapping == NULL while being dirty with clean buffers.
+		 */
+		if (PageDirty(page) && PagePrivate(page)) {
+			if (try_to_free_buffers(page)) {
+				ClearPageDirty(page);
+				printk("%s: orphaned page\n", __FUNCTION__);
+				return PAGE_CLEAN;
+			}
+		}
 		return PAGE_KEEP;
+	}
 	if (mapping->a_ops->writepage == NULL)
 		return PAGE_ACTIVATE;
 	if (!may_write_to_queue(mapping->backing_dev_info))

--=-ax60y7afElL/36xQ/Uq0--

