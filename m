Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264881AbRFTO1K>; Wed, 20 Jun 2001 10:27:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264883AbRFTO1A>; Wed, 20 Jun 2001 10:27:00 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:24581 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S264881AbRFTO0y>; Wed, 20 Jun 2001 10:26:54 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
Subject: Re: [RFC] Early flush (was: spindown)
Date: Wed, 20 Jun 2001 16:29:49 +0200
X-Mailer: KMail [version 1.2]
Cc: Mike Galbraith <mikeg@wen-online.de>, Rik van Riel <riel@conectiva.com.br>,
        Pavel Machek <pavel@suse.cz>, John Stoffel <stoffel@casc.com>,
        Roger Larsson <roger.larsson@norran.net>, <thunder7@xs4all.nl>,
        Linux-Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0106171156410.318-100000@mikeg.weiden.de> <01062003503300.00439@starship> <200106200439.f5K4d4501462@vindaloo.ras.ucalgary.ca>
In-Reply-To: <200106200439.f5K4d4501462@vindaloo.ras.ucalgary.ca>
MIME-Version: 1.0
Message-Id: <01062016294903.00439@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 20 June 2001 06:39, Richard Gooch wrote:
> Daniel Phillips writes:
> > I never realized how much I didn't like the good old 5 second delay
> > between saving an edit and actually getting it written to disk until
> > it went away.  Now the question is, did I lose any performance in
> > doing that.  What I wrote in the previous email turned out to be
> > pretty accurate, so I'll just quote it
>
> Starting I/O immediately if there is no load sounds nice. However,
> what about the other case, when the disc is already spun down (and
> hence there's no I/O load either)? I want the system to avoid doing
> writes while the disc is spun down. I'm quite happy for the system to
> accumulate dirtied pages/buffers, reclaiming clean pages as needed,
> until it absolutely has to start writing out (or I call sync(2)).

I'd like that too, but what about sync writes?  As things stand now, there is 
no option but to spin the disk back up.  To get around this we'd have to 
change the basic behavior of the block device and that's doable, but it's an 
entirely different proposition than the little patch above.

You know about this project no doubt:

   http://noflushd.sourceforge.net/

This is really complementary to what I did.  Lightweight is not really a good 
way to describe it though, the tar is almost 10,000 lines long.  There is 
probably a clever thing to do at the kernel level to shorten that up.

There's one thing I think I can help fix up while I'm working in here, this 
complaint: 

    Reiserfs journaling bypasses the kernel's delayed write mechanisms and    
    writes straight to disk.

We need to address the reasons why such filesystems have to bypass kupdate.  
This touches on how sync and fsync work, updating supers, flushing the inode 
cache etc, but with Al Viro's superblock work merged now we could start 
thinking about it.

> Right now I hack that by setting bdflush parameters to 5 minutes. But
> that's not ideal either.

Yes, that still works with my patch.  The noflushd user space daemon works by 
turning off kupdate (set update time to 0).

--
Daniel
