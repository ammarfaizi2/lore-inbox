Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286453AbRL0Se2>; Thu, 27 Dec 2001 13:34:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286433AbRL0SeT>; Thu, 27 Dec 2001 13:34:19 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:60934
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S286443AbRL0SeI>; Thu, 27 Dec 2001 13:34:08 -0500
Date: Thu, 27 Dec 2001 10:32:44 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: hdc: dma_intr: status=0x51 { DriveReady SeekComplete Error }
In-Reply-To: <a0fmq3$ujs$1@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.10.10112271014500.24491-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


There must be an ECHO, 'cause I know that I have been making this
statement for a while, your appointed "Storage Architect" still does not
get the point.  So maybe if you would like, I could finish teaching the
model that is started, or request that somebody with more vision than me
from who has been in the storage industry longer than me.

Regardless you have a mess that is not easily cleanable and really needs
to be restarted, and that is "My Professional Opinion" and that of others
who are laugh at the mess you allowed started without an means of defining
completion, stablity, nor integrity.

Lately I have found you slow on the up take, but at least somebody is
getting my message and notes to you, especially since you have blackholed
me.

Regards,

Andre Hedrick
CEO/President, LAD Storage Consulting Group
Linux ATA Development
Linux Disk Certification Project

On Thu, 27 Dec 2001, Linus Torvalds wrote:

> In article <20011227175105.E1730@suse.de>, Jens Axboe  <axboe@suse.de> wrote:
> >On Thu, Dec 27 2001, Alan Cox wrote:
> >> > retries belong at the low level, once you pass up info of failure to the
> >> > upper layers it's fatal. time for FS to shut down.
> >> 
> >> Thats definitely not the case. Just because your file system is too dumb to
> >> use the information please don't assume everyone elses isnt - in fact one
> >> of the side properties of Daniel Phillips stuff is that it should be able
> >> to sanely handle a bad block problem.
> >
> >That's ok too, the fs can do whatever it wants in case of I/O failure.
> >It's not up to the fs to reissue failed requests, _that's_ stupid.
> 
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
> 
> For reads, sufficient state information is already there ("uptodate" bit
> - just add a counter for retries), but for writes we only have the dirty
> bit that gets cleared when the request gets sent off.  So for writes
> we'd need to add a new bit ("write in progress", and then clear it on
> successful completion, and set the "dirty" bit again on error). 
> 
> So I'd actually _like_ for all IO requests to be clearly "try just
> once", and it being up to th eupper layers to retry on error. 
> 
> (The notion of timeouts are much harder - the upper layers can retry on
> errors, but I really don't think that the upper layers want to handle
> timeouts and the associated "cancel this request" issues.  So low layers
> would still have to do _that_ part of error recovery, but at least they
> wouldn't have to worry about keeping the request around until it is
> successful). 
> 
> Does anybody see any really fundamental problems with moving retrying to
> _above_ ll_rw_block.c instead of below it?
> 
> (And once it is above, you can much more easily support filesystems that
> can automatically remap blocks on IO failure etc, and even have
> interruptible block filesystem mounts for those pesky bad media problems
> - allowing user level to tell the kernel to not screw around too much
> with errors and just return them early to user space). 
> 
> 		Linus
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

