Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261436AbTC0WOu>; Thu, 27 Mar 2003 17:14:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261441AbTC0WOu>; Thu, 27 Mar 2003 17:14:50 -0500
Received: from smtp09.iddeo.es ([62.81.186.19]:41155 "EHLO smtp09.retemail.es")
	by vger.kernel.org with ESMTP id <S261436AbTC0WOs>;
	Thu, 27 Mar 2003 17:14:48 -0500
Date: Thu, 27 Mar 2003 23:25:59 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: Christoph Hellwig <hch@infradead.org>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] d_alloc_anon for 2.4.21-pre6
Message-ID: <20030327222559.GA3420@werewolf.able.es>
References: <Pine.LNX.4.53L.0303262107480.2544@freak.distro.conectiva> <20030327165112.A2395@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20030327165112.A2395@infradead.org>; from hch@infradead.org on Thu, Mar 27, 2003 at 17:51:12 +0100
X-Mailer: Balsa 2.0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 03.27, Christoph Hellwig wrote:
> [$BIGNUM repost since August 2002, still zero feedback]
> 
> The rewritten 2.5 nfsd export handling introduce a funcion,
> d_alloc_anon, to get an dentry for a given inode, either taking
> a well-connected one or allocating a new one.
> 
> In 2.4 we have the functionality that it does in 2.4 duplicated over
> nfsd and all filesystems having their own fh_to_dentry method, and
> XFS needs even more instances of this for other handle to dentry
> conversations.
> 
> This patch adds d_alloc_anon with exactly the same API as in 2.5, but
> the 2.4ish functionality instead to the kernel and switches nfsd, fat
> and reiserfs over to it.
> 

The patch I had from time ago in -jam also included this switch to
list_for_each:

diff -uNr -Xdontdiff -p linux-2.4.20-pre4/fs/dcache.c linux/fs/dcache.c
--- linux-2.4.20-pre4/fs/dcache.c	Sat Aug 17 14:54:38 2002
+++ linux/fs/dcache.c	Tue Aug 20 11:39:48 2002
@@ -247,24 +247,22 @@ struct dentry * dget_locked(struct dentr
 
 struct dentry * d_find_alias(struct inode *inode)
 {
-	struct list_head *head, *next, *tmp;
-	struct dentry *alias;
+	struct dentry *dentry;
+	struct list_head *p;
 
 	spin_lock(&dcache_lock);
-	head = &inode->i_dentry;
-	next = inode->i_dentry.next;
-	while (next != head) {
-		tmp = next;
-		next = tmp->next;
-		alias = list_entry(tmp, struct dentry, d_alias);
-		if (!list_empty(&alias->d_hash)) {
-			__dget_locked(alias);
-			spin_unlock(&dcache_lock);
-			return alias;
-		}
+	list_for_each(p, &inode->i_dentry) {
+		dentry = list_entry(p, struct dentry, d_alias);
+		if (!list_empty(&dentry->d_hash))
+			goto found;
 	}
 	spin_unlock(&dcache_lock);
 	return NULL;
+
+found:
+	__dget_locked(dentry);
+	spin_unlock(&dcache_lock);
+	return dentry;
 }
 
 /*

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.1 (Bamboo) for i586
Linux 2.4.21-pre5-jam1 (gcc 3.2.2 (Mandrake Linux 9.1 3.2.2-3mdk))
