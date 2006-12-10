Return-Path: <linux-kernel-owner+w=401wt.eu-S1762599AbWLJVGb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762599AbWLJVGb (ORCPT <rfc822;w@1wt.eu>);
	Sun, 10 Dec 2006 16:06:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762607AbWLJVGa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Dec 2006 16:06:30 -0500
Received: from 1wt.eu ([62.212.114.60]:1444 "EHLO 1wt.eu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762599AbWLJVGa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Dec 2006 16:06:30 -0500
Date: Sun, 10 Dec 2006 22:06:14 +0100
From: Willy Tarreau <w@1wt.eu>
To: Folkert van Heusden <folkert@vanheusden.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: strncpy optimalisation? (lib/string.c)
Message-ID: <20061210210614.GD24090@1wt.eu>
References: <20061210205230.GB30197@vanheusden.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061210205230.GB30197@vanheusden.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 10, 2006 at 09:52:30PM +0100, Folkert van Heusden wrote:
> Hi,
> 
> In lib/string.c we have:
> 
> char *strncpy(char *dest, const char *src, size_t count)
> {
>         char *tmp = dest;
> 
>         while (count) {
>                 if ((*tmp = *src) != 0)
>                         src++;
>                 tmp++;
>                 count--;
>         }
>         return dest;
> }
> 
> now I wonder isn't this ineffecient when strlen(src) < count? It would
> then, if I'm correct, iterate count-strlen(src) times doing useless
> increment/decrement. And since there are aprox. 580 instances in the
> 2.6.18.2 source, maybe some efficency can be won here.
> Wouldn't it be better to do:
>                 if ((*tmp = *src) == 0x00)
>                         break;
> 
> So that would be:
> --- lib/string.c	2006-11-04 02:33:58.000000000 +0100
> +++ string-new.c	2006-12-10 21:50:05.000000000 +0100
> @@ -97,8 +97,8 @@
>  	char *tmp = dest;
>  
>  	while (count) {
> -		if ((*tmp = *src) != 0)
> -			src++;
> +		if ((*tmp = *src) == 0x00)
> +			break;
>  		tmp++;
>  		count--;
>  	}

While your code is faster, it does not do exactly the same.
Original code completely pads the destination with zeroes,
while yours only adds the last zero. Your code does what
strncpy() is said to do, but maybe there's a particular
reason for it to behave differently in the kernel (helping
during debugging, or filling specific structs).

Just out of curiosity, have you tried to do a general
benchmark to check if original code eats much CPU ?

Regards,
Willy

