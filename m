Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132497AbRDUGAM>; Sat, 21 Apr 2001 02:00:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132500AbRDUGAD>; Sat, 21 Apr 2001 02:00:03 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:45828 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S132497AbRDUF74>; Sat, 21 Apr 2001 01:59:56 -0400
Date: Fri, 20 Apr 2001 22:59:43 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Jeremy Fitzhardinge <jeremy@goop.org>
cc: Alexander Viro <viro@math.psu.edu>,
        Linux Kernel <linux-kernel@vger.kernel.org>, <autofs@linux.kernel.org>
Subject: Re: Fix for SMP deadlock in autofs4
In-Reply-To: <20010420184613.B12962@goop.org>
Message-ID: <Pine.LNX.4.31.0104202253010.15553-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 20 Apr 2001, Jeremy Fitzhardinge wrote:
>
> I kept the dget/put out caution and ignorance, but they're clearly
> problematic.  I'm happy to drop them if holding dcache_lock is enough
> to keep the tree stable while I traverse it.

How does this patch look to you people?

It's untested, but looks fairly obvious. It removes the increment, and
changes autofs4_expire() to properly bump the count of the returned dentry
(and callers will dput() it when done). This may be unnecessarily careful,
but it's the RightThing(tm) to do.

Jeremy, would you mind verifying that this WorksForYou(tm)?

		Linus

-----
diff -u --recursive --new-file pre5/linux/fs/autofs4/expire.c linux/fs/autofs4/expire.c
--- pre5/linux/fs/autofs4/expire.c	Mon Oct 23 21:57:38 2000
+++ linux/fs/autofs4/expire.c	Fri Apr 20 22:57:51 2001
@@ -98,8 +98,6 @@
 		 top, count));
 	this_parent = top;

-	count--;	/* top is passed in after being dgot */
-
 	if (is_autofs4_dentry(top)) {
 		count--;
 		DPRINTK(("is_tree_busy: autofs; count=%d\n", count));
@@ -168,8 +166,6 @@
 	unsigned long timeout;
 	struct dentry *root = sb->s_root;
 	struct list_head *tmp;
-	struct dentry *d;
-	struct vfsmount *p;

 	if (!sbi->exp_timeout || !root)
 		return NULL;
@@ -208,23 +204,17 @@
 			     attempts if expire fails the first time */
 			ino->last_used = now;
 		}
-		p = mntget(mnt);
-		d = dget_locked(dentry);
-
-		if (!is_tree_busy(p, d)) {
+		if (!is_tree_busy(mnt, dentry)) {
 			DPRINTK(("autofs_expire: returning %p %.*s\n",
 				 dentry, (int)dentry->d_name.len, dentry->d_name.name));
 			/* Start from here next time */
 			list_del(&root->d_subdirs);
 			list_add(&root->d_subdirs, &dentry->d_child);
+			dget(dentry);
 			spin_unlock(&dcache_lock);

-			dput(d);
-			mntput(p);
 			return dentry;
 		}
-		dput(d);
-		mntput(p);
 	}
 	spin_unlock(&dcache_lock);

@@ -251,6 +241,7 @@
 	pkt.len = dentry->d_name.len;
 	memcpy(pkt.name, dentry->d_name.name, pkt.len);
 	pkt.name[pkt.len] = '\0';
+	dput(dentry);

 	if ( copy_to_user(pkt_p, &pkt, sizeof(struct autofs_packet_expire)) )
 		return -EFAULT;
@@ -278,6 +269,7 @@
 		de_info->flags |= AUTOFS_INF_EXPIRING;
 		ret = autofs4_wait(sbi, &dentry->d_name, NFY_EXPIRE);
 		de_info->flags &= ~AUTOFS_INF_EXPIRING;
+		dput(dentry);
 	}

 	return ret;

