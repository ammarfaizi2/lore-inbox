Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316928AbSFRELi>; Tue, 18 Jun 2002 00:11:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317305AbSFRELh>; Tue, 18 Jun 2002 00:11:37 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:26631 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S316928AbSFRELg>;
	Tue, 18 Jun 2002 00:11:36 -0400
Message-ID: <3D0EB3F2.C128F97C@zip.com.au>
Date: Mon, 17 Jun 2002 21:15:46 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andreas Dilger <adilger@clusterfs.com>
CC: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: ext2 errors w/2.5.x
References: <20020617.195611.61846581.davem@redhat.com> <20020618032544.GM22427@clusterfs.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Dilger wrote:
> 
> On Jun 17, 2002  19:56 -0700, David S. Miller wrote:
> > I started seeing these occaisionally on my SMP boxes about a month or
> > two ago, is anyone else seeing something similar?
> >
> > EXT2-fs error (device sd(8,17)): ext2_find_entry: zero-length directory entry
> >
> > Upon reboot e2fsck is forced to run (since the partition is marked as
> > having errors by the kernel) and no problems are discovered.
> >
> > Any clues?
> 
> This would appear to be from accessing a buffer (page) which has not yet
> been read from disk.  Otherwise you would have an error from e2fsck also.
> Andrew has been mucking the most in this area...
> 

Not that, I hope.  Possibly it's the interaction between
block_write_full_pages's memset outside i_size, truncate and lookup.
It took me a ridiculous amount of time to get that "correct", so
it's a suspicion point.   Or possibly locking between lookup and
truncate (rmdir) and/or creat.

Dave, I assume this is with 8k pages and 4k blocks?

Is it repeatable enough to conduct a little experiment?  Like, lock the page
in ext2_find_entry?

--- linux-2.5.22/fs/ext2/dir.c	Wed May 29 11:42:43 2002
+++ 25/fs/ext2/dir.c	Mon Jun 17 20:50:48 2002
@@ -348,6 +348,7 @@ struct ext2_dir_entry_2 * ext2_find_entr
 		char *kaddr;
 		page = ext2_get_page(dir, n);
 		if (!IS_ERR(page)) {
+			lock_page(page);
 			kaddr = page_address(page);
 			de = (ext2_dirent *) kaddr;
 			kaddr += ext2_last_byte(dir, n) - reclen;
@@ -355,6 +356,7 @@ struct ext2_dir_entry_2 * ext2_find_entr
 				if (de->rec_len == 0) {
 					ext2_error(dir->i_sb, __FUNCTION__,
 						"zero-length directory entry");
+					unlock_page(page);
 					ext2_put_page(page);
 					goto out;
 				}
@@ -367,10 +369,12 @@ struct ext2_dir_entry_2 * ext2_find_entr
 		if (++n >= npages)
 			n = 0;
 	} while (n != start);
+	unlock_page(page);
 out:
 	return NULL;
 
 found:
+	unlock_page(page);
 	*res_page = page;
 	ei->i_dir_start_lookup = n;
 	return de;


-
