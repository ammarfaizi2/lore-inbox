Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263458AbTDSU1E (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Apr 2003 16:27:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263459AbTDSU1E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Apr 2003 16:27:04 -0400
Received: from mail.ithnet.com ([217.64.64.8]:47882 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id S263458AbTDSU1B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Apr 2003 16:27:01 -0400
Date: Sat, 19 Apr 2003 22:38:58 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: John Bradford <john@grabjohn.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Are linux-fs's drive-fault-tolerant by concept?
Message-Id: <20030419223858.6781064d.skraw@ithnet.com>
In-Reply-To: <200304192004.h3JK4Sgc000152@81-2-122-30.bradfords.org.uk>
References: <20030419185201.55cbaf43.skraw@ithnet.com>
	<200304192004.h3JK4Sgc000152@81-2-122-30.bradfords.org.uk>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 19 Apr 2003 21:04:28 +0100 (BST)
John Bradford <john@grabjohn.com> wrote:

> > > > I wonder whether it would be a good idea to give the linux-fs
> > > > (namely my preferred reiser and ext2 :-) some fault-tolerance.
> > > 
> > > Fault tollerance should be done at a lower level than the filesystem.
> > 
> > I know it _should_ to live in a nice and easy world. Unfortunately
> > real life is different. The simple question is: you have tons of
> > low-level drivers for all kinds of storage media, but you have
> > comparably few filesystems. To me this sound like the preferred
> > place for this type of behaviour can be fs, because all drivers
> > inherit the feature if it lives in fs.
> 
> The sort of feature you are describing would really belong in a
> separate layer, somewhat analogous to the MD driver, but for defect
> management.  You could create a virtual block device that has 90% of
> the capacity of the real block device, then allocte spare blocks from
> the real device if and when blocks failed.

Well, of all work-arounds for the problem this one is probably the worst: it
wastes space on good drives and runs out of space for sure on bad ones.
What is so bad about the simple way: the one who wants to write (e.g. fs) and
knows _where_ to write simply uses another newly allocated block and dumps the
old one on a blacklist. The blacklist only for being able to count them (or get
the sector-numbers) in case you are interested. If you weren't you might as
well mark them allocated and that's it (which I would presume a _bad_ idea). If
there are no free blocks left, well, then the medium is full. And that is just
about the only cause for a write error then (if the medium is writeable at
all).
Don't make the thing bigger than it really is...

> 
> > > The filesystem doesn't know or care what device it is stored on, and
> > > therefore shouldn't try to predict likely failiures.
> > 
> > It should not predict failures, it should possibly only say: "ok, driver
> > told me the block I just wanted to write has an error, so lets try a
> > different one and mark this block in my personal bad-block list as
> > unusable. This does not sound all-too complex. There is a free-block-list
> > anyway...
> 
> Modern disk devices typically already do this kind of defect management.

_should_ do, or do you know for sure?
Take real life: it is near midnight and your ide hd has just filled its last
available bad-block-mapping. The next write comes in and your fs goes boom. You
notice next morning and work is waiting for you. Can you mount it again? Is
your data being corrupted? Well, you need some luck ...
On the other hand, you could have been informed by mail that your ide-drives'
fs has just mapped another bad block and the total number of bad blocks just
reached 4 percent of the available space on the drive.
Why do you trust hd manufacturing sites in Malaysia or Hungary or whereever,
when you can make _sure_ yourself?
I don't get it, sorry.


> > > [1] Although it is uncommon to use a tape as a block device, you never
> > > know.  It's certainly possible, (not necessarily with Linux).
> > 
> > From the fs point of view it makes no difference living on disk or tape or
> > a tesa-strip.
> 
> It does if you are trying to avoid likely failiures, which is what I
> was originally thinking about.

Well, this is for sure nothing for a fs, you are right. But lets fix the _easy_
things first ...


-- 
Regards,
Stephan
