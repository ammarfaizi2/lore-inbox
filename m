Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932092AbWAEIIt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932092AbWAEIIt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 03:08:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932103AbWAEIIt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 03:08:49 -0500
Received: from linuxhacker.ru ([217.76.32.60]:35510 "EHLO shrek.linuxhacker.ru")
	by vger.kernel.org with ESMTP id S932092AbWAEIIs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 03:08:48 -0500
Date: Thu, 5 Jan 2006 10:09:33 +0200
From: Oleg Drokin <green@linuxhacker.ru>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk
Subject: Re: d_instantiate_unique / NFS inode leakage?
Message-ID: <20060105080933.GK5743@linuxhacker.ru>
References: <20060105010047.GJ5743@linuxhacker.ru> <1136424407.7847.37.camel@lade.trondhjem.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1136424407.7847.37.camel@lade.trondhjem.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Thu, Jan 05, 2006 at 02:26:47AM +0100, Trond Myklebust wrote:
> >    Searching for inode leakage in NFS code (seen in 2.6.14 and 2.6.15 at least,
> >    have not tried earlier versions), I see suspicious place in
> >    d_instantiate_unique (the only user happens to be NFS).
> >    There if we have found aliased dentry that we return, inode reference is
> >    not dropped and inode is not attached anywhere, so it seems the reference
> >    to inode is leaked in that case.
> Yep, that looks like it ought to be the correct behaviour. Could you
> please also add a note to this effect in the DocBook header for
> d_instantiate_unique?

Sure.

--- fs/dcache.c.orig	2006-01-05 02:28:57.000000000 +0200
+++ fs/dcache.c	2006-01-05 10:04:02.000000000 +0200
@@ -808,10 +808,14 @@ void d_instantiate(struct dentry *entry,
  *
  * Fill in inode information in the entry. On success, it returns NULL.
  * If an unhashed alias of "entry" already exists, then we return the
- * aliased dentry instead.
+ * aliased dentry instead and drop one reference to inode.
  *
  * Note that in order to avoid conflicts with rename() etc, the caller
  * had better be holding the parent directory semaphore.
+ *
+ * This also assumes that the inode count has been incremented
+ * (or otherwise set) by the caller to indicate that it is now
+ * in use by the dcache.
  */
 struct dentry *d_instantiate_unique(struct dentry *entry, struct inode *inode)
 {
@@ -838,6 +842,7 @@ struct dentry *d_instantiate_unique(stru
 		dget_locked(alias);
 		spin_unlock(&dcache_lock);
 		BUG_ON(!d_unhashed(alias));
+		iput(inode);
 		return alias;
 	}
 	list_add(&entry->d_alias, &inode->i_dentry);

Bye,
    Oleg
