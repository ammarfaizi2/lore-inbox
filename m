Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280307AbRKXV6C>; Sat, 24 Nov 2001 16:58:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280343AbRKXV5x>; Sat, 24 Nov 2001 16:57:53 -0500
Received: from ns0.ipal.net ([206.97.148.120]:20918 "HELO vega.ipal.net")
	by vger.kernel.org with SMTP id <S280307AbRKXV5k>;
	Sat, 24 Nov 2001 16:57:40 -0500
Date: Sat, 24 Nov 2001 15:57:39 -0600
From: Phil Howard <phil-linux-kernel@ipal.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Disk hardware caching, performance, and journalling
Message-ID: <20011124155739.A4372@vega.ipal.net>
In-Reply-To: <3BFFE8A2.1010708@rueb.com> <3BFFF021.D963B467@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3BFFF021.D963B467@zip.com.au>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 24, 2001 at 11:08:17AM -0800, Andrew Morton wrote:

| With writebehind the disk can write that entire track in pretty
| much a single spin.  But if we're waiting on the result of each
| request we'll lose revolutions.  In synchronous mode it's going
| to take three or four spins to write a track.
|  
| > So what are the implications here for journalling?  Do I have to turn
| > off caching and suffer a huge performance hit?
| 
| In theory, yes.  In my opinion, no.  For ext3, at least.  Caching
| isn't bad per-se.  It's reordering which can break the journalling
| constraints.  But given that the journal is, we hope, a strictly
| ascending and (we really hope) contiguous chunk of blocks, it's
| quite unlikely that the disk will decide to write them in an
| unexpected order.  This is especially true if the journal was
| created when the disk was relatively unfragmented.
| 
| And if the disk _does_ write them in the wrong order, it has
| to be specifically the journal commit block which was written
| prior to some data blocks.  And you need to lose power (not
| just crash) prior to the data blocks hitting disk.  It's a
| very small time window containing an improbable occurrence.
| 
| Now that's all just vigorous handwaving, and may be wrong,
| and yes, we really need a way of propagating barriers down
| to the request queue.  But I've not seen a whisker of a report
| which indicates that write reordering has caused on-recovery
| corruption.

What if (and maybe it is so, or maybe not) the write cache does
write-back (or write-behind) zones per track?  That is, when it
gets a write request either when the cache is not dirty, or is
in the same _physical_ track that everything that is in there
dirty goes into, it gets queued.  Then when some time passes,
or a request goes to a new track, it will write that track now
and move on.  IWSTM this gives you the advantage of "one spin"
writes for sequential data, and still keeps the order right for
journaled data.  Could they be doing this?

-- 
-----------------------------------------------------------------
| Phil Howard - KA9WGN |   Dallas   | http://linuxhomepage.com/ |
| phil-nospam@ipal.net | Texas, USA | http://phil.ipal.org/     |
-----------------------------------------------------------------
