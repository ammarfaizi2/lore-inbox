Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310367AbSCPNyG>; Sat, 16 Mar 2002 08:54:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310370AbSCPNxq>; Sat, 16 Mar 2002 08:53:46 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:14096 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S310367AbSCPNxg>; Sat, 16 Mar 2002 08:53:36 -0500
Date: Sat, 16 Mar 2002 14:54:45 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Jari Ruusu <jari.ruusu@pp.inet.fi>
Cc: Jens Axboe <axboe@suse.de>, Marcelo Tosatti <marcelo@conectiva.com.br>,
        Herbert Valerio Riedel <hvr@hvrlab.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.19pre3aa2
Message-ID: <20020316145445.C15709@dualathlon.random>
In-Reply-To: <20020314032801.C1273@dualathlon.random> <3C912ACF.AF3EE6F0@pp.inet.fi> <20020315105621.GA22169@suse.de> <3C9230C6.4119CB4C@pp.inet.fi> <20020315185747.P10073@dualathlon.random> <3C933633.891663B0@pp.inet.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C933633.891663B0@pp.inet.fi>
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 16, 2002 at 02:10:27PM +0200, Jari Ruusu wrote:
> Andrea Arcangeli wrote:
> > Nevertheless as Jens said the infinite-loop-allocation in the
> > ->make_request_fn path are deadlock prone at the moment, not because
> > they sleeps but because they need a reserved mempool to guarantee
> > operations can go ahead slowly without deadlocks even if dynamic
> > allocation fails, but this is not a very pratical problem, it's very
> > unlikely to deadlock there (it's not worse than the other infinite loop
> > in getblk() that affects not just loop).
> 
> Unlikely to deadlock for normal filesystems, but swap on encrypted loop is a
> different case.

Not really much different, it's no different than other paths like
getblk (when you swap on top of the fs) and brw_page (OTOH we have a
little reserved shared pool for the async bh needed by brw_page but it's not
math accurate first of all because it's shared for the other pagecache
I/O too), it just increases a little the mem pressure when there's
a transfer function involved and the translation cannot be done in
place, but I obviously agree that such loop deadlock needs fixing
reagardless if it's easy to reproduce it or not :). Infact I think I
mentioned such deadlock in the past too.

> Deadlock free operation is exactly why my prealloc loop patch is needed.
> Beyond initial preallocating that is done at losetup time, it does not
> allocate anything from kernel memory pools, but effectively recycles its
> private per loop device preallocated memory. Encrypted swap needs that, and
> normal device backed loop file systems are also happy with deadlock free and
> VM stress free operation.

Yes, thanks.

Andrea
