Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277039AbRJDAfa>; Wed, 3 Oct 2001 20:35:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277046AbRJDAfV>; Wed, 3 Oct 2001 20:35:21 -0400
Received: from sphinx.mythic-beasts.com ([195.82.107.246]:31247 "EHLO
	sphinx.mythic-beasts.com") by vger.kernel.org with ESMTP
	id <S277039AbRJDAfB>; Wed, 3 Oct 2001 20:35:01 -0400
Date: Thu, 4 Oct 2001 01:35:18 +0100 (BST)
From: <chris@scary.beasts.org>
X-X-Sender: <cevans@sphinx.mythic-beasts.com>
To: "Bond, Andrew" <Andrew.Bond@COMPAQ.com>
cc: <linux-kernel@vger.kernel.org>,
        "Nikolaiev, Mike" <Mike.Nikolaiev@COMPAQ.com>,
        "Jamshed Patel (E-mail)" <Jamshed.Patel@oracle.com>
Subject: Re: [PATCH] kiobuf_init optimization
In-Reply-To: <45B36A38D959B44CB032DA427A6E106410AA5A@cceexc18.americas.cpqcorp.net>
Message-ID: <Pine.LNX.4.33.0110040132260.29315-100000@sphinx.mythic-beasts.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Have a look at 2.4.10 - I believe this has a similar optimization?
Re-running your benchmark against plain 2.4.10 would be interesting.

Cheers
Chris

On Wed, 3 Oct 2001, Bond, Andrew wrote:

> 	I have come up with a change to the kiobuf_init() routine that
> drops the blind memset() to 0 of the entire kiobuf structure and zeros
> out 3 specific fields instead.  Since this is done on every IO and the
> kiobuf structure is over 8K in size (8756 bytes I believe) it becomes
> quite costly from a cpu cycle perspective as well as a cache utilization
> perspective.  The typical IO path uses a small subset of the
> preallocated fields within the kiobuf structure.  Therefore, the IO path
> pays a performance penalty for having to zero out many fields that it
> typically doesn't use.
>
> 	The kiobuf_init() routine using a memset() of the entire kiobuf
> structure is in the top 10 of cpu consuming kernel routines in Oracle 9i
> testing using raw io.  Using the included kiobuf_init patch, our testing
> has shown a 5% improvement in Oracle transactional performance in 4 and
> 8 processor configurations, and the kiobuf_init() routine became a
> non-issue for performance.  The testing was performed with Oracle, but
> this patch could provide performance improvements to any application
> that uses raw IO or relies on kiobufs in the IO path.
>
> 	Obviously, since the structure is no longer set to zero, any
> code that makes a zero assumption would break.  I haven't come across
> code that makes this assumption yet for fields that I did not
> specifically zero out in the patch, but I could very well be missing
> something.  It appears that Alan has included this patch in his
> 2.4.10-ac4 tree.  So, let me know if you have any problems that you
> think might be related to this patch.   Any input would be greatly
> appreciated.
>
> 	The patch is against a 2.4.9 tree, but it is localized to just
> the kiobuf_init() routine and should apply to any of the recent kernels.
>
> 	Run from the root level of your kernel tree:
> 		patch -p1 < kiobuf_init_speedup.patch
>
> 	I cannot currently receive the kernel mailing list at this email
> address, so please cc: me on posts related to this patch.
>
> Thanks,
> Andrew Bond
>
>  <<kiobuf_init_speedup.patch>>
>

