Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261586AbTKBJYu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Nov 2003 04:24:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261595AbTKBJYu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Nov 2003 04:24:50 -0500
Received: from linuxhacker.ru ([217.76.32.60]:6530 "EHLO shrek.linuxhacker.ru")
	by vger.kernel.org with ESMTP id S261586AbTKBJYs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Nov 2003 04:24:48 -0500
Date: Sun, 2 Nov 2003 11:18:47 +0200
From: Oleg Drokin <green@linuxhacker.ru>
To: Andrew Morton <akpm@osdl.org>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0test9 Reiserfs boot time "buffer layer error at fs/buffer.c:431"
Message-ID: <20031102091847.GO3940@linuxhacker.ru>
References: <20031029141931.6c4ebdb5.akpm@osdl.org> <E1AGCUJ-00016g-00@gondolin.me.apana.org.au> <20031101233354.1f566c80.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031101233354.1f566c80.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Sat, Nov 01, 2003 at 11:33:54PM -0800, Andrew Morton wrote:
> > >> (These buffers are there because reiserfs first reads that offset (in bytes)
> > >> with whatever current blocksize is, except they should have been invalidated of
> > >> course).
> > >> Even if invalidate_bdev() -> invalidate_inode_pages() have not cleaned
> > >> everything, truncate_inode_pages() should have done this.
> > > yup.
> > The person who had the problem is actually using the Debian tree which
> > carried over a patch from 2.4 that removed the truncate_inode_pages
> > call in set_blocksize.  So I appologise for the noise.

Sigh.

> truncate_inode_pages() will unconditionally remove the pages from
> pagecache: they're gone.  So if some poorly behaved piece of code
> (reiserfs's read_super_block()) holds a reference against a buffer, that
> piece of code ends up owning the page - the VFS has lost interest in it.

Here's the patch against reiserfs in 2.6 (2.4 does not need it as this bit
of code is different and correct there).

===== fs/reiserfs/super.c 1.69 vs edited =====
--- 1.69/fs/reiserfs/super.c	Tue Sep 23 07:16:25 2003
+++ edited/fs/reiserfs/super.c	Sun Nov  2 11:11:36 2003
@@ -942,6 +942,7 @@
 {
     struct buffer_head * bh;
     struct reiserfs_super_block * rs;
+    int fs_blocksize;
  
 
     bh = sb_bread (s, offset / s->s_blocksize);
@@ -961,8 +962,9 @@
     //
     // ok, reiserfs signature (old or new) found in at the given offset
     //    
-    sb_set_blocksize (s, sb_blocksize(rs));
+    fs_blocksize = sb_blocksize(rs);
     brelse (bh);
+    sb_set_blocksize (s, fs_blocksize);
     
     bh = sb_bread (s, offset / s->s_blocksize);
     if (!bh) {

Bye,
    Oleg
