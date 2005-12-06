Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964996AbVLFSPW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964996AbVLFSPW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 13:15:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965001AbVLFSPW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 13:15:22 -0500
Received: from straum.hexapodia.org ([64.81.70.185]:18448 "EHLO
	straum.hexapodia.org") by vger.kernel.org with ESMTP
	id S964996AbVLFSPV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 13:15:21 -0500
Date: Tue, 6 Dec 2005 10:15:20 -0800
From: Andy Isaacson <adi@hexapodia.org>
To: Pavel Machek <pavel@suse.cz>
Cc: Nigel Cunningham <ncunningham@cyclades.com>,
       "Rafael J. Wysocki" <rjw@sisk.pl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: swsusp performance problems in 2.6.15-rc3-mm1
Message-ID: <20051206181520.GA21501@hexapodia.org>
References: <20051205081935.GI22168@hexapodia.org> <20051205121728.GF5509@elf.ucw.cz> <1133791084.3872.53.camel@laptop.cunninghams> <200512052328.01999.rjw@sisk.pl> <1133832773.6360.38.camel@localhost> <20051206020626.GO22168@hexapodia.org> <20051206121835.GN1770@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051206121835.GN1770@elf.ucw.cz>
User-Agent: Mutt/1.4.2i
X-PGP-Fingerprint: 48 01 21 E2 D4 E4 68 D1  B8 DF 39 B2 AF A3 16 B9
X-PGP-Key-URL: http://web.hexapodia.org/~adi/pgp.txt
X-Domestic-Surveillance: money launder bomb tax evasion
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 06, 2005 at 01:18:35PM +0100, Pavel Machek wrote:
> > I'm assuming that the difference is that with Rafael's patches, clean
> > pages that would have been evicted in the "freeing pages..." step are
> > now being written out to the swsusp image.  If so, this is a waste - no
> > point in having the data on disk twice.  (It would be nice to confirm
> > this suspicion.)
> 
> Confirmed. But you are wrong; it is not a waste. The pages are nicely
> linear in suspend image, while they would be all over the disk
> otherwise. There can easily be factor 20 difference between linear
> read and random read.

Agreed, linear reads are obviously an enormous improvement over seeking
all over the disk.  (Especially given my 15 ms seek latency.)  It would
suck to have to do all those seeks synchronously (before allowing the
swsusp resume to complete).  But see below for my suggested alternative.

> > Could we rework it to avoid writing clean pages out to the swsusp image,
> > but keep a list of those pages and read them back in *after* having
> > resumed?  Maybe do the /dev/initrd ('less +/once Documentation/initrd.txt'
> > if you're not familiar with it) trick to make the list of pages available 
> > to a userland helper.
> 
> I did not understand this one.

I'm suggesting that rather than writing the clean pages out to the
image, simply make their metadata available to a post-resume userland
helper.  Something like

% head -2 /dev/swsusp-helper
/bin/sh 105-115 192 199-259
/lib/libc-2.3.2.so 1-250

where the userland program is expected to use the list of page numbers
(and getpagesize(2)) to asynchronously page in the working set in an
ionice'd manner.

This doesn't get rid of the seeks, of course, but doing them post-resume
will improve interactive performance while avoiding the cost of gigantic
swsusp images.

> Anyway, try limiting size of image to ~500MB, first. Should solve your
> problem with very little work.

This is obviously the right thing for my situation, and it's on my list.

-andy
