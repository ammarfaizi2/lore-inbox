Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314065AbSDVGu5>; Mon, 22 Apr 2002 02:50:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314072AbSDVGu4>; Mon, 22 Apr 2002 02:50:56 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:31105 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S314065AbSDVGuz>; Mon, 22 Apr 2002 02:50:55 -0400
Message-ID: <3CC3B2AA.80217EA0@in.ibm.com>
Date: Mon, 22 Apr 2002 12:20:18 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
Organization: IBM
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.16-22 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Stephen Lord <lord@sgi.com>, Andrew Morton <akpm@zip.com.au>,
        Mark Peloquin <peloquin@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: Bio pool & scsi scatter gather pool usage
In-Reply-To: <3CBFC755.50106@sgi.com> <E16yUE0-0006i7-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > But this gets you lowest common denominator sizes for the whole
> > volume, which is basically the buffer head approach, chop all I/O up
> > into a chunk size we know will always work. Any sort of nasty  boundary
> > condition at one spot in a volume means the whole thing is crippled
> > down to that level. It then becomes a black magic art to configure a
> > volume which is not restricted to a small request size.
> 
> Its still cheaper to merge bio chains than split them. 

Depends on how small each piece ends up having to be with the lowest
common denominator approach. (Shouldn't end up with too small pieces)

Its easy to miss/forget that merging chains redundantly does have a 
bit of extra cost on the completion path - extra callback invokations 
(bi_end_io)to collate results. 


> The VM issues with
> splitting them are not nice at all since you may need to split a bio to
> write out a page and it may be the last page

Yes, the mempool alloc aspects get quite confusing even when thinking
about
the normal bio path ... (e.g bounce bio's are probably already an aspect
of
concern since we have multiple allocations by the same thread drawing
into the 
same pool, a generic condition that has earlier been cited as a source
of potential deadlock) With splitting it gets worse. (BTW, for similar
reasons. drawing from 
the common pool may not be the best thing to do when splitting ..,
though 
multiple pools probably come with their source of problems)

But then, the situation of writeout of the last page again is not a
common
case. In this case it makes sense to revert to the lowest common
denominator
... , but must we do so in every case ?

Again, it really depends on how small the lowest common denominator
turns
out to be. If one can have the entire layout information abstracted in
a way to be able to compute it in advance for a given block so it
doesn't
limit one to be too conservative fine ... but I don't know if that's
always feasible.

As such, its good to avoid splitting in general relying on good hints,
but
perhaps have room for the stray case that crops up -- either handle the
split,
or maybe have a way pass back an error to retry with smaller size.
Maybe 2 limits (one that indicates that anything bigger than this is
sure to
get split, so always break it up, and another that says that anything
smaller
than this is sure not to be split, so use this size when you can't
afford a
split).

Regards
Suparna

> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
