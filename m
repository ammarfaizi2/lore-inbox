Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262458AbTE0BNJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 21:13:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262489AbTE0BJI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 21:09:08 -0400
Received: from itaqui.terra.com.br ([200.176.3.19]:42930 "EHLO
	itaqui.terra.com.br") by vger.kernel.org with ESMTP id S262458AbTE0BIX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 21:08:23 -0400
Date: Mon, 26 May 2003 22:21:32 -0300
From: Rodrigo Souza de Castro <rcastro@ime.usp.br>
To: Kimmo Sundqvist <rabbit80@mbnet.fi>
Cc: linux-kernel@vger.kernel.org, linuxcompressed-devel@lists.sourceforge.net
Subject: Re: [2.4.20-ck7] good compressed caching experience
Message-ID: <20030527012132.GD3388@bach>
Mail-Followup-To: Rodrigo Souza de Castro <rcastro@ime.usp.br>,
	Kimmo Sundqvist <rabbit80@mbnet.fi>, linux-kernel@vger.kernel.org,
	linuxcompressed-devel@lists.sourceforge.net
References: <200305262150.04552.rabbit80@mbnet.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200305262150.04552.rabbit80@mbnet.fi>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kimmo!

On Mon, May 26, 2003 at 09:50:03PM +0300, Kimmo Sundqvist wrote:
> I just decided to tell everyone that I've been able to run
> 2.4.20-ck7 with compressed caching enabled in my little brother's
> Pentium 133MHz, for hours, doing stress testing, compiling kernels
> and using the Internet under X.

Great, glad to know that. 

> I had pre-empt enabled.  Compressed swap worked also.  I used 4kB
> pages without compressed swap, and 8kB with it.

Compressed cache patch isn't safe to be used with preempt, at least
not with the version you tried (0.24pre5). There are some bug reports
that I was able to check myself about fs corruptions (due to problems
in locking control). The latest code seems to fix these corruptions,
given some tests some volunteers and I performed. I ported this code
to 2.4.20, but I still couldn't figure out why it isn't as stable as
in 2.4.18 version, that is why it remains unreleased as a patch
(although it is in the CVS server).

Double page size (i.e, 8K pages) is useful when you don't have a good
compression ratio. If your data compress to more than 50% of its
original size, a compressed cache with 4K isn't supposed to provide
major performance gains.

> This was with Con's ck7pre versions released on 24th and 25th of
> May.
> 
> Now running 2.4.20-ck7pre with compressed cache in a dual CPU
> machine with SMP disabled (compressed caching and SMP support are
> still mutually exclusive),

Until I make it work safely on SMP systems, I want to make it
exclusive in the config.in.

> 1GB of RAM but "mem=128M" for testing purposes.  Been stable for 6
> hours now, and done even some stress testing.  Try 128 instances of
> burnBX with 1MB each, like "for ((A=128;A--;A<1)) do burnBX J &
> done".  A nice brute force or "if you don't behave I'll push all my
> buttons" method :)

:-)

> Wondering if Pentium 133MHz (64MB RAM) is fast enough to benefit
> from compressed caching.  I know there's a limit, depending on the
> speed of the CPU and the speed of the swap partition (doing random
> accesses), which determines if compressed caching is beneficial or
> not.

That's right. Faster CPUs have a greater tendency to benefit from
compressed caching, since the gap between them and disks is
larger. This gap is the basic principle that makes compressed caching
interesting today.

> This machine has a Seagate Barracuda V 80GB, which does sequential
> reads at 40MB/s.  I could drive this into trashing, then type "sar
> -B 1 1000" and see how the swap is doing.  Now, compressed caching
> brings me benefit if, and only if, it can compress and decompress
> pages faster than that in this CPU, which it sure does, since this
> is a Pentium III 933MHz, but I'm not sure about the little brother's
> Pentium 133MHz.  It has a 4GB Seagate that does 6MB/s sequentially.
> Did I figure it out correctly?  Of course swapping to a partition
> gets slower as the swap usage increases.  Longer seeks and the like.

Yes, you figured it out correctly. I don't know the lower limit for a
CPU to benefit from compressed caching. However I guess that, since we
already had a gap between disk and CPU with a Pentium 133 MHz, it will
probably have some advantage using it, even if not as much as with a
faster CPU. The current code was written and tested on a Pentium III 1
GHz CPU, so there may be room for improvements for such systems, as
your Pentium 133 MHz.

I would like to know your impressions about compressed caching on your
brother's system.

> Just a warning... both systems have only ReiserFS partitions.  Other
> FSes might still get hurt.

True. I don't know how you don't have your filesystem corrupted
though. I suggest you to disable preempt if you want to keep testing
this compressed cache code in order to avoid possible problems (and
you getting mad at me :-).

Thanks for your feedback.

Regards,
-- 
Rodrigo


