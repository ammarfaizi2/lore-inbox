Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264427AbRFUBcg>; Wed, 20 Jun 2001 21:32:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264510AbRFUBcZ>; Wed, 20 Jun 2001 21:32:25 -0400
Received: from shell.ca.us.webchat.org ([216.152.64.152]:44000 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP
	id <S264427AbRFUBcN>; Wed, 20 Jun 2001 21:32:13 -0400
From: "David Schwartz" <davids@webmaster.com>
To: "Davide Libenzi" <davidel@xmailserver.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Why use threads ( was: Alan Cox quote?)
Date: Wed, 20 Jun 2001 18:32:10 -0700
Message-ID: <NCBBLIEPOCNJOAEKBEAKMEOLPPAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2462.0000
In-Reply-To: <XFMail.20010620175613.davidel@xmailserver.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > Who said anything about 'select'? If you want to learn
> > how to write
> > efficient multi-threaded servers, take a course or read a book.
> > Heck, you
> > can even ask me questions on marginally appropriate lists or
> > even by private
> > email. But don't put words in my mouth.

> I was just thinking about having a course on how to write mt applications,
> are You currently keeping such courses ?

	I've been preparing one for several years, but due to the constantly
changing state of the art and the other limitations on my time, it just
keeps getting further behind.

> Is still this Your address :
>
> David Schwartz
> 16000 NW Modesty Dr

	That was never my address, though I lived at 16000 NW 1st street a long
time ago.

> How do you handle an average of 1600 sessions over a single
> process without
> using select()/poll(), I'm just curious ?

	Well, with 1,600 connections, things are pretty easy. This is so far below
the limit of modern machines that efficiency only matters if your server is
just one of many things the machine does. I would just use two threads in
poll loops, each working on half the descriptors. Some would have these
threads actually do the I/O, others would have it queue I/O jobs to another
pool of I/O threads that do the actual read/write operations.

	My (WebMaster's) library does even better than this, converting the 'poll'
threads into 'do the I/O' threads dynamically. That way if the 'poll' only
hits on one file descriptor, you don't have to do a context switch to
service the I/O, but you also can get back to 'poll' pretty quickly even if
the I/O manages to block when it's not supposed to.

	But 1,600 is easy, so there's no reason to sweat about it.

	Things get more difficult at 16,000 connections. At this level, I recommend
a tiered approach. Separate the file descriptors into the 80% that are 20%
of the activity and find the 10% that are 90% of the activity. Have separate
threads poll on each of these groups. The advantage of this is that the more
expensive poll calls (the ones on the greatest number of file descriptors)
are called very rarely (because those file descriptors aren't very active.
Tracking code can move file descriptors dynamically from group to group.

	No matter what anyone tells you, 'poll' scales *better* than O(n) (in other
words, the more connections you have, the less CPU time you need per
connection to discover which sockets need work), and since your I/O can't
possibly scale better than O(n), poll is as scalable as it needs to be. If
you double the number of sockets, you double the cost of 'poll' but you also
double the amount of information you get per poll call (actually, you more
than double it, but that's a long story).

	The problem with 'poll' is efficiency at *low* load. Since I write mostly
servers designed to operate at high load, I don't worry too much about
efficiency at low load. The hard case for 'poll' is large numbers of file
descriptors at very low load (so you're unlikely to find more than one
'active' fd at a time). Fortunately these cases don't need much efficiency.
The operating systems max out at around 65,536 descriptors anyway, and
keeping these inactive enough to allow such low discovery rates means a
server with most of its CPU to spare.

	Not that I have anything against the more efficient I/O discovery
techniques under discussion and development. There's nothing wrong with a
more efficient approach, especially one that's more efficient at every
combination of loads and socket counts. But as far as ultimate scalability
goes, socket discovery is not the limiting factor -- far from it.

	DS

