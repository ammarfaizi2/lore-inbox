Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268915AbRHGWCd>; Tue, 7 Aug 2001 18:02:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269473AbRHGWCW>; Tue, 7 Aug 2001 18:02:22 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:1298 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S269380AbRHGWCD>; Tue, 7 Aug 2001 18:02:03 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Ben LaHaise <bcrl@redhat.com>, Andrew Morton <akpm@zip.com.au>
Subject: Re: [RFC][DATA] re "ongoing vm suckage"
Date: Tue, 7 Aug 2001 23:33:21 +0200
X-Mailer: KMail [version 1.2]
Cc: "Linus Torvalds <torvalds@transmeta.com> Rik van Riel" <riel@conectiva.com.br>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
In-Reply-To: <Pine.LNX.4.33.0108071426380.30280-100000@touchme.toronto.redhat.com>
In-Reply-To: <Pine.LNX.4.33.0108071426380.30280-100000@touchme.toronto.redhat.com>
MIME-Version: 1.0
Message-Id: <0108072333210J.02365@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 07 August 2001 20:40, Ben LaHaise wrote:
> On Tue, 7 Aug 2001, Andrew Morton wrote:
> > Ben, are you using software RAID?
> >
> > The throughput problems which Mike Black has been seeing with
> > ext3 seem to be specific to an interaction with software RAID5
> > and possibly highmem.  I've never been able to reproduce them.
>
> Yes, but I'm using raid 0.  The ratio of highmem to normal memory is
> ~3.25:1, and it would seem that this is breaking write throttling
> somehow. The interaction between vm and io throttling is not at all
> predictable. Certainly, pulling highmem out of the equation results in
> writes proceeding at the speed of the disk, which makes me wonder if
> the bounce buffer allocation is triggering the vm code to attempt to
> free more memory.... Ah, and that would explain why shorter io queues
> makes things smoother: less memory pressure is occuring on the normal
> memory zone from bounce buffers.  The original state of things was
> allowing several hundred MB of ram to be allocated for bounce buffers,
> which lead to a continuous shortage, causing kswapd et al to spin in a
> loop making no progress.

I thought Marcelo and Linus fixed that in pre1.

But even with the inactive_plent/skip_page strategy there's a problem.  
Suppose 2 gig of memory is active, that's 2 million pages.  Suppose you 
touch it all once, now everything is active, age=2.  It takes 4 million 
scan steps to age that down to zero so we can start deactivating the 
kind of pages we want.  In the meantime the page cache user is stalled, 
the pages just aren't there.  After two times around the active list, 
inactive pages come flooding out, some time later they make it through 
the inactive queue, the user snaps them up and create another flood of 
activations.

Please, tell me this scenario can't happen.

> Hmmm, how to make kswapd/bdflush/kreclaimd all back off until progress
> is made in cleaning the io queue?

I'd suggest putting memory users on a wait queue instead of letting them 
transform themselves into vm scanners...

--
Daniel
