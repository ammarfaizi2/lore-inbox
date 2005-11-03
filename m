Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030268AbVKCB6c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030268AbVKCB6c (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 20:58:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030269AbVKCB6b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 20:58:31 -0500
Received: from nproxy.gmail.com ([64.233.182.192]:1294 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030268AbVKCB6b convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 20:58:31 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Xpp2xg2VNvUjVDIZS3KptpdJlugSZhkCSJU3dV7MtObAJl4ljv5Rs+avi7YqmCztN/No4DaM8Uv8f8LxLVmtkZ5azgbEfVzJiuXeMlRgVEUQDK8Gskw9FWHQtEg6eu0Nvi9P8qXlfpf844EyDbFfRhvbqasA13cdvYoij1Y5A68=
Message-ID: <2cd57c900511021758j29ffb5f4l@mail.gmail.com>
Date: Thu, 3 Nov 2005 09:58:29 +0800
From: Coywolf Qi Hunt <coywolf@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: + readahead-commentary.patch added to -mm tree
Cc: akpm@osdl.org
In-Reply-To: <200511030145.jA31j8eB021068@shell0.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200511030145.jA31j8eB021068@shell0.pdx.osdl.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/11/05, akpm@osdl.org <akpm@osdl.org> wrote:
>
> The patch titled
>
>      readahead commentary
>
> has been added to the -mm tree.  Its filename is
>
>      readahead-commentary.patch
>
>
> From: Andrew Morton <akpm@osdl.org>
>
> Add a few comments surrounding thr generic readahead API.
>
> Also convert some ulongs into pgoff_t: the identifier for PAGE_CACHE_SIZE
> offsets into pagecache.
>
> Signed-off-by: Andrew Morton <akpm@osdl.org>
> ---
>
>  include/linux/mm.h |    8 ++++----
>  mm/readahead.c     |   31 ++++++++++++++++++++++---------
>  2 files changed, 26 insertions(+), 13 deletions(-)
>
> diff -puN mm/readahead.c~readahead-commentary mm/readahead.c
> --- 25/mm/readahead.c~readahead-commentary      2005-11-03 08:06:16.000000000 +1100
> +++ 25-akpm/mm/readahead.c      2005-11-03 08:16:16.000000000 +1100
> @@ -254,7 +254,7 @@ out:
>   */
>  static int
>  __do_page_cache_readahead(struct address_space *mapping, struct file *filp,
> -                       unsigned long offset, unsigned long nr_to_read)
> +                       pgoff_t offset, unsigned long nr_to_read)
>  {
>         struct inode *inode = mapping->host;
>         struct page *page;
> @@ -274,7 +274,7 @@ __do_page_cache_readahead(struct address
>          */
>         read_lock_irq(&mapping->tree_lock);
>         for (page_idx = 0; page_idx < nr_to_read; page_idx++) {
> -               unsigned long page_offset = offset + page_idx;
> +               pgoff_t page_offset = offset + page_idx;
>
>                 if (page_offset > end_index)
>                         break;
> @@ -311,7 +311,7 @@ out:
>   * memory at once.
>   */
>  int force_page_cache_readahead(struct address_space *mapping, struct file *filp,
> -               unsigned long offset, unsigned long nr_to_read)
> +               pgoff_t offset, unsigned long nr_to_read)
>  {
>         int ret = 0;
>
> @@ -368,7 +368,7 @@ static inline int check_ra_success(struc
>   * request queues.
>   */
>  int do_page_cache_readahead(struct address_space *mapping, struct file *filp,
> -                       unsigned long offset, unsigned long nr_to_read)
> +                       pgoff_t offset, unsigned long nr_to_read)
>  {
>         if (bdi_read_congested(mapping->backing_dev_info))
>                 return -1;
> @@ -385,7 +385,7 @@ int do_page_cache_readahead(struct addre
>   */
>  static int
>  blockable_page_cache_readahead(struct address_space *mapping, struct file *filp,
> -                       unsigned long offset, unsigned long nr_to_read,
> +                       pgoff_t offset, unsigned long nr_to_read,
>                         struct file_ra_state *ra, int block)
>  {
>         int actual;
> @@ -430,14 +430,27 @@ static int make_ahead_window(struct addr
>         return ret;
>  }
>
> -/*
> - * page_cache_readahead is the main function.  If performs the adaptive
> +/**
> + * page_cache_readahead - generic adaptive readahead
> + * @mapping: address_space which holds te pagecache and I/O vectors

typo. s/te/the/

> + * @ra: file_ra_state which holds the readahead state
> + * @filp: passed on to ->readpage() and ->readpages()
> + * @offset: start offset into @mapping, in PAGE_CACHE_SIZE units
> + * @req_size: hint: total size of the read which the caller is performing in
> + *            PAGE_CACHE_SIZE units
> + *
> + * page_cache_readahead() is the main function.  If performs the adaptive
>   * readahead window size management and submits the readahead I/O.
> + *
> + * Note that @filp is purely used for passing on to the ->readpage[s]()
> + * handler: it may refer to a different file from @mapping (so we may not use
> + * @filp->f_mapping or @filp->f_dentry->d_inode here).
> + * Also, @ra may not be equal to &@filp->f_ra.
> + *
>   */
>  unsigned long
>  page_cache_readahead(struct address_space *mapping, struct file_ra_state *ra,
> -                    struct file *filp, unsigned long offset,
> -                    unsigned long req_size)
> +                    struct file *filp, pgoff_t offset, unsigned long req_size)
>  {
>         unsigned long max, newsize;
>         int sequential;

--
Coywolf Qi Hunt
http://sosdg.org/~coywolf/
