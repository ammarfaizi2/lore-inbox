Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423678AbWJaSVG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423678AbWJaSVG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 13:21:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423753AbWJaSVG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 13:21:06 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:4241 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1423678AbWJaSVF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 13:21:05 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=RSLWu08MK1YZDP08Yu18UfxeTJQM4bNHTHROgVSIsmuMLLcOqJbtIYb1XzkUKs3xiZ09t0x8cnx9gBzL6uZHIbURoLLWCVcmuv2rcjQCBpCcaEPrc9KK9gglHo114rPaNGy5f/97i15W13vX+0KbaEh2Owo4d+TRGFuEYZ0Kmek=
Date: Tue, 31 Oct 2006 21:19:18 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Derek Fults <dfults@sgi.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Allow a hyphenated range in get_options
Message-ID: <20061031181918.GB4900@martell.zuzino.mipt.ru>
References: <1162315517.9542.372.camel@lnx-dfults.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1162315517.9542.372.camel@lnx-dfults.americas.sgi.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2006 at 11:25:16AM -0600, Derek Fults wrote:
> This allows a hyphenated range of positive numbers in the string passed
> to command line helper function, get_options.

Please, find in-tree code which could use this feature. After you have
done it address comments below and resend series with this patch going
first, conversions going next.

> --- linux.orig/lib/cmdline.c
> +++ linux/lib/cmdline.c
> @@ -29,6 +29,10 @@
>   *	0 : no int in string
>   *	1 : int found, no subsequent comma
>   *	2 : int found including a subsequent comma
> + *  -(int): int found with a subsequent hyphen to denote a range.
> + *          The negative number is the number of integers in the range
> + *          used to increment the counter in the while loop.
> + *      
>   */

Comment mentions irrelevant implementations details. trailing whitespace

> @@ -44,7 +48,16 @@
>  		(*str)++;
>  		return 2;
>  	}
> +	if (**str == '-') {
> +	    int x,inc_counter= 0, upper_range = 0;
>  
> +	    (*str)++;
> +	    upper_range = simple_strtol ((*str), NULL, 0);
> +	    inc_counter = upper_range - *pint ;
> +	    for (x=*pint; x < upper_range; x++) 
> +		    *pint++ = x;
> +	    return -inc_counter;
> +	}

coding style.

> @@ -55,7 +68,8 @@
>   *	@ints: integer array
>   *
>   *	This function parses a string containing a comma-separated
> - *	list of integers.  The parse halts when the array is
> + *	list of integers, a hyphen-separated range of _positive_ integers,
> + *      or a combination of both.  The parse halts when the array is
>   *	full, or when no more numbers can be retrieved from the
>   *	string.
>   *
> @@ -75,6 +89,11 @@
>  		i++;
>  		if (res == 1)
>  			break;
> +		if (res < 0) 
> +		        /* Decrement the result by one to leave out the 
> +			   last number in the range.  The next iteration 
> +			   will handle the upper number in the range */
> +		        i += ((-res) - 1);

trailing whitespace

