Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751522AbWCXWnZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751522AbWCXWnZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 17:43:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751531AbWCXWnZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 17:43:25 -0500
Received: from smtp.osdl.org ([65.172.181.4]:29631 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751522AbWCXWnY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 17:43:24 -0500
Date: Fri, 24 Mar 2006 14:45:35 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jeff Dike <jdike@addtoit.com>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [PATCH 12/16] UML - Memory hotplug
Message-Id: <20060324144535.37b3daf7.akpm@osdl.org>
In-Reply-To: <200603241814.k2OIExNn005555@ccure.user-mode-linux.org>
References: <200603241814.k2OIExNn005555@ccure.user-mode-linux.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Dike <jdike@addtoit.com> wrote:
>
> This adds hotplug memory support to UML.  The mconsole syntax is
> 	config mem=[+-]n[KMG]
> In other words, add or subtract some number of kilobytes, megabytes, or
> gigabytes.
>  
> Unplugged pages are allocated and then madvise(MADV_REMOVE), which is
> a currently experimental madvise extension.  These pages are tracked so
> they can be plugged back in later if the admin decides to give them back.
> The first page to be unplugged is used to keep track of about 4M of other
> pages.  A list_head is the first thing on this page.  The rest is filled
> with addresses of other unplugged pages.  This first page is not madvised,
> obviously.
> When this page is filled, the next page is used in a similar way and linked
> onto a list with the first page.  Etc.
> This whole process reverses when pages are plugged back in.  When a tracking
> page no longer tracks any unplugged pages, then it is next in line for
> plugging, which is done by freeing pages back to the kernel.
> 
> This patch also removes checking for /dev/anon on the host, which is obsoleted
> by MADVISE_REMOVE.
> 
> ...
>
> +static unsigned long long unplugged_pages_count = 0;

The `= 0;' causes this to consume space in vmlinux's .data.  If we put it
in bss and let crt0.o take care of zeroing it, we save a little disk space.


> +			page = alloc_page(GFP_ATOMIC);

That's potentially quite a few atomically-allocated pages.  I guess UML is
more resistant to oom than normal kernels (?) but it'd be nice to be able to
run page reclaim here.

> +	char buf[sizeof("18446744073709551615\0")];

rofl.  We really ought to have a #define for "this architecture's maximum
length of an asciified int/long/s32/s64".  Generally people do
guess-and-giggle-plus-20%, or they just get it wrong.

> +#ifndef MADV_REMOVE
> +#define MADV_REMOVE	0x5		/* remove these pages & resources */
> +#endif
> +
> +int os_drop_memory(void *addr, int length)
> +{
> +	int err;
> +
> +	err = madvise(addr, length, MADV_REMOVE);
> +	if(err < 0)
> +		err = -errno;
> +	return 0;
> +}

 * NOTE: Currently, only shmfs/tmpfs is supported for this operation.
 * Other filesystems return -ENOSYS.

Are you expecting that this memory is backed by tmpfs?

