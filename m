Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261740AbTILPjj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 11:39:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261751AbTILPjj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 11:39:39 -0400
Received: from angband.namesys.com ([212.16.7.85]:28032 "EHLO
	angband.namesys.com") by vger.kernel.org with ESMTP id S261740AbTILPjh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 11:39:37 -0400
Date: Fri, 12 Sep 2003 19:39:35 +0400
From: Oleg Drokin <green@namesys.com>
To: Kyle Rose <krose+linux-kernel@krose.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Large-file corruption. ReiserFS? VFS?
Message-ID: <20030912153935.GA2693@namesys.com>
References: <87r82noyr9.fsf@nausicaa.krose.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r82noyr9.fsf@nausicaa.krose.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Thu, Sep 11, 2003 at 04:28:58PM -0400, Kyle Rose wrote:

> However, just as the write completed, the beginning of the file became
> corrupted.  I considered a 4GB problem to be likely, and re-tested

You are absolutely right.
Ther is a reiserfs problem that I just found based on your description.
The patch below should help. Please confirm that it works for you too.
Thanks a lot for the report.

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
