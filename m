Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261842AbULPGGw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261842AbULPGGw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 01:06:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262582AbULPGGw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 01:06:52 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:40970 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S261842AbULPGGt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 01:06:49 -0500
Date: Thu, 16 Dec 2004 06:49:33 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Adam Denenberg <adam@dberg.org>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>, linux-kernel@vger.kernel.org
Subject: Re: bind() udp behavior 2.6.8.1
Message-ID: <20041216054932.GG17946@alpha.home.local>
References: <1103038728.10965.12.camel@sucka> <Pine.LNX.4.61.0412141700430.24308@yvahk01.tjqt.qr> <1103042538.10965.27.camel@sucka> <Pine.LNX.4.61.0412141742590.22148@yvahk01.tjqt.qr> <1103043716.10965.40.camel@sucka> <Pine.LNX.4.61.0412141806440.5600@yvahk01.tjqt.qr> <1103045881.10965.48.camel@sucka>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1103045881.10965.48.camel@sucka>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Dec 14, 2004 at 12:38:02PM -0500, Adam Denenberg wrote:
 
> My issue is that linux is not randomizing or incrementing the ports it
> uses for udp connections to prevent this sort of issue since udp is
> connectionless.  We dont have sequence numbers or the sorts like TCP to
> sort this out, we only have source ip and port.

Most UDP services use the server socket to access remote servers. For
example, bind will only use its source port 53 to emit requests, ntpd
will only use source port 123, this *is* how they have been working for
ages. PIX is totally buggy and does not respect standards, it respects
what seems to be "common practices" (remember TCP ECN ?). If the
developpers have observed that freebsd wastes lots of source ports for
DNS requests, they will decide that using the same one is probably an
attack. I even remember that it does not support NTP correctly. When
an NTP server on your LAN "connects" to another one outside, it
translates the source port 123 to another source port < 1024, which
most servers and/or firewalls drop (they only let 123 or >=1024 in).

> Other OS's seem  to do this and thus apps are not getting broken when
> connections are made thru the firewall, which is why i originally posted
> the question.

Perhaps the other OS you have seen simply close the socket as soon as they
get their response, and have to create a new one for each new request...
How does any DNS server forward to outside through your PIX ?

> I was hoping that maybe there is some workaround or that
> hopefully someone else encountered this issue.  I am not saying the
> firewall is not totally to blame, but i can see why it is behaving the
> way it is when seeing tons of connections from the same udp ip/port come
> in.

I doubt you can reliably use any UDP-based application through this
firewall then... It seems more buggy than other pixes I have encountered,
and I think you can configure it to be less silly, but I don't know how.
You agree that a session is defined by these 5 numbers :
  - proto (udp, tcp, icmp, ...)
  - source ip, source port
  - destination ip, destination port

If these 5 parameters are the same within a certain time frame, the packet
belongs to a known session. If the combination is different, then it is a
new session, and there is no reason for the firewall to drop a new session
only based on the fact that 3 parameters out of 5 are the same as other ones.
It is as stupid as saying that you refuse to establish a new TCP connection
on some dest:80 because you just did it 30ms ago.

I you want to work around this buggy behaviour without reconfiguring the PIX,
you can also play with iptables on the linux machine to use a random source
port range :
  iptables -t nat -A OUTPUT -p udp --dport 53 -j SNAT --to-source <your ip>:1024-65534

But this is a dirty hack...

Regards,
Willy

