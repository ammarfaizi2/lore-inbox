Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261893AbVATTwM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261893AbVATTwM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 14:52:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261917AbVATTwM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 14:52:12 -0500
Received: from wproxy.gmail.com ([64.233.184.201]:8280 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261893AbVATTvo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 14:51:44 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=UWfZPPc5OodNBtvtcvxUCK+qyRno1TazILCFBAOpYOCZ2j7XrS/vggTCDYP5/AV0jqZYH0TzVPmFGjyeRZNRi6sd69giTa2+eHrrGJnOlIkFxwroeO1U60wMwirrVXYRimI3Y/pQ1CHp50tU+0oBx753+fNMAOI1Epk+gVh2baU=
Message-ID: <84144f02050120115172375893@mail.gmail.com>
Date: Thu, 20 Jan 2005 21:51:39 +0200
From: Pekka Enberg <penberg@gmail.com>
Reply-To: Pekka Enberg <penberg@gmail.com>
To: karim@opersys.com
Subject: Re: [PATCH] relayfs redux for 2.6.10: lean and mean
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Andi Kleen <ak@muc.de>, Roman Zippel <zippel@linux-m68k.org>,
       Greg KH <greg@kroah.com>, Tom Zanussi <zanussi@us.ibm.com>,
       Robert Wisniewski <bob@watson.ibm.com>, Tim Bird <tim.bird@am.sony.com>,
       penberg@cs.helsinki.fi
In-Reply-To: <41EF4E74.2000304@opersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <41EF4E74.2000304@opersys.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Jan 2005 01:23:48 -0500, Karim Yaghmour <karim@opersys.com> wrote:
> +config RELAYFS_FS
> +	tristate "Relayfs file system support"
> +	---help---
> +	  Relayfs is a high-speed data relay filesystem designed to provide
> +	  an efficient mechanism for tools and facilities to relay large
> +	  amounts of data from kernel space to user space.  It's not useful
> +	  on its own, and should only be enabled if other facilities that
> +	  need it are enabled, such as for example the Linux Trace Toolkit.
> +
> +	  See <file:Documentation/filesystems/relayfs.txt> for further
> +	  information.

Please remove the above if you don't include the file in this patch.

>  menu "Miscellaneous filesystems"
> --- linux-2.6.10/fs/Makefile	2004-12-24 16:34:58.000000000 -0500
> +++ linux-2.6.10-relayfs-redux-1/fs/Makefile	2005-01-20 01:23:27.000000000 -0500
> @@ -1,5 +1,4 @@
> -#
> -# Makefile for the Linux filesystems.
> +## Makefile for the Linux filesystems.

Please remove the patch noise above.

> +/**
> + *	alloc_page_array - alloc array to hold pages, but not pages
> + *	@size: the total size of the memory represented by the page array
> + *	@page_count: the number of pages the array can hold
> + *	@err: 0 on success, negative otherwise
> + *
> + *	Returns a pointer to the page array if successful, NULL otherwise.
> + */
> +static struct page **
> +alloc_page_array(int size, int *page_count, int *err)
> +{
> +	int n_pages;
> +	struct page **page_array;
> +	int page_array_size;
> +
> +	*err = 0;
> +
> +	size = PAGE_ALIGN(size);
> +	n_pages = size >> PAGE_SHIFT;
> +	page_array_size = n_pages * sizeof(struct page *);
> +	page_array = kmalloc(page_array_size, GFP_KERNEL);
> +	if (page_array == NULL) {
> +		*err = -ENOMEM;
> +		return NULL;
> +	}
> +	*page_count = n_pages;
> +	memset(page_array, 0, page_array_size);
> +
> +	return page_array;
> +}

err parameter seems overkill as you can simply return NULL when failing.
Furthermore this allocator looks a lot like kcalloc(). As there's only one
caller for this function, please switch to kcalloc and inline this method
to the caller.

> +
> +/**
> + *	free_page_array - free array to hold pages, but not pages
> + *	@page_array: pointer to the page array
> + */
> +static inline void
> +free_page_array(struct page **page_array)
> +{
> +	kfree(page_array);
> +}

Please remove this useless wrapper and inline kfree() in the code.

> +/**
> + *	relaybuf_free - free a resized channel buffer
> + *	@private: pointer to the channel struct
> + *
> + *	Internal - manages the de-allocation and unmapping of old channel
> + *	buffers.
> + */
> +static void
> +relaybuf_free(void *private)
> +{
> +	struct free_rchan_buf *free_buf = (struct free_rchan_buf *)private;

Please remove the redundant cast.

> +/**
> + *     remove_rchan_file - remove the channel file
> + *     @private: pointer to the channel struct
> + *
> + *     Internal - manages the removal of old channel file
> + */
> +static void
> +remove_rchan_file(void *private)
> +{
> +	struct rchan *rchan = (struct rchan *)private;

Please remove the redundant cast.

> +/**
> + *	rchan_put - decrement channel refcount, releasing it if 0
> + *	@rchan: the channel
> + *
> + *	If the refcount reaches 0, the channel will be destroyed.
> + */
> +void
> +rchan_put(struct rchan *rchan)
> +{
> +	if (atomic_dec_and_test(&rchan->refcount))
> +		relay_release(rchan);

relay_release returns an error code. Either check for it or remove the
pointless error value propagation from the code.

> +/**
> + *	wakeup_readers - wake up VFS readers waiting on a channel
> + *	@private: the channel
> + *
> + *	This is the work function used to defer reader waking.  The
> + *	reason waking is deferred is that calling directly from commit
> + *	causes problems if you're writing from say the scheduler.
> + */
> +static void
> +wakeup_readers(void *private)
> +{
> +	struct rchan *rchan = (struct rchan *)private;
> +

Remove the redundant cast.

> +/*
> + * close() vm_op implementation for relayfs file mapping.
> + */
> +static void
> +relay_file_mmap_close(struct vm_area_struct *vma)
> +{
> +	struct file *filp = vma->vm_file;
> +	struct rchan_reader *reader;
> +	struct rchan *rchan;
> +
> +	reader = filp->private_data;
> +	rchan = reader->rchan;

Why not move these initializations to the declaration like vma->vm_file.

> +		if (err == 0)
> +			atomic_inc(&rchan->mapped);
> +	}
> +exit:
> +	return err;
> +}
> +
> +/*
> + * High-level relayfs kernel API.  See Documentation/filesystems/relafys.txt.
> + */

s/relafys/relayfs/

> +static inline int
> +rchan_create_buf(struct rchan *rchan, int size_alloc)
> +{
> +	struct page **page_array;
> +	int page_count;
> +
> +	if ((rchan->buf = (char *)alloc_rchan_buf(size_alloc, &page_array, &page_count)) == NULL) {

Please remove the redundant cast.

> +/**
> + *	rchan_create - allocate and initialize a channel, including buffer
> + *	@chanpath: path specifying the relayfs channel file to create
> + *	@bufsize: the size of the sub-buffers within the channel buffer
> + *	@nbufs: the number of sub-buffers within the channel buffer
> + *	@rchan_flags: flags specifying buffer attributes
> + *	@err: err code
> + *
> + *	Returns channel if successful, NULL otherwise, err receives errcode.
> + *
> + *	Allocates a struct rchan representing a relay channel, according
> + *	to the attributes passed in via rchan_flags.  Does some basic sanity
> + *	checking but doesn't try to do anything smart.  In particular, the
> + *	number of buffers must be a power of 2, and if the lockless scheme
> + *	is being used, the sub-buffer size must also be a power of 2.  The
> + *	locking scheme can use buffers of any size.
> + */
> +static struct rchan *
> +rchan_create(const char *chanpath,
> +	     int bufsize,
> +	     int nbufs,
> +	     u32 rchan_flags,
> +	     int *err)

err parameter seems overkill as you can achieve the same thing by returning
NULL to the caller.

> +exit:
> +	if (*err) {
> +		kfree(rchan);
> +		rchan = NULL;
> +	}
> +
> +	return rchan;
> +}
> +
> +
> +static char tmpname[NAME_MAX];

Hmm? At least move this bugger into rchan_create_dir. How are you serializing
accesses to this anyway?

> +/**
> + *	restore_callbacks - restore default channel callbacks
> + *	@rchan: the channel
> + *
> + *	Restore callbacks to the default versions.
> + */
> +static inline void
> +restore_callbacks(struct rchan *rchan)
> +{
> +	if (rchan->callbacks != &default_channel_callbacks)
> +		rchan->callbacks = &default_channel_callbacks;

The if clause achieves nothing. Please remove it and inline the code to its
callers.

                                  Pekka
