Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271660AbRICKNC>; Mon, 3 Sep 2001 06:13:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271661AbRICKMx>; Mon, 3 Sep 2001 06:12:53 -0400
Received: from leeor.math.technion.ac.il ([132.68.115.2]:6568 "EHLO
	leeor.math.technion.ac.il") by vger.kernel.org with ESMTP
	id <S271660AbRICKMb>; Mon, 3 Sep 2001 06:12:31 -0400
Date: Mon, 3 Sep 2001 13:12:40 +0300
From: "Nadav Har'El" <nyh@math.technion.ac.il>
To: Andrey Savochkin <saw@saw.sw.com.sg>
Cc: linux-kernel@vger.kernel.org
Subject: Transparent proxy support in 2.4 - revisited
Message-ID: <20010903131240.A9791@leeor.math.technion.ac.il>
In-Reply-To: <20010607170825.A18760@leeor.math.technion.ac.il> <20010608014443.A28407@saw.sw.com.sg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20010608014443.A28407@saw.sw.com.sg>; from saw@saw.sw.com.sg on Fri, Jun 08, 2001 at 01:44:43AM -0400
Hebrew-Date: 15 Elul 5761
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A few months ago, I asked on this list why the transparent proxy feature
(CONFIG_IP_TRANSPARENT_PROXY) that was supported in Linux 2.2 is no longer
supported in Linux 2.4:

> > I am writing a transparent-proxy-like application, that needs to be able to
> > bind a TCP socket with a non-local address (i.e., the proxy contacts the
> > origin-server, in the local network, pretending to be the original client.
> > The reply will get back to the proxy because it acts as the default
> > gateway, and the kernel needs to pass that reply to the socket).

I included an example code, where bind() on a foreign address would work (if
I set ip_nonlocal_bind sysctl to 1), but a later connect() on that socket
would not.

Andrey Savochkin wrote a useful reply, on how to make the connect work():

> To make a custom kernel where you can use non-local addresses more freely,
> find source address checks in ip_route_output_slow() and get rid of all of
> them except considering
> 	MULTICAST(saddr) || BADCLASS(saddr) || ZERONET(saddr) ||
> 		saddr == htonl(INADDR_BROADCAST)
> as invalid.

I did that, and indeed now connect() works, and sends out (when considering
TCP) the appropriate SYN packet.

Unfortunately, that's not enough. When the return SYN-ACK packet carrying a
non-local destination address is received (in practice, the transparent
proxy machine is acting as a default gateway to the other machine), this
packet is either ignored or forwarded out (depending on ip_forward), but is
never accepted as a local packet and transfered to the appropriate socket
as it should.
To do that, some cache of open sockets will need to be consulted for
incoming packets that are not destined to local addresses (whether or not
ip_forward is enabled). This was done in kernel 2.2, where I found
CONFIG_IP_TRANSPARENT_PROXY-related changes in several files (af_inet.c,
icmp.c, ip_forward.c, ip_fw.c, ip_input.c, raw.c, route.c, syncookies.c,
tcp_ipv4.c and udp.c).

As I'm not an experienced Linux kernel hacker, and I'm barely familar with
Linux's networking code, so I hesitate to attempt such a feat (resurrecting
the transparent proxy code) myself, so I was wondering if anyone else had any
plans of doing that?

If not, does anyone know of a reason why this feature was abandoned on the
change to Linux 2.4: Was it a deliberate decision (e.g., because of performance
reasons, because it blurred the distinction between layer 2 and 3 when routing,
etc.) or simply a matter of priorities (e.g., adding transparent proxy support
would take up valuable kernel programmer time and was not deemed important
enough)?

Thanks,
	Nadav.

-- 
Nadav Har'El                        |        Monday, Sep  3 2001, 15 Elul 5761
nyh@math.technion.ac.il             |-----------------------------------------
Phone: +972-53-245868, ICQ 13349191 |It's fortunate I have back luck - without
http://nadav.harel.org.il           |it I would have no luck at all!
