Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286395AbRL0Rt3>; Thu, 27 Dec 2001 12:49:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286390AbRL0RtU>; Thu, 27 Dec 2001 12:49:20 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:39942 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S286415AbRL0RtF>; Thu, 27 Dec 2001 12:49:05 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: hdc: dma_intr: status=0x51 { DriveReady SeekComplete Error }
Date: Thu, 27 Dec 2001 17:46:43 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <a0fmq3$ujs$1@penguin.transmeta.com>
In-Reply-To: <20011227155403.A1730@suse.de> <E16JdbY-00061d-00@the-village.bc.nu> <20011227175105.E1730@suse.de>
X-Trace: palladium.transmeta.com 1009475328 8363 127.0.0.1 (27 Dec 2001 17:48:48 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 27 Dec 2001 17:48:48 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20011227175105.E1730@suse.de>, Jens Axboe  <axboe@suse.de> wrote:
>On Thu, Dec 27 2001, Alan Cox wrote:
>> > retries belong at the low level, once you pass up info of failure to the
>> > upper layers it's fatal. time for FS to shut down.
>> 
>> Thats definitely not the case. Just because your file system is too dumb to
>> use the information please don't assume everyone elses isnt - in fact one
>> of the side properties of Daniel Phillips stuff is that it should be able
>> to sanely handle a bad block problem.
>
>That's ok too, the fs can do whatever it wants in case of I/O failure.
>It's not up to the fs to reissue failed requests, _that's_ stupid.

Actually, I really think we should move the failure recovery up to the
filesystem: we can fairly easily do it already today, as basically very
few of the filesystems actually do the requests directly, but instead
rely on helper functions like "bread()" and "generic_file_read()". 

Moving error handling up has a lot of advantages:

 - it simplifies the (often fragile) lower layers, and moves common
   problems to common code instead of putting it at a low level and
   duplicating it across different drivers.

 - it allows "context-sensitive" handling of errors, ie if there is a
   read error on a read-ahead request the upper layers can comfortably
   just say "f*ck it, I don't need it yet", which can _seriously_ help
   interactive feel on bad mediums (right now we often try to re-read
   a failing sector tens of times, because we re-read it during
   read-ahead several times, and the lower layers re-read it _too_).

In fact, it would even be mostly _simple_ to do it at a higher level, at
least for reads.

Writes are somewhat harder, mainly because the upper layers have never
had to handle re-issuing of requests, and don't really have the state
information.

For reads, sufficient state information is already there ("uptodate" bit
- just add a counter for retries), but for writes we only have the dirty
bit that gets cleared when the request gets sent off.  So for writes
we'd need to add a new bit ("write in progress", and then clear it on
successful completion, and set the "dirty" bit again on error). 

So I'd actually _like_ for all IO requests to be clearly "try just
once", and it being up to th eupper layers to retry on error. 

(The notion of timeouts are much harder - the upper layers can retry on
errors, but I really don't think that the upper layers want to handle
timeouts and the associated "cancel this request" issues.  So low layers
would still have to do _that_ part of error recovery, but at least they
wouldn't have to worry about keeping the request around until it is
successful). 

Does anybody see any really fundamental problems with moving retrying to
_above_ ll_rw_block.c instead of below it?

(And once it is above, you can much more easily support filesystems that
can automatically remap blocks on IO failure etc, and even have
interruptible block filesystem mounts for those pesky bad media problems
- allowing user level to tell the kernel to not screw around too much
with errors and just return them early to user space). 

		Linus
