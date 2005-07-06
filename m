Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262205AbVGGDg0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262205AbVGGDg0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 23:36:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262458AbVGFT5j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 15:57:39 -0400
Received: from smtp15.wanadoo.fr ([193.252.23.84]:43516 "EHLO
	smtp15.wanadoo.fr") by vger.kernel.org with ESMTP id S262208AbVGFP7E
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 11:59:04 -0400
X-ME-UUID: 20050706155859325.4F81F7000083@mwinf1504.wanadoo.fr
Message-ID: <10201100.1120665539318.JavaMail.www@wwinf1506>
From: Pascal CHAPPERON <pascal.chapperon@wanadoo.fr>
Reply-To: pascal.chapperon@wanadoo.fr
To: Francois Romieu <romieu@fr.zoreil.com>
Subject: Re: sis190
Cc: Juha Laiho <Juha.Laiho@iki.fi>, Andrew Hutchings <info@a-wing.co.uk>,
       linux-kernel@vger.kernel.org, lars.vahlenberg@mandator.com,
       vinay kumar <b4uvin@yahoo.co.in>, jgarzik@pobox.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [80.13.96.175]
X-WUM-FROM: |~|
X-WUM-TO: |~|
X-WUM-CC: |~||~||~||~||~||~|
X-WUM-REPLYTO: |~|
Date: Wed,  6 Jul 2005 17:58:59 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Message du 05/07/05 01:34
> De : "Francois Romieu" <romieu@fr.zoreil.com>
[...]
> Can you check if there is a regression in sis190-000.patch available at
> http://www.zoreil.com/~romieu/sis190/20050704-2.6.13-rc1/patches ?
> 

That one works perfectly; i tried it in the same conditions as
the previous patch, and i don't notice a regression.

[...]
> If it works and you want some entertainment, you can apply sis190-010.patch
> + sis190-020.patch and experience with ethtool/mii-tool. 
> 
[...]

sis190-010.patch does not compile properly :

# make clean;make;make install
rm -f *.o *.ko .*.cmd .*.flags *.mod.c
make -C /lib/modules/2.6.12.1/build SUBDIRS=/data/src/sis190  modules
make[1]: Entering directory `/usr/src/linux-2.6.12.1-custom'
  CC [M]  /data/src/sis190/sis190.o
/data/src/sis190/sis190.c: In function `sis190_init_one':
/data/src/sis190/sis190.c:1318: error: structure has no member named `poll_controller'

# diff -puN sis190-20050704-10.c sis190.c
--- sis190-20050704-10.c        2005-07-06 14:49:19.000000000 +0200
+++ sis190.c    2005-07-06 15:41:49.000000000 +0200

@@ -639,8 +640,6 @@ static void sis190_netpoll(struct net_de
        sis190_interrupt(pdev->irq, dev, NULL);
        enable_irq(pdev->irq);
 }
-#else
-#define sis190_netpoll         NULL
 #endif

 static void sis190_free_rx_skb(struct sis190_private *tp,
@@ -1314,7 +1313,9 @@ static int __devinit sis190_init_one(str
        dev->tx_timeout = sis190_tx_timeout;
        dev->watchdog_timeo = SIS190_TX_TIMEOUT;
        dev->hard_start_xmit = sis190_start_xmit;
+#ifdef CONFIG_NET_POLL_CONTROLLER
        dev->poll_controller = sis190_netpoll;
+#endif
        dev->set_multicast_list = sis190_set_rx_mode;
        SET_ETHTOOL_OPS(dev, &sis190_ethtool_ops);
        dev->irq = pdev->irq;

After that, it compiles and works as expected; i can use netconsole
and get local messages on the other box.


There is something wrong whith sis190-020.patch;
it works, i can use the link as usual, i can use
ethtool :

# ethtool eth0
Settings for eth0:
        Supported ports: [ TP MII ]
        Supported link modes:   10baseT/Half 10baseT/Full
                                100baseT/Half 100baseT/Full
        Supports auto-negotiation: Yes
        Advertised link modes:  10baseT/Half 10baseT/Full
                                100baseT/Half 100baseT/Full
        Advertised auto-negotiation: Yes
        Speed: 100Mb/s
        Duplex: Full
        Port: MII
        PHYAD: 0
        Transceiver: internal
        Auto-negotiation: on
        Current message level: 0x00000037 (55)
        Link detected: yes

But i get those traces in syslog, when the driver is
loaded and every time i use ethtool :

[...]
scheduling while atomic: mii-tool/0x00000001/4699

Call Trace:<ffffffff8030358a>{schedule+122} <ffffffff801ce6de>{avc_has_perm_noaudit+1134}
       <ffffffff80191290>{update_atime+64} <ffffffff80139109>{__mod_timer+425}
       <ffffffff803047fe>{schedule_timeout+158} <ffffffff80139b70>{process_timeout+0}
       <ffffffff80139f68>{msleep+56} <ffffffff880370c8>{:sis190:__mdio_cmd+24}
       <ffffffff8803712f>{:sis190:mdio_read+15} <ffffffff88034868>{:mii:generic_mii_ioctl+152}
       <ffffffff880387dd>{:sis190:sis190_ioctl+77} <ffffffff802a30db>{dev_ifsioc+971}
       <ffffffff802a33e5>{dev_ioctl+741} <ffffffff802e47da>{inet_ioctl+138}
       <ffffffff80297fdc>{sock_ioctl+572} <ffffffff8018967a>{do_ioctl+58}
       <ffffffff8018998d>{vfs_ioctl+685} <ffffffff80189a2a>{sys_ioctl+106}
       <ffffffff8010d866>{system_call+126}
[...]
scheduling while atomic: ethtool/0x00000001/4703

Call Trace:<ffffffff8030358a>{schedule+122} <ffffffff80139109>{__mod_timer+425}
       <ffffffff803047fe>{schedule_timeout+158} <ffffffff80139b70>{process_timeout+0}
       <ffffffff80139f68>{msleep+56} <ffffffff880370c8>{:sis190:__mdio_cmd+24}
       <ffffffff8803712f>{:sis190:mdio_read+15} <ffffffff880340df>{:mii:mii_ethtool_gset+223}
       <ffffffff880385de>{:sis190:sis190_get_settings+46} <ffffffff802a43d2>{dev_ethtool+290}
       <ffffffff80159862>{buffered_rmqueue+690} <ffffffff80159a32>{__alloc_pages+194}
       <ffffffff801ce6de>{avc_has_perm_noaudit+1134} <ffffffff801650f3>{do_no_page+483}
       <ffffffff8015be4a>{__do_page_cache_readahead+362} <ffffffff8018f5eb>{__d_lookup+363}
       <ffffffff801ce6de>{avc_has_perm_noaudit+1134} <ffffffff801ce6de>{avc_has_perm_noaudit+1134}
       <ffffffff80191290>{update_atime+64} <ffffffff801ce76a>{avc_has_perm+90}
       <ffffffff80159862>{buffered_rmqueue+690} <ffffffff801cf57a>{inode_has_perm+106}
       <ffffffff801561fa>{filemap_nopage+394} <ffffffff802a33b5>{dev_ioctl+693}
       <ffffffff802e47da>{inet_ioctl+138} <ffffffff80297fdc>{sock_ioctl+572}
       <ffffffff8018967a>{do_ioctl+58} <ffffffff8018998d>{vfs_ioctl+685}
       <ffffffff80189a2a>{sys_ioctl+106} <ffffffff8010d866>{system_call+126}
[...]


I also tried to set sis190 mode (eg: 10 full autoneg off), but the driver
froze the box.

As for now mii support seems unstable, i do not play further more with 
the media management.

Regards
Pascal


