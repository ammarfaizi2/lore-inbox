Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317807AbSGKJzZ>; Thu, 11 Jul 2002 05:55:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317811AbSGKJzW>; Thu, 11 Jul 2002 05:55:22 -0400
Received: from Morgoth.ESIWAY.NET ([193.194.16.157]:24074 "EHLO
	Morgoth.esiway.net") by vger.kernel.org with ESMTP
	id <S317807AbSGKJye>; Thu, 11 Jul 2002 05:54:34 -0400
Date: Thu, 11 Jul 2002 11:57:17 +0200 (CEST)
From: Marco Colombo <marco@esi.it>
To: William Lee Irwin III <wli@holomorphy.com>
cc: kernel-janitor-discuss 
	<kernel-janitor-discuss@lists.sourceforge.net>,
       <linux-kernel@vger.kernel.org>
Subject: Re: BKL removal
In-Reply-To: <20020710164645.GR25360@holomorphy.com>
Message-ID: <Pine.LNX.4.44.0207111128480.728-100000@Megathlon.ESI>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Jul 2002, William Lee Irwin III wrote:

> On Wed, Jul 10, 2002 at 12:03:08PM +0200, Marco Colombo wrote:
> >> Larry, there's something I've always wanted to ask you about your
> >> idea of the "locking cliff": when you're counting the number of locks,
> >> are you looking at the running image of an OS or at the source? 
> 
> On Wed, Jul 10, 2002 at 03:40:03PM +0100, Matthew Wilcox wrote:
> > Larry normally talks about the number of conceptual locks.  So in order
> > to manipulate a `struct file', it really doesn't matter whether you have
> > to grab the BKL, the files_struct lock or the filp->lock.  There's a big
> > difference if you have to grab the filp->pos_lock, the filp->ra_lock and
> > the filp->iobuf_lock.  You'd have to know what order to grab them in,
> > for a start.
> 
> This is called "lock depth" and is not related to the total number of
> locks declared in the source. AFAIK no one wants to increase lock depth.

Not directly of course. But with one BKL, depth is limited to one.
With one lock per subsystem, it's hardly more than one. But with 10000
locks spread into the source, it's quite unlikely you can do *anything*
without holding two locks at least. I think one of the point of Larry's
"locking cliff" idea is that when the lock depth grows beyond your
ability (or time) to really handle it, the only solution is to create
"your own" lock, just to play safe. But this way you increase both the
global number of locks *and* the lock depth of your code (by one at least).

I don't fully agree with Larry: I blame the lack of a clean locking model.
If you start from one BKL and push it "down", just increasing the number
of locks everytime you feel you need to, you get a mess. Locking should be
done globally at the same level: either at top (BKL), at the top of
each subsystem, or at "object" level.

But I realize I'm speaking out of imagination, Larry out of experience.
And it really makes a difference (to me, at least).

.TM.

