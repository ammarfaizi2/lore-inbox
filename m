Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: (majordomo@vger.rutgers.edu) by vger.rutgers.edu via listexpand id <S156730AbQFOJkJ>; Thu, 15 Jun 2000 05:40:09 -0400
Received: by vger.rutgers.edu id <S156884AbQFOJh6>; Thu, 15 Jun 2000 05:37:58 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:3032 "HELO mail.ocs.com.au") by vger.rutgers.edu with SMTP id <S156983AbQFOJgu>; Thu, 15 Jun 2000 05:36:50 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Michael Cunningham <malice@exit109.com>
Cc: linux-kernel@vger.rutgers.edu
Subject: Re: Wierd Masquerading problem? 
In-reply-to: Your message of "Thu, 15 Jun 2000 02:03:01 -0400." <Pine.BSF.3.96.1000615014018.12251B-100000@hiway1.exit109.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 15 Jun 2000 19:38:21 +1000
Message-ID: <1750.961061901@ocs3.ocs-net>
Sender: owner-linux-kernel@vger.rutgers.edu

On Thu, 15 Jun 2000 02:03:01 -0400 (EDT), 
Michael Cunningham <malice@exit109.com> wrote:
>Some websites dont seem to ip masquerading.. take for example
>www.slashdot.org  I can get a packet out to them but nothing ever returns.
>
>If I open up a netscape session on the box doing the masquerading I can 
>access the site fine.

Classic symptom of a path MTU problem.  Short answer - increase your
PPP MTU to 1500 or decrease your internal Ethernet MTU to the same as
the PPP link.

Long winded explanation on path MTU problems.

When you start a TCP connection, the two ends of the link negotiate on
a path Maximum Transmission Unit (MTU), basically the largest packet
size that can be sent across the connection.  Alas, somewhere between
you and the failing site there is a box with a link MTU which is
smaller than the path MTU.  This does not cause a problem until one
site tries to send a large packet to the other and the packet is marked
"do not fragment".

Although the packet is within the agreed path MTU, it is too big for
the intermediate link and it cannot be fragmented (the DF bit is set).
When a large packet hits the link with a smaller MTU, the link is
supposed to send an ICMP response "Unreachable, need to fragment" back
to the sender.  The response includes the original packet header so the
sender can see which packet failed.  The sender is supposed to look at
the ICMP response, get the size of the packet, pick a new path MTU
which is less than the failing packet size and send the data in a new,
smaller packet.  This is called "Path MTU Discovery".

Most of the time path MTU discovery works fine.  The link starts with a
large MTU then settles down to an MTU set by the smallest link in the
route.  When discovery fails you get partial transfers then nothing,
all the big packets are getting lost.  There are several possible
causes of failure.

1) The intermediate link is not sending ICMP messages, it is just
   dropping the packets into the bit bucket.  There are some of these
   old routers out there but fortunately, not too many.
   
   Best solution is 4,000 volts up the router backplane.

2) The sender is not seeing the ICMP response.  Usually caused by some
   firewall being a bit too paranoid.

   The sender has to adjust their routers and/or firewall to let ICMP
   in.

3) The sender is seeing the ICMP response but is ignoring it.  Should
   not really happen.

   Sender has to correct their TCP/IP stack to handle ICMP "need to
   fragment".

4) The link with the low MTU is corrupting the packet header it sends
   back.  This problem is very common in routers based on BSD 4.2 and
   is known to affect Annex 4000's.  Read RFC 1191, section 5 for the
   gory details.  If the sender's TCP/IP stack is not aware of this
   common bug, it does not pick the correct MTU.  Windows NT (at least
   3.1) does not recover when faced with these routers.

   Solutions:

   a) Replace all buggy router code on the Internet (not going to
      happen anytime soon).  If the problem link is at your ISP this is
      the best solution for this bug.

   b) Upgrade the sender's TCP/IP stack to recognise the buggy routers
      and calculate the correct MTU (Microsoft, not going to happen
      anytime soon).

The real problem with a failing path MTU discovery is that the fix has
to come from the sender's end, not from the receiver.  To get a
permanent fix, you have to explain the problem to the sender and get
them to diagnose and correct the problem from their end.

In some cases, the simplest option is for the sender to disable path
MTU discovery completely.  This turns off the "do not fragment" bit in
the packet header.  When a large packet hits the low MTU link, instead
of bouncing back to the sender, the packet is fragmented and forwarded
in pieces.  However fragments can have their own problems, this option
does not always work.

The only thing the receiver can do to bypass the problem is force the
original path MTU to a lower value so the offending link never sees big
packets.  If you have the application source code, setsockopt
TCP_MAXSEG will set the MTU for a single socket, it must be set after
creating the socket and before connecting to the other end.

If changing the source is not an option, you can change the path MTU
by setting the MTU value on your network interface.  For example,

ifconfig <interface> <ip-address> MTU <number>

The interface MTU can be changed at any time, although it can cause
problems if you reduce the interface MTU while connections are routing
across the interface.  Best to set it at start up or when no
connections exist.

WARNING: Changing the interface MTU will affect *ALL* new connections,
         not just the one you are trying to fix.  Low MTU's can slow
         down connections.

Picking the MTU number is a problem, the receiver never sees the ICMP
messages so you cannot tell what the limit is.  One option is just to
go down the list of common MTU values (see rfc 1191) until you hit a
value that works, starting a new connection each time.  Alternatively,
if you know how to read tcpdump output, run tcpdump while you "ping -s
<number> site", reducing <number> until you get a response which is not
fragmented, the path MTU is then <number+28>.

In some circumstances, you have to *increase* your MTU.  This only
occurs when your have a large MTU (say Ethernet) into a small MTU link
on a SLIP/PPP link and your ISP's terminal server has the BSD 4.2 bug.
Increasing your SLIP/PPP MTU to match the Ethernet MTU bypasses the
buggy terminal server code.  If you have this problem, get your ISP to
fix their server or change ISP.  AFAIK this problem can only happen
with this configuration :-

          MTU=m1           MTU=m2            MTU=m3
Internal -------- Gateway -------- Terminal -------- sender
machine           machine           Server

With m1 > m2, m2 < m3, clean routers from sender to terminal server and
a buggy terminal server.  The terminal server is typically an Annex of
some kind, Annex 4000 is known to be be buggy.  m1 is usually 1500
(Ethernet), m2 is the MTU of the SLIP/PPP link.

The initial path MTU is set to m1 because the connection is coming from
an internal machine.  The sender sends a packet with size <= m1, > m2
and don't fragment set.  This packet gets as far as the terminal server
which tries to forward it to the gateway machine and goes wrong.

Because the packet is > m2 and DF is set, the terminal server cannot
fragment and forward the packet, it sends "ICMP need to fragment" to
the sender.  When the terminal server has the BSD 4.2 bug, the ICMP
response is corrupt.  Unless the sender was written to cope with this
bug, the sender loops trying to send the same size packet.  A Linux
sender (post 1.3.54) copes with the 4.2BSD router bug, NT does not.

If you want to overcome the problem in this configuration, m1 must be
<= m2.  Either increase m2 to be equal to m1 or reduce m1 to match m2.
Since m1 is usually 1500, setting m2 to 1500 will fix the problem.  An
alternative is to reduce m1, however you have to do that for *all*
internal machines that access the Internet.  The real fix is to correct
the terminal server software or change to an ISP with reliable
software.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
