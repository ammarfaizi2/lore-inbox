Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263656AbUEKVO5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263656AbUEKVO5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 17:14:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263661AbUEKVO4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 17:14:56 -0400
Received: from fw.osdl.org ([65.172.181.6]:14768 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263656AbUEKVOy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 17:14:54 -0400
Date: Tue, 11 May 2004 14:17:17 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ram Pai <linuxram@us.ibm.com>
Cc: alexeyk@mysql.com, nickpiggin@yahoo.com.au, peter@mysql.com,
       linux-kernel@vger.kernel.org, axboe@suse.de
Subject: Re: Random file I/O regressions in 2.6
Message-Id: <20040511141717.719f3ac8.akpm@osdl.org>
In-Reply-To: <1084308706.25954.28.camel@localhost.localdomain>
References: <200405022357.59415.alexeyk@mysql.com>
	<200405050301.32355.alexeyk@mysql.com>
	<20040504162037.6deccda4.akpm@osdl.org>
	<200405060204.51591.alexeyk@mysql.com>
	<20040506014307.1a97d23b.akpm@osdl.org>
	<1084218659.6140.459.camel@localhost.localdomain>
	<20040510132151.238b8d0c.akpm@osdl.org>
	<1084228767.6140.832.camel@localhost.localdomain>
	<20040510160740.5db8c62c.akpm@osdl.org>
	<1084308706.25954.28.camel@localhost.localdomain>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ram Pai <linuxram@us.ibm.com> wrote:
>
> Looks like you are right on all counts!

It's a probabilistic thing.

> I did some modifications to your
> patch and did a preliminary run with my user-level simulator. With these
> changes I am able to get rid of that extra page. Also code looks much
> simpler and adapts well to sequential and random patterns.

That is good news.

> However I have to run this under some benchmarks and see how it fares.
> Its a pre-alpha level patch.

It is nicer, thanks.  I'll add it to -mm and hopefully Meredith and co will
include it in regular performance testing.

> Can you take a quick look at the changes and see if you like it? I am
> sure you won't consider these changes a hack ;)

Couple of minor things:

> -	unsigned long preoffset=0;

yay!

> +	unsigned long average=0;

Please add spaces around '='.  But I don't think this needs to be
initialised at all.


>  	/*
>  	 * Here we detect the case where the application is performing
> @@ -394,10 +394,17 @@ page_cache_readahead(struct address_spac
>  		if (ra->serial_cnt <= (max * 2))
>  			ra->serial_cnt++;
>  	} else {
> -		ra->average = (ra->average + ra->serial_cnt) / 2;
> +		/* to avoid rounding errors, ensure that 'average' 
> +		 * tends towards the value of ra->serial_cnt.
> +		 */

multiline comment layout:

		/*
		 * To avoid rounding errors, ensure that 'average' tends
		 * towards the value of ra->serial_cnt.
		 */

(I said "minor").

I can't say that I immediately understand what is the issue here with
rounding errors?


> +                if(ra->average > ra->serial_cnt) {

space between "if" and "("

> +			ra->next_size = (ra->average > max ?  
> +				max : ra->average); 

	min(max, ra->average) ?


