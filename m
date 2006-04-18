Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750733AbWDRWGE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750733AbWDRWGE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 18:06:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750735AbWDRWGE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 18:06:04 -0400
Received: from b3162.static.pacific.net.au ([203.143.238.98]:685 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S1750733AbWDRWGD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 18:06:03 -0400
From: Nigel Cunningham <ncunningham@cyclades.com>
Organization: Cyclades Corporation
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH -mm] swsusp: use less memory during resume
Date: Tue, 18 Apr 2006 23:07:21 +1000
User-Agent: KMail/1.9.1
Cc: Pavel Machek <pavel@suse.cz>, LKML <linux-kernel@vger.kernel.org>,
       Linux PM <linux-pm@osdl.org>
References: <200604181319.47400.rjw@sisk.pl>
In-Reply-To: <200604181319.47400.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1187782.eCAHqRTDMh";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200604182307.26114.ncunningham@cyclades.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1187782.eCAHqRTDMh
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Tuesday 18 April 2006 21:19, Rafael J. Wysocki wrote:
> Hi,
>
> Currently during resume swsusp puts the image data in the page frames that
> don't conflict with the original locations of the data (ie. the locations
> the data will be put in when the saved system state is restored from the
> image). These page frames are considered as "safe" and the other page
> frames are treadet as "unsafe".
>
> Of course we cannot force the memory allocator to allocate "safe" pages
> only, so if an "unsafe" page is allocated, swsusp treats it as an "eaten
> page" and attempts to allocate another page in the hope that it'll be
> "safe" etc. swsusp tries to allocate as many "safe" pages as necessary to
> store the image data, so it "eats" a considerable number of "unsafe" pages
> in the process.  Next, it reads the image and puts the data into the
> allocated "safe" pages.  Finally, the data are copied to their "original"
> locations.
>
> This approach, although it works nicely, is quite inefficient from the
> memory utilization point of view and it also turns out to be unnecessary.=
=20
> Namely, for each "unsafe" page frame returned by the memory allocator
> there's exactly one page in the image that finally should be placed in th=
is
> page frame. Therefore we can put the right data into this page frame as
> soon as they're read from the image and we won't have to copy these data
> later on.  This way we'll only need to allocate as many pages as necessary
> to store the image data and we won't have to "eat" the "unsafe" pages.
>
> The appended patch implements this idea.  It makes swsusp allocate as
> many pages as it'll need to store the data read from the image in one
> shot, creating a list of allocated "safe" pages, and uses the observation
> that all pages allocated by swsusp are marked with the PG_nosave and
> PG_nosave_free flags set.  Namely, when it's about to read a page, it
> checks whether the page frame corresponding to the "original" location of
> this page has been allocated (ie. if the page frame has the PG_nosave and
> PG_nosave_free flags set) and if so, it reads the page directly into this
> page frame.  Otherwise it uses an allocated "safe" page from the list to
> store the data that will be copied to their "original" location later on.
>
> On my box this patch allows us to save as many as approx. 90000 page
> copyings and 90000 (at least - probably twice as many, because it's an
> x86_64 box) page allocations for an image of approx. 100000 of pages.  Al=
so
> it will allow us to read images greater than 50% of the normal zone (when
> we learn how to create them ;-)).

