Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136318AbRDWASn>; Sun, 22 Apr 2001 20:18:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136317AbRDWASe>; Sun, 22 Apr 2001 20:18:34 -0400
Received: from ash.lnxi.com ([207.88.130.242]:26864 "EHLO DLT.linuxnetworx.com")
	by vger.kernel.org with ESMTP id <S136315AbRDWASC>;
	Sun, 22 Apr 2001 20:18:02 -0400
To: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: <linux-kernel@vger.kernel.org>
Subject: [PATCH] Add DHCP to 2.4.x ipconfig support 
From: ebiederman@lnxi.com (Eric W. Biederman)
Date: 22 Apr 2001 18:17:30 -0600
Message-ID: <m3wv8c79lx.fsf@DLT.linuxnetworx.com>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.5
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=


Here is a forward port of the 2.2.x improvements to ipconfig.c.
Especially support for DHCP.

Eric


--=-=-=
Content-Type: text/x-patch
Content-Disposition: attachment; filename=linux-2.4.3.ipdhcp.diff

diff -uNr linux-2.4.3/Documentation/Configure.help linux-2.4.3.ipdhcp/Documentation/Configure.help
--- linux-2.4.3/Documentation/Configure.help	Fri Apr 20 12:06:37 2001
+++ linux-2.4.3.ipdhcp/Documentation/Configure.help	Sun Apr 22 16:03:26 2001
@@ -3961,6 +3961,21 @@
   want to use BOOTP, a BOOTP server must be operating on your network.
   Read Documentation/nfsroot.txt for details.
 
