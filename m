Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275862AbRI1HJM>; Fri, 28 Sep 2001 03:09:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275860AbRI1HJF>; Fri, 28 Sep 2001 03:09:05 -0400
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:24054 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S274966AbRI1HIu>; Fri, 28 Sep 2001 03:08:50 -0400
From: Andreas Dilger <adilger@turbolabs.com>
Date: Fri, 28 Sep 2001 01:08:19 -0600
To: Ingo Molnar <mingo@elte.hu>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>, linux-kernel@vger.kernel.org,
        linux-net@vger.kernel.org, netdev@oss.sgi.com,
        jgarzik@mandrakesoft.com
Subject: Re: [patch] netconsole-2.4.10-B1
Message-ID: <20010928010819.A434@turbolinux.com>
Mail-Followup-To: Ingo Molnar <mingo@elte.hu>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
	netdev@oss.sgi.com, jgarzik@mandrakesoft.com
In-Reply-To: <Pine.LNX.4.21.0109261635190.957-100000@freak.distro.conectiva> <Pine.LNX.4.33.0109270746150.1679-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0109270746150.1679-100000@localhost.localdomain>
User-Agent: Mutt/1.3.22i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 27, 2001  08:38 +0200, Ingo Molnar wrote:
> the patch also includes Andrew Morton's suggestion to add the
> HAVE_POLL_CONTROLLER define for easier network-driver integration. The
> eepro100.c changes now use this define.
> 
> the new utilities-tarball is at:
> 
> http://redhat.com/~mingo/netconsole-patches/netconsole-client-20010927.tar.gz

A few minor changes to the code, after testing it a bit locally (note that I
am using kernel patch C1):

First, a patch to change the MAC address kernel parameter to be in the
standard XX:XX:XX:XX:XX:XX form, instead of separate bytes.  It also
fixes the output of the IP addresses to be unsigned ints.  Isn't there
a function in the kernel to format IP addresses for output already?

Next, a patch to netconsole-server to use the target_mac parameter
instead of the target_eth_byteX parameters.  I thought about keeping
these around for compatibility, but since this is a relatively new
tool there is no point in keeping the extra baggage.

TODO: figure out what "offset" is really supposed to be useful for.  Maybe
      it should be aligned properly, and we add the message priority into
      one of the free bytes?

Finally, a patch to netconsole-client.c which does a few things:
- remove "offset" from output, it appears meaningless and screws formatting.
- allow the client to receive messages from multiple servers, unless a
  single server is specified.
- log to syslog (this is a bit complex because of the desire to write full
  lines into the syslog as opposed to chunks of the size sent by printk().
- (minor) change parameters to use "--" long option names in preparation
  for using getopt-long to do CLI parsing.
- (minor) don't require the --port option (use 6666 as default)
- (minor) don't require the --server option (accept all messages by default)

TODO: don't require the --client option (get ipaddress from interface and/or
      listen on all interfaces by default)
TODO: add getopt_long parsing of options to avoid ordered option requirement
TODO: make syslog and stdout logging optional (need one or the other obviously)
TODO: print server IP/hostname in syslog/stdout output in case we are getting
      messages from multiple servers
TODO: figure out why LOG_KERN does not show up in kernel log, while klogd does
TODO: add timeout for messages in syslog output buffer.
TODO: allow client/server to be specified by both hostname/IP
TODO: allow different client/server port numbers?  Do we care?

As an added bonus, a patch for 8139too.c which adds poll support (Jeff CC'd).

Cheers, Andreas
======================= netconsole-2.4.8-mac.diff =====================
--- linux/drivers/net/netconsole.c.orig	Thu Sep 27 10:11:27 2001
+++ linux/drivers/net/netconsole.c	Thu Sep 27 17:13:24 2001
@@ -219,20 +219,10 @@
 }
 
 static char *dev;
-static int target_eth_byte0 = 255;
-static int target_eth_byte1 = 255;
-static int target_eth_byte2 = 255;
-static int target_eth_byte3 = 255;
-static int target_eth_byte4 = 255;
-static int target_eth_byte5 = 255;
+static char *target_mac;
 
 MODULE_PARM(target_ip, "i");
