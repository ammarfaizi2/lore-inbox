Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261702AbUKRExs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261702AbUKRExs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 23:53:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262543AbUKRExs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 23:53:48 -0500
Received: from thunk.org ([69.25.196.29]:24533 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S261702AbUKRExp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 23:53:45 -0500
Date: Wed, 17 Nov 2004 23:53:36 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, r6144 <rainy6144@gmail.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       "ext2-devel@lists.sourceforge.net" <ext2-devel@lists.sourceforge.net>,
       phillips@istop.com, Alex Tomas <alex@clusterfs.com>,
       Christopher Li <chrisl@vmware.com>,
       Christopher Li <ext2-devel@chrisli.org>
Subject: Re: Fw: [POSSIBLE-BUG] telldir() broken on ext3 dir_index'd directories just after the first entry.
Message-ID: <20041118045336.GA5236@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	"Stephen C. Tweedie" <sct@redhat.com>,
	Andrew Morton <akpm@osdl.org>, r6144 <rainy6144@gmail.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	"ext2-devel@lists.sourceforge.net" <ext2-devel@lists.sourceforge.net>,
	phillips@istop.com, Alex Tomas <alex@clusterfs.com>,
	Christopher Li <chrisl@vmware.com>,
	Christopher Li <ext2-devel@chrisli.org>
References: <20041116183813.11cbf280.akpm@osdl.org> <20041117223436.GB5334@thunk.org> <1100736003.11047.14.camel@sisko.sctweedie.blueyonder.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1100736003.11047.14.camel@sisko.sctweedie.blueyonder.co.uk>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 18, 2004 at 12:00:05AM +0000, Stephen C. Tweedie wrote:
> 
> Doesn't this make things worse?  
> don't we end up silently ignoring all dirents with a major hash <= 1,
> even for unbroken getdents() with no intervening seekdir?  

Oops, yes, I screwed up.

> If we're going to do this, I think we need to stuff . and .. into the
> rbtree with the right hashes, but without ignoring other existing
> dirents with colliding hashes.

We can't just do that, because there are programs that's assume '.'
and '..' are the first and second entries in the directory.  Yes, they
are broken and non-portable, but so are programs that depend on
d_off....

So instead what we need to do is wire '.' and '..' to have hash values
of (0,0) and (2,0), respectively, without ignoring other existing
dirents with colliding hashes.  (In those cases the programs will
break, but they are statistically rare, and there's not much we can do
in those cases anyway.)

This patch should do this.

Signed-off-by: "Theodore Ts'o" <tytso@mit.edu>

--- 1.59/fs/ext3/namei.c	2004-10-19 05:40:30 -04:00
+++ edited/fs/ext3/namei.c	2004-11-17 23:05:35 -05:00
@@ -610,10 +610,14 @@ int ext3_htree_fill_tree(struct file *di
 		de = (struct ext3_dir_entry_2 *) frames[0].bh->b_data;
 		if ((err = ext3_htree_store_dirent(dir_file, 0, 0, de)) != 0)
 			goto errout;
+		count++;
+	}
+	if (start_hash < 2 || (start_hash ==2 && start_minor_hash==0)) {
+		de = (struct ext3_dir_entry_2 *) frames[0].bh->b_data;
 		de = ext3_next_entry(de);
-		if ((err = ext3_htree_store_dirent(dir_file, 0, 0, de)) != 0)
+		if ((err = ext3_htree_store_dirent(dir_file, 2, 0, de)) != 0)
 			goto errout;
-		count += 2;
+		count++;
 	}
 
 	while (1) {
