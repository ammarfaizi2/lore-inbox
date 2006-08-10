Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161033AbWHJFyD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161033AbWHJFyD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 01:54:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161043AbWHJFyC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 01:54:02 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:24788 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1161033AbWHJFyA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 01:54:00 -0400
Date: Thu, 10 Aug 2006 14:56:28 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: Christoph Lameter <clameter@sgi.com>
Cc: mpm@selenic.com, npiggin@suse.de, manfred@colorfullife.com,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] Simple Slab: A slab allocator with minimal meta
 information
Message-Id: <20060810145628.3d060c5f.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <Pine.LNX.4.64.0608092243410.5928@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.64.0608091744290.4966@schroedinger.engr.sgi.com>
	<20060810140153.e5932e76.kamezawa.hiroyu@jp.fujitsu.com>
	<Pine.LNX.4.64.0608092211320.5806@schroedinger.engr.sgi.com>
	<20060810144451.13591e4b.kamezawa.hiroyu@jp.fujitsu.com>
	<Pine.LNX.4.64.0608092243410.5928@schroedinger.engr.sgi.com>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Aug 2006 22:44:59 -0700 (PDT)
Christoph Lameter <clameter@sgi.com> wrote:

> On Thu, 10 Aug 2006, KAMEZAWA Hiroyuki wrote:
> 
> > Because of inode_init_once, many codes which uses inode uses initilization code.
> > And inode is one of heavy users of slab.
> 
> Probably just code copied from the same location. It has the same name.
> 
for example, ext3's copy of init_once() is
--
static void init_once(void * foo, kmem_cache_t * cachep, unsigned long flags)
{
        struct ext3_inode_info *ei = (struct ext3_inode_info *) foo;

        if ((flags & (SLAB_CTOR_VERIFY|SLAB_CTOR_CONSTRUCTOR)) ==
            SLAB_CTOR_CONSTRUCTOR) {
                INIT_LIST_HEAD(&ei->i_orphan);               ---------------(A)
#ifdef CONFIG_EXT3_FS_XATTR
                init_rwsem(&ei->xattr_sem);                  ---------------(B)
#endif
                mutex_init(&ei->truncate_mutex);             ---------------(C)
                inode_init_once(&ei->vfs_inode);
        }
}

--
(A) and (B) and (C) is only for ext3.

NFS's
--
static void init_once(void * foo, kmem_cache_t * cachep, unsigned long flags)
{
        struct nfs_inode *nfsi = (struct nfs_inode *) foo;

        if ((flags & (SLAB_CTOR_VERIFY|SLAB_CTOR_CONSTRUCTOR)) ==
            SLAB_CTOR_CONSTRUCTOR) {
                inode_init_once(&nfsi->vfs_inode);
                spin_lock_init(&nfsi->req_lock);
                INIT_LIST_HEAD(&nfsi->dirty);
                INIT_LIST_HEAD(&nfsi->commit);
                INIT_LIST_HEAD(&nfsi->open_files);
                INIT_RADIX_TREE(&nfsi->nfs_page_tree, GFP_ATOMIC);
                atomic_set(&nfsi->data_updates, 0);
                nfsi->ndirty = 0;
                nfsi->ncommit = 0;
                nfsi->npages = 0;
                nfs4_init_once(nfsi);
        }
}
--


Of cource, many of init_once() just call inode_init_once(). But some fs does
something special.

Thanks,
-Kame

