Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S154914AbQDUD1h>; Thu, 20 Apr 2000 23:27:37 -0400
Received: by vger.rutgers.edu id <S154886AbQDUD1X>; Thu, 20 Apr 2000 23:27:23 -0400
Received: from TSX-PRIME.MIT.EDU ([18.86.0.76]:36573 "HELO tsx-prime.MIT.EDU") by vger.rutgers.edu with SMTP id <S154914AbQDUDZs>; Thu, 20 Apr 2000 23:25:48 -0400
Date: Thu, 20 Apr 2000 23:29:48 -0400
Message-Id: <200004210329.XAA28130@tsx-prime.MIT.EDU>
From: "Theodore Y. Ts'o" <tytso@MIT.EDU>
To: hans@grumbeer.inka.de
Cc: linux-kernel@vger.rutgers.edu, fusion94@valinux.com
In-reply-to: Hans-Joachim Baader's message of Thu, 20 Apr 2000 09:41:45 +0200 (CEST), <m12iBar-0019snC@grumbeer.inka.de>
Subject: Re: Problems with MTU?
Phone: (781) 391-3464
Sender: owner-linux-kernel@vger.rutgers.edu

   From: hans@grumbeer.inka.de (Hans-Joachim Baader)
   Date: 	Thu, 20 Apr 2000 09:41:45 +0200 (CEST)

   for several months I had the problem that access to some web sites
   fails mysteriously. This means I never got a reply although the
   servers were reachable with ping and telnet.

   Today I did

	   echo 1 > /proc/sys/net/ipv4/ip_no_pmtu_disc

   and suddenly all these sites worked again for me. I use kernel 2.2.x
   (2.2.pre15-19 currently). Some of the affected sites are
   dri.sourceforge.net (in fact, the whole sourceforge.net)
   and support.3com.com

   Are these web sites broken? I never had these problems under Windows,
   so this is probably not the case.

Actually, yes, the web sites are broken; but it's a relatively subtle
problem.  Here's what's going on.

The web sites are probably behind a firewall which is filtering all ICMP
packets (since some dumb firewall administrator read somewhere that all
ICMP packets are evil).  Somewhere in the network path between you and
the web site, there's a link which has a maximum MTU which is smaller
than the ethernet default of 1500 bytes.

Normally, dumb hosts would just send bytes using their local max MTU,
and then when the packets hit the link with the restricted MTU, the
packet would get fragmented at that point, and then it would get
reassembled at the receiver.  Fragmentation has the problem, though,
that it only takes one fragment to get lost in order to require the
retranmission of the entire packet, thus wasting network bandwidth ---
and if the reason why the one of the fragments was dropped was due to
link congestion, the fact that all of the fragments have to get
retransmitted can actually worsen the situation.

Hence, good network citizens (of which Linux is one) uses Path MTU
discovery to try to determine the appropriate size to send over any
arbitrary link.  The way it works is very simple; in each direction, the
hosts sends packets with the Don't Fragment bit set.  When a packet
which is too large reaches the router just before the link with the
restricted MTU, since the don't fragment bit is set, the router drops
the packet on the floor and sends back an ICMP Destination unreachable
with a code which means "fragmentation needed and DF set", along with
the maximum MTU of the constricting network link.  This allows the
sender to automatically determine maximum MTU for the hop, and the
sender can then resend the TCP segment using a smaller packetsize, now
that the maximum path MTU is known.

The problem with this comes with, as I mentioned earlier, bone-headed
firewall maintainers who believe that all ICMP packets are bad and
filters all of them.  This includes the ICMP Destination unreacable
packets which are needed to make path MTU function correctly.  As a
result, a site which is behind one of these firewalls will continually
send big packets with the don't fragment bit set, which then get
rejected when they hit the constricting link, but since the firewall
filters out the ICMP "too big" message, the sending sight never knows
that the packets are getting rejected, and so they can never send you
anything. 

This doesn't come up in normal operation for most hosts because most
links support at least the ethernet maximum MTU of 1500, and if there is
a constricting link, it is at the client endpoint (for example, the
client is dialing up with PPP and so has a restricted MTU).  At the
client end point, it's not a problem, since the client knows that it's
sending packets to an interface with a restricted MTU, and so it sends
small packets.  The problem comes when the constricting link is in the
*middle* of the network path, and so Path MTU discovery is required in
order to make things work.  (Either that, or you have to learn to live
with fragmentation with their attendant disadvantage).

So this will come up if you are using a PPP to connect to your gateway,
and then you use NAT to allow machines on the local ethernet to gain
access to the network via your singleton PPP connection.  It also comes
up with those folks using DSL where the providers are using the
abomination also known as PPP over Ethernet (PPPOE).

   Could anyone please explain this? Is there a better solution than
   disabling MTU discovery?

There are a couple of solutions you can use to solve this problem.  One
is to ask nicely to the web site administrators that they fix their
firewall.  Unfortunately, this doesn't always work.  I am told that
Amazon's web programmers were told about this problem, and they
acknowledged it *as* a problem, but said they weren't allowed to fix it.
(Probably because the bone-headed firewall administrator in their case
was clueless, and they didn't have the power to override him.)

The second approach, assuming that the constricting link is close to you
(usually it's the second-to-last hop in most scenarios), you can simply
set a per route max segment size (MSS) parameter, which will force TCP
packets using that particular route to be no larger than the MSS size
--- in both directions.  Given that the problem is usually on the link
to the outside internet, and that connections to other hosts within the
subnet are OK, it's usually a matter of setting the mss option only on
the default route:

route add default gw 216.176.176.160 mss 1400

The final approach, which apparently some of the DSL providers use, is
that on the cable modem box or on the DSLAM in the telco's central
office, they are actively messing with the outgoing packets, by looking
for TCP packets with the SYN bit set (which indicates the beginning of a
TCP stream), and change the max MSS option in the IP header to be
smaller than max MTU caused by the PPP over Ethernet overhead.  This is
incredibly ugly, and violates the IP protocol's end-to-end argument.  It
also breaks in the presence of IPSEC, since the DSL provider won't be
able to muck with the packet without breaking the cryptographic
checksums.  

So it's completely ugly.  Still, I imagine that Rusty will no doubt be
writing a new "packet fucking" module in ipchains to support this kind
of TCP syn option rewriting.  :-)

						- Ted

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
