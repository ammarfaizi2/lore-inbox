Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318022AbSHCXwp>; Sat, 3 Aug 2002 19:52:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318027AbSHCXwo>; Sat, 3 Aug 2002 19:52:44 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:4559 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id <S318022AbSHCXwo>;
	Sat, 3 Aug 2002 19:52:44 -0400
To: Daniel Phillips <phillips@arcor.de>
cc: Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org
Reply-To: Gerrit Huizenga <gh@us.ibm.com>
From: Gerrit Huizenga <gh@us.ibm.com>
Subject: Re: [PATCH] Rmap speedup 
In-reply-to: Your message of Sun, 04 Aug 2002 00:49:27 +0200.
             <E17b7iB-0003Lu-00@starship> 
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <21013.1028418922.1@us.ibm.com>
Date: Sat, 03 Aug 2002 16:55:22 -0700
Message-Id: <E17b8jy-0005Sz-00@w-gerrit2>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Seperate cache lines yes, but don't you also need to be somewhat
aware of the algorithm used for 2-way or 4-way set associative cacheing?
I forget the details, but it seems like P-II or P-III used an algorithm
that dropped the last several bits when deciding which bucket in the
set it would put a value in.  So when we had items at some multiple
of, I think 64 (could be 64 bytes, 64 kbytes) that only one entry
in the set associated cache would be used for lots and lots of memory
references.  My brain is really fuzzy on this right now, but if anyone
knows that the, for instance, P-II or P-III algorithm is for doing
replacement in a 2-way or 4-way set associative cache is, that might
help point out where a micro-optimization isn't optimizing as expected...

And sorry for the vagueness of the description, I don't have my Intel
books at hand to dig this up.  But that might account for wide variations
of a single function on two different processor types of the same
family.

gerrit

In message <E17b7iB-0003Lu-00@starship>, > : Daniel Phillips writes:
> On Saturday 03 August 2002 23:40, Andrew Morton wrote:
> > - total amount of CPU time lost spinning on locks is 1%, mainly
> >   in page_add_rmap and zap_pte_range.
> > 
> > That's not much spintime.   The total system time with this test went
> > from 71 seconds (2.5.26) to 88 seconds (2.5.30). (4.5 seconds per CPU)
> > So all the time is presumably spent waiting on cachelines to come from
> > other CPUs, or from local L2.
> 
> Have we tried this one:
> 
>  static inline unsigned rmap_lockno(pgoff_t index)
>  {
> -       return (index >> 4) & (ARRAY_SIZE(rmap_locks) - 1);
> +       return (index >> 4) & (ARRAY_SIZE(rmap_locks) - 16);
>  }
> 
> (which puts all the rmap spinlocks in separate cache lines)
> 
> -- 
> Daniel
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 
