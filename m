Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261835AbSIXWeF>; Tue, 24 Sep 2002 18:34:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261836AbSIXWeF>; Tue, 24 Sep 2002 18:34:05 -0400
Received: from mta04bw.bigpond.com ([139.134.6.87]:7121 "EHLO
	mta04bw.bigpond.com") by vger.kernel.org with ESMTP
	id <S261835AbSIXWeD>; Tue, 24 Sep 2002 18:34:03 -0400
From: Brad Hards <bhards@bigpond.net.au>
To: Tim Hockin <thockin@sun.com>, Jeff Garzik <jgarzik@pobox.com>
Subject: Re: alternate event logging proposal
Date: Wed, 25 Sep 2002 08:32:34 +1000
User-Agent: KMail/1.4.5
Cc: Chris Friesen <cfriesen@nortelnetworks.com>,
       Rusty Russell <rusty@rustcorp.com.au>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       cgl_discussion mailing list <cgl_discussion@osdl.org>,
       evlog mailing list <evlog-developers@lists.sourceforge.net>,
       "ipslinux (Keith Mitchell)" <ipslinux@us.ibm.com>,
       Linus Torvalds <torvalds@home.transmeta.com>,
       Hien Nguyen <hien@us.ibm.com>, James Keniston <kenistoj@us.ibm.com>,
       Mike Sullivan <sullivam@us.ibm.com>
References: <20020924073051.363D92C1A7@lists.samba.org> <3D90C4FE.3070909@pobox.com> <3D90D0FB.1070805@sun.com>
In-Reply-To: <3D90D0FB.1070805@sun.com>
MIME-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200209250832.35068.bhards@bigpond.net.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Wed, 25 Sep 2002 06:54, Tim Hockin wrote:
> Jeff Garzik wrote:
> > In existing drivers that call netif_carrier_{on,off}, it is perhaps even
> > possible to have them send netlink messages with no driver-specific code
> > changes at all.
>
> This is something that I have been asked to look at, here.  Jeff, how
> (or is?) any of the netlink info pushed up to userspace?  The idea that
> someone came to me with was to have something in (driverfs? netdevfs?)
> that was poll()able and read()able.  read() giving current state, and
> poll() waking on changes.  Or maybe two different files, but something.
>   Of course it'd be greate to be generic.  I just assumed it would come
> from netif_* for netdevices.
>
> Is this something planned?  wanted?  something I should bang out into
> 2.5.x before end of next month?
Wanted.
Example: In desktop / consumer applications, you can use link-state change to 
do things like invoke the DHCP client daemon, or get yourself a link-local IP 
address.

> We could have a generic device-events file (akin to acpi events) that a
> daemon dispatches events into user-land, or we could have a kernel->user
> callback a la /sbin/hotplug, or we could have many device/subsys
> specific files.
>
> Anyone have a preference?
I liked the /sbin/hotplug arrangement (aka call_usermode_helper). In fact, my 
plan was to add the call_usermode_helper call to the netif_carrier_[on,off] 
functions. Unfortuantely, I've been to too many of Rusty's talks, and know 
that calling a function that is only safe in user context is unlikely to be a 
good idea in netif_carrier_[on,off], which are more than likely running in 
interrupt context.

Conceptually, I don't see (hot-plugging) a CAT-5 cable into a NIC to be that 
much different (from a userland view) to plugging the NIC into the PCI bus.

My big problem is that I am clueless, and call_usermode_helper isn't nice 
code. If someone in kernel-land could make call_usermode_helper safe in 
interrupt context, at least link-state reporting would be fairly trivial. It 
shouldn't be that hard - it's already using keventd. I just have no idea 
about clone_thread and stuff like that.

Brad

- -- 
http://conf.linux.org.au. 22-25Jan2003. Perth, Aust. Tickets booked.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9kOgDW6pHgIdAuOMRAqojAJ0aiXkHtK0eo6/1Bg+Yo8zSzBCMSQCfXK0x
5CSmDWhwRiamJwttaxF6Eac=
=hqKf
-----END PGP SIGNATURE-----

