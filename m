Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318877AbSICRn4>; Tue, 3 Sep 2002 13:43:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318878AbSICRn4>; Tue, 3 Sep 2002 13:43:56 -0400
Received: from warden-b.diginsite.com ([208.29.163.249]:40955 "HELO
	wardenb.diginsite.com") by vger.kernel.org with SMTP
	id <S318877AbSICRnz>; Tue, 3 Sep 2002 13:43:55 -0400
From: David Lang <david.lang@digitalinsight.com>
To: "Peter T. Breuer" <ptb@it.uc3m.es>
Cc: linux kernel <linux-kernel@vger.kernel.org>
Date: Tue, 3 Sep 2002 10:40:53 -0700 (PDT)
Subject: Re: [RFC] mount flag "direct"
In-Reply-To: <200209031730.g83HUIb15556@oboe.it.uc3m.es>
Message-ID: <Pine.LNX.4.44.0209031025430.1889-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Sep 2002, Peter T. Breuer wrote:

> "A month of sundays ago David Lang wrote:"
> > Peter, the thing that you seem to be missing is that direct mode only
> > works for writes, it doesn't force a filesystem to go to the hardware for
> > reads.
>
> Yes it does. I've checked! Well, at least I've checked that writing
> then reading causes the reads to get to the device driver. I haven't
> checked what reading twice does.
>
> If it doesn't cause the data to be read twice, then it ought to, and
> I'll fix it (given half a clue as extra pay ..:-)

writing then reading the same file may cause it to be read from the disk,
but reading /foo/bar then reading /foo/bar again will not cause two reads
of all data.

some filesystems go to a lot fo work to orginize the metadata in
particular in memory to access things more efficiantly, you will have to
go into each filesystem and modify them to not do this.

in addition you will have lots of potential races as one system reads a
block of data, modifies it, then writes it while the other system does the
same thing. you cannot easily detect this in the low level drivers as
these are seperate calls from the filesystem, and even if you do what
error message will you send to the second system? there's no error that
says 'the disk has changed under you, backup and re-read it before you
modify it'

yes this is stuff that could be added to all filesystems, but will the
filesystem maintainsers let you do this major surgery to their systems?

for example the XFS and JFS teams are going to a lot of effort to maintain
their systems to be compatable with other OS's, they probably won't
appriciate all the extra conditionals that you will need to put in to
do all of this.

even for ext2 there are people (including linus I believe) that are saying
that major new features should not be added to ext2, but to a new
filesystem forked off of ext2 (ext3 for example or a fork of it).

David Lang

> > for many filesystems you cannot turn off their internal caching of data
> > (metadata for some, all data for others)
>
> Well, let's take things one at a time. Put in a VFS mechanism and then
> convert some FSs to use it.
>
> > so to implement what you are after you will have to modify the filesystem
> > to not cache anything, since you aren't going to do this for every
>
> Yes.
>
> > filesystem you end up only haivng this option on the one(s) that you
> > modify.
>
> I intend to make the generic mechanism attractive.
>
> > if you have a single (or even just a few) filesystems that have this
> > option you may as well include the locking/syncing software in them rather
> > then modifying the VFS layer.
>
> Why? Are you advocating a particular approach? Yes, I agree that that
> is a possible way to go - but I will want the extra VFS ops anyway,
> and will want to modify the particular fs to use them, no?
>
> Peter
>
