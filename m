Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310420AbSCBSn0>; Sat, 2 Mar 2002 13:43:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310417AbSCBSnQ>; Sat, 2 Mar 2002 13:43:16 -0500
Received: from trillium-hollow.org ([209.180.166.89]:15293 "EHLO
	trillium-hollow.org") by vger.kernel.org with ESMTP
	id <S310415AbSCBSm5>; Sat, 2 Mar 2002 13:42:57 -0500
To: Julian Anastasov <ja@ssi.bg>
cc: Szekeres Bela <szekeres@lhsystems.hu>,
        Daniel Gryniewicz <dang@fprintf.net>,
        linux-kernel <linux-kernel@vger.kernel.org>, erich@uruk.org
Subject: Network Security hole (was -> Re: arp bug )
In-Reply-To: Your message of "Tue, 08 Jan 2002 23:33:40 GMT."
             <Pine.LNX.4.33.0201082201020.1204-100000@u.domain.uli> 
Date: Sat, 02 Mar 2002 10:42:20 -0800
From: erich@uruk.org
Message-Id: <E16hESa-0000Gn-00@trillium-hollow.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[My apologies for getting into this thread rather late, but I just
 came across this on a network I'm working with which is all on the
 same switch/VLAN...  I had 2 network  cards per machine and was
 puzzled why traffic destined for one interface went to the other]

Julian Anastasov <ja@ssi.bg> wrote:

> Szekeres Bela wrote:
> 
> > I've seen a similar bug in 2.2.19 (and a lot of 2.2-s, I've not checked it in
> > the 2.4 series).
> 
> 	In your case
> 
> > --------------------------- 10.1.0.0 (tr)
> >   |.1       |.2
> >  BOX1      BOX2      BOX3
> >   |.1       |.2       |.3
> > --------------------------- 10.2.0.0 (eth)
> 
> 	it is a feature, may be not fully utilized without using
> alternative link routes. At least, I don't know for any standard
> that is not followed from this feature. IMO, the following fix
> is more correct:
> 
> 01_arp_prefsrc-2.2.19-4.diff
> or
> 01_arp_prefsrc-2.4.12-5.diff
> from
> http://www.linuxvirtualserver.org/~julian/#routes
> 
> its main usage is for devices attached to same medium but should
> work for your case too. It always uses the preferred source IP
> to the target because any local IP addresses announced in our probes
> are updated in the remote ARP caches and in some cases it is not
> the desired behavior. Even the Linux's rp_filter protection can't
> avoid the ARP cache entry update. It could be a "problem" when BOX2 uses
> devices attached to same medium. Other users are happy with such
> feature because if eth0 fails may be eth1 still have link to the
> same hub, for example.


This is *not* a feature, it is a major security hole.

Let's say you have a firewall running Linux.  Oops, I can spoof the
external interface to accept traffic as if it's the internal one.

I may have screwed up my test, but it looks like it just worked on
my RedHat 7.2 based most recent 2.4.9-21 kernel on my firewall!!

This is Not Good.

You can imagine, I just added the proc command to shut it off to
my setup.

I'm not sure (haven't checked it yet), but I would guess that
there still may be a hole here (and in my config) where a machine
on the same network could craft packets that will get accepted
by my machine even though it doesn't respond to arps on that
interface any more.

I.e. the machine still may be accepting traffic destined for one
interface on another, even though it won't *advertise* that fact
any more.

If so, this is yet another bug which is dangerous in configs
like firewalls.


The fact that you have to manually turn this off is insane.  I must
admit to being kind of angry that it was considered a "feature"
when discovered, and left in.

Am I the only one that saw this kind of scary hole?

These kind of "features" that cause weird behavior should always
be turned off by default, else corner cases like this sometimes
pop up.

Sorry about the mild flameage here, but this does make me wonder what
other "features" there are that might be exploitable.


--
    Erich Stefan Boleyn     <erich@uruk.org>     http://www.uruk.org/
"Reality is truly stranger than fiction; Probably why fiction is so popular"