+DHCP support
+CONFIG_IP_PNP_DHCP
+  If you want your Linux box to mount its whole root filesystem (the
+  one containing the directory /) from some other computer over the
+  net via NFS and you want the IP address of your computer to be
+  discovered automatically at boot time using the DHCP protocol (a
+  special protocol designed for doing this job), say Y here. In case
+  the boot ROM of your network card was designed for booting Linux and
+  does DHCP itself, providing all necessary information on the kernel
+  command line, you can say N here.
+
+  If unsure, say Y. Note that if you want to use DHCP, a DHCP server
+  must be operating on your network.  Read Documentation/nfsroot.txt
+  for details.
+
 RARP support
 CONFIG_IP_PNP_RARP
   If you want your Linux box to mount its whole root file system (the
diff -uNr linux-2.4.3/include/net/ipconfig.h linux-2.4.3.ipdhcp/include/net/ipconfig.h
--- linux-2.4.3/include/net/ipconfig.h	Mon Jan  4 16:31:35 1999
+++ linux-2.4.3.ipdhcp/include/net/ipconfig.h	Sun Apr 22 16:03:26 2001
@@ -6,16 +6,33 @@
  *  Automatic IP Layer Configuration
  */
 
-extern __u32 root_server_addr;
-extern u8 root_server_path[];
-extern u32 ic_myaddr;
-extern u32 ic_servaddr;
-extern u32 ic_gateway;
-extern u32 ic_netmask;
-extern int ic_enable;
-extern int ic_host_name_set;
-extern int ic_set_manually;
-extern int ic_proto_enabled;
+/* The following are initdata: */
 
-#define IC_BOOTP 1
-#define IC_RARP 2
+extern int ic_enable;		/* Enable or disable the whole shebang */
+
+extern int ic_proto_enabled;	/* Protocols enabled (see IC_xxx) */
+extern int ic_host_name_set;	/* Host name set by ipconfig? */
+extern int ic_set_manually;	/* IPconfig parameters set manually */
+
+extern u32 ic_myaddr;		/* My IP address */
+extern u32 ic_netmask;		/* Netmask for local subnet */
+extern u32 ic_gateway;		/* Gateway IP address */
+
+extern u32 ic_servaddr;		/* Boot server IP address */
+
+extern u32 root_server_addr;	/* Address of NFS server */
+extern u8 root_server_path[];	/* Path to mount as root */
+
+
+
+/* The following are persistent (not initdata): */
+
+extern int ic_proto_used;	/* Protocol used, if any */
+extern u32 ic_nameserver;	/* DNS server IP address */
+extern u8 ic_domain[];		/* DNS (not NIS) domain name */
+
+/* bits in ic_proto_{enabled,used} */
+#define IC_PROTO	0xFF	/* Protocols mask: */
+#define IC_BOOTP	0x01	/*   BOOTP (or DHCP, see below) */
+#define IC_RARP		0x02	/*   RARP */
+#define IC_USE_DHCP    0x100	/* If on, use DHCP instead of BOOTP */
diff -uNr linux-2.4.3/net/ipv4/Config.in linux-2.4.3.ipdhcp/net/ipv4/Config.in
--- linux-2.4.3/net/ipv4/Config.in	Tue Nov  7 15:12:02 2000
+++ linux-2.4.3.ipdhcp/net/ipv4/Config.in	Sun Apr 22 16:03:26 2001
@@ -20,6 +20,7 @@
 fi
 bool '  IP: kernel level autoconfiguration' CONFIG_IP_PNP
 if [ "$CONFIG_IP_PNP" = "y" ]; then
+   bool '    IP: DHCP support' CONFIG_IP_PNP_DHCP
    bool '    IP: BOOTP support' CONFIG_IP_PNP_BOOTP
    bool '    IP: RARP support' CONFIG_IP_PNP_RARP
 # not yet ready..
diff -uNr linux-2.4.3/net/ipv4/ipconfig.c linux-2.4.3.ipdhcp/net/ipv4/ipconfig.c
--- linux-2.4.3/net/ipv4/ipconfig.c	Mon Mar 26 18:20:57 2001
+++ linux-2.4.3.ipdhcp/net/ipv4/ipconfig.c	Sun Apr 22 16:55:36 2001
@@ -1,10 +1,10 @@
 /*
  *  $Id: ipconfig.c,v 1.35 2000/12/30 06:46:36 davem Exp $
  *
- *  Automatic Configuration of IP -- use BOOTP or RARP or user-supplied
- *  information to configure own IP address and routes.
+ *  Automatic Configuration of IP -- use DHCP, BOOTP, RARP, or
+ *  user-supplied information to configure own IP address and routes.
  *
- *  Copyright (C) 1996--1998 Martin Mares <mj@atrey.karlin.mff.cuni.cz>
+ *  Copyright (C) 1996-1998 Martin Mares <mj@atrey.karlin.mff.cuni.cz>
  *
  *  Derived from network configuration code in fs/nfs/nfsroot.c,
  *  originally Copyright (C) 1995, 1996 Gero Kuhlmann and me.
@@ -16,6 +16,16 @@
  *  Fixed ip_auto_config_setup calling at startup in the new "Linker Magic"
  *  initialization scheme.
  *	- Arnaldo Carvalho de Melo <acme@conectiva.com.br>, 08/11/1999
+ *
+ *  DHCP support added.  To users this looks like a whole separate
+ *  protocol, but we know it's just a bag on the side of BOOTP.
+ *		-- Chip Salzenberg <chip@valinux.com>, May 2000
+ *
+ *  Ported DHCP support from 2.2.16 to 2.4.0-test4
+ *              -- Eric Biederman <ebiederman@lnxi.com>, 30 Aug 2000
+ *
+ *  Merged changes from 2.2.19 into 2.4.3
+ *              -- Eric Biederman <ebiederman@lnxi.com>, 22 April Aug 2001
  */
 
 #include <linux/config.h>
@@ -36,6 +46,7 @@
 #include <linux/socket.h>
 #include <linux/route.h>
 #include <linux/udp.h>
+#include <linux/proc_fs.h>
 #include <net/arp.h>
 #include <net/ip.h>
 #include <net/ipconfig.h>
@@ -52,48 +63,88 @@
 #define DBG(x) do { } while(0)
 #endif
 
-/* Define the timeout for waiting for a RARP/BOOTP reply */
-#define CONF_BASE_TIMEOUT	(HZ*5)	/* Initial timeout: 5 seconds */
-#define CONF_RETRIES	 	10	/* 10 retries */
+#if defined(CONFIG_IP_PNP_DHCP)
+#define IPCONFIG_DHCP
+#endif
+#if defined(CONFIG_IP_PNP_BOOTP) || defined(CONFIG_IP_PNP_DHCP)
+#define IPCONFIG_BOOTP
+#endif
+#if defined(CONFIG_IP_PNP_RARP)
+#define IPCONFIG_RARP
+#endif
+#if defined(IPCONFIG_BOOTP) || defined(IPCONFIG_RARP)
+#define IPCONFIG_DYNAMIC
+#endif
+
+/* Define the friendly delay before and after opening net devices */
+#define CONF_PRE_OPEN		(HZ/2)	/* Before opening: 1/2 second */
+#define CONF_POST_OPEN		(1*HZ)	/* After opening: 1 second */
+
+/* Define the timeout for waiting for a DHCP/BOOTP/RARP reply */
+#define CONF_OPEN_RETRIES 	2	/* (Re)open devices twice */
+#define CONF_SEND_RETRIES 	6	/* Send six requests per open */
+#define CONF_INTER_TIMEOUT	(HZ/2)	/* Inter-device timeout: 1/2 second */
+#define CONF_BASE_TIMEOUT	(HZ*2)	/* Initial timeout: 2 seconds */
 #define CONF_TIMEOUT_RANDOM	(HZ)	/* Maximum amount of randomization */
-#define CONF_TIMEOUT_MULT	*5/4	/* Rate of timeout growth */
+#define CONF_TIMEOUT_MULT	*7/4	/* Rate of timeout growth */
 #define CONF_TIMEOUT_MAX	(HZ*30)	/* Maximum allowed timeout */
 
-/* IP configuration */
-static char user_dev_name[IFNAMSIZ] __initdata = { 0, };/* Name of user-selected boot device */
-u32 ic_myaddr __initdata = INADDR_NONE;		/* My IP address */
-u32 ic_servaddr __initdata = INADDR_NONE;	/* Server IP address */
-u32 ic_gateway __initdata = INADDR_NONE;	/* Gateway IP address */
-u32 ic_netmask __initdata = INADDR_NONE;	/* Netmask for local subnet */
-int ic_enable __initdata = 1;			/* Automatic IP configuration enabled */
-int ic_host_name_set __initdata = 0;		/* Host name configured manually */
-int ic_set_manually __initdata = 0;		/* IPconfig parameters set manually */
-
-u32 root_server_addr __initdata = INADDR_NONE;		/* Address of boot server */
-u8 root_server_path[256] __initdata = { 0, };		/* Path to mount as root */
 
-#if defined(CONFIG_IP_PNP_BOOTP) || defined(CONFIG_IP_PNP_RARP)
+/*
+ * Public IP configuration
+ */
 
-#define CONFIG_IP_PNP_DYNAMIC
+int ic_enable __initdata = 0;			/* IP config enabled? */
 
-int ic_proto_enabled __initdata = 0			/* Protocols enabled */
-#ifdef CONFIG_IP_PNP_BOOTP
+/* Protocol choice */
+static int ic_proto_enabled __initdata = 0
+#ifdef IPCONFIG_BOOTP
 			| IC_BOOTP
 #endif
-#ifdef CONFIG_IP_PNP_RARP
+#ifdef CONFIG_IP_PNP_DHCP
+			| IC_USE_DHCP
+#endif
+#ifdef IPCONFIG_RARP
 			| IC_RARP
 #endif
 			;
-static int ic_got_reply __initdata = 0;				/* Protocol(s) we got reply from */
 
-#else
+int ic_host_name_set __initdata = 0;		/* Host name set by us? */
+
+u32 ic_myaddr __initdata = INADDR_NONE;		/* My IP address */
+u32 ic_netmask __initdata = INADDR_NONE;	/* Netmask for local subnet */
+u32 ic_gateway __initdata = INADDR_NONE;	/* Gateway IP address */
 
-static int ic_proto_enabled __initdata = 0;
+u32 ic_servaddr __initdata = INADDR_NONE;	/* Boot server IP address */
 
-#endif
+u32 root_server_addr __initdata = INADDR_NONE;	/* Address of NFS server */
+u8 root_server_path[256] __initdata = { 0, };	/* Path to mount as root */
 
+/* Persistent data: */
+
+int ic_proto_used = 0;			/* Protocol used, if any */
+u32 ic_nameserver = INADDR_NONE;	/* DNS Server IP address */
+u8 ic_domain[64] = { 0, };		/* DNS (not NIS) domain name */
+
+/*
+ * Private state.
+ */
+
+/* Name of user-selected boot device */
+static char user_dev_name[IFNAMSIZ] __initdata = { 0, };
+
+/* Protocols supported by available interfaces */
 static int ic_proto_have_if __initdata = 0;
 
+#ifdef IPCONFIG_DYNAMIC
+static spinlock_t ic_recv_lock = SPIN_LOCK_UNLOCKED;
+static volatile int ic_got_reply __initdata = 0;    /* Proto(s) that replied */
+#endif
+#ifdef IPCONFIG_DHCP
+static int ic_dhcp_msgtype __initdata = 0;	/* DHCP msg type received */
+#endif
+
+
 /*
  *	Network devices
  */
@@ -102,11 +153,12 @@
 	struct ic_device *next;
 	struct net_device *dev;
 	unsigned short flags;
-	int able;
+	short able;
+	u32 xid;
 };
 
 static struct ic_device *ic_first_dev __initdata = NULL;/* List of open device */
