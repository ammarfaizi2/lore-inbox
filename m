Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932411AbWEMMbZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932411AbWEMMbZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 May 2006 08:31:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932416AbWEMMbZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 May 2006 08:31:25 -0400
Received: from smtp.osdl.org ([65.172.181.4]:15268 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932411AbWEMMbU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 May 2006 08:31:20 -0400
Date: Sat, 13 May 2006 05:28:09 -0700
From: Andrew Morton <akpm@osdl.org>
To: Chris Wright <chrisw@sous-sol.org>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.osdl.org,
       xen-devel@lists.xensource.com, ian.pratt@xensource.com,
       Christian.Limpach@cl.cam.ac.uk
Subject: Re: [RFC PATCH 33/35] Add the Xenbus sysfs and virtual device
 hotplug driver.
Message-Id: <20060513052809.2c6e051f.akpm@osdl.org>
In-Reply-To: <20060509085200.826853000@sous-sol.org>
References: <20060509084945.373541000@sous-sol.org>
	<20060509085200.826853000@sous-sol.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 09 May 2006 00:00:33 -0700
Chris Wright <chrisw@sous-sol.org> wrote:

> This communicates with the machine control software via a registry
> residing in a controlling virtual machine. This allows dynamic
> creation, destruction and modification of virtual device
> configurations (network devices, block devices and CPUS, to name some
> examples).
> 
>
> ...
>
> +void _dev_error(struct xenbus_device *dev, int err, const char *fmt,
> +		va_list ap)

I don't think this needs global scope?  (hopefully not, with that name..)

> +	int ret;
> +	unsigned int len;
> +	char *printf_buffer = NULL, *path_buffer = NULL;

	char *print_buffer;
	char *path_buffer = NULL;

> +#define PRINTF_BUFFER_SIZE 4096
> +	printf_buffer = kmalloc(PRINTF_BUFFER_SIZE, GFP_KERNEL);

Assuming that GFP_KERNEL is legal in this context seems like a bad idea.

<looks>

hm, it does that all over the place, so I guess it works.

> +/* Based on Rusty Russell's skeleton driver's unmap_page */
> +int xenbus_unmap_ring_vfree(struct xenbus_device *dev, void *vaddr)
> +{
> +	struct vm_struct *area;
> +	struct gnttab_unmap_grant_ref op = {
> +		.host_addr = (unsigned long)vaddr,
> +	};
> +
> +	/* It'd be nice if linux/vmalloc.h provided a find_vm_area(void *addr)
> +	 * method so that we don't have to muck with vmalloc internals here.

We take patches ;)

But then, perhaps the requirement doesn't make a lot of sense in a
multithreaded environment.  We don't refcount the entries on vmlist, so
there's no point in being able to look them up.  Instead, the calling code
is supposed to be able to keep track of its own state.

Which begs the question: why isn't this code able to do that thing?

> +	 * We could force the user to hang on to their struct vm_struct from
> +	 * xenbus_map_ring_valloc, but these 6 lines considerably simplify
> +	 * this API.
> +	 */
> +	read_lock(&vmlist_lock);
> +	for (area = vmlist; area != NULL; area = area->next) {
> +		if (area->addr == vaddr)
> +			break;
> +	}
> +	read_unlock(&vmlist_lock);
> +
> +	if (!area) {
> +		xenbus_dev_error(dev, -ENOENT,
> +				 "can't find mapped virtual address %p", vaddr);
> +		return GNTST_bad_virt_addr;
> +	}

One assumes there's some locking hereabouts which ensures that `area' is
still on that list after vmlist_lock got dropped?

> +
> +static void *get_output_chunk(XENSTORE_RING_IDX cons,
> +			      XENSTORE_RING_IDX prod,
> +			      char *buf, uint32_t *len)
> +{
> +	*len = XENSTORE_RING_SIZE - MASK_XENSTORE_IDX(prod);
> +	if ((XENSTORE_RING_SIZE - (prod - cons)) < *len)
> +		*len = XENSTORE_RING_SIZE - (prod - cons);
> +	return buf + MASK_XENSTORE_IDX(prod);
> +}

Another open-coded ringbuffer?  Am still seeking the user of the
interesting ring.h.


