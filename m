Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267360AbUIACZz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267360AbUIACZz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 22:25:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267385AbUIACZz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 22:25:55 -0400
Received: from web40002.mail.yahoo.com ([66.218.78.20]:62125 "HELO
	web40002.mail.yahoo.com") by vger.kernel.org with SMTP
	id S267360AbUIACZw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 22:25:52 -0400
Message-ID: <20040901022551.63415.qmail@web40002.mail.yahoo.com>
Date: Tue, 31 Aug 2004 19:25:51 -0700 (PDT)
From: Song Wang <wsonguci@yahoo.com>
Subject: [PATCH 2.6.9-rc1] handle error msg "driver changed get_stats after register"
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is against 2.6.9-rc1.

In net/core/dev.c: dev_open

  if (get_stats_changed(dev) && net_ratelimit()) {
                printk(KERN_ERR "%s: driver changed
get_stats after register\n",
                       dev->name);
        }

static inline int get_stats_changed(struct net_device
*dev)
{
        int changed = dev->last_stats !=
dev->get_stats;
        dev->last_stats = dev->get_stats;
        return changed;
}

get_stats_changed checks if dev->last_stats has been
changed after the registration when opening the net
device. However, the initialization of dev->last_stats
is done in net/core/net-sysfs.c, which is only 
compiled when CONFIG_SYSFS is enabled.

So if we don't enable CONFIG_SYSFS (for example,
embedded system may not need it for saving space.),
all the network device drivers will have an error
message "driver changed get_stats after register"
printed on the console when you try to ifconfig it,
because dev->last_stats is never initialized.

The following patch adds the initialization of
dev->last_stats in register_netdevice function.

-Song

diff -Naur linux-2.6.9-rc1/net/core/dev.c
linux-2.6.9-rc1.mod/net/core/dev.c
--- linux-2.6.9-rc1/net/core/dev.c      2004-08-31
18:51:06.000000000 -0700
+++ linux-2.6.9-rc1.mod/net/core/dev.c  2004-08-31
19:11:35.407452369 -0700
@@ -2872,6 +2872,8 @@

        dev->iflink = -1;

+       dev->last_stats = dev->get_stats;
+
        /* Init, if this function is available */
        if (dev->init) {
                ret = dev->init(dev);



		
__________________________________
Do you Yahoo!?
Y! Messenger - Communicate in real time. Download now. 
http://messenger.yahoo.com
