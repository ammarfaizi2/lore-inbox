Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316759AbSFUT1A>; Fri, 21 Jun 2002 15:27:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316763AbSFUT07>; Fri, 21 Jun 2002 15:26:59 -0400
Received: from 216-42-72-140.ppp.netsville.net ([216.42.72.140]:62915 "EHLO
	roc-24-169-102-121.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S316759AbSFUT06>; Fri, 21 Jun 2002 15:26:58 -0400
Subject: Re: ext3 performance bottleneck as the number of spindles gets large
From: Chris Mason <mason@suse.com>
To: mgross <mgross@unix-os.sc.intel.com>
Cc: Andrew Morton <akpm@zip.com.au>,
       "Griffiths, Richard A" <richard.a.griffiths@intel.com>,
       "'Jens Axboe'" <axboe@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lse-tech@lists.sourceforge.net
In-Reply-To: <3D13747A.3030804@unix-os.sc.intel.com>
References: <01BDB7EEF8D4D3119D95009027AE99951B0E63EA@fmsmsx33.fm.intel.com>
	<3D12DCB4.872269F6@zip.com.au>  <3D13747A.3030804@unix-os.sc.intel.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 21 Jun 2002 15:26:24 -0400
Message-Id: <1024687585.13539.209.camel@tiny>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-06-21 at 14:46, mgross wrote:
> Andrew Morton wrote:

> >
> >Please try the below patch (againt 2.4.19-pre10).  It halves the lock
> >contention, and it does that by making the fs twice as efficient, so
> >that's a bonus.
> >
> We'll give it a try.  I'm on travel right now so it may be a few days if 
> Richard doesn't get to before I get back.

You might want to try this too, Andrew fixed UPDATE_ATIME() to only call
the dirty_inode method once per second, but generic_file_write should do
the same.  It reduces BKL contention by reducing calls to ext3 and
reiserfs dirty_inode calls, which are much more expensive than simply
marking the inode dirty.

-chris

--- linux/mm/filemap.c Mon, 28 Jan 2002 09:51:50 -0500 
+++ linux/mm/filemap.c Sun, 12 May 2002 16:16:59 -0400 
@@ -2826,6 +2826,14 @@
 	}
 }
 
+static void update_inode_times(struct inode *inode) 
+{
+	time_t now = CURRENT_TIME;
+	if (inode->i_ctime != now || inode->i_mtime != now) {
+	    inode->i_ctime = inode->i_mtime = now;
+	    mark_inode_dirty_sync(inode);
+	} 
+}
 /*
  * Write to a file through the page cache. 
  *
@@ -2955,8 +2963,7 @@
 		goto out;
 
 	remove_suid(inode);
-	inode->i_ctime = inode->i_mtime = CURRENT_TIME;
-	mark_inode_dirty_sync(inode);
+	update_inode_times(inode);
 
 	if (file->f_flags & O_DIRECT)
 		goto o_direct;

