Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992669AbWKARBk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992669AbWKARBk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 12:01:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992679AbWKARBk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 12:01:40 -0500
Received: from agminet01.oracle.com ([141.146.126.228]:62527 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S2992669AbWKARBk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 12:01:40 -0500
Date: Wed, 1 Nov 2006 08:57:22 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: Derek Fults <dfults@sgi.com>
Cc: linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>
Subject: Re: [PATCH] Add get_range, allows a hyhpenated range to get_options
Message-Id: <20061101085722.18430d23.randy.dunlap@oracle.com>
In-Reply-To: <1162398157.9524.490.camel@lnx-dfults.americas.sgi.com>
References: <1162398157.9524.490.camel@lnx-dfults.americas.sgi.com>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 01 Nov 2006 10:22:36 -0600 Derek Fults wrote:

> This allows a hyphenated range of positive numbers in the string passed
> to command line helper function, get_options.    
> Currently the command line option "isolcpus=" takes as its argument a
> list of cpus.  
> Format: <cpu number>,...,<cpu number>
> This can get extremely long when isolating the majority of cpus on a
> large system.  Valid values of <cpu_number>  include all cpus, 0 to
> "number of CPUs in system - 1".
> 
> Signed-off-by: Derek Fults <dfults@sgi.com>  
> 
> Index: linux/lib/cmdline.c
> ===================================================================
> --- linux.orig/lib/cmdline.c	2006-09-19 22:42:06.000000000 -0500
> +++ linux/lib/cmdline.c	2006-11-01 10:16:09.988659834 -0600
> @@ -16,6 +16,21 @@
>  #include <linux/kernel.h>
>  #include <linux/string.h>
>  
> +/* If a hyphen was found in get_option, this will handle the 
> + * range of numbers given. 

Still have trailing whitespace in the patch (2 lines above).

I think that this comment should explain that the M-N range
is handled by expanding it to an array of [M, M+1, ..., N].


> + */
> +
> +static int get_range(char **str, int *pint)
> +{
> +	int x, inc_counter = 0, upper_range = 0;

No need to init these variables.

> +	(*str)++;
> +	upper_range = simple_strtol((*str), NULL, 0);
> +	inc_counter = upper_range - *pint;
> +	for (x = *pint; x < upper_range; x++)
> +		*pint++ = x;
> +	return inc_counter;
> +}
>  
>  /**
>   *	get_option - Parse integer from an option string
> @@ -29,6 +44,7 @@
>   *	0 : no int in string
>   *	1 : int found, no subsequent comma
>   *	2 : int found including a subsequent comma
> + *	3 : hyphen found to denote a range
>   */
>  
>  int get_option (char **str, int *pint)
> @@ -44,6 +60,8 @@
>  		(*str)++;
>  		return 2;
>  	}
> +	if (**str == '-')
> +		return 3;
>  
>  	return 1;
>  }
> @@ -55,7 +73,8 @@
>   *	@ints: integer array
>   *
>   *	This function parses a string containing a comma-separated
> - *	list of integers.  The parse halts when the array is
> + *	list of integers, a hyphen-separated range of _positive_ integers,
> + *	or a combination of both.  The parse halts when the array is
>   *	full, or when no more numbers can be retrieved from the
>   *	string.
>   *
> @@ -72,6 +91,14 @@
>  		res = get_option ((char **)&str, ints + i);
>  		if (res == 0)
>  			break;
> +		if (res == 3) {
> +			int range_nums = 0;

no need to init the variable.

> +			range_nums = get_range((char **)&str, ints + i);
> +			/* Decrement the result by one to leave out the
> +			   last number in the range.  The next iteration
> +			   will handle the upper number in the range */
> +			i += (range_nums - 1);
> +		}
>  		i++;
>  		if (res == 1)
>  			break;
> -


---
~Randy
