Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264307AbUEXPfm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264307AbUEXPfm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 11:35:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264308AbUEXPfm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 11:35:42 -0400
Received: from pincoya.inf.utfsm.cl ([200.1.19.3]:7296 "EHLO
	pincoya.inf.utfsm.cl") by vger.kernel.org with ESMTP
	id S264307AbUEXPfk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 11:35:40 -0400
Message-Id: <200405241533.i4OFXnI01224@pincoya.inf.utfsm.cl>
To: hch@infradead.org
cc: "Peter J. Braam" <braam@clusterfs.com>, torvalds@osdl.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org, "'Phil Schwan'" <phil@clusterfs.com>,
       vonbrand@inf.utfsm.cl
Subject: Re: [PATCH/RFC] Lustre VFS patch 
In-reply-to: Your message of "Mon, 24 May 2004 08:03:15 -0400."
             <20040524120315.GC26863@infradead.org> 
X-mailer: MH [Version 6.8.4]
X-charset: ISO_8859-1
Date: Mon, 24 May 2004 11:33:49 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hch@infradead.org said:
> > vfs-dcache_locking-vanilla-2.6.patch
> > 
> >   A trivial patch to make functions available to lustre that do
> >   d_move, d_rehash, without taking/dropping the dcache lock.
> 
> 
> -void d_rehash(struct dentry * entry)
> +void __d_rehash(struct dentry * entry)
>  {
>  	struct hlist_head *list = d_hash(entry->d_parent, entry->d_name.hash);
> -	spin_lock(&dcache_lock);
>   	entry->d_vfs_flags &= ~DCACHE_UNHASHED;
>  	entry->d_bucket = list;
>   	hlist_add_head_rcu(&entry->d_hash, list);
> +}

Won't you also need a non-__ version, perhaps like so:

   void d_rehash(struct dentry *entry)
   {
       spin_lock(&dcache_lock);
       __d_rehash(entry);
       spin_unlock(&dcache_lock);
   }
   EXPORT_SYMBOL(d_rehash);

?

Signed-off-by: Horst H. von Brand <vonbrand@inf.utfsm.cl>

(Surely such a triviality doesn't need this, but...)
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
