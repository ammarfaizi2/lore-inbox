Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271646AbRIBRTL>; Sun, 2 Sep 2001 13:19:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271647AbRIBRTB>; Sun, 2 Sep 2001 13:19:01 -0400
Received: from shed.alex.org.uk ([195.224.53.219]:41380 "HELO shed.alex.org.uk")
	by vger.kernel.org with SMTP id <S271646AbRIBRSx>;
	Sun, 2 Sep 2001 13:18:53 -0400
Date: Sun, 02 Sep 2001 18:19:08 +0100
From: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Reply-To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
To: Daniel Phillips <phillips@bonn-fries.net>,
        Igor Mozetic <igor.mozetic@uni-mb.si>, linux-kernel@vger.kernel.org
Cc: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Subject: Re: [2.4.9 SMP] alloc_pages failed
Message-ID: <1026233054.999454747@[169.254.198.40]>
In-Reply-To: <20010902164323Z16375-32383+3004@humbolt.nl.linux.org>
In-Reply-To: <20010902164323Z16375-32383+3004@humbolt.nl.linux.org>
X-Mailer: Mulberry/2.1.0 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think Daniel's two patches are the wrong way around. IE
the second (labelled as the first) is the instrumentation
to differentiate between different kinds of failure, and
the first (labelled as the second) is the attempt to
reserve extra pages for atomic allocations to reduce
0-order failures.

Alex Bligh

--On Sunday, 02 September, 2001 6:50 PM +0200 Daniel Phillips 
<phillips@bonn-fries.net> wrote:

> On September 2, 2001 03:14 pm, Igor Mozetic wrote:
>> My box is dual Xeon 550, Intel C440GX+, 2GB RAM, AIC7XXX.
>> Last night I got log full of the following:
>>
>> Sep  2 04:00:46 jerolim kernel: __alloc_pages: 0-order allocation failed.
>> Sep  2 04:00:47 jerolim last message repeated 208 times
>> Sep  2 04:00:47 jerolim kernel: ed.
>
> Could you please apply this patch so we can see which kind of allocation
> is failing (patch -p0):
>
> --- ../2.4.9.clean/mm/page_alloc.c	Thu Aug 16 12:43:02 2001
> +++ ./mm/page_alloc.c	Wed Aug 29 23:47:39 2001
> @@ -493,6 +493,9 @@
>  		}
>
>  		/* XXX: is pages_min/4 a good amount to reserve for this? */
> +		if (z->free_pages < z->pages_min / 3 && (gfp_mask & __GFP_WAIT) &&
> +				!(current->flags & PF_MEMALLOC))
> +			continue;
>  		if (z->free_pages < z->pages_min / 4 &&
>  				!(current->flags & PF_MEMALLOC))
>  			continue;
>
>
> On the assumption it's an atomic allocation, chould you try this patch
> and  see if it reduces the frequency:
>
> --- 2.4.9.clean/mm/page_alloc.c	Thu Aug 16 12:43:02 2001
> +++ 2.4.9/mm/page_alloc.c	Mon Aug 20 22:05:40 2001
> @@ -502,7 +502,8 @@
>  	}
>
>  	/* No luck.. */
> -	printk(KERN_ERR "__alloc_pages: %lu-order allocation failed.\n", order);
> +	printk(KERN_ERR "__alloc_pages: %lu-order allocation failed
> (gfp=0x%x/%i).\n",
> +		order, gfp_mask, !!(current->flags & PF_MEMALLOC));
>  	return NULL;
>  }
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>



--
Alex Bligh