-MODULE_PARM(target_eth_byte0, "i");
-MODULE_PARM(target_eth_byte1, "i");
-MODULE_PARM(target_eth_byte2, "i");
-MODULE_PARM(target_eth_byte3, "i");
-MODULE_PARM(target_eth_byte4, "i");
-MODULE_PARM(target_eth_byte5, "i");
+MODULE_PARM(target_mac, "s");
 MODULE_PARM(source_port, "h");
 MODULE_PARM(target_port, "h");
 MODULE_PARM(dev, "s");
@@ -267,8 +257,8 @@
 		printk(KERN_ERR "netconsole: network device %s has no local address, aborting.\n", dev);
 		return -1;
 	}
-#define IP(x) ((char *)&source_ip)[x]
-	printk(KERN_INFO "netconsole: using source IP %i.%i.%i.%i\n",
+#define IP(x) ((unsigned char *)&source_ip)[x]
+	printk(KERN_INFO "netconsole: using source IP %u.%u.%u.%u\n",
 		IP(3), IP(2), IP(1), IP(0));
 #undef IP
 	source_ip = htonl(source_ip);
@@ -276,8 +266,8 @@
 		printk(KERN_ERR "netconsole: target_ip parameter not specified, aborting.\n");
 		return -1;
 	}
-#define IP(x) ((char *)&target_ip)[x]
-	printk(KERN_INFO "netconsole: using target IP %i.%i.%i.%i\n",
+#define IP(x) ((unsigned char *)&target_ip)[x]
+	printk(KERN_INFO "netconsole: using target IP %u.%u.%u.%u\n",
 		IP(3), IP(2), IP(1), IP(0));
 #undef IP
 	target_ip = htonl(target_ip);
@@ -294,18 +284,26 @@
 	printk(KERN_INFO "netconsole: using target UDP port: %i\n", target_port);
 	target_port = htons(target_port);
 
-	daddr[0] = target_eth_byte0;
-	daddr[1] = target_eth_byte1;
-	daddr[2] = target_eth_byte2;
-	daddr[3] = target_eth_byte3;
-	daddr[4] = target_eth_byte4;
-	daddr[5] = target_eth_byte5;
-
-	if ((daddr[0] & daddr[1] & daddr[2] & daddr[3] & daddr[4] & daddr[5]) == 255)
-		printk(KERN_INFO "netconsole: using broadcast ethernet frames to send packets.\n");
-	else
-		printk(KERN_INFO "netconsole: using target ethernet address %02x:%02x:%02x:%02x:%02x:%02x.\n", daddr[0], daddr[1], daddr[2], daddr[3], daddr[4], daddr[5]);
-		
+	if (target_mac) {
+		char *ptr = target_mac;
+		int i;
+
+		printk(KERN_INFO "netconsole: using target ethernet MAC: %s\n",
+		       target_mac);
+		for (i = 0; i < 6 && ptr; i++) {
+			int val;
+			char *sep;
+			val = simple_strtoul(ptr, &sep, 16);
+			if (sep != ptr) {
+				daddr[i] = val;
+				ptr = *sep ? sep + 1 : NULL;
+			}
+		}
+	} else
+		printk(KERN_INFO "netconsole: using broadcast ethernet MAC.\n");
+
 	netconsole_dev = ndev;
 #define STARTUP_MSG "[...network console startup...]\n"
 	write_netconsole_msg(NULL, STARTUP_MSG, strlen(STARTUP_MSG));
===================== netconsole-server.diff =============================
--- netconsole-client/netconsole-server.orig	Thu Sep 27 00:32:50 2001
+++ netconsole-client/netconsole-server	Thu Sep 27 17:22:55 2001
@@ -30,9 +30,11 @@
 
 while [ $# -ge 1 ]; do case $1 in
 	-b) NOMAC=1 ;;
-	-d) DEV=$2; shift ;;
-	-m) MAC=$2; shift ;;
-	-p) PORT=$2; shift ;;
+	-d|--device) DEV=$2; shift ;;
+	-m|--mac) MAC=$2; shift ;;
+	-p|--port) PORT=$2; shift ;;
+	--client) TGT=`echo $2| sed "s/:.*//"`;
+		TPORT=`echo $2 | sed "s/.*://"`; shift ;;
 	*:*) TGT=`echo $1 | sed "s/:.*//"`; TPORT=`echo $1 | sed "s/.*://"` ;;
 	*) TGT=$1 ;;
 	esac
