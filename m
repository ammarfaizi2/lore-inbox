Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265513AbTBJWif>; Mon, 10 Feb 2003 17:38:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265570AbTBJWif>; Mon, 10 Feb 2003 17:38:35 -0500
Received: from port-212-202-184-53.reverse.qdsl-home.de ([212.202.184.53]:6345
	"EHLO el-zoido.localnet") by vger.kernel.org with ESMTP
	id <S265513AbTBJWiR>; Mon, 10 Feb 2003 17:38:17 -0500
Message-ID: <3E482CD7.7070800@trash.net>
Date: Mon, 10 Feb 2003 23:51:03 +0100
From: Patrick McHardy <kaber@trash.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021226 Debian/1.2.1-9
X-Accept-Language: en
MIME-Version: 1.0
To: kkeil@suse.de
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [RFC]: CONFIG_IPPP_FILTER
Content-Type: multipart/mixed;
 boundary="------------030802020108080208050806"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030802020108080208050806
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi,
this patch adds ippp filters to isdn similar to ppp filters. Also 
included is the required patch for
ipppd. To compile ipppd add -DIPPP_FILTER to CFLAGS and -lpcap to LIBS.
Comments and suggestions are welcome.

Regards,
Patrick


--------------030802020108080208050806
Content-Type: text/plain;
 name="linux-2.4.20_ippp-filter.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="linux-2.4.20_ippp-filter.diff"

diff -urN linux-2.4.20-clean/Documentation/Configure.help linux-2.4.20_ippp-filter/Documentation/Configure.help
--- linux-2.4.20-clean/Documentation/Configure.help	2002-11-29 00:53:08.000000000 +0100
+++ linux-2.4.20_ippp-filter/Documentation/Configure.help	2003-02-10 23:27:05.000000000 +0100
@@ -20432,6 +20432,17 @@
   feature. See <file:Documentation/isdn/README.syncppp> and
   <file:Documentation/isdn/syncPPP.FAQ> for more information.
 
+PPP filtering for ISDN
+CONFIG_IPPP_FILTER
+  Say Y here if you want to be able to filter the packets passing over
+  IPPP interfaces.  This allows you to control which packets count as
+  activity (i.e. which packets will reset the idle timer or bring up
+  a demand-dialled link) and which packets are to be dropped entirely.
+  You need to say Y here if you wish to use the pass-filter and
+  active-filter options to ipppd.
+
+  If unsure, say N.
+
 Support generic MP (RFC 1717)
 CONFIG_ISDN_MPP
   With synchronous PPP enabled, it is possible to increase throughput
diff -urN linux-2.4.20-clean/drivers/isdn/Config.in linux-2.4.20_ippp-filter/drivers/isdn/Config.in
--- linux-2.4.20-clean/drivers/isdn/Config.in	2002-11-29 00:53:13.000000000 +0100
+++ linux-2.4.20_ippp-filter/drivers/isdn/Config.in	2003-02-10 23:27:05.000000000 +0100
@@ -8,6 +8,7 @@
 if [ "$CONFIG_INET" != "n" ]; then
    bool '  Support synchronous PPP' CONFIG_ISDN_PPP
    if [ "$CONFIG_ISDN_PPP" != "n" ]; then
+      bool         '    PPP filtering for ISDN' CONFIG_IPPP_FILTER $CONFIG_FILTER
       bool         '    Use VJ-compression with synchronous PPP' CONFIG_ISDN_PPP_VJ
       bool         '    Support generic MP (RFC 1717)' CONFIG_ISDN_MPP
       dep_tristate '    Support BSD compression' CONFIG_ISDN_PPP_BSDCOMP $CONFIG_ISDN
diff -urN linux-2.4.20-clean/drivers/isdn/isdn_net.c linux-2.4.20_ippp-filter/drivers/isdn/isdn_net.c
--- linux-2.4.20-clean/drivers/isdn/isdn_net.c	2002-11-29 00:53:13.000000000 +0100
+++ linux-2.4.20_ippp-filter/drivers/isdn/isdn_net.c	2003-02-10 23:27:05.000000000 +0100
@@ -1296,6 +1296,16 @@
 						restore_flags(flags);
 						return 0;	/* STN (skb to nirvana) ;) */
 					}
