Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264532AbTLCKdc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 05:33:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264536AbTLCKdc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 05:33:32 -0500
Received: from [212.102.131.179] ([212.102.131.179]:56734 "EHLO acs.vm")
	by vger.kernel.org with ESMTP id S264532AbTLCKd3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 05:33:29 -0500
Message-ID: <3FCDBB32.5040300@transacty.co.yu>
Date: Wed, 03 Dec 2003 11:30:10 +0100
From: Zoran Davidovac <zoran.davidovac@transacty.co.yu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Wilmer van der Gaast <lintux@lintux.cx>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.23 masquerading broken? key.oif = 0;  perhaps in bad position
 ?
References: <20031202165653.GJ615@gaast.net>
In-Reply-To: <20031202165653.GJ615@gaast.net>
X-Enigmail-Version: 0.76.7.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------090901000707080007050008"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090901000707080007050008
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Wilmer van der Gaast wrote:
> For security reasons, I upgraded to 2.4.23 last night. Now, suddenly, IP
> masquerading seems to be broken. When I use SNAT instead of
> masquerading, everything works.
> 
> Unfortunately, I think it's hard to reproduce the problem. Right after
> booting .23 for the first time, everything seemed to be okay. The
> problems started just an hour ago, after having the server running for
> fifteen hours without any problems.
> 
> Unfortunately there's not much more information I can provide. I can
> attach my iptables/rule/route file and keep my machine running in case
> anyone needs/wants more information. For now I'll just stick with SNAT.
> It works good enough for me.
> 
> Just FYI, and maybe someone else will have a similar problem.
> 
> Wilmer v/d Gaast. (not on the list)
I remember problem with masquerade on 2.4.22 and there was included attached 
diff on Slackware 9.1


==========================================================================
# This patch is needed in 2.4.22 or else NAT (masquerade) will not work.
# It fixes the "Rusty's broken brain" error/failure.

===== net/ipv4/netfilter/ipt_MASQUERADE.c 1.6 vs edited =====
--- 1.6/net/ipv4/netfilter/ipt_MASQUERADE.c     Tue Aug 12 11:30:12 2003
+++ edited/net/ipv4/netfilter/ipt_MASQUERADE.c  Thu Aug 28 16:54:15 2003
@@ -90,6 +90,7 @@
  #ifdef CONFIG_IP_ROUTE_FWMARK
         key.fwmark = (*pskb)->nfmark;
  #endif
+       key.oif = 0;
         if (ip_route_output_key(&rt, &key) != 0) {
                  /* Funky routing can do this. */
                  if (net_ratelimit())
==========================================================================

interesting is that 2.4.23 is pached BUT

==========================================================================

         key.tos = RT_TOS((*pskb)->nh.iph->tos)|RTO_CONN;
         key.oif = 0;
#ifdef CONFIG_IP_ROUTE_FWMARK
         key.fwmark = (*pskb)->nfmark;
#endif
         if (ip_route_output_key(&rt, &key) != 0) {
                 /* Funky routing can do this. */
==========================================================================

So problem is there perhaps, anyway edit file or patch it with att, patch
ipt_MASQ.diff


-- 
Zoran Davidovac

--------------090901000707080007050008
Content-Type: text/plain;
 name="2.4.22.nat.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2.4.22.nat.diff"

# This patch is needed in 2.4.22 or else NAT (masquerade) will not work.
# It fixes the "Rusty's broken brain" error/failure.

===== net/ipv4/netfilter/ipt_MASQUERADE.c 1.6 vs edited =====
--- 1.6/net/ipv4/netfilter/ipt_MASQUERADE.c	Tue Aug 12 11:30:12 2003
+++ edited/net/ipv4/netfilter/ipt_MASQUERADE.c	Thu Aug 28 16:54:15 2003
@@ -90,6 +90,7 @@
 #ifdef CONFIG_IP_ROUTE_FWMARK
 	key.fwmark = (*pskb)->nfmark;
 #endif
+	key.oif = 0;
 	if (ip_route_output_key(&rt, &key) != 0) {
                 /* Funky routing can do this. */
                 if (net_ratelimit())

--------------090901000707080007050008
Content-Type: text/plain;
 name="ipt_MASQUERADE.c-2.4.23.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ipt_MASQUERADE.c-2.4.23.diff"

--- ipt_MASQUERADE.c.2.4.23	2003-12-03 11:26:45.000000000 +0100
+++ ipt_MASQUERADE.c	2003-12-03 11:27:22.000000000 +0100
@@ -87,10 +87,10 @@
 	key.dst = (*pskb)->nh.iph->daddr;
 	key.src = 0; /* Unknown: that's what we're trying to establish */
 	key.tos = RT_TOS((*pskb)->nh.iph->tos)|RTO_CONN;
-	key.oif = 0;
 #ifdef CONFIG_IP_ROUTE_FWMARK
 	key.fwmark = (*pskb)->nfmark;
 #endif
+	key.oif = 0;
 	if (ip_route_output_key(&rt, &key) != 0) {
                 /* Funky routing can do this. */
                 if (net_ratelimit())

--------------090901000707080007050008--