@@ -65,16 +67,9 @@
 		echo "$prog: $DEV must be an ethernet interface" 1>&2 && usage
 		
 	IPHEX=`dquad_to_hex $IPADDR`
-	echo $MAC | sed "s/:/ /g" | { read M0 M1 M2 M3 M4 M5;
-		if [ -z "$NOMAC" ]; then
-			TGTMAC="target_eth_byte0=0x$M0 target_eth_byte1=0x$M1 \
-				target_eth_byte2=0x$M2 target_eth_byte3=0x$M3 \
-				target_eth_byte4=0x$M4 target_eth_byte5=0x$M5"
-		fi
-		echo dev=$DEV target_ip=$IPHEX \
-			source_port=$PORT target_port=$TPORT $TGTMAC
-		/sbin/insmod netconsole dev=$DEV target_ip=$IPHEX \
-			source_port=$PORT target_port=$TPORT $TGTMAC
-	}
+	[ -z "$NOMAC" ] && TGTMAC="target_mac=$MAC"
+	echo dev=$DEV target_ip=$IPHEX \
+		source_port=$PORT target_port=$TPORT $TGTMAC
+	insmod netconsole dev=$DEV target_ip=$IPHEX \
+		source_port=$PORT target_port=$TPORT $TGTMAC
 }
-
===================== netconsole-client.diff =============================
--- netconsole-client/netconsole-client.c.orig	Thu Sep 27 08:32:31 2001
+++ netconsole-client/netconsole-client.c	Thu Sep 27 16:07:39 2001
@@ -17,47 +17,59 @@
 #include <sys/socket.h>
 #include <netinet/in.h>
 #include <arpa/inet.h>
+#include <syslog.h>
 
 #define NETCONSOLE_VERSION 0x01
 
 #define BUFLEN 10000
 