-static struct net_device *ic_dev __initdata = NULL;		/* Selected device */
+static struct net_device *ic_dev __initdata = NULL;	/* Selected device */
 
 static int __init ic_open_devs(void)
 {
@@ -125,7 +177,7 @@
 			if (dev->mtu >= 364)
 				able |= IC_BOOTP;
 			else
-				printk(KERN_WARNING "BOOTP: Ignoring device %s, MTU %d too small", dev->name, dev->mtu);
+				printk(KERN_WARNING "DHCP/BOOTP: Ignoring device %s, MTU %d too small", dev->name, dev->mtu);
 			if (!(dev->flags & IFF_NOARP))
 				able |= IC_RARP;
 			able &= ic_proto_enabled;
@@ -143,8 +195,13 @@
 			last = &d->next;
 			d->flags = oflags;
 			d->able = able;
+			if (able & IC_BOOTP)
+				get_random_bytes(&d->xid, sizeof(u32));
+			else
+				d->xid = 0;
 			ic_proto_have_if |= able;
-			DBG(("IP-Config: Opened %s (able=%d)\n", dev->name, able));
+			DBG(("IP-Config: %s UP (able=%d, xid=%08x)\n",
+				dev->name, able, d->xid));
 		}
 	}
 	rtnl_shunlock();
@@ -282,7 +339,7 @@
 	 */
 	 
 	if (!ic_host_name_set)
-		strcpy(system_utsname.nodename, in_ntoa(ic_myaddr));
+		sprintf(system_utsname.nodename, "%u.%u.%u.%u", NIPQUAD(ic_myaddr));
 
 	if (root_server_addr == INADDR_NONE)
 		root_server_addr = ic_servaddr;
@@ -309,7 +366,7 @@
  *	RARP support.
  */
 
-#ifdef CONFIG_IP_PNP_RARP
+#ifdef IPCONFIG_RARP
 
 static int ic_rarp_recv(struct sk_buff *skb, struct net_device *dev, struct packet_type *pt);
 
@@ -341,11 +398,22 @@
 	unsigned char *rarp_ptr = (unsigned char *) (rarp + 1);
 	unsigned long sip, tip;
 	unsigned char *sha, *tha;		/* s for "source", t for "target" */
+	struct ic_device *d;
+
+	/* One reply at a time, please. */
+	spin_lock(&ic_recv_lock);
 
 	/* If we already have a reply, just drop the packet */
 	if (ic_got_reply)
 		goto drop;
 
+	/* Find the ic_device that the packet arrived on */
+	d = ic_first_dev;
+	while (d && d->dev != dev)
+		d = d->next;
+	if (!d)
+		goto drop;	/* should never happen */
+
 	/* If this test doesn't pass, it's not IP, or we should ignore it anyway */
 	if (rarp->ar_hln != dev->addr_len || dev->type != ntohs(rarp->ar_hrd))
 		goto drop;
@@ -375,23 +443,34 @@
 	if (ic_servaddr != INADDR_NONE && ic_servaddr != sip)
 		goto drop;
 
-	/* Victory! The packet is what we were looking for! */
-	if (!ic_got_reply) {
-		ic_got_reply = IC_RARP;
-		ic_dev = dev;
-		if (ic_myaddr == INADDR_NONE)
-			ic_myaddr = tip;
-		ic_servaddr = sip;
-	}
+	/* We have a winner! */
+	ic_dev = dev;
+	if (ic_myaddr == INADDR_NONE)
+		ic_myaddr = tip;
+	ic_servaddr = sip;
+	ic_got_reply = IC_RARP;
 
-	/* And throw the packet out... */
 drop:
+	/* Show's over.  Nothing to see here.  */
+	spin_unlock(&ic_recv_lock);
+
+	/* Throw the packet out. */
 	kfree_skb(skb);
 	return 0;
 }
 
 
 /*
+ *  Send RARP request packet over a signle interface.
+ */
+static void __init ic_rarp_send_if(struct ic_device *d)
+{
+	struct net_device *dev = d->dev;
+	arp_send(ARPOP_RREQUEST, ETH_P_RARP, 0, dev, 0, NULL,
+		 dev->dev_addr, dev->dev_addr);
+}
+
+/*
  *  Send RARP request packet over all devices which allow RARP.
  */
 static void __init ic_rarp_send(void)
@@ -399,20 +478,17 @@
 	struct ic_device *d;
 
 	for (d=ic_first_dev; d; d=d->next)
-		if (d->able & IC_RARP) {
-			struct net_device *dev = d->dev;
-			arp_send(ARPOP_RREQUEST, ETH_P_RARP, 0, dev, 0, NULL,
-				 dev->dev_addr, dev->dev_addr);
-		}
+		if (d->able & IC_RARP)
+			ic_rarp_send_if(d);
 }
 
 #endif
 
 /*
- *	BOOTP support.
+ *	DHCP/BOOTP support.
  */
 
