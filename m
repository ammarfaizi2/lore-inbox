Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313264AbSDUAmc>; Sat, 20 Apr 2002 20:42:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313288AbSDUAmb>; Sat, 20 Apr 2002 20:42:31 -0400
Received: from ip68-3-16-134.ph.ph.cox.net ([68.3.16.134]:26057 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S313264AbSDUAmY>;
	Sat, 20 Apr 2002 20:42:24 -0400
Message-ID: <3CC20AED.4000007@candelatech.com>
Date: Sat, 20 Apr 2002 17:42:21 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20011019 Netscape6/6.2
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@redhat.com>
Subject: PATCH:  pktgen.c update
Content-Type: multipart/mixed;
 boundary="------------070007070600010608010603"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070007070600010608010603
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

I got all excited about the pktgen.c module, and went in and
changed it significantly to suite my needs better.  I would
be happy to see these changes integrated into the mainstream kernel,
but even if that is not appropriate, I will appreciate any
feedback, especially about how to make it sleep more efficiently
when there is an inter-packet-gap set.

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear


--------------070007070600010608010603
Content-Type: text/plain;
 name="patch2.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch2.txt"

--- linux/net/core/pktgen.c	Sat Apr 20 17:28:52 2002
+++ linux.dev/net/core/pktgen.c	Sat Apr 20 17:27:55 2002
@@ -1,4 +1,5 @@
-/* $Id: pktgen.c,v 1.1.2.1 2002/03/01 12:15:05 davem Exp $
+/* -*-linux-c-*-
+ * $Id: pktgen.c,v 1.1.2.1 2002/03/01 12:15:05 davem Exp $
  * pktgen.c: Packet Generator for performance evaluation.
  *
  * Copyright 2001, 2002 by Robert Olsson <robert.olsson@its.uu.se>
@@ -18,6 +19,20 @@
  * MAC address typo fixed. 010417 --ro
  * Integrated.  020301 --DaveM
  * Added multiskb option 020301 --DaveM
+ * Significant re-work of the module:
+ *   *  Updated to support generation over multiple interfaces at once
+ *       by creating 32 /proc/net/pg* files.  Each file can be manipulated
+ *       individually.
+ *   *  Converted many counters to __u64 to allow longer runs.
+ *   *  Allow configuration of ranges, like min/max IP address, MACs,
+ *       and UDP-ports, for both source and destination, and can
+ *       set to use a random distribution or sequentially walk the range.
+ *   *  Can now change some values after starting.
+ *   *  Place 12-byte packet in UDP payload with magic number,
+ *       sequence number, and timestamp.  Will write receiver next.
+ *   *  The new changes seem to have a performance inpact of around 1%,
+ *       as far as I can tell.
+ *   --Ben Greear <greearb@candelatech.com>
  *
  * See Documentation/networking/pktgen.txt for how to use this.
  */
@@ -56,69 +71,189 @@
 #define cycles()	((u32)get_cycles())
 
 static char version[] __initdata = 
-  "pktgen.c: v1.0 010812: Packet Generator for packet performance testing.\n";
+  "pktgen.c: v1.1: Packet Generator for packet performance testing.\n";
 
-/* Parameters */
-static char pg_outdev[32], pg_dst[32];
-static int pkt_size = ETH_ZLEN;
-static int nfrags = 0;
-static __u32 pg_count = 100000;  /* Default No packets to send */
-static __u32 pg_ipg = 0;  /* Default Interpacket gap in nsec */
-static int pg_multiskb = 0; /* Use multiple SKBs during packet gen. */
+/* Used to help with determining the pkts on receive */
+#define PKTGEN_MAGIC 0xbe9be955
 
-static int debug;
-static int forced_stop;
-static int pg_cpu_speed;
-static int pg_busy;
+/* Keep information per interface */
+struct pktgen_info {
+        /* Parameters */
+
+        /* If min != max, then we will either do a linear iteration, or
+         * we will do a random selection from within the range.
+         */
+        __u32 flags;     /* 1<<0 IP-Src Random, 1<<1 IP-Dst Random,
+                          * 1<<2 UDP-Src Random, 1<<3 UDP-Dst Random
+                          * 1<<4 MAC-Src Random, 1<<5 MAC-Dst Random
+                          * 1<<6 Specify-Src-Mac (default is to use Interface's MAC Addr)
+                          * 1<<7 Specify-Src-IP (default is to use Interface's IP Addr)
+                          */
+        
+        int pkt_size;    /* = ETH_ZLEN; */
+        int nfrags;
+        __u32 pg_ipg;    /* Default Interpacket gap in nsec */
+        __u64 pg_count;  /* Default No packets to send */
+        __u64 pg_sofar;  /* How many pkts we've sent so far */
+        __u64 errors;    /* Errors when trying to transmit, pkts will be re-sent */
+        struct timeval started_at;
+        struct timeval stopped_at;
+        __u64 idle_acc;
+        __u32 seq_num;
+        
+        int pg_multiskb; /* Use multiple SKBs during packet gen. */
+        int forced_stop;
+        int pg_busy;
+        int do_run_run;  /* if this changes to false, the test will stop */
+        
+        char pg_outdev[32];
+        char dst_min[32];
+        char dst_max[32];
+        char src_min[32];
+        char src_max[32];
+
+        /* If we're doing ranges, random or incremental, then this
+         * defines the min/max for those ranges.
+         */
+        __u32 saddr_min; /* inclusive, source IP address */
+        __u32 saddr_max; /* exclusive, source IP address */
+        __u32 daddr_min; /* inclusive, dest IP address */
+        __u32 daddr_max; /* exclusive, dest IP address */
+
+        __u16 udp_src_min; /* inclusive, source UDP port */
+        __u16 udp_src_max; /* exclusive, source UDP port */
+        __u16 udp_dst_min; /* inclusive, dest UDP port */
+        __u16 udp_dst_max; /* exclusive, dest UDP port */
+
+        __u32 src_mac_count; /* How many MACs to iterate through */
+        __u32 dst_mac_count; /* How many MACs to iterate through */
+        
+        unsigned char dst_mac[6];
+        unsigned char src_mac[6];
+        
+        __u32 cur_dst_mac_offset;
+        __u32 cur_src_mac_offset;
+        __u32 cur_saddr;
+        __u32 cur_daddr;
+        __u16 cur_udp_dst;
+        __u16 cur_udp_src;
+        
+        __u8 hh[14];
+        /* = { 
+           0x00, 0x80, 0xC8, 0x79, 0xB3, 0xCB, 
+           
+           We fill in SRC address later
+           0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+           0x08, 0x00
+           };
+        */
+        __u16 pad; /* pad out the hh struct to an even 16 bytes */
+        char pg_result[512];
+
+        /* proc file names */
+        char fname[80];
+        char busy_fname[80];
 
-static __u8 hh[14] = { 
-    0x00, 0x80, 0xC8, 0x79, 0xB3, 0xCB, 
+        struct proc_dir_entry *pg_proc_ent;
+        struct proc_dir_entry *pg_busy_proc_ent;
+};
 
-    /* We fill in SRC address later */
-    0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-    0x08, 0x00
+struct pktgen_hdr {
+        __u32 pgh_magic;
+        __u32 seq_num;
+        struct timeval timestamp;
 };
 
-static unsigned char *pg_dstmac = hh;
-static char pg_result[512];
+static int pg_cpu_speed;
+static int debug;
+
+/* Module parameters, defaults. */
+static int pg_count_d = 100000;
+static int pg_ipg_d = 0;
+static int pg_multiskb_d = 0;
+
+
+#define MAX_PKTGEN 32
+static struct pktgen_info pginfos[MAX_PKTGEN];
+
+
+/** Convert to miliseconds */
+inline __u64 tv_to_ms(const struct timeval* tv) {
+        __u64 ms = tv->tv_usec / 1000;
+        ms += (__u64)tv->tv_sec * (__u64)1000;
+        return ms;
+}
+
+inline __u64 getCurMs(void) {
+        struct timeval tv;
+        do_gettimeofday(&tv);
+        return tv_to_ms(&tv);
+}
+
 
-static struct net_device *pg_setup_inject(u32 *saddrp)
+static struct net_device *pg_setup_inject(struct pktgen_info* info)
 {
 	struct net_device *odev;
-	int p1, p2;
-	u32 saddr;
 
 	rtnl_lock();
-	odev = __dev_get_by_name(pg_outdev);
+	odev = __dev_get_by_name(info->pg_outdev);
 	if (!odev) {
-		sprintf(pg_result, "No such netdevice: \"%s\"", pg_outdev);
+		sprintf(info->pg_result, "No such netdevice: \"%s\"", info->pg_outdev);
 		goto out_unlock;
 	}
 
 	if (odev->type != ARPHRD_ETHER) {
-		sprintf(pg_result, "Not ethernet device: \"%s\"", pg_outdev);
+		sprintf(info->pg_result, "Not ethernet device: \"%s\"", info->pg_outdev);
 		goto out_unlock;
 	}
 
 	if (!netif_running(odev)) {
-		sprintf(pg_result, "Device is down: \"%s\"", pg_outdev);
+		sprintf(info->pg_result, "Device is down: \"%s\"", info->pg_outdev);
 		goto out_unlock;
 	}
 
-	for (p1 = 6, p2 = 0; p1 < odev->addr_len + 6; p1++)
-		hh[p1] = odev->dev_addr[p2++];
-
-	saddr = 0;
-	if (odev->ip_ptr) {
-		struct in_device *in_dev = odev->ip_ptr;
-
-		if (in_dev->ifa_list)
-			saddr = in_dev->ifa_list->ifa_address;
-	}
+        /* Default to the interface's mac if not explicitly set. */
+        if (!(info->flags & (1<<6))) {
+                memcpy(&(info->hh[6]), odev->dev_addr, 6);
+        }
+        else {
+                memcpy(&(info->hh[6]), info->src_mac, 6);
+        }
+
+        /* Set up Dest MAC */
+        memcpy(&(info->hh[0]), info->dst_mac, 6);
+        
+	info->saddr_min = 0;
+	info->saddr_max = 0;
+        if (strlen(info->src_min) == 0) {
+                if (odev->ip_ptr) {
+                        struct in_device *in_dev = odev->ip_ptr;
+
+                        if (in_dev->ifa_list) {
+                                info->saddr_min = in_dev->ifa_list->ifa_address;
+                                info->saddr_max = info->saddr_min;
+                        }
+                }
+	}
+        else {
+                info->saddr_min = in_aton(info->src_min);
+                info->saddr_max = in_aton(info->src_max);
+        }
+
+        info->daddr_min = in_aton(info->dst_min);
+        info->daddr_max = in_aton(info->dst_max);
+
+        /* Initialize current values. */
+        info->cur_dst_mac_offset = 0;
+        info->cur_src_mac_offset = 0;
+        info->cur_saddr = info->saddr_min;
+        info->cur_daddr = info->daddr_min;
+        info->cur_udp_dst = info->udp_dst_min;
+        info->cur_udp_src = info->udp_src_min;
+        
 	atomic_inc(&odev->refcnt);
 	rtnl_unlock();
 
-	*saddrp = saddr;
 	return odev;
 
 out_unlock:
@@ -126,9 +261,7 @@
 	return NULL;
 }
 
-static u32 idle_acc_lo, idle_acc_hi;
-
-static void nanospin(int pg_ipg)
+static void nanospin(int pg_ipg, struct pktgen_info* info)
 {
 	u32 idle_start, idle;
 
@@ -140,9 +273,7 @@
 		if (idle * 1000 >= pg_ipg * pg_cpu_speed)
 			break;
 	}
-	idle_acc_lo += idle;
-	if (idle_acc_lo < idle)
-		idle_acc_hi++;
+	info->idle_acc += idle;
 }
 
 static int calc_mhz(void)
@@ -173,17 +304,136 @@
 	}
 }
 