+#ifdef CONFIG_IPPP_FILTER
+					if (isdn_ppp_autodial_filter(skb, lp)) {
+						isdn_ppp_free(lp);
+						isdn_net_unbind_channel(lp);
+						restore_flags(flags);
+						isdn_net_unreachable(ndev, skb, "dial rejected: packet filtered");
+						dev_kfree_skb(skb);
+						return 0;
+					}
+#endif
 					restore_flags(flags);
 					isdn_net_dial();	/* Initiate dialing */
 					netif_stop_queue(ndev);
@@ -1793,9 +1803,6 @@
 {
 	isdn_net_local *lp = (isdn_net_local *) ndev->priv;
 	isdn_net_local *olp = lp;	/* original 'lp' */
-#ifdef CONFIG_ISDN_PPP
-	int proto = PPP_PROTOCOL(skb->data);
-#endif
 #ifdef CONFIG_ISDN_X25
 	struct concap_proto *cprot = lp -> netdev -> cprot;
 #endif
@@ -1855,14 +1862,7 @@
 			break;
 #ifdef CONFIG_ISDN_PPP
 		case ISDN_NET_ENCAP_SYNCPPP:
-			/*
-			 * If encapsulation is syncppp, don't reset
-			 * huptimer on LCP packets.
-			 */
-			if (proto != PPP_LCP) {
-				olp->huptimer = 0;
-				lp->huptimer = 0;
-			}
+			/* huptimer is done in isdn_ppp_push_higher */
 			isdn_ppp_receive(lp->netdev, olp, skb);
 			return;
 #endif
diff -urN linux-2.4.20-clean/drivers/isdn/isdn_ppp.c linux-2.4.20_ippp-filter/drivers/isdn/isdn_ppp.c
--- linux-2.4.20-clean/drivers/isdn/isdn_ppp.c	2002-11-29 00:53:13.000000000 +0100
+++ linux-2.4.20_ippp-filter/drivers/isdn/isdn_ppp.c	2003-02-10 23:27:05.000000000 +0100
@@ -13,6 +13,9 @@
 #include <linux/isdn.h>
 #include <linux/poll.h>
 #include <linux/ppp-comp.h>
+#ifdef CONFIG_IPPP_FILTER
+#include <linux/filter.h>
+#endif
 
 #include "isdn_common.h"
 #include "isdn_ppp.h"
@@ -324,7 +327,10 @@
 	 */
 	is->slcomp = slhc_init(16, 16);	/* not necessary for 2. link in bundle */
 #endif
-
+#ifdef CONFIG_IPPP_FILTER
+	is->pass_filter.filter = NULL;
+	is->active_filter.filter = NULL;
+#endif
 	is->state = IPPP_OPEN;
 
 	return 0;
@@ -379,6 +385,16 @@
 	slhc_free(is->slcomp);
 	is->slcomp = NULL;
 #endif
+#ifdef CONFIG_IPPP_FILTER
+	if (is->pass_filter.filter) {
+		kfree(is->pass_filter.filter);
+		is->pass_filter.filter = NULL;
+	}
+	if (is->active_filter.filter) {
+		kfree(is->active_filter.filter);
+		is->active_filter.filter = NULL;
+	}
+#endif
 
 /* TODO: if this was the previous master: link the the stuff to the new master */
 	if(is->comp_stat)
@@ -588,6 +604,37 @@
 				}
 				return set_arg((void *)arg,&pci,sizeof(struct pppcallinfo));
 			}
+#ifdef CONFIG_IPPP_FILTER
+		case PPPIOCSPASS:
+		case PPPIOCSACTIVE:
+			{
+				struct sock_fprog uprog, *filtp;
+				struct sock_filter *code = NULL;
+				int len, err;
+
+				if (copy_from_user(&uprog, (void *) arg, sizeof(uprog)))
+					return -EFAULT;
+				if (uprog.len > 0 && uprog.len < 65536) {
+					len = uprog.len * sizeof(struct sock_filter);
+					code = kmalloc(len, GFP_KERNEL);
+					if (code == NULL)
+						return -ENOMEM;
+					if (copy_from_user(code, uprog.filter, len))
+						return -EFAULT;
+					err = sk_chk_filter(code, uprog.len);
+					if (err) {
+						kfree(code);
+						return err;
+					}
+				}
+				filtp = (cmd == PPPIOCSPASS) ? &is->pass_filter : &is->active_filter;
+				if (filtp->filter)
+					kfree(filtp->filter);
+				filtp->filter = code;
+				filtp->len = uprog.len;
+				break;
+			}
+#endif /* CONFIG_IPPP_FILTER */
 		default:
 			break;
 	}
