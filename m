Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316491AbSGLOKo>; Fri, 12 Jul 2002 10:10:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316503AbSGLOKn>; Fri, 12 Jul 2002 10:10:43 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:55301 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S316491AbSGLOKm>; Fri, 12 Jul 2002 10:10:42 -0400
Date: Fri, 12 Jul 2002 15:13:22 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Maneesh Soni <maneesh@in.ibm.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>, Al Viro <viro@math.psu.edu>
Subject: Re: [Lse-tech] [RFC] dcache scalability patch (2.4.17)
Message-ID: <20020712151322.B31480@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Maneesh Soni <maneesh@in.ibm.com>,
	LKML <linux-kernel@vger.kernel.org>,
	lse-tech <lse-tech@lists.sourceforge.net>,
	Al Viro <viro@math.psu.edu>
References: <20020712193935.B13618@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020712193935.B13618@in.ibm.com>; from maneesh@in.ibm.com on Fri, Jul 12, 2002 at 07:39:35PM +0530
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> diff -urN linux-2.4.17-base/fs/dcache.c linux-2.4.17-dc8/fs/dcache.c
> --- linux-2.4.17-base/fs/dcache.c	Fri Dec 21 23:11:55 2001
> +++ linux-2.4.17-dc8/fs/dcache.c	Fri Jul 12 16:18:39 2002
> @@ -25,6 +25,7 @@
>  #include <linux/module.h>
>  
>  #include <asm/uaccess.h>
> +#include <linux/rcupdate.h>

Please try to include <linux/*.h> before <asm/*.h> headers.


> +static void d_callback(void *arg)
> +{
> +	struct dentry * dentry = (struct dentry *)arg;
> +
> +	if (dname_external(dentry)) 
> +		kfree((void *) dentry->d_name.name);
> +	kmem_cache_free(dentry_cache, dentry); 
> +}

why do you cast to void * before calling kfree?

> -	/* dput on a free dentry? */
> -	if (!list_empty(&dentry->d_lru))
> -		BUG();
> +	spin_lock(&dentry->d_lock);
> +        if (atomic_read(&dentry->d_count)) {
> +                spin_unlock(&dentry->d_lock);
> +                spin_unlock(&dcache_lock);
> +                return;
> +        }
> +

Please use tabs instead of eight spaces in kernel code.

Another implementation details is whether we shouldn't spin on a bit of
->d_vfs_flags instead of increasing struct dentry further.  Maybe the
spin_lock_bit interface that wli prototypes might be a godd choise.

Else the patch looks fine to me, although I'm wondering why you target 2.4.17
