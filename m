Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751082AbWHPNqN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751082AbWHPNqN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 09:46:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751090AbWHPNqN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 09:46:13 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:50895 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751012AbWHPNqM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 09:46:12 -0400
Date: Wed, 16 Aug 2006 14:45:50 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: lkml <linux-kernel@vger.kernel.org>, David Miller <davem@davemloft.net>,
       Ulrich Drepper <drepper@redhat.com>, Andrew Morton <akpm@osdl.org>,
       netdev <netdev@vger.kernel.org>, Zach Brown <zach.brown@oracle.com>
Subject: Re: [take9 1/2] kevent: Core files.
Message-ID: <20060816134550.GA12345@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
	lkml <linux-kernel@vger.kernel.org>,
	David Miller <davem@davemloft.net>,
	Ulrich Drepper <drepper@redhat.com>, Andrew Morton <akpm@osdl.org>,
	netdev <netdev@vger.kernel.org>, Zach Brown <zach.brown@oracle.com>
References: <11555364962921@2ka.mipt.ru> <1155536496588@2ka.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1155536496588@2ka.mipt.ru>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> diff --git a/include/linux/kevent.h b/include/linux/kevent.h
> new file mode 100644
> index 0000000..03eeeea
> --- /dev/null
> +++ b/include/linux/kevent.h
> @@ -0,0 +1,310 @@
> +/*
> + * 	kevent.h

Please don't put filenames in the top of file block comments.  They're
redudant and as history shows out of date far too often.

> +#ifdef __KERNEL__

Please split the user/kernel ABI and kernel implementation details into
two different headers.  That way we don't have to run unifdef as part of
the user headers generation process and it's much cleaner what bit is a
kernel implementation details and what's the public ABI.

> +#define KEVENT_READY		0x1
> +#define KEVENT_STORAGE		0x2
> +#define KEVENT_USER		0x4

Please use enums here.

> +	void			*priv;			/* Private data for different storages. 
> +							 * poll()/select storage has a list of wait_queue_t containers 
> +							 * for each ->poll() { poll_wait()' } here.
> +							 */

Please try to avoid spilling over the 80 chars limit.  In this case it's
easy, just put the comment before the field beeing documented.

> +extern struct kevent_callbacks kevent_registered_callbacks[];

Having global arrays is not very nice.  Any chance this could be hidden
behind proper accessor functions?

> +#ifdef CONFIG_KEVENT_INODE
> +void kevent_inode_notify(struct inode *inode, u32 event);
> +void kevent_inode_notify_parent(struct dentry *dentry, u32 event);
> +void kevent_inode_remove(struct inode *inode);
> +#else
> +static inline void kevent_inode_notify(struct inode *inode, u32 event)
> +{
> +}
> +static inline void kevent_inode_notify_parent(struct dentry *dentry, u32 event)
> +{
> +}
> +static inline void kevent_inode_remove(struct inode *inode)
> +{
> +}
> +#endif /* CONFIG_KEVENT_INODE */

The code implementing these prototypes doesn't exist.

> +#ifdef CONFIG_KEVENT_SOCKET
> +#ifdef CONFIG_LOCKDEP
> +void kevent_socket_reinit(struct socket *sock);
> +void kevent_sk_reinit(struct sock *sk);
> +#else
> +static inline void kevent_socket_reinit(struct socket *sock)
> +{
> +}
> +static inline void kevent_sk_reinit(struct sock *sk)
> +{
> +}
> +#endif

Dito.  Please clean the header from all this dead code.

> +int kevent_storage_init(void *origin, struct kevent_storage *st)
> +{
> +	spin_lock_init(&st->lock);
> +	st->origin = origin;
> +	INIT_LIST_HEAD(&st->list);
> +	return 0;
> +}

Why does this need a return value?

> +int kevent_sys_init(void)
> +{
> +	int i;
> +
> +	kevent_cache = kmem_cache_create("kevent_cache", 
> +			sizeof(struct kevent), 0, SLAB_PANIC, NULL, NULL);
> +
> +	for (i=0; i<ARRAY_SIZE(kevent_registered_callbacks); ++i) {
> +		struct kevent_callbacks *c = &kevent_registered_callbacks[i];
> +
> +		c->callback = c->enqueue = c->dequeue = NULL;
> +	}
> +	
> +	return 0;
> +}

Please make this an initcall in this file and make sure it's linked before
kevent_users.c


