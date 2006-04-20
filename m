Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750817AbWDTKJm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750817AbWDTKJm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 06:09:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750820AbWDTKJm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 06:09:42 -0400
Received: from dobermann.cosy.sbg.ac.at ([141.201.2.56]:1422 "EHLO
	dobermann.cosy.sbg.ac.at") by vger.kernel.org with ESMTP
	id S1750817AbWDTKJl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 06:09:41 -0400
Message-ID: <44475DDD.1020206@cosy.sbg.ac.at>
Date: Thu, 20 Apr 2006 12:09:33 +0200
From: Christian Praehauser <cpraehaus@cosy.sbg.ac.at>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-dvb-maintainer@linuxtv.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dvb-core: ULE fixes and RFC4326 additions (kernel 2.6.16)
References: <44465208.5030004@cosy.sbg.ac.at> <20060419235349.2b1840c0.akpm@osdl.org>
In-Reply-To: <20060419235349.2b1840c0.akpm@osdl.org>
Content-Type: multipart/mixed;
 boundary="------------090409080706070700020507"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090409080706070700020507
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello again!
After correcting the broadcast address i saw that broadcast packets are 
not accepted when in "multicast" mode (RX_MODE_MULTI).
In the attached version of the patch this was fixed.

Best wishes,
Christian.
-- 
________________________________________
| Christian Praehauser                  |
|---------------------------------------|
| Email:                                |
|  cpraehaus@cosy.sbg.ac.at             |
| Address:                              |
|  Institut fuer Computerwissenschaften |
|  Jakob-Haringer-Strasse 2             |
|  A-5020 Salzburg, Austria             |
|_______________________________________|



--------------090409080706070700020507
Content-Type: text/x-patch;
 name="dvb_net_ule_rfc4326_fixed.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dvb_net_ule_rfc4326_fixed.patch"

--- drivers/media/dvb/dvb-core/dvb_net.c.orig	2006-04-19 15:12:31.000000000 +0200
+++ drivers/media/dvb/dvb-core/dvb_net.c	2006-04-20 11:04:18.000000000 +0200
@@ -12,7 +12,7 @@
  *                          Hilmar Linder <hlinder@cosy.sbg.ac.at>
  *                      and Wolfram Stering <wstering@cosy.sbg.ac.at>
  *
- * ULE Decaps according to draft-ietf-ipdvb-ule-03.txt.
+ * ULE Decaps according to RFC 4326.
  *
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License
@@ -42,6 +42,9 @@
  *                     Bugfixes and robustness improvements.
  *                     Filtering on dest MAC addresses, if present (D-Bit = 0)
  *                     ULE_DEBUG compile-time option.
+ * Apr 2006: cp v3:    Bugfixes and compliency with RFC 4326 (ULE) by 
+ *                       Christian Praehauser <cpraehaus@cosy.sbg.ac.at>, 
+ *                       Paris Lodron University of Salzburg.
  */
 
 /*
@@ -49,9 +52,6 @@
  *
  * Unloading does not work for 2.6.9 kernels: a refcount doesn't go to zero.
  *
- * TS_FEED callback is called once for every single TS cell although it is
- * registered (in dvb_net_feed_start()) for 100 TS cells (used for dvb_net_ule()).
- *
  */
 
 #include <linux/module.h>
@@ -88,6 +88,9 @@ static inline __u32 iov_crc32( __u32 c, 
 
 #ifdef ULE_DEBUG
 
+#define MAC_ADDR_PRINTFMT "%.2x:%.2x:%.2x:%.2x:%.2x:%.2x"
+#define MAX_ADDR_PRINTFMT_ARGS(macap) (macap)[0],(macap)[1],(macap)[2],(macap)[3],(macap)[4],(macap)[5]
+
 #define isprint(c)	((c >= 'a' && c <= 'z') || (c >= 'A' && c <= 'Z') || (c >= '0' && c <= '9'))
 
 static void hexdump( const unsigned char *buf, unsigned short len )
@@ -214,6 +217,8 @@ static unsigned short dvb_net_eth_type_t
 #define ULE_TEST	0
 #define ULE_BRIDGED	1
 
+#define ULE_OPTEXTHDR_PADDING 0
+
 static int ule_test_sndu( struct dvb_net_priv *p )
 {
 	return -1;
@@ -221,14 +226,28 @@ static int ule_test_sndu( struct dvb_net
 
 static int ule_bridged_sndu( struct dvb_net_priv *p )
 {
-	/* BRIDGE SNDU handling sucks in draft-ietf-ipdvb-ule-03.txt.
-	 * This has to be the last extension header, otherwise it won't work.
-	 * Blame the authors!
+	struct ethhdr *hdr = (struct ethhdr*) p->ule_next_hdr;
+	if(ntohs(hdr->h_proto) < 1536) {
+		int framelen = p->ule_sndu_len - ((p->ule_next_hdr+sizeof(struct ethhdr)) - p->ule_skb->data);
+		/* A frame Type < 1536 for a bridged frame, introduces a LLC Length field. */
+		if(framelen != ntohs(hdr->h_proto)) {
+			return -1;
+		}
+	}
+	/* Note:
+	 * From RFC4326:
+	 *  "A bridged SNDU is a Mandatory Extension Header of Type 1. 
+	 *   It must be the final (or only) extension header specified in the header chain of a SNDU."
+	 * The 'ule_bridged' flag will cause the extension header processing loop to terminate.
 	 */
 	p->ule_bridged = 1;
 	return 0;
 }
 
+static int ule_exthdr_padding( struct dvb_net_priv *p )
+{
+	return 0;
+}
 
 /** Handle ULE extension headers.
  *  Function is called after a successful CRC32 verification of an ULE SNDU to complete its decoding.
@@ -242,7 +261,8 @@ static int handle_one_ule_extension( str
 		{ [0] = ule_test_sndu, [1] = ule_bridged_sndu, [2] = NULL,  };
 
 	/* Table of optional extension header handlers.  The header type is the index. */
-	static int (*ule_optional_ext_handlers[255])( struct dvb_net_priv *p ) = { NULL, };
+	static int (*ule_optional_ext_handlers[255])( struct dvb_net_priv *p ) = 
+		{ [0] = ule_exthdr_padding, [1] = NULL, };
 
 	int ext_len = 0;
 	unsigned char hlen = (p->ule_sndu_type & 0x0700) >> 8;
@@ -253,25 +273,28 @@ static int handle_one_ule_extension( str
 		/* Mandatory extension header */
 		if (ule_mandatory_ext_handlers[htype]) {
 			ext_len = ule_mandatory_ext_handlers[htype]( p );
-			p->ule_next_hdr += ext_len;
-			if (! p->ule_bridged) {
-				p->ule_sndu_type = ntohs( *(unsigned short *)p->ule_next_hdr );
-				p->ule_next_hdr += 2;
-			} else {
-				p->ule_sndu_type = ntohs( *(unsigned short *)(p->ule_next_hdr + ((p->ule_dbit ? 2 : 3) * ETH_ALEN)) );
-				/* This assures the extension handling loop will terminate. */
+			if(ext_len >= 0) {
+				p->ule_next_hdr += ext_len;
+				if (! p->ule_bridged) {
+					p->ule_sndu_type = ntohs( *(unsigned short *)p->ule_next_hdr );
+					p->ule_next_hdr += 2;
+				} else {
+					p->ule_sndu_type = ntohs( *(unsigned short *)(p->ule_next_hdr + ((p->ule_dbit ? 2 : 3) * ETH_ALEN)) );
+					/* This assures the extension handling loop will terminate. */
+				}
 			}
+			// else: extension handler failed or SNDU should be discarded
 		} else
 			ext_len = -1;	/* SNDU has to be discarded. */
 	} else {
 		/* Optional extension header.  Calculate the length. */
-		ext_len = hlen << 2;
+		ext_len = hlen << 1;
 		/* Process the optional extension header according to its type. */
 		if (ule_optional_ext_handlers[htype])
 			(void)ule_optional_ext_handlers[htype]( p );
 		p->ule_next_hdr += ext_len;
-		p->ule_sndu_type = ntohs( *(unsigned short *)p->ule_next_hdr );
-		p->ule_next_hdr += 2;
+		p->ule_sndu_type = ntohs( *(unsigned short *)(p->ule_next_hdr-2) );
+		/* note: the length of the next header type is included in the length of THIS optional extension header */
 	}
 
 	return ext_len;
@@ -284,8 +307,11 @@ static int handle_ule_extensions( struct
 	p->ule_next_hdr = p->ule_skb->data;
 	do {
 		l = handle_one_ule_extension( p );
-		if (l == -1) return -1;	/* Stop extension header processing and discard SNDU. */
+		if (l < 0) return l;	/* Stop extension header processing and discard SNDU. */
 		total_ext_len += l;
+#ifdef ULE_DEBUG
+		dprintk("handle_ule_extensions: ule_next_hdr=%p, ule_sndu_type=%i, l=%i, total_ext_len=%i\n", p->ule_next_hdr, (int) p->ule_sndu_type, l, total_ext_len);
+#endif
 
 	} while (p->ule_sndu_type < 1536);
 
@@ -355,8 +381,8 @@ static void dvb_net_ule( struct net_devi
 				if (priv->ule_skb) {
 					dev_kfree_skb( priv->ule_skb );
 					/* Prepare for next SNDU. */
-					((struct dvb_net_priv *) dev->priv)->stats.rx_errors++;
-					((struct dvb_net_priv *) dev->priv)->stats.rx_frame_errors++;
+					priv->stats.rx_errors++;
+					priv->stats.rx_frame_errors++;
 				}
 				reset_ule(priv);
 				priv->need_pusi = 1;
@@ -396,27 +422,25 @@ static void dvb_net_ule( struct net_devi
 			}
 		}
 
-		/* Check continuity counter. */
 		if (new_ts) {
+			/* Check continuity counter. */
 			if ((ts[3] & 0x0F) == priv->tscc)
 				priv->tscc = (priv->tscc + 1) & 0x0F;
 			else {
 				/* TS discontinuity handling: */
 				printk(KERN_WARNING "%lu: TS discontinuity: got %#x, "
-				       "exptected %#x.\n", priv->ts_count, ts[3] & 0x0F, priv->tscc);
+				       "expected %#x.\n", priv->ts_count, ts[3] & 0x0F, priv->tscc);
 				/* Drop partly decoded SNDU, reset state, resync on PUSI. */
 				if (priv->ule_skb) {
 					dev_kfree_skb( priv->ule_skb );
 					/* Prepare for next SNDU. */
 					// reset_ule(priv);  moved to below.
-					((struct dvb_net_priv *) dev->priv)->stats.rx_errors++;
-					((struct dvb_net_priv *) dev->priv)->stats.rx_frame_errors++;
+					priv->stats.rx_errors++;
+					priv->stats.rx_frame_errors++;
 				}
 				reset_ule(priv);
 				/* skip to next PUSI. */
 				priv->need_pusi = 1;
-				ts += TS_SZ;
-				priv->ts_count++;
 				continue;
 			}
 			/* If we still have an incomplete payload, but PUSI is
@@ -425,7 +449,7 @@ static void dvb_net_ule( struct net_devi
 			 * cells (continuity counter wrap). */
 			if (ts[1] & TS_PUSI) {
 				if (! priv->need_pusi) {
-					if (*from_where > 181) {
+					if (!(*from_where < (ts_remain-1)) || *from_where != priv->ule_sndu_remain) {
 						/* Pointer field is invalid.  Drop this TS cell and any started ULE SNDU. */
 						printk(KERN_WARNING "%lu: Invalid pointer "
 						       "field: %u.\n", priv->ts_count, *from_where);
@@ -438,8 +462,6 @@ static void dvb_net_ule( struct net_devi
 						}
 						reset_ule(priv);
 						priv->need_pusi = 1;
-						ts += TS_SZ;
-						priv->ts_count++;
 						continue;
 					}
 					/* Skip pointer field (we're processing a
@@ -452,8 +474,8 @@ static void dvb_net_ule( struct net_devi
 				if (priv->ule_sndu_remain > 183) {
 					/* Current SNDU lacks more data than there could be available in the
 					 * current TS cell. */
-					((struct dvb_net_priv *) dev->priv)->stats.rx_errors++;
-					((struct dvb_net_priv *) dev->priv)->stats.rx_length_errors++;
+					priv->stats.rx_errors++;
+					priv->stats.rx_length_errors++;
 					printk(KERN_WARNING "%lu: Expected %d more SNDU bytes, but "
 					       "got PUSI (pf %d, ts_remain %d).  Flushing incomplete payload.\n",
 					       priv->ts_count, priv->ule_sndu_remain, ts[4], ts_remain);
@@ -492,9 +514,11 @@ static void dvb_net_ule( struct net_devi
 				} else
 					priv->ule_dbit = 0;
 
-				if (priv->ule_sndu_len > 32763) {
+				if (priv->ule_sndu_len < 5) {
 					printk(KERN_WARNING "%lu: Invalid ULE SNDU length %u. "
 					       "Resyncing.\n", priv->ts_count, priv->ule_sndu_len);
+					priv->stats.rx_errors++;
+					priv->stats.rx_length_errors++;
 					priv->ule_sndu_len = 0;
 					priv->need_pusi = 1;
 					new_ts = 1;
@@ -608,11 +632,64 @@ static void dvb_net_ule( struct net_devi
 				ule_dump = 1;
 #endif
 
-				((struct dvb_net_priv *) dev->priv)->stats.rx_errors++;
-				((struct dvb_net_priv *) dev->priv)->stats.rx_crc_errors++;
+				priv->stats.rx_errors++;
+				priv->stats.rx_crc_errors++;
 				dev_kfree_skb(priv->ule_skb);
 			} else {
 				/* CRC32 verified OK. */
+				u8 dest_addr[ETH_ALEN];
+				static const u8 bc_addr[ETH_ALEN] = { [ 0 ... ETH_ALEN-1] = 0xFF};
+
+				/* CRC32 was OK. Remove it from skb. */
+				priv->ule_skb->tail -= 4;
+				priv->ule_skb->len -= 4;
+
+				if (!priv->ule_dbit) {
+					/* The destination MAC address is the next data in the skb. 
+					 * It comes before any extension headers.
+					 *
+					 * Check, if the payload of this SNDU should be passed up the stack.
+					 */
+					register int drop = 0;
+					if(priv->rx_mode != RX_MODE_PROMISC) {
+						if(priv->ule_skb->data[0] & 0x01) {
+							/* multicast or broadcast */
+							if(memcmp( priv->ule_skb->data, bc_addr, ETH_ALEN )) {
+								/* multicast */
+								if(priv->rx_mode == RX_MODE_MULTI) {
+									int i;
+									for(i=0; i<priv->multi_num && memcmp( priv->ule_skb->data, priv->multi_macs[i], ETH_ALEN ); i++);
+									if(i == priv->multi_num)
+										drop = 1;
+								}
+								else if(priv->rx_mode != RX_MODE_ALL_MULTI)
+									drop = 1; /* no broadcast; */
+								/* else: all multicast mode: accept all multicast packets */
+							}
+							/* else: broadcast */
+						}
+						else if(memcmp( priv->ule_skb->data, dev->dev_addr, ETH_ALEN )) 
+							drop = 1;
+						/* else: destination address matches the MAC address of our receiver device */
+					}
+					/* else: promiscious mode; pass everything up the stack */
+						
+					if(drop)
+					{
+#ifdef ULE_DEBUG
+						dprintk( "Dropping SNDU: MAC destination address does not match: dest addr: "MAC_ADDR_PRINTFMT", dev addr: "MAC_ADDR_PRINTFMT"\n", 
+							MAX_ADDR_PRINTFMT_ARGS(priv->ule_skb->data), MAX_ADDR_PRINTFMT_ARGS(dev->dev_addr));
+#endif
+						dev_kfree_skb( priv->ule_skb );
+						goto sndu_done;
+					}
+					else
+					{
+						memcpy(dest_addr,  priv->ule_skb->data, ETH_ALEN);
+						skb_pull( priv->ule_skb, ETH_ALEN );
+					}
+				}
+				
 				/* Handle ULE Extension Headers. */
 				if (priv->ule_sndu_type < 1536) {
 					/* There is an extension header.  Handle it accordingly. */
@@ -626,40 +703,25 @@ static void dvb_net_ule( struct net_devi
 					skb_pull( priv->ule_skb, l );
 				}
 
-				/* CRC32 was OK. Remove it from skb. */
-				priv->ule_skb->tail -= 4;
-				priv->ule_skb->len -= 4;
-
-				/* Filter on receiver's destination MAC address, if present. */
-				if (!priv->ule_dbit) {
-					/* The destination MAC address is the next data in the skb. */
-					if (memcmp( priv->ule_skb->data, dev->dev_addr, ETH_ALEN )) {
-						/* MAC addresses don't match.  Drop SNDU. */
-						// printk( KERN_WARNING "Dropping SNDU, MAC address.\n" );
-						dev_kfree_skb( priv->ule_skb );
-						goto sndu_done;
-					}
-					if (! priv->ule_bridged) {
-						skb_push( priv->ule_skb, ETH_ALEN + 2 );
-						ethh = (struct ethhdr *)priv->ule_skb->data;
-						memcpy( ethh->h_dest, ethh->h_source, ETH_ALEN );
+				/* Construct/assure correct ethernet header.
+				 * Note: in bridged mode (priv->ule_bridged != 0) we already have the (original) ethernet header
+				 * at the start of the payload (after optional dest. address and any extension headers).
+				 * */
+				
+				if (! priv->ule_bridged) {
+					skb_push( priv->ule_skb, ETH_HLEN);
+					ethh = (struct ethhdr *)priv->ule_skb->data;
+					if(!priv->ule_dbit) /* dest_addr buffer is only valid if priv->ule_dbit == 0 */
+					{
+						memcpy( ethh->h_dest, dest_addr, ETH_ALEN );
 						memset( ethh->h_source, 0, ETH_ALEN );
-						ethh->h_proto = htons( priv->ule_sndu_type );
-					} else {
-						/* Skip the Receiver destination MAC address. */
-						skb_pull( priv->ule_skb, ETH_ALEN );
-					}
-				} else {
-					if (! priv->ule_bridged) {
-						skb_push( priv->ule_skb, ETH_HLEN );
-						ethh = (struct ethhdr *)priv->ule_skb->data;
-						memcpy( ethh->h_dest, dev->dev_addr, ETH_ALEN );
-						memset( ethh->h_source, 0, ETH_ALEN );
-						ethh->h_proto = htons( priv->ule_sndu_type );
-					} else {
-						/* skb is in correct state; nothing to do. */
 					}
+					else /* zeroize source and dest */
+						memset( ethh, 0, ETH_ALEN*2 );
+
+					ethh->h_proto = htons( priv->ule_sndu_type );
 				}
+				/* else:  skb is in correct state; nothing to do. */
 				priv->ule_bridged = 0;
 
 				/* Stuff into kernel's protocol stack. */
@@ -668,8 +730,8 @@ static void dvb_net_ule( struct net_devi
 				 * receive the packet anyhow. */
 				/* if (priv->ule_dbit && skb->pkt_type == PACKET_OTHERHOST)
 					priv->ule_skb->pkt_type = PACKET_HOST; */
-				((struct dvb_net_priv *) dev->priv)->stats.rx_packets++;
-				((struct dvb_net_priv *) dev->priv)->stats.rx_bytes += priv->ule_skb->len;
+				priv->stats.rx_packets++;
+				priv->stats.rx_bytes += priv->ule_skb->len;
 				netif_rx(priv->ule_skb);
 			}
 			sndu_done:
@@ -944,7 +1006,7 @@ static int dvb_net_feed_start(struct net
 		dprintk("%s: start filtering\n", __FUNCTION__);
 		priv->secfeed->start_filtering(priv->secfeed);
 	} else if (priv->feedtype == DVB_NET_FEEDTYPE_ULE) {
-		struct timespec timeout = { 0, 30000000 }; // 30 msec
+		struct timespec timeout = { 0, 10000000 }; // 10 msec
 
 		/* we have payloads encapsulated in TS */
 		dprintk("%s: alloc tsfeed\n", __FUNCTION__);
@@ -956,10 +1018,13 @@ static int dvb_net_feed_start(struct net
 
 		/* Set netdevice pointer for ts decaps callback. */
 		priv->tsfeed->priv = (void *)dev;
-		ret = priv->tsfeed->set(priv->tsfeed, priv->pid,
-					TS_PACKET, DMX_TS_PES_OTHER,
+		ret = priv->tsfeed->set(priv->tsfeed,
+					priv->pid, /* pid */
+					TS_PACKET, /* type */
+					DMX_TS_PES_OTHER, /* pes type */
 					32768,     /* circular buffer size */
-					timeout);
+					timeout    /* timeout */
+					);
 
 		if (ret < 0) {
 			printk("%s: could not set ts feed\n", dev->name);

--------------090409080706070700020507--
