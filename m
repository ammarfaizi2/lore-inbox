Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265124AbUFRMF4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265124AbUFRMF4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 08:05:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265125AbUFRMF4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 08:05:56 -0400
Received: from linuxhacker.ru ([217.76.32.60]:60650 "EHLO shrek.linuxhacker.ru")
	by vger.kernel.org with ESMTP id S265124AbUFRMFx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 08:05:53 -0400
Date: Fri, 18 Jun 2004 15:05:14 +0300
From: Oleg Drokin <green@linuxhacker.ru>
To: Paulo Marques <pmarques@grupopie.com>
Cc: Helge Hafting <helge.hafting@hist.no>, Petter Larsen <pla@morecom.no>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       ext3 <ext3-users@redhat.com>
Subject: Re: mode data=journal in ext3. Is it safe to use?
Message-ID: <20040618120513.GA2394@linuxhacker.ru>
References: <40FB8221D224C44393B0549DDB7A5CE83E31B1@tor.lokal.lan> <1087322976.1874.36.camel@pla.lokal.lan> <200406160734.i5G7YZwV002051@car.linuxhacker.ru> <1087460837.2765.31.camel@pla.lokal.lan> <20040617170939.GO2659@linuxhacker.ru> <40D2B8C3.8090908@hist.no> <20040618101520.GA2389@linuxhacker.ru> <1087558255.25904.14.camel@pmarqueslinux>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1087558255.25904.14.camel@pmarqueslinux>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Fri, Jun 18, 2004 at 12:30:55PM +0100, Paulo Marques wrote:
> > > Hard to _produce_, but consider:
> > > 1. Write data to an existing file
> > > 2. Sync metadata
> > > 3. data is forced out because of ordered mode, a powerout crash happens
> > >    in the middle of this. The file now has a block with a mix of new 
> > > and old,
> > Well, this is not much worse than having two blocks, one from old file
> > and one from new after a crash.
> Agree. If the application needs consistency it must do some journaling
> itself. At least, until the time when an application can say "start
> transaction" "commit transaction" to the file system itself.

Right, this is my point.

> > >    it may even be unreadable due to a bad sector checksum.
> > Well, in data journaled mode you may get unreadable journal, is this much
> > better? (Also original question was about CF flash media, so no bad sector
> > problems I presume).
> You got it wrong here. The sentence was "bad sector checksum", not "bad
> sector". If the sector was "half written", then the checksum would not
> match.

In any case bad sector checksum is hardware bug. Sector write is supposed to be
atomic, it either happens or not.

> If the journal is "half written" then it is just discarded (or at least
> it should be).

Well, if there is bad sector checksum inside journal block, ext3 won't be
all that happy about this for sure (and most of other journaling filesystems as
well, I am sure).

> > > With data journalling you either get the old data (because the crash 
> > > happened
> > > during a write to the journal) or new data (crash happened during data 
> > > write,
> > Well, while with data journaling mode your granularity is one block,
> > with data ordered it is one sector.
> Imagine that you request a 2Mb write to an ext3 filesystem with an 1Mb
> journal. There is *no way* the filesystem can do the write in an atomic
> operation. (there would be if the filesystem wrote the data to free
> blocks and updated the metadata through the journal)

True.
Even if you write 512K of data and have 1Mb journal, still there is no atomicity
guarantee.

> The point is, there is no concept of "atomic operation" at the file
> system level, so the application must do journaling itself if it wants
> to have some concept of "transactions".

Well, if you go with less than 1 block size updates (that do not cross block
boundaries), this can be done atomically. (with help of fsync and stuff).

> >From my experience with CF cards, there are some brands that do
> wear-leveling (I know that at least the TwinMOS ones do, and probably
> SanDisk too) and others that don't (Kingmax). 
> With a bad CF card and an ext3 filesystem you can get bad sectors in a
> couple of hours doing some intensive writing. 

Well, for flash memory there is jffs2, it does (data) journalling and supports
compression. And it can even work over conventional block devices via mtd block
emulation, I think. Basically jffs2 is one large fs-sized journal as I
understand it.

Bye,
    Oleg
