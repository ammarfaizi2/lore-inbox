Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261742AbSKHJvh>; Fri, 8 Nov 2002 04:51:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261745AbSKHJvh>; Fri, 8 Nov 2002 04:51:37 -0500
Received: from rrzd1.rz.uni-regensburg.de ([132.199.1.6]:24592 "EHLO
	rrzd1.rz.uni-regensburg.de") by vger.kernel.org with ESMTP
	id <S261742AbSKHJvf>; Fri, 8 Nov 2002 04:51:35 -0500
From: "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de>
Organization: Universitaet Regensburg, Klinikum
To: linux-kernel@vger.kernel.org
Date: Fri, 08 Nov 2002 10:57:08 +0100
MIME-Version: 1.0
Subject: Re: [TRIVIAL] 2.4.19 Fix adjtimex when txc->modes == 0
CC: "Michael Kerrisk" <m.kerrisk@gmx.net>
Message-ID: <3DCB9884.19253.AE2807@localhost>
In-reply-to: <20021108081529.559392C3AF@lists.samba.org>
X-mailer: Pegasus Mail for Windows (v4.02)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
X-Content-Conformance: HerringScan-0.13/Sophos-3.62+2.10+2.03.098+07 October 2002+76770@20021108.095213Z
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty,

your EMail address (Rusty Trivial Russell <@rustcorp.com.au>) 
is broken. I'm replying to linux-kernel instead.

I had reported this problem a long time (over a year at least) 
to the list. I found no 100% solution that is compatible with 
the old kernel version.

Best solution would be to separate the NTP functionality 
(ntp_adjtime, ntp_gettime) from adjtime() in the kernel.

I wonder how adjtime(NULL, non_null) is implemented:
If "modes == 0" adjtimex() will emulate ntp_gettime()
if "modes & ADJ_OFFSET_SINGLESHOT" is set with "txc->offset == 
0", the current correction will be stopped.
You must distinguish it from a call to adjtime(non_null, 
non_null) with an offset of 0 that will terminate the current 
correction.

(Manual says: "The second call to adjtime() stops the first 
call to adjtime() if delta is non-NULL, but does not undo the 
effects of the previous call. If delta is NULL, then no time 
correction will be done.")

If adjtimex() still should implement both library styles 
(ntp_*, and adjtime()), the clean solution would be a new flag 
like ADJ_OFFSET_QUERY (or ADJ_OFFSET_NO_SHOT or 
ADJ_OFFSET_PEACE).  [Well I'm beginning to like the last one ;-
)]

If adjtime(NULL, any) is used in Clib, adjtimex would have to 
be called with the ADJ_OFFSET_PEACE flag, avoiding to disturb 
the adjustment. If `any' is non-NULL, the offset would be 
returned to user land.

Rehards,
Ulrich

On 8 Nov 2002 at 18:51, Rusty Trivial Russell wrote:

> Ulrich, does this look good to you?
> 
> From:  "Michael Kerrisk" <m.kerrisk@gmx.net>
> 
>   Hello Marcelo (or Rusty does this belong you as TPM?),
>   
>   I did try submitting it against 2.4.18pre10 but this patch
>   didn't seem to make it.  The problem still exists in 2.4.19.
>   
>   The glibc implementation of adjtime(delta, old_delta) should return
>   the remaining time adjustment value from adjtimex() in old_delta if that
>   argument is non-NULL.  
>   
>   This is broken in the case that delta is NULL (i.e., we don't want 
>   a change, but just to find out the current time_adjust).  The breakage
>   occurs because adjtime specifies txc->modes as 0 (so that no change
>   is made to the current offset) and in this case do_adjtimex() does not
>   correctly return the required information in txc->offset.  
>   
>   The patch below (against 2.4.19) seems to me the best way to 
>   fix the problem.
>   
>   Cheers,
>   
>   Michael
>   
> 
> --- trivial-2.5-bk/kernel/time.c.orig	2002-11-08 18:46:34.000000000 +1100
> +++ trivial-2.5-bk/kernel/time.c	2002-11-08 18:46:34.000000000 +1100
> @@ -361,7 +361,9 @@
>  	    /* p. 24, (d) */
>  		result = TIME_ERROR;
>  	
> -	if ((txc->modes & ADJ_OFFSET_SINGLESHOT) == ADJ_OFFSET_SINGLESHOT)
> +	if (!txc->modes)
> +	    txc->offset	   = time_adjust;
> +	else if ((txc->modes & ADJ_OFFSET_SINGLESHOT) == ADJ_OFFSET_SINGLESHOT)
>  	    txc->offset	   = save_adjust;
>  	else {
>  	    if (time_offset < 0)
> -- 
>   Don't blame me: the Monkey is driving
>   File: "Michael Kerrisk" <m.kerrisk@gmx.net>: [patch] 2.4.19 Fix adjtimex when txc->modes == 0


