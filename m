Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281908AbRKUPdR>; Wed, 21 Nov 2001 10:33:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281907AbRKUPdI>; Wed, 21 Nov 2001 10:33:08 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:41317 "EHLO
	svldns02.veritas.com") by vger.kernel.org with ESMTP
	id <S281905AbRKUPc7>; Wed, 21 Nov 2001 10:32:59 -0500
Date: Wed, 21 Nov 2001 15:34:46 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
To: Rik van Riel <riel@conectiva.com.br>
cc: "Eric W. Biederman" <ebiederm@xmission.com>,
        "David S. Miller" <davem@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: 2.4.14 + Bug in swap_out.
In-Reply-To: <Pine.LNX.4.33L.0111211219420.1491-100000@duckman.distro.conectiva>
Message-ID: <Pine.LNX.4.21.0111211515210.1357-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Nov 2001, Rik van Riel wrote:
> On 21 Nov 2001, Eric W. Biederman wrote:
> 
> > We only hold a ref count for the duration of swap_out_mm.
> > Not for the duration of the value in swap_mm.

Exactly.

> In that case, why can't we just take the next mm from
> init_mm and just "roll over" our mm to the back of the
> list once we're done with it ?

No.  That's how it used to be, that's what I changed it from.

fork and exec are well ordered in how they add to the mmlist,
and that ordering (children after parent) suited swapoff nicely,
to minimize duplication of a swapent while it's being unused;
except swap_out randomized the order by cycling init_mm around it.

I agree that mmput would look nicer without the reference to swap_mm.
If you want to make a change here, I'd suggest replacing swap_mm
pointer by full dummy marker swap_mm, then mmput wouldn't need to
worry about it at all.

I didn't do it that way because I couldn't see where to initialize
the swap_mm structure without touching each architecture separately;
and I also wondered if there might be some stats gathering utility
out there which would get confused by finding a non-mm in the mmlist.

Hugh

