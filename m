Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267578AbVBEDen@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267578AbVBEDen (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 22:34:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267020AbVBED36
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 22:29:58 -0500
Received: from fw.osdl.org ([65.172.181.6]:22452 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264008AbVBEDVX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 22:21:23 -0500
Date: Fri, 4 Feb 2005 19:21:15 -0800
From: Andrew Morton <akpm@osdl.org>
To: ambx1@neo.rr.com (Adam Belay)
Cc: castet.matthieu@free.fr, linux-kernel@vger.kernel.org, vojtech@suse.cz
Subject: Re: [patch] ns558 bug
Message-Id: <20050204192115.65ea246a.akpm@osdl.org>
In-Reply-To: <20050205030813.GB7998@neo.rr.com>
References: <4203D476.4040706@free.fr>
	<20050205004311.GA7998@neo.rr.com>
	<20050204190614.6cfd68ce.akpm@osdl.org>
	<20050205030813.GB7998@neo.rr.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ambx1@neo.rr.com (Adam Belay) wrote:
>
>  It looks ok.  My only concern is what would happen if the isa probe succeded
>  but the pnp_register_driver failed?  "pnp_register_driver" return -ENODEV if
>  "CONFIG_PNP" isn't enabled.  Do you think this would conflict with legacy
>  probing?

Fair enough.  How about this?

static void ns588_unregister_ports(void)
{
	struct ns558 *port;

	list_for_each_entry(port, &ns558_list, node) {
		gameport_unregister_port(&port->gameport);
		switch (port->type) {

#ifdef CONFIG_PNP
			case NS558_PNP:
				/* fall through */
#endif
			case NS558_ISA:
				release_region(port->gameport.io &
					~(port->size - 1), port->size);
				kfree(port);
				break;

			default:
				break;
		}
	}
}

static int __init ns558_init(void)
{
	int i = 0;
	int ret;

/*
 * Probe for ISA ports.
 */

	while (ns558_isa_portlist[i])
		ns558_isa_probe(ns558_isa_portlist[i++]);

	ret = pnp_register_driver(&ns558_pnp_driver);
	if (ret < 0) {
		ns588_unregister_ports();
		return ret;
	}
	return 0;
}

static void __exit ns558_exit(void)
{
	ns588_unregister_ports();
	pnp_unregister_driver(&ns558_pnp_driver);
}

