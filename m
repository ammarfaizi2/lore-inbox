Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270709AbTHSOhU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 10:37:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270695AbTHSOhL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 10:37:11 -0400
Received: from granite.aspectgroup.co.uk ([212.187.249.254]:12527 "EHLO
	letters.pc.aspectgroup.co.uk") by vger.kernel.org with ESMTP
	id S270709AbTHSOgk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 10:36:40 -0400
Message-ID: <353568DCBAE06148B70767C1B1A93E625EAB58@post.pc.aspectgroup.co.uk>
From: Richard Underwood <richard@aspectgroup.co.uk>
To: "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>
Cc: "'David S. Miller'" <davem@redhat.com>,
       Stephan von Krawczynski <skraw@ithnet.com>, willy@w.ods.org,
       carlosev@newipnet.com, lamont@scriptkiddie.org, davidsen@tmr.com,
       bloemsaa@xs4all.nl, Marcelo Tosatti <marcelo@conectiva.com.br>,
       netdev@oss.sgi.com, linux-net@vger.kernel.org, layes@loran.com,
       torvalds@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: [2.4 PATCH] bugfix: ARP respond on all devices
Date: Tue, 19 Aug 2003 15:34:43 +0100
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2656.59)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> You increase it and you shortcut on shared lans. Thats really a seperate
> issue to the question of which source is used. If you loopback someone
> elses address on your own lo device I'm not suprised weird 
> shit happens, put the alias on eth0 where it belongs.
> 
	Woah! I'm not talking about JUST load-balanced networks. This is a
far more generic problem.

	As an example, I have a router/firewall for the office that has two
interface cards, both with perfectly valid internal addresses - these
addresses aren't used anywhere else on the network.

	Two of the interfaces are: 172.20.240.2/24 and 172.24.0.1/16. My
default gateway is 172.20.240.1 and there aren't any other non-interface
routes. If I do:

# arp -d 172.24.0.80
# ping -I 172.20.240.2 172.24.0.80

	I see:

16:18:40.856328 arp who-has 172.24.0.80 tell 172.20.240.2
16:18:40.856431 arp reply 172.24.0.80 is-at 0:50:da:44:f:37

	Now, since 172.24.0.80 is a Linux box, it's happily adding
172.20.240.2 into its ARP table and reply to it, hence the reply.

	But if I was to do this in the other direction (arp -d 172.20.240.1;
ping -I 172.24.0.1 172.20.240.1) then I'd lose connectivity over my default
route because 172.20.240.1 won't accept ARP packets from IP numbers not on
the connected subnet. The <incomplete> ARP entry will block any further ARP
requests from valid IP numbers.

	This, in my opinion, isn't on. There must be thousands of Linux
installations out there that (1) have more than one interfaces and (2) are
connected to routers or firewalls that drop ARP requests in the same way. 

	Actually, it's not that bad in this case as the next hop will
probably send an ARP request at some point which will override it - but
that's really not the point.

	If the routeing was asymetric, or the next hop had a static ARP
entry for me, all communication would quite simply be lost. It'd just take
the first packet after an ARP entry times out to be from the wrong IP
address, and the host would be off the net.

	I personally don't think "shared LANs" should be favoured over best
practice. Even in the case of shared LANs, nothing "breaks" as David Miller
suggests would happen if the ARPs were fixed.

	Thanks,

		Richard
