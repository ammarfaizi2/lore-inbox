Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312357AbSCUPg5>; Thu, 21 Mar 2002 10:36:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312348AbSCUPgr>; Thu, 21 Mar 2002 10:36:47 -0500
Received: from rrzd1.rz.uni-regensburg.de ([132.199.1.6]:39177 "EHLO
	rrzd1.rz.uni-regensburg.de") by vger.kernel.org with ESMTP
	id <S312368AbSCUPg2>; Thu, 21 Mar 2002 10:36:28 -0500
From: "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de>
Organization: Universitaet Regensburg, Klinikum
To: linux-kernel@vger.kernel.org
Date: Thu, 21 Mar 2002 16:22:27 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: [PATCH] 2.4.19 do_adjtimex parameter checking
CC: trivial@rustcorp.com.au, Paul Gortmaker <p_gortmaker@yahoo.com>
Message-ID: <3C9A08C2.13553.1CBE6CD@localhost>
In-Reply-To: <3C99E2E2.30DCCF46@yahoo.com>
X-mailer: Pegasus Mail for Win32 (v3.12c)
X-Content-Conformance: HerringScan-0.9/Sophos-3.53+2.6+2.03.083+07 January 2002+71269@20020321.151020Z
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 21 Mar 2002, at 8:40, Paul Gortmaker wrote to me:

> Spotted by Tajthy.Tamas @ datentechnik.hu:
> 
> Adjtimex modes may contain other bits set in addition to
> ADJ_OFFSET_SINGLESHOT bits, and hence tests for strict (in)equality
> are not appropriate - must test for ADJ_OFFSET_SINGLESHOT
> bits set in modes.  Three places in the code where this test
> is made - oddly enough the 3rd is already correct.

Hello, 
masters of the bits,

basically no: adjtimex() is either adjtime() or ntp_adjtime or 
ntp_gettime(). While one could think to set multiple bit combinations, 
it was never intended. At the user level adjtimex() should never have 
existed. This patch would open a new incompatible use of adjtimex() by 
blessing what was illegal before IMHO.

ADJ_OFFSET_SINGLESHOT has be be used alone, specifically also to return 
the correct return value.

Regards,
Ulrich

> 
> 
> --- linux/kernel/time.c~	Thu Feb 28 09:37:32 2002
> +++ linux/kernel/time.c		Thu Mar 21 08:27:49 2002
> @@ -216,7 +216,7 @@
>  		
>  	/* Now we validate the data before disabling interrupts */
>  
> -	if (txc->modes != ADJ_OFFSET_SINGLESHOT && (txc->modes & ADJ_OFFSET))
> +	if (((txc->modes & ADJ_OFFSET_SINGLESHOT) != ADJ_OFFSET_SINGLESHOT) && (txc->modes & ADJ_OFFSET))
>  	  /* adjustment Offset limited to +- .512 seconds */
>  		if (txc->offset <= - MAXPHASE || txc->offset >= MAXPHASE )
>  			return -EINVAL;	
> @@ -275,7 +275,7 @@
>  	    }
>  
>  	    if (txc->modes & ADJ_OFFSET) {	/* values checked earlier */
> -		if (txc->modes == ADJ_OFFSET_SINGLESHOT) {
> +		if ((txc->modes & ADJ_OFFSET_SINGLESHOT) == ADJ_OFFSET_SINGLESHOT) {
>  		    /* adjtime() is independent from ntp_adjtime() */
>  		    time_adjust = txc->offset;
>  		}
> 
> 


