Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280975AbRL0VQA>; Thu, 27 Dec 2001 16:16:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281805AbRL0VPv>; Thu, 27 Dec 2001 16:15:51 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:20118 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S280975AbRL0VPh>;
	Thu, 27 Dec 2001 16:15:37 -0500
Date: Thu, 27 Dec 2001 16:15:36 -0500
From: Legacy Fishtank <garzik@havoc.gtf.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: hdc: dma_intr: status=0x51 { DriveReady SeekComplete Error }
Message-ID: <20011227161536.B23942@havoc.gtf.org>
In-Reply-To: <20011227155403.A1730@suse.de> <E16JdbY-00061d-00@the-village.bc.nu> <20011227175105.E1730@suse.de> <a0fmq3$ujs$1@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <a0fmq3$ujs$1@penguin.transmeta.com>; from torvalds@transmeta.com on Thu, Dec 27, 2001 at 05:46:43PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 27, 2001 at 05:46:43PM +0000, Linus Torvalds wrote:
> Actually, I really think we should move the failure recovery up to the
> filesystem: we can fairly easily do it already today, as basically very
> few of the filesystems actually do the requests directly, but instead
> rely on helper functions like "bread()" and "generic_file_read()". 
> 
> Moving error handling up has a lot of advantages:
> 
>  - it simplifies the (often fragile) lower layers, and moves common
>    problems to common code instead of putting it at a low level and
>    duplicating it across different drivers.
> 
>  - it allows "context-sensitive" handling of errors, ie if there is a
>    read error on a read-ahead request the upper layers can comfortably
>    just say "f*ck it, I don't need it yet", which can _seriously_ help
>    interactive feel on bad mediums (right now we often try to re-read
>    a failing sector tens of times, because we re-read it during
>    read-ahead several times, and the lower layers re-read it _too_).
> 
> In fact, it would even be mostly _simple_ to do it at a higher level, at
> least for reads.
> 
> Writes are somewhat harder, mainly because the upper layers have never
> had to handle re-issuing of requests, and don't really have the state
> information.

Call me crazy but IMHO it is clear and logical and easy how to handle
write errors at the filesystem level.  I've been thinking about this
for the "ibu fs" I am hacking on...  have your own writepage and your
own async-io-completion routine.  If M of N bh's indicate write failure
when bh->b_end_io is called, queue those for the filesystem so it can
add those blocks to the bad block list, and allocate some new blocks for
writing.  Seems straightforward to me except worst-case where all
remaining sectors are bad.

A side effect of this is that I am taking a cue from "NTFS TNG"
[which is nice, 100% page-cache-based code] and simply making the
hard sector size be the logical block size.  That way, not only can
write errors be handled on a fine-grained (hard sector) level, there
are no limitations on what the filesystem's blocksize is.  Right now,
we cannot have a block size larger than PAGE-CACHE-SIZE AFAICS, but
when blocksize==hard sector size, you can simply fake any blocksize you
want (32K, 64K, ...)  You have a bit more overhead with an increased
number of bh's, but since the bh->b_data is pointing into a page,
that's all the overhead is... a buffer head.

Right now no filesystems really support big blocksize in this way
because fragment handling hasn't been thought through [again, AFAICS]


> For reads, sufficient state information is already there ("uptodate" bit
> - just add a counter for retries), but for writes we only have the dirty
> bit that gets cleared when the request gets sent off.  So for writes
> we'd need to add a new bit ("write in progress", and then clear it on
> successful completion, and set the "dirty" bit again on error). 

Handling read errors always seemed uglier than handling write errors,
but I haven't thought through read errors yet...


> So I'd actually _like_ for all IO requests to be clearly "try just
> once", and it being up to th eupper layers to retry on error. 

I agree this is a good direction.

	Jeff


