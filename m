Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261937AbULPPAb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261937AbULPPAb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 10:00:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262675AbULPPAb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 10:00:31 -0500
Received: from bigeats.dufftech.com ([69.57.156.29]:51358 "HELO
	bigeats.dufftech.com") by vger.kernel.org with SMTP id S261937AbULPPAM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 10:00:12 -0500
In-Reply-To: <20041216145138.GB8150@delft.aura.cs.cmu.edu>
References: <Pine.LNX.4.61.0412141700430.24308@yvahk01.tjqt.qr> <1103042538.10965.27.camel@sucka> <Pine.LNX.4.61.0412141742590.22148@yvahk01.tjqt.qr> <1103043716.10965.40.camel@sucka> <8AF1BC56-4E1C-11D9-B94B-000393ACC76E@mac.com> <57782EC8-4E40-11D9-B971-003065B11AE8@dberg.org> <20F668EE-4E48-11D9-B94B-000393ACC76E@mac.com> <1103120162.5517.14.camel@sucka> <20041215190725.GA24635@delft.aura.cs.cmu.edu> <444EB40D-4F6E-11D9-91A1-003065B11AE8@dberg.org> <20041216145138.GB8150@delft.aura.cs.cmu.edu>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <2ED48933-4F73-11D9-91A1-003065B11AE8@dberg.org>
Content-Transfer-Encoding: 7bit
Cc: Kyle Moffett <mrmacman_g4@mac.com>, linux-kernel@vger.kernel.org,
       Jan Engelhardt <jengelh@linux01.gwdg.de>
From: Adam Denenberg <adam@dberg.org>
Subject: Re: bind() udp behavior 2.6.8.1
Date: Thu, 16 Dec 2004 10:00:10 -0500
To: Jan Harkes <jaharkes@cs.cmu.edu>
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok thanks for all the help.

One final note before i end this (since there still seems to be some 
misunderstanding) is that the reply comes back successful for the first 
of the 2 redundant transaction IDs.  Its not a retransmit.  ID 101 gets 
sent from the linux box and receives a response successfully.  It then 
sends another reqeust with ID 101 _after_ it received the response for 
101.  That is my issue and that is what is breaking the communication 
thru the firewall.  It should be using a new ID after a successful dns 
transaction but it is not.

I understand this has deviated from the topic of the linux kernel so we 
can consider this thread dead.

thanks everybody for all their input and help.

adam

On Dec 16, 2004, at 9:51 AM, Jan Harkes wrote:

> On Thu, Dec 16, 2004 at 09:24:59AM -0500, Adam Denenberg wrote:
>> I disagree.  The linux server should be using unique Transaction ID's
>> in the dns header for each unique dns request.  Otherwise there is no
>> way to distinguish them (same A record request).  Of course the
>> firewall is going to drop a reply that it thinks it already saw a 
>> reply
>> for 30ms ago.
>>
>> This appears to be a bug in the way glibc is handling things but i
>> cannot be sure.  That is the goal of my investigation.
>
> Ok, please stop it and _read_ the email, completely, a possible 
> solution
> will be at the end.
>
> This is not a problem with the linux kernel, the application (resolver
> library) is simply retransmitting the request and the kernel does
> exactly as it is told. So first of all this is completely off-topic for
> linux-kernel.
>
> Second of all, it is -not- a glibc issue either. The reply packet was
> probably lost after it has passed through the firewall but before it
> reached the DNS client machine. So since it has not yet received the
> response it is doing the right thing, retransmitting the request.
>
> The problem is... your firewall, it seems to assume that once it has
> seen a UDP reply packet that this packet will reach the destination and
> the session is closed. This is an incorrect assumption since UDP is per
> definition a lossy protocol (unreliable datagram protocol) and the
> packet can and will be dropped by any routers, switches, the network
> card in your machine, or even by the kernel if there is too much
> traffic or a single bit error which makes the checksum fail.
>
> One solution that might work is to run a local caching DNS daemon on a
> machine behind the firewall (bind, dnsmasq or something) and set
> /etc/resolv.conf to only send requests to the local machine. The local
> caching daemon can then forward those requests from a known fixed local
> port to your upstream DNS servers. This allows you to open a hole in 
> the
> firewall between local_dns_cache:53 and upstream_dns_server:53.
>
> Jan
>

