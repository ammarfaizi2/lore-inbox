Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263225AbRFEF3G>; Tue, 5 Jun 2001 01:29:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263228AbRFEF24>; Tue, 5 Jun 2001 01:28:56 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:56073 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S263225AbRFEF2n>; Tue, 5 Jun 2001 01:28:43 -0400
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: Missing cache flush.
Date: 4 Jun 2001 22:28:19 -0700
Organization: A poorly-installed InterNetNews site
Message-ID: <9fhqlj$7jt$1@penguin.transmeta.com>
In-Reply-To: <13942.991696607@redhat.com> <3B1C1872.8D8F1529@mandrakesoft.com> <15132.15829.322534.88410@pizda.ninka.net> <20010605155550.C22741@metastasis.f00f.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20010605155550.C22741@metastasis.f00f.org>,
Chris Wedgwood  <cw@f00f.org> wrote:
>On Mon, Jun 04, 2001 at 07:03:01PM -0700, David S. Miller wrote:
>
>    The x86 doesn't have dumb caches, therefore it really doesn't
>    need to flush anything.  Maybe a mb(), but that is it.
>
>What if the memory is erased underneath the CPU being aware of this?
>In such a way ig generates to bus traffic...

Doing bank switching etc is outside the scope of the current DMA cache
flush macros - they are there only for "sane" cache coherency issues,
not to be used as generic "we have to flush the cache because we went
behind the back of the CPU and switched a bank of memory around". 

You will have to come up with some new primitive for this. 

The x86 has the "wbinval" instruction, although it should be noted that

 - it is buggy and will lock up some CPU's. Use with EXTREME CAUTION.
   Intel set a special field in the MP table for whether wbinval is
   usable or not, and you can probably find their errata on which CPU's
   it doesn't work on (I think it was some early PPro steppings).

   When wbinval doesn't work, there's another strategy to flush the
   cache, but I forget what it was. It was something ridiculous like
   reading in a few megabytes of memory from consecutive physical
   addresses to make sure that the cache has been replaced.

 - even when it works, it is necessarily very very very slow. Not to be
   used lightly. As you can imagine, the work-around is even slower.

On the whole, I would suggest avoiding this like the plague, and just
marking such memory to be non-cacheable, regardless of whether there is
a performance impact or not. If you mark it write-combining and
speculative, it's going to perform a bit better.

			Linus