-static struct sk_buff *fill_packet(struct net_device *odev, __u32 saddr)
+
+/* Increment/randomize headers according to flags and current values
+ * for IP src/dest, UDP src/dst port, MAC-Addr src/dst
+ */
+static void mod_cur_headers(struct pktgen_info* info) {        
+        __u32 imn;
+        __u32 imx;
+        
+	/*  Deal with source MAC */
+        if (info->src_mac_count > 1) {
+                __u32 mc;
+                __u32 tmp;
+                if (info->flags & (1<<4)) {
+                        mc = net_random() % (info->src_mac_count);
+                }
+                else {
+                        mc = info->cur_src_mac_offset++;
+                        if (info->cur_src_mac_offset > info->src_mac_count) {
+                                info->cur_src_mac_offset = 0;
+                        }
+                }
+
+                tmp = info->src_mac[5] + (mc & 0xFF);
+                info->hh[11] = tmp;
+                tmp = (info->src_mac[4] + ((mc >> 8) & 0xFF) + (tmp >> 8));
+                info->hh[10] = tmp;
+                tmp = (info->src_mac[3] + ((mc >> 16) & 0xFF) + (tmp >> 8));
+                info->hh[9] = tmp;
+                tmp = (info->src_mac[2] + ((mc >> 24) & 0xFF) + (tmp >> 8));
+                info->hh[8] = tmp;
+                tmp = (info->src_mac[1] + (tmp >> 8));
+                info->hh[7] = tmp;        
+        }
+
+        /*  Deal with Destination MAC */
+        if (info->dst_mac_count > 1) {
+                __u32 mc;
+                __u32 tmp;
+                if (info->flags & (1<<5)) {
+                        mc = net_random() % (info->dst_mac_count);
+                }
+                else {
+                        mc = info->cur_dst_mac_offset++;
+                        if (info->cur_dst_mac_offset > info->dst_mac_count) {
+                                info->cur_dst_mac_offset = 0;
+                        }
+                }
+
+                tmp = info->dst_mac[5] + (mc & 0xFF);
+                info->hh[5] = tmp;
+                tmp = (info->dst_mac[4] + ((mc >> 8) & 0xFF) + (tmp >> 8));
+                info->hh[4] = tmp;
+                tmp = (info->dst_mac[3] + ((mc >> 16) & 0xFF) + (tmp >> 8));
+                info->hh[3] = tmp;
+                tmp = (info->dst_mac[2] + ((mc >> 24) & 0xFF) + (tmp >> 8));
+                info->hh[2] = tmp;
+                tmp = (info->dst_mac[1] + (tmp >> 8));
+                info->hh[1] = tmp;        
+        }
+
+        if (info->udp_src_min < info->udp_src_max) {
+                if (info->flags & (1<<2)) {
+                        info->cur_udp_src = ((net_random() % (info->udp_src_max - info->udp_src_min))
+                                             + info->udp_src_min);
+                }
+                else {
+                     info->cur_udp_src++;
+                     if (info->cur_udp_src >= info->udp_src_max) {
+                             info->cur_udp_src = info->udp_src_min;
+                     }
+                }
+        }
+
+        if (info->udp_dst_min < info->udp_dst_max) {
+                if (info->flags & (1<<3)) {
+                        info->cur_udp_dst = ((net_random() % (info->udp_dst_max - info->udp_dst_min))
+                                             + info->udp_dst_min);
+                }
+                else {
+                     info->cur_udp_dst++;
+                     if (info->cur_udp_dst >= info->udp_dst_max) {
+                             info->cur_udp_dst = info->udp_dst_min;
+                     }
+                }
+        }
+
+        if ((imn = ntohl(info->saddr_min)) < (imx = ntohl(info->saddr_max))) {
+                __u32 t;
+                if (info->flags & (1<<0)) {
+                        t = ((net_random() % (imx - imn)) + imn);
+                }
+                else {
+                     t = ntohl(info->cur_saddr);
+                     t++;
+                     if (t >= imx) {
+                             t = imn;
+                     }
+                }
+                info->cur_saddr = htonl(t);
+        }
+
+        if ((imn = ntohl(info->daddr_min)) < (imx = ntohl(info->daddr_max))) {
+                __u32 t;
+                if (info->flags & (1<<1)) {
+                        t = ((net_random() % (imx - imn)) + imn);
+                }
+                else {
+                     t = ntohl(info->cur_daddr);
+                     t++;
+                     if (t >= imx) {
+                             t = imn;
+                     }
+                }
+                info->cur_daddr = htonl(t);
+        }
+}/* mod_cur_headers */
+
+
+static struct sk_buff *fill_packet(struct net_device *odev, struct pktgen_info* info)
 {
-	struct sk_buff *skb;
+	struct sk_buff *skb = NULL;
 	__u8 *eth;
 	struct udphdr *udph;
 	int datalen, iplen;
 	struct iphdr *iph;
-
-	skb = alloc_skb(pkt_size + 64 + 16, GFP_ATOMIC);
+        struct pktgen_hdr *pgh = NULL;
+        
+	skb = alloc_skb(info->pkt_size + 64 + 16, GFP_ATOMIC);
 	if (!skb) {
-		sprintf(pg_result, "No memory");
+		sprintf(info->pg_result, "No memory");
 		return NULL;
 	}
 
@@ -194,15 +444,20 @@
 	iph = (struct iphdr *)skb_put(skb, sizeof(struct iphdr));
 	udph = (struct udphdr *)skb_put(skb, sizeof(struct udphdr));
 
-	/*  Copy the ethernet header  */
-	memcpy(eth, hh, 14);
-
-	datalen = pkt_size - 14 - 20 - 8; /* Eth + IPh + UDPh */
-	if (datalen < 0)
-		datalen = 0;
-
-	udph->source = htons(9);
-	udph->dest = htons(9);
+        /* Update any of the values, used when we're incrementing various
+         * fields.
+         */
+        mod_cur_headers(info);
+
+	memcpy(eth, info->hh, 14);
+        
+	datalen = info->pkt_size - 14 - 20 - 8; /* Eth + IPh + UDPh */
+	if (datalen < sizeof(struct pktgen_hdr)) {
+		datalen = sizeof(struct pktgen_hdr);
+        }
+        
+	udph->source = htons(info->cur_udp_src);
+	udph->dest = htons(info->cur_udp_dst);
 	udph->len = htons(datalen + 8); /* DATA + udphdr */
 	udph->check = 0;  /* No checksum */
 
@@ -211,8 +466,8 @@
 	iph->ttl = 3;
 	iph->tos = 0;
 	iph->protocol = IPPROTO_UDP; /* UDP */
-	iph->saddr = saddr;
-	iph->daddr = in_aton(pg_dst);
+	iph->saddr = info->cur_saddr;
+	iph->daddr = info->cur_daddr;
 	iph->frag_off = 0;
 	iplen = 20 + 8 + datalen;
 	iph->tot_len = htons(iplen);
@@ -223,12 +478,15 @@
 	skb->dev = odev;
 	skb->pkt_type = PACKET_HOST;
 
-	if (nfrags <= 0) {
-		skb_put(skb, datalen);
+	if (info->nfrags <= 0) {
+                pgh = (struct pktgen_hdr *)skb_put(skb, datalen);
 	} else {
-		int frags = nfrags;
+		int frags = info->nfrags;
 		int i;
 
+                /* TODO: Verify this is OK...it sure is ugly. --Ben */
+                pgh = (struct pktgen_hdr*)(((char*)(udph)) + 8);
+                
 		if (frags > MAX_SKB_FRAGS)
 			frags = MAX_SKB_FRAGS;
 		if (datalen > frags*PAGE_SIZE) {
@@ -272,63 +530,95 @@
 		}
 	}
 
+        /* Stamp the time, and sequence number, convert them to network byte order */
+        if (pgh) {
+                pgh->pgh_magic = __constant_htonl(PKTGEN_MAGIC);
+                do_gettimeofday(&(pgh->timestamp));
+                pgh->timestamp.tv_usec = htonl(pgh->timestamp.tv_usec);
+                pgh->timestamp.tv_sec = htonl(pgh->timestamp.tv_sec);
+                pgh->seq_num = htonl(info->seq_num);
+        }
+        
 	return skb;
 }
 
 
-static void pg_inject(void)
+static void pg_inject(struct pktgen_info* info)
 {
-	u32 saddr;
 	struct net_device *odev;
-	struct sk_buff *skb;
-	struct timeval start, stop;
-	u32 total, idle;
-	int pc, lcount;
-
-	odev = pg_setup_inject(&saddr);
+	struct sk_buff *skb = NULL;
+	__u64 total = 0;
+        __u64 idle = 0;
+	__u64 lcount = 0;
+        int nr_frags = 0;
+        
+	odev = pg_setup_inject(info);
 	if (!odev)
 		return;
 
-	skb = fill_packet(odev, saddr);
-	if (skb == NULL)
-		goto out_reldev;
-
-	forced_stop = 0;
-	idle_acc_hi = 0;
-	idle_acc_lo = 0;
-	pc = 0;
-	lcount = pg_count;
-	do_gettimeofday(&start);
-
-	for(;;) {
+        info->do_run_run = 1; /* Cranke yeself! */
+	info->forced_stop = 0;
+	info->idle_acc = 0;
+	info->pg_sofar = 0;
+	lcount = info->pg_count;
+	do_gettimeofday(&(info->started_at));
+
+	while(info->do_run_run) {
+                /* Want to set a time-stamp, so build a new pkt each time */
+                if (skb) {
+                        kfree_skb(skb);
+                }
+                skb = fill_packet(odev, info);
+                if (skb == NULL)
+                   goto out_reldev;
+                nr_frags = skb_shinfo(skb)->nr_frags;
+                   
 		spin_lock_bh(&odev->xmit_lock);
 		if (!netif_queue_stopped(odev)) {
 			struct sk_buff *skb2 = skb;
 
-			if (pg_multiskb)
+			if (info->pg_multiskb)
 				skb2 = skb_copy(skb, GFP_ATOMIC);
 			else
 				atomic_inc(&skb->users);
 			if (!skb2)
 				goto skip;
 			if (odev->hard_start_xmit(skb2, odev)) {
-				kfree_skb(skb2);
-				if (net_ratelimit())
-					printk(KERN_INFO "Hard xmit error\n");
+				if (net_ratelimit()) {
+                                   printk(KERN_INFO "Hard xmit error\n");
+                                }
+                                info->errors++;
 			}
-			pc++;
+                        else {
+                           info->pg_sofar++;
+                           info->seq_num++;
+                        }
 		}
 	skip:
 		spin_unlock_bh(&odev->xmit_lock);
 
-		if (pg_ipg)
-			nanospin(pg_ipg);
-		if (forced_stop)
+		if (info->pg_ipg) {
+                        /* Try not to busy-spin if we have larger sleep times.
+                         * TODO:  Investigate better ways to do this.
+                         */
+                        if (info->pg_ipg < 10000) { /* 10 usecs or less */
+                                nanospin(info->pg_ipg, info);
+                        }
+                        else if (info->pg_ipg < 10000000) { /* 10ms or less */
+                                udelay(info->pg_ipg / 1000);
+                        }
+                        else {
+                                mdelay(info->pg_ipg / 1000000);
+                        }
+                }
+                
+		if (info->forced_stop)
 			goto out_intr;
 		if (signal_pending(current))
-			goto out_intr;
+                        break;
 
-		if (--lcount == 0) {
+                /* If lcount is zero, then run forever */
+		if ((lcount != 0) && (--lcount == 0)) {
 			if (atomic_read(&skb->users) != 1) {
 				u32 idle_start, idle;
 
@@ -339,9 +629,7 @@
 					schedule();
 				}
 				idle = cycles() - idle_start;
-				idle_acc_lo += idle;
-				if (idle_acc_lo < idle)
-					idle_acc_hi++;
+				info->idle_acc += idle;
 			}
 			break;
 		}
@@ -361,53 +649,63 @@
 					do_softirq();
 			} while (netif_queue_stopped(odev));
 			idle = cycles() - idle_start;
-			idle_acc_lo += idle;
-			if (idle_acc_lo < idle)
-				idle_acc_hi++;
+			info->idle_acc += idle;
 		}
-	}
+	}/* while we should be running */
 
