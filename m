Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263437AbTDSTte (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Apr 2003 15:49:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263441AbTDSTte
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Apr 2003 15:49:34 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:1664 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S263437AbTDSTtd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Apr 2003 15:49:33 -0400
From: John Bradford <john@grabjohn.com>
Message-Id: <200304192004.h3JK4Sgc000152@81-2-122-30.bradfords.org.uk>
Subject: Re: Are linux-fs's drive-fault-tolerant by concept?
To: skraw@ithnet.com (Stephan von Krawczynski)
Date: Sat, 19 Apr 2003 21:04:28 +0100 (BST)
Cc: john@grabjohn.com (John Bradford),
       linux-kernel@vger.kernel.org (linux-kernel)
In-Reply-To: <20030419185201.55cbaf43.skraw@ithnet.com> from "Stephan von Krawczynski" at Apr 19, 2003 06:52:01 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > I wonder whether it would be a good idea to give the linux-fs
> > > (namely my preferred reiser and ext2 :-) some fault-tolerance.
> > 
> > Fault tollerance should be done at a lower level than the filesystem.
> 
> I know it _should_ to live in a nice and easy world. Unfortunately
> real life is different. The simple question is: you have tons of
> low-level drivers for all kinds of storage media, but you have
> comparably few filesystems. To me this sound like the preferred
> place for this type of behaviour can be fs, because all drivers
> inherit the feature if it lives in fs.

The sort of feature you are describing would really belong in a
separate layer, somewhat analogous to the MD driver, but for defect
management.  You could create a virtual block device that has 90% of
the capacity of the real block device, then allocte spare blocks from
the real device if and when blocks failed.

> > Linux filesystems are used on many different devices, not just hard
> > disks.  Different devices can fail in different ways - a disk might
> > have a lot of bad sectors in a block, a tape[1] might have a single
> > track which becomes unreadble, and solid state devices might have get
> > a few random bits flipped all over them, if a charged particle passes
> > through them.
> > 
> > The filesystem doesn't know or care what device it is stored on, and
> > therefore shouldn't try to predict likely failiures.
> 
> It should not predict failures, it should possibly only say: "ok, driver told
> me the block I just wanted to write has an error, so lets try a different one
> and mark this block in my personal bad-block list as unusable. This does not
> sound all-too complex. There is a free-block-list anyway...

Modern disk devices typically already do this kind of defect management.

> > A RAID-0 array and regular backups are the best way to protect your
> > data.
> 
> RAID-1 obviously ;-)

Obviously :-).

> > [1] Although it is uncommon to use a tape as a block device, you never
> > know.  It's certainly possible, (not necessarily with Linux).
> 
> From the fs point of view it makes no difference living on disk or tape or a
> tesa-strip.

It does if you are trying to avoid likely failiures, which is what I
was originally thinking about.

Imagine a four-track tape.  It would be valid reasoning to store
important data such as the directory structure on the two inner
tracks, on the basis that the outer tracks were more susceptable to
edge damage.  If blocks are allocated on all tracks at the same time,
that might mean storing the directory on blocks 2,3,6,7,10,11, etc.
Such a layout wouldn't be very useful on a disk where blocks 1-8 were
written on one track, and 9-16 on the next, because the directory
would needlessly span two tracks.

John.
