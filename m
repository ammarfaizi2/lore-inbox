Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316578AbSFFAXc>; Wed, 5 Jun 2002 20:23:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316579AbSFFAXb>; Wed, 5 Jun 2002 20:23:31 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:31495 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S316578AbSFFAXa>;
	Wed, 5 Jun 2002 20:23:30 -0400
Message-ID: <3CFEAB2F.C3203ED8@zip.com.au>
Date: Wed, 05 Jun 2002 17:22:07 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Adam J. Richter" <adam@yggdrasil.com>
CC: axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: Patch: linux-2.5.20/fs/bio.c - ll_rw_kio made incorrect assumptions 
 about queue handler's capabilities
In-Reply-To: <200206060004.RAA00496@baldur.yggdrasil.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Adam J. Richter" wrote:
> 
> ..
> +       max_bytes = q->max_sectors << 9;

Does this not also need to be done in fs/mpage.c?  It's
just using BIO_MAX_SIZE.

What particular problem are you trying to solve here?

>         /*
>          * maybe kio is bigger than the max we can easily map into a bio.
>          * if so, split it up in appropriately sized chunks.
> @@ -367,8 +370,14 @@
> 
>         map_i = 0;
> 
> +       max_pages = (max_bytes + PAGE_MASK) >> PAGE_SHIFT;
> +       if (max_pages > q->max_phys_segments)
> +               max_pages = q->max_phys_segments;
> +       if (max_pages > q->max_hw_segments)
> +               max_pages = q->max_hw_segments;
> +

I think probably this should be implemented as a block API
function.

This is going to drag us back into the BIO splitting quagmire.

>  next_chunk:
> -       nr_pages = BIO_MAX_SECTORS >> (PAGE_SHIFT - 9);
> +       nr_pages = max_pages;

hmm.  So BIO is based on PAGE_SIZE pages.  Not PAGE_CACHE_SIZE.
I currently have:

                unsigned nr_bvecs = MPAGE_BIO_MAX_SIZE / PAGE_CACHE_SIZE;

Which is about the only sane way in which the pagecache BIO
assembly code can go from "bytes" to "number of pages".
It's going to get interesting if someone makes PAGE_SIZE != PAGE_CACHE_SIZE.
