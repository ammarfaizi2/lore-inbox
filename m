Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132622AbQL1X4K>; Thu, 28 Dec 2000 18:56:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132694AbQL1X4B>; Thu, 28 Dec 2000 18:56:01 -0500
Received: from Cantor.suse.de ([194.112.123.193]:9747 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S132622AbQL1Xz4>;
	Thu, 28 Dec 2000 18:55:56 -0500
Date: Fri, 29 Dec 2000 00:25:27 +0100
From: Andi Kleen <ak@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Andi Kleen <ak@suse.de>, Marcelo Tosatti <marcelo@conectiva.com.br>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: test13-pre5
Message-ID: <20001229002527.C25388@gruyere.muc.suse.de>
In-Reply-To: <20001228231722.A24875@gruyere.muc.suse.de> <Pine.LNX.4.10.10012281459150.995-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10012281459150.995-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Thu, Dec 28, 2000 at 03:15:01PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 28, 2000 at 03:15:01PM -0800, Linus Torvalds wrote:
> > (first number for 32bit, second for 64bit) 
> > 
> > - Do not compile virtual in when the kernel does not support highmem
> > (saves 4/8 bytes) 
> 
> Even on UP, "virtual" often helps. The conversion from "struct page" to
> the linear address is quite common, and if "struct page" isn't a
> power-of-two it gets slow.

Are you sure? Last time I checked gcc did a very good job at optimizing
small divisions with small integers, without using div. It just has to 
be a good integer with not too many set bits.

> is 100% accurate, we _do_ care that the fields close-by don't get strange
> effects from updating "age". We used to have exactly this problem on alpha
> back in the 2.1.x timeframe.

When it is shared with a constant field (like zone index) it shouldn't
matter, no ? At worst you can see outdated data, and when the outdated
data is constant all is fine.

> > - flags can be __u32 on 64bit hosts, sharing 64bit with something that
> > is tolerant to async updates (e.g. the zone table index or the index) 
> > - index could be probably u32 instead of unsigned long, saving 4 bytes
> > on i386
> 
> It already _is_ 32-bit on x86. 

Oops. It was a typo. I meant to write "saving 4 bytes on 64bit"

> Anyway, I don't want to increase "struct page" in size, but I also don't
> think it's worth micro-optimizing some of these things if the code gets
> harder to maintain (like the partial-word stuff would be).

Ok pity :-/

Hopefully all the "goto out" micro optimizations can be taken out then too,
I recently found out that gcc 2.97's block moving pass has the tendency
to move the outlined blocks inline again ;) 



-Andi
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
