Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266170AbUFUJRp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266170AbUFUJRp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jun 2004 05:17:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266171AbUFUJRp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jun 2004 05:17:45 -0400
Received: from LPBPRODUCTIONS.COM ([68.98.211.131]:50065 "HELO
	lpbproductions.com") by vger.kernel.org with SMTP id S266170AbUFUJRn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jun 2004 05:17:43 -0400
From: "Matt H." <lkml@lpbproductions.com>
Reply-To: lkml@lpbproduction.scom
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.7-bk way too fast
Date: Mon, 21 Jun 2004 02:17:26 -0700
User-Agent: KMail/1.6.52
Cc: Jeff Garzik <jgarzik@pobox.com>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
References: <40D64DF7.5040601@pobox.com> <20040621014837.6b52fa2e.akpm@osdl.org>
In-Reply-To: <20040621014837.6b52fa2e.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200406210217.27389.lkml@lpbproductions.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

That fixes it perfectly here, 

Thanks.

Matt H.

On Monday 21 June 2004 1:48 am, Andrew Morton wrote:
> Jeff Garzik <jgarzik@pobox.com> wrote:
> > Something is definitely screwy with the latest -bk.
>
> Would you believe that there is a totally separate bug in the latest -mm
> which has exactly the same symptoms?
>
> mark_offset_tsc() does
>
> 	if (lost && abs(delay - delay_at_last_interrupt) > (900000/HZ))
> 		jiffies_64++;
>
> which is doing abs(unsigned long).
>
> Which works OK if abs() in a function, but I made it a macro.
>
> This fixes it up.
>
>
> diff -puN include/linux/kernel.h~abs-fix-fix include/linux/kernel.h
> --- 25/include/linux/kernel.h~abs-fix-fix	2004-06-21 01:42:24.283873616
> -0700 +++ 25-akpm/include/linux/kernel.h	2004-06-21 01:43:08.150204920
> -0700 @@ -55,7 +55,12 @@ void __might_sleep(char *file, int line)
>  #endif
>
>  #define abs(x) ({				\
> -		typeof(x) __x = (x);		\
> +		int __x = (x);			\
> +		(__x < 0) ? -__x : __x;		\
> +	})
> +
> +#define labs(x) ({				\
> +		long __x = (x);			\
>  		(__x < 0) ? -__x : __x;		\
>  	})
>
> _
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
