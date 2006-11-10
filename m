Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946369AbWKJKWN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946369AbWKJKWN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 05:22:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946307AbWKJKWN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 05:22:13 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:43268 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1946304AbWKJKWL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 05:22:11 -0500
Date: Fri, 10 Nov 2006 11:22:13 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linville@tuxdriver.com
Cc: netdev@vger.kernel.org, linux-pcmcia@lists.infradead.org,
       linux-kernel@vger.kernel.org
Subject: hostap_cs_{resume,suspend}(): inconsequent NULL checking
Message-ID: <20061110102213.GY4729@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The Coverity checker spotted the following in 
drivers/net/wireless/hostap/hostap_cs.c:

<--  snip  -->

...
static int hostap_cs_suspend(struct pcmcia_device *link)
{
        struct net_device *dev = (struct net_device *) link->priv;
        int dev_open = 0;
        struct hostap_interface *iface = NULL;

        if (dev)
                iface = netdev_priv(dev);

        PDEBUG(DEBUG_EXTRA, "%s: CS_EVENT_PM_SUSPEND\n", dev_info);
        if (iface && iface->local)
                dev_open = iface->local->num_dev_open > 0;
        if (dev_open) {
                netif_stop_queue(dev);
                netif_device_detach(dev);
        }
        prism2_suspend(dev);

        return 0;
}

static int hostap_cs_resume(struct pcmcia_device *link)
{
        struct net_device *dev = (struct net_device *) link->priv;
        int dev_open = 0;
        struct hostap_interface *iface = NULL;

        if (dev)
                iface = netdev_priv(dev);

        PDEBUG(DEBUG_EXTRA, "%s: CS_EVENT_PM_RESUME\n", dev_info);

        if (iface && iface->local)
                dev_open = iface->local->num_dev_open > 0;

        prism2_hw_shutdown(dev, 1);
        prism2_hw_config(dev, dev_open ? 0 : 1);
        if (dev_open) {
                netif_device_attach(dev);
                netif_start_queue(dev);
        }

        return 0;
}
...

<--  snip  -->

The problem is that if the "if (dev)" is false, there's a guaranteed 
NULL dereference later in the "prism2_suspend(dev)" resp.
"prism2_hw_config(dev, dev_open ? 0 : 1)".

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

