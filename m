Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314242AbSEXHRq>; Fri, 24 May 2002 03:17:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314266AbSEXHRp>; Fri, 24 May 2002 03:17:45 -0400
Received: from [195.223.140.120] ([195.223.140.120]:15696 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S314242AbSEXHRn>; Fri, 24 May 2002 03:17:43 -0400
Date: Fri, 24 May 2002 09:16:57 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Alexander Viro <viro@math.psu.edu>
Subject: negative dentries wasting ram
Message-ID: <20020524071657.GI21164@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I actually noticed that after an unlink the dentry wasn't released (the
inode was released the dentry wasn't). At first I thought it was a bug,
then while reading the code I noticed this is intentional.  So after
creating some thousand of different names and then deleting them and
then recreating again different names and deleting them, the size of the
dcache keeps growing again and again like a memory leak until the vm
starts shrinking unrelated pagecache and then finally prune_dcache
started collecting the first negative dentries away after the dcache
grown like crazy and the hashtable is overfull.

You can try yourself with:

	while :; do >$RANDOM; done

and then rm *, then restart, and rm again, and monitor the size of the
i/dcache via slabinfo, inodes returns back to zero after rm -r, dcache
only goes up.

as far I can see that negative dentries are not caching anything, they
should be dropped immediatly, they even slowdown the lookups because
they're hashed.

I'm pretty sure I want to avoid to waste my ram with negative dentries,
after I `rm` a file I want the dentry for such file to go away too, not
only the inode. I want free ram space for useful cache.

So I did this patch that seems to work for me (this also takes care of
when a creat fails, there may be other corner cases like creat-failure).
The directories were just released correctly because of d_unhash, it was
a problem only for the files (and of course the negative dentries are
all collected away when the parent dir is rmdirred, but how do you know
that the parent dir will ever go away?). I can very well imagine spools
where an huge number of files is regularly created and deleted with
timestamped names, always different and the parent dir never going away.

Negative dentries should be only temporary entities, for example between
the allocation of the dentry and the create of the inode, they shouldn't
be left around waiting the vm to collect them. They maybe more
intersting with nfs, maybe if something is been invalidated because the
server timeouts or stuff like that, while we wait it's fine to have
negative dentries, but to ensure good performance negative dentries
should be always controlled and never left floating around for an
undefinite time, since they are no cache, they should be collected away
at the last dput (infact another approch is to d_drop implicitly inside
dput, if d_inode is null, right before the check for d_hash but I didn't
took that approch because it was less obvious for fs like nfs that
may make more special usage of negative dentries).

the patch is only slightly tested under uml, the first chunk is
obviously safe, the other a bit less, so beware that it can corrupt your
fs.

Comments?

--- 2.4.19pre8aa4/fs/dcache.c.~1~	Fri May 24 05:57:21 2002
+++ 2.4.19pre8aa4/fs/dcache.c	Fri May 24 08:33:27 2002
@@ -812,6 +812,7 @@ out:
  
 void d_delete(struct dentry * dentry)
 {
+#ifdef DENTRY_WASTE_RAM
 	/*
 	 * Are we the only user?
 	 */
@@ -821,6 +822,7 @@ void d_delete(struct dentry * dentry)
 		return;
 	}
 	spin_unlock(&dcache_lock);
+#endif
 
 	/*
 	 * If not, just drop the dentry and let dput
--- 2.4.19pre8aa4/fs/namei.c.~1~	Fri May 24 05:57:21 2002
+++ 2.4.19pre8aa4/fs/namei.c	Fri May 24 08:35:05 2002
@@ -1055,6 +1055,10 @@ do_last:
 			mode &= ~current->fs->umask;
 		error = vfs_create(dir->d_inode, dentry, mode);
 		up(&dir->d_inode->i_sem);
+#ifndef DENTRY_WASTE_RAM
+		if (error)
+			d_drop(dentry);
+#endif
 		dput(nd->dentry);
 		nd->dentry = dentry;
 		if (error)


Andrea
