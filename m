Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262708AbVGHQag@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262708AbVGHQag (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 12:30:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262707AbVGHQaY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 12:30:24 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:24258 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262703AbVGHQ3P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 12:29:15 -0400
Subject: Re: [RFC PATCH 1/8] share/private/slave a subtree
From: Ram <linuxram@us.ibm.com>
To: Pekka Enberg <penberg@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       viro@parcelfarce.linux.theplanet.co.uk, Andrew Morton <akpm@osdl.org>,
       mike@waychison.com, bfields@fieldses.org,
       Miklos Szeredi <miklos@szeredi.hu>,
       Pekka Enberg <penberg@cs.helsinki.fi>
In-Reply-To: <84144f0205070804171d7c9726@mail.gmail.com>
References: <1120816072.30164.10.camel@localhost>
	 <1120816229.30164.13.camel@localhost> <1120817463.30164.43.camel@localhost>
	 <84144f0205070804171d7c9726@mail.gmail.com>
Content-Type: text/plain
Organization: IBM 
Message-Id: <1120840148.30164.99.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 08 Jul 2005 09:29:08 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-07-08 at 04:17, Pekka Enberg wrote:
> On 7/8/05, Ram <linuxram@us.ibm.com> wrote:
> > This patch adds the shared/private/slave support for VFS trees.
> 
> Inlining the patches to email would be greatly appreciated. Here are
> some comments.
> 
> > +int
> > +_do_make_mounted(struct nameidata *nd, struct vfsmount **mnt)
> 
> Use two underscores to follow naming conventions.

I have renamed this function as make_mounted() in the 2nd patch.
Sure, will follow the convention.

> 
> > Index: 2.6.12/fs/pnode.c
> > ===================================================================
> > --- /dev/null
> > +++ 2.6.12/fs/pnode.c
> > @@ -0,0 +1,362 @@
> > +
> > +#define PNODE_MEMBER_VFS  0x01
> > +#define PNODE_SLAVE_VFS   0x02
> 
> Enums, please.

ok.

> 
> > +
> > +static kmem_cache_t * pnode_cachep;
> > +
> > +/* spinlock for pnode related operations */
> > + __cacheline_aligned_in_smp DEFINE_SPINLOCK(vfspnode_lock);
> > +
> > +
> > +static void
> > +pnode_init_fn(void *data, kmem_cache_t *cachep, unsigned long flags)
> > +{
> > +	struct vfspnode *pnode = (struct vfspnode *)data;
> 
> Redundant cast.

ok.

> 
> > +	INIT_LIST_HEAD(&pnode->pnode_vfs);
> > +	INIT_LIST_HEAD(&pnode->pnode_slavevfs);
> > +	INIT_LIST_HEAD(&pnode->pnode_slavepnode);
> > +	INIT_LIST_HEAD(&pnode->pnode_peer_slave);
> > +	pnode->pnode_master = NULL;
> > +	pnode->pnode_flags = 0;
> > +	atomic_set(&pnode->pnode_count,0);
> > +}
> > +
> > +void __init
> > +pnode_init(unsigned long mempages)
> > +{
> > +	pnode_cachep = kmem_cache_create("pnode_cache",
> > +                       sizeof(struct vfspnode), 0,
> > +                       SLAB_HWCACHE_ALIGN|SLAB_PANIC, pnode_init_fn, NULL);
> > +}
> > +
> > +
> > +struct vfspnode *
> > +pnode_alloc(void)
> > +{
> > +	struct vfspnode *pnode =  (struct vfspnode *)kmem_cache_alloc(
> > +			pnode_cachep, GFP_KERNEL);
> 
> Redundant cast.

ok.

> 
> > +struct inoutdata {
> 
> Wants a better name.

ok. something like propogation_data? or pdata?

> 
> > +	void *my_data; /* produced and consumed by me */
> > +	void *in_data; /* produced by master, consumed by slave */
> > +	void *out_data; /* produced by slave, comsume by master */
> > +};
> > +
> > +struct pcontext {
> > +	struct vfspnode *start;
> > +	int 	flag;
> > +	int 	traversal;
> > +	int	level;
> > +	struct vfspnode *master_pnode;
> > +	struct vfspnode *pnode;
> > +	struct vfspnode *slave_pnode;
> > +};
> > +
> > +
> > +#define PNODE_UP 1
> > +#define PNODE_DOWN 2
> > +#define PNODE_MID 3
> 
> Enums, please.

ok. I will incorporate all the rest of the comments.  There are lots of
places as noted by you I need to following the coding style. I will.

Thanks,
RP
 

