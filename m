Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317025AbSGNShj>; Sun, 14 Jul 2002 14:37:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317026AbSGNShi>; Sun, 14 Jul 2002 14:37:38 -0400
Received: from ns.suse.de ([213.95.15.193]:27154 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S317025AbSGNShh>;
	Sun, 14 Jul 2002 14:37:37 -0400
To: dean gaudet <dean-list-linux-kernel@arctic.org>
Cc: linux-kernel@vger.kernel.org, davem@redhat.com
Subject: Re: [BUG?] unwanted proxy arp in 2.4.19-pre10
References: <20020713.205930.101495830.davem@redhat.com.suse.lists.linux.kernel> <Pine.LNX.4.44.0207141026440.4252-100000@twinlark.arctic.org.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 14 Jul 2002 20:40:23 +0200
In-Reply-To: dean gaudet's message of "14 Jul 2002 19:33:04 +0200"
Message-ID: <p73lm8eup9k.fsf@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dean gaudet <dean-list-linux-kernel@arctic.org> writes:

> On Sat, 13 Jul 2002, David S. Miller wrote:
> 
> >
> > You have to use specific source-routing settings in conjuntion with
> > enabling arp_filter in order for arp_filter to have any effect.
> >
> > This is a FAQ.
> 
> a couple google queries yielded no answer to this faq... is there a posted
> example somewhere?

arpfilter normally needs no special routing entries, unless you want
to do weird things (like filtering ARP based on source). The main use
of arp filter is to prevent multiple arp answers on multiple devices
when the host has more than one interface to the same network. The other
use is to allow load balancing for incoming connections together 
with multi path routing.

It can be abused for more complex filtering scenaries:

The arpfilter routing decision takes the reversed address tuple in account.
When the routing decision yields the device that the ARP arrived on
then the ARP is answered otherwise not.
You can construct policy routing rules that match the ARP requests you
want to prevent with some tricks, but do not match outgoing packets.
Easy? It's not easy, but nobody said it was.

The main use of this seem to be certain HA failover setups.
Some people use a patch that allows to disable ARP per interface for it
("hidden") but for some reasons it was not integrated. 

> 
> is the default behaviour of use to anyone?  this question comes up like
> every other month.

It would be likely easier/more straightforward if there was a special
ARP routing table that is only consulted by ARP filter (as an extension 
to the current multi table routing). Then you could just put reject routes
there to filter ARP Unfortunately nobody has stepped forward to implement it
yet, so it remained a dream so far.

Another thing that was implemented is a netfilter chain for ARP, but
afaik there are no filtering modules for it yet, so Joe User cannot
use it. It likely just exists somewhere as a proprietary module in
someone's firewall appliance and all they did was to contribute the
hook. It probably would not be hard to rewrite a filter module for it,
but again nobody did it yet.

Hope this helps,

-Andi

