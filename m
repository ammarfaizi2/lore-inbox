Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265632AbUALW0b (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 17:26:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266282AbUALW0b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 17:26:31 -0500
Received: from arnor.apana.org.au ([203.14.152.115]:55819 "EHLO
	arnor.me.apana.org.au") by vger.kernel.org with ESMTP
	id S265632AbUALW0Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 17:26:24 -0500
Date: Tue, 13 Jan 2004 09:26:10 +1100
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [I810_AUDIO] 1/x: Fix wait queue race in drain_dac
Message-ID: <20040112222610.GA20177@gondor.apana.org.au>
References: <20031122070931.GA27231@gondor.apana.org.au> <4001B979.1080600@pobox.com> <20040112094625.GA16686@gondor.apana.org.au> <40031623.2000204@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40031623.2000204@pobox.com>
User-Agent: Mutt/1.5.4i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 12, 2004 at 04:48:19PM -0500, Jeff Garzik wrote:
> 
> hmmm, I'll have to think on this one a bit.  You are described observed 
> behavior here... can you go a bit deeper, and describe what two code 
> paths are racing?  I think I might a _different_ race in the code we're 
> looking at, but I do not yet see the race you are describing :(

A				B
drain_dac()
	count > 0
				i810_channel_interrupt()
					i810_update_ptr()
						count = 0
						wake_up()
	set_current_state()
	schedule_timeout()
	*TIMEOUT*

> >schedule() already checks for signals.
> 
> Well -- A signal won't be pending until after you call 
> schedule_timeout() ;-)  A signal, particularly SIGINT, might even occur 
> _during_ the schedule_timeout().

Yes, but as long as you check signal_pending at least once in each
loop it does the right thing.  Can you point me to a scenario where
checking it right after schedule_timeout produces different behaviour
than the current code?

Cheers,
-- 
Debian GNU/Linux 3.0 is out! ( http://www.debian.org/ )
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
