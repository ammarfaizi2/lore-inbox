Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270010AbRHEUqI>; Sun, 5 Aug 2001 16:46:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270012AbRHEUp7>; Sun, 5 Aug 2001 16:45:59 -0400
Received: from fenrus.demon.co.uk ([158.152.228.152]:18869 "EHLO
	amadeus.home.nl") by vger.kernel.org with ESMTP id <S270010AbRHEUpr>;
	Sun, 5 Aug 2001 16:45:47 -0400
Message-Id: <m15TUmQ-000PQbC@amadeus.home.nl>
Date: Sun, 5 Aug 2001 21:45:46 +0100 (BST)
From: arjan@fenrus.demon.nl
To: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: [RFC][DATA] re "ongoing vm suckage"
cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0108051315540.7988-100000@penguin.transmeta.com>
X-Newsgroups: fenrus.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.4.3-6.0.1 (i586))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.33.0108051315540.7988-100000@penguin.transmeta.com> you wrote:

> In general, I think we can get latency to acceptable values, and latency
> is the _hard_ thing. We seem to have become a lot better already, by just
> removing the artificial ll_rw_blk code.

Ok how about a scheme (in 2.5) where every request has a "priority" assigned
to it. The way I see this is:

* priority is a signed value
* negative priority means "no need to do IO yet" to allow for gathering
  and grouping more requests in the request queues. It would be possible
  to get most of the inactive-dirty list in this state, eg io scheduled but
  not yet running
* on merging requests, the highest priority obviously becomes the overall 
  priority of the request
* "interactive" requests get a higher priority; this can be helped by adding
  a ll_rw_block_sync function, as 99% if the ll_rw_block users ends up
  waiting for io anyway
* priority needs to be "aged up" in time to take care of latency and such

If a device is truely idle (eg no io for X jiffies), it could steal negative
requests from the queue to do preemtive writes in order to prevent the
current situation of 5 seconds of no IO, and then suddenly a problem and
long-latency IO.

Also, intelligent devices such as aacraid, where the hardware controller has
the notion of priority, can be used more effectively this way. Such hardware
raid controllers also like to have deep IO queues for non-priority requests
to keep all disks in the raid array busy...

Comments ?

Greetings,
   Arjan van de Ven
