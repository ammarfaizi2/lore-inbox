Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261803AbULOCXv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261803AbULOCXv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 21:23:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261804AbULOCXv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 21:23:51 -0500
Received: from bigeats.dufftech.com ([69.57.156.29]:23189 "HELO
	bigeats.dufftech.com") by vger.kernel.org with SMTP id S261803AbULOCXr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 21:23:47 -0500
In-Reply-To: <8AF1BC56-4E1C-11D9-B94B-000393ACC76E@mac.com>
References: <1103038728.10965.12.camel@sucka> <Pine.LNX.4.61.0412141700430.24308@yvahk01.tjqt.qr> <1103042538.10965.27.camel@sucka> <Pine.LNX.4.61.0412141742590.22148@yvahk01.tjqt.qr> <1103043716.10965.40.camel@sucka> <8AF1BC56-4E1C-11D9-B94B-000393ACC76E@mac.com>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <57782EC8-4E40-11D9-B971-003065B11AE8@dberg.org>
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, Jan Engelhardt <jengelh@linux01.gwdg.de>
From: Adam Denenberg <adam@dberg.org>
Subject: Re: bind() udp behavior 2.6.8.1
Date: Tue, 14 Dec 2004 21:23:43 -0500
To: Kyle Moffett <mrmacman_g4@mac.com>
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i think you guys are all right.  However there is one concern.  Not 
clearing out a UDP connection in a firewall coming from a high port is 
indeed a security risk.  Allowing a high numbered udp port to remain 
open for a prolonged period of time would definitely impose a security 
risk which is why the PIX is doing what it does.  The linux server is 
"reusing" the same UDP high numbered socket however it is doing so 
exactly as the firewall is clearing its state table (60 ms) from the 
first connection which is what is causing the issue.

I think a firewall ought to be aware of such behavior, but at the same 
time be secure enough to not just leave high numbered udp ports wide 
open for attack.  I am trying to find out why the PIX chose 60 ms to 
clear out the UDP state table.  I think that is a random number and 
probably too short of a span for this to occur however i am still 
researching it.

Any other insight would be greatly appreciated.

adam

On Dec 14, 2004, at 5:07 PM, Kyle Moffett wrote:

> On Dec 14, 2004, at 12:01, Adam Denenberg wrote:
>> any firewall must keep some sort of state table even if it is udp.  
>> How
>> else do you manage established connections?  It must know that some 
>> high
>> numbered port is making a udp dns request, and thus be able to allow
>> that request back thru to the high numbered port client b/c the
>> connection is already established.
>>
>> what does any fireawall do if it sees one ip with the same high 
>> numbered
>> udp port make a request in a _very_ short amount of time (under 60ms 
>> for
>> this example)?  It must make a distintion between an attack and legit
>> traffic.  So if it sees one ip/port make multiple requests in too 
>> short
>> of a time frame, it will drop the traffic, as it probably should.  
>> This
>> is causing erratic behavior when traffic traverses the firewall b/c 
>> the
>> linux kernel keeps allocating the same source high numbered ephemeral
>> port.  I would like to know if there is a way to alter this behavior 
>> b/c
>> it is breaking applications.
>
> When I wrote my user-space UDP over TCP tunneling software, I combined
> the Internal IP and port and the External IP and port into a single 
> hashed
> value that I used as an index into my "psuedo-connection" hash, of 
> which
> each entry referenced an index in my 2000 item "pseudo-connection" 
> table.
> For each packet from an unrecognized host, I added a new hash entry and
> table entry, then forwarded the packet.  When I get a new packet 
> matching
> an old-but-not-expired rule, I set the "last_seen" value to the 
> current time.
> When a connection is 5 minutes since "last_seen", then it can be 
> removed
> if there is pressure on the table, otherwise it will accept packets 
> until it is
> 1 hour old, at which point it gets purged.  I've found that this 
> system works
> well at tunneling everything from Kerberos and OpenAFS to DNS without
> problems.  Given that this relatively simple piece of sofware is able 
> to
> successfully manage a multitude of UDP connections, I would suggest
> that an advanced connection-tracking firewall like yours has serious 
> bugs
> if it can't perform equally well.  Either that or it shouldn't be 
> meddling in the
> affairs of such UDP packets.
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