-#ifdef CONFIG_IP_PNP_BOOTP
+#ifdef IPCONFIG_BOOTP
 
 struct bootp_pkt {		/* BOOTP packet format */
 	struct iphdr iph;	/* IP header */
@@ -426,18 +502,27 @@
 	u16 flags;		/* Just what it says */
 	u32 client_ip;		/* Client's IP address if known */
 	u32 your_ip;		/* Assigned IP address */
-	u32 server_ip;		/* Server's IP address */
+	u32 server_ip;		/* (Next, e.g. NFS) Server's IP address */
 	u32 relay_ip;		/* IP address of BOOTP relay */
 	u8 hw_addr[16];		/* Client's HW address */
 	u8 serv_name[64];	/* Server host name */
 	u8 boot_file[128];	/* Name of boot file */
-	u8 vendor_area[128];	/* Area for extensions */
+	u8 exten[312];		/* DHCP options / BOOTP vendor extensions */
 };
 
-#define BOOTP_REQUEST 1
-#define BOOTP_REPLY 2
-
-static u32 ic_bootp_xid;
+/* packet ops */
+#define BOOTP_REQUEST	1
+#define BOOTP_REPLY	2
+
+/* DHCP message types */
+#define DHCPDISCOVER	1
+#define DHCPOFFER	2
+#define DHCPREQUEST	3
+#define DHCPDECLINE	4
+#define DHCPACK		5
+#define DHCPNAK		6
+#define DHCPRELEASE	7
+#define DHCPINFORM	8
 
 static int ic_bootp_recv(struct sk_buff *skb, struct net_device *dev, struct packet_type *pt);
 
@@ -451,20 +536,79 @@
 
 
 /*
- *  Initialize BOOTP extension fields in the request.
+ *  Initialize DHCP/BOOTP extension fields in the request.
  */
+
+static const u8 ic_bootp_cookie[4] = { 99, 130, 83, 99 };
+
+#ifdef IPCONFIG_DHCP
+
+static void __init
+ic_dhcp_init_options(u8 *options)
+{
+	u8 mt = ((ic_servaddr == INADDR_NONE)
+		 ? DHCPDISCOVER : DHCPREQUEST);
+	u8 *e = options;
+
+#ifdef IPCONFIG_DEBUG
+	printk("DHCP: Sending message type %d\n", mt);
+#endif
+
+	memcpy(e, ic_bootp_cookie, 4);	/* RFC1048 Magic Cookie */
+	e += 4;
+
+	*e++ = 53;		/* DHCP message type */
+	*e++ = 1;
+	*e++ = mt;
+
+	if (mt == DHCPREQUEST) {
+		*e++ = 54;	/* Server ID (IP address) */
+		*e++ = 4;
+		memcpy(e, &ic_servaddr, 4);
+		e += 4;
+
+		*e++ = 50;	/* Requested IP address */
+		*e++ = 4;
+		memcpy(e, &ic_myaddr, 4);
+		e += 4;
+	}
+
+	/* always? */
+	{
+		static const u8 ic_req_params[] = {
+			1,	/* Subnet mask */
+			3,	/* Default gateway */
+			6,	/* DNS server */
+			12,	/* Host name */
+			15,	/* Domain name */
+			17,	/* Boot path */
+			40,	/* NIS domain name */
+		};
+
+		*e++ = 55;	/* Parameter request list */
+		*e++ = sizeof(ic_req_params);
+		memcpy(e, ic_req_params, sizeof(ic_req_params));
+		e += sizeof(ic_req_params);
+	}
+
+	*e++ = 255;	/* End of the list */
+}
+
+#endif /* IPCONFIG_DHCP */
+
 static void __init ic_bootp_init_ext(u8 *e)
 {
-	*e++ = 99;		/* RFC1048 Magic Cookie */
-	*e++ = 130;
-	*e++ = 83;
-	*e++ = 99;
+	memcpy(e, ic_bootp_cookie, 4);	/* RFC1048 Magic Cookie */
+	e += 4;
 	*e++ = 1;		/* Subnet mask request */
 	*e++ = 4;
 	e += 4;
 	*e++ = 3;		/* Default gateway request */
 	*e++ = 4;
 	e += 4;
+	*e++ = 5;		/* Name server reqeust */
+	*e++ = 8;
+	e += 8;
 	*e++ = 12;		/* Host name request */
 	*e++ = 32;
 	e += 32;
@@ -472,25 +616,23 @@
 	*e++ = 32;
 	e += 32;
 	*e++ = 17;		/* Boot path */
-	*e++ = 32;
-	e += 32;
-	*e = 255;		/* End of the list */
+	*e++ = 40;
+	e += 40;
+	*e++ = 255;		/* End of the list */
 }
 
 
 /*
- *  Initialize the BOOTP mechanism.
+ *  Initialize the DHCP/BOOTP mechanism.
  */
 static inline void ic_bootp_init(void)
 {
-	get_random_bytes(&ic_bootp_xid, sizeof(u32));
-	DBG(("BOOTP: XID=%08x\n", ic_bootp_xid));
 	dev_add_pack(&bootp_packet_type);
 }
 
 
 /*
- *  BOOTP cleanup.
+ *  DHCP/BOOTP cleanup.
  */
 static inline void ic_bootp_cleanup(void)
 {
@@ -499,7 +641,7 @@
 
 
 /*
- *  Send BOOTP request to single interface.
+ *  Send DHCP/BOOTP request to single interface.
  */
 static void __init ic_bootp_send_if(struct ic_device *d, u32 jiffies)
 {
@@ -534,7 +676,7 @@
 	b->udph.len = htons(sizeof(struct bootp_pkt) - sizeof(struct iphdr));
 	/* UDP checksum not calculated -- explicitly allowed in BOOTP RFC */
 
-	/* Construct BOOTP header */
+	/* Construct DHCP/BOOTP header */
 	b->op = BOOTP_REQUEST;
 	if (dev->type < 256) /* check for false types */
 		b->htype = dev->type;
@@ -545,10 +687,19 @@
 		b->htype = dev->type; /* can cause undefined behavior */
 	}
 	b->hlen = dev->addr_len;
+	b->your_ip = INADDR_NONE;
+	b->server_ip = INADDR_NONE;
 	memcpy(b->hw_addr, dev->dev_addr, dev->addr_len);
 	b->secs = htons(jiffies / HZ);
-	b->xid = ic_bootp_xid;
-	ic_bootp_init_ext(b->vendor_area);
+	b->xid = d->xid;
+
+	/* add DHCP options or BOOTP extensions */
+#ifdef IPCONFIG_DHCP
+	if (ic_proto_enabled & IC_USE_DHCP)
+		ic_dhcp_init_options(b->exten);
+	else
+#endif
+		ic_bootp_init_ext(b->exten);
 
 	/* Chain packet down the line... */
 	skb->dev = dev;
@@ -561,15 +712,16 @@
 
 
 /*
- *  Send BOOTP requests to all interfaces.
+ *  Send DHCP/BOOTP requests to all interfaces.
  */
 static void __init ic_bootp_send(u32 jiffies)
 {
 	struct ic_device *d;
 
-	for(d=ic_first_dev; d; d=d->next)
+	for(d = ic_first_dev; d; d=d->next) {
 		if (d->able & IC_BOOTP)
 			ic_bootp_send_if(d, jiffies);
+	}
 }
 
 
@@ -582,21 +734,21 @@
 		return 0;
 	if (len > max-1)
 		len = max-1;
-	strncpy(dest, src, len);
+	memcpy(dest, src, len);
 	dest[len] = '\0';
 	return 1;
 }
 
 
 /*
- *  Process BOOTP extension.
+ *  Process BOOTP extensions.
  */
 static void __init ic_do_bootp_ext(u8 *ext)
 {
 #ifdef IPCONFIG_DEBUG
 	u8 *c;
 
-	printk("BOOTP: Got extension %02x",*ext);
+	printk("DHCP/BOOTP: Got extension %d:",*ext);
 	for(c=ext+2; c<ext+2+ext[1]; c++)
 		printk(" %02x", *c);
 	printk("\n");
@@ -611,17 +763,24 @@
 			if (ic_gateway == INADDR_NONE)
 				memcpy(&ic_gateway, ext+1, 4);
 			break;
+		case 6:		/* DNS server */
+			if (ic_nameserver == INADDR_NONE)
+				memcpy(&ic_nameserver, ext+1, 4);
+			break;
 		case 12:	/* Host name */
 			ic_bootp_string(system_utsname.nodename, ext+1, *ext, __NEW_UTS_LEN);
 			ic_host_name_set = 1;
 			break;
-		case 40:	/* NIS Domain name */
-			ic_bootp_string(system_utsname.domainname, ext+1, *ext, __NEW_UTS_LEN);
+		case 15:	/* Domain name (DNS) */
+			ic_bootp_string(ic_domain, ext+1, *ext, sizeof(ic_domain));
 			break;
 		case 17:	/* Root path */
 			if (!root_server_path[0])
 				ic_bootp_string(root_server_path, ext+1, *ext, sizeof(root_server_path));
 			break;
+		case 40:	/* NIS Domain name (_not_ DNS) */
+			ic_bootp_string(system_utsname.domainname, ext+1, *ext, __NEW_UTS_LEN);
+			break;
 	}
 }
 
