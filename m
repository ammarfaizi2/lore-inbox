Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265255AbUGCU4N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265255AbUGCU4N (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jul 2004 16:56:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265257AbUGCU4N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jul 2004 16:56:13 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:35200 "EHLO midnight.ucw.cz")
	by vger.kernel.org with ESMTP id S265255AbUGCU4K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jul 2004 16:56:10 -0400
Date: Sat, 3 Jul 2004 22:56:21 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Joel Soete <soete.joel@tiscali.be>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, marcelo.tosatti@cyclades.com
Subject: Re: Some cleanup patches for: '...lvalues is deprecated'
Message-ID: <20040703205621.GA1640@ucw.cz>
References: <40E6AC41.4050804@tiscali.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40E6AC41.4050804@tiscali.be>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 03, 2004 at 12:53:21PM +0000, Joel Soete wrote:
> Hi Marcelo,
> 
> Please appolgies first for wrong presentation of previous post (that was 
> the first and certainly the last time that I used the 'forwarding' option 
> of this webmail interface :( ).
> 
> Here are some backport to clean up some warning of type: use of cast 
> experssion
> as lvalues is deprecated.
> --- linux-2.4.27-rc2-pa4mm/kernel/sysctl.c.Orig	2004-06-29 
> 09:03:42.000000000 +0200
> +++ linux-2.4.27-rc2-pa4mm/kernel/sysctl.c	2004-06-29 
> 10:10:31.588030256 +0200
> @@ -890,7 +890,7 @@
>  				if (!isspace(c))
>  					break;
>  				left--;
> -				((char *) buffer)++;
> +				buffer += sizeof(char);

This (although correct in the end) is a wrong thing to do.

It seems to look like the intention is to move the pointer by a char's
size, however your change is equivalent to:

	buffer += 1;

And if buffer wasn't void*, which it fortunately is, it would, unlike
the older construction, move the pointer by a different size.

So just use

	buffer++;

here, and the intent is then clear.

> --- linux-2.4.27-rc2-pa4mm/drivers/video/fbcon.c.Orig	2004-06-29 
> 10:47:31.901491304 +0200
> +++ linux-2.4.27-rc2-pa4mm/drivers/video/fbcon.c	2004-06-29 
> 11:13:31.846343640 +0200
> @@ -1877,7 +1877,10 @@
>         font length must be multiple of 256, at least. And 256 is multiple
>         of 4 */
>      k = 0;
> -    while (p > new_data) k += *--(u32 *)p;
> +    while (p > new_data) {
> +        p = (u8 *)((u32 *)p - 1);
> +        k += *(u32 *)p;
> +    }


How about

	p -= 4;
	k += *(u32 *)p;

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
