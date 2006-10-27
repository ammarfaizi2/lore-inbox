Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945972AbWJ0Gcm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945972AbWJ0Gcm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 02:32:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946034AbWJ0Gcl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 02:32:41 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:32919 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1945972AbWJ0Gcl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 02:32:41 -0400
Message-ID: <4541A803.9000004@sw.ru>
Date: Fri, 27 Oct 2006 10:32:35 +0400
From: Vasily Averin <vvs@sw.ru>
User-Agent: Thunderbird 1.5.0.7 (X11/20060911)
MIME-Version: 1.0
To: David Howells <dhowells@redhat.com>
CC: aviro@redhat.com, Neil Brown <neilb@suse.de>, Jan Blunck <jblunck@suse.de>,
       Olaf Hering <olh@suse.de>, Balbir Singh <balbir@in.ibm.com>,
       Kirill Korotaev <dev@openvz.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       devel@openvz.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [Q] missing unused dentry in prune_dcache()?
References: <4540A0C5.60700@sw.ru>  <453F58FB.4050407@sw.ru> <19857.1161869015@redhat.com>
In-Reply-To: <19857.1161869015@redhat.com>
X-Enigmail-Version: 0.94.1.0
Content-Type: text/plain; charset=KOI8-R
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells wrote:
> Vasily Averin <vvs@sw.ru> wrote:
> 
>> I've noticed one more minor issue in your patch: in
>> shrink_dcache_for_umount_subtree() function you decrement
>> dentry_stat.nr_dentry without dcache_lock.
> 
> How about the attached patch?
I'm sorry, but your patch is wrong:
you have mixed calculation of 2 variables:
dentry_stat.nr_unused -- were correct, it was decremented under dcache_lock.
dentry_stat.nr_dentry -- were incorrect, it was decremented without dcache_lock.

You should correct dentry_stat.nr_dentry, but instead you broke calculation of
dentry_stat.nr_unused.

I've fixed this issue by following patch.

Thank you,
	Vasily Averin
---
VFS: Fix an error in dentry_stat.nr_dentry counting

From: Vasily Averin <vvs@sw.ru>

Fix an error in dentry_stat.nr_dentry counting in
shrink_dcache_for_umount_subtree() in which the count is modified without the
dcache_lock held.

Signed-Off-By: Vasily Averin <vvs@sw.ru>

--- linux-2.6.19-rc3/fs/dcache.c.nrdntr	2006-10-26 15:14:51.000000000 +0400
+++ linux-2.6.19-rc3/fs/dcache.c	2006-10-27 10:24:07.000000000 +0400
@@ -554,6 +554,7 @@ repeat:
 static void shrink_dcache_for_umount_subtree(struct dentry *dentry)
 {
 	struct dentry *parent;
+	unsigned detached = 0;

 	BUG_ON(!IS_ROOT(dentry));

@@ -618,7 +619,7 @@ static void shrink_dcache_for_umount_sub
 				atomic_dec(&parent->d_count);

 			list_del(&dentry->d_u.d_child);
-			dentry_stat.nr_dentry--;	/* For d_free, below */
+			detached++;

 			inode = dentry->d_inode;
 			if (inode) {
@@ -635,8 +636,8 @@ static void shrink_dcache_for_umount_sub
 			/* finished when we fall off the top of the tree,
 			 * otherwise we ascend to the parent and move to the
 			 * next sibling if there is one */
-			if (!parent)
-				return;
+			if (!parent)
+				goto out;

 			dentry = parent;

@@ -645,6 +646,11 @@ static void shrink_dcache_for_umount_sub
 		dentry = list_entry(dentry->d_subdirs.next,
 				    struct dentry, d_u.d_child);
 	}
+out:
+	/* several dentries were freed, need to correct nr_dentry */
+	spin_lock(&dcache_lock);
+	dentry_stat.nr_dentry -= detached;
+	spin_unlock(&dcache_lock);
 }

 /*
