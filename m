Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261717AbUBYWFy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 17:05:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261645AbUBYWDm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 17:03:42 -0500
Received: from 104.engsoc.carleton.ca ([134.117.69.104]:1941 "EHLO
	quickman.certainkey.com") by vger.kernel.org with ESMTP
	id S261639AbUBYWCr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 17:02:47 -0500
Date: Wed, 25 Feb 2004 16:52:39 -0500
From: Jean-Luc Cooke <jlcooke@certainkey.com>
To: Christophe Saout <christophe@saout.de>
Cc: Andrew Morton <akpm@osdl.org>, jmorris@intercode.com.au,
       linux-kernel@vger.kernel.org
Subject: Re: cryptoapi highmem bug
Message-ID: <20040225215239.GB7731@certainkey.com>
References: <20040225043209.GA1179@certainkey.com> <20040224220030.13160197.akpm@osdl.org> <20040225153126.GA7395@leto.cs.pocnet.net> <20040225155121.GA7148@leto.cs.pocnet.net> <20040225154453.GB4218@certainkey.com> <20040225181540.GB8983@leto.cs.pocnet.net> <20040225201216.GA6799@certainkey.com> <20040225203920.GA1816@leto.cs.pocnet.net> <20040225204651.GA7140@certainkey.com> <20040225213647.GB6587@leto.cs.pocnet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040225213647.GB6587@leto.cs.pocnet.net>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 25, 2004 at 10:36:48PM +0100, Christophe Saout wrote:
> On Wed, Feb 25, 2004 at 03:46:51PM -0500, Jean-Luc Cooke wrote:
> 
> > > >  Can we do this?
> > > 
> > > It's very non-trivial. Think about journalling filesystems, write
> > > ordering and atomicity. If the system crashes between two write
> > > operations we must be able to still correctly read the data. And
> > > write to these "crypto info blocks" should be done in a ways that
> > > doesn't kill performance. Do you have a proposal?
> > 
> > I see.  From a security point of view, no.  OMACs need to be updated after
> > the data is updated to keep integrity checks passing.
> 
> Yes. But if the machine doesn't get to update the OMAC but the data has
> already been written you must be able to still read the data somehow.

Agreed.  Some magic is needed here.

> > IVs need to be updated before the data is updated or plaintext is leaked.
> 
> Hmm? What could be done: The IV "sequence number" is incremented by one
> every time a sector gets written. The IV sequence numbers get written
> to the info block later (after a timeout, memory pressure and we to
> free some space in the cache or if the sequence has gone too far). When
> we read and the OMAC doesn't match we can try to increase the IV
> several times until it matches. Still the problem with the OMAC
> atomicity...

At mkfs, each block is given IV=HMAC(Key,blockNum).  Every time data is written
to the block, encrypt with IV'=IV+1 and store IV'.

Donno if I like the "if at first we don't succeed, try try again" approach.
But you know better then I do how difficult caching info blocks will be.

> > (IV + data + OMAC can be written to device at once).
> 
> You can't guarantee that anything gets written at once. You can only
> make sure that something has been written. Or that something gets
> written before something else (using barriers, but I don't know if that
> is stable, it has never been used on bio level yet).

Caching sounds like a good way out.  Always consult the cache struct with a
lock for each N-blocks in the FS to reduce bottleneck-ing and let the cache
update at a sensible interval.  ...or am I talking black (block?) magic of the
worst kind here?

How about we set a goal for ourselves saying "we're prepared to accept X
performance degradation for encrypted file systems"?

> > I assume then that IVs and OMACs will not be stored in the same read-chunk as
> > the data then?  Bummer if this is the case.
> 
> Well, we can't store it in the same sector because all 512 bytes are
> already used data.
> 
> We could store less than 512 bytes in a sector but that would mean
> splitting up data on a sub-sector level. That means we have to read
> some sectors with untouched data (the first and the last), update
> the data and write several sectors. But then we can't even guarantee
> that sectors are atomicically written as seen by the filesystem.
> This is... yuck.

The "try try again" approach maybe our only way.  Yet, if someone reads data
from the FS and the IV wasn't written to disk yet (or ever in the case of a
crash) then incrementing will not solve anything.  Screwed again.

JLC - will think about this on the bus ride home.

-- 
http://www.certainkey.com
Suite 4560 CTTC
1125 Colonel By Dr.
Ottawa ON, K1S 5B6
