Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274960AbTHPVPd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Aug 2003 17:15:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274963AbTHPVPd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Aug 2003 17:15:33 -0400
Received: from [212.209.10.216] ([212.209.10.216]:33175 "EHLO
	krynn.se.axis.com") by vger.kernel.org with ESMTP id S274960AbTHPVP3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Aug 2003 17:15:29 -0400
Message-ID: <D069C7355C6E314B85CF36761C40F9A42E20BE@mailse02.se.axis.com>
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: "'Daniel Forrest'" <forrest@lmcg.wisc.edu>
Cc: "'Timothy Miller'" <miller@techsource.com>,
       "'Willy Tarreau'" <willy@w.ods.org>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: RE: generic strncpy - off-by-one error
Date: Sat, 16 Aug 2003 23:10:31 +0200
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Daniel Forrest [mailto:forrest@lmcg.wisc.edu] 
> Sent: Saturday, August 16, 2003 12:04
> To: Peter Kjellerstedt
> Cc: 'Daniel Forrest'; 'Timothy Miller'; 'Willy Tarreau'; 
> linux-kernel mailing list
> Subject: Re: generic strncpy - off-by-one error
> 
> On Sat, Aug 16, 2003 at 11:19:30AM +0200, Peter Kjellerstedt wrote:
> > 
> > Actually, it should be:
> > 
> > 	while (count && ((long)tmp & (sizeof(long) - 1)))
> > 
> 
> Oops, you're right, I forgot that the count could be small.
> 
> But, now that I think of it, maybe this would be best...
> 
>  char *strncpy(char *dest, const char *src, size_t count)
>  {
>  	char *tmp = dest;
>  
>  	while (count && *src) {
>  		*tmp++ = *src++;
>  		count--;
>  	}
>  
> -	if (count) {
> +	if (count >= sizeof(long)) {
>  		size_t count2;
>  
> -		while (count && ((long)tmp & (sizeof(long) - 1))) {
> +		while ((long)tmp & (sizeof(long) - 1)) {
>  			*tmp++ = '\0';
>  			count--;
>  		}
>  
>  		count2 = count / sizeof(long);
>  		while (count2) {
>  			*((long *)tmp)++ = '\0';
>  			count2--;
>  		}
>  
>  		count &= (sizeof(long) - 1);
> -		while (count) {
> -			*tmp++ = '\0';
> -			count--;
> -		}
> +	}
> +
> +	while (count) {
> +		*tmp++ = '\0';
> +		count--;
>  	}
>  
>  	return dest;
>  }
> 
> -- 
> Dan

Looks good to me. However, this only optimizes the filling
part. So why not try to optimize the copying part too? Here
is a version that optimizes the (hopefully somewhat common)
case of both source and destination being long aligned
(UNALIGNED() and DETECT_NUL() were borrowed from newlib's
strncpy()):

#include <limits.h>

/* Non-zero if either x or y is not aligned on a "long" boundary. */
#define UNALIGNED(x, y) \
	(((long)x & (sizeof(long) - 1)) | ((long)y & (sizeof(long) - 1)))

/* DETECT_NUL() is non-zero if x contains a NUL byte. */
#if LONG_MAX == 2147483647L
#define DETECT_NUL(x) (((x) - 0x01010101) & ~(x) & 0x80808080)
#else
#if LONG_MAX == 9223372036854775807L
#define DETECT_NUL(x) (((x) - 0x0101010101010101) & ~(x) & 0x8080808080808080)
#else
#error long int is not a 32bit or 64bit type.
#endif
#endif

char *strncpy(char *dest, const char *src, size_t count)
{
	char *tmp = dest;

	if (!UNALIGNED(src, tmp)) {
		while (count >= sizeof(long)) {
			if (DETECT_NUL(*((long*)src)))
				break;

			*((long *)tmp)++ = *((long *)src)++;
			count -= sizeof(long);
		}
	}

	while (count) {
		count--;
		if (!(*tmp++ = *src++))
			break;
	}

	if (count) {
		size_t count2;

		if (count >= sizeof(long)) {
			while ((long)tmp & (sizeof(long) - 1)) {
				*tmp++ = '\0';
				count--;
			}

			count2 = count / sizeof(long);
			while (count2) {
				*((long *)tmp)++ = '\0';
				count2--;
			}
		}

		count &= (sizeof(long) - 1);
		while (count) {
			*tmp++ = '\0';
			count--;
		}
	}

	return dest;
}

And here are some benchmarking numbers for the CRIS
architecture. "Multi copy & fill" is the code above.
"Multi copy+memset" is the same as above, but with the
filling replaced by a call to memset().

Multi copy+memset 1.374258    2.627357    3.125354    4.614480  
Multi copy & fill 1.339129    2.607850    3.260540    8.303503  
Multi byte fill   2.336643    4.619374    5.290972   10.326644  
For loops         2.828718    5.591865    8.110286   40.684943  
strncpy (glibc)   2.201317    4.273052    7.281693   31.474109  
strncpy (uClibc)  2.311860    4.588357    9.112990   45.387527  

And the numbers for my P4:

Multi copy+memset 1.284029    2.111502    4.672941    8.470845  
Multi copy & fill 1.203095    2.160514    3.265682    8.645152  
Multi byte fill   3.161438    6.249649    7.144416   12.687760  
For loops         3.202569    6.028025    9.410537   33.492053  
strncpy (glibc)   2.359909    3.943612    6.952230   29.604865  
strncpy (uClibc)  3.234713    5.943762   10.137144   39.651053  

For unaligned source or destination the "Multi copy & fill" 
would degenerate into "Multi byte fill". However, for
architectures like ix86 and CRIS that can do unaligned long
access, it would be a win to remove the UNALIGNED() check,
and use long word copying all the time.

Then whether using memset() or your filling is a win depends
on the architecture and how many bytes needs to be filled.
For a slow processor with little function call overhead (like
CRIS), using memset seems to be a win almost immediately.
However, for a fast processor like my P4, the call to memset
is not a win until some 1500 bytes need to be filled.

//Peter
