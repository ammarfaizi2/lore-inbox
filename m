Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264117AbTICRSR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 13:18:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264116AbTICRRD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 13:17:03 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:65034 "EHLO
	mtvmime03.VERITAS.COM") by vger.kernel.org with ESMTP
	id S264115AbTICRQw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 13:16:52 -0400
Date: Wed, 3 Sep 2003 18:18:28 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: "Nikita V. Youshchenko" <yoush@cs.msu.su>
cc: linux-kernel@vger.kernel.org
Subject: Re: Strange situation while writing CDR from iso file on tmpfs
In-Reply-To: <200309030120.54112@sercond.localdomain>
Message-ID: <Pine.LNX.4.44.0309031745110.2222-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Sep 2003, Nikita V. Youshchenko wrote:
> 
> First I grabbed the iso image to a file in /tmp, which is tmpfs on my 
> system.
> Then I tried to write it using cdrecord at speed 24, and got an i/o error 
> that looked like buffer underrun.
> I insered another disk and repeated write attempt. And got i/o error again 
> almost at the same byte offset (459716608 first time, 459399168 second 
> time).

That's curious, I don't have an explanation for why 438MB should be
repeatably significant on your 256MB system.  I'm pretty sure tmpfs
itself doesn't have any "438MB" coded into it!  Maybe it tended to
to horrible seeking around swap at that point; maybe shrink_cache
got stuck too much on wait_on_page; I'm only guessing.

> I was able to write the image only after I copied it from tmpfs to my home 
> directory on reiserfs (file was copied without any errors).
> ... 
> Computer on which it happened has only 256M of RAM, and iso file size was 
> about 700M. So large parts of the file in tmpfs actually resided in swap.

I'm sure you did the right thing, copying it to a grown-up filesystem.

tmpfs is fine while everything is in memory, and even when a little
overflowed to swap; but with so much on swap it's at the mercy of the
vagaries of the LRU lists, and swap allocation might work out far
from optimal for it.  tmpfs use of swap is not something we've ever
tried to optimize for.

Perhaps something exceptionally stupid and avoidable occurs, I'll keep
your mail as reminder to investigate some day.  But if most of your
file is going to be on disk, much better to keep it in a filesystem
which allocates disk blocks to files in a well-designed way, than to
rely on tmpfs use of swap.

> It seems that several times it took tmpfs unacceptably long to deliver 
> same part of the file to the reading process. Since it was the same part 
> of the file, I thought that these particular blocks (located on 
> particular blocks of the swap partition) could trigger some situation 
> when tmpfs misbehaves.

I'm assuming you ran it two or three times without rebooting or running
swapoff.  In which case, I doubt that the same parts of the file got the
same swap blocks each time (the association is not persistent), so I
don't think it would be a problem with your swap partition itself.

Sorry for tmpfs wasting your CDs: trust your reiserfs next time.

Hugh

