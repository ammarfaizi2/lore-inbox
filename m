Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131183AbRBLS50>; Mon, 12 Feb 2001 13:57:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131173AbRBLS5Q>; Mon, 12 Feb 2001 13:57:16 -0500
Received: from Mail.ubishops.ca ([192.197.190.5]:46865 "EHLO Mail.ubishops.ca")
	by vger.kernel.org with ESMTP id <S131183AbRBLS5G>;
	Mon, 12 Feb 2001 13:57:06 -0500
Message-ID: <3A8831D2.7EDB25D3@yahoo.co.uk>
Date: Mon, 12 Feb 2001 13:56:18 -0500
From: Thomas Hood <jdthoodREMOVETHIS@yahoo.co.uk>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1-ac10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: jschlst@turbolinux.com, Andrew Morton <andrewm@uow.edu.au>,
        "Bryan K. Walton" <bryan@bryansweb.com>,
        Russell Coker <russell@coker.com.au>, dahinds@sourceforge.net,
        kuznet@ms2.inr.ac.ru, jgarzik@mandrakesoft.com, acme@conectiva.com.br
Subject: Re: [PATCH] to deal with bad dev->refcnt in unregister_netdevice()
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, but it turns out that the bug is not completely
fixed by the change that acme made.  With the change,
ifup-ing and if-downing eth0 with the ipx module loaded
no longer reduces eth0's refcnt to an indefinitely low
(larger and larger negative) number.  However if the ipx
module is loaded first and ipx configured on eth0, and
then the network card inserted and "ifconfig eth0 up" done,
and then "ifconfig eth0 down" done, then once again the
refcnt is too low, so that when I try to "cardctl eject"
my ethernet card, "modprobe -r xirc2ps_cs" hangs up.
This whole business of refcnts needs to be thought 
through more carefully.

> This bug was fixed by "acme" in 2.4.1-ac10.  :)
> The ipx driver now increments refcnt on NETDEV_UP to
> match downing the interface on NETDEV_DOWN.
> 
> Thanks all.
> Thomas
> 
> 
> > Okay, I now know the cause of this problem.  It's a bug in
> > the ipx driver.  (This also closes pcmcia-cs bug #126563.)
> > 
> > Through copious use of printk()s I was able to track down
> > the point at which the dev->refcnt for my card was being
> > erroneously decremented.  It was being erroneously decremented
> > by "notifier_call_chain(&netdev_chain, NETDEV_DOWN, dev);"
> > near the end of the "dev_close()" function in net/core/dev.c.
> > This indicated that one of the registered notifiers
> > was doing an improper "dev_put()".  I rmmod-ed the ipx module
> > from my system and the problem magically disappeared.  The
> > refcnt is no longer inappropriately decremented and there
> > are no more inappropriate calls to netdev_finish_unregister()
> > in the absence of a prior call to unregister_netdevice()
> > (which is what resulted in the "Freeing alive device" messages).
> > 
> > Where is the bug?  It is in the ipx driver.  When I configure
> > eth0 for ipx, the device gets added to the ipx driver's linked
> > list of devices headed at "ipx_interfaces".  The ipx driver
> > registers the following function to be notified of net events.
> > It's clear that the ipx driver will do a __ipxitf_put (which
> > decrements dev-refcnt and does a dev_put() on dev) every time
> > eth0 is taken down with "ifconfig eth0 down"!  That would be
> > okay, I guess, if the opposite were done on an "ifconfig eth0 up"
> > but it isn't.  This needs to be fixed somehow.  I'll leave it
> > up to the maintainers and other gurus to figure out how.  In
> > the meantime I'll just avoid using ipx.
> > 
> > ---------------- net/ipx/af_ipx.c ---------------------------
> > static int ipxitf_device_event(struct notifier_block *notifier,
> >                                 unsigned long event, void *ptr)
> > {
> >         struct net_device *dev = ptr;
> >         ipx_interface *i, *tmp;
> > 
> >         if (event != NETDEV_DOWN)
> >                 return NOTIFY_DONE;
> > 
> >         spin_lock_bh(&ipx_interfaces_lock);
> >         for (i = ipx_interfaces; i;) {
> >                 tmp = i->if_next;
> >                 if (i->if_dev == dev)
> >                         __ipxitf_put(i);
> >                 i = tmp;
> > 
> >         }
> >         spin_unlock_bh(&ipx_interfaces_lock);
> >         return NOTIFY_DONE;
> > }
> > --------------------------------------------------------------
>
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://vger.kernel.org/lkml/
