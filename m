Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277532AbRJ3S6m>; Tue, 30 Oct 2001 13:58:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277559AbRJ3S6d>; Tue, 30 Oct 2001 13:58:33 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:13866 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S277532AbRJ3S6Q>; Tue, 30 Oct 2001 13:58:16 -0500
Date: Tue, 30 Oct 2001 19:58:28 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Hugh Dickins <hugh@veritas.com>,
        Frank Dekervel <Frank.dekervel@student.kuleuven.ac.Be>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        linux-kernel@vger.kernel.org
Subject: Re: need help interpreting 'free' output.
Message-ID: <20011030195828.X1340@athlon.random>
In-Reply-To: <20011030191612.S1340@athlon.random> <Pine.LNX.4.33.0110301017240.12018-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <Pine.LNX.4.33.0110301017240.12018-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Tue, Oct 30, 2001 at 10:28:29AM -0800
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 30, 2001 at 10:28:29AM -0800, Linus Torvalds wrote:
> want to lock the page - because locking the page means that you can pause
> for a _long_ time waiting for the page to be written out when there is IO
> pending.

ok I see what you mean, I agree (going to merge those important bits
into my tree! :)

however those locking bits have nothing to do with exclusive_swap_page
and the ealry cow I believe. exclusive_swap_page is faster than
remove_exclusive_swap_page + only_swap_page as said in the earlier email
and don't forget you somehow need the page lock too for
remove_exclusive_swap_page.

The magic word here is "_trylock_" after your wait_on_page if the page
wasn't uptodate, it's not that avoiding the early-cow or your
remove_exclusive_swap_cache will change anything (they only slowdowns).

So in short we only need to replace the lock_page with a TryLockPage
(plus your wait_on_page if page is not uptodate to catch the major
faults) and here we go, faster than pre5.

In previous emails I was thinking at major faults, of course the whole
optimization here is for the _minor_ faults were we don't need to block
and where pre5aa1 blocks and where pre5 vanilla doesn't block! Very good
point.

Andrea
