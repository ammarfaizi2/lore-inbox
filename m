Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267357AbTBKKXz>; Tue, 11 Feb 2003 05:23:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267473AbTBKKXz>; Tue, 11 Feb 2003 05:23:55 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.103]:58268 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S267357AbTBKKXy>;
	Tue, 11 Feb 2003 05:23:54 -0500
Date: Tue, 11 Feb 2003 16:08:03 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       Maneesh Soni <maneesh@in.ibm.com>
Subject: Re: 2.5.60-mm1
Message-ID: <20030211103802.GA2199@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20030211005516.03add509.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030211005516.03add509.akpm@digeo.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 11, 2003 at 08:55:53AM +0000, Andrew Morton wrote:
> +dcache_rcu-fast_walk-revert.patch
> +dcache_rcu-main.patch
> +dcache_rcu-nfs-server-fix.patch
> 
>  Maneesh fixed the knfsd problem.
> 


Andrew,

I think dcache_rcu-nfs-server-fix needs to be included irrespective of 
dcache_rcu.  All fs should be using dcache APIs to manipulate dcache hash 
lists.  This is in line with the dcache cleanup patch (dcache_rcu-1) from 
Maneesh that Linus accepted. This seems like a reasonable cleanup. One
change though, we don't need to grab dcache_lock while deleting
dentries from the private list and __d_drop() should suffice here.
Untested replacement patch included.

Thanks
Dipankar 


--- linux-2.5.59-dc/net/sunrpc/~rpc_pipe.c	2003-02-11 15:49:18.000000000 +0530
+++ linux-2.5.59-dc/net/sunrpc/rpc_pipe.c	2003-02-11 15:47:55.000000000 +0530
@@ -488,14 +488,15 @@
 		dentry = list_entry(pos, struct dentry, d_child);
 		if (!d_unhashed(dentry)) {
 			dget_locked(dentry);
-			list_del(&dentry->d_hash);
+			__d_drop(dentry);
 			list_add(&dentry->d_hash, &head);
 		}
 	}
 	spin_unlock(&dcache_lock);
 	while (!list_empty(&head)) {
 		dentry = list_entry(head.next, struct dentry, d_hash);
-		list_del_init(&dentry->d_hash);
+		/* Private list, so no dcache_lock needed and use __d_drop */
+		__d_drop(dentry);
 		if (dentry->d_inode) {
 			rpc_inode_setowner(dentry->d_inode, NULL);
 			simple_unlink(dir->d_inode, dentry);
