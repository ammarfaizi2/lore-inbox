Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262351AbULOOQO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262351AbULOOQO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 09:16:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262353AbULOOQO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 09:16:14 -0500
Received: from bigeats.dufftech.com ([69.57.156.29]:43158 "HELO
	bigeats.dufftech.com") by vger.kernel.org with SMTP id S262351AbULOOQG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 09:16:06 -0500
Subject: Re: bind() udp behavior 2.6.8.1
From: Adam Denenberg <adam@dberg.org>
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: linux-kernel@vger.kernel.org, Jan Engelhardt <jengelh@linux01.gwdg.de>
In-Reply-To: <20F668EE-4E48-11D9-B94B-000393ACC76E@mac.com>
References: <1103038728.10965.12.camel@sucka>
	 <Pine.LNX.4.61.0412141700430.24308@yvahk01.tjqt.qr>
	 <1103042538.10965.27.camel@sucka>
	 <Pine.LNX.4.61.0412141742590.22148@yvahk01.tjqt.qr>
	 <1103043716.10965.40.camel@sucka>
	 <8AF1BC56-4E1C-11D9-B94B-000393ACC76E@mac.com>
	 <57782EC8-4E40-11D9-B971-003065B11AE8@dberg.org>
	 <20F668EE-4E48-11D9-B94B-000393ACC76E@mac.com>
Content-Type: text/plain
Message-Id: <1103120162.5517.14.camel@sucka>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 15 Dec 2004 09:16:02 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i have some more updated information for this.  It seems that linux is
generating a duplicate transaction ID in the udp header in the dns query
when making a dns request.  This piece seems to be what is preventing
the Firewall from distinguishing unique dns requests.  It sees a second
DNS request come from the linux server with the _same_ transaction ID in
the UDP header as it is marking that session closed since it already saw
the reply successfully.  So for example the linux server is making a dns
query with DNS Transaction ID 0x598d, then a response comes back with ID
0x598d, and then another query gets sent out with ID 0x598d.  When that
second response comes back, the firewall gets confused b/c it is in the
middle of closing the original 0x598d session and thus drops the packet,
causing a DNS timeout.

 Why is linux generating a redundant transaction ID in the dns header
here?  The first 2 requests have incremented values, but then for some
reason the third seems to have the same value which is causing issues. 
Has anyone encountered this behavior?

thanks again
adam

Please CC me i am not on the list.




On Tue, 2004-12-14 at 22:19, Kyle Moffett wrote:
> On Dec 14, 2004, at 21:23, Adam Denenberg wrote:
> > i think you guys are all right.  However there is one concern.  Not 
> > clearing out a UDP connection in a firewall coming from a high port is 
> > indeed a security risk.  Allowing a high numbered udp port to remain 
> > open for a prolonged period of time would definitely impose a security 
> > risk which is why the PIX is doing what it does.  The linux server is 
> > "reusing" the same UDP high numbered socket however it is doing so 
> > exactly as the firewall is clearing its state table (60 ms) from the 
> > first connection which is what is causing the issue.
> >
> > I think a firewall ought to be aware of such behavior, but at the same 
> > time be secure enough to not just leave high numbered udp ports wide 
> > open for attack.  I am trying to find out why the PIX chose 60 ms to 
> > clear out the UDP state table.  I think that is a random number and 
> > probably too short of a span for this to occur however i am still 
> > researching it.
> >
> > Any other insight would be greatly appreciated.
> 
> 60ms is certainly _way_ too small for most UDP traffic.  With something 
> like
> that, OpenAFS would die almost immediately.  I think the current OpenAFS
> minimum is like 20 minutes, although somebody patched the OpenAFS
> source to send a keepalive every 5 minutes, so it could be reduced.  
> OTOH,
> sending a keepalive every 60ms would take a _massive_ amount of
> bandwidth even for one client, think about a couple hundred :-D.  Heck, 
> I've
> even seen pings on a regular basis that take longer than 60ms, which
> means that even an infinitely fast kerberos server wouldn't respond 
> quickly
> enough :-D.
> 
> Cheers,
> Kyle Moffett
> 
> -----BEGIN GEEK CODE BLOCK-----
> Version: 3.12
> GCM/CS/IT/U d- s++: a18 C++++>$ UB/L/X/*++++(+)>$ P+++(++++)>$
> L++++(+++) E W++(+) N+++(++) o? K? w--- O? M++ V? PS+() PE+(-) Y+
> PGP+++ t+(+++) 5 X R? tv-(--) b++++(++) DI+ D+ G e->++++$ h!*()>++$ r  
> !y?(-)
> ------END GEEK CODE BLOCK------
> 
> 

