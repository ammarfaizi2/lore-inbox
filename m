Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751474AbWIDVKw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751474AbWIDVKw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 17:10:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751467AbWIDVKw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 17:10:52 -0400
Received: from moutng.kundenserver.de ([212.227.126.183]:4591 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1751454AbWIDVKv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 17:10:51 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Francois Romieu <romieu@fr.zoreil.com>
Subject: Re: [2.6.19 PATCH 1/7] ehea: interface to network stack
Date: Mon, 4 Sep 2006 23:11:20 +0200
User-Agent: KMail/1.9.1
Cc: Jan-Bernd Themann <ossthema@de.ibm.com>, netdev <netdev@vger.kernel.org>,
       Jeff Garzik <jeff@garzik.org>, Christoph Raisch <raisch@de.ibm.com>,
       Jan-Bernd Themann <themann@de.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-ppc <linuxppc-dev@ozlabs.org>, Marcus Eder <meder@de.ibm.com>,
       Thomas Klein <tklein@de.ibm.com>
References: <200609041237.46528.ossthema@de.ibm.com> <20060904201606.GA24386@electric-eye.fr.zoreil.com>
In-Reply-To: <20060904201606.GA24386@electric-eye.fr.zoreil.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200609042311.21202.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:bf0b512fe2ff06b96d9695102898be39
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Monday 04 September 2006 22:16 schrieb Francois Romieu:
> > +#include "ehea.h"
> > +#include "ehea_qmr.h"
> > +#include "ehea_phyp.h"
>
> Afaik none of those is included in this patch nor in my 2.6.18-git tree.


They are in 5, 3 and 2, respectively

> Happy bissect in sight.

The driver should get merged as a single commit anyway, even
if split diffs are posted for review. Even if it gets merged
like this, bisect will work since the Kconfig option is added
in the final patch.

> > +
> > +static struct net_device_stats *ehea_get_stats(struct net_device *dev)
> > +{
> > +     struct ehea_port *port = netdev_priv(dev);
> > +     struct net_device_stats *stats = &port->stats;
> > +     struct hcp_ehea_port_cb2 *cb2;
> > +     u64 hret, rx_packets;
> > +     int i;
>
> unsigned int ?

does it matter? int as a counter is pretty standard.

> > +
> > +     if (netif_msg_hw(port))
> > +             ehea_dump(cb2, sizeof(*cb2), "net_device_stats");
> > +
> > +     rx_packets = 0;
>
> Could be initialized when it is declared.
>
> > +     for (i = 0; i < port->num_def_qps; i++)
> > +             rx_packets += port->port_res[i].rx_packets;

In one of the previous reviews, we told them to do it this way
instead. Initializing at declaration is error-prone.

> > +
> > +     intreq = ((pr->p_state.ehea_poll & 0xF) == 0xF);
>
> Arguable parenthesis.
>

I'd argue to keep them ;-)

> > +
> > +     hret = ehea_h_modify_ehea_port(port->adapter->handle,
> > +                                    port->logical_port_id,
> > +                                    H_PORT_CB0, mask, cb0);
> > +     if (hret != H_SUCCESS) {
> > +             ret = -EIO;
>
> Why can't ehea_xyz return -EIO/0 directly ?
>

the lowest-level hypercall should return H_* by convention.

Then again, it should also be called plpar_modify_ehea_port()
in that case.

> > +static int ehea_start_xmit(struct sk_buff *skb, struct net_device *dev)
> > +{
> > +     struct ehea_port *port = netdev_priv(dev);
> > +     struct ehea_port_res *pr;
> > +     struct ehea_swqe *swqe;
> > +     unsigned long flags;
> > +     u32 lkey;
> > +     int swqe_index;
> > +
> > +     pr = &port->port_res[0];
>
> Initialization and declaration can happen at the same time.

it's a gray area. In general, I recommend not to combine them
at all. Initialization to NULL or 0 is always bad, this one
is harmless, but I'd still leave it this way, especially after
telling them to clean this up earlier ;-)

	Arnd <><