@@ -977,6 +1024,7 @@
 {
 	struct net_device *dev = &net_dev->dev;
  	struct ippp_struct *is, *mis;
+	isdn_net_local *mlp = NULL;
 	int slot;
 
 	slot = lp->ppp_slot;
@@ -988,7 +1036,8 @@
 	is = ippp_table[slot];
  	
  	if (lp->master) { // FIXME?
- 		slot = ((isdn_net_local *) (lp->master->priv))->ppp_slot;
+		mlp = (isdn_net_local *) lp->master->priv;
+ 		slot = mlp->ppp_slot;
  		if (slot < 0 || slot > ISDN_MAX_CHANNELS) {
  			printk(KERN_ERR "isdn_ppp_push_higher: master->ppp_slot(%d)\n",
  				lp->ppp_slot);
@@ -1082,9 +1131,36 @@
 			return;
 	}
 
- 	/* Reset hangup-timer */
- 	lp->huptimer = 0;
-
+#ifdef CONFIG_IPPP_FILTER
+	/* check if the packet passes the pass and active filters
+	 * the filter instructions are constructed assuming
+	 * a four-byte PPP header on each packet (which is still present) */
+	skb_push(skb, 4);
+	skb->data[0] = 0;	/* indicate inbound */
+
+	if (is->pass_filter.filter
+	    && sk_run_filter(skb, is->pass_filter.filter,
+	                    is->pass_filter.len) == 0) {
+		if (is->debug & 0x2)
+			printk(KERN_DEBUG "IPPP: inbound frame filtered.\n");
+		kfree_skb(skb);
+		return;
+	}
+	if (!(is->active_filter.filter
+	      && sk_run_filter(skb, is->active_filter.filter,
+	                       is->active_filter.len) == 0)) {
+		if (is->debug & 0x2)
+			printk(KERN_DEBUG "IPPP: link-active filter: reseting huptimer.\n");
+		lp->huptimer = 0;
+		if (mlp)
+			mlp->huptimer = 0;
+	}
+	skb_pull(skb, 4);
+#else /* CONFIG_IPPP_FILTER */
+	lp->huptimer = 0;
+	if (mlp)
+		mlp->huptimer = 0;
+#endif /* CONFIG_IPPP_FILTER */
 	skb->dev = dev;
 	skb->mac.raw = skb->data;
 	netif_rx(skb);
@@ -1188,7 +1264,6 @@
 		goto unlock;
 	}
 	ipt = ippp_table[slot];
-	lp->huptimer = 0;
 
 	/*
 	 * after this line .. requeueing in the device queue is no longer allowed!!!
@@ -1199,6 +1274,34 @@
 	 */
 	skb_pull(skb,IPPP_MAX_HEADER);
 
+#ifdef CONFIG_IPPP_FILTER
+	/* check if we should pass this packet
+	 * the filter instructions are constructed assuming
+	 * a four-byte PPP header on each packet */
+	skb_push(skb, 4);
+	skb->data[0] = 1;	/* indicate outbound */
+	*(u_int16_t *)(skb->data + 2) = htons(proto);
+
+	if (ipt->pass_filter.filter 
+	    && sk_run_filter(skb, ipt->pass_filter.filter,
+		             ipt->pass_filter.len) == 0) {
+		if (ipt->debug & 0x4)
+			printk(KERN_DEBUG "IPPP: outbound frame filtered.\n");
+		kfree_skb(skb);
+		goto unlock;
+	}
+	if (!(ipt->active_filter.filter
+	      && sk_run_filter(skb, ipt->active_filter.filter,
+		               ipt->active_filter.len) == 0)) {
+		if (ipt->debug & 0x4)
+			printk(KERN_DEBUG "IPPP: link-active filter: reseting huptimer.\n");
+		lp->huptimer = 0;
+	}
+	skb_pull(skb, 4);
+#else /* CONFIG_IPPP_FILTER */
+	lp->huptimer = 0;
+#endif /* CONFIG_IPPP_FILTER */
+
 	if (ipt->debug & 0x4)
 		printk(KERN_DEBUG "xmit skb, len %d\n", (int) skb->len);
         if (ipts->debug & 0x40)
@@ -1340,6 +1443,50 @@
 	return retval;
 }
 
