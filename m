Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261182AbVAaM6M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261182AbVAaM6M (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 07:58:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261184AbVAaM6M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 07:58:12 -0500
Received: from colin2.muc.de ([193.149.48.15]:49419 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S261182AbVAaM57 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 07:57:59 -0500
Date: 31 Jan 2005 13:57:58 +0100
Date: Mon, 31 Jan 2005 13:57:58 +0100
From: Andi Kleen <ak@muc.de>
To: Tom Zanussi <zanussi@us.ibm.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Andi Kleen <ak@muc.de>, Roman Zippel <zippel@linux-m68k.org>,
       Robert Wisniewski <bob@watson.ibm.com>, Tim Bird <tim.bird@AM.SONY.COM>,
       karim@opersys.com
Subject: Re: [PATCH] relayfs redux, part 2
Message-ID: <20050131125758.GA23172@muc.de>
References: <16890.38062.477373.644205@tut.ibm.com> <m1d5volksx.fsf@muc.de> <16892.26990.319480.917561@tut.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16892.26990.319480.917561@tut.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 29, 2005 at 10:58:22PM -0600, Tom Zanussi wrote:
>  > The logging fast path seems still a bit slow to me. I would like
>  > to have a logging macro that is not much worse than a stdio putc,
>  > basically something like
>  > 
>  >           get_cpu();
>  >           if (buffer space > N) { 
>  >               memcpy(buffer, input, N);
>  >               buffer pointer += N;
>  >           } else { 
>  >               FreeBuffer(input, N); 
>  >           }    
>  >           put_cpu();
>  > 
> 
> I think what we have now is somewhat similar, except that we wanted to

It's doing a complicated function call which does who knows what in
the logging fast path (I stopped reading after some point)  
It definitely is not putc !

> separate grabbing a slot in the buffer from the memcpy because some
> applications such as ltt want to be able to directly write into the
> slot without having to copy it into another buffer first.  How about

If the inline function to log was fast enough it wouldn't need 
any such hacks.

Note that gcc is quite good at optimizing memcpy, so essentially
when you e.g. do log(singleint) it should be roughly equivalent
to a int store into the buffer + the check if there is enough
buffer space.

> something like this for relay reserve, with the local_add_return()
> gone since we're assuming the client protects the buffer properly for
> whatever it's doing:

I think relay_reserve shouldn't be in the fast path at all.

The simple write should simple be the traditional stdio putc pattern

	if (buffer + datalen < bufferend) { 
		memcpy(buffer, data, datalen);
		buffer += datalen;
	} else {
		flush(buffer, datalen); /* flush takes care of the slow path */
	}

This is quite fast for the fast path and expands to reasonably compact 
inline code too.

The only interesting part is how to protect this against interrupts.
For that you need an local_irq_save(); local_irq_restore() which
can be unfortunately quite costly (P4 is really slow at PUSHF) 

That is why I would provide a __ variant of the simple
where the caller guarantees no disruption by interrupts.

On preemptive kernel the local_irq_save takes care of CPU 
preemption, the __ variant should probably disable preemption
to avoid mistakes. For non __ it is not needed.

>  > This would need interrupt protection only if interrupts can access
>  > it, best you use separate buffers for that too.
> 
> Not sure what you mean by separate buffers for that too.  Can you
> expand on that a little?

You could avoid the local_irq_save() if you use separate interrupt
buffers that are only accessed in non nesting interrupt context 
(like softirqs) That would require a sorting step at output though. Not
sure if it's worth it. The problem is that hardirqs can nest anyways,
so it wouldn't work for them. However a lot of important code runs
in softirq (like the network stack) where this is true.

-Andi