-	do_gettimeofday(&stop);
+	do_gettimeofday(&(info->stopped_at));
 
-	total = (stop.tv_sec - start.tv_sec) * 1000000 +
-		stop.tv_usec - start.tv_usec;
+	total = (info->stopped_at.tv_sec - info->started_at.tv_sec) * 1000000 +
+		info->stopped_at.tv_usec - info->started_at.tv_usec;
 
-	idle = (((idle_acc_hi<<20)/pg_cpu_speed)<<12)+idle_acc_lo/pg_cpu_speed;
+	idle = (__u32)(info->idle_acc)/(__u32)(pg_cpu_speed);
 
         {
-		char *p = pg_result;
-    
-		p += sprintf(p, "OK: %u(c%u+d%u) usec, %u (%dbyte,%dfrags) %upps %uMB/sec",
+		char *p = info->pg_result;
+                __u64 pps = (__u32)(info->pg_sofar * 1000) / ((__u32)(total) / 1000);
+                __u64 bps = pps * 8 * (info->pkt_size + 4); /* take 32bit ethernet CRC into account */
+		p += sprintf(p, "OK: %llu(c%llu+d%llu) usec, %llu (%dbyte,%dfrags) %llupps %lluMb/sec (%llubps)  errors: %llu",
 			     total, total-idle, idle,
-			     pc, skb->len, skb_shinfo(skb)->nr_frags,
-			     ((pc*1000)/(total/1000)),
-			     (((pc*1000)/(total/1000))*pkt_size)/1024/1024
+			     info->pg_sofar,
+                             skb->len + 4, /* Add 4 to account for the ethernet checksum */
+                             nr_frags,
+			     pps,
+			     bps/1024/1024, bps, info->errors
 			     );
 	}
-
+        
 out_relskb:
-	kfree_skb(skb);
+        if (skb) {
+           kfree_skb(skb);
+           skb = NULL;
+        }
+
 out_reldev:
         dev_put(odev);
 	return;
 
 out_intr:
-	sprintf(pg_result, "Interrupted");
+	sprintf(info->pg_result, "Interrupted");
 	goto out_relskb;
 }
 
 /* proc/net/pg */
 