+#ifdef CONFIG_IPPP_FILTER
+/*
+ * check if this packet may trigger auto-dial.
+ */
+
+int isdn_ppp_autodial_filter(struct sk_buff *skb, isdn_net_local *lp)
+{
+	struct ippp_struct *is = ippp_table[lp->ppp_slot];
+	u_int16_t proto;
+	int drop = 0;
+
+	switch (ntohs(skb->protocol)) {
+	case ETH_P_IP:
+		proto = PPP_IP;
+		break;
+	case ETH_P_IPX:
+		proto = PPP_IPX;
+		break;
+	default:
+		printk(KERN_ERR "isdn_ppp_autodial_filter: unsupported protocol 0x%x.\n",
+		       skb->protocol);
+		return 1;
+	}
+
+	/* the filter instructions are constructed assuming
+	 * a four-byte PPP header on each packet. we have to
+	 * temporarily remove part of the fake header stuck on
+	 * earlier.
+	 */
+	skb_pull(skb, IPPP_MAX_HEADER - 4);
+	skb->data[0] = 1;	/* indicate outbound */
+	*(u_int16_t *)(skb->data + 2) = htons(proto);
+	
+	drop |= is->pass_filter.filter
+	        && sk_run_filter(skb, is->pass_filter.filter,
+	                         is->pass_filter.len) == 0;
+	drop |= is->active_filter.filter
+	        && sk_run_filter(skb, is->active_filter.filter,
+	                         is->active_filter.len) == 0;
+	
+	skb_push(skb, IPPP_MAX_HEADER - 4);
+	return drop;
+}
+#endif
 #ifdef CONFIG_ISDN_MPP
 
 /* this is _not_ rfc1990 header, but something we convert both short and long
diff -urN linux-2.4.20-clean/drivers/isdn/isdn_ppp.h linux-2.4.20_ippp-filter/drivers/isdn/isdn_ppp.h
--- linux-2.4.20-clean/drivers/isdn/isdn_ppp.h	2001-12-21 18:41:54.000000000 +0100
+++ linux-2.4.20_ippp-filter/drivers/isdn/isdn_ppp.h	2003-02-10 23:27:05.000000000 +0100
@@ -19,6 +19,7 @@
 extern void isdn_ppp_cleanup(void);
 extern int isdn_ppp_free(isdn_net_local *);
 extern int isdn_ppp_bind(isdn_net_local *);
+extern int isdn_ppp_autodial_filter(struct sk_buff *, isdn_net_local *);
 extern int isdn_ppp_xmit(struct sk_buff *, struct net_device *);
 extern void isdn_ppp_receive(isdn_net_dev *, isdn_net_local *, struct sk_buff *);
 extern int isdn_ppp_dev_ioctl(struct net_device *, struct ifreq *, int);
diff -urN linux-2.4.20-clean/include/linux/isdn_ppp.h linux-2.4.20_ippp-filter/include/linux/isdn_ppp.h
--- linux-2.4.20-clean/include/linux/isdn_ppp.h	2001-09-30 21:26:42.000000000 +0200
+++ linux-2.4.20_ippp-filter/include/linux/isdn_ppp.h	2003-02-10 23:27:05.000000000 +0100
@@ -65,6 +65,9 @@
 
 #include <linux/config.h>
 
+#ifdef CONFIG_IPPP_FILTER
+#include <linux/filter.h>
+#endif
 
 #define DECOMP_ERR_NOMEM	(-10)
 
@@ -223,6 +226,10 @@
   unsigned char *cbuf;
   struct slcompress *slcomp;
 #endif
+#ifdef CONFIG_IPPP_FILTER
+  struct sock_fprog pass_filter;	/* filter for packets to pass */
+  struct sock_fprog active_filter;	/* filter for pkts to reset idle */
+#endif
   unsigned long debug;
   struct isdn_ppp_compressor *compressor,*decompressor;
   struct isdn_ppp_compressor *link_compressor,*link_decompressor;

