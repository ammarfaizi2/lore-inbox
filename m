Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262438AbRENT5W>; Mon, 14 May 2001 15:57:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262441AbRENT5M>; Mon, 14 May 2001 15:57:12 -0400
Received: from c1473286-a.stcla1.sfba.home.com ([24.176.137.160]:25604 "HELO
	ocean.lucon.org") by vger.kernel.org with SMTP id <S262438AbRENT5I>;
	Mon, 14 May 2001 15:57:08 -0400
Date: Mon, 14 May 2001 12:57:06 -0700
From: "H . J . Lu" <hjl@lucon.org>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: =?iso-8859-1?Q?Mads_Martin_J=F8rgensen?= <mmj@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Manfred Spraul <manfred@colorfullife.com>,
        Yann Dupont <Yann.Dupont@IPv6.univ-nantes.fr>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: PATCH 2.4.4.ac9: BOOTP/DHCP
Message-ID: <20010514125706.A26901@lucon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 14, 2001 at 12:02:48PM -0700, H . J . Lu wrote:
> 
> BTW, I cannot select both CONFIG_IP_PNP_DHCP and CONFIG_IP_PNP_BOOTP.
> BOOTP doesn' work even if I pass "ip=bootp" to kernel. I will take
> a look.
> 
> 

Here is a patch. We should do DHCP iff it is enabled.


H.J.
--- linux-2.4.4-ac9/net/ipv4/ipconfig.c.auto	Mon May 14 12:18:18 2001
+++ linux-2.4.4-ac9/net/ipv4/ipconfig.c	Mon May 14 12:52:51 2001
@@ -816,61 +816,63 @@ static int __init ic_bootp_recv(struct s
 		u8 *ext;
 
 #ifdef IPCONFIG_DHCP
+		if (ic_proto_enabled & IC_USE_DHCP) {
 
-		u32 server_id = INADDR_NONE;
-		int mt = 0;
+			u32 server_id = INADDR_NONE;
+			int mt = 0;
 
-		ext = &b->exten[4];
-		while (ext < end && *ext != 0xff) {
-			u8 *opt = ext++;
-			if (*opt == 0)	/* Padding */
-				continue;
-			ext += *ext + 1;
-			if (ext >= end)
-				break;
-			switch (*opt) {
-			case 53:	/* Message type */
-				if (opt[1])
-					mt = opt[2];
-				break;
-			case 54:	/* Server ID (IP address) */
-				if (opt[1] >= 4)
-					memcpy(&server_id, opt + 2, 4);
-				break;
+			ext = &b->exten[4];
+			while (ext < end && *ext != 0xff) {
+				u8 *opt = ext++;
+				if (*opt == 0)	/* Padding */
+					continue;
+				ext += *ext + 1;
+				if (ext >= end)
+					break;
+				switch (*opt) {
+				case 53:	/* Message type */
+					if (opt[1])
+						mt = opt[2];
+					break;
+				case 54:	/* Server ID (IP address) */
+					if (opt[1] >= 4)
+						memcpy(&server_id, opt + 2, 4);
+					break;
+				}
 			}
-		}
 
 #ifdef IPCONFIG_DEBUG
-		printk("DHCP: Got message type %d\n", mt);
+			printk("DHCP: Got message type %d\n", mt);
 #endif
 
-		switch (mt) {
-		    case DHCPOFFER:
-			/* While in the process of accepting one offer,
-			   ignore all others. */
-			if (ic_myaddr != INADDR_NONE)
-				goto drop;
-			/* Let's accept that offer. */
-			ic_myaddr = b->your_ip;
-			ic_servaddr = server_id;
+			switch (mt) {
+			case DHCPOFFER:
+				/* While in the process of accepting one offer,
+				   ignore all others. */
+				if (ic_myaddr != INADDR_NONE)
+					goto drop;
+				/* Let's accept that offer. */
+				ic_myaddr = b->your_ip;
+				ic_servaddr = server_id;
 #ifdef IPCONFIG_DEBUG
-			printk("DHCP: Offered address %u.%u.%u.%u", NIPQUAD(ic_myaddr));
-			printk(" by server %u.%u.%u.%u\n", NIPQUAD(ic_servaddr));
+				printk("DHCP: Offered address %u.%u.%u.%u", NIPQUAD(ic_myaddr));
+				printk(" by server %u.%u.%u.%u\n", NIPQUAD(ic_servaddr));
 #endif
-			break;
+				break;
 
-		    case DHCPACK:
-			/* Yeah! */
-			break;
-
-		    default:
-			/* Urque.  Forget it*/
-			ic_myaddr = INADDR_NONE;
-			ic_servaddr = INADDR_NONE;
-			goto drop;
-		}
+			case DHCPACK:
+				/* Yeah! */
+				break;
+
+			default:
+				/* Urque.  Forget it*/
+				ic_myaddr = INADDR_NONE;
+				ic_servaddr = INADDR_NONE;
+				goto drop;
+			}
 
-		ic_dhcp_msgtype = mt;
+			ic_dhcp_msgtype = mt;
+		}
 
 #endif /* IPCONFIG_DHCP */
 
