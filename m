Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272643AbRHaNXg>; Fri, 31 Aug 2001 09:23:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272683AbRHaNX1>; Fri, 31 Aug 2001 09:23:27 -0400
Received: from nbd.it.uc3m.es ([163.117.139.192]:54800 "EHLO nbd.it.uc3m.es")
	by vger.kernel.org with ESMTP id <S272643AbRHaNXO>;
	Fri, 31 Aug 2001 09:23:14 -0400
From: "Peter T. Breuer" <ptb@it.uc3m.es>
Message-Id: <200108311322.PAA12269@nbd.it.uc3m.es>
Subject: Re: [IDEA+RFC] Possible solution for min()/max() war
X-ELM-OSV: (Our standard violations) hdr-charset=US-ASCII
In-Reply-To: <Pine.LNX.4.33.0108301753180.2569-100000@penguin.transmeta.com>
 "from Linus Torvalds at Aug 30, 2001 05:55:51 pm"
To: Linus Torvalds <torvalds@transmeta.com>
Date: Fri, 31 Aug 2001 15:22:40 +0200 (CEST)
CC: "Peter T. Breuer" <ptb@it.uc3m.es>,
        "Patrick J. LoPresti" <patl@cag.lcs.mit.edu>,
        linux-kernel@vger.kernel.org
X-Anonymously-To: 
Reply-To: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL89 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"A month of sundays ago Linus Torvalds wrote:"
> 
> On Fri, 31 Aug 2001, Peter T. Breuer wrote:
> >
> > To give you all something definite to look at, here's some test code:
> 
> Hmm.. This might be a good idea, actually. Have you tried whether it finds
> something in the existing tree (you could just take the existing macro and
> ignore the first argument)?

I only have source for 2.4.8 plus xfs 1.0 patches here. 

I removed MIN/min/MAX/max definitions from about a dozen header files
in include/linux, and added an #include <linux/minmax.h> to them. That
file goes below. The test are fairly alarmist.

On doing a make bzImage no errors showed. On make modules, 4 errors
showed, one in tun.c and 3 in pagebuf_io.c (I presume that's from
xfs).

I probably covered about 25% of the kernel code in that trial.

The tun.c one was safe as it was .. the signed value was always
positive at the point where the macro was applied. I'm not
at all sure about the pagebuf_io.c ones because there was deep iovec
and iobuf and skb magic about,  but that's not of interest
to you. I made the comparisons signed and added an if (value out of
signed range) BUG(); just above.

The macros below seem to show up the line number perfectly in the
compiletime error. I guess one can add a __FILE__ to them someway.

One thing that worries me is that these should have triggered on
the signed/unsigned char comparisons that you were worried about in
-Wsigned-compare, and no, they didn't. They did find other
signed/unsigned mixes, but not char.

Peter



#ifndef MINMAX_H
#define MINMAX_H 1


#define __MINMAX_S(x) #x
#define MINMAX_S(x) __MINMAX_S(x)
#define MINMAX_BUG asm(".unsafe_min_or_max_at_line_" MINMAX_S(__LINE__))

#define __MIN(x,y) ({\
   typeof(x) _x = x; \
   typeof(y) _y = y; \
   _x < _y ? _x : _y ; \
 })
#define MIN(x,y) ({\
   const typeof(x) _x = ~(typeof(x))0; \
   const typeof(y) _y = ~(typeof(y))0; \
   if (sizeof(_x) != sizeof(_y)) \
     MINMAX_BUG; \
   if ((_x > (typeof(x))0 && _y < (typeof(y))0) \
   ||  (_x < (typeof(x))0 && _y > (typeof(y))0)) \
     MINMAX_BUG; \
   __MIN(x,y); \
 })
#define __MAX(x,y) ({\
   typeof(x) _x = x; \
   typeof(y) _y = y; \
   _x > _y ? _x : _y ; \
 })
#define MAX(x,y) ({\
   const typeof(x) _x = ~(typeof(x))0; \
   const typeof(y) _y = ~(typeof(y))0; \
   if (sizeof(_x) != sizeof(_y)) \
     MINMAX_BUG; \
   if ((_x > (typeof(x))0 && _y < (typeof(y))0) \
   ||  (_x < (typeof(x))0 && _y > (typeof(y))0)) \
     MINMAX_BUG; \
   __MAX(x,y); \
 })


#ifndef min
#define min(x,y) MIN(x,y)
#endif
#ifndef max
#define max(x,y) MAX(x,y)
#endif


#endif
