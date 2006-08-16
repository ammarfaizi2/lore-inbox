Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750926AbWHPN5a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750926AbWHPN5a (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 09:57:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750971AbWHPN5a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 09:57:30 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:14827 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S1750926AbWHPN53 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 09:57:29 -0400
Date: Wed, 16 Aug 2006 17:56:42 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Christoph Hellwig <hch@infradead.org>
Cc: lkml <linux-kernel@vger.kernel.org>, David Miller <davem@davemloft.net>,
       Ulrich Drepper <drepper@redhat.com>, Andrew Morton <akpm@osdl.org>,
       netdev <netdev@vger.kernel.org>, Zach Brown <zach.brown@oracle.com>
Subject: Re: [take9 1/2] kevent: Core files.
Message-ID: <20060816135642.GD4314@2ka.mipt.ru>
References: <11555364962921@2ka.mipt.ru> <1155536496588@2ka.mipt.ru> <20060816134550.GA12345@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20060816134550.GA12345@infradead.org>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Wed, 16 Aug 2006 17:56:46 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2006 at 02:45:50PM +0100, Christoph Hellwig (hch@infradead.org) wrote:
> > diff --git a/include/linux/kevent.h b/include/linux/kevent.h
> > new file mode 100644
> > index 0000000..03eeeea
> > --- /dev/null
> > +++ b/include/linux/kevent.h
> > @@ -0,0 +1,310 @@
> > +/*
> > + * 	kevent.h
> 
> Please don't put filenames in the top of file block comments.  They're
> redudant and as history shows out of date far too often.

Ok.

> > +#ifdef __KERNEL__
> 
> Please split the user/kernel ABI and kernel implementation details into
> two different headers.  That way we don't have to run unifdef as part of
> the user headers generation process and it's much cleaner what bit is a
> kernel implementation details and what's the public ABI.

ok.

> > +#define KEVENT_READY		0x1
> > +#define KEVENT_STORAGE		0x2
> > +#define KEVENT_USER		0x4
> 
> Please use enums here.

I used, but I was sugested to use define in some previous releases :)

> > +	void			*priv;			/* Private data for different storages. 
> > +							 * poll()/select storage has a list of wait_queue_t containers 
> > +							 * for each ->poll() { poll_wait()' } here.
> > +							 */
> 
> Please try to avoid spilling over the 80 chars limit.  In this case it's
> easy, just put the comment before the field beeing documented.

Ok.

> > +extern struct kevent_callbacks kevent_registered_callbacks[];
> 
> Having global arrays is not very nice.  Any chance this could be hidden
> behind proper accessor functions?

Ok.

> > +#ifdef CONFIG_KEVENT_INODE
> > +void kevent_inode_notify(struct inode *inode, u32 event);
> > +void kevent_inode_notify_parent(struct dentry *dentry, u32 event);
> > +void kevent_inode_remove(struct inode *inode);
> > +#else
> > +static inline void kevent_inode_notify(struct inode *inode, u32 event)
> > +{
> > +}
> > +static inline void kevent_inode_notify_parent(struct dentry *dentry, u32 event)
> > +{
> > +}
> > +static inline void kevent_inode_remove(struct inode *inode)
> > +{
> > +}
> > +#endif /* CONFIG_KEVENT_INODE */
> 
> The code implementing these prototypes doesn't exist.

It exist, it was suggested by you to not include into patchset right
now, so this file is not yet updated to not contain AIO stuff.

> > +#ifdef CONFIG_KEVENT_SOCKET
> > +#ifdef CONFIG_LOCKDEP
> > +void kevent_socket_reinit(struct socket *sock);
> > +void kevent_sk_reinit(struct sock *sk);
> > +#else
> > +static inline void kevent_socket_reinit(struct socket *sock)
> > +{
> > +}
> > +static inline void kevent_sk_reinit(struct sock *sk)
> > +{
> > +}
> > +#endif
> 
> Dito.  Please clean the header from all this dead code.
> 
> > +int kevent_storage_init(void *origin, struct kevent_storage *st)
> > +{
> > +	spin_lock_init(&st->lock);
> > +	st->origin = origin;
> > +	INIT_LIST_HEAD(&st->list);
> > +	return 0;
> > +}
> 
> Why does this need a return value?

Initialization in general can fail, this one can not, but I prefer to
reserve a second plan.

> > +int kevent_sys_init(void)
> > +{
> > +	int i;
> > +
> > +	kevent_cache = kmem_cache_create("kevent_cache", 
> > +			sizeof(struct kevent), 0, SLAB_PANIC, NULL, NULL);
> > +
> > +	for (i=0; i<ARRAY_SIZE(kevent_registered_callbacks); ++i) {
> > +		struct kevent_callbacks *c = &kevent_registered_callbacks[i];
> > +
> > +		c->callback = c->enqueue = c->dequeue = NULL;
> > +	}
> > +	
> > +	return 0;
> > +}
> 
> Please make this an initcall in this file and make sure it's linked before
> kevent_users.c

Ok.

> > +static int kevent_user_open(struct inode *, struct file *);
> > +static int kevent_user_release(struct inode *, struct file *);
> > +static unsigned int kevent_user_poll(struct file *, struct poll_table_struct *);
> > +static int kevent_user_mmap(struct file *, struct vm_area_struct *);
> 
> Could you reorder the file so these forward-declaring prototypes aren't
> needed?

I prefer structures to be placed at the begining of the file, so it
requires forward declaration.
But there is no sttrong feeling about that, so I will put it at the end.

> > +	for (i=0; i<ARRAY_SIZE(u->kevent_list); ++i)
> 
> 	for (i = 0; i < ARRAY_SIZE(u->kevent_list); i++)

Ugh, no. It reduces readability due to exessive number of spaces.

> > +static struct page *kevent_user_nopage(struct vm_area_struct *vma, unsigned long addr, int *type)
> > +{
> > +	struct kevent_user *u = vma->vm_file->private_data;
> > +	unsigned long off = (addr - vma->vm_start)/PAGE_SIZE;
> > +	unsigned int pnum = ALIGN(KEVENT_MAX_EVENTS*sizeof(struct mukevent) + sizeof(unsigned int), PAGE_SIZE)/PAGE_SIZE;
> > +
> > +	if (type)
> > +		*type = VM_FAULT_MINOR;
> > +
> > +	if (off >= pnum)
> > +		goto err_out_sigbus;
> > +
> > +	u->pring[off] = __get_free_page(GFP_KERNEL);
> 
> So we have a pagefault handler that allocates pages.

It is fixed in take10 patchset, which is why it was released.

> > +static int kevent_user_mmap(struct file *file, struct vm_area_struct *vma)
> > +{
> > +	unsigned long start = vma->vm_start;
> > +	struct kevent_user *u = file->private_data;
> > +
> > +	if (vma->vm_flags & VM_WRITE)
> > +		return -EPERM;
> > +
> > +	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
> > +	vma->vm_ops = &kevent_user_vm_ops;
> > +	vma->vm_flags |= VM_RESERVED;
> > +	vma->vm_file = file;
> > +
> > +	if (remap_pfn_range(vma, start, virt_to_phys((void *)u->pring[0]), PAGE_SIZE,
> > +				vma->vm_page_prot))
> > +		return -EFAULT;
> 
> but you always map the first page.  This model sounds odd and rather confusing.
> Do we really need to avoid of the cost of the pagefault just for the special
> first page?

->nopage() is fixed in take10 patchset to return next one.
Number of pages can grow with te time until limit (which is quite high,
and I was suggested to not allocate them all at startup).

> If so please at least use vm_insert_page() instead of remap_pfn_range().
 
Ok.
 
> > +#if 0
> > +static inline unsigned int kevent_user_hash(struct ukevent *uk)
> > +{
> > +	unsigned int h = (uk->user[0] ^ uk->user[1]) ^ (uk->id.raw[0] ^ uk->id.raw[1]);
> > +	
> > +	h = (((h >> 16) & 0xffff) ^ (h & 0xffff)) & 0xffff;
> > +	h = (((h >> 8) & 0xff) ^ (h & 0xff)) & KEVENT_HASH_MASK;
> > +
> > +	return h;
> > +}
> > +#else
> > +static inline unsigned int kevent_user_hash(struct ukevent *uk)
> > +{
> > +	return jhash_1word(uk->id.raw[0], 0) & KEVENT_HASH_MASK;
> > +}
> > +#endif
> 
> Please remove that #if 0 code.

Ok.

> +static int kevent_ctl_process(struct file *file, unsigned int cmd, unsigned int num, void __user *arg)
> > +{
> > +	int err;
> > +	struct kevent_user *u = file->private_data;
> > +
> > +	if (!u || num > KEVENT_MAX_EVENTS)
> > +		return -EINVAL;
> > +
> > +	switch (cmd) {
> > +	case KEVENT_CTL_ADD:
> > +		err = kevent_user_ctl_add(u, num, arg);
> > +		break;
> > +	case KEVENT_CTL_REMOVE:
> > +		err = kevent_user_ctl_remove(u, num, arg);
> > +		break;
> > +	case KEVENT_CTL_MODIFY:
> > +		err = kevent_user_ctl_modify(u, num, arg);
> > +		break;
> > +	default:
> > +		err = -EINVAL;
> > +		break;
> 
> We were rather against these kind of odd multiplexers in the past.  For
> these three we at least have a common type beeing passed down so there's
> not compat handling problem, but I'm still not very happy with it..

I use one syscall for add/remove/modify, so it requires multiplexer.

> > +asmlinkage long sys_kevent_ctl(int fd, unsigned int cmd, unsigned int num, void __user *arg)
> > +{
> > +	int err = -EINVAL;
> > +	struct file *file;
> > +
> > +	if (cmd == KEVENT_CTL_INIT)
> > +		return kevent_ctl_init();
> 
> This one on the other hand is plain wrong. At least it should be a separate
> syscall.  But looking at the code I don't quite understand why you need
> a syscall at all, why can't kevent be implemented as a cloning chardevice
> (on where every open allocates a new structure and stores it into
> file->private_data?)

That requires separate syscall.

I created a char device in first releases and was forced to not use it
at all.

-- 
	Evgeniy Polyakov
