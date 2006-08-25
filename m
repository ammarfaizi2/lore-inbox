Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751450AbWHYK7F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751450AbWHYK7F (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 06:59:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751451AbWHYK7F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 06:59:05 -0400
Received: from khc.piap.pl ([195.187.100.11]:28368 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S1751450AbWHYK7A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 06:59:00 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-serial@vger.kernel.org, "'LKML'" <linux-kernel@vger.kernel.org>,
       libc-alpha@sources.redhat.com
Subject: Re: Serial custom speed deprecated?
References: <028a01c6c6fc$e792be90$294b82ce@stuartm>
	<1156411101.3012.15.camel@pmac.infradead.org>
	<m3bqqap09a.fsf@defiant.localdomain>
	<1156441293.3007.184.camel@localhost.localdomain>
	<m31wr6otlr.fsf@defiant.localdomain>
	<1156459387.3007.218.camel@localhost.localdomain>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Fri, 25 Aug 2006 12:58:57 +0200
In-Reply-To: <1156459387.3007.218.camel@localhost.localdomain> (Alan Cox's message of "Thu, 24 Aug 2006 23:43:07 +0100")
Message-ID: <m34pw1cc9a.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> We could implement an entirely new TCSETS/TCGETS/TCSETSA/SAW which used
> different B* values so B9600 was 9600 etc and the data was stored in
> c_ospeed/c_ispeed type separate fields and we'd support arbitary speeds
> for input and output once and for all, shoot all the multiplier hacks
> etc. As it happens the kernel code for this is easy owing to some
> fortuitous good design long ago in the tty layer.

I think it makes most sense.

> We could also implement a Linux "improved" TCSET* new set of ioctls that
> had sensible speed fields, utf-8 characters for the _cc[] array and new
> flags for all the utf-8 handling and the like. That would be less
> compatible though.

I think compatibility at the source level is good here. UTF-8 looks
nice, though.

I think it could remain compatible - c_cc[] could grow into array of
multibyte characters with:
#define VINTR 0
#define VQUIT (1 * n)
#define VERASE (2 * n)
#define VKILL (3 * n)

where n is max number of UTF-8 bytes (5 for 32-bit UCS?)

I'm not sure if UTF-8 control codes are needed in practice, though
(I mean I just don't know).

> Or we could just add a standardised extra set of speed ioctls, but then
> we need to decide what occurs if I set the speed and then issue a
> termios call - does it override or not.

A bit messy I think. I think the first way is much better. Especially
when we have multiple changes (speed and UTF-8, for example).

>> Not sure if we want int, uint, or long long for speed values :-)
>
> You want speed_t according to POSIX.

Sure, I meant what does speed_t resolve to.

> I've no idea what the glibc impact of this kind of thing would be
> (consider new glibc, old kernel etc).  I've cc'd the libc folks but I am
> not sure it is practical to do.

While obviously I'm not glibc (nor termios) expert I don't think
we should expect problems. New glibc would just issue the old ioctl
if the new one isn't available. I think similar things are already
in place.
Glibc could be compiled with minimum kernel version = 2.6.20 or so
to assume the new ioctls are always present.
-- 
Krzysztof Halasa
