Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268963AbUIHCJQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268963AbUIHCJQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 22:09:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268966AbUIHCJQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 22:09:16 -0400
Received: from coverity.dreamhost.com ([66.33.192.105]:63186 "EHLO
	coverity.dreamhost.com") by vger.kernel.org with ESMTP
	id S268963AbUIHCJJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 22:09:09 -0400
Date: Tue, 7 Sep 2004 19:09:08 -0700 (PDT)
From: Dawson Engler <engler@coverity.dreamhost.com>
To: linux-kernel@vger.kernel.org
Cc: developers@coverity.com
Subject: [CHECKER] Deadlock cycle between locks nr_neigh_list_lock: <===>> 
 nr_node_list_lock
Message-ID: <Pine.LNX.4.58.0409071859080.22756@coverity.dreamhost.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi All,

below is a possible deadlock in linux-2.6.8.1 found by a static deadlock
checker I'm writing.  Let me know if it looks valid (and/or whether the
output is too cryptic).

Thanks,
Dawson


   thread 1: nr_neigh_list_lock ==>> nr_node_list_lock
       trace 1:

linux-2.6.8.1/net/netrom/nr_route.c:nr_rt_device_down
          531: void nr_rt_device_down(struct net_device *dev)
          532: {
          533:  struct nr_neigh *s;
          534:  struct hlist_node *node, *nodet, *node2, *node2t;
          535:  struct nr_node  *t;
          536:  int i;
          537:
===>      538:  spin_lock_bh(&nr_neigh_list_lock);
             539:       nr_neigh_for_each_safe(s, node, nodet,
&nr_neigh_list) {
             540:               if (s->dev == dev) {
===>         541:                       spin_lock_bh(&nr_node_list_lock);


       trace 2:

linux-2.6.8.1/net/netrom/nr_route.c:nr_rt_free
          1018: void __exit nr_rt_free(void)
          1019: {
          1020:         struct nr_neigh *s = NULL;
          1021:         struct nr_node  *t = NULL;
          1022:         struct hlist_node *node, *nodet;
          1023:
===>      1024:         spin_lock_bh(&nr_neigh_list_lock);
===>         1025:      spin_lock_bh(&nr_node_list_lock);


     -----------
   thread 2: nr_node_list_lock ==>> nr_neigh_list_lock
       trace 1: ncalls=1, ncond=0

linux-2.6.8.1/net/netrom/nr_route.c:nr_dec_obs
          476: static int nr_dec_obs(void)
          477: {
          478:  struct nr_neigh *nr_neigh;
          479:  struct nr_node  *s;
          480:  struct hlist_node *node, *nodet;
          481:  int i;
          482:
===>      483:  spin_lock_bh(&nr_node_list_lock);
             ...

===>      498:             nr_remove_neigh(nr_neigh);

linux-2.6.8.1/net/netrom/nr_route.c:nr_remove_neigh
                338: static void nr_remove_neigh(struct nr_neigh
*nr_neigh)
                339: {
===>            340:    spin_lock_bh(&nr_neigh_list_lock);

     -----------

