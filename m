Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268734AbTCCTZa>; Mon, 3 Mar 2003 14:25:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268733AbTCCTZa>; Mon, 3 Mar 2003 14:25:30 -0500
Received: from 2etnv5.cm.chello.no ([80.111.51.24]:14466 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S268729AbTCCTZ0>; Mon, 3 Mar 2003 14:25:26 -0500
Subject: Re: anyone ever done multicast AF_UNIX sockets?
From: Terje Eggestad <terje.eggestad@scali.com>
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, netdev@oss.sgi.com,
       linux-net@vger.kernel.org, davem@redhat.com
In-Reply-To: <3E638C51.2000904@nortelnetworks.com>
References: <3E5E7081.6020704@nortelnetworks.com>
	<1046695876.7731.78.camel@pc-16.office.scali.no> 
	<3E638C51.2000904@nortelnetworks.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 03 Mar 2003 20:39:19 +0100
Message-Id: <1046720360.28127.209.camel@eggis1>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-03-03 at 18:09, Chris Friesen wrote:
    Terje Eggestad wrote:
    > On a single box you would use a shared memory segment to do this. It has
    > the following advantages:
    > - no syscalls at all
    
    Unless you poll for messages on the receiving side, how do you trigger 
    the receiver to look for a message?  Shared memory doesn't have file 
    descriptors.
    
OK, you want multicast to send the *same* info to all peers. The only of
two sane reason to do that is to update the peers with some info they
need to do real work. So when there is reel work to be done, the info is
available in the shm. 

The other reason is to tell the others to die. Then you a) have a
socket/pipe connected that you get a end of file event on, or, you have
a timeout on the select() (in any real life app you should anyway) so
that when select/poll return -1 with errno=EINTR, you check some flags
in shm. 

If you *had* multicast, you don't know *when* a peer proccessed it. 
What if the peer is suspended ??? you don't get an error on the send,
and you apparently never get an answer, then what? The peer may also
gone haywire on a while(1);
   
I have an OSS project project (http://midway.sourceforge.net/) where I
have a gateway daemon that poll on a large set of sockets (TCP/IP
clients) and passes the request to IPC servers, and back. The way I'm
doing that is to have two threads, on on blocking wait on the
select/poll, the other on msgrcv. Works quite well. 

  
    > - whenever the recipients need to use the info, they access the shm
    > directly (you may need to use a semaphore to enforce consistency, or if
    > you're really pressed on time, spin lock a shm location) There is no
    > need for the recipients to copy the info to private data structs.
    
    How do they know the information has changed?  Suppose one process 
    detects that the ethernet link has dropped.  How does it alert other 
    processes which need to do something?
    
Again, if you want someone to do something, they must ack the request
before you can safely assume that they are going to do something.
 
    > Why does it help you to know that there are no recipients contra the
    > wrong number recipients ???? OR asked differently, if you don't have a
    > notion of who the recipients are/should be, why would you care if there
    > are none??????
    > There are practically no real applications for this feature. 
    
    It's true that if I have a nonzero number of listeners it doesn't tell 
    me anything since I don't know if the right one is included.  However, 
    if I send a message and there were *no* listeners but I know that there 
    should be at least one, then I can log the anomaly, raise an alarm, or 
    take whatever action is appropriate.
    
    > Also: Keep in mind that either you do multicast, or explisit send to
    > all, the data you're sending are copied from you buffer to the dest
    > sockets recv buffers anyway. If you're sending 1k you need somewhere
    > between 250 to 1000 cycles to do the copy, depending on alignment. I've
    > measured the syscall overhead for a write(len=0) to be about 800 cycles
    > on a P3 or athlon, and about 2000 on P4. If you really have enough
    > possible recipients, you should use a shm segment instead. If you have
    > only a few (~10) the overhead is worst case 20000 cycles, or on a 2G P4,
    > 10 microsecs to do a syscall for each. Who cares... 
    
    Granted, shared memory (or sysV message queues) are the fastest way to 
    transfer data between processes.  However, you still have to implement 
    some way to alert the receiver that there is a message waiting for it.
    
    For large packet sizes it may be sufficient to send a small unix socket 
    message to alert it that there is a message waiting, but for small 
    messages the cost of the copying is small compared to the cost of the 
    context switch, and the unix multicast cuts the number of context 
    switches in half.
    
    Chris
    
    -- 
    Chris Friesen                    | MailStop: 043/33/F10
    Nortel Networks                  | work: (613) 765-0557
    3500 Carling Avenue              | fax:  (613) 765-2986
    Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com



-- 
_________________________________________________________________________

Terje Eggestad                  mailto:terje.eggestad@scali.no
Scali Scalable Linux Systems    http://www.scali.com

Olaf Helsets Vei 6              tel:    +47 22 62 89 61 (OFFICE)
P.O.Box 150, Oppsal                     +47 975 31 574  (MOBILE)
N-0619 Oslo                     fax:    +47 22 62 89 51
NORWAY            
_________________________________________________________________________

