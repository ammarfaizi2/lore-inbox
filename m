Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932201AbWDUBRZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932201AbWDUBRZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 21:17:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932200AbWDUBRZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 21:17:25 -0400
Received: from smtp.osdl.org ([65.172.181.4]:41162 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932094AbWDUBRY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 21:17:24 -0400
Date: Thu, 20 Apr 2006 18:16:16 -0700
From: Andrew Morton <akpm@osdl.org>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@osdl.org, steved@redhat.com, sct@redhat.com, aviro@redhat.com,
       linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
       nfsv4@linux-nfs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/7] FS-Cache: CacheFiles: A cache that backs onto a
 mounted filesystem
Message-Id: <20060420181616.0f167b1d.akpm@osdl.org>
In-Reply-To: <20060420165941.9968.13602.stgit@warthog.cambridge.redhat.com>
References: <20060420165927.9968.33912.stgit@warthog.cambridge.redhat.com>
	<20060420165941.9968.13602.stgit@warthog.cambridge.redhat.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells <dhowells@redhat.com> wrote:
>
> ...
>
> +		ret = 0;
> +	}
> +	else if (cachefiles_has_space(cache, 1) == 0) {

	} else if (cachefiles_has_space(cache, 1) == 0) {

> +		/* there's space in the cache we can use */
> +		pagevec_add(&pagevec, page);
> +		cookie->def->mark_pages_cached(cookie->netfs_data,
> +					       page->mapping, &pagevec);
> +		ret = -ENODATA;
> +	}
> +	else {

	} else {

(many instances)

> +unsigned long cachefiles_debug = 0;

Unneeded initialisation.

> +static int cachefiles_init(void)

__init?

> +#if 0
> +void __cyg_profile_func_enter (void *this_fn, void *call_site)
> +__attribute__((no_instrument_function));
> +
> +void __cyg_profile_func_enter (void *this_fn, void *call_site)
> +{
> +       asm volatile("  movl    %%esp,%%edi     \n"
> +                    "  andl    %0,%%edi        \n"
> +                    "  addl    %1,%%edi        \n"
> +                    "  movl    %%esp,%%ecx     \n"
> +                    "  subl    %%edi,%%ecx     \n"
> +                    "  shrl    $2,%%ecx        \n"
> +                    "  movl    $0xedededed,%%eax     \n"
> +                    "  rep stosl               \n"
> +                    :
> +                    : "i"(~(THREAD_SIZE-1)), "i"(sizeof(struct thread_info))
> +                    : "eax", "ecx", "edi", "memory", "cc"
> +                    );
> +}
> +
> +void __cyg_profile_func_exit(void *this_fn, void *call_site)
> +__attribute__((no_instrument_function));
> +
> +void __cyg_profile_func_exit(void *this_fn, void *call_site)
> +{
> +       asm volatile("  movl    %%esp,%%edi     \n"
> +                    "  andl    %0,%%edi        \n"
> +                    "  addl    %1,%%edi        \n"
> +                    "  movl    %%esp,%%ecx     \n"
> +                    "  subl    %%edi,%%ecx     \n"
> +                    "  shrl    $2,%%ecx        \n"
> +                    "  movl    $0xdadadada,%%eax     \n"
> +                    "  rep stosl               \n"
> +                    :
> +                    : "i"(~(THREAD_SIZE-1)), "i"(sizeof(struct thread_info))
> +                    : "eax", "ecx", "edi", "memory", "cc"
> +                    );
> +}
> +#endif

removeable?

> +/*
> + * delete an object representation from the cache
> + * - file backed objects are unlinked
> + * - directory backed objects are stuffed into the graveyard for userspace to
> + *   delete
> + * - unlocks the directory mutex
> + */
> +static int cachefiles_bury_object(struct cachefiles_cache *cache,
> +				  struct dentry *dir,
> +				  struct dentry *rep)
> +{
> +	struct dentry *grave, *alt, *trap;
> +	struct qstr name;
> +	const char *old_name;
> +	char nbuffer[8 + 8 + 1];
> +	int ret;
> +
> +	_enter(",'%*.*s','%*.*s'",
> +	       dir->d_name.len, dir->d_name.len, dir->d_name.name,
> +	       rep->d_name.len, rep->d_name.len, rep->d_name.name);
> +
> +	/* non-directories can just be unlinked */
> +	if (!S_ISDIR(rep->d_inode->i_mode)) {
> +		_debug("unlink stale object");
> +		ret = dir->d_inode->i_op->unlink(dir->d_inode, rep);
> +
> +		mutex_unlock(&dir->d_inode->i_mutex);

hm, what's going on here?  It's strange for a callee to undo an i_mutex
which some caller took.

>  EXPORT_SYMBOL(generic_file_buffered_write);
>  
> +int
> +generic_file_buffered_write_one_kernel_page(struct file *file,
> +					    pgoff_t index,
> +					    struct page *src)

Some covering comments would be nice.

> +{
> +	struct address_space *mapping = file->f_mapping;
> +	struct address_space_operations *a_ops = mapping->a_ops;
> +	struct pagevec	lru_pvec;
> +	struct page *page, *cached_page = NULL;
> +	void *from, *to;
> +	long status = 0;
> +
> +	pagevec_init(&lru_pvec, 0);
> +
> +	page = __grab_cache_page(mapping, index, &cached_page, &lru_pvec);
> +	if (!page) {
> +		BUG_ON(cached_page);
> +		return -ENOMEM;
> +	}
> +
> +	status = a_ops->prepare_write(file, page, 0, PAGE_CACHE_SIZE);
> +	if (unlikely(status)) {
> +		loff_t isize = i_size_read(mapping->host);

If the hosts's i_mutex is held (it should be, but there are no comments)
then we can read inode->i_size directly.  Minor thing.


> +
> +	from = kmap_atomic(src, KM_USER0);
> +	to = kmap_atomic(page, KM_USER1);
> +	copy_page(to, from);
> +	kunmap_atomic(from, KM_USER0);
> +	kunmap_atomic(to, KM_USER1);

that's copy_highpage().




Sigh.  It's all a huge pile of new code.  And it's only used by AFS, the
number of users of which can be counted on the fingers of one foot.  An NFS
implementation would make a testing phase much more useful.
