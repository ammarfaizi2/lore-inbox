Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262608AbUJ0S64@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262608AbUJ0S64 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 14:58:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262651AbUJ0S6m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 14:58:42 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:16848 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262608AbUJ0S5n
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 14:57:43 -0400
Date: Wed, 27 Oct 2004 14:19:36 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Douglas Gilbert <dougg@torque.net>, Jens Axboe <axboe@suse.de>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: [PATCH 2.4] the perils of kunmap_atomic
Message-ID: <20041027161936.GC1081@logos.cnet>
References: <417EDE4C.20003@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <417EDE4C.20003@pobox.com>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 26, 2004 at 07:31:24PM -0400, Jeff Garzik wrote:
> 
> kunmap_atomic() violates the Principle of Least Surprise in a nasty way. 
>    kmap(), kunmap(), and kmap_atomic() all take struct page* to 
> reference the memory location.  kunmap_atomic() is the oddball of the 
> three, and takes a kernel address.
> 
> Ignoring the driver-related bugs that are present due to 
> kunmap_atomic()'s weirdness, there also appears to be a big in the 
> !CONFIG_HIGHMEM implementation in 2.4.x.
> 
> (Bart is poking through some of the 2.6.x-related kunmap_atomic slip-ups)
> 
> Anyway, what do people think about the attached patch to 2.4.x?  I'm 
> surprised it has gone unnoticed until now.
> 
> 	Jeff
>
> ===== include/linux/highmem.h 1.12 vs edited =====
> --- 1.12/include/linux/highmem.h	2003-06-30 20:18:42 -04:00
> +++ edited/include/linux/highmem.h	2004-10-26 19:26:14 -04:00
> @@ -70,7 +70,7 @@
>  #define kunmap(page) do { } while (0)
>  
>  #define kmap_atomic(page,idx)		kmap(page)
> -#define kunmap_atomic(page,idx)		kunmap(page)
> +#define kunmap_atomic(addr,idx)		kunmap(virt_to_page(addr))
>  
>  #define bh_kmap(bh)			((bh)->b_data)
>  #define bh_kunmap(bh)			do { } while (0)

Ugh :(

An audit of kunmap_atomic() users is needed.

We can try this in -29pre if there are no objections.

I have no useful comment about the bug itself right now.
