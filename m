Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130356AbRBQBfl>; Fri, 16 Feb 2001 20:35:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131473AbRBQBfb>; Fri, 16 Feb 2001 20:35:31 -0500
Received: from ferret.lmh.ox.ac.uk ([163.1.18.131]:19979 "HELO
	ferret.lmh.ox.ac.uk") by vger.kernel.org with SMTP
	id <S130356AbRBQBfS>; Fri, 16 Feb 2001 20:35:18 -0500
Date: Sat, 17 Feb 2001 01:35:15 +0000 (GMT)
From: Chris Evans <chris@scary.beasts.org>
To: <linux-kernel@vger.kernel.org>
cc: <kuznet@ms2.inr.ac.ru>, <davem@redhat.com>
Subject: SO_SNDTIMEO: 2.4 kernel bugs
Message-ID: <Pine.LNX.4.30.0102170126130.21158-100000@ferret.lmh.ox.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I was glad to see Linux gain SO_SNDTIMEO in kernel 2.4. It is a very use
feature which can avoid complexity and pain in userspace programs.

Unfortunately, it seems to be very buggy. Here are two buggy scenarios.

1)
Create a socketpair(), PF_UNIX, SOCK_STREAM.
Set a 5 second SO_SNDTIMEO on the socket.
write() 100k down the socket in one write(), i.e. enough to cause the
write to have to block.
--> BUG!!! The call blocks indefinitely instead of returning after 5
seconds

(Note that the same test but with SO_RCVTIMEO and a read() works as
expected - I get EAGAIN after 5 seconds).


2)
Create a localhost listening socket - AF_INET, SOCK_STREAM.
Connect to the listening port
Set a 5 second SO_SNDTIMEO on the socket.
write() 1Mb down the socket in one write(), i.e. enough to cause it to
have to block
-> The write() will return after 5 seconds with a partial write count.
GOOD!
Repeat the write() - send another 1Mb.
--> BUG!! The call blocks indefinitely instead of returning with EAGAIN
after 5s.


I hope this is detailled enough. I'm trying to gain access to a FreeBSD
box to compare results..

Cheers
Chris


