Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262330AbTINIlp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Sep 2003 04:41:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262332AbTINIlp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Sep 2003 04:41:45 -0400
Received: from angband.namesys.com ([212.16.7.85]:7564 "EHLO
	angband.namesys.com") by vger.kernel.org with ESMTP id S262330AbTINIln
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Sep 2003 04:41:43 -0400
Date: Sun, 14 Sep 2003 12:41:41 +0400
From: Oleg Drokin <green@namesys.com>
To: Hans Reiser <reiser@namesys.com>
Cc: George <george@xorgate.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6 kernel large file create problem
Message-ID: <20030914084141.GA28617@namesys.com>
References: <000501c37a0c$e2ad24a0$3eac18ac@geosxp> <3F63E898.4010803@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F63E898.4010803@namesys.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Sun, Sep 14, 2003 at 08:03:36AM +0400, Hans Reiser wrote:

> >I have a 300G reiserfs 3.6 file system created above a RAID0 (HPT372
> >controller) partition.  When I am using the 2.6.0-test5 kernel and create
> >files larger that 4GB they are corrupted with lots of trash throughout the
> >file.  When I use the same file system with the 2.4.22 kernel it works 
> >fine.
> this bug was just found and fixed, green has details.

Indeed.
Try this patch, it should help.
Tell us if you experience any problems with the patch.

Bye,
    Oleg

===== fs/reiserfs/file.c 1.22 vs edited =====
--- 1.22/fs/reiserfs/file.c	Fri Aug 15 05:17:00 2003
+++ edited/fs/reiserfs/file.c	Fri Sep 12 19:18:53 2003
@@ -779,7 +779,7 @@
     /* Now if all the write area lies past the file end, no point in
        maping blocks, since there is none, so we just zero out remaining
        parts of first and last pages in write area (if needed) */
-    if ( (pos & ~(PAGE_CACHE_SIZE - 1)) > inode->i_size ) {
+    if ( (pos & ~((loff_t)PAGE_CACHE_SIZE - 1)) > inode->i_size ) {
 	if ( from != 0 ) {/* First page needs to be partially zeroed */
 	    char *kaddr = kmap_atomic(prepared_pages[0], KM_USER0);
 	    memset(kaddr, 0, from);
@@ -801,9 +801,9 @@
        we need to allocate (calculated above) */
     /* Mask write position to start on blocksize, we do it out of the
        loop for performance reasons */
-    pos &= ~(inode->i_sb->s_blocksize - 1);
+    pos &= ~((loff_t) inode->i_sb->s_blocksize - 1);
     /* Set cpu key to the starting position in a file (on left block boundary)*/
-    make_cpu_key (&key, inode, 1 + ((pos) & ~(inode->i_sb->s_blocksize - 1)), TYPE_ANY, 3/*key length*/);
+    make_cpu_key (&key, inode, 1 + ((pos) & ~((loff_t) inode->i_sb->s_blocksize - 1)), TYPE_ANY, 3/*key length*/);
 
     reiserfs_write_lock(inode->i_sb); // We need that for at least search_by_key()
     for ( i = 0; i < num_pages ; i++ ) { 
