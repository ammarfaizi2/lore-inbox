Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268771AbRG0Eon>; Fri, 27 Jul 2001 00:44:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268772AbRG0Eod>; Fri, 27 Jul 2001 00:44:33 -0400
Received: from 216-60-128-137.ati.utexas.edu ([216.60.128.137]:3293 "HELO
	tsunami.webofficenow.com") by vger.kernel.org with SMTP
	id <S268771AbRG0EoN>; Fri, 27 Jul 2001 00:44:13 -0400
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@webofficenow.com>
Reply-To: landley@webofficenow.com
To: Nerijus Baliunas <nerijus@users.sourceforge.net>,
        Julio Sanchez Fernandez <j_sanchez@stl.es>
Subject: Re: Transparent proxies and binding to foreign addresses
Date: Thu, 26 Jul 2001 15:41:50 -0400
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <m2lmlcakrq.fsf@j-sanchez-p.stl.es> <200107270215.EAA1376016@mail.takas.lt>
In-Reply-To: <200107270215.EAA1376016@mail.takas.lt>
MIME-Version: 1.0
Message-Id: <01072615415006.02057@localhost.localdomain>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Thursday 26 July 2001 22:15, Nerijus Baliunas wrote:
> On 25 Jul 2001 21:09:13 +0200 Julio Sanchez Fernandez <j_sanchez@stl.es>
> wrote:
>
> JSF>
> JSF> I have been using transparent proxies on Linux for a long time, very
> JSF> possibly longer than anyone else, since I wrote a extremely crude hack
> JSF> that served me well back 1995.
>
> JSF> This mechanism has worked since I originally wrote my kludge up to
> JSF> 2.2.x but, from what I can gather, it does not work anymore in 2.4.x.
>
> Hello,
>
> I don't know if it is useful for you, but http://www.mcknight.de/jftpgw
> supports transparent proxy for Linux 2.4.x kernel.
>
> BTW, do you know of any port forwarder which works with 2.4 kernel in
> transparent mode? I tried mmtcpfwd and portfwd, but both do not work.

Well, for simple forwarding within the box I'm using:

iptables -t nat -A PREROUTING -p tcp -i eth1 -d 10.0.0.0/8 -j REDIRECT 
--to-port 3141

That's to forward an all ports for a given address range (anything in the 
10.x.x.x subnet in this case) to a daemon on the box itself.  I don't 
remember if it winds up on eth1 or on loopback (where said daemon should 
bind), probably eth1.  The magic snippet of C code that can recover the 
original destination address and port for a forwarded connection is:

getsockopt(connection_fd,SOL_IP,SO_ORIGINAL_DST, &addr, &i);

(Finding out the above involved thumbscrews, a bullwhip, google, a lot of 
luck, and emailing various developers.  But I sent it off to the man page 
maintainer so hopefully it should be better documented now.)

To forward a port outside the box entirely, the mystic iincantation is:

iptables -t nat -A PREROUTING -i eth0 -p tcp --dport "$fromport" --j DNAT 
--to "$addr":"$toport"


fromport being the port on the firwall (I.E. 80), addr and toport being the 
remote machine's IP address and the port number on that remote machine 
(hopefully one behind your firewall, although that's probably not a 
requirement).

Is that what you needed?

> Regards,
> Nerijus

Rob
