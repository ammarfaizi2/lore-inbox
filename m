Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129392AbQLGNWL>; Thu, 7 Dec 2000 08:22:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129477AbQLGNWB>; Thu, 7 Dec 2000 08:22:01 -0500
Received: from [62.172.234.2] ([62.172.234.2]:52644 "EHLO penguin.homenet")
	by vger.kernel.org with ESMTP id <S129392AbQLGNV7>;
	Thu, 7 Dec 2000 08:21:59 -0500
Date: Thu, 7 Dec 2000 12:53:29 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: Szabolcs Szakacsits <szaka@f-secure.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Broken NR_RESERVED_FILES
In-Reply-To: <Pine.LNX.4.30.0012071354070.5455-100000@fs129-190.f-secure.com>
Message-ID: <Pine.LNX.4.21.0012071248480.970-100000@penguin.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Dec 2000, Szabolcs Szakacsits wrote:
> Reserved fd's for superuser doesn't work.

It does actually work, but remember that the concept of "reserved file
structures for superuser" is defined as "file structures to be taken from
the freelist" whereas your patch below:

> +	total_free = max_files - nr_files + nr_free_files;
> +	if (total_free > NR_RESERVED_FILES || (total_free && !current->euid)) {
> +		if (nr_free_files) {
> +		used_one:
> +			f = free_filps;
> +			remove_filp(f);
> +			nr_free_files--;
> +		new_one:
> +			memset(f, 0, sizeof(*f));
> +			f->f_count = 1;
> +			f->f_version = ++global_event;
> +			f->f_uid = current->fsuid;
> +			f->f_gid = current->fsgid;
> +			put_inuse(f);
> +			return f;
> +		}
> +		/*
> +		 * Allocate a new one if we're below the limit.
> +	 	*/
>  		f = kmem_cache_alloc(filp_cache, SLAB_KERNEL);

allows one to allocate a file structure from the filp_cache slab cache if
one is a superuser. That is not a "fix" -- it is a serious re-definition
of semantics of 'freelist'. There are even books (Understanding the Linux
Kernel by Bovet et all) which describe this freelist in the current
context so your patch will require updates to the books.

Having said that, it is probably a good idea to allow superuser to
allocate new file structures... just remember that you have just
_rewritten_ get_empty_filp()'s rules completely and not "fixed" them.

Regards,
Tigran

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
