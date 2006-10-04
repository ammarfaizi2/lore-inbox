Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750900AbWJDDfO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750900AbWJDDfO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 23:35:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750698AbWJDDfN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 23:35:13 -0400
Received: from smtp.osdl.org ([65.172.181.4]:38354 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161069AbWJDDdh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 23:33:37 -0400
Date: Tue, 3 Oct 2006 20:32:44 -0700
From: Andrew Morton <akpm@osdl.org>
To: andrew.j.wade@gmail.com
Cc: tim.c.chen@linux.intel.com, herbert@gondor.apana.org.au,
       linux-kernel@vger.kernel.org, leonid.i.ananiev@intel.com
Subject: Re: [PATCH] Fix WARN_ON / WARN_ON_ONCE regression
Message-Id: <20061003203244.9edd94b9.akpm@osdl.org>
In-Reply-To: <200610032324.29454.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com>
References: <1159916644.8035.35.camel@localhost.localdomain>
	<1159920569.8035.71.camel@localhost.localdomain>
	<20061003181452.778291fb.akpm@osdl.org>
	<200610032324.29454.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Oct 2006 23:24:27 -0400
Andrew James Wade <andrew.j.wade@gmail.com> wrote:

> On Tuesday 03 October 2006 21:14, Andrew Morton wrote:
> > There are changes here: in the old code we'll avoid reading the static
> > variable.  In the new code we'll read the static variable, but we'll avoid
> > evaluating the condition.
> 
> Tim Chen's patch goes back to the old behaviour. I suspect the cache
> misses on __warn_once is what he is measuring. If so, the (untested)
> patch below should reduce the cache misses back to those of the old
> code.
> 
> signed-off-by: Andrew Wade <andrew.j.wade@gmail.com>
> diff -rupN a/include/asm-generic/bug.h b/include/asm-generic/bug.h
> --- a/include/asm-generic/bug.h	2006-10-03 13:58:40.000000000 -0400
> +++ b/include/asm-generic/bug.h	2006-10-03 23:17:37.000000000 -0400
> @@ -45,9 +45,10 @@
>  	static int __warn_once = 1;			\
>  	typeof(condition) __ret_warn_once = (condition);\
>  							\
> -	if (likely(__warn_once))			\
> -		if (WARN_ON(__ret_warn_once)) 		\
> +	if (unlikely(__ret_warn_once) && __warn_once) {	\
>  			__warn_once = 0;		\
> +			WARN_ON(1);			\
> +	};						\
>  	unlikely(__ret_warn_once);			\
>  })

It might help, but we still don't know what's going on (I think).

I mean, if cache misses against __warn_once were sufficiently high for it
to affect performance, then __warn_once would be, err, in cache?
