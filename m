Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314981AbSD2KDW>; Mon, 29 Apr 2002 06:03:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314984AbSD2KDV>; Mon, 29 Apr 2002 06:03:21 -0400
Received: from elin.scali.no ([62.70.89.10]:48397 "EHLO elin.scali.no")
	by vger.kernel.org with ESMTP id <S314981AbSD2KDQ>;
	Mon, 29 Apr 2002 06:03:16 -0400
Subject: Re: Possible bug with UDP and SO_REUSEADDR.
From: Terje Eggestad <terje.eggestad@scali.com>
To: David Schwartz <davids@webmaster.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20020429084448.AAA25009@shell.webmaster.com@whenever>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 29 Apr 2002 12:03:14 +0200
Message-Id: <1020074594.22026.38.camel@pc-16.office.scali.no>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-04-29 at 10:44, David Schwartz wrote:
> 
> >>    1) The two instances are cooperating closely together and should be
> >>sharing
> >>a socket (not each opening one), or
> >>
> >>    2) The two instances are not cooperating closely together and each own
> >>their
> >>own socket. For all the kernel knows, they don't even know about each
> >>other.
> >>
> >>    In the first case, it's logical for whichever one happens to try to 
> read
> >>first to get the/a datagram. In the second case, it's logical for the
> >>kernel
> >>to pick one and give it all the data.
> >>
> >>    DS
> 
> >IMHO, in the second case it's logical for the kernel NOT to allow the
> >second to bind to the port at all. Which it actually does, it's the
> >normal case. When you set the SO_REUSEADDR flag on the socket you're
> >telling the kernel that we're in case 1).
> >
> >TJ  
> 
> 	NO. When you set the SO_REUSEADDR, you are telling the kernel that you 
> intend to share your port with *someone*, but not who. The kernel has no way 
> to know that two processes that bind to the same UDP port with SO_REUSEADDR 
> are the two that were intended to cooperate with each other. For all it 
> knows, one is a foo intended to cooperate with other foo's and the other is a 
> bar intended to cooperate with other bar's.
> 
> 	That's why if you mean to share, you should share the actual socket 
> descriptor rather than trying to reference the same transport endpoint with 
> two different sockets.
> 
> 	Of course, in this case you don't even need SO_REUSEADDR/SO_REUSEPORT since 
> you only actually open the endpoint once.
> 

Well, first of all, I picked up "Unix Network Programming, Networking
APIs: Scokets and XTI" by R. Stevens.This is discussed on p.195-196.
(With reference to "TCP/IP Illustrated" Vol 2, p.777-779, which I don't
have at hand). According to Stevens, duplicate binding to the same
address (IP + port) is an multicast/broadcast feature, and the test code
I published here a few mail ago is actually illegal on hosts that 
a) don't implement multicast.
b) implement SO_REUSEPORT (Which Linux as of now don't)

FYI: In b) the use of SO_REUSEPORT to do bind of duplicate addr is the
same as SO_REUSEADDR is now. All parties must set the flag.

Stevens further remarks that when a unicast datagram is received on the
port only one socket shall receive it, *** and which one is
implementation specific. ***!!!

*** So the current implementation is NOT a bug. *** (If you believe
Stevens that is :-) I do.).


I even agree that the *proper* way for two or more programs to share a
UDP port is to share the socket, it just create an issue about who shall
create the AF_UNIX socket used to pass the descriptor, and what happen
when the owner of the AF_UNIX socket dies. (they others will after all
most likely continue). Not to mention the extra code needed in the
programs to implement the descriptor passing algorithm. 
  

However, I still can't see any *practical* use of having one program
(me) bind the port, deliberately share it, and another program (you)
coming along and want to share it, and then all unicast datagrams are
passed to you. Not If I haven't subscribed to any multicast addresses,
and no one is sending bcasts, there is no point of me being alive. 

Can you come up with a real life situation where this make sense?


Like I said, it's currently not a bug, and IMHO any behavior should only
be changed  iff SO_REUSEPORT is implemented. 



> 	DS
> 
> 

TJ

-- 
_________________________________________________________________________

Terje Eggestad                  mailto:terje.eggestad@scali.no
Scali Scalable Linux Systems    http://www.scali.com

Olaf Helsets Vei 6              tel:    +47 22 62 89 61 (OFFICE)
P.O.Box 150, Oppsal                     +47 975 31 574  (MOBILE)
N-0619 Oslo                     fax:    +47 22 62 89 51
NORWAY            
_________________________________________________________________________

