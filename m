Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261813AbULOUUC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261813AbULOUUC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 15:20:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262418AbULOUUB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 15:20:01 -0500
Received: from bigeats.dufftech.com ([69.57.156.29]:63898 "HELO
	bigeats.dufftech.com") by vger.kernel.org with SMTP id S261813AbULOUTy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 15:19:54 -0500
Subject: Re: bind() udp behavior 2.6.8.1
From: Adam Denenberg <adam@dberg.org>
To: linux-os@analogic.com
Cc: Jan Harkes <jaharkes@cs.cmu.edu>, Kyle Moffett <mrmacman_g4@mac.com>,
       linux-kernel@vger.kernel.org, Jan Engelhardt <jengelh@linux01.gwdg.de>
In-Reply-To: <Pine.LNX.4.61.0412151459150.4365@chaos.analogic.com>
References: <1103038728.10965.12.camel@sucka>
	 <Pine.LNX.4.61.0412141700430.24308@yvahk01.tjqt.qr>
	 <1103042538.10965.27.camel@sucka>
	 <Pine.LNX.4.61.0412141742590.22148@yvahk01.tjqt.qr>
	 <1103043716.10965.40.camel@sucka>
	 <8AF1BC56-4E1C-11D9-B94B-000393ACC76E@mac.com>
	 <57782EC8-4E40-11D9-B971-003065B11AE8@dberg.org>
	 <20F668EE-4E48-11D9-B94B-000393ACC76E@mac.com>
	 <1103120162.5517.14.camel@sucka>
	 <20041215190725.GA24635@delft.aura.cs.cmu.edu>
	 <1103138573.6825.11.camel@sucka>
	 <Pine.LNX.4.61.0412151459150.4365@chaos.analogic.com>
Content-Type: text/plain
Message-Id: <1103141991.6825.17.camel@sucka>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 15 Dec 2004 15:19:51 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sorry for any confusion, but i am not referring to the Identification
field in the IP header but rather the "Transaction ID" field in the DNS
query portion of the packet.  I can reproduce this behavior on our linux
system where if i pump gethostbyname_r requests on the system at some
point it will reuse a transaction id in the DNS request.  This is my
lastest discovery in what is causing the requests to fail thru the
firewall.  So far my research has not turned up any reason as to why the
kernel would be re-using a transaction ID in the dns request.

The ip IDentification field is uniquely generated as it should be, just
not the Transaction ID field of the dns portion of the packet.

adam

Please CC me as I am not on this list.


On Wed, 2004-12-15 at 15:06, linux-os wrote:
> On Wed, 15 Dec 2004, Adam Denenberg wrote:
> 
> > almost yes.  The firewall never passes the retransmit onto the DNS
> > server since it has the same DNS ID, source port and source ip.  What is
> > happening is the following
> >
> > request 1
> > --------------------
> > linux box.32789 (id 001) ->  FW -> DNS SERVER.53
> > DNS SERVER.53 (id 001) -> FW -> linux box.32789
> >
> > request 2
> > -------------------
> > linux box.32789 (id 002) -> FW -> DNS SERVER.53
> > DNS SERVER (id 002).53 -> FW -> linux box.32789
> >
> > request 3
> > -----------------------
> > linux box (id 002).32789 -> FW -> NEVER GETS HERE, B/C ITS DROPPED
> >
> > the time between request 2 and request 3 is under 60ms.  The firewall is
> > in the midst of clearing its table for the dns request with ID 002
> > already so it thinks its a duplicate and drops it.  So my question is,
> > why is the kernel not incrementing the DNS ID in this case? It does it
> > for almost all other tests that i can find, and the firewall does not
> > drop any traffic.  Only when the DNS ID does not increment does this
> > problem occur.  This does not seem to always be the default behavior.  I
> > wrote a small C program to just put a gethostbyname_r() in a for loop
> > and each DNS ID is incremented all 40 times.  But there are times when
> > this doesnt happen, and this seems to be what is causing the issue.  The
> > firewall needs some sort of identifier to know which dns request is
> > associated with which dns reply (source ip, source port, ID).
> >
> > this is the behavior I am trying to debug.
> >
> > thanks
> > adam
> 
> The ID portion of the IP header, offset 32, is 16 bits of unique
> identification that is supposed to be unique for the entire time
> that any message should be in the system. That's what firewalls
> and routers use to determine if it's a duplicate packet. You
> never before stated that Linux was duplicating the ID portion,
> and if it is, it's a bug. But, I'll bet that it isn't. Nothing
> would work if it was. All TCP/IP messages are composed of
> Datagrams. If these basic elements were mucked up, this would
> have been discovered long before now, and if not discovered,
> you wouldn't receive this message. Also UCP is connectionless
> and stateless. If you have some box that handles it differently,
> its broken.
> 
> 
> Cheers,
> Dick Johnson
> Penguin : Linux version 2.6.9 on an i686 machine (5537.79 BogoMips).
>   Notice : All mail here is now cached for review by John Ashcroft.
>                   98.36% of all statistics are fiction.
> 

