Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291248AbSBSLSp>; Tue, 19 Feb 2002 06:18:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291251AbSBSLSf>; Tue, 19 Feb 2002 06:18:35 -0500
Received: from gold.MUSKOKA.COM ([216.123.107.5]:58129 "EHLO gold.muskoka.com")
	by vger.kernel.org with ESMTP id <S291248AbSBSLSV>;
	Tue, 19 Feb 2002 06:18:21 -0500
Message-ID: <3C722D25.320BA3B2@yahoo.com>
Date: Tue, 19 Feb 2002 05:47:01 -0500
From: Paul Gortmaker <p_gortmaker@yahoo.com>
X-Mailer: Mozilla 3.04 (X11; I; Linux 2.2.20 i586)
MIME-Version: 1.0
To: Jan Schubert <Jan.Schubert@GMX.li>
CC: linux-kernel@vger.kernel.org, boris@kista.gajba.net
Subject: Re: mdacon driver updates
In-Reply-To: <3C71A149.3030706@GMX.li>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Schubert wrote:
> 
> I've posted a small fix to mdacon.c at the end of last year (while
> Marcello was in vacation). It has'nt made it to the kernel yet, nor was
> there any feedback. I've thought, thats the way like open source works...

Well, you can't be too surprised when everybody doesn't jump to review
driver changes for hardware that dates to the early 80's  :)

I think your change may break true MDA cards (as in an original full
length 8 bit text only card, clustered with enough TTL chips that could
heat a small room...)

If I read the current code right, the p==q case means that TYPE_MDA 
remains set, and these cards don't get mda_initialize().  Only the
TYPE_HERC* cards get mda_initialize().

Your change forces TYPE_HERC and forces mda_initialize() on all 
non Herc cards, which is a departure from existing behaviour.

So, there are two possibilities:

   1) mda_initialize() should really be called hga_initialize() and
      your card is simply broken in some way  :)
or

   2) mda_initialize() is also needed for some non Herc cards too.

What kind of card did you say needed this change?

Paul.

> 
> So, here we go again (against 2.4.17; my MDA is detected, but not
> initialized, see my last posting):
> 
> --- drivers/video/mdacon.c.orig    Sun Dec 30 02:44:25 2001
> +++ drivers/video/mdacon.c    Sun Dec 30 21:36:50 2001
> @@ -24,6 +24,7 @@
>   *
>   *  Changelog:
>   *  Paul G. (03/2001) Fix mdacon= boot prompt to use __setup().
> + *  20011230 Jan.Schubert@GMX.li - consider non-Hercules MDA compatible
>   */
> 
>  #include <linux/types.h>
> @@ -291,6 +292,10 @@
>                                 break;
>                 }
>         }
> +       else {  /* consider non-Hercules as Hercules-compatible */
> +               mda_type = TYPE_HERC;
> +               mda_type_name = "Hercules compatible (hopefully)";
> +       }
> 
>         return 1;
>  }
> @@ -342,9 +347,8 @@
>                 return NULL;
>         }
> 
> -       if (mda_type != TYPE_MDA) {
> -               mda_initialize();
> -       }
> +       /* at this point, we found an MDA */
> +       mda_initialize();
> 
>         /* cursor looks ugly during boot-up, so turn it off */
>         mda_set_cursor(mda_vram_len - 1);
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

