Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270322AbTGWNdt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 09:33:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270324AbTGWNdt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 09:33:49 -0400
Received: from 5.Red-80-32-157.pooles.rima-tde.net ([80.32.157.5]:7428 "EHLO
	smtp.newipnet.com") by vger.kernel.org with ESMTP id S270322AbTGWNdr convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 09:33:47 -0400
Message-ID: <200307231541180759.1C8EFFB1@192.168.128.16>
In-Reply-To: <200307182357260552.063FA10C@192.168.128.16>
References: <200307182357260552.063FA10C@192.168.128.16>
X-Mailer: Calypso Version 3.30.00.00 (4)
Date: Wed, 23 Jul 2003 15:41:18 +0200
From: "Carlos Velasco" <carlosev@newipnet.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Re: ARP with wrong ip?
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have submitted a patch for this issue, as it's found in 2.6.0-test1 too.

Can someone take a look to this bug and process the patch?

http://bugzilla.kernel.org/show_bug.cgi?id=978


--- linux-2.6.0-test1/net/ipv4/arp.c      Mon Jul 14 05:37:28 2003
+++ linux-2.6.0-test1-patch/net/ipv4/arp.c    Wed Jul 23 15:31:29 2003
@@ -326,10 +326,14 @@
        u32 target = *(u32*)neigh->primary_key;
        int probes = atomic_read(&neigh->probes);
 
+        /* This don't work if the src addr is a loopback or similar.
+          See http://bugzilla.kernel.org/show_bug.cgi?id=978 
+
        if (skb && inet_addr_type(skb->nh.iph->saddr) == RTN_LOCAL)
                saddr = skb->nh.iph->saddr;
-       else
-               saddr = inet_select_addr(dev, target, RT_SCOPE_LINK);
+       else */
+
+       saddr = inet_select_addr(dev, target, RT_SCOPE_LINK);
 
        if ((probes -= neigh->parms->ucast_probes) < 0) {
                if (!(neigh->nud_state&NUD_VALID))


*********** REPLY SEPARATOR  ***********

On 18/07/2003 at 23:57 Carlos Velasco wrote:

>Hi,
>
>I have a problem with ARP in this machine:
>Kernel 2.4.20
>1 ethernet interface with IP 192.168.10.1 netmask 255.255.255.0
>1 loopback interface with IP 194.147.150.10 netmask 255.255.255.255
>default route to 192.168.10.190
>
>Packets are being sent to ethernet interface 192.168.10.1 with IP dst
>194.147.150.10.
>After receiving these packets it tries to find out the mac address of
>default gateway (192.168.10.190)... but it's doing it from the wrong src
>IP address!!
>
>22:49:10.875002 0:b:cd:4d:82:72 ff:ff:ff:ff:ff:ff 0806 60: arp who-has
>192.168.10.190 tell 194.147.150.10
>22:49:11.867673 0:b:cd:4d:82:72 ff:ff:ff:ff:ff:ff 0806 60: arp who-has
>192.168.10.190 tell 194.147.150.10
>
>Is this a bug?
>
>Regards,
>Carlos Velasco
>
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/



