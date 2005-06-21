Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262120AbVFUPSc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262120AbVFUPSc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 11:18:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262112AbVFUPRd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 11:17:33 -0400
Received: from [62.206.217.67] ([62.206.217.67]:59074 "EHLO kaber.coreworks.de")
	by vger.kernel.org with ESMTP id S262119AbVFUPQU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 11:16:20 -0400
Message-ID: <42B82F35.3040909@trash.net>
Date: Tue, 21 Jun 2005 17:16:05 +0200
From: Patrick McHardy <kaber@trash.net>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.8) Gecko/20050514 Debian/1.7.8-1
X-Accept-Language: en
MIME-Version: 1.0
To: Bart De Schuymer <bdschuym@pandora.be>
CC: Bart De Schuymer <bdschuym@telenet.be>,
       Herbert Xu <herbert@gondor.apana.org.au>, netfilter-devel@manty.net,
       netfilter-devel@lists.netfilter.org, linux-kernel@vger.kernel.org,
       ebtables-devel@lists.sourceforge.net, rankincj@yahoo.com
Subject: Re: 2.6.12: connection tracking broken?
References: <E1Dk9nK-0001ww-00@gondolin.me.apana.org.au>	 <Pine.LNX.4.62.0506200432100.31737@kaber.coreworks.de>	 <1119249575.3387.3.camel@localhost.localdomain> <42B6B373.20507@trash.net>	 <1119293193.3381.9.camel@localhost.localdomain>	 <42B74FC5.3070404@trash.net> <1119338382.3390.24.camel@localhost.localdomain>
In-Reply-To: <1119338382.3390.24.camel@localhost.localdomain>
Content-Type: multipart/mixed;
 boundary="------------000506000503090704000107"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000506000503090704000107
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Bart De Schuymer wrote:
> Deferring the hooks makes the bridge-nf code alot more complicated, so I
> would be glad to get rid of it if it is the right thing to do. But
> backwards compatibility can't be maintained and I'd be surprised if
> every ruleset that now works will still be possible using an
> iptables/ebtables scheme.

I unfortunately don't see a way to remove it, but we should keep
thinking about it. Can you please check if the attached patch is
correct? It should exclude all packets handled by bridge-netfilter
from having their conntrack reference dropped. I didn't add nf_reset()'s
to the bridging code because with tc actions the packets can end up
anywhere else anyway, and this will hopefully get fixed right sometime.

BTW. this line from ip_sabotage_out() looks wrong, it will clear all
flags instead of setting the BRNF_DONT_TAKE_PARENT flag (second
patch):

                        nf_bridge->mask &= BRNF_DONT_TAKE_PARENT;

Signed-off-by: Patrick McHardy <kaber@trash.net>

--------------000506000503090704000107
Content-Type: text/plain;
 name="x"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="x"

diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -188,7 +188,12 @@ static inline int ip_finish_output2(stru
 		skb = skb2;
 	}
 
-	nf_reset(skb);
+#ifdef CONFIG_BRIDGE_NETFILTER
+	/* bridge-netfilter defers calling some IP hooks to the bridge layer and
+	 * still needs the conntrack reference */
+	if (skb->nf_bridge == NULL)
+#endif
+		nf_reset(skb);
 
 	if (hh) {
 		int hh_alen;

--------------000506000503090704000107
Content-Type: text/x-patch;
 name="10.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="10.diff"

diff --git a/net/bridge/br_netfilter.c b/net/bridge/br_netfilter.c
--- a/net/bridge/br_netfilter.c
+++ b/net/bridge/br_netfilter.c
@@ -882,7 +882,7 @@ static unsigned int ip_sabotage_out(unsi
 		 * doesn't use the bridge parent of the indev by using
 		 * the BRNF_DONT_TAKE_PARENT mask. */
 		if (hook == NF_IP_FORWARD && nf_bridge->physindev == NULL) {
-			nf_bridge->mask &= BRNF_DONT_TAKE_PARENT;
+			nf_bridge->mask |= BRNF_DONT_TAKE_PARENT;
 			nf_bridge->physindev = (struct net_device *)in;
 		}
 #if defined(CONFIG_VLAN_8021Q) || defined(CONFIG_VLAN_8021Q_MODULE)

--------------000506000503090704000107--
