Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262442AbSJIWl1>; Wed, 9 Oct 2002 18:41:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262443AbSJIWl0>; Wed, 9 Oct 2002 18:41:26 -0400
Received: from edinburgh.cisco.com ([144.254.112.76]:51112 "EHLO cisco.com")
	by vger.kernel.org with ESMTP id <S262442AbSJIWir>;
	Wed, 9 Oct 2002 18:38:47 -0400
Date: Wed, 9 Oct 2002 23:44:21 +0100
From: Derek Fawcus <dfawcus@cisco.com>
To: Yuji Sekiya <sekiya@sfc.wide.ad.jp>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com, usagi@linux-ipv6.org
Subject: Re: [PATCH] IPv6: Fix Prefix Length of Link-local Addresses
Message-ID: <20021009234421.J29133@edinburgh.cisco.com>
References: <20021008.000559.17528416.yoshfuji@linux-ipv6.org> <20021009170018.H29133@edinburgh.cisco.com> <uwuor9tg7.wl@sfc.wide.ad.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <uwuor9tg7.wl@sfc.wide.ad.jp>; from sekiya@sfc.wide.ad.jp on Thu, Oct 10, 2002 at 06:46:16AM +0900
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 10, 2002 at 06:46:16AM +0900, Yuji Sekiya wrote:
> At Wed, 9 Oct 2002 17:00:18 +0100,
> Derek Fawcus <dfawcus@cisco.com> wrote:
> 
> > Without reading the kernel routing table code a bit more,  I'm not certain
> > what that change does,  but it looks as if it might be changing the
> > connected route for a link local from fe80::/10 to fe80::/64.
> 
> Why do you want to use /10 prefix for link-local address ?
> RFC2373 defines link-local address format as below.

It also states that all fe80::/10 are link local and all fec0:/10 are
site local (sect 2.4)

>    |   10     |
>    |  bits    |        54 bits          |          64 bits           |
>    +----------+-------------------------+----------------------------+
>    |1111111010|           0             |       interface ID         |
>    +----------+-------------------------+----------------------------+

and for site local it says use the following:

   |   10     |
   |  bits    |   38 bits   |  16 bits  |         64 bits            |
   +----------+-------------+-----------+----------------------------+
   |1111111011|    0        | subnet ID |       interface ID         |
   +----------+-------------+-----------+----------------------------+

whereas draft-ietf-ipngwg-addr-arch-v3-10.txt says:

   |   10     |
   |  bits    |         54 bits         |         64 bits            |
   +----------+-------------------------+----------------------------+
   |1111111011|        subnet ID        |       interface ID         |
   +----------+-------------------------+----------------------------+

So we've already changed what is recommended in the top bits for site
local,  if someone can think of a use for the top bits in link local
they'll probably be defined.  (Do you arbitrarily restrict the bits
in site local addresses?)

However link locals are a bit different.  Once you have matched fe80:/10
then by definition the rest of the address specifies a directly
connected neighbour.  As that's what link locals are - host routes
to directly connected neighbours.  There isn't really a connected
prefix as such,  that is only there to trigger ND.

Making a restriction that all link local neighbour entries have to match
fe80::/64 rather than the full fe80::/10 is pointless,  it gains nothing
and makes an arbitrary restriction for no real purpose.

> > All link local's are currently supposed to have those top bits
> > ('tween 10 and 64) zero'd,  however any address within the link local
> > prefix _is_ on link / connected and should go to the interface.
> 
> If you wan to use /10 prefix for link-local address, you can add the
> link-local address with /10 prefix to interfaces and routing table
> manually at your own risk, but it should not  be a default behavior.

My point is that it isn't really a route.  Once you've matched fe80::/10
then you know that you've got a link local address,  and you switch
to looking up a connected neighbour entry in the conceptual neighbour
cache.

Other than allowing the use of the whole address field,  the only
difference in behaviour between the two forms would possibly
be in the type of ICMPv6 error generated for a non existant neighbour
addressed by a link local with those high bits set.

If the prefix to match link locals is /10 then type 1 code 3 would
be generated,  whereas if /64 is used (together with a /10 drop) then
type 1 code 0 would be generated.

Anyway,  I'll not bother following up again in this thread.

If you don't see the point,  then forget it.

DF
