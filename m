Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261698AbULNWLC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261698AbULNWLC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 17:11:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261702AbULNWJm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 17:09:42 -0500
Received: from lakermmtao07.cox.net ([68.230.240.32]:37320 "EHLO
	lakermmtao07.cox.net") by vger.kernel.org with ESMTP
	id S261698AbULNWHb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 17:07:31 -0500
In-Reply-To: <1103043716.10965.40.camel@sucka>
References: <1103038728.10965.12.camel@sucka> <Pine.LNX.4.61.0412141700430.24308@yvahk01.tjqt.qr> <1103042538.10965.27.camel@sucka> <Pine.LNX.4.61.0412141742590.22148@yvahk01.tjqt.qr> <1103043716.10965.40.camel@sucka>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <8AF1BC56-4E1C-11D9-B94B-000393ACC76E@mac.com>
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, Jan Engelhardt <jengelh@linux01.gwdg.de>
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: bind() udp behavior 2.6.8.1
Date: Tue, 14 Dec 2004 17:07:28 -0500
To: Adam Denenberg <adam@dberg.org>
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Dec 14, 2004, at 12:01, Adam Denenberg wrote:
> any firewall must keep some sort of state table even if it is udp.  How
> else do you manage established connections?  It must know that some 
> high
> numbered port is making a udp dns request, and thus be able to allow
> that request back thru to the high numbered port client b/c the
> connection is already established.
>
> what does any fireawall do if it sees one ip with the same high 
> numbered
> udp port make a request in a _very_ short amount of time (under 60ms 
> for
> this example)?  It must make a distintion between an attack and legit
> traffic.  So if it sees one ip/port make multiple requests in too short
> of a time frame, it will drop the traffic, as it probably should.  This
> is causing erratic behavior when traffic traverses the firewall b/c the
> linux kernel keeps allocating the same source high numbered ephemeral
> port.  I would like to know if there is a way to alter this behavior 
> b/c
> it is breaking applications.

When I wrote my user-space UDP over TCP tunneling software, I combined
the Internal IP and port and the External IP and port into a single 
hashed
value that I used as an index into my "psuedo-connection" hash, of which
each entry referenced an index in my 2000 item "pseudo-connection" 
table.
For each packet from an unrecognized host, I added a new hash entry and
table entry, then forwarded the packet.  When I get a new packet 
matching
an old-but-not-expired rule, I set the "last_seen" value to the current 
time.
When a connection is 5 minutes since "last_seen", then it can be removed
if there is pressure on the table, otherwise it will accept packets 
until it is
1 hour old, at which point it gets purged.  I've found that this system 
works
well at tunneling everything from Kerberos and OpenAFS to DNS without
problems.  Given that this relatively simple piece of sofware is able to
successfully manage a multitude of UDP connections, I would suggest
that an advanced connection-tracking firewall like yours has serious 
bugs
if it can't perform equally well.  Either that or it shouldn't be 
meddling in the
affairs of such UDP packets.

Cheers,
Kyle Moffett

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCM/CS/IT/U d- s++: a18 C++++>$ UB/L/X/*++++(+)>$ P+++(++++)>$
L++++(+++) E W++(+) N+++(++) o? K? w--- O? M++ V? PS+() PE+(-) Y+
PGP+++ t+(+++) 5 X R? tv-(--) b++++(++) DI+ D+ G e->++++$ h!*()>++$ r  
!y?(-)
------END GEEK CODE BLOCK------


