Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268286AbRHTSW5>; Mon, 20 Aug 2001 14:22:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268071AbRHTSWs>; Mon, 20 Aug 2001 14:22:48 -0400
Received: from SNAP.THUNK.ORG ([216.175.175.173]:10765 "EHLO snap.thunk.org")
	by vger.kernel.org with ESMTP id <S267992AbRHTSWk>;
	Mon, 20 Aug 2001 14:22:40 -0400
Date: Mon, 20 Aug 2001 14:22:15 -0400
From: Theodore Tso <tytso@mit.edu>
To: Theodore Tso <tytso@mit.edu>, Yusuf Goolamabbas <yusufg@outblaze.com>,
        alan@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: Your ext2 optimisation for readdir+stat
Message-ID: <20010820142215.A18301@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	Yusuf Goolamabbas <yusufg@outblaze.com>, alan@redhat.com,
	linux-kernel@vger.kernel.org
In-Reply-To: <20010820042921.14473.qmail@yusufg.portal2.com> <20010820082440.C8399@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <20010820082440.C8399@thunk.org>; from tytso@MIT.EDU on Mon, Aug 20, 2001 at 08:24:40AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ Alan, please ignore the previous e-mail I sent you; shortly after I
  sent this out, Yosuf pointed out that that I had sent it to 
  vger.rutgers.org instead of vger.kernel.org, and sct pointed out that
  I had introduced an infinite loop in the error handling case.  So this 
  e-mail has a revised patch, plus it's sent to the correct e-mail
  address for lkml.  :-)  -- Ted ]

On Mon, Aug 20, 2001 at 04:29:21AM -0000, Yusuf Goolamabbas wrote:
> Hi Ted, I just came across your email on ext2-devel,debian-devel about
> ext2 optimisations when doing a readdir+stat. 
> 
> This may be a dumb question but would your patch have any impact on
> Linux client NFS mounts when the underlying filesystem may not be ext2

It will have absolutely no effect if the underlying filesystem is not
ext2; the change is to the ext2 low-level directory lookup routine,
after all.  

> Alan, Would you consider this for 2.2.20 ?. Would your patch help with
> the Nautilus optimizations you recently spent some time on ?

The patch won't work for the 2.2 kernels or 2.4 ext3, since it
requires that the directories-in-page-cache change.  It's
theoretically possible to rewrite the change for the old-style
ext2/3_find_entry code, but (a) the ext2_find_entry() function before
it was modified to use the page cache is rather icky, and (b) I don't
particularly care about 2.2 at this point.

The only reason why I might try to do this work is if we really want
this optimization in ext3 before we add support for putting
directories in the page cache (which isn't going to happen before the
ext3 1.0 release), but as I said, it would require messing with a
complicated bit of code, and it's not high on my priority list at the
moment.

> Ted, Any chance you can generate a patch for -ac kernels, Linus
> kernels suck in VM right now

The patch applies completely cleanly into the -ac kernel tree, without
even any patch offsets --- I just tried it against 2.4.8-ac7.

Alan, I think this is a trivial enough change, which can provide a
significant performance improvement.... "ls -l" on a directory with
50,000 entries and a cold dcache goes down from an elapsed time of
3:03 minutes (with 180 seconds of system cpu time) to an elapsed time
of 4.67 seconds (with 1.7 seconds of system cpu time).  So I think
it'd be worthwhile to get this into the 2.4 -ac tree, and to feed it
to Linus.

Compared the sorts of much higher-risk changes going into 2.4 at the
moment, this changes no locking semantics, makes no on-disk format
changes, and has no any global VM effects.  It also makes a huge
performance difference, so it seems reasonable to get this into 2.4
mainline.

						- Ted


Patch generated: on Mon Aug 20 13:30:33 EDT 2001 by tytso@think
against Linux version 2.4.8
 
===================================================================
RCS file: fs/ext2/RCS/dir.c,v
retrieving revision 1.1
diff -u -r1.1 fs/ext2/dir.c
--- fs/ext2/dir.c	2001/08/18 11:11:30	1.1
+++ fs/ext2/dir.c	2001/08/20 16:49:09
@@ -303,7 +303,7 @@
 	const char *name = dentry->d_name.name;
 	int namelen = dentry->d_name.len;
 	unsigned reclen = EXT2_DIR_REC_LEN(namelen);
-	unsigned long n;
+	unsigned long start, n;
 	unsigned long npages = dir_pages(dir);
 	struct page *page = NULL;
 	ext2_dirent * de;
@@ -311,24 +311,32 @@
 	/* OFFSET_CACHE */
 	*res_page = NULL;
 
-	for (n = 0; n < npages; n++) {
+	start = dir->u.ext2_i.i_dir_start_lookup;
+	if (start >= npages)
+		start = 0;
+	n = start;
+	do {
 		char *kaddr;
 		page = ext2_get_page(dir, n);
-		if (IS_ERR(page))
-			continue;
-
-		kaddr = page_address(page);
-		de = (ext2_dirent *) kaddr;
-		kaddr += PAGE_CACHE_SIZE - reclen;
-		for ( ; (char *) de <= kaddr ; de = ext2_next_entry(de))
-			if (ext2_match (namelen, name, de))
-				goto found;
-		ext2_put_page(page);
-	}
+		if (!IS_ERR(page)) {
+			kaddr = page_address(page);
+			de = (ext2_dirent *) kaddr;
+			kaddr += PAGE_CACHE_SIZE - reclen;
+			while ((char *) de <= kaddr) {
+				if (ext2_match (namelen, name, de))
+					goto found;
+				de = ext2_next_entry(de);
+			}
+			ext2_put_page(page);
+		}
+		if (++n >= npages)
+			n = 0;
+	} while (n != start);
 	return NULL;
 
 found:
 	*res_page = page;
+	dir->u.ext2_i.i_dir_start_lookup = n;
 	return de;
 }
 
===================================================================
RCS file: include/linux/RCS/ext2_fs_i.h,v
retrieving revision 1.1
diff -u -r1.1 include/linux/ext2_fs_i.h
--- include/linux/ext2_fs_i.h	2001/08/18 11:10:48	1.1
+++ include/linux/ext2_fs_i.h	2001/08/18 11:11:18
@@ -34,6 +34,7 @@
 	__u32	i_next_alloc_goal;
 	__u32	i_prealloc_block;
 	__u32	i_prealloc_count;
+	__u32	i_dir_start_lookup;
 	int	i_new_inode:1;	/* Is a freshly allocated inode */
 };
 
