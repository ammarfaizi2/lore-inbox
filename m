Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264813AbTCCMlG>; Mon, 3 Mar 2003 07:41:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264830AbTCCMlG>; Mon, 3 Mar 2003 07:41:06 -0500
Received: from elin.scali.no ([62.70.89.10]:11979 "EHLO elin.scali.no")
	by vger.kernel.org with ESMTP id <S264813AbTCCMlC>;
	Mon, 3 Mar 2003 07:41:02 -0500
Subject: Re: anyone ever done multicast AF_UNIX sockets?
From: Terje Eggestad <terje.eggestad@scali.com>
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, netdev@oss.sgi.com,
       linux-net@vger.kernel.org
In-Reply-To: <3E5E7081.6020704@nortelnetworks.com>
References: <3E5E7081.6020704@nortelnetworks.com>
Content-Type: text/plain
Organization: Scali AS
Message-Id: <1046695876.7731.78.camel@pc-16.office.scali.no>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 03 Mar 2003 13:51:17 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On a single box you would use a shared memory segment to do this. It has
the following advantages:
- no syscalls at all
- whenever the recipients need to use the info, they access the shm
directly (you may need to use a semaphore to enforce consistency, or if
you're really pressed on time, spin lock a shm location) There is no
need for the recipients to copy the info to private data structs. 
- there is no need for the recipients to waste cycles on processing an
update
- you KNOW that all the recipients has "updated" at the same time.



That aside, you idea of being notified when the listener (peer) is not
there is pretty hopless when it comes to multicasts. 

Why does it help you to know that there are no recipients contra the
wrong number recipients ???? OR asked differently, if you don't have a
notion of who the recipients are/should be, why would you care if there
are none??????
There are practically no real applications for this feature. 


If you really want to get to know that a recipient disappeared,  use 
a stream socket to each recipients, and to keep the # of syscalls down,
get the aio patch, and do the send to all with a single lio_listio()
call. 


Also: Keep in mind that either you do multicast, or explisit send to
all, the data you're sending are copied from you buffer to the dest
sockets recv buffers anyway. If you're sending 1k you need somewhere
between 250 to 1000 cycles to do the copy, depending on alignment. I've
measured the syscall overhead for a write(len=0) to be about 800 cycles
on a P3 or athlon, and about 2000 on P4. If you really have enough
possible recipients, you should use a shm segment instead. If you have
only a few (~10) the overhead is worst case 20000 cycles, or on a 2G P4,
10 microsecs to do a syscall for each. Who cares... 


TJ


On Thu, 2003-02-27 at 21:09, Chris Friesen wrote:
> It is fairly common to want to distribute information between a single 
> sender and multiple receivers on a single box.
> 
> Multicast IP sockets are one possibility, but then you have additional 
> overhead in the IP stack.
> 
> Unix sockets are more efficient and give notification if the listener is 
> not present, but the problem then becomes that you must do one syscall 
> for each listener.
> 
> So, here's my main point--has anyone ever considered the concept of 
> multicast AF_UNIX sockets?
> 
> The main features would be:
> --ability to associate/disassociate a socket with a multicast address
> --ability to associate/disassociate with all multicast addresses 
> (possibly through some kind of raw socket thing, or maybe a simple 
> wildcard multicast address)
> --on process death all sockets owned by that process are disassociated 
> from any multicast addresses that they were associated with
> --on sending a packet to a multicast address and there are no sockets 
> associated with it, return -1 with errno=ECONNREFUSED
> 
> The association/disassociation could be done using the setsockopt() 
> calls the same as with udp sockets, everything else would be the same 
> from a userspace perspective.
> 
> Any thoughts?  How hard would this be to put in?
> 
> Chris
-- 
_________________________________________________________________________

Terje Eggestad                  mailto:terje.eggestad@scali.no
Scali Scalable Linux Systems    http://www.scali.com

Olaf Helsets Vei 6              tel:    +47 22 62 89 61 (OFFICE)
P.O.Box 150, Oppsal                     +47 975 31 574  (MOBILE)
N-0619 Oslo                     fax:    +47 22 62 89 51
NORWAY            
_________________________________________________________________________

