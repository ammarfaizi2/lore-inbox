Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272269AbRH3Pc2>; Thu, 30 Aug 2001 11:32:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272279AbRH3PcT>; Thu, 30 Aug 2001 11:32:19 -0400
Received: from c1473286-a.stcla1.sfba.home.com ([24.176.137.160]:22277 "HELO
	ocean.lucon.org") by vger.kernel.org with SMTP id <S272269AbRH3PcC>;
	Thu, 30 Aug 2001 11:32:02 -0400
Date: Thu, 30 Aug 2001 08:32:17 -0700
From: "H . J . Lu" <hjl@lucon.org>
To: Ian.Dall@dsto.defence.gov.au
Cc: "Torvalds; Linus" <torvalds@transmeta.com>,
        linux kernel <linux-kernel@vger.kernel.org>, alan@redhat.com
Subject: Re: IPCONFIG fails for BOOTP
Message-ID: <20010830083217.A8134@lucon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the patch I have been using since May.


H.J.
----
--- linux-2.4.5-ac3-ext3/net/ipv4/ipconfig.c.dhcp	Tue May  1 20:59:24 2001
+++ linux-2.4.5-ac3-ext3/net/ipv4/ipconfig.c	Tue May 29 09:30:16 2001
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
 
