Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312381AbSFAGPy>; Sat, 1 Jun 2002 02:15:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314680AbSFAGPy>; Sat, 1 Jun 2002 02:15:54 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:38298 "EHLO
	svldns02.veritas.com") by vger.kernel.org with ESMTP
	id <S312381AbSFAGPx>; Sat, 1 Jun 2002 02:15:53 -0400
Date: Sat, 1 Jun 2002 07:17:59 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Andrea Arcangeli <andrea@suse.de>, Andrew Morton <akpm@zip.com.au>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch 5/18] mark swapout pages PageWriteback()
In-Reply-To: <Pine.LNX.4.33.0205311559330.13043-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.21.0206010649080.1316-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 31 May 2002, Linus Torvalds wrote:
> On Fri, 31 May 2002, Andrea Arcangeli wrote:
> > 
> > In short the same way MAP_ANON must pageout correctly, also MAP_SHARED
> > must swapout correctly with very vm intensive conditions.

I strongly agree with Andrea on that.  Swap fault without page lock
was a step forward, reinstating it in the light of observed degradation
in one workload was right decision for that particular tail of release,
but it's a shame to have stayed that way.

> That is true, but it is ignoring the fact that there _are_ real technical 
> differences between swap cache mappings and regular shared mappings.
> 
> One major difference is the approach to the last user: a last use of a 
> shared mapping still needs to write out dirty state, while the last use of 
> a swap page is better off noticing that it should just optimize away the 
> write, and we can just turn the page back into a dirty anonymous page.

Poor example: isn't last use of swap page just like last use of
shared mapping of an _unlinked_ file?

Offhand, I think most of the differences between swap and filesystem
just come from our wish not to waste any time on that filesystem:
we _expect_ the object will be unlinked before it needs to hit disk.
Plus, it's important that going to disk doesn't need more memory.

Perhaps those are just attributes of a particular filesystem.
Just as anon pages graduated to being put on LRU a few months ago,
maybe they could graduate to being hashed pages of tmpfs objects?
Probably yes, but without wasting time and memory - more doubtful.

Hugh

