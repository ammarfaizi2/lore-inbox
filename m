Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270082AbVBEDxy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270082AbVBEDxy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 22:53:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270213AbVBEDxy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 22:53:54 -0500
Received: from EASTCAMPUS-THREE-FORTY-FOUR.MIT.EDU ([18.248.6.89]:53379 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id S270136AbVBEDxT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 22:53:19 -0500
Date: Fri, 4 Feb 2005 22:48:32 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: castet.matthieu@free.fr, linux-kernel@vger.kernel.org, vojtech@suse.cz
Subject: Re: [patch] ns558 bug
Message-ID: <20050205034832.GC7998@neo.rr.com>
Mail-Followup-To: ambx1@neo.rr.com, Andrew Morton <akpm@osdl.org>,
	castet.matthieu@free.fr, linux-kernel@vger.kernel.org,
	vojtech@suse.cz
References: <4203D476.4040706@free.fr> <20050205004311.GA7998@neo.rr.com> <20050204190614.6cfd68ce.akpm@osdl.org> <20050205030813.GB7998@neo.rr.com> <20050204192115.65ea246a.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050204192115.65ea246a.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040907i
From: ambx1@neo.rr.com (Adam Belay)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 04, 2005 at 07:21:15PM -0800, Andrew Morton wrote:
> ambx1@neo.rr.com (Adam Belay) wrote:
> >
> >  It looks ok.  My only concern is what would happen if the isa probe succeded
> >  but the pnp_register_driver failed?  "pnp_register_driver" return -ENODEV if
> >  "CONFIG_PNP" isn't enabled.  Do you think this would conflict with legacy
> >  probing?
> 
> Fair enough.  How about this?

The code no longer is leaking devices.  I may be overlooking something, but I
think it still doesn't retain legacy probed devices when PnP isn't available.

If "pnp_register_driver" fails then "ns588_unregister_ports" will unregister
the correctly detected ISA ports.  "pnp_register_driver" will always fail if
pnp support isn't compiled into the kernel.  We need a way of not 
unregistering "ns558_pnp_driver" in "ns558_exit" but retaining the ports
detected by the legacy probe.  In a way, this is sort of a driver model
problem.

As a more general solution for all drivers, I've been thinking about doing
something like this in the long term.

int ret;
if (!(ret = register_driver(&ns558_driver)))
	return ret;
add_driver_protocol(&ns558_driver, &ns558_pnp);
add_driver_protocol(&ns558_driver, &ns558_isa);

and then on exit:

unregister_driver(&ns558_driver); /* this tears down any successfully
				     registered bus protocol automatically */


For now a less invasive solution might be better.

Comments?

Thanks,
Adam


> 
> static void ns588_unregister_ports(void)
> {
> 	struct ns558 *port;
> 
> 	list_for_each_entry(port, &ns558_list, node) {
> 		gameport_unregister_port(&port->gameport);
> 		switch (port->type) {
> 
> #ifdef CONFIG_PNP
> 			case NS558_PNP:
> 				/* fall through */
> #endif
> 			case NS558_ISA:
> 				release_region(port->gameport.io &
> 					~(port->size - 1), port->size);
> 				kfree(port);
> 				break;
> 
> 			default:
> 				break;
> 		}
> 	}
> }
> 
> static int __init ns558_init(void)
> {
> 	int i = 0;
> 	int ret;
> 
> /*
>  * Probe for ISA ports.
>  */
> 
> 	while (ns558_isa_portlist[i])
> 		ns558_isa_probe(ns558_isa_portlist[i++]);
> 
> 	ret = pnp_register_driver(&ns558_pnp_driver);
> 	if (ret < 0) {
> 		ns588_unregister_ports();
> 		return ret;
> 	}
> 	return 0;
> }
> 
> static void __exit ns558_exit(void)
> {
> 	ns588_unregister_ports();
> 	pnp_unregister_driver(&ns558_pnp_driver);
> }
