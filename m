Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751042AbWJRLaB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751042AbWJRLaB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 07:30:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750759AbWJRLaB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 07:30:01 -0400
Received: from unthought.net ([212.97.129.88]:52749 "EHLO unthought.net")
	by vger.kernel.org with ESMTP id S1751470AbWJRLaA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 07:30:00 -0400
Date: Wed, 18 Oct 2006 13:30:01 +0200
From: Jakob Oestergaard <jakob@unthought.net>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Jens Axboe <jens.axboe@oracle.com>,
       "Phetteplace, Thad (GE Healthcare, consultant)" 
	<Thad.Phetteplace@ge.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Bandwidth Allocations under CFQ I/O Scheduler
Message-ID: <20061018113001.GV23492@unthought.net>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	Arjan van de Ven <arjan@infradead.org>,
	Jens Axboe <jens.axboe@oracle.com>,
	"Phetteplace, Thad (GE Healthcare, consultant)" <Thad.Phetteplace@ge.com>,
	linux-kernel@vger.kernel.org
References: <CAEAF2308EEED149B26C2C164DFB20F4E7EAFE@ALPMLVEM06.e2k.ad.ge.com> <1161048269.3245.26.camel@laptopd505.fenrus.org> <20061017132312.GD7854@kernel.dk> <20061018080030.GU23492@unthought.net> <1161164456.3128.81.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1161164456.3128.81.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2006 at 11:40:56AM +0200, Arjan van de Ven wrote:
...
> Hi,
> 
> I can see that that makes it simple, but.. what would it MEAN? Eg what
> would a system administrator use it for?

For example, I could allocate "at least 100 iops/sec" for my database.
The VMWare can take whatever is left.

I have no idea how much bandwidth my database needs... But I have a
rough idea about how many I/O operations it does for a given operation.
And if I don't, strace can tell me pretty quick :)

> It then no longer means "my mp3
> player is guaranteed to get the streaming mp3 from the disk at this
> bitrate" or something like that...

In a sense you are right.

You cannot be certain that the mp3 player will get a specific bandwidth.
The mp3 player will be accessing the underlying storage through a
filesystem, which again means that accessing a file sequentially *will*
cause non-sequential I/O on the underlying device(s).

If you wanted to guarantee any specific bandwidth, you would somehow
assume that you had an infinite (or at least very very high) number of
seeks at your disposal. Or that seeks were free... In any other
scenario, the total "capacity" of your underlying storage, the maximum
amount of bandwidth (including non-free seeks) available, would vary
depending on how it is currently used (how many seeks are issued) by all
the clients.

So, what I'm arguing is; you will not want to specify a fixed sequential
bandwidth for your mp3 player.

What you want to do is this: Allocate 5 iops/sec for your mp3 player
because either a quick calculation - or - experience has shown that this
is enough for it to keep its buffer from depleting at all times.

Describing iops/sec for your mp3 player is at least as simple as
sequential bitrate. The difference is, that you can implement iops/sec
allocation whereas you cannot implement bitrate allocation (in a
meaningful way at least)   :)

> so my question to you is: can you
> describe what it'd bring the admin to put such an allocation in place?

Limiting on iops/sec rather than bandwidth, is simply accepting that
bandwidth does not make sense (because you cannot know how much of it
you have and therefore you cannot slice up your total capacity), and,
realizing that bandwidth in the scenarios where limiting is interesting
is in reality bound by seeks rather than sequential on-disk throughput.

> If we find that it can be a good approach.. but if not, I'm less certain
> this'll be used..

I can only see a problem with specifying iops/sec in the one scenario
where you have multiple sequential readers or writers, and you want to
distribute bandwidth between them.

However, in that scenario, where you have multiple clients, *seeks* will
again be your limiting factor.

Specifying iops/sec might be difficult for the admin. But I really can't
see how you would implement bandwidth limiting in a meaningful way - and
if you can't do that, then specifying bandwidth limiting in terms of a
bandwidth limiting process that doesn't work properly will be even
harder :)

The only situation in which seeks is not either the limiting factor, or
at least a very very large contributor to I/O wait, is in the situation
where you have only one client.  And, if you have only one client, what
is it you need sharing of resources for again?

In all other scenarios, I believe iops/sec is by far a superios way of
describing the ressource allocation. For two reasons:
1)  It describes what the hardware provides
2)  By describing a concept based on the real world it may actually be
    possible to implement so that it works as intended


I hope some of the above makes sense. I'll try to explain what I mean to
the best of my ability  :)

-- 

 / jakob

