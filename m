Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268880AbRGaILw>; Tue, 31 Jul 2001 04:11:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269006AbRGaILl>; Tue, 31 Jul 2001 04:11:41 -0400
Received: from leeor.math.technion.ac.il ([132.68.115.2]:1946 "EHLO
	leeor.math.technion.ac.il") by vger.kernel.org with ESMTP
	id <S268880AbRGaILe>; Tue, 31 Jul 2001 04:11:34 -0400
Date: Tue, 31 Jul 2001 11:11:31 +0300
From: "Nadav Har'El" <nyh@math.technion.ac.il>
To: Erik De Bonte <erikd@lithtech.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Determining IP:port corresponding to an ICMP port unreachable
Message-ID: <20010731111131.B29309@leeor.math.technion.ac.il>
In-Reply-To: <AF020C5FC551DD43A4958A679EA16A1501349556@mailcluster.lith.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <AF020C5FC551DD43A4958A679EA16A1501349556@mailcluster.lith.com>; from erikd@lithtech.com on Mon, Jul 30, 2001 at 04:08:56PM -0700
Hebrew-Date: 11 Av 5761
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Mon, Jul 30, 2001, Erik De Bonte wrote about "Determining IP:port corresponding to an ICMP port unreachable":
> When an ICMP port unreachable message is received and corresponds to a UDP
> socket, is there a way to determine the corresponding unreachable IP and
> port?  I'm able to retrieve the IP, but not the port.  From looking through
> the kernel source, it appears that the port is never extracted from the
> payload section of the ICMP message.  If this is indeed a limitation of the
> kernel, is there a plan to "fix" it in the future?

If you recvfrom (for example) on a UDP socket (which, obviously, has some
port number) on which you sent a message previously, recvfrom will return
(-1) (with errno=connection refused) if an ICMP port unreachable was received
by the kernel for this port. This kind of error is asynchronous, in the sense
that you will get it some time later after sending the original message (you
could have sent and received a dozen other messages in the meantime).

For connected()ed sockets, this behavior is indeed useful - you know which
port sent the message, which host and port was meant to get that message
(because the socket is connected() and only sends to one host/port).

But for non-connected()ed sockets, you can only find out the host sending the
ICMP message. Note that sometimes (e.g., with host unreachable errors) you
don't even know the host you orignally sent the message to (that is burried
in the IP heard inside the ICMP data) - only the host that sent you the
error. And you don't know any port number (again, the port number is inside
the ICMP packet, but you have no access to it - this is what you wrote too).

This is why the original BSD behavior was to pass these errors only on
connect()ed sockets. Linux decided to give those errors on unconnect()ed
sockets - while it is usually not useful, it fits more closely with RFC 1122
which says in section 4.1.2.3: "UDP MUST pass to the application layer all
ICMP error messages that it receives from the IP layer".

There's a discussion about this issue in Stevens' book ""UNIX Network
Programming", section 8.9 (Elementary UDP Sockets, Server Not Running),
page 221, and he discusses why the socket API is problematic in that respect.

I think the only recourse you have (if you really want to know which
host/port every ICMP message is about) is to listen on a raw socket, which
you open with something like
	in_icmp=socket(AF_INET, SOCK_RAW, IPPROTO_ICMP);
	shutdown(in_icmp,SHUT_WR); /* optional (we don't intend to write) */

And then you'll get full ICMP packets (all of them!) - and you'll have to
pick out the ones intended for your port(s), and then take out the destination
ip and port inside the ip header that is inside the ICMP packet (not the
ip header of the ICMP packet itself!). This is rather ugly, because it requires
you to understand how IP and UDP headers look like.
Note that you need superuser permissions to create (but not to read) a
raw socket.

for example (just unchecked pseudo-code based on stuff I found in the
traceroute(8) sourcecode, but it will work with minor modifications)

#include <netinet/ip_icmp.h>
#include <netinet/udp.h>

parse_icmp(unsigned char *packet, int cc)
{
	struct ip *ip=(struct ip *) packet;
	struct icmp *icp;
	int hlen, icmp_len;

	hlen = ip->ip_hl << 2;
	if (cc < hlen + ICMP_MINLEN)
		/* packet too short... */

	icmp_len = cc-hlen;
	icp=(struct icmp *)(packet + hlen);

	if(icp->icmp_type==ICMP_TIMXCEED||
        icp->icmp_type==ICMP_UNREACH){
	/* this is an ICMP error message and it carries part of the original
	   packet, so we can see what this error is refering to. */
		struct ip *inner_ip = &icp->icmp_ip;
		hlen = inner_ip->ip_hl << 2;
		if(inner_ip->ip_p == IPPROTO_UDP){
		    /* This is a time exceeded error on some UDP packet we sent.
		       Note that it is guaranteed we get back the UDP header
                      (8 bytes) of the original ICMP packet (see the RFC),
                      but not necessarily the whole packet.
		      inner_udp is part of the original ICMP packet:
		    */
		    struct udphdr *inner_udp =
                      (struct udphdr *)((u_char *)inner_ip + hlen);
                    /* the UDP header is 8 bytes: see udp.h. we'll use
                       sizeof(udphdr) for clarity, but that will always be 8 */
                    if(icmp_len < hlen + sizeof(struct udphdr))
                       /** error: packet too short. do something. **/

		    /* now we can check if this is an error on a packet sent
                       by one of our sockets */
		    if(!is_one_of_my_sockets(inner_ip->ip_src, inner_udp->source)
			return; /* not one of ours */
		    /* just as an example, do something on port unreachable
		       errors */
		    if(icp->icmp_type==ICMP_UNREACH &&
			icp->icmp_code==ICMP_UNREACH_PORT
				){
			/* do something about this error. The problematic
			   packet was sent from our socket at ip
                           inner_ip->ip_src and port inner_udp->source,
			   and it was sent to ip inner_ip->ip_dst, port
			   inner_udp->dest; The error was returned from host
			   ip->ip_src (not always inner_ip->ip_src */
			...
		     }
		}	
	}
}

I hope this helps.

-- 
Nadav Har'El                        |         Tuesday, Jul 31 2001, 11 Av 5761
nyh@math.technion.ac.il             |-----------------------------------------
Phone: +972-53-245868, ICQ 13349191 |The space between my ears was
http://nadav.harel.org.il           |intentionally left blank.