+#ifndef min
+#define min(a,b) ((a) < (b) ? (a) : (b))
+#endif
+
 int main (int argc, char **argv)
 {
 	struct sockaddr_in saddr, caddr;
 	int udp_socket;
-	unsigned char buf[BUFLEN];
-	int len, port;
+	unsigned char buf[BUFLEN], sysbuf[BUFLEN];
+	unsigned int sysoff = 0;
+	int len, port = 6666;
 	struct sockaddr_in addr;
 	int addr_len = sizeof(addr);
+	int noserver = 1;
 
 	memset(&addr, 0, addr_len);
 	memset(&saddr, 0, addr_len);
 	memset(&caddr, 0, addr_len);
 
-	if (argc != 7) {
-		fprintf(stderr, "usage: netconsole-client -server <IP> -client <IP> -port <port>\n");
+	if (argc != 3 && argc != 5 && argc != 7) {
+		fprintf(stderr, "usage: netconsole-client --client <IP> [--port <port> [--server <IP>]]\n");
 		exit(-1);
 	}
-	port = atol(argv[6]);
-	printf("displaying netconsole output from server %s, client %s, UDP port %d.\n", argv[2], argv[4], port);
+	if (argc > 4)
+		port = atol(argv[4]);
+	printf("listening on interface %s:%d for server %s:%d.\n", argv[2], port, argc > 6 ? argv[6] : "ANY", port);
 
 
 	udp_socket = socket(PF_INET, SOCK_DGRAM, 0);
 
-	saddr.sin_family = AF_INET;
-	saddr.sin_port = htons(port);
-	saddr.sin_addr.s_addr = inet_addr(argv[2]);
-
 	caddr.sin_family = AF_INET;
 	caddr.sin_port = htons(port);
-	caddr.sin_addr.s_addr = inet_addr(argv[4]);
+	caddr.sin_addr.s_addr = inet_addr(argv[2]);
+
+	if (argc > 5) {
+		saddr.sin_family = AF_INET;
+		saddr.sin_port = htons(port);
+		saddr.sin_addr.s_addr = inet_addr(argv[6]);
+		noserver = 0;
+	}
 
 	if (bind(udp_socket, (struct sockaddr *)&caddr, sizeof(caddr))) {
 		perror("could not bind UDP socket!\n");
 		exit(-1);
 	}
 
+	openlog("netconsole", 0, LOG_KERN);
 	while (1) {
 		len = recvfrom(udp_socket, buf, BUFLEN, 0, (struct sockaddr *)&addr, &addr_len);
 		if (len <= 0) {
@@ -65,10 +77,15 @@
 			exit(-1);
 		}
 		buf[len] = 0;
-		if (!memcmp(&addr, &saddr, addr_len)) {
-			unsigned int offset;
+		if (noserver || !memcmp(&addr, &saddr, addr_len)) {
+			unsigned int offset, skip;
+			unsigned int priority = LOG_WARNING, new_priority;
+			unsigned char *nl;
+
 			if (buf[0] != NETCONSOLE_VERSION) {
-				printf("[netconsole server has version %d, client supports only version %d! exiting.]\n", buf[0], NETCONSOLE_VERSION);
+				printf("[netconsole server has version %d, "
+				       "client supports only version %d! "
+				       "exiting.]\n", *buf, NETCONSOLE_VERSION);
 				exit(-1);
 			}
 
@@ -76,10 +93,42 @@
 			offset = (offset << 8) | buf[2];
 			offset = (offset << 8) | buf[3];
 			offset = (offset << 8) | buf[4];
+			skip = 5;
 
-			printf("(%d): %s", offset, buf+5);
+			printf("%s", buf + skip);
 			fflush(stdout);
+			if (sysoff == 0 &&
+			    sscanf(buf + skip, "<%d>", &new_priority) == 1) {
+				if (new_priority <= LOG_DEBUG) {
+					priority = new_priority;
+					skip += 3;
+				}
+			}
+			while ((nl = strchr(buf + skip, '\n'))) {
+				int used, left;
+
+				used = (nl - (buf + skip)) + 1;
+				left = sizeof(sysbuf) - sysoff - 1;
+
+				strncat(sysbuf + sysoff, buf + skip,
+					min(used, left));
+				/* FIXME: need to print source hostname/IP */
+				syslog(priority, "%s", sysbuf);
+				sysbuf[(sysoff = 0)] = '\0';
+				skip += min(used, left);
+			}
+			if (buf[skip]) {
+				strncat(sysbuf + sysoff, buf + skip,
+					 sizeof(sysbuf) - sysoff - 1);
+				sysoff += strlen(buf + skip);
+				if (sysoff >= sizeof(sysbuf)) {
+					syslog(priority, "%s", sysbuf);
+					sysbuf[(sysoff = 0)] = '\0';
+				}
+			}
+
 		}
 	}
+	closelog();
 	return 0;
 }
========================= 8139too-poll.diff ==============================
--- linux/drivers/net/8139too.c.orig	Tue Jul 31 15:15:28 2001
+++ linux/drivers/net/8139too.c	Thu Sep 27 10:15:59 2001
@@ -619,6 +619,9 @@
 static void rtl8139_init_ring (struct net_device *dev);
 static int rtl8139_start_xmit (struct sk_buff *skb,
 			       struct net_device *dev);
+#ifdef HAVE_POLL_CONTROLLER
+static void rtl8139_poll (struct net_device *dev);
+#endif
 static void rtl8139_interrupt (int irq, void *dev_instance,
 			       struct pt_regs *regs);
 static int rtl8139_close (struct net_device *dev);
@@ -965,6 +968,9 @@
 	dev->get_stats = rtl8139_get_stats;
 	dev->set_multicast_list = rtl8139_set_rx_mode;
 	dev->do_ioctl = netdev_ioctl;
+#ifdef HAVE_POLL_CONTROLLER
+	dev->poll_controller = rtl8139_poll;
+#endif
 	dev->tx_timeout = rtl8139_tx_timeout;
 	dev->watchdog_timeo = TX_TIMEOUT;
 
@@ -2201,6 +2207,20 @@
 	return 0;
 }
 
+
+#ifdef HAVE_POLL_CONTROLLER
+/*
+ * Polling 'interrupt' - used by things like netconsole to send skbs
+ * without having to re-enable interrupts. It's not called while
+ * the interrupt routine is executing.
+ */
+static void rtl8139_poll(struct net_device *dev)
+{
+	disable_irq(dev->irq);
+	rtl8139_interrupt(dev->irq, dev, NULL);
+	enable_irq(dev->irq);
+}
+#endif
 
 static int netdev_ethtool_ioctl (struct net_device *dev, void *useraddr)
 {
--
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert

