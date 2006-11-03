Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753260AbWKCOxY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753260AbWKCOxY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 09:53:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753261AbWKCOxY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 09:53:24 -0500
Received: from wohnheim.fh-wedel.de ([213.39.233.138]:41663 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S1753260AbWKCOxX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 09:53:23 -0500
Date: Fri, 3 Nov 2006 15:53:29 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: New filesystem for Linux
Message-ID: <20061103145329.GE11947@wohnheim.fh-wedel.de>
References: <Pine.LNX.4.64.0611022221330.4104@artax.karlin.mff.cuni.cz> <20061102235920.GA886@wohnheim.fh-wedel.de> <Pine.LNX.4.64.0611030217570.7781@artax.karlin.mff.cuni.cz> <20061103101901.GA11947@wohnheim.fh-wedel.de> <Pine.LNX.4.64.0611031252430.17174@artax.karlin.mff.cuni.cz> <20061103122126.GC11947@wohnheim.fh-wedel.de> <Pine.LNX.4.64.0611031428010.17427@artax.karlin.mff.cuni.cz> <20061103134802.GD11947@wohnheim.fh-wedel.de> <Pine.LNX.4.64.0611031509500.27698@artax.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.64.0611031509500.27698@artax.karlin.mff.cuni.cz>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 November 2006 15:19:09 +0100, Mikulas Patocka wrote:
> 
> >>Really it can batch any number of modifications into one transaction
> >>(unless fsync or sync is called). Transaction is closed only on
> >>fsync/sync, if 2 minutes pass (can be adjusted) or when the disk runs out
> >>of space.
> >
> >Interesting.  Let me pick an example and see where we're going from
> >there.  You have four directories, A, B, C and D, none of which is the
> >parent of another.  Two cross-directory renames happen:
> >$ mv A/foo B/
> >$ mv C/bar D/
> >
> >This will cause four modifications, one to each of the directories.  I
> >would have assumed that the modifications to A and B receive one
> >transaction number n, C and D get a different one, n+1 if nothing else
> >is going on in between.
> 
> They most likely receive the same transaction (this is not like journaling 
> transaction --- new transactions are issued only on conditions above).

That means one transaction in your terminology contains many
transactions in my terminology, which explains a bit of confusion.

> They may be written in any order (that's some improvement over 
> journaling) by buffer thread.
>
> And when you sync, with one write of memory_cct to disk, you make old 
> entries permanently invalid and new entries permanently valid.

Ok, I seem to understand it now.  Quite interesting.

> If the machine crashes before sync (and some of directory sectors were 
> written and some not), new entries will always be considered invalid, and 
> old entries always valid, because new crash count will be used and crash 
> count table at old crash count index will never be modified.

So the only overflow you have to fear is the 16-bit cc overflow.  Once
that hits your filesystem is end-of-life and cannot be written to
anymore.

Has it ever occurred to you how similar your approach is to the
venerable sprite lfs?  Lfs syncs by writing a "checkpoint", which
contains quite a bit of information.  You sync by just writing a
single number.  But in the end, both designs have a lot of
non-committed data already written to disk which only becomes valid
once the final (checkpoint|transaction count) is written.

And considering that writing several kB of contiguous data to disk is
nearly free, compared to the initial seek, both commit operations
should take about the same time.

So which, if I may ask, are the advantages of your design over sprite
lfs?

http://citeseer.ist.psu.edu/rosenblum91design.html

Jörn

-- 
ticks = jiffies;
while (ticks == jiffies);
ticks = jiffies;
-- /usr/src/linux/init/main.c
