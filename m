Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268854AbTBZSNd>; Wed, 26 Feb 2003 13:13:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268869AbTBZSNc>; Wed, 26 Feb 2003 13:13:32 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:40452 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S268854AbTBZSMx>;
	Wed, 26 Feb 2003 13:12:53 -0500
Date: Wed, 26 Feb 2003 10:14:54 -0800
From: Greg KH <greg@kroah.com>
To: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Cc: Linux Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 7/8] dm: __LOW macro fix no. 2
Message-ID: <20030226181454.GA16350@kroah.com>
References: <20030226170537.GA8289@fib011235813.fsnet.co.uk> <20030226171249.GG8369@fib011235813.fsnet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030226171249.GG8369@fib011235813.fsnet.co.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 26, 2003 at 05:12:49PM +0000, Joe Thornber wrote:
> Another fix for the __LOW macro.
> 
> When dm_table and dm_target structures are initialized, the "limits" fields 
> (struct io_restrictions) are initialized to zero (e.g. in dm_table_add_target()
> in dm-table.c). However, zero is not a useable value in these fields. The
> request queue will never let an I/O through, regardless of how small it might
> be, if max_sectors is set to zero (see generic_make_request in ll_rw_blk.c).
> This change to the __LOW() macro sets these fields correctly when they are
> first initialized.  [Kevin Corry]
> 
> --- diff/drivers/md/dm-table.c	2003-02-26 16:10:02.000000000 +0000
> +++ source/drivers/md/dm-table.c	2003-02-26 16:10:19.000000000 +0000
> @@ -79,7 +79,7 @@
>  }
>  
>  #define __HIGH(l, r) if (*(l) < (r)) *(l) = (r)
> -#define __LOW(l, r) if (*(l) > (r)) *(l) = (r)
> +#define __LOW(l, r) if (*(l) == 0 || *(l) > (r)) *(l) = (r)

Any reason to not use the existing min() and max() macros instead of
these?  Then:
	__HIGH(foo, bar);
can be written as:
	foo = max(foo, bar);
which is (IMHO) easier to read.

By special casing the logic in your __LOW() macro, you're only asking
for trouble in the long run :)

thanks,

greg k-h
