Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264547AbTGGCXJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jul 2003 22:23:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266785AbTGGCXI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jul 2003 22:23:08 -0400
Received: from air-2.osdl.org ([65.172.181.6]:46013 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264547AbTGGCW5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jul 2003 22:22:57 -0400
Date: Sun, 6 Jul 2003 19:37:22 -0700
From: Andrew Morton <akpm@osdl.org>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: barryn@pobox.com, linux-kernel@vger.kernel.org
Subject: Re: [BUG] heavy disk access sometimes freezes 2.5.73-mm[123]
Message-Id: <20030706193722.79352bc3.akpm@osdl.org>
In-Reply-To: <3F08DA84.7010500@cyberone.com.au>
References: <20030703090541.GB5044@ip68-101-124-193.oc.oc.cox.net>
	<20030706204630.GA2904@ip68-4-255-84.oc.oc.cox.net>
	<3F08DA84.7010500@cyberone.com.au>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <piggin@cyberone.com.au> wrote:
>
> >I've figured things out a bit more and filed a Bugzilla report:
> >http://bugme.osdl.org/show_bug.cgi?id=877

Barry says the problem started with 2.5.73-mm1.  There was a reiserfs patch
added in that kernel.

Does a `patch -R' of this fix it up?


 fs/reiserfs/tail_conversion.c |   13 +++++++++++++
 1 files changed, 13 insertions(+)

diff -puN fs/reiserfs/tail_conversion.c~reiserfs-unmapped-buffer-fix fs/reiserfs/tail_conversion.c
--- 25/fs/reiserfs/tail_conversion.c~reiserfs-unmapped-buffer-fix	2003-06-27 23:20:15.000000000 -0700
+++ 25-akpm/fs/reiserfs/tail_conversion.c	2003-06-27 23:20:15.000000000 -0700
@@ -143,6 +143,16 @@ void reiserfs_unmap_buffer(struct buffer
     }
     clear_buffer_dirty(bh) ;
     lock_buffer(bh) ;
+    /* Remove the buffer from whatever list it belongs to. We are mostly
+       interested in removing it from per-sb j_dirty_buffers list, to avoid
+        BUG() on attempt to write not mapped buffer */
+    if ( !list_empty(&bh->b_assoc_buffers) && bh->b_page) {
+	struct inode *inode = bh->b_page->mapping->host;
+	struct reiserfs_journal *j = SB_JOURNAL(inode->i_sb);
+	spin_lock(&j->j_dirty_buffers_lock);
+	list_del_init(&bh->b_assoc_buffers);
+	spin_unlock(&j->j_dirty_buffers_lock);
+    }
     clear_buffer_mapped(bh) ;
     clear_buffer_req(bh) ;
     clear_buffer_new(bh);
@@ -180,6 +190,9 @@ unmap_buffers(struct page *page, loff_t 
         }
 	bh = next ;
       } while (bh != head) ;
+      if ( PAGE_SIZE == bh->b_size ) {
+	ClearPageDirty(page);
+      }
     }
   } 
 }

_