Haven't looked at the patch itself, but this sounds like a great idea. I=20
wonder though, won't the 50% limit still apply, because you'll still have t=
o=20
make an atomic copy to start with (unless you figure out which pages aren't=
=20
going to change and therefore don't need to be atomically copied)?

Regards,

Nigel

> [This patch is on top of the
> swsusp-prevent-possible-image-corruption-on-resume.patch
> (recently added to the -mm tree).]
>
> Comments welcome.
>
> Greetings,
> Rafael
>
> ---
>  kernel/power/power.h    |    2
>  kernel/power/snapshot.c |  141
> ++++++++++++++++++++++++++++-------------------- 2 files changed, 85
> insertions(+), 58 deletions(-)
>
> Index: linux-2.6.17-rc1-mm2/kernel/power/power.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.17-rc1-mm2.orig/kernel/power/power.h	2006-04-17
> 13:47:58.000000000 +0200 +++
> linux-2.6.17-rc1-mm2/kernel/power/power.h	2006-04-17 13:59:16.000000000
> +0200 @@ -55,7 +55,7 @@ struct snapshot_handle {
>  	unsigned int	page;
>  	unsigned int	page_offset;
>  	unsigned int	prev;
> -	struct pbe	*pbe;
> +	struct pbe	*pbe, *last_pbe;
>  	void		*buffer;
>  	unsigned int	buf_offset;
>  };
> Index: linux-2.6.17-rc1-mm2/kernel/power/snapshot.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.17-rc1-mm2.orig/kernel/power/snapshot.c	2006-04-17
> 13:58:07.000000000 +0200 +++
> linux-2.6.17-rc1-mm2/kernel/power/snapshot.c	2006-04-17 14:05:01.000000000
> +0200 @@ -293,62 +293,29 @@ static inline void create_pbe_list(struc
>  	}
>  }
>
> -/**
> - *	On resume it is necessary to trace and eventually free the unsafe
> - *	pages that have been allocated, because they are needed for I/O
> - *	(on x86-64 we likely will "eat" these pages once again while
> - *	creating the temporary page translation tables)
> - */
> -
> -struct eaten_page {
> -	struct eaten_page *next;
> -	char padding[PAGE_SIZE - sizeof(void *)];
> -};
> -
> -static struct eaten_page *eaten_pages =3D NULL;
> -
> -static void release_eaten_pages(void)
> -{
> -	struct eaten_page *p, *q;
> -
> -	p =3D eaten_pages;
> -	while (p) {
> -		q =3D p->next;
> -		/* We don't want swsusp_free() to free this page again */
> -		ClearPageNosave(virt_to_page(p));
> -		free_page((unsigned long)p);
> -		p =3D q;
> -	}
> -	eaten_pages =3D NULL;
> -}
> +static unsigned int unsafe_pages;
>
>  /**
>   *	@safe_needed - on resume, for storing the PBE list and the image,
>   *	we can only use memory pages that do not conflict with the pages
> - *	which had been used before suspend.
> + *	used before suspend.
>   *
>   *	The unsafe pages are marked with the PG_nosave_free flag
> - *
> - *	Allocated but unusable (ie eaten) memory pages should be marked
> - *	so that swsusp_free() can release them
> + *	and we count them using unsafe_pages
>   */
>
>  static inline void *alloc_image_page(gfp_t gfp_mask, int safe_needed)
>  {
>  	void *res;
>
> +	res =3D (void *)get_zeroed_page(gfp_mask);
>  	if (safe_needed)
> -		do {
> +		while (res && PageNosaveFree(virt_to_page(res))) {
> +			/* The page is unsafe, mark it for swsusp_free() */
> +			SetPageNosave(virt_to_page(res));
> +			unsafe_pages++;
>  			res =3D (void *)get_zeroed_page(gfp_mask);
> -			if (res && PageNosaveFree(virt_to_page(res))) {
> -				/* This is for swsusp_free() */
> -				SetPageNosave(virt_to_page(res));
> -				((struct eaten_page *)res)->next =3D eaten_pages;
> -				eaten_pages =3D res;
> -			}
> -		} while (res && PageNosaveFree(virt_to_page(res)));
> -	else
> -		res =3D (void *)get_zeroed_page(gfp_mask);
> +		}
>  	if (res) {
>  		SetPageNosave(virt_to_page(res));
>  		SetPageNosaveFree(virt_to_page(res));
> @@ -642,6 +609,8 @@ static int mark_unsafe_pages(struct pbe
>  			return -EFAULT;
>  	}
>
> +	unsafe_pages =3D 0;
> +
>  	return 0;
>  }
>
> @@ -719,42 +688,99 @@ static inline struct pbe *unpack_orig_ad
>  }
>
>  /**
> - *	create_image - use metadata contained in the PBE list
> + *	prepare_image - use metadata contained in the PBE list
>   *	pointed to by pagedir_nosave to mark the pages that will
>   *	be overwritten in the process of restoring the system
> - *	memory state from the image and allocate memory for
> - *	the image avoiding these pages
> + *	memory state from the image ("unsafe" pages) and allocate
> + *	memory for the image
> + *
> + *	The idea is to allocate the PBE list first and then
> + *	allocate as many pages as it's needed for the image data,
> + *	but not to assign these pages to the PBEs initially.
> + *	Instead, we just mark them as allocated and create a list
> + *	of "safe" which will be used later
>   */
>
> -static int create_image(struct snapshot_handle *handle)
> +struct safe_page {
> +	struct safe_page *next;
> +	char padding[PAGE_SIZE - sizeof(void *)];
> +};
> +
> +static struct safe_page *safe_pages;
> +
> +static int prepare_image(struct snapshot_handle *handle)
>  {
>  	int error =3D 0;
> -	struct pbe *p, *pblist;
> +	unsigned int nr_pages =3D nr_copy_pages;
> +	struct pbe *p, *pblist =3D NULL;
>
>  	p =3D pagedir_nosave;
>  	error =3D mark_unsafe_pages(p);
>  	if (!error) {
> -		pblist =3D alloc_pagedir(nr_copy_pages, GFP_ATOMIC, 1);
> +		pblist =3D alloc_pagedir(nr_pages, GFP_ATOMIC, 1);
>  		if (pblist)
>  			copy_page_backup_list(pblist, p);
>  		free_pagedir(p, 0);
>  		if (!pblist)
>  			error =3D -ENOMEM;
>  	}
> -	if (!error)
> -		error =3D alloc_data_pages(pblist, GFP_ATOMIC, 1);
> +	safe_pages =3D NULL;
> +	if (!error && nr_pages > unsafe_pages) {
> +		nr_pages -=3D unsafe_pages;
> +		while (nr_pages--) {
> +			struct safe_page *ptr;
> +
> +			ptr =3D (struct safe_page *)get_zeroed_page(GFP_ATOMIC);
> +			if (!ptr) {
> +				error =3D -ENOMEM;
> +				break;
> +			}
> +			if (!PageNosaveFree(virt_to_page(ptr))) {
> +				/* The page is "safe", add it to the list */
> +				ptr->next =3D safe_pages;
> +				safe_pages =3D ptr;
> +			}
> +			/* Mark the page as allocated */
> +			SetPageNosave(virt_to_page(ptr));
> +			SetPageNosaveFree(virt_to_page(ptr));
> +		}
> +	}
>  	if (!error) {
> -		release_eaten_pages();
>  		pagedir_nosave =3D pblist;
>  	} else {
> -		pagedir_nosave =3D NULL;
>  		handle->pbe =3D NULL;
> -		nr_copy_pages =3D 0;
> -		nr_meta_pages =3D 0;
> +		swsusp_free();
>  	}
>  	return error;
>  }
>
> +static void *get_buffer(struct snapshot_handle *handle)
> +{
> +	struct pbe *pbe =3D handle->pbe, *last =3D handle->last_pbe;
> +	struct page *page =3D virt_to_page(pbe->orig_address);
> +
> +	if (PageNosave(page) && PageNosaveFree(page)) {
> +		/*
> +		 * We have allocated the "original" page frame and we can
> +		 * use it directly to store the read page
> +		 */
> +		pbe->address =3D 0;
> +		if (last && last->next)
> +			last->next =3D NULL;
> +		return (void *)pbe->orig_address;
> +	}
> +	/*
> +	 * The "original" page frame has not been allocated and we have to
> +	 * use a "safe" page frame to store the read page
> +	 */
> +	pbe->address =3D (unsigned long)safe_pages;
> +	safe_pages =3D safe_pages->next;
> +	if (last)
> +		last->next =3D pbe;
> +	handle->last_pbe =3D pbe;
> +	return (void *)pbe->address;
> +}
> +
>  /**
>   *	snapshot_write_next - used for writing the system memory snapshot.
>   *
> @@ -799,15 +825,16 @@ int snapshot_write_next(struct snapshot_
>  		} else if (handle->prev <=3D nr_meta_pages) {
>  			handle->pbe =3D unpack_orig_addresses(buffer, handle->pbe);
>  			if (!handle->pbe) {
> -				error =3D create_image(handle);
> +				error =3D prepare_image(handle);
>  				if (error)
>  					return error;
>  				handle->pbe =3D pagedir_nosave;
> -				handle->buffer =3D (void *)handle->pbe->address;
> +				handle->last_pbe =3D NULL;
> +				handle->buffer =3D get_buffer(handle);
>  			}
>  		} else {
>  			handle->pbe =3D handle->pbe->next;
> -			handle->buffer =3D (void *)handle->pbe->address;
> +			handle->buffer =3D get_buffer(handle);
>  		}
>  		handle->prev =3D handle->page;
>  	}
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

--nextPart1187782.eCAHqRTDMh
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBEROSON0y+n1M3mo0RAnu6AJwLgihZtOg4SymICzRY9Rt5L17dqQCgogK9
Lvq2PZA0df52SeclfGqQhSU=
=fsky
-----END PGP SIGNATURE-----

--nextPart1187782.eCAHqRTDMh--
