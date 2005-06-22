Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262573AbVFVXHf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262573AbVFVXHf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 19:07:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262560AbVFVXC4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 19:02:56 -0400
Received: from web52903.mail.yahoo.com ([206.190.39.180]:49015 "HELO
	web52903.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262557AbVFVW6V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 18:58:21 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=TVjCzz7mllvHfiKSBZJgBl7QRBdU/ElA/66GpV9XUcTVB+MGqL62I3a2keRXrtmdHpvskybLFZ/KO9ZL4IjrUxwFHhDvP2rZtRoS8oGYvgWFoH6PCIkLtqW1xFbRi/Kej+maE17SET4d2PzuvSw3XjzWJ2kFMGQ3nQtRJcptRbw=  ;
Message-ID: <20050622225816.97752.qmail@web52903.mail.yahoo.com>
Date: Wed, 22 Jun 2005 23:58:16 +0100 (BST)
From: Chris Rankin <rankincj@yahoo.com>
Subject: Re: 2.6.12: connection tracking broken?
To: Patrick McHardy <kaber@trash.net>, "David S. Miller" <davem@davemloft.net>
Cc: chrisw@osdl.org, bdschuym@pandora.be, bdschuym@telenet.be,
       herbert@gondor.apana.org.au, netfilter-devel@lists.netfilter.org,
       linux-kernel@vger.kernel.org, rankincj@yahoo.com,
       ebtables-devel@lists.sourceforge.net, netfilter-devel@manty.net
In-Reply-To: <42B8B035.7020303@trash.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Patrick McHardy <kaber@trash.net> wrote:
> I would like to get confirmation from someone affected by this
> bug, after that I think it should go in -stable. Chris, could
> you give it a try?

I trust you're talking about the following patches?

diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -188,7 +188,12 @@ static inline int ip_finish_output2(stru
                skb = skb2;
        }

-       nf_reset(skb);
+#ifdef CONFIG_BRIDGE_NETFILTER
+       /* bridge-netfilter defers calling some IP hooks to the bridge layer and
+        * still needs the conntrack reference */
+       if (skb->nf_bridge == NULL)
+#endif
+               nf_reset(skb);

        if (hh) {
                int hh_alen;

diff --git a/net/bridge/br_netfilter.c b/net/bridge/br_netfilter.c
--- a/net/bridge/br_netfilter.c
+++ b/net/bridge/br_netfilter.c
@@ -882,7 +882,7 @@ static unsigned int ip_sabotage_out(unsi
                 * doesn't use the bridge parent of the indev by using
                 * the BRNF_DONT_TAKE_PARENT mask. */
                if (hook == NF_IP_FORWARD && nf_bridge->physindev == NULL) {
-                       nf_bridge->mask &= BRNF_DONT_TAKE_PARENT;
+                       nf_bridge->mask |= BRNF_DONT_TAKE_PARENT;
                        nf_bridge->physindev = (struct net_device *)in;
                }
 #if defined(CONFIG_VLAN_8021Q) || defined(CONFIG_VLAN_8021Q_MODULE)

I have just installed them, and my bridging firewall is working again with 2.6.12.

Thanks,
Chris



		
___________________________________________________________ 
How much free photo storage do you get? Store your holiday 
snaps for FREE with Yahoo! Photos http://uk.photos.yahoo.com
