Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313194AbSC1RrQ>; Thu, 28 Mar 2002 12:47:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313195AbSC1RrH>; Thu, 28 Mar 2002 12:47:07 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:6158 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S313194AbSC1Rq6>;
	Thu, 28 Mar 2002 12:46:58 -0500
Message-ID: <3CA356AE.2E61F712@zip.com.au>
Date: Thu, 28 Mar 2002 09:45:18 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alexander Viro <viro@math.psu.edu>
CC: lkml <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [patch] ext2_fill_super breakage
In-Reply-To: <3CA2C68E.5B8C4176@zip.com.au> <Pine.GSO.4.21.0203280918190.24447-100000@weyl.math.psu.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro wrote:
> 
> On Wed, 27 Mar 2002, Andrew Morton wrote:
> 
> > In 2.5.7 there is a thinko in the allocation and initialisation
> > of the fs-private superblock for ext2.  It's passing the wrong type
> > to the sizeof operator (which of course gives the wrong size)
> > when allocating and clearing the memory.
> 
> > Lesson for the day: this is one of the reasons why this idiom:
> >
> >       some_type *p;
> >
> >       p = malloc(sizeof(*p));
> >       ...
> >       memset(p, 0, sizeof(*p));
> >
> > is preferable to
> >
> >       some_type *p;
> >
> >       p = malloc(sizeof(some_type));
> >       ...
> >       memset(p, 0, sizeof(some_type));
> 
> ... however, there is a lot of reasons why the former is preferable.

Yeah, a lot of newbies think that :)

> For one thing, the latter is hell on any search.

If the usage of the type is hard to search for then
then wrong identifier was chosen.

>  Moreover, I would
> argue that memset() on a structure is not a good idea - better do
> the explicit initialization.

memset will run at up to twice the speed (according to
Arjan).  Dunno if this includes I-cache misses - probably
not.

I'm not particularly fussed about this one, but I do prefer
the sleep-at-night safety of a blanket memset.  Because
(and I think this is something on which you and I somewhat
differ) code should be written for the convenience of others,
not the original author.  A nice memset will leave no doubt
in the reader's mind that all members of the structure have
been initialised.

BTW, Linus: while we're on the topic, I think we should do
this again:

--- linux-2.5.7/mm/slab.c	Sat Mar  9 00:18:43 2002
+++ 25/mm/slab.c	Thu Mar 28 09:42:41 2002
@@ -95,9 +95,9 @@
 #define	STATS		1
 #define	FORCED_DEBUG	1
 #else
-#define	DEBUG		0
-#define	STATS		0
-#define	FORCED_DEBUG	0
+#define	DEBUG		1	/* It's a development kernel */
+#define	STATS		1
+#define	FORCED_DEBUG	1
 #endif
 
 /*

-
