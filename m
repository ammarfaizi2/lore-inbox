Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291088AbSBGCzP>; Wed, 6 Feb 2002 21:55:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291089AbSBGCzC>; Wed, 6 Feb 2002 21:55:02 -0500
Received: from age.cs.columbia.edu ([128.59.22.100]:31243 "EHLO
	age.cs.columbia.edu") by vger.kernel.org with ESMTP
	id <S291088AbSBGCyy>; Wed, 6 Feb 2002 21:54:54 -0500
Date: Wed, 6 Feb 2002 21:54:45 -0500 (EST)
From: Ion Badulescu <ionut@cs.columbia.edu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux-kernel@vger.kernel.org, Chris Friesen <cfriesen@nortelnetworks.com>
Subject: Re: want opinions on possible glitch in 2.4 network error reporting
In-Reply-To: <E16YeOC-0007J5-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.44.0202062131290.4832-100000@age.cs.columbia.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Feb 2002, Alan Cox wrote:

> Wrong. man ping. ping -f doesn't do what you apparently think it does.

strace ping, you'll see it doing a 

	setsockopt(7, SOL_SOCKET, SO_SNDTIMEO, [1], 8) = 0

on its socket.

That's about the only way (aside from using a TBF queue, and other non
FIFO queues) you can lose data from a socket's queue.

Getting back to the NFS/UDP example: yes, NFS has its own flow control, 
but that's not the point. The reason NFS/UDP works so well with large NFS 
packets over a fully-switched *local* subnet is precisely because NFS's 
flow control is almost never exercised in that case. Data simply doesn't 
get lost -- never in the UDP socket's queue, and very rarely on the wire.

But you don't need to believe me. Just run the ttcp -uts test and explain 
how come all the data makes it to the other end (again, over a 
fully-switched local subnet) if:
1. ttcp has no clue about the wire speed (which it obviously doesn't) so 
it can't do rate limiting
2. the UDP socket simply discards data when some internal queue fills up, 
without blocking sendto() and without returning an error.

Moreover: please strace -T that ttcp -uts test, and notice how the time 
for the system call goes up by 2 orders of magnitude (i.e. it blocks) as 
soon as the socket queue fill up.

Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.



