Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131219AbRDPMBp>; Mon, 16 Apr 2001 08:01:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131248AbRDPMBf>; Mon, 16 Apr 2001 08:01:35 -0400
Received: from vp175062.reshsg.uci.edu ([128.195.175.62]:55812 "EHLO
	moisil.dev.hydraweb.com") by vger.kernel.org with ESMTP
	id <S131219AbRDPMBR>; Mon, 16 Apr 2001 08:01:17 -0400
Date: Mon, 16 Apr 2001 04:59:46 -0700
Message-Id: <200104161159.f3GBxkc06110@moisil.dev.hydraweb.com>
From: Ion Badulescu <ionut@moisil.cs.columbia.edu>
To: umam@delhi.tcs.co.in
Cc: linux-kernel@vger.kernel.org
Subject: Re: VRRP related
In-Reply-To: <3ADAFC74.3905C4D3@delhi.tcs.co.in>
User-Agent: tin/1.5.7-20001104 ("Paradise Regained") (UNIX) (Linux/2.2.19 (i586))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Apr 2001 15:06:44 +0100, umam@delhi.tcs.co.in wrote:
> 
> Hi,
> I am trying to put virtual mac address at the place of physical mac
> address , for that I have overwrite source hardware address with virtual
> address.Now when I try to ping to this machine with some other
> machine.It says request time out.While checking arp -a , gives me
> virtual mac address in ARP-Table instead of physical mac address.I want
> it should give response to ping  also.what I can do????

1. Get a card that accepts non-multicast MAC addresses in its hardware
filter. eepro100, tulip, starfire will do. 3c59x won't (well newer cards
have the capability, but the driver doesn't support it).

2. Apply the attached patch and enable "Ethernet Virtual MAC support".

3. Tell the card about your VMAC using ipmaddr.

The patch slows down the fast receive patch, I know, but I don't see
a way around it. It's against 2.4.recent, I haven't looked at 2.2.

Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.
-----------------------
--- linux-2.4/net/ethernet/eth.c.old	Tue Nov 14 20:18:52 2000
+++ linux-2.4/net/ethernet/eth.c	Tue Nov 14 20:30:45 2000
@@ -203,8 +203,21 @@
 	 
 	else if(1 /*dev->flags&IFF_PROMISC*/)
 	{
-		if(memcmp(eth->h_dest,dev->dev_addr, ETH_ALEN))
+#ifdef CONFIG_NET_VMAC
+		if (memcmp(eth->h_dest,dev->dev_addr, ETH_ALEN)) {
+			struct dev_mc_list *mc_addr = dev->mc_list;
+			while (mc_addr) {
+				if (memcmp(mc_addr->dmi_addr, dev->dev_addr, ETH_ALEN))
+					goto loose_local;
+				mc_addr = mc_addr->next;
+			}
 			skb->pkt_type=PACKET_OTHERHOST;
+		loose_local:
+		}
+#else  /* not CONFIG_NET_VMAC */
+		if (memcmp(eth->h_dest,dev->dev_addr, ETH_ALEN))
+			skb->pkt_type=PACKET_OTHERHOST;
+#endif /* not CONFIG_NET_VMAC */
 	}
 	
 	if (ntohs(eth->h_proto) >= 1536)
--- linux-2.4/net/Config.in.old	Tue Nov 14 20:29:37 2000
+++ linux-2.4/net/Config.in	Tue Nov 14 20:30:31 2000
@@ -64,6 +64,7 @@
    tristate 'LAPB Data Link Driver (EXPERIMENTAL)' CONFIG_LAPB
    bool '802.2 LLC (EXPERIMENTAL)' CONFIG_LLC
    bool 'Frame Diverter (EXPERIMENTAL)' CONFIG_NET_DIVERT
+   bool 'Ethernet Virtual MAC support (EXPERIMENTAL)' CONFIG_NET_VMAC
 #   if [ "$CONFIG_LLC" = "y" ]; then
 #      bool '  Netbeui (EXPERIMENTAL)' CONFIG_NETBEUI
 #   fi
