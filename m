Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130984AbQLJNwv>; Sun, 10 Dec 2000 08:52:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131169AbQLJNwm>; Sun, 10 Dec 2000 08:52:42 -0500
Received: from isis.its.uow.edu.au ([130.130.68.21]:28395 "EHLO
	isis.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S130984AbQLJNwe>; Sun, 10 Dec 2000 08:52:34 -0500
Message-ID: <3A33845F.9FB3EE81@uow.edu.au>
Date: Mon, 11 Dec 2000 00:25:51 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0-test8 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@mandrakesoft.com>
CC: David Brownell <david-b@pacbell.net>, lkml <linux-kernel@vger.kernel.org>,
        "linux-usb-devel@lists.sourceforge.net" 
	<linux-usb-devel@lists.sourceforge.net>,
        Linus Torvalds <torvalds@transmeta.com>,
        "David S. Miller" <davem@redhat.com>
Subject: Re: hotplug mopup
In-Reply-To: <3A3377B3.FDCBE4AD@uow.edu.au> <3A337DF1.DD9516C7@mandrakesoft.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> 
> Andrew Morton wrote:
> > - On the unregister/removal path, the netdevice layer ensures that
> >   the interface is removed from the kernel namespace prior to launching
> >   `/sbin/hotplug net unregister eth0'.
> >
> >   This means that when handling netdevice unregistration
> >   /sbin/hotplug cannot and must not attempt to do anything with eth0!
> >   Generally it'll fail to find an interface with this name.  If it does
> >   find eth0, it'll be the wrong one due to a race.
> 
> This is not a bug.  'unregister eth0' says to userspace "eth0 just
> disappeared."

Yes.  I was simply pointing out a restriction which is placed upon
/sbin/hotplug in this situation.

> Read my previous messages on the subject:  Add events like NETDEV_UP,
> NETDEV_DOWN, and NETDEV_GOING_DOWN to netdev_event_names[] if you want
> to call /sbin/hotplug for other netdev events.

erm..  I just deleted netdev_event_names[].  Without it, the way to do this
is to put

	net_run_sbin_hotplug(dev, "netdev_going_down");

in the appropriate place.

I deleted it because of the 'Rebroadcast unregister notification' crap
in unregister_netdevice.  If you want the netdev_event_names[] flexibility
back then we probably should kill the rebroadcast stuff.

But now that /sbin/hotplug is run asynchronously (Linus did it!) I
don't think this flexibility buys us much.  You'll end up with
'/sbin/hotplug net netdev_going_down' and '/sbin/hotplug net netdev_down'
running simultaneously.  What can they do?
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
