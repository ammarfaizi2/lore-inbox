Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317512AbSGERay>; Fri, 5 Jul 2002 13:30:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317517AbSGERax>; Fri, 5 Jul 2002 13:30:53 -0400
Received: from quechua.inka.de ([212.227.14.2]:23126 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S317512AbSGERaw>;
	Fri, 5 Jul 2002 13:30:52 -0400
From: Bernd Eckenfels <ecki-news2002-06@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Question concerning ifconfig
In-Reply-To: <180577A42806D61189D30008C7E632E8793972@boca213a.boca.ssc.siemens.com>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.0.39 (i686))
Message-Id: <E17QWxR-0000Im-00@sites.inka.de>
Date: Fri, 5 Jul 2002 19:33:25 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bloch, Jack <Jack.Bloch@icn.siemens.com> wrote:
> ifconfig ifp0 hw ether A2:A5:A5:01:00:00

I get also EBUSY on 0x8924 aka SIOCSIFHWADDR.

Looking into the kernel:

core/dev.c
                case SIOCSIFHWADDR:
                        if (dev->set_mac_address == NULL)
                                return -EOPNOTSUPP;
                        if (ifr->ifr_hwaddr.sa_family!=dev->type)
                                return -EINVAL;
                        if (!netif_device_present(dev))
                                return -ENODEV;
                        err = dev->set_mac_address(dev, &ifr->ifr_hwaddr);
                        if (!err)
                                notifier_call_chain(&netdev_chain, NETDEV_CHANGE
                        return err;


It looks to me that set_mac_address() of the device is doing that. For my
card it is the generic one in net_init.c which is doing:

static int eth_mac_addr(struct net_device *dev, void *p)
{
        struct sockaddr *addr=p;
        if (netif_running(dev))
                return -EBUSY;
        memcpy(dev->dev_addr, addr->sa_data,dev->addr_len);
        return 0;
}

So, as long as your interface is up, you are not allowed to change the
address.

I will add that to the man page.

Greetings
Bernd
