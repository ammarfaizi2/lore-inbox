Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261607AbUBYVjj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 16:39:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261589AbUBYViB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 16:38:01 -0500
Received: from websrv.werbeagentur-aufwind.de ([213.239.197.241]:9941 "EHLO
	mail.werbeagentur-aufwind.de") by vger.kernel.org with ESMTP
	id S261608AbUBYVg4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 16:36:56 -0500
Date: Wed, 25 Feb 2004 22:36:48 +0100
From: Christophe Saout <christophe@saout.de>
To: Jean-Luc Cooke <jlcooke@certainkey.com>
Cc: Andrew Morton <akpm@osdl.org>, jmorris@intercode.com.au,
       linux-kernel@vger.kernel.org
Subject: Re: cryptoapi highmem bug
Message-ID: <20040225213647.GB6587@leto.cs.pocnet.net>
References: <1077663682.6493.1.camel@leto.cs.pocnet.net> <20040225043209.GA1179@certainkey.com> <20040224220030.13160197.akpm@osdl.org> <20040225153126.GA7395@leto.cs.pocnet.net> <20040225155121.GA7148@leto.cs.pocnet.net> <20040225154453.GB4218@certainkey.com> <20040225181540.GB8983@leto.cs.pocnet.net> <20040225201216.GA6799@certainkey.com> <20040225203920.GA1816@leto.cs.pocnet.net> <20040225204651.GA7140@certainkey.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040225204651.GA7140@certainkey.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 25, 2004 at 03:46:51PM -0500, Jean-Luc Cooke wrote:

> > >  Can we do this?
> > 
> > It's very non-trivial. Think about journalling filesystems, write
> > ordering and atomicity. If the system crashes between two write
> > operations we must be able to still correctly read the data. And
> > write to these "crypto info blocks" should be done in a ways that
> > doesn't kill performance. Do you have a proposal?
> 
> I see.  From a security point of view, no.  OMACs need to be updated after
> the data is updated to keep integrity checks passing.

Yes. But if the machine doesn't get to update the OMAC but the data has
already been written you must be able to still read the data somehow.

> IVs need to be updated before the data is updated or plaintext is leaked.

Hmm? What could be done: The IV "sequence number" is incremented by one
every time a sector gets written. The IV sequence numbers get written
to the info block later (after a timeout, memory pressure and we to
free some space in the cache or if the sequence has gone too far). When
we read and the OMAC doesn't match we can try to increase the IV
several times until it matches. Still the problem with the OMAC
atomicity...

> (IV + data + OMAC can be written to device at once).

You can't guarantee that anything gets written at once. You can only
make sure that something has been written. Or that something gets
written before something else (using barriers, but I don't know if that
is stable, it has never been used on bio level yet).

> I assume then that IVs and OMACs will not be stored in the same read-chunk as
> the data then?  Bummer if this is the case.

Well, we can't store it in the same sector because all 512 bytes are
already used data.

We could store less than 512 bytes in a sector but that would mean
splitting up data on a sub-sector level. That means we have to read
some sectors with untouched data (the first and the last), update
the data and write several sectors. But then we can't even guarantee
that sectors are atomicically written as seen by the filesystem.
This is... yuck.
