Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1750800AbWFEVBp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750800AbWFEVBp (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 17:01:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750812AbWFEVBp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 17:01:45 -0400
Received: from smtp.osdl.org ([65.172.181.4]:34535 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750800AbWFEVBo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 17:01:44 -0400
Date: Mon, 5 Jun 2006 13:58:12 -0700
From: Andrew Morton <akpm@osdl.org>
To: Christoph Lameter <clameter@sgi.com>
Cc: mbligh@google.com, apw@shadowen.org, mbligh@mbligh.org,
        linux-kernel@vger.kernel.org, ak@suse.de, hugh@veritas.com,
        Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: 2.6.17-rc5-mm1
Message-Id: <20060605135812.30138205.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606051334010.18717@schroedinger.engr.sgi.com>
References: <447DEF49.9070401@google.com>
	<20060531140652.054e2e45.akpm@osdl.org>
	<447E093B.7020107@mbligh.org>
	<20060531144310.7aa0e0ff.akpm@osdl.org>
	<447E104B.6040007@mbligh.org>
	<447F1702.3090405@shadowen.org>
	<44842C01.2050604@shadowen.org>
	<Pine.LNX.4.64.0606051137400.17951@schroedinger.engr.sgi.com>
	<44848DD2.7010506@shadowen.org>
	<Pine.LNX.4.64.0606051304360.18543@schroedinger.engr.sgi.com>
	<44848F45.1070205@shadowen.org>
	<44849075.5070802@google.com>
	<Pine.LNX.4.64.0606051325351.18717@schroedinger.engr.sgi.com>
	<Pine.LNX.4.64.0606051334010.18717@schroedinger.engr.sgi.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Jun 2006 13:43:47 -0700 (PDT)
Christoph Lameter <clameter@sgi.com> wrote:

> Sigh the patch that I sent earlier will make swapon fail when adding more 
> entries if 32 entries have been defined before even if some of these are 
> later freed. Plus maybe we better leave the probing intact for arches that 
> support less than 32 swap devices and also return -EPERM like before. I 
> guess we need this one instead:
> 
> 
> Do proper boundary checking in sys_swapon().
> 
> sys_swapon currently does not limit the number of swap devices. It may as
> a result overwrite memory following the swap_info array and get into 
> entanglements with page migration since it may usethe swap types reserved 
> for page migration.
> 
> Fix this by limiting the number of swap devices in swapon to 
> MAX_SWAPFILES
> 
> Signed-off-by: Christoph Lameter <clameter@sgi.com>
> 
> Index: linux-2.6.17-rc5-mm2/mm/swapfile.c
> ===================================================================
> --- linux-2.6.17-rc5-mm2.orig/mm/swapfile.c	2006-06-01 10:03:07.127259731 -0700
> +++ linux-2.6.17-rc5-mm2/mm/swapfile.c	2006-06-05 13:40:45.887291175 -0700
> @@ -1408,8 +1408,13 @@ asmlinkage long sys_swapon(const char __
>  		spin_unlock(&swap_lock);
>  		goto out;
>  	}
> -	if (type >= nr_swapfiles)
> +	if (type >= nr_swapfiles) {
> +		if (nr_swapfiles >= MAX_SWAPFILES) {
> +			spin_unlock(&swap_lock);
> +			goto out;
> +		}
>  		nr_swapfiles = type+1;
> +	}
>  	INIT_LIST_HEAD(&p->extent_list);
>  	p->flags = SWP_USED;
>  	p->swap_file = NULL;

Thanks, Christoph.  So we get to keep the crappy test?

I wonder what LTP was corrupting before it started to corrupt page
migration data?

The above looks like a 2.6.17 thing to me.