@@ -633,12 +792,23 @@
 {
 	struct bootp_pkt *b = (struct bootp_pkt *) skb->nh.iph;
 	struct iphdr *h = &b->iph;
+	struct ic_device *d;
 	int len;
 
+	/* One reply at a time, please. */
+	spin_lock(&ic_recv_lock);
+
 	/* If we already have a reply, just drop the packet */
 	if (ic_got_reply)
 		goto drop;
 
+	/* Find the ic_device that the packet arrived on */
+	d = ic_first_dev;
+	while (d && d->dev != dev)
+		d = d->next;
+	if (!d)
+		goto drop;  /* should never happen */
+
 	/* Check whether it's a BOOTP packet */
 	if (skb->pkt_type == PACKET_OTHERHOST ||
 	    skb->len < sizeof(struct udphdr) + sizeof(struct iphdr) ||
@@ -654,7 +824,7 @@
 
 	/* Fragments are not supported */
 	if (h->frag_off & htons(IP_OFFSET|IP_MF)) {
-		printk(KERN_ERR "BOOTP: Ignoring fragmented reply.\n");
+		printk(KERN_ERR "DHCP/BOOTP: Ignoring fragmented reply.\n");
 		goto drop;
 	}
 
@@ -662,41 +832,103 @@
 	len = ntohs(b->udph.len) - sizeof(struct udphdr);
 	if (len < 300 ||				    /* See RFC 951:2.1 */
 	    b->op != BOOTP_REPLY ||
-	    b->xid != ic_bootp_xid) {
+	    b->xid != d->xid) {
 		printk("?");
 		goto drop;
 	}
 
-	/* Extract basic fields */
-	ic_myaddr = b->your_ip;
-	ic_servaddr = b->server_ip;
-	ic_got_reply = IC_BOOTP;
-	ic_dev = dev;
-
 	/* Parse extensions */
-	if (b->vendor_area[0] == 99 &&	/* Check magic cookie */
-	    b->vendor_area[1] == 130 &&
-	    b->vendor_area[2] == 83 &&
-	    b->vendor_area[3] == 99) {
-		u8 *ext = &b->vendor_area[4];
+	if (!memcmp(b->exten, ic_bootp_cookie, 4)) { /* Check magic cookie */
                 u8 *end = (u8 *) b + ntohs(b->iph.tot_len);
+		u8 *ext;
+
+#ifdef IPCONFIG_DHCP
+
+		u32 server_id = INADDR_NONE;
+		int mt = 0;
+
+		ext = &b->exten[4];
 		while (ext < end && *ext != 0xff) {
-			if (*ext == 0)		/* Padding */
-				ext++;
-			else {
-				u8 *opt = ext;
-				ext += ext[1] + 2;
-				if (ext <= end)
-					ic_do_bootp_ext(opt);
+			u8 *opt = ext++;
+			if (*opt == 0)	/* Padding */
+				continue;
+			ext += *ext + 1;
+			if (ext >= end)
+				break;
+			switch (*opt) {
+			case 53:	/* Message type */
+				if (opt[1])
+					mt = opt[2];
+				break;
+			case 54:	/* Server ID (IP address) */
+				if (opt[1] >= 4)
+					memcpy(&server_id, opt + 2, 4);
+				break;
 			}
 		}
+
+#ifdef IPCONFIG_DEBUG
+		printk("DHCP: Got message type %d\n", mt);
+#endif
+
+		switch (mt) {
+		    case DHCPOFFER:
+			/* While in the process of accepting one offer,
+			   ignore all others. */
+			if (ic_myaddr != INADDR_NONE)
+				goto drop;
+			/* Let's accept that offer. */
+			ic_myaddr = b->your_ip;
+			ic_servaddr = server_id;
+#ifdef IPCONFIG_DEBUG
+			printk("DHCP: Offered address %u.%u.%u.%u", NIPQUAD(ic_myaddr));
+			printk(" by server %u.%u.%u.%u\n", NIPQUAD(ic_servaddr));
+#endif
+			break;
+
+		    case DHCPACK:
+			/* Yeah! */
+			break;
+
+		    default:
+			/* Urque.  Forget it*/
+			ic_myaddr = INADDR_NONE;
+			ic_servaddr = INADDR_NONE;
+			goto drop;
+		}
+
+		ic_dhcp_msgtype = mt;
+
+#endif /* IPCONFIG_DHCP */
+
+		ext = &b->exten[4];
+		while (ext < end && *ext != 0xff) {
+			u8 *opt = ext++;
+			if (*opt == 0)	/* Padding */
+				continue;
+			ext += *ext + 1;
+			if (ext < end)
+				ic_do_bootp_ext(opt);
+		}
 	}
 
+	/* We have a winner! */
+	ic_dev = dev;
+	ic_myaddr = b->your_ip;
+	ic_servaddr = b->server_ip;
 	if (ic_gateway == INADDR_NONE && b->relay_ip)
 		ic_gateway = b->relay_ip;
+	if (ic_nameserver == INADDR_NONE)
+		ic_nameserver = ic_servaddr;
+	ic_got_reply = IC_BOOTP;
 
 drop:
+	/* Show's over.  Nothing to see here.  */
+	spin_unlock(&ic_recv_lock);
+
+	/* Throw the packet out. */
 	kfree_skb(skb);
+
 	return 0;
 }	
 
@@ -705,36 +937,34 @@
 
 
 /*
- *	Dynamic IP configuration -- BOOTP and RARP.
+ *	Dynamic IP configuration -- DHCP, BOOTP, RARP.
  */
 
-#ifdef CONFIG_IP_PNP_DYNAMIC
+#ifdef IPCONFIG_DYNAMIC
 
 static int __init ic_dynamic(void)
 {
 	int retries;
-	unsigned long timeout, jiff;
-	unsigned long start_jiffies;
-	int do_rarp = ic_proto_have_if & IC_RARP;
+	struct ic_device *d;
+	unsigned long start_jiffies, timeout, jiff;
 	int do_bootp = ic_proto_have_if & IC_BOOTP;
+	int do_rarp = ic_proto_have_if & IC_RARP;
 
 	/*
-	 * If neither BOOTP nor RARP was selected, return with an error. This
-	 * routine gets only called when some pieces of information are mis-
-	 * sing, and without BOOTP and RARP we are not able to get that in-
-	 * formation.
+	 * If none of DHCP/BOOTP/RARP was selected, return with an error.
+	 * This routine gets only called when some pieces of information
+	 * are missing, and without DHCP/BOOTP/RARP we are unable to get it.
 	 */
 	if (!ic_proto_enabled) {
 		printk(KERN_ERR "IP-Config: Incomplete network configuration information.\n");
 		return -1;
 	}
 
-#ifdef CONFIG_IP_PNP_BOOTP
+#ifdef IPCONFIG_BOOTP
 	if ((ic_proto_enabled ^ ic_proto_have_if) & IC_BOOTP)
-		printk(KERN_ERR "BOOTP: No suitable device found.\n");
+		printk(KERN_ERR "DHCP/BOOTP: No suitable device found.\n");
 #endif
-
-#ifdef CONFIG_IP_PNP_RARP
+#ifdef IPCONFIG_RARP
 	if ((ic_proto_enabled ^ ic_proto_have_if) & IC_RARP)
 		printk(KERN_ERR "RARP: No suitable device found.\n");
 #endif
@@ -744,16 +974,16 @@
 		return -1;
 
 	/*
-	 * Setup RARP and BOOTP protocols
+	 * Setup protocols
 	 */
-#ifdef CONFIG_IP_PNP_RARP
-	if (do_rarp)
-		ic_rarp_init();
-#endif
-#ifdef CONFIG_IP_PNP_BOOTP
+#ifdef IPCONFIG_BOOTP
 	if (do_bootp)
 		ic_bootp_init();
 #endif
+#ifdef IPCONFIG_RARP
+	if (do_rarp)
+		ic_rarp_init();
+#endif
 
 	/*
 	 * Send requests and wait, until we get an answer. This loop
@@ -763,61 +993,119 @@
 	 * [Actually we could now, but the nothing else running note still 
 	 *  applies.. - AC]
 	 */
-	printk(KERN_NOTICE "Sending %s%s%s requests...",
-	        do_bootp ? "BOOTP" : "",
-		do_bootp && do_rarp ? " and " : "",
-		do_rarp ? "RARP" : "");
+	printk(KERN_NOTICE "Sending %s%s%s requests .",
+	       do_bootp
+		? ((ic_proto_enabled & IC_USE_DHCP) ? "DHCP" : "BOOTP") : "",
+	       (do_bootp && do_rarp) ? " and " : "",
+	       do_rarp ? "RARP" : "");
+
 	start_jiffies = jiffies;
-	retries = CONF_RETRIES;
+	d = ic_first_dev;
+	retries = CONF_SEND_RETRIES;
 	get_random_bytes(&timeout, sizeof(timeout));
 	timeout = CONF_BASE_TIMEOUT + (timeout % (unsigned) CONF_TIMEOUT_RANDOM);
 	for(;;) {
-#ifdef CONFIG_IP_PNP_BOOTP
-		if (do_bootp)
-			ic_bootp_send(jiffies - start_jiffies);
+#ifdef IPCONFIG_BOOTP
+		if (do_bootp && (d->able & IC_BOOTP))
+			ic_bootp_send_if(d, jiffies - start_jiffies);
 #endif
-#ifdef CONFIG_IP_PNP_RARP
-		if (do_rarp)
-			ic_rarp_send();
+#ifdef IPCONFIG_RARP
+		if (do_rarp && (d->able & IC_RARP))
+			ic_rarp_send_if(d);
 #endif
-		printk(".");
-		jiff = jiffies + timeout;
+
+		jiff = jiffies + (d->next ? CONF_INTER_TIMEOUT : timeout);
 		while (jiffies < jiff && !ic_got_reply)
 			barrier();
+#ifdef IPCONFIG_DHCP
+		/* DHCP isn't done until we get a DHCPACK. */
+		if ((ic_got_reply & IC_BOOTP)
+		    && (ic_proto_enabled & IC_USE_DHCP)
+		    && ic_dhcp_msgtype != DHCPACK)
+		{
+			ic_got_reply = 0;
+			printk(",");
+			continue;
+		}
+#endif /* IPCONFIG_DHCP */
+
 		if (ic_got_reply) {
 			printk(" OK\n");
 			break;
 		}
+
+		if ((d = d->next))
+			continue;
+
 		if (! --retries) {
 			printk(" timed out!\n");
 			break;
 		}
+
+		d = ic_first_dev;
+
 		timeout = timeout CONF_TIMEOUT_MULT;
 		if (timeout > CONF_TIMEOUT_MAX)
 			timeout = CONF_TIMEOUT_MAX;
+
+		printk(".");
 	}
 
-#ifdef CONFIG_IP_PNP_RARP
-	if (do_rarp)
-		ic_rarp_cleanup();
-#endif
-#ifdef CONFIG_IP_PNP_BOOTP
+#ifdef IPCONFIG_BOOTP
 	if (do_bootp)
 		ic_bootp_cleanup();
 #endif
+#ifdef IPCONFIG_RARP
+	if (do_rarp)
+		ic_rarp_cleanup();
+#endif
 
 	if (!ic_got_reply)
 		return -1;
 
 	printk("IP-Config: Got %s answer from %u.%u.%u.%u, ",
-		(ic_got_reply & IC_BOOTP) ? "BOOTP" : "RARP",
+		((ic_got_reply & IC_RARP) ? "RARP" 
+		 : (ic_proto_enabled & IC_USE_DHCP) ? "DHCP" : "BOOTP"),
 		NIPQUAD(ic_servaddr));
 	printk("my address is %u.%u.%u.%u\n", NIPQUAD(ic_myaddr));
 
 	return 0;
 }
 
-#endif
+#endif /* IPCONFIG_DYNAMIC */
+
+#ifdef CONFIG_PROC_FS
+
+static int pnp_get_info(char *buffer, char **start,
+			off_t offset, int length, int dummy)
+{
+	int len;
+
+	if (ic_proto_used & IC_PROTO)
+	    sprintf(buffer, "#PROTO: %s\n",
+		    (ic_proto_used & IC_RARP) ? "RARP"
+		    : (ic_proto_used & IC_USE_DHCP) ? "DHCP" : "BOOTP");
+	else
+	    strcpy(buffer, "#MANUAL\n");
+	len = strlen(buffer);
+
+	if (ic_domain[0])
+		len += sprintf(buffer + len,
+			       "domain %s\n", ic_domain);
+	if (ic_nameserver != INADDR_NONE)
+		len += sprintf(buffer + len,
+			       "nameserver %u.%u.%u.%u\n", NIPQUAD(ic_nameserver));
+
+	if (offset > len)
+		offset = len;
+	*start = buffer + offset;
+
+	if (offset + length > len)
+		length = len - offset;
+	return length;
+}
+
+#endif /* CONFIG_PROC_FS */
 
 /*
  *	IP Autoconfig dispatcher.
@@ -825,15 +1113,33 @@
 
 static int __init ip_auto_config(void)
 {
+	int retries = CONF_OPEN_RETRIES;
+	unsigned long jiff;
+
+#ifdef CONFIG_PROC_FS
+	proc_net_create("pnp", 0, pnp_get_info);
+#endif /* CONFIG_PROC_FS */
+
 	if (!ic_enable)
 		return 0;
 
 	DBG(("IP-Config: Entered.\n"));
 
+ try_try_again:
+	/* Give hardware a chance to settle */
+	jiff = jiffies + CONF_PRE_OPEN;
+	while (jiffies < jiff)
+		;
+
 	/* Setup all network devices */
 	if (ic_open_devs() < 0)
 		return -1;
 
+	/* Give drivers a chance to settle */
+	jiff = jiffies + CONF_POST_OPEN;
+	while (jiffies < jiff)
+			;
+
 	/*
 	 * If the config information is insufficient (e.g., our IP address or
 	 * IP address of the boot server is missing or we have multiple network
@@ -845,19 +1151,51 @@
 	    (root_server_addr == INADDR_NONE && ic_servaddr == INADDR_NONE) ||
 #endif
 	    ic_first_dev->next) {
-#ifdef CONFIG_IP_PNP_DYNAMIC
+#ifdef IPCONFIG_DYNAMIC
+
 		if (ic_dynamic() < 0) {
-			printk(KERN_ERR "IP-Config: Auto-configuration of network failed.\n");
 			ic_close_devs();
+
+			/*
+			 * I don't know why, but sometimes the
+			 * eepro100 driver (at least) gets upset and
+			 * doesn't work the first time it's opened.
+			 * But then if you close it and reopen it, it
+			 * works just fine.  So we need to try that at
+			 * least once before giving up.
+			 *
+			 * Also, if the root will be NFS-mounted, we
+			 * have nowhere to go if DHCP fails.  So we
+			 * just have to keep trying forever.
+			 *
+			 * 				-- Chip
+			 */
+#ifdef CONFIG_ROOT_NFS
+			if (ROOT_DEV == MKDEV(UNNAMED_MAJOR, 255)) {
+				printk(KERN_ERR 
+					"IP-Config: Retrying forever (NFS root)...\n");
+				goto try_try_again;
+			}
+#endif
+
+			if (--retries) {
+				printk(KERN_ERR 
+				       "IP-Config: Reopening network devices...\n");
+				goto try_try_again;
+			}
+
+			/* Oh, well.  At least we tried. */
+			printk(KERN_ERR "IP-Config: Auto-configuration of network failed.\n");
 			return -1;
 		}
-#else
+#else /* !DYNAMIC */
 		printk(KERN_ERR "IP-Config: Incomplete network configuration information.\n");
 		ic_close_devs();
 		return -1;
-#endif
+#endif /* IPCONFIG_DYNAMIC */
 	} else {
-		ic_dev = ic_first_dev->dev;	/* Device selected manually or only one device -> use it */
+		/* Device selected manually or only one device -> use it */
+		ic_dev = ic_first_dev->dev;
 	}
 
 	/*
@@ -874,10 +1212,30 @@
 	if (ic_setup_if() < 0 || ic_setup_routes() < 0)
 		return -1;
 
-	DBG(("IP-Config: device=%s, local=%08x, server=%08x, boot=%08x, gw=%08x, mask=%08x\n",
-	    ic_dev->name, ic_myaddr, ic_servaddr, root_server_addr, ic_gateway, ic_netmask));
-	DBG(("IP-Config: host=%s, domain=%s, path=`%s'\n", system_utsname.nodename,
-	    system_utsname.domainname, root_server_path));
+	/*
+	 * Record which protocol was actually used.
+	 */
+#ifdef IPCONFIG_DYNAMIC
+	ic_proto_used = ic_got_reply | (ic_proto_enabled & IC_USE_DHCP);
+#endif
+
+#ifndef IPCONFIG_SILENT
+	/*
+	 * Clue in the operator.
+	 */
+	printk("IP-Config: Complete:");
+	printk("\n      device=%s", ic_dev->name);
+	printk(", addr=%u.%u.%u.%u", NIPQUAD(ic_myaddr));
+	printk(", mask=%u.%u.%u.%u", NIPQUAD(ic_netmask));
+	printk(", gw=%u.%u.%u.%u", NIPQUAD(ic_gateway));
+	printk(",\n     host=%s, domain=%s, nis-domain=%s",
+	       system_utsname.nodename, ic_domain, system_utsname.domainname);
+	printk(",\n     bootserver=%u.%u.%u.%u", NIPQUAD(ic_servaddr));
+	printk(", rootserver=%u.%u.%u.%u", NIPQUAD(root_server_addr));
+	printk(", rootpath=%s", root_server_path);
+	printk("\n");
+#endif /* !SILENT */
+
 	return 0;
 }
 
