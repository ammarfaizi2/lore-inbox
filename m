Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422759AbWAMSe4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422759AbWAMSe4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 13:34:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422809AbWAMSe4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 13:34:56 -0500
Received: from smtp15.wanadoo.fr ([193.252.23.84]:33493 "EHLO
	smtp15.wanadoo.fr") by vger.kernel.org with ESMTP id S1422759AbWAMSez
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 13:34:55 -0500
X-ME-UUID: 20060113183444366.59615700008B@mwinf1501.wanadoo.fr
Message-ID: <5880875.1137177284360.JavaMail.www@wwinf1509>
From: Denis Semmau <denis.semmau@wanadoo.fr>
Reply-To: denis.semmau@wanadoo.fr
To: linux-kernel@vger.kernel.org
Subject: [PATCH] RP filter support for IPv6, kernel 2.6.15
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [86.201.114.6]
X-Wum-Nature: EMAIL-NATURE
X-WUM-FROM: |~|
X-WUM-TO: |~|
X-WUM-REPLYTO: |~|
Date: Fri, 13 Jan 2006 19:34:44 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've made a patch in order to enable reverse path filtering for IPv6.
The rp_filter sysctl has been added, and some structures have changed in order to support this new feature.
The main part has been added into net/ipv6/ip6_output.c, with the same name of functions than for IPv4 (the new function is called rt6_validate_source).


Signed-off-by: Denis Semmau <denis.semmau@wanadoo.fr>


diff -Naur linux-2.6.15.old/include/linux/ipv6.h linux-2.6.15.new/include/linux/ipv6.h
--- linux-2.6.15.old/include/linux/ipv6.h       2006-01-03 04:21:10.000000000 +0100
+++ linux-2.6.15.new/include/linux/ipv6.h       2006-01-11 20:12:03.000000000 +0100
@@ -127,6 +127,7 @@
  */
 struct ipv6_devconf {
        __s32           forwarding;
+        __s32           rp_filter;
        __s32           hop_limit;
        __s32           mtu6;
        __s32           accept_ra;
@@ -151,6 +152,7 @@
 /* index values for the variables in ipv6_devconf */
 enum {
        DEVCONF_FORWARDING = 0,
+       DEVCONF_RPFILTER = 0,
        DEVCONF_HOPLIMIT,
        DEVCONF_MTU6,
        DEVCONF_ACCEPT_RA,
diff -Naur linux-2.6.15.old/include/linux/sysctl.h linux-2.6.15.new/include/linux/sysctl.h
--- linux-2.6.15.old/include/linux/sysctl.h     2006-01-03 04:21:10.000000000 +0100
+++ linux-2.6.15.new/include/linux/sysctl.h     2006-01-11 20:11:51.000000000 +0100
@@ -524,6 +524,7 @@
        NET_IPV6_MAX_DESYNC_FACTOR=15,
        NET_IPV6_MAX_ADDRESSES=16,
        NET_IPV6_FORCE_MLD_VERSION=17,
+       NET_IPV6_RPFILTER=18,
        __NET_IPV6_MAX
 };

diff -Naur linux-2.6.15.old/net/ipv6/addrconf.c linux-2.6.15.new/net/ipv6/addrconf.c
--- linux-2.6.15.old/net/ipv6/addrconf.c        2006-01-03 04:21:10.000000000 +0100
+++ linux-2.6.15.new/net/ipv6/addrconf.c        2006-01-11 20:12:30.000000000 +0100
@@ -150,6 +150,7 @@

 struct ipv6_devconf ipv6_devconf = {
        .forwarding             = 0,
+       .rp_filter              = 0,
        .hop_limit              = IPV6_DEFAULT_HOPLIMIT,
        .mtu6                   = IPV6_MIN_MTU,
        .accept_ra              = 1,
@@ -172,6 +173,7 @@

 static struct ipv6_devconf ipv6_devconf_dflt = {
        .forwarding             = 0,
+       .rp_filter              = 0,
        .hop_limit              = IPV6_DEFAULT_HOPLIMIT,
        .mtu6                   = IPV6_MIN_MTU,
        .accept_ra              = 1,
@@ -3111,6 +3113,7 @@
 {
        memset(array, 0, bytes);
        array[DEVCONF_FORWARDING] = cnf->forwarding;
+       array[DEVCONF_RPFILTER] = cnf->rp_filter;
        array[DEVCONF_HOPLIMIT] = cnf->hop_limit;
        array[DEVCONF_MTU6] = cnf->mtu6;
        array[DEVCONF_ACCEPT_RA] = cnf->accept_ra;
@@ -3586,6 +3589,14 @@
                        .proc_handler   =       &proc_dointvec,
                },
                {
+                       .ctl_name       =       NET_IPV6_RPFILTER,
+                       .procname       =       "rp_filter",
+                       .data           =       &ipv6_devconf.rp_filter,
+                       .maxlen         =       sizeof(int),
+                       .mode           =       0644,
+                       .proc_handler   =       &proc_dointvec,
+               },
+               {
                        .ctl_name       =       0,      /* sentinel */
                }
        },
diff -Naur linux-2.6.15.old/net/ipv6/ip6_output.c linux-2.6.15.new/net/ipv6/ip6_output.c
--- linux-2.6.15.old/net/ipv6/ip6_output.c      2006-01-03 04:21:10.000000000 +0100
+++ linux-2.6.15.new/net/ipv6/ip6_output.c      2006-01-13 01:24:22.000000000 +0100
@@ -306,11 +306,24 @@
        return 0;
 }

+static int rt6_validate_source( struct sk_buff *skb) {
+         struct rt6_info *rt;
+         rt=rt6_lookup(&skb->nh.ipv6h->saddr,NULL,0,0);
+         if ( rt!=NULL ) {
+           if (rt->rt6i_idev->dev == skb->dev )
+             return 0;
+         }
+         return -1;
+}
+
+
 static inline int ip6_forward_finish(struct sk_buff *skb)
 {
        return dst_output(skb);
 }

+
+
 int ip6_forward(struct sk_buff *skb)
 {
        struct dst_entry *dst = skb->dst;
@@ -320,6 +333,26 @@
        if (ipv6_devconf.forwarding == 0)
                goto error;

+       /*RP_FILTER*/
+       struct inet6_dev *idev = NULL;
+       idev = in6_dev_get(skb->dev);
+       if (!idev) {
+         printk(KERN_WARNING "idev error for RP_Filter\n");
+         goto error;
+       }
+
+       if (ipv6_devconf.rp_filter & idev->cnf.rp_filter ) {
+         if (rt6_validate_source(skb)<0) {
+           printk(KERN_WARNING "RP_FILTER-- Packet refused from %x:%x:%x:%x:%x:%x:%x:%x to %x:%x:%x:%x:%x:%x:%x:%x from %s\n",NIP6(skb->nh.ipv6h->saddr),NIP6(skb->nh.ipv6h->daddr),skb->dev->name);
+           goto error;
+         }
+
+       }
+
+       /*RP_FILTER END*/
+
+
+
        if (!xfrm6_policy_check(NULL, XFRM_POLICY_FWD, skb)) {
                IP6_INC_STATS(IPSTATS_MIB_INDISCARDS);
                goto drop;

