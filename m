Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263407AbTFGTwZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jun 2003 15:52:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263451AbTFGTwY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jun 2003 15:52:24 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:38412 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S263407AbTFGTwX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jun 2003 15:52:23 -0400
Date: Sat, 7 Jun 2003 13:05:29 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Paul Mackerras <paulus@samba.org>
cc: benh@kernel.crashing.org, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix check warnings in drivers/macintosh
In-Reply-To: <16097.53391.364090.367854@argo.ozlabs.ibm.com>
Message-ID: <Pine.LNX.4.44.0306071259050.2393-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 7 Jun 2003, Paul Mackerras wrote:
> 
> This patch removes the warnings that the `check' program came up with
> in drivers/macintosh.  This involves adding __user in various places
> and fixing some non-ANSI function definitions for functions that take
> no arguments.

Thanks, but please avoid doing things like this:

> diff -urN linux-2.5/drivers/macintosh/macserial.c pmac-2.5/drivers/macintosh/macserial.c
> --- linux-2.5/drivers/macintosh/macserial.c	2003-06-07 08:57:42.000000000 +1000
> +++ pmac-2.5/drivers/macintosh/macserial.c	2003-06-07 14:35:34.000000000 +1000
> @@ -1496,7 +1496,7 @@
>  			if (c <= 0)
>  				break;
>  
> -			c -= copy_from_user(tmp_buf, buf, c);
> +			c -= copy_from_user(tmp_buf, (void __user *) buf, c);

The problem here is that "buf" has the wrong type, and you're hiding it 
with a cast.

That's pointless - yes, it avoids a warning from "check", but the thing 
is, that warning was _correct_, and you just hid the problem.

If "buf" really is a user pointer, then it should have been marked that 
way in the first place.

I understand why you did it the way you did: the tty functions are badly 
designed, and the same function is used for both user and kernel pointers.

And that's something that check does and _should_ warn about. The function 
definition is crap, and I'd rather have the warning there and hope some 
tty layer person comes along and makes the user/kernel case into separate 
functions (they don't share that much code anyway, since most of the 
function is

	if (from_user) {
		user case
	} else {
		kernel case
	}

anyway.

I hate these kinds of "flag" arguments anyway. If a function does two
different things, it should be two different functions. Yeah, I know, the
"gfp_mask" thing for the memory allocators are the same way, and yeah,
that was a design mistake too.

		Linus

