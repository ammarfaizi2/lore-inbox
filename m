Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288393AbSAHVbr>; Tue, 8 Jan 2002 16:31:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288432AbSAHVbh>; Tue, 8 Jan 2002 16:31:37 -0500
Received: from ja.mac.ssi.bg ([212.95.166.194]:25860 "EHLO u.domain.uli")
	by vger.kernel.org with ESMTP id <S288428AbSAHVbP>;
	Tue, 8 Jan 2002 16:31:15 -0500
Date: Tue, 8 Jan 2002 23:33:40 +0000 (GMT)
From: Julian Anastasov <ja@ssi.bg>
X-X-Sender: <ja@u.domain.uli>
To: Szekeres Bela <szekeres@lhsystems.hu>
cc: linux-kernel <linux-kernel@vger.kernel.org>,
        Daniel Gryniewicz <dang@fprintf.net>
Subject: Re: arp bug
Message-ID: <Pine.LNX.4.33.0201082201020.1204-100000@u.domain.uli>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Hello,

Szekeres Bela wrote:

> I've seen a similar bug in 2.2.19 (and a lot of 2.2-s, I've not checked it in
> the 2.4 series).

	In your case

> --------------------------- 10.1.0.0 (tr)
>   |.1       |.2
>  BOX1      BOX2      BOX3
>   |.1       |.2       |.3
> --------------------------- 10.2.0.0 (eth)

	it is a feature, may be not fully utilized without using
alternative link routes. At least, I don't know for any standard
that is not followed from this feature. IMO, the following fix
is more correct:

01_arp_prefsrc-2.2.19-4.diff
or
01_arp_prefsrc-2.4.12-5.diff
from
http://www.linuxvirtualserver.org/~julian/#routes

its main usage is for devices attached to same medium but should
work for your case too. It always uses the preferred source IP
to the target because any local IP addresses announced in our probes
are updated in the remote ARP caches and in some cases it is not
the desired behavior. Even the Linux's rp_filter protection can't
avoid the ARP cache entry update. It could be a "problem" when BOX2 uses
devices attached to same medium. Other users are happy with such
feature because if eth0 fails may be eth1 still have link to the
same hub, for example.

> In my case BOX1 is a NetWare, which caches all the arp queries it sees, which
> produced a very interesting arp table in BOX1...

	It seems NetWare is different than Linux in this handling.
Linux does not create new entries in the ARP cache. But even if they
are created (in NetWare) I can't believe they are used (I hope
the ARP entry is looked up by IP and outdev, not only by IP).

	But note that:

- BOX2 is right to announce 10.1.0.2 through the eth device because
it can accept traffic to 10.1.0.2 from any device. At least, it
depends on the sender's address and the rp_filter values in BOX2.
You should be able to talk with 10.1.0.2 through the eth device
from any host attached to the same eth device.

- BOX1 can decide through which device to talk with BOX2, may be
in your case it is set to accept traffic from the both devices
but to send only through one of them (similar to rp_filter=0 in
Linux). You need alternative link routes to allow sending through
the both devices but may be that is not your goal.

So, where in fact is the problem without applying any patches?
May be there is no problem? Or NetWare has a problem to create
new ARP entries and even to use them?

	As for the Daniel's problem I don't understand where is
the link route created for the 10.128.0.0/9 network ? Or may be the key
is to have the right preferred source IP address for all routes?:

ip route add ... src PREFSRC

Regards

--
Julian Anastasov <ja@ssi.bg>