@@ -889,7 +1247,7 @@
  *  command line parameter. It consists of option fields separated by colons in
  *  the following order:
  *
- *  <client-ip>:<server-ip>:<gw-ip>:<netmask>:<host name>:<device>:<bootp|rarp>
+ *  <client-ip>:<server-ip>:<gw-ip>:<netmask>:<host name>:<device>:<PROTO>
  *
  *  Any of the fields can be empty which means to use a default value:
  *	<client-ip>	- address given by BOOTP or RARP
@@ -900,28 +1258,38 @@
  *	<host name>	- <client-ip> in ASCII notation, or the name returned
  *			  by BOOTP
  *	<device>	- use all available devices
- *	<bootp|rarp|both|off> - use both protocols to determine my own address
+ *	<PROTO>:
+ *	   off|none	    - don't do autoconfig at all (DEFAULT)
+ *	   on|any           - use any configured protocol
+ *	   dhcp|bootp|rarp  - use only the specified protocol
+ *	   both             - use both BOOTP and RARP (not DHCP)
  */
 static int __init ic_proto_name(char *name)
 {
-	if (!strcmp(name, "off")) {
-		ic_proto_enabled = 0;
+	if (!strcmp(name, "on") || !strcmp(name, "any")) {
+		return 1;
+	}
+#ifdef CONFIG_IP_PNP_DHCP
+	else if (!strcmp(name, "dhcp")) {
+		ic_proto_enabled &= ~IC_RARP;
 		return 1;
 	}
+#endif
 #ifdef CONFIG_IP_PNP_BOOTP
 	else if (!strcmp(name, "bootp")) {
-		ic_proto_enabled &= ~IC_RARP;
+		ic_proto_enabled &= ~(IC_RARP | IC_USE_DHCP);
 		return 1;
 	}
 #endif
 #ifdef CONFIG_IP_PNP_RARP
 	else if (!strcmp(name, "rarp")) {
-		ic_proto_enabled &= ~IC_BOOTP;
+		ic_proto_enabled &= ~(IC_BOOTP | IC_USE_DHCP);
 		return 1;
 	}
 #endif
-#ifdef CONFIG_IP_PNP_DYNAMIC
+#ifdef IPCONFIG_DYNAMIC
 	else if (!strcmp(name, "both")) {
+		ic_proto_enabled &= ~IC_USE_DHCP; /* backward compat :-( */
 		return 1;
 	}
 #endif
@@ -933,11 +1301,12 @@
 	char *cp, *ip, *dp;
 	int num = 0;
 
-	ic_set_manually = 1;
-	if (!strcmp(addrs, "off")) {
-		ic_enable = 0;
+	ic_enable = (*addrs && 
+		(strcmp(addrs, "off") != 0) && 
+		(strcmp(addrs, "none") != 0));
+	if (!ic_enable)
 		return 1;
-	}
+
 	if (ic_proto_name(addrs))
 		return 1;
 

--=-=-=




--=-=-=--