-static struct proc_dir_entry *pg_proc_ent = 0;
-static struct proc_dir_entry *pg_busy_proc_ent = 0;
-
 static int proc_pg_busy_read(char *buf , char **start, off_t offset,
 			     int len, int *eof, void *data)
 {
 	char *p;
+        int idx = (int)(data);
+        struct pktgen_info* info = NULL;
+        
+        if ((idx < 0) || (idx >= MAX_PKTGEN)) {
+                printk("ERROR: idx: %i is out of range in proc_pg_write\n", idx);
+                return -EINVAL;
+        }
+        info = &(pginfos[idx]);
   
 	p = buf;
-	p += sprintf(p, "%d\n", pg_busy);
+	p += sprintf(p, "%d\n", info->pg_busy);
 	*eof = 1;
   
 	return p-buf;
@@ -418,16 +716,72 @@
 {
 	char *p;
 	int i;
+        int idx = (int)(data);
+        struct pktgen_info* info = NULL;
+        __u64 sa;
+        __u64 stopped;
+        __u64 now = getCurMs();
+        
+        if ((idx < 0) || (idx >= MAX_PKTGEN)) {
+                printk("ERROR: idx: %i is out of range in proc_pg_write\n", idx);
+                return -EINVAL;
+        }
+        info = &(pginfos[idx]);
   
 	p = buf;
-	p += sprintf(p, "Params: count=%u pkt_size=%u frags %d ipg %u multiskb %d odev \"%s\" dst %s dstmac ",
-		     pg_count, pkt_size, nfrags, pg_ipg, pg_multiskb,
-		     pg_outdev, pg_dst);
-	for (i = 0; i < 6; i++)
-		p += sprintf(p, "%02X%s", pg_dstmac[i], i == 5 ? "\n" : ":");
-
-	if (pg_result[0])
-		p += sprintf(p, "Result: %s\n", pg_result);
+        p += sprintf(p, "VERSION-1\n"); /* Help with parsing compatibility */
+	p += sprintf(p, "Params: count %llu  pkt_size: %u  frags: %d  ipg: %u  multiskb: %d odev \"%s\"\n",
+		     info->pg_count, info->pkt_size, info->nfrags, info->pg_ipg,
+                     info->pg_multiskb, info->pg_outdev);
+        p += sprintf(p, "     dst_min: %s  dst_max: %s  src_min: %s  src_max: %s\n",
+                     info->dst_min, info->dst_max, info->src_min, info->src_max);
+        p += sprintf(p, "     src_mac: ");
+	for (i = 0; i < 6; i++) {
+		p += sprintf(p, "%02X%s", info->src_mac[i], i == 5 ? "  " : ":");
+        }
+        p += sprintf(p, "dst_mac: ");
+	for (i = 0; i < 6; i++) {
+		p += sprintf(p, "%02X%s", info->dst_mac[i], i == 5 ? "\n" : ":");
+        }
+        p += sprintf(p, "     udp_src_min: %d  udp_src_max: %d  udp_dst_min: %d  udp_dst_max: %d\n",
+                     info->udp_src_min, info->udp_src_max, info->udp_dst_min,
+                     info->udp_dst_max);
+        p += sprintf(p, "     src_mac_count: %d  dst_mac_count: %d\n     Flags: ",
+                     info->src_mac_count, info->dst_mac_count);
+        if (info->flags & (1<<0)) {
+                p += sprintf(p, "IPSRC_RND  ");
+        }
+        if (info->flags & (1<<1)) {
+                p += sprintf(p, "IPDST_RND  ");
+        }
+        if (info->flags & (1<<2)) {
+                p += sprintf(p, "UDPSRC_RND  ");
+        }
+        if (info->flags & (1<<3)) {
+                p += sprintf(p, "UDPDST_RND  ");
+        }
+        if (info->flags & (1<<4)) {
+                p += sprintf(p, "MACSRC_RND  ");
+        }
+        if (info->flags & (1<<5)) {
+                p += sprintf(p, "MACDST_RND  ");
+        }
+        p += sprintf(p, "\n");
+        
+        sa = tv_to_ms(&(info->started_at));
+        stopped = tv_to_ms(&(info->stopped_at));
+        if (info->do_run_run) {
+                stopped = now; /* not really stopped, more like last-running-at */
+        }
+        p += sprintf(p, "Current:\n     pkts-sofar: %llu  errors: %llu\n     started: %llums  stopped: %llums  now: %llums  idle: %lluns\n",
+                     info->pg_sofar, info->errors, sa, stopped, now, info->idle_acc);
+        p += sprintf(p, "     seq_num: %d  cur_dst_mac_offset: %d  cur_src_mac_offset: %d\n",
+                     info->seq_num, info->cur_dst_mac_offset, info->cur_src_mac_offset);
+        p += sprintf(p, "     cur_saddr: 0x%x  cur_daddr: 0x%x  cur_udp_dst: %d  cur_udp_src: %d\n",
+                     info->cur_saddr, info->cur_daddr, info->cur_udp_dst, info->cur_udp_src);
+        
+	if (info->pg_result[0])
+		p += sprintf(p, "Result: %s\n", info->pg_result);
 	else
 		p += sprintf(p, "Result: Idle\n");
 	*eof = 1;
@@ -498,7 +852,17 @@
 	int i = 0, max, len;
 	char name[16], valstr[32];
 	unsigned long value = 0;
-  
+        int idx = (int)(data);
+        struct pktgen_info* info = NULL;
+        char* pg_result = NULL;
+        
+        if ((idx < 0) || (idx >= MAX_PKTGEN)) {
+                printk("ERROR: idx: %i is out of range in proc_pg_write\n", idx);
+                return -EINVAL;
+        }
+        info = &(pginfos[idx]);
+        pg_result = &(info->pg_result[0]);
+        
 	if (count < 1) {
 		sprintf(pg_result, "Wrong command format");
 		return -EINVAL;
@@ -521,85 +885,206 @@
 	if (debug)
 		printk("pg: %s,%lu\n", name, count);
 
-	/* Only stop is allowed when we are running */
-  
 	if (!strcmp(name, "stop")) {
-		forced_stop = 1;
-		if (pg_busy)
+		info->forced_stop = 1;
+		if (info->do_run_run) {
 			strcpy(pg_result, "Stopping");
+                }
+                else {
+                        strcpy(pg_result, "Already stopped...\n");
+                }
+                info->do_run_run = 0;
 		return count;
 	}
 
-	if (pg_busy) {
-		strcpy(pg_result, "Busy");
-		return -EINVAL;
-	}
-
 	if (!strcmp(name, "pkt_size")) {
 		len = num_arg(&buffer[i], 10, &value);
 		i += len;
 		if (value < 14+20+8)
 			value = 14+20+8;
-		pkt_size = value;
-		sprintf(pg_result, "OK: pkt_size=%u", pkt_size);
+		info->pkt_size = value;
+		sprintf(pg_result, "OK: pkt_size=%u", info->pkt_size);
 		return count;
 	}
 	if (!strcmp(name, "frags")) {
 		len = num_arg(&buffer[i], 10, &value);
 		i += len;
-		nfrags = value;
-		sprintf(pg_result, "OK: frags=%u", nfrags);
+		info->nfrags = value;
+		sprintf(pg_result, "OK: frags=%u", info->nfrags);
 		return count;
 	}
 	if (!strcmp(name, "ipg")) {
 		len = num_arg(&buffer[i], 10, &value);
 		i += len;
-		pg_ipg = value;
-		sprintf(pg_result, "OK: ipg=%u", pg_ipg);
+		info->pg_ipg = value;
+		sprintf(pg_result, "OK: ipg=%u", info->pg_ipg);
+		return count;
+	}
+ 	if (!strcmp(name, "udp_src_min")) {
+		len = num_arg(&buffer[i], 10, &value);
+		i += len;
+	 	info->udp_src_min = value;
+		sprintf(pg_result, "OK: udp_src_min=%u", info->udp_src_min);
+		return count;
+	}
+ 	if (!strcmp(name, "udp_dst_min")) {
+		len = num_arg(&buffer[i], 10, &value);
+		i += len;
+	 	info->udp_dst_min = value;
+		sprintf(pg_result, "OK: udp_dst_min=%u", info->udp_dst_min);
+		return count;
+	}
+ 	if (!strcmp(name, "udp_src_max")) {
+		len = num_arg(&buffer[i], 10, &value);
+		i += len;
+	 	info->udp_src_max = value;
+		sprintf(pg_result, "OK: udp_src_max=%u", info->udp_src_max);
+		return count;
+	}
+ 	if (!strcmp(name, "udp_dst_max")) {
+		len = num_arg(&buffer[i], 10, &value);
+		i += len;
+	 	info->udp_dst_max = value;
+		sprintf(pg_result, "OK: udp_dst_max=%u", info->udp_dst_max);
 		return count;
 	}
 	if (!strcmp(name, "multiskb")) {
 		len = num_arg(&buffer[i], 10, &value);
 		i += len;
-		pg_multiskb = (value ? 1 : 0);
-		sprintf(pg_result, "OK: multiskb=%d", pg_multiskb);
+		info->pg_multiskb = (value ? 1 : 0);
+		sprintf(pg_result, "OK: multiskb=%d", info->pg_multiskb);
 		return count;
 	}
 	if (!strcmp(name, "count")) {
 		len = num_arg(&buffer[i], 10, &value);
 		i += len;
-		pg_count = value;
-		sprintf(pg_result, "OK: count=%u", pg_count);
+		info->pg_count = value;
+		sprintf(pg_result, "OK: count=%llu", info->pg_count);
+		return count;
+	}
+	if (!strcmp(name, "src_mac_count")) {
+		len = num_arg(&buffer[i], 10, &value);
+		i += len;
+		info->src_mac_count = value;
+		sprintf(pg_result, "OK: src_mac_count=%d", info->src_mac_count);
+		return count;
+	}
+	if (!strcmp(name, "dst_mac_count")) {
+		len = num_arg(&buffer[i], 10, &value);
+		i += len;
+		info->dst_mac_count = value;
+		sprintf(pg_result, "OK: dst_mac_count=%d", info->dst_mac_count);
 		return count;
 	}
 	if (!strcmp(name, "odev")) {
-		len = strn_len(&buffer[i], sizeof(pg_outdev) - 1);
-		memset(pg_outdev, 0, sizeof(pg_outdev));
-		strncpy(pg_outdev, &buffer[i], len);
+		len = strn_len(&buffer[i], sizeof(info->pg_outdev) - 1);
+		memset(info->pg_outdev, 0, sizeof(info->pg_outdev));
+		strncpy(info->pg_outdev, &buffer[i], len);
+		i += len;
+		sprintf(pg_result, "OK: odev=%s", info->pg_outdev);
+		return count;
+	}
+	if (!strcmp(name, "flag")) {
+                char f[32];
+                memset(f, 0, 32);
+		len = strn_len(&buffer[i], sizeof(f) - 1);
+		strncpy(f, &buffer[i], len);
 		i += len;
-		sprintf(pg_result, "OK: odev=%s", pg_outdev);
+                if (strcmp(f, "IPSRC_RND") == 0) {
+                        info->flags |= (1<<0);
+                }
+                else if (strcmp(f, "!IPSRC_RND") == 0) {
+                        info->flags &= ~(1<<0);
+                }
+                else if (strcmp(f, "IPDST_RND") == 0) {
+                        info->flags |= (1<<1);
+                }
+                else if (strcmp(f, "!IPDST_RND") == 0) {
+                        info->flags &= ~(1<<1);
+                }
+                else if (strcmp(f, "UDPSRC_RND") == 0) {
+                        info->flags |= (1<<2);
+                }
+                else if (strcmp(f, "!UDPSRC_RND") == 0) {
+                        info->flags &= ~(1<<2);
+                }
+                else if (strcmp(f, "UDPDST_RND") == 0) {
+                        info->flags |= (1<<3);
+                }
+                else if (strcmp(f, "!UDPDST_RND") == 0) {
+                        info->flags &= ~(1<<3);
+                }
+                else if (strcmp(f, "MACSRC_RND") == 0) {
+                        info->flags |= (1<<4);
+                }
+                else if (strcmp(f, "!MACSRC_RND") == 0) {
+                        info->flags &= ~(1<<4);
+                }
+                else if (strcmp(f, "MACDST_RND") == 0) {
+                        info->flags |= (1<<5);
+                }
+                else if (strcmp(f, "!MACDST_RND") == 0) {
+                        info->flags &= ~(1<<5);
+                }
+                else {
+                        sprintf(pg_result, "Flag -:%s:- unknown\nAvailable flags, (prepend ! to un-set flag):\n%s",
+                                f,
+                                "IPSRC_RND, IPDST_RND, UDPSRC_RND, UDPDST_RND, MACSRC_RND, MACDST_RND\n");
+                        return count;
+                }
+		sprintf(pg_result, "OK: flags=0x%x", info->flags);
 		return count;
 	}
-	if (!strcmp(name, "dst")) {
-		len = strn_len(&buffer[i], sizeof(pg_dst) - 1);
-		memset(pg_dst, 0, sizeof(pg_dst));
-		strncpy(pg_dst, &buffer[i], len);
+	if (!strcmp(name, "dst_min") || !strcmp(name, "dst")) {
+		len = strn_len(&buffer[i], sizeof(info->dst_min) - 1);
+		memset(info->dst_min, 0, sizeof(info->dst_min));
+		strncpy(info->dst_min, &buffer[i], len);
 		if(debug)
-			printk("pg: dst set to: %s\n", pg_dst);
+			printk("pg: dst_min set to: %s\n", info->dst_min);
 		i += len;
-		sprintf(pg_result, "OK: dst=%s", pg_dst);
+		sprintf(pg_result, "OK: dst_min=%s", info->dst_min);
+		return count;
+	}
+	if (!strcmp(name, "dst_max")) {
+		len = strn_len(&buffer[i], sizeof(info->dst_max) - 1);
+		memset(info->dst_max, 0, sizeof(info->dst_max));
+		strncpy(info->dst_max, &buffer[i], len);
+		if(debug)
+			printk("pg: dst_max set to: %s\n", info->dst_max);
+		i += len;
+		sprintf(pg_result, "OK: dst_max=%s", info->dst_max);
+		return count;
+	}
+	if (!strcmp(name, "src_min")) {
+		len = strn_len(&buffer[i], sizeof(info->src_min) - 1);
+		memset(info->src_min, 0, sizeof(info->src_min));
+		strncpy(info->src_min, &buffer[i], len);
+		if(debug)
+			printk("pg: src_min set to: %s\n", info->src_min);
+		i += len;
+		sprintf(pg_result, "OK: src_min=%s", info->src_min);
+		return count;
+	}
+	if (!strcmp(name, "src_max")) {
+		len = strn_len(&buffer[i], sizeof(info->src_max) - 1);
+		memset(info->src_max, 0, sizeof(info->src_max));
+		strncpy(info->src_max, &buffer[i], len);
+		if(debug)
+			printk("pg: src_max set to: %s\n", info->src_max);
+		i += len;
+		sprintf(pg_result, "OK: src_max=%s", info->src_max);
 		return count;
 	}
 	if (!strcmp(name, "dstmac")) {
 		char *v = valstr;
-		unsigned char *m = pg_dstmac;
+		unsigned char *m = info->dst_mac;
 
 		len = strn_len(&buffer[i], sizeof(valstr) - 1);
 		memset(valstr, 0, sizeof(valstr));
 		strncpy(valstr, &buffer[i], len);
 		i += len;
 
-		for(*m = 0;*v && m < pg_dstmac + 6; v++) {
+		for(*m = 0;*v && m < info->dst_mac + 6; v++) {
 			if (*v >= '0' && *v <= '9') {
 				*m *= 16;
 				*m += *v - '0';
@@ -620,54 +1105,125 @@
 		sprintf(pg_result, "OK: dstmac");
 		return count;
 	}
+	if (!strcmp(name, "srcmac")) {
+		char *v = valstr;
+		unsigned char *m = info->src_mac;
+
+		len = strn_len(&buffer[i], sizeof(valstr) - 1);
+		memset(valstr, 0, sizeof(valstr));
+		strncpy(valstr, &buffer[i], len);
+		i += len;
+
+		for(*m = 0;*v && m < info->src_mac + 6; v++) {
+			if (*v >= '0' && *v <= '9') {
+				*m *= 16;
+				*m += *v - '0';
+			}
+			if (*v >= 'A' && *v <= 'F') {
+				*m *= 16;
+				*m += *v - 'A' + 10;
+			}
+			if (*v >= 'a' && *v <= 'f') {
+				*m *= 16;
+				*m += *v - 'a' + 10;
+			}
+			if (*v == ':') {
+				m++;
+				*m = 0;
+			}
+		}	  
+		sprintf(pg_result, "OK: srcmac");
+		return count;
+	}
 
 	if (!strcmp(name, "inject") || !strcmp(name, "start")) {
 		MOD_INC_USE_COUNT;
-		pg_busy = 1;
-		strcpy(pg_result, "Starting");
-		pg_inject();
-		pg_busy = 0;
+                if (info->pg_busy) {
+                        strcpy(info->pg_result, "Already running...\n");
+                }
+                else {
+                        info->pg_busy = 1;
+                        strcpy(info->pg_result, "Starting");
+                        pg_inject(info);
+                        info->pg_busy = 0;
+                }
 		MOD_DEC_USE_COUNT;
 		return count;
 	}
 
-	sprintf(pg_result, "No such parameter \"%s\"", name);
+	sprintf(info->pg_result, "No such parameter \"%s\"", name);
 	return -EINVAL;
 }
 
 static int __init pg_init(void)
 {
+        int i;
 	printk(version);
 	cycles_calibrate();
 	if (pg_cpu_speed == 0) {
 		printk("pktgen: Error: your machine does not have working cycle counter.\n");
 		return -EINVAL;
 	}
-	pg_proc_ent = create_proc_entry("net/pg", 0600, 0);
-	if (!pg_proc_ent) {
-		printk("pktgen: Error: cannot create net/pg procfs entry.\n");
-		return -ENOMEM;
-	}
-	pg_proc_ent->read_proc = proc_pg_read;
-	pg_proc_ent->write_proc = proc_pg_write;
-	pg_proc_ent->data = 0;
-
-	pg_busy_proc_ent = create_proc_entry("net/pg_busy", 0, 0);
-	if (!pg_busy_proc_ent) {
-		printk("pktgen: Error: cannot create net/pg_busy procfs entry.\n");
-		remove_proc_entry("net/pg", NULL);
-		return -ENOMEM;
-	}
-	pg_busy_proc_ent->read_proc = proc_pg_busy_read;
-	pg_busy_proc_ent->data = 0;
 
-	return 0;
+        for (i = 0; i<MAX_PKTGEN; i++) {
+                memset(&(pginfos[i]), 0, sizeof(pginfos[i]));
+                pginfos[i].pkt_size = ETH_ZLEN;
+                pginfos[i].nfrags = 0;
+                pginfos[i].pg_multiskb = pg_multiskb_d;
+                pginfos[i].pg_ipg = pg_ipg_d;
+                pginfos[i].pg_count = pg_count_d;
+                pginfos[i].pg_sofar = 0;
+                pginfos[i].hh[12] = 0x08; /* fill in protocol.  Rest is filled in later. */
+                pginfos[i].hh[13] = 0x00;
+                pginfos[i].udp_src_min = 9; /* sink NULL */
+                pginfos[i].udp_src_max = 9;
+                pginfos[i].udp_dst_min = 9;
+                pginfos[i].udp_dst_max = 9;
+                
+                sprintf(pginfos[i].fname, "net/pg%i", i);
+                pginfos[i].pg_proc_ent = create_proc_entry(pginfos[i].fname, 0600, 0);
+                if (!pginfos[i].pg_proc_ent) {
+                        printk("pktgen: Error: cannot create net/pg procfs entry.\n");
+                        goto cleanup_mem;
+                }
+                pginfos[i].pg_proc_ent->read_proc = proc_pg_read;
+                pginfos[i].pg_proc_ent->write_proc = proc_pg_write;
+                pginfos[i].pg_proc_ent->data = (void*)(i);
+
+                sprintf(pginfos[i].busy_fname, "net/pg_busy%i", i);
+                pginfos[i].pg_busy_proc_ent = create_proc_entry(pginfos[i].busy_fname, 0, 0);
+                if (!pginfos[i].pg_busy_proc_ent) {
+                        printk("pktgen: Error: cannot create net/pg_busy procfs entry.\n");
+                        goto cleanup_mem;
+                }
+                pginfos[i].pg_busy_proc_ent->read_proc = proc_pg_busy_read;
+                pginfos[i].pg_busy_proc_ent->data = (void*)(i);
+        }
+        return 0;
+        
+cleanup_mem:
+        for (i = 0; i<MAX_PKTGEN; i++) {
+                if (strlen(pginfos[i].fname)) {
+                        remove_proc_entry(pginfos[i].fname, NULL);
+                }
+                if (strlen(pginfos[i].busy_fname)) {
+                        remove_proc_entry(pginfos[i].busy_fname, NULL);
+                }
+        }
+	return -ENOMEM;
 }
 
 static void __exit pg_cleanup(void)
 {
-	remove_proc_entry("net/pg", NULL);
-	remove_proc_entry("net/pg_busy", NULL);
+        int i;
+        for (i = 0; i<MAX_PKTGEN; i++) {
+                if (strlen(pginfos[i].fname)) {
+                        remove_proc_entry(pginfos[i].fname, NULL);
+                }
+                if (strlen(pginfos[i].busy_fname)) {
+                        remove_proc_entry(pginfos[i].busy_fname, NULL);
+                }
+        }
 }
 
 module_init(pg_init);
@@ -676,7 +1232,7 @@
 MODULE_AUTHOR("Robert Olsson <robert.olsson@its.uu.se");
 MODULE_DESCRIPTION("Packet Generator tool");
 MODULE_LICENSE("GPL");
-MODULE_PARM(pg_count, "i");
-MODULE_PARM(pg_ipg, "i");
+MODULE_PARM(pg_count_d, "i");
+MODULE_PARM(pg_ipg_d, "i");
 MODULE_PARM(pg_cpu_speed, "i");
-MODULE_PARM(pg_multiskb, "i");
+MODULE_PARM(pg_multiskb_d, "i");

--------------070007070600010608010603
Content-Type: text/plain;
 name="patch1.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch1.txt"

--- linux/Documentation/networking/pktgen.txt	Sat Apr 20 17:28:11 2002
+++ linux.dev/Documentation/networking/pktgen.txt	Sat Apr 20 17:39:55 2002
@@ -4,6 +4,9 @@
    in the place where insmod may find it.
 2. Cut script "ipg" (see below).
 3. Edit script to set preferred device and destination IP address.
+3a.  Create more scripts for different interfaces.  Up to thirty-two
+     pktgen processes can be configured and run at once by using the
+     32 /proc/net/pg* files.
 4. Run in shell: ". ipg"
 5. After this two commands are defined:
    A. "pg" to start generator and to get results.
@@ -12,12 +15,33 @@
       pgset "multiskb 0"      use single SKB for all transmits
       pgset "pkt_size 9014"   sets packet size to 9014
       pgset "frags 5"         packet will consist of 5 fragments
-      pgset "count 200000"    sets number of packets to send
+      pgset "count 200000"    sets number of packets to send, set to zero
+                              for continious sends untill explicitly
+                              stopped.
       pgset "ipg 5000"        sets artificial gap inserted between packets
                               to 5000 nanoseconds
       pgset "dst 10.0.0.1"    sets IP destination address
                               (BEWARE! This generator is very aggressive!)
+      pgset "dst_min 10.0.0.1"            Same as dst
+      pgset "dst_max 10.0.0.254"          Set the maximum destination IP.
+      pgset "src_min 10.0.0.1"            Set the minimum (or only) source IP.
+      pgset "src_max 10.0.0.254"          Set the maximum source IP.
       pgset "dstmac 00:00:00:00:00:00"    sets MAC destination address
+      pgset "srcmac 00:00:00:00:00:00"    sets MAC source address
+      pgset "src_mac_count 1" Sets the number of MACs we'll range through.  The
+                              'minimum' MAC is what you set with srcmac.
+      pgset "dst_mac_count 1" Sets the number of MACs we'll range through.  The
+                              'minimum' MAC is what you set with dstmac.
+      pgset "flag [name]"     Set a flag to determine behaviour.  Current flags
+                              are: IPSRC_RND #IP Source is random (between min/max),
+                                   IPDST_RND, UDPSRC_RND,
+                                   UDPDST_RND, MACSRC_RND, MACDST_RND 
+      pgset "udp_src_min 9"   set UDP source port min, If < udp_src_max, then
+                              cycle through the port range.
+      pgset "udp_src_max 9"   set UDP source port max.
+      pgset "udp_dst_min 9"   set UDP destination port min, If < udp_dst_max, then
+                              cycle through the port range.
+      pgset "udp_dst_max 9"   set UDP destination port max.
       pgset stop    	      aborts injection
       
   Also, ^C aborts generator.
@@ -26,22 +50,24 @@
 
 #! /bin/sh
 
-modprobe pktgen.o
+modprobe pktgen
+
+PGDEV=/proc/net/pg0
 
 function pgset() {
     local result
 
-    echo $1 > /proc/net/pg
+    echo $1 > $PGDEV
 
-    result=`cat /proc/net/pg | fgrep "Result: OK:"`
+    result=`cat $PGDEV | fgrep "Result: OK:"`
     if [ "$result" = "" ]; then
-         cat /proc/net/pg | fgrep Result:
+         cat $PGDEV | fgrep Result:
     fi
 }
 
 function pg() {
-    echo inject > /proc/net/pg
-    cat /proc/net/pg
+    echo inject > $PGDEV
+    cat $PGDEV
 }
 
 pgset "odev eth0"

--------------070007070600010608010603--

