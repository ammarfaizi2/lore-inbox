Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284144AbSBGGSb>; Thu, 7 Feb 2002 01:18:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284305AbSBGGSV>; Thu, 7 Feb 2002 01:18:21 -0500
Received: from zcars0m9.nortelnetworks.com ([47.129.242.157]:34512 "EHLO
	zcars0m9.ca.nortel.com") by vger.kernel.org with ESMTP
	id <S284144AbSBGGSL>; Thu, 7 Feb 2002 01:18:11 -0500
Message-ID: <3C621DD2.5AE6448A@nortelnetworks.com>
Date: Thu, 07 Feb 2002 01:25:22 -0500
X-Sybari-Space: 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
Cc: Ion Badulescu <ionut@cs.columbia.edu>, linux-kernel@vger.kernel.org
Subject: Re: want opinions on possible glitch in 2.4 network error reporting
In-Reply-To: <E16Ydys-0007D6-00@the-village.bc.nu.suse.lists.linux.kernel> <Pine.LNX.4.44.0202062101390.4832-100000@age.cs.columbia.edu.suse.lists.linux.kernel> <p73zo2mqa7f.fsf@oldwotan.suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> 
> Ion Badulescu <ionut@cs.columbia.edu> writes:
> > I'll state again: if data (UDP or otherwise) is lost after sendto()
> > returns success but before it hits the wire, something is BROKEN in that
> > IP stack.
> 
> Your proposal would break select(). It would require UDP sendmsg to block
> when the TX queue is full. Most applications using select do
> not send the socket non blocking. If they select for writing and the
> kernel signals the socket writable they expect not to block in the write.
> As long as the only thing controlling the blocking is the per socket
> send buffer that works out as long as the application is careful enough
> not to fill its send buffer. If you would put the TX queue into the
> blocking equation too this cannot be guaranteed anymore because the TX queue
> is shared between all local processes and even forwarding. You would
> get random blocking on select based applications, breaking them.

I don't see the problem.  So sendto() blocks if there is no room on the socket
buffer.  Fine.  So if there's room on the socket buffer we take the packet and
put in on the buffer, and sendto() returns.

Now, for each socket we've got a buffer of packets that want to get onto the
device driver tx queue.  So we use some kind of algorithm to pick which packets
to move from the group of socket buffers to the device driver tx queue.  If the
app calls sendto() before there is space in the socket buffer, then sendto()
blocks.  select() should return whether or not there is space in the socket
buffer.  Eventually, every packet that gets put into a socket buffer makes it
out onto the wire.  Congestion is dealt with by leaving packets in the socket
buffers until they can be guaranteed a spot in the device tx queue.  I assume we
would try and add it to the tx queue, and remove it from the socket buffer if
the add succeeds.

I just don't see why sendto() would accept the packet and then later on it gets
dropped.

Chris

-- 
Chris Friesen                    | MailStop: 043/33/F10  
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com
