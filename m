Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262597AbUKQWiW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262597AbUKQWiW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 17:38:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262593AbUKQWgI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 17:36:08 -0500
Received: from thunk.org ([69.25.196.29]:10961 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S262596AbUKQWfC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 17:35:02 -0500
Date: Wed, 17 Nov 2004 17:34:36 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Andrew Morton <akpm@osdl.org>
Cc: r6144 <rainy6144@gmail.com>, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net, phillips@istop.com,
       Alex Tomas <alex@clusterfs.com>, Christopher Li <chrisl@vmware.com>,
       Christopher Li <ext2-devel@chrisli.org>,
       "Stephen C. Tweedie" <sct@redhat.com>
Subject: Re: Fw: [POSSIBLE-BUG] telldir() broken on ext3 dir_index'd directories just after the first entry.
Message-ID: <20041117223436.GB5334@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Andrew Morton <akpm@osdl.org>, r6144 <rainy6144@gmail.com>,
	linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net,
	phillips@istop.com, Alex Tomas <alex@clusterfs.com>,
	Christopher Li <chrisl@vmware.com>,
	Christopher Li <ext2-devel@chrisli.org>,
	"Stephen C. Tweedie" <sct@redhat.com>
References: <20041116183813.11cbf280.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041116183813.11cbf280.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> [1.] One line summary of the problem:
> telldir() broken on large ext3 dir_index'd directories because
> getdents() gives d_off==0 for the first entry

Here's a patch which fixes the problem, but note the following warning
from the readdir man page:

       According to POSIX, the dirent structure contains a field char d_name[]
       of  unspecified  size,  with  at most NAME_MAX characters preceding the
       terminating null character.  Use of other fields will harm  the  porta-
       bility  of  your  programs. 

Also, as always, telldir() and seekdir() are truly awful interfaces
because they implicitly assume that (a) a directory is a linear data
structure, and (b) that the position in a directory can be expressed
in a cookie which hsa only 31 bits on 32-bit systems. 

So there will be hash colliions that will cause programs that assume
that seekdir(dirent->d_off) will always return the next directory
entry to sometimes lose directory entries in the
not-as-unlikely-as-we-would wish case of a 31-bit hash collision.
Really, any program which is using telldir/seekdir really should be
rewritten to not use these interfaces if at all possible.  So with
these caveats....

						- Ted

Here is a patch which causes d_off of '.' to be 1, and for seekdir(1)
to cause readdir to return the directory entry of '..'.  

Signed-off-by: "Theodore Ts'o" <tytso@mit.edu>

===== fs/ext3/namei.c 1.59 vs edited =====
--- 1.59/fs/ext3/namei.c	2004-10-19 05:40:30 -04:00
+++ edited/fs/ext3/namei.c	2004-11-17 17:14:06 -05:00
@@ -610,10 +610,15 @@ int ext3_htree_fill_tree(struct file *di
 		de = (struct ext3_dir_entry_2 *) frames[0].bh->b_data;
 		if ((err = ext3_htree_store_dirent(dir_file, 0, 0, de)) != 0)
 			goto errout;
+		count++;
+		start_hash=2;
+	}
+	if (start_hash==2 && start_minor_hash==0) {
+		de = (struct ext3_dir_entry_2 *) frames[0].bh->b_data;
 		de = ext3_next_entry(de);
-		if ((err = ext3_htree_store_dirent(dir_file, 0, 0, de)) != 0)
+		if ((err = ext3_htree_store_dirent(dir_file, 2, 0, de)) != 0)
 			goto errout;
-		count += 2;
+		count++;
 	}
 
 	while (1) {
