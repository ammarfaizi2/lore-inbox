Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270642AbTHCB7N (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Aug 2003 21:59:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270658AbTHCB7M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Aug 2003 21:59:12 -0400
Received: from tomts6.bellnexxia.net ([209.226.175.26]:42911 "EHLO
	tomts6-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S270642AbTHCB6u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Aug 2003 21:58:50 -0400
Subject: Re: 2.6.0-test2-mm3 and mysql
From: Shane Shrybman <shrybman@sympatico.ca>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20030802180410.265dfe40.akpm@osdl.org>
References: <1059871132.2302.33.camel@mars.goatskin.org>
	 <20030802180410.265dfe40.akpm@osdl.org>
Content-Type: text/plain
Organization: 
Message-Id: <1059875927.2966.32.camel@mars.goatskin.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 02 Aug 2003 21:58:47 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-08-02 at 21:04, Andrew Morton wrote:
> Shane Shrybman <shrybman@sympatico.ca> wrote:
> >
> > mysql doesn't start on this kernel.
> 
> That's because I'm an idiot.


Ah.. thats good 8) For once its not me. :)
> 
> --- 25/fs/mpage.c~awe-use-gfp_flags-braino	Sat Aug  2 18:03:01 2003
> +++ 25-akpm/fs/mpage.c	Sat Aug  2 18:03:01 2003
> @@ -568,7 +568,7 @@ confused:
>  	 */
>  	if (*ret == -ENOSPC)
>  		set_bit(AS_ENOSPC, &mapping->flags);
> -	else
> +	else if (*ret)
>  		set_bit(AS_EIO, &mapping->flags);
>  out:
>  	return bio;
> @@ -673,7 +673,7 @@ mpage_writepages(struct address_space *m
>  				ret = (*writepage)(page, wbc);
>  				if (ret == -ENOSPC)
>  					set_bit(AS_ENOSPC, &mapping->flags);
> -				else
> +				else if (ret)
>  					set_bit(AS_EIO, &mapping->flags);
>  			} else {
>  				bio = mpage_writepage(bio, page, get_block,
> diff -puN mm/vmscan.c~awe-use-gfp_flags-braino mm/vmscan.c
> --- 25/mm/vmscan.c~awe-use-gfp_flags-braino	Sat Aug  2 18:03:01 2003
> +++ 25-akpm/mm/vmscan.c	Sat Aug  2 18:03:01 2003
> @@ -254,7 +254,7 @@ static void handle_write_error(struct ad
>  	if (page->mapping == mapping) {
>  		if (error == -ENOSPC)
>  			set_bit(AS_ENOSPC, &mapping->flags);
> -		else
> +		else if (error)
>  			set_bit(AS_EIO, &mapping->flags);
>  	}
>  	unlock_page(page);
> 
> _
> 
> > One last thing, I have started seeing mysql database corruption
> > recently. I am not sure it is a kernel problem. And I don't know the
> > exact steps to reproduce it, but I think I started seeing it with
> > -test2-mm2. I haven't ever seen db corruption in the 8-12 months I have
> > being playing with mysql/php.
> 
> hm, that's a worry.  No additional info available?
> 
The db corruption hit again on test2-mm2. I am on -test1-mm1 trying to
reproduce it there. I don't now what little query or update is the
problem. There is nothing in the system logs. I went through everything
that I thought might have been happening at the time and the tables came
up clean with the "check tables" command. Then it happened a bit later.
There is a cron job doing a query every minute, but it doesn't happen
all the time. I don't know, its probably some config change I made to
mysql.

I am still backing out the 64 bit devt bit, I assume that is still
needed. The db and mysql binaries are on, respectively:

/dev/vg02/varlv /var ext3 rw,noatime,nosuid,nodev 0 0
/dev/vg02/usrlv /usr ext3 rw,noatime,nodev 0 0

mysql version
mysql  Ver 12.12 Distrib 4.0.3-beta, for pc-linux-gnu (i686)

dmesg
http://zeke.yi.org/linux/2.6.0-test2-mm2.dmesg

Shane

