Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287979AbSBDAeG>; Sun, 3 Feb 2002 19:34:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288005AbSBDAd6>; Sun, 3 Feb 2002 19:33:58 -0500
Received: from mailhost.cs.tamu.edu ([128.194.130.106]:48571 "EHLO cs.tamu.edu")
	by vger.kernel.org with ESMTP id <S287979AbSBDAdn>;
	Sun, 3 Feb 2002 19:33:43 -0500
Date: Sun, 3 Feb 2002 18:33:41 -0600 (CST)
From: Xinwen - Fu <xinwenfu@cs.tamu.edu>
To: Rob Landley <landley@trommello.org>
cc: linux-kernel@vger.kernel.org
Subject: SOCK_PACKET bypasses IPTABLES queue?
In-Reply-To: <20020203221438.NAPP25931.femail13.sdc1.sfba.home.com@there>
Message-ID: <Pine.SOL.4.10.10202031831480.25367-100000@dogbert>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rob,
	Another problem:
	Will a packet from SOCK_PACKET socket bypass all the queues of
IPTABLES?

	Thanks!
	

Xinwen Fu


On Sun, 3 Feb 2002, Rob Landley wrote:

> On Sunday 03 February 2002 01:45 pm, Xinwen - Fu wrote:
> > Hi, All,
> >
> > 	I want  to know how a raw packet passes the chain of iptables.
> >
> > 	Here are the iptables chains
> >
> > --->PRE------>[ROUTE]--->FWD---------->POST------>
> >         Conntrack    |       Filter   ^    NAT (Src)
> >         Mangle       |                |    Conntrack
> >         NAT (Dst)    |             [ROUTE]
> >         (QDisc)      v                |
> >                      IN Filter       OUT Conntrack
> >
> >                      |  Conntrack     ^  Mangle
> >                      |
> >                      |                |  NAT (Dst)
> >
> >                      v                |  Filter
> >
> >
> > 	So how a raw packet go through these chains?
> 
> 
> Well, from trial and error and a lot of documentation reading, I eventually 
> worked out that a TCP/IP packet basically seems to do this:
> 
> --->pre--->forward--->post--->
>      |                           ^
>      |                           |
>      v                          |
>      input->local ports->output
> 
> I'd like to point out that the last arrow should point from "output" to 
> "post", since kmail apparently is not using a fixed with font, and I can't 
> figure out how to get it to do so.  (I did figure out how to get it to use a 
> korean, chinese, or cyrillic encoding, but not monospaced.  Sigh...)
> 
> So in prerouting, the packet is either forwarded on to the forwarding chain 
> (if it's not for this box) or to the input chain (if it's for a daemon on 
> this box).  Forwarding never sees packets locally generated on this box, they 
> go into the output chain and then get sent on to postrouting (which is where 
> forwarding also feeds into).
> 
> It took a little trial and error to work this out, by the way.  It's entirely 
> ossibly I'm wrong (since I don't think the above agrees with the 
> documentation), but at the same time it works and survives specific behavior 
> testing, so... :)  The tables are fairly arbitrarily broken into "NAT" tables 
> and non-NAT tables.  Oh, and one of the chains (output, I think) exists in 
> both nat and non-nat versions.  To this day, I have no idea why...
> 
> > 	Thanks!!
> >
> > Xinwen Fu
> 
> If the above doesn't help, this might:
> 
> http://netfilter.samba.org/unreliable-guides/
> 
> Rob
> 

