Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262470AbULOTY5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262470AbULOTY5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 14:24:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262464AbULOTY5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 14:24:57 -0500
Received: from bigeats.dufftech.com ([69.57.156.29]:41370 "HELO
	bigeats.dufftech.com") by vger.kernel.org with SMTP id S262453AbULOTWy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 14:22:54 -0500
Subject: Re: bind() udp behavior 2.6.8.1
From: Adam Denenberg <adam@dberg.org>
To: Jan Harkes <jaharkes@cs.cmu.edu>
Cc: Kyle Moffett <mrmacman_g4@mac.com>, linux-kernel@vger.kernel.org,
       Jan Engelhardt <jengelh@linux01.gwdg.de>
In-Reply-To: <20041215190725.GA24635@delft.aura.cs.cmu.edu>
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
Content-Type: text/plain
Message-Id: <1103138573.6825.11.camel@sucka>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 15 Dec 2004 14:22:53 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

almost yes.  The firewall never passes the retransmit onto the DNS
server since it has the same DNS ID, source port and source ip.  What is
happening is the following

request 1
--------------------
linux box.32789 (id 001) ->  FW -> DNS SERVER.53
DNS SERVER.53 (id 001) -> FW -> linux box.32789 

request 2
-------------------
linux box.32789 (id 002) -> FW -> DNS SERVER.53
DNS SERVER (id 002).53 -> FW -> linux box.32789

request 3
-----------------------
linux box (id 002).32789 -> FW -> NEVER GETS HERE, B/C ITS DROPPED

the time between request 2 and request 3 is under 60ms.  The firewall is
in the midst of clearing its table for the dns request with ID 002
already so it thinks its a duplicate and drops it.  So my question is,
why is the kernel not incrementing the DNS ID in this case? It does it
for almost all other tests that i can find, and the firewall does not
drop any traffic.  Only when the DNS ID does not increment does this
problem occur.  This does not seem to always be the default behavior.  I
wrote a small C program to just put a gethostbyname_r() in a for loop
and each DNS ID is incremented all 40 times.  But there are times when
this doesnt happen, and this seems to be what is causing the issue.  The
firewall needs some sort of identifier to know which dns request is
associated with which dns reply (source ip, source port, ID). 

this is the behavior I am trying to debug.

thanks
adam

Please CC me as i am not on the list.


On Wed, 2004-12-15 at 14:07, Jan Harkes wrote:
> On Wed, Dec 15, 2004 at 09:16:02AM -0500, Adam Denenberg wrote:
> > the Firewall from distinguishing unique dns requests.  It sees a second
> > DNS request come from the linux server with the _same_ transaction ID in
> > the UDP header as it is marking that session closed since it already saw
> > the reply successfully.  So for example the linux server is making a dns
> 
> Stupid guess here,
> 
> The reply got dropped after it passed your firewall and before it
> reached the linux server. What you are seeing is simply a retransmit
> which would also have happened if the original request got lost, or if
> the reply was dropped before it reached your firewall, in which case the
> firewall probably would have forwarded the retransmitted request without
> a problem.
> 
> I would open the window before you throw the piece of garbage out.
> 
> Jan
> 

