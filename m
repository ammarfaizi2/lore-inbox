Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262060AbUFEWGG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262060AbUFEWGG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jun 2004 18:06:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262071AbUFEWGG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jun 2004 18:06:06 -0400
Received: from cantor.suse.de ([195.135.220.2]:56552 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262060AbUFEWGA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jun 2004 18:06:00 -0400
To: "David S. Miller" <davem@redhat.com>
Cc: olh@suse.de, linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [PATCH] compat bug in sys_recvmsg, MSG_CMSG_COMPAT check
 missing
References: <20040605204334.GA1134@suse.de>
	<20040605140153.6c5945a0.davem@redhat.com>
	<20040605140544.0de4034d.davem@redhat.com>
	<jer7st7lam.fsf@sykes.suse.de>
	<20040605143649.3fd6c22b.davem@redhat.com>
	<jen03h7k45.fsf@sykes.suse.de>
	<20040605145333.11c80173.davem@redhat.com>
From: Andreas Schwab <schwab@suse.de>
X-Yow: I need to discuss BUY-BACK PROVISIONS with at least
 six studio SLEAZEBALLS!!
Date: Sun, 06 Jun 2004 00:05:58 +0200
In-Reply-To: <20040605145333.11c80173.davem@redhat.com> (David S. Miller's
 message of "Sat, 5 Jun 2004 14:53:33 -0700")
Message-ID: <jeise57j95.fsf@sykes.suse.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" <davem@redhat.com> writes:

> On Sat, 05 Jun 2004 23:47:22 +0200
> Andreas Schwab <schwab@suse.de> wrote:
>
>> > Olaf's patch, it said:
>> >
>> > -	if (flags & ~(MSG_PEEK|MSG_DONTWAIT|MSG_TRUNC))
>> > +	if (flags & ~(MSG_PEEK|MSG_DONTWAIT|MSG_TRUNC|MSG_CMSG_COMPAT))
>> 
>> Yes, and where is the problem?
>
> If MSG_CMSG_COMPAT is "ZERO", which it will be if CONFIG_COMPAT is
> not set, then "~0" is all bits, therefore if any bit (even the ones
> we want to accept) is set we will return failure.  The test ends
> up amounting to:
>
> 	if (flags & ~0)
>
> which is true if any bit is set, that's not what we want.

Can you say DeMorgan?

> diff -Nru a/include/linux/socket.h b/include/linux/socket.h
> --- a/include/linux/socket.h	2004-06-05 14:53:34 -07:00
> +++ b/include/linux/socket.h	2004-06-05 14:53:34 -07:00
> @@ -241,8 +241,10 @@
>  
>  #if defined(CONFIG_COMPAT)
>  #define MSG_CMSG_COMPAT	0x80000000	/* This message needs 32 bit fixups */
> +#define MSG_FLAGS_USER(X)	((X) & ~MSG_CMSG_COMPAT)
>  #else
>  #define MSG_CMSG_COMPAT	0		/* We never have 32 bit fixups */
> +#define MSG_FLAGS_USER(X)	(X)
>  #endif
>  
>  
> diff -Nru a/net/appletalk/ddp.c b/net/appletalk/ddp.c
> --- a/net/appletalk/ddp.c	2004-06-05 14:53:35 -07:00
> +++ b/net/appletalk/ddp.c	2004-06-05 14:53:35 -07:00
> @@ -1567,7 +1567,7 @@
>  	struct atalk_route *rt;
>  	int err;
>  
> -	if (flags & ~MSG_DONTWAIT)
> +	if (MSG_FLAGS_USER(flags) & ~MSG_DONTWAIT)
>  		return -EINVAL;
>  
>  	if (len > DDP_MAXSZ)

This is exactly equivalent to Olaf's version.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux AG, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
