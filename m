Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262394AbTB0JY0>; Thu, 27 Feb 2003 04:24:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262420AbTB0JY0>; Thu, 27 Feb 2003 04:24:26 -0500
Received: from unthought.net ([212.97.129.24]:31872 "EHLO mail.unthought.net")
	by vger.kernel.org with ESMTP id <S262394AbTB0JYZ>;
	Thu, 27 Feb 2003 04:24:25 -0500
Date: Thu, 27 Feb 2003 10:34:42 +0100
From: Jakob Oestergaard <jakob@unthought.net>
To: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Cc: Linux Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 7/8] dm: __LOW macro fix no. 2
Message-ID: <20030227093442.GC4239@unthought.net>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	Joe Thornber <joe@fib011235813.fsnet.co.uk>,
	Linux Mailing List <linux-kernel@vger.kernel.org>
References: <20030226170537.GA8289@fib011235813.fsnet.co.uk> <20030226171249.GG8369@fib011235813.fsnet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030226171249.GG8369@fib011235813.fsnet.co.uk>
User-Agent: Mutt/1.3.28i
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

As someone else suggested, it would be good style to just use the
existing min() and max() macros.

Special-casing like the above is a recipe for disaster - having a
macro named "__LOW" which actually translates to  "min() unless left
argument is zero in which case we do a max() instead" is going to get
someone in trouble one day.

I'd say use "min()" and if there are places in the code where you want
min() unless that will be zero, then make that condition *explicit* at
those places in the code.

If you want a magic "usually_min_but_sometimes_max()" macro, then make
it's *name* reflect it's voodoo propeties.

Just my 0.02 Euro

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
