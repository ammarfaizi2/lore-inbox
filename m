Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285462AbRLNTTZ>; Fri, 14 Dec 2001 14:19:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285464AbRLNTTQ>; Fri, 14 Dec 2001 14:19:16 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:18256 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S285462AbRLNTTB>; Fri, 14 Dec 2001 14:19:01 -0500
Date: Fri, 14 Dec 2001 20:16:41 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@zip.com.au>
Cc: Chris Mason <mason@suse.com>, Johan Ekenberg <johan@ekenberg.se>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, jack@suse.cz,
        linux-kernel@vger.kernel.org
Subject: Re: Lockups with 2.4.14 and 2.4.16
Message-ID: <20011214201641.L2431@athlon.random>
In-Reply-To: <000a01c1829f$75daf7a0$050010ac@FUTURE> <000a01c1829f$75daf7a0$050010ac@FUTURE> <3825380000.1008348567@tiny> <3C1A3652.52B989E4@zip.com.au> <3845670000.1008352380@tiny>, <3845670000.1008352380@tiny>; <20011214193217.H2431@athlon.random> <3C1A4BB4.EA8C4B45@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <3C1A4BB4.EA8C4B45@zip.com.au>; from akpm@zip.com.au on Fri, Dec 14, 2001 at 10:57:56AM -0800
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 14, 2001 at 10:57:56AM -0800, Andrew Morton wrote:
> Andrea Arcangeli wrote:
> > 
> > On Fri, Dec 14, 2001 at 12:53:00PM -0500, Chris Mason wrote:
> > > I'll try this, and also add kinoded so we can avoid using keventd.  I'm wary
> > 
> > using keventd for that doesn't look too bad to me. Just like we do with
> > the dirty inode flushing. keventd doesn't do anything 99.9% of the time,
> > so it sounds a bit wasteful to add yet another daemon that will remain
> > idle 99% of the time too... :)
> 
> Well heck, let's use ksoftirqd then :)

:)

ksoftirqd can run quite heavily sometime (it's needed for an efficient
NAPI for example) and it's not a general purpose kernel thread, and
all its work never blocks.

> keventd is used for real-time things - deferred interrupt
> actions.  It should be SCHED_FIFO.

The true fact is that keventd is _not_ SCHED_FIFO in 2.[245] and in turn
it _cannot_ be used for real time things.

So if keventd is currently used for real-time things, those real-time
things are malfunctioning right now, no matter of the dirty inode/quota
flushing.

furthmore the only point of keventd compared to a tasklet is that
keventd queued-tasks can _sleep_, and so all the users of keventd should
be used to block (if they cannot block they should use a taslket instead
that has a chance to be faster, per-cpu cache locality etc...).

> Actually, kupdated almost does what's needed already.  I
> suspect a wakeup_kupdate() would suffice.

Probably yes, however it would be nice to be able to push inode buffers
to disk while the buffers are getting flushed. So queueing the work to
keventd (or adding a kinoded) still sounds better to me :).

Andrea
