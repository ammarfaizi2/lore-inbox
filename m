Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269414AbRGaTDM>; Tue, 31 Jul 2001 15:03:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269407AbRGaTDC>; Tue, 31 Jul 2001 15:03:02 -0400
Received: from abbott.lith.com ([207.195.147.16]:4614 "EHLO
	MAILCLUSTER.lith.com") by vger.kernel.org with ESMTP
	id <S269414AbRGaTCw>; Tue, 31 Jul 2001 15:02:52 -0400
Message-ID: <AF020C5FC551DD43A4958A679EA16A1501349560@mailcluster.lith.com>
From: Erik De Bonte <erikd@lithtech.com>
To: "'Philippe Troin'" <phil@fifi.org>,
        "'Nadav Har'El'" <nyh@math.technion.ac.il>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: Determining IP:port corresponding to an ICMP port unreachable
Date: Tue, 31 Jul 2001 12:03:14 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Philippe Troin said:
> Nah, on linux, use setsockopt with IP_RECVERR.
> man 7 ip

I've already tried that, but was only able to retrieve the IP, not the port.
>From my original message: "I'm able to retrieve the IP via recvmsg with the
MSG_ERRQUEUE flag (and the IP_RECVERR sockopt), but the port that it gives
me is bogus."

Nadav Har'El said:
> But for non-connected()ed sockets, you can only find out the host
> sending the ICMP message.

Why?  The remote port is in the ICMP message (64-bits of the undeliverable
message's header are in there), right?  Why can't the kernel net code
extract the port and give it to me?  It's obviously possible, since Winsock
does it.**

-Erik

** Btw, please don't take that as Linux bashing.  Our server runs
significantly faster on Linux, which is awesome!  However, there are a few
small issues like this one that are causing problems for me.

-----Original Message-----
From: Philippe Troin [mailto:phil@fifi.org]
Sent: Tuesday, July 31, 2001 9:42 AM
To: Nadav Har'El
Cc: Erik De Bonte; linux-kernel@vger.kernel.org
Subject: Re: Determining IP:port corresponding to an ICMP port
unreachable


"Nadav Har'El" <nyh@math.technion.ac.il> writes:

> On Mon, Jul 30, 2001, Erik De Bonte wrote about "Determining IP:port
> corresponding to an ICMP port unreachable":

> > When an ICMP port unreachable message is received and corresponds
> > to a UDP socket, is there a way to determine the corresponding
> > unreachable IP and port?  I'm able to retrieve the IP, but not the
> > port.  From looking through the kernel source, it appears that the
> > port is never extracted from the payload section of the ICMP
> > message.  If this is indeed a limitation of the kernel, is there a
> > plan to "fix" it in the future?
> 
> If you recvfrom (for example) on a UDP socket (which, obviously, has
> some port number) on which you sent a message previously, recvfrom
> will return (-1) (with errno=connection refused) if an ICMP port
> unreachable was received by the kernel for this port. This kind of
> error is asynchronous, in the sense that you will get it some time
> later after sending the original message (you could have sent and
> received a dozen other messages in the meantime).
> 
> For connected()ed sockets, this behavior is indeed useful - you know
> which port sent the message, which host and port was meant to get
> that message (because the socket is connected() and only sends to
> one host/port).
> 
> But for non-connected()ed sockets, you can only find out the host
> sending the ICMP message. Note that sometimes (e.g., with host
> unreachable errors) you don't even know the host you orignally sent
> the message to (that is burried in the IP heard inside the ICMP
> data) - only the host that sent you the error. And you don't know
> any port number (again, the port number is inside the ICMP packet,
> but you have no access to it - this is what you wrote too).
> 
> This is why the original BSD behavior was to pass these errors only
> on connect()ed sockets. Linux decided to give those errors on
> unconnect()ed sockets - while it is usually not useful, it fits more
> closely with RFC 1122 which says in section 4.1.2.3: "UDP MUST pass
> to the application layer all ICMP error messages that it receives
> from the IP layer".
> 
> There's a discussion about this issue in Stevens' book ""UNIX
> Network Programming", section 8.9 (Elementary UDP Sockets, Server
> Not Running), page 221, and he discusses why the socket API is
> problematic in that respect.
> 
> I think the only recourse you have (if you really want to know which
> host/port every ICMP message is about) is to listen on a raw socket, which
> you open with something like
> 	in_icmp=socket(AF_INET, SOCK_RAW, IPPROTO_ICMP);
> 	shutdown(in_icmp,SHUT_WR); /* optional (we don't intend to write) */
> 
> And then you'll get full ICMP packets (all of them!) - and you'll
> have to pick out the ones intended for your port(s), and then take
> out the destination ip and port inside the ip header that is inside
> the ICMP packet (not the ip header of the ICMP packet itself!). This
> is rather ugly, because it requires you to understand how IP and UDP
> headers look like.  Note that you need superuser permissions to
> create (but not to read) a raw socket.

Nah, on linux, use setsockopt with IP_RECVERR.
man 7 ip

Phil.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
