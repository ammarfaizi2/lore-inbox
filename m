Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264265AbUEXMEB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264265AbUEXMEB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 08:04:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264263AbUEXMDs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 08:03:48 -0400
Received: from canuck.infradead.org ([205.233.217.7]:38151 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S264265AbUEXMDR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 08:03:17 -0400
Date: Mon, 24 May 2004 08:03:15 -0400
From: hch@infradead.org
To: "Peter J. Braam" <braam@clusterfs.com>
Cc: torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       "'Phil Schwan'" <phil@clusterfs.com>
Subject: Re: [PATCH/RFC] Lustre VFS patch
Message-ID: <20040524120315.GC26863@infradead.org>
Mail-Followup-To: hch@infradead.org, "Peter J. Braam" <braam@clusterfs.com>,
	torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
	'Phil Schwan' <phil@clusterfs.com>
References: <20040524114009.96CE13100E2@moraine.clusterfs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040524114009.96CE13100E2@moraine.clusterfs.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> vfs-dcache_locking-vanilla-2.6.patch
> 
>   A trivial patch to make functions available to lustre that do
>   d_move, d_rehash, without taking/dropping the dcache lock.


-void d_rehash(struct dentry * entry)
+void __d_rehash(struct dentry * entry)
 {
 	struct hlist_head *list = d_hash(entry->d_parent, entry->d_name.hash);
-	spin_lock(&dcache_lock);
  	entry->d_vfs_flags &= ~DCACHE_UNHASHED;
 	entry->d_bucket = list;
  	hlist_add_head_rcu(&entry->d_hash, list);
+}
+
+EXPORT_SYMBOL(__d_rehash);

looks okay as change but explanation is missing.

+EXPORT_SYMBOL(__d_move);
+
+void d_move(struct dentry *dentry, struct dentry *target)
+{
+	spin_lock(&dcache_lock);
+	__d_move(dentry, target);
 	spin_unlock(&dcache_lock);
 }

dito.
 