> +static int kevent_user_open(struct inode *, struct file *);
> +static int kevent_user_release(struct inode *, struct file *);
> +static unsigned int kevent_user_poll(struct file *, struct poll_table_struct *);
> +static int kevent_user_mmap(struct file *, struct vm_area_struct *);

Could you reorder the file so these forward-declaring prototypes aren't
needed?

> +	for (i=0; i<ARRAY_SIZE(u->kevent_list); ++i)

	for (i = 0; i < ARRAY_SIZE(u->kevent_list); i++)

> +static struct page *kevent_user_nopage(struct vm_area_struct *vma, unsigned long addr, int *type)
> +{
> +	struct kevent_user *u = vma->vm_file->private_data;
> +	unsigned long off = (addr - vma->vm_start)/PAGE_SIZE;
> +	unsigned int pnum = ALIGN(KEVENT_MAX_EVENTS*sizeof(struct mukevent) + sizeof(unsigned int), PAGE_SIZE)/PAGE_SIZE;
> +
> +	if (type)
> +		*type = VM_FAULT_MINOR;
> +
> +	if (off >= pnum)
> +		goto err_out_sigbus;
> +
> +	u->pring[off] = __get_free_page(GFP_KERNEL);

So we have a pagefault handler that allocates pages.

> +static int kevent_user_mmap(struct file *file, struct vm_area_struct *vma)
> +{
> +	unsigned long start = vma->vm_start;
> +	struct kevent_user *u = file->private_data;
> +
> +	if (vma->vm_flags & VM_WRITE)
> +		return -EPERM;
> +
> +	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
> +	vma->vm_ops = &kevent_user_vm_ops;
> +	vma->vm_flags |= VM_RESERVED;
> +	vma->vm_file = file;
> +
> +	if (remap_pfn_range(vma, start, virt_to_phys((void *)u->pring[0]), PAGE_SIZE,
> +				vma->vm_page_prot))
> +		return -EFAULT;

but you always map the first page.  This model sounds odd and rather confusing.
Do we really need to avoid of the cost of the pagefault just for the special
first page?

If so please at least use vm_insert_page() instead of remap_pfn_range().

> +#if 0
> +static inline unsigned int kevent_user_hash(struct ukevent *uk)
> +{
> +	unsigned int h = (uk->user[0] ^ uk->user[1]) ^ (uk->id.raw[0] ^ uk->id.raw[1]);
> +	
> +	h = (((h >> 16) & 0xffff) ^ (h & 0xffff)) & 0xffff;
> +	h = (((h >> 8) & 0xff) ^ (h & 0xff)) & KEVENT_HASH_MASK;
> +
> +	return h;
> +}
> +#else
> +static inline unsigned int kevent_user_hash(struct ukevent *uk)
> +{
> +	return jhash_1word(uk->id.raw[0], 0) & KEVENT_HASH_MASK;
> +}
> +#endif

Please remove that #if 0 code.

> +static int kevent_ctl_process(struct file *file, unsigned int cmd, unsigned int num, void __user *arg)
> +{
> +	int err;
> +	struct kevent_user *u = file->private_data;
> +
> +	if (!u || num > KEVENT_MAX_EVENTS)
> +		return -EINVAL;
> +
> +	switch (cmd) {
> +	case KEVENT_CTL_ADD:
> +		err = kevent_user_ctl_add(u, num, arg);
> +		break;
> +	case KEVENT_CTL_REMOVE:
> +		err = kevent_user_ctl_remove(u, num, arg);
> +		break;
> +	case KEVENT_CTL_MODIFY:
> +		err = kevent_user_ctl_modify(u, num, arg);
> +		break;
> +	default:
> +		err = -EINVAL;
> +		break;

We were rather against these kind of odd multiplexers in the past.  For
these three we at least have a common type beeing passed down so there's
not compat handling problem, but I'm still not very happy with it..

> +asmlinkage long sys_kevent_ctl(int fd, unsigned int cmd, unsigned int num, void __user *arg)
> +{
> +	int err = -EINVAL;
> +	struct file *file;
> +
> +	if (cmd == KEVENT_CTL_INIT)
> +		return kevent_ctl_init();

This one on the other hand is plain wrong. At least it should be a separate
syscall.  But looking at the code I don't quite understand why you need
a syscall at all, why can't kevent be implemented as a cloning chardevice
(on where every open allocates a new structure and stores it into
file->private_data?)

