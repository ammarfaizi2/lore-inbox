Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262150AbTIHJNf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 05:13:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262167AbTIHJNf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 05:13:35 -0400
Received: from angband.namesys.com ([212.16.7.85]:10692 "EHLO
	angband.namesys.com") by vger.kernel.org with ESMTP id S262150AbTIHJNe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 05:13:34 -0400
Date: Mon, 8 Sep 2003 13:13:33 +0400
From: Oleg Drokin <green@namesys.com>
To: Daniel Blueman <daniel.blueman@gmx.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6.0-test4] [BUG] reiserfs_writepage()
Message-ID: <20030908091333.GC17718@namesys.com>
References: <14963.1062928209@www51.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14963.1062928209@www51.gmx.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Sun, Sep 07, 2003 at 11:50:09AM +0200, Daniel Blueman wrote:

> Let me know if any more info would help on this!
> EIP is at end_page_writeback+0x6a/0x82
>  [<c01df812>] reiserfs_write_full_page+0xe1/0x314
>  [<c0196b8e>] mpage_writepages+0x3de/0x538
>  [<c01dfa5b>] reiserfs_writepage+0x0/0x39
>  [<c0147501>] do_writepages+0x37/0x39

This patch should help.

Bye,
    Oleg

diff -Nru a/fs/reiserfs/inode.c b/fs/reiserfs/inode.c
--- a/fs/reiserfs/inode.c	Mon Sep  8 12:54:12 2003
+++ b/fs/reiserfs/inode.c	Mon Sep  8 12:54:12 2003
@@ -2048,8 +2048,8 @@
         last_offset = inode->i_size & (PAGE_CACHE_SIZE - 1) ;
 	/* no file contents in this page */
 	if (page->index >= end_index + 1 || !last_offset) {
-	    error = 0 ;
-	    goto done ;
+    	    unlock_page(page);
+	    return 0;
 	}
 	kaddr = kmap_atomic(page, KM_USER0);
 	memset(kaddr + last_offset, 0, PAGE_CACHE_SIZE-last_offset) ;