--------------030802020108080208050806
Content-Type: text/plain;
 name="isdn4k-utils_ippp-filter.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="isdn4k-utils_ippp-filter.diff"

diff -urN isdn4k-utils-clean/ipppd/ipppd.h isdn4k-utils_ippp-filter/ipppd/ipppd.h
--- isdn4k-utils-clean/ipppd/ipppd.h	2002-07-06 02:34:08.000000000 +0200
+++ isdn4k-utils_ippp-filter/ipppd/ipppd.h	2003-01-27 12:56:54.000000000 +0100
@@ -215,6 +215,11 @@
 #ifdef __linux__
 extern int      hostroute;      /* Add a route to the host at the other end? */
 #endif
+#ifdef IPPP_FILTER
+#include <net/bpf.h>
+extern struct   bpf_program pass_filter;   /* Filter for pkts to pass */
+extern struct   bpf_program active_filter; /* Filter for link-active pkts */
+#endif /* IPPP_FILTER */
 
 /*
  * Values for phase.
@@ -288,6 +293,9 @@
 void link_terminated(int);
 void link_down(int);
 void link_established(int unit);
+#ifdef IPPP_FILTER
+int set_filters(int, struct bpf_program *, struct bpf_program *);
+#endif /* IPPP_FILTER */
 int device_script(char *program,int in,int out);
 void check_auth_options(void);
 void setipdefault(void);
diff -urN isdn4k-utils-clean/ipppd/ippp-filter-compat.h isdn4k-utils_ippp-filter/ipppd/ippp-filter-compat.h
--- isdn4k-utils-clean/ipppd/ippp-filter-compat.h	1970-01-01 01:00:00.000000000 +0100
+++ isdn4k-utils_ippp-filter/ipppd/ippp-filter-compat.h	2003-02-10 06:00:05.000000000 +0100
@@ -0,0 +1,11 @@
+#ifndef _IPPP_FILTER_COMPAT_H
+#define _IPPP_FILTER_COMPAT_T
+
+#ifndef PPPIOCSPASS
+#define PPPIOCSPASS	_IOW('t', 71, struct sock_fprog) /* set pass filter */
+#endif
+#ifndef PPPIOCSACTIVE
+#define PPPIOCSACTIVE	_IOW('t', 70, struct sock_fprog) /* set active filter */
+#endif
+                                                                                
+#endif /* _IPPP_FILTER_COMPAT_T */
diff -urN isdn4k-utils-clean/ipppd/main.c isdn4k-utils_ippp-filter/ipppd/main.c
--- isdn4k-utils-clean/ipppd/main.c	2002-07-18 02:06:21.000000000 +0200
+++ isdn4k-utils_ippp-filter/ipppd/main.c	2003-01-27 12:56:54.000000000 +0100
@@ -564,6 +564,9 @@
 	lns[linkunit].upap_unit = lns[linkunit].chap_unit = lns[linkunit].lcp_unit;
 	upap[lns[linkunit].upap_unit].us_unit = chap[lns[linkunit].chap_unit].unit = linkunit;
 	lcp_lowerup(lns[linkunit].lcp_unit);
+#ifdef IPPP_FILTER
+	set_filters(linkunit, &pass_filter, &active_filter);
+#endif /* IPPP_FILTER */
 
 	return 0;
 }
diff -urN isdn4k-utils-clean/ipppd/options.c isdn4k-utils_ippp-filter/ipppd/options.c
--- isdn4k-utils-clean/ipppd/options.c	2002-07-06 02:34:08.000000000 +0200
+++ isdn4k-utils_ippp-filter/ipppd/options.c	2003-02-10 06:06:03.000000000 +0100
@@ -39,6 +39,10 @@
 #include <radiusclient.h>
 #endif
 
+#ifdef IPPP_FILTER
+#include <pcap.h>
+#endif /* IPPP_FILTER */
+
 #include "fsm.h"
 #include "ipppd.h"
 #include "pathnames.h"
@@ -140,6 +144,10 @@
 struct option_info auth_req_info;
 struct option_info devnam_info;
 
+#ifdef IPPP_FILTER
+struct  bpf_program pass_filter;/* Filter program for packets to pass */
+struct  bpf_program active_filter; /* Filter program for link-active pkts */
+#endif /* IPPP_FILTER */
 
 /*
  * Prototypes
@@ -292,6 +300,11 @@
 int __P (radius_init ( void ));
 #endif
 
+#ifdef IPPP_FILTER
+static int setpassfilter __P((int,char **));
+static int setactivefilter __P((int,char **));
+#endif /* IPPP_FILTER */
+
 /*
  * Valid arguments.
  */
@@ -470,7 +483,10 @@
     {"nohostroute", 0, setnohostroute}, /* Don't add host route */
 #endif
     {"+force-driver",0,setforcedriver},
-
+#ifdef IPPP_FILTER
+    { "pass-filter", 1, setpassfilter},		/* pass filter */
+    { "active-filter", 1, setactivefilter},	/* link-active filter */
+#endif /* IPPP_FILTER */
     {NULL, 0, NULL}
 };
 
@@ -2615,3 +2631,33 @@
     force_driver = 1;
     return 1;
 }
+
+#ifdef IPPP_FILTER
+/*
+ * setpassfilter - Set the pass filter for packets
+ */
+static int
+setpassfilter(argc, argv)
+    int argc;
+    char **argv;
+{
+    if (pcap_compile_nopcap(PPP_HDRLEN, DLT_PPP, &pass_filter, *argv, 1, netmask) == 0)
+        return 1;
+    option_error("error in pass-filter expression.\n");
+    return 0;
+}
+
+/*
+ * setactivefilter - Set the active filter for packets
+ */
+static int
+setactivefilter(argc, argv)
+    int argc;
+    char **argv;
+{
+    if (pcap_compile_nopcap(PPP_HDRLEN, DLT_PPP, &active_filter, *argv, 1, netmask) == 0)
+        return 1;
+    option_error("error in active-filter expression.\n");
+    return 0;
+}
+#endif /* IPPP_FILTER */
diff -urN isdn4k-utils-clean/ipppd/sys-linux.c isdn4k-utils_ippp-filter/ipppd/sys-linux.c
--- isdn4k-utils-clean/ipppd/sys-linux.c	2000-10-05 22:45:25.000000000 +0200
+++ isdn4k-utils_ippp-filter/ipppd/sys-linux.c	2003-02-10 06:00:35.000000000 +0100
@@ -57,6 +57,7 @@
 #if defined __GLIBC__ && __GLIBC__ >= 2
 # include </usr/include/net/ppp_defs.h>
 # include </usr/include/net/if_ppp.h>
+# include "ippp-filter-compat.h"
 # include </usr/include/net/ethernet.h>
 # include "route.h"
 #else
@@ -70,6 +71,11 @@
 # include <netipx/ipx.h>
 #endif
 
+#ifdef IPPP_FILTER
+#include <net/bpf.h>
+#include <linux/filter.h>
+#endif /* IPPP_FILTER */
+
 #include "fsm.h"
 #include "ipppd.h"
 #include "ipcp.h"
@@ -515,6 +521,40 @@
 	return 1;
 }
 
+#ifdef IPPP_FILTER
+/*
+ * set_filters - set the active and pass filters in the kernel driver.
+ */
+int set_filters(int u, struct bpf_program *pass, struct bpf_program *active)
+{       
+        struct sock_fprog fp;
+
+	/*
+	 *  unfortunately there is no way of checking for kernel support. the
+	 *  driver just returns 0 for unsupported ioctls, which means without
+	 *  kernel support we won't even notice the error.
+	 */
+
+	if (pass) {
+		fp.len = pass->bf_len;
+		fp.filter = (struct sock_filter *) pass->bf_insns;
+		if (ioctl(lns[u].fd, PPPIOCSPASS, &fp) < 0) {
+			syslog(LOG_ERR, "Couldn't set pass-filter in kernel.");
+			return 0;
+		}
+	}
+	if (active) {
+		fp.len = active->bf_len;
+		fp.filter = (struct sock_filter *) active->bf_insns;
+		if (ioctl(lns[u].fd, PPPIOCSACTIVE, &fp) < 0) {
+			syslog(LOG_ERR, "Couldn't set active-filter in kernel.");
+	        	return 0;
+		}
+	}
+	return 1;
+}
+#endif /* IPPP_FILTER */
+
 /*
  * sifup - Config the interface up and enable IP packets to pass.
  */

--------------030802020108080208050806--

