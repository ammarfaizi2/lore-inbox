Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265068AbTFCPoi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 11:44:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265069AbTFCPoh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 11:44:37 -0400
Received: from [212.202.223.62] ([212.202.223.62]:33157 "EHLO gw.localnet")
	by vger.kernel.org with ESMTP id S265068AbTFCPoH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 11:44:07 -0400
Message-ID: <3EDCC4AC.2030103@trash.net>
Date: Tue, 03 Jun 2003 17:54:20 +0200
From: Patrick McHardy <kaber@trash.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030527 Debian/1.3.1-2
X-Accept-Language: en
MIME-Version: 1.0
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] updated isdn ppp filters
Content-Type: multipart/mixed;
 boundary="------------020506020202000402030909"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020506020202000402030909
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi Kai,
since 2.4.21 is coming soon i'm sending you an updated isdn ppp
filter patch. The only change since the last version fixes a memory
leak in an ioctl error path. I've also updated the ipppd man page
(cut-n-paste from pppd).

To build ipppd run autoconf in ipppd subdir after patching and
add "--enable-ippp-filter" to the configure options.

Please submit to Marcello if you are comfortable with it.

Best regards,
Patrick

--------------020506020202000402030909
Content-Type: text/plain;
 name="linux-2.4.20_ippp-filter.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="linux-2.4.20_ippp-filter.diff"

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1192  -> 1.1193 
#	include/linux/isdn_ppp.h	1.5     -> 1.6    
#	drivers/isdn/isdn_ppp.h	1.3     -> 1.4    
#	drivers/isdn/Config.in	1.20    -> 1.21   
#	drivers/isdn/isdn_ppp.c	1.21    -> 1.22   
#	Documentation/Configure.help	1.182   -> 1.183  
#	drivers/isdn/isdn_net.c	1.16    -> 1.17   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/06/03	kaber@trash.net	1.1193
# [ISDN] isdn ppp filter
# --------------------------------------------
#
diff -Nru a/Documentation/Configure.help b/Documentation/Configure.help
--- a/Documentation/Configure.help	Tue Jun  3 07:03:12 2003
+++ b/Documentation/Configure.help	Tue Jun  3 07:03:12 2003
@@ -20673,6 +20673,17 @@
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
diff -Nru a/drivers/isdn/Config.in b/drivers/isdn/Config.in
--- a/drivers/isdn/Config.in	Tue Jun  3 07:03:12 2003
+++ b/drivers/isdn/Config.in	Tue Jun  3 07:03:12 2003
@@ -8,6 +8,7 @@
 if [ "$CONFIG_INET" != "n" ]; then
    bool '  Support synchronous PPP' CONFIG_ISDN_PPP
    if [ "$CONFIG_ISDN_PPP" != "n" ]; then
+      bool         '    PPP filtering for ISDN' CONFIG_IPPP_FILTER $CONFIG_FILTER
       bool         '    Use VJ-compression with synchronous PPP' CONFIG_ISDN_PPP_VJ
       bool         '    Support generic MP (RFC 1717)' CONFIG_ISDN_MPP
       dep_tristate '    Support BSD compression' CONFIG_ISDN_PPP_BSDCOMP $CONFIG_ISDN
diff -Nru a/drivers/isdn/isdn_net.c b/drivers/isdn/isdn_net.c
--- a/drivers/isdn/isdn_net.c	Tue Jun  3 07:03:12 2003
+++ b/drivers/isdn/isdn_net.c	Tue Jun  3 07:03:12 2003
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
diff -Nru a/drivers/isdn/isdn_ppp.c b/drivers/isdn/isdn_ppp.c
--- a/drivers/isdn/isdn_ppp.c	Tue Jun  3 07:03:12 2003
+++ b/drivers/isdn/isdn_ppp.c	Tue Jun  3 07:03:12 2003
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
 
 /* TODO: if this was the previous master: link the stuff to the new master */
 	if(is->comp_stat)
@@ -588,6 +604,39 @@
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
+					if (copy_from_user(code, uprog.filter, len)) {
+						kfree(code);
+						return -EFAULT;
+					}
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
@@ -977,6 +1026,7 @@
 {
 	struct net_device *dev = &net_dev->dev;
  	struct ippp_struct *is, *mis;
+	isdn_net_local *mlp = NULL;
 	int slot;
 
 	slot = lp->ppp_slot;
@@ -988,7 +1038,8 @@
 	is = ippp_table[slot];
  	
  	if (lp->master) { // FIXME?
- 		slot = ((isdn_net_local *) (lp->master->priv))->ppp_slot;
+		mlp = (isdn_net_local *) lp->master->priv;
+ 		slot = mlp->ppp_slot;
  		if (slot < 0 || slot > ISDN_MAX_CHANNELS) {
  			printk(KERN_ERR "isdn_ppp_push_higher: master->ppp_slot(%d)\n",
  				lp->ppp_slot);
@@ -1082,9 +1133,36 @@
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
@@ -1121,7 +1199,6 @@
 	return skb_push(skb,len);
 }
 
-
 /*
  * send ppp frame .. we expect a PIDCOMPressable proto --
  *  (here: currently always PPP_IP,PPP_VJC_COMP,PPP_VJC_UNCOMP)
@@ -1188,7 +1265,6 @@
 		goto unlock;
 	}
 	ipt = ippp_table[slot];
-	lp->huptimer = 0;
 
 	/*
 	 * after this line .. requeueing in the device queue is no longer allowed!!!
@@ -1199,6 +1275,34 @@
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
@@ -1340,6 +1444,50 @@
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
diff -Nru a/drivers/isdn/isdn_ppp.h b/drivers/isdn/isdn_ppp.h
--- a/drivers/isdn/isdn_ppp.h	Tue Jun  3 07:03:12 2003
+++ b/drivers/isdn/isdn_ppp.h	Tue Jun  3 07:03:12 2003
@@ -19,6 +19,7 @@
 extern void isdn_ppp_cleanup(void);
 extern int isdn_ppp_free(isdn_net_local *);
 extern int isdn_ppp_bind(isdn_net_local *);
+extern int isdn_ppp_autodial_filter(struct sk_buff *, isdn_net_local *);
 extern int isdn_ppp_xmit(struct sk_buff *, struct net_device *);
 extern void isdn_ppp_receive(isdn_net_dev *, isdn_net_local *, struct sk_buff *);
 extern int isdn_ppp_dev_ioctl(struct net_device *, struct ifreq *, int);
diff -Nru a/include/linux/isdn_ppp.h b/include/linux/isdn_ppp.h
--- a/include/linux/isdn_ppp.h	Tue Jun  3 07:03:12 2003
+++ b/include/linux/isdn_ppp.h	Tue Jun  3 07:03:12 2003
@@ -65,6 +65,9 @@
 
 #include <linux/config.h>
 
+#ifdef CONFIG_IPPP_FILTER
+#include <linux/filter.h>
+#endif
 
 #define DECOMP_ERR_NOMEM	(-10)
 
@@ -222,6 +225,10 @@
 #ifdef CONFIG_ISDN_PPP_VJ
   unsigned char *cbuf;
   struct slcompress *slcomp;
+#endif
+#ifdef CONFIG_IPPP_FILTER
+  struct sock_fprog pass_filter;	/* filter for packets to pass */
+  struct sock_fprog active_filter;	/* filter for pkts to reset idle */
 #endif
   unsigned long debug;
   struct isdn_ppp_compressor *compressor,*decompressor;

--------------020506020202000402030909
Content-Type: text/plain;
 name="isdn4k-utils_ippp-filter.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="isdn4k-utils_ippp-filter.diff"

? ipppd/ippp-filter-compat.h
Index: ipppd/Makefile.in
===================================================================
RCS file: /i4ldev/isdn4k-utils/ipppd/Makefile.in,v
retrieving revision 1.16
diff -u -r1.16 Makefile.in
--- ipppd/Makefile.in	2002/07/19 19:03:53	1.16
+++ ipppd/Makefile.in	2003/06/03 04:40:39
@@ -7,6 +7,7 @@
 HAVE_LIBCRYPT := @HAVE_LIBCRYPT@
 HAVE_SHADOW_H := @HAVE_SHADOW_H@
 HAVE_LZSCOMP_H:= @HAVE_LZSCOMP_H@
+IPPP_FILTER   := @CONFIG_IPPP_FILTER@
 SBINDIR       := @CONFIG_SBINDIR@
 MANDIR        := @CONFIG_MANDIR@
 CC            := @CC@
@@ -77,6 +78,10 @@
 LIBS        = -lcrypt -lutil
 endif
 
+ifeq ($(IPPP_FILTER),1)
+CFLAGS     += -DIPPP_FILTER
+LIBS       += -lpcap
+endif
 
 SOURCE = RELNOTES configure *.in $(PPPDSRCS) $(HEADERS) $(MANPAGES)
 
Index: ipppd/configure.in
===================================================================
RCS file: /i4ldev/isdn4k-utils/ipppd/configure.in,v
retrieving revision 1.8
diff -u -r1.8 configure.in
--- ipppd/configure.in	2002/07/19 19:03:53	1.8
+++ ipppd/configure.in	2003/06/03 04:40:39
@@ -98,6 +98,12 @@
 	AC_DEFINE(CONFIG_IPPPD_DEBUGFLAGS,"-DDEBUGALL"),
 )
 
+AC_ARG_ENABLE(ippp-filter,
+	[  --enable-ippp-filter    Enable IPPP Filters (needs kernel supports) [no]],
+	CONFIG_IPPP_FILTER="1"
+	AC_DEFINE(CONFIG_IPPP_FILTER,"1"),
+)
+
 AC_SUBST(I4LVERSION)
 AC_SUBST(MANDATE)
 AC_SUBST(HAVE_LIBDES)
@@ -113,4 +119,5 @@
 AC_SUBST(RADIUS_CLIENT_CONFIG_FILE)
 AC_SUBST(CONFIG_RADIUS_WTMP_LOGGING)
 AC_SUBST(CONFIG_IPPPD_DEBUGFLAGS)
+AC_SUBST(CONFIG_IPPP_FILTER)
 AC_OUTPUT(Makefile ipppd.man pathnames.h)
Index: ipppd/ipppd.h
===================================================================
RCS file: /i4ldev/isdn4k-utils/ipppd/ipppd.h,v
retrieving revision 1.22
diff -u -r1.22 ipppd.h
--- ipppd/ipppd.h	2002/07/06 00:34:08	1.22
+++ ipppd/ipppd.h	2003/06/03 04:40:40
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
Index: ipppd/ipppd.man.in
===================================================================
RCS file: /i4ldev/isdn4k-utils/ipppd/ipppd.man.in,v
retrieving revision 1.10
diff -u -r1.10 ipppd.man.in
--- ipppd/ipppd.man.in	2000/07/25 20:23:51	1.10
+++ ipppd/ipppd.man.in	2003/06/03 04:40:41
@@ -88,6 +88,22 @@
 .B ipcp-accept-remote
 options are given, respectively.
 .TP
+.B active-filter \fIfilter-expression
+Specifies a packet filter to be applied to data packets to determine
+which packets are to be regarded as link activity, and therefore reset
+the idle timer, or cause the link to be brought up in demand-dialling
+mode.  This option is useful in conjunction with the
+\fBidle\fR option if there are packets being sent or received
+regularly over the link (for example, routing information packets)
+which would otherwise prevent the link from ever appearing to be idle.
+The \fIfilter-expression\fR syntax is as described for tcpdump(1),
+except that qualifiers which are inappropriate for a PPP link, such as
+\fBether\fR and \fBarp\fR, are not permitted.  Generally the filter
+expression should be enclosed in single-quotes to prevent whitespace
+in the expression from being interpreted by the shell. This option
+is currently only available if both the kernel and ipppd were compiled
+with IPPP_FILTER defined.
+.TP
 .B -ac
 Disable Address/Control compression negotiation (use default, i.e.
 address/control field compression disabled).
@@ -514,6 +530,23 @@
 .I ipppd
 will wait for the peer to authenticate itself with PAP to
 <n> seconds (0 means no limit).
+.TP
+.B pass-filter \fIfilter-expression
+Specifies a packet filter to applied to data packets being sent or
+received to determine which packets should be allowed to pass.
+Packets which are rejected by the filter are silently discarded.  This
+option can be used to prevent specific network daemons (such as
+routed) using up link bandwidth, or to provide a basic firewall
+capability.
+The \fIfilter-expression\fR syntax is as described for tcpdump(1),
+except that qualifiers which are inappropriate for a PPP link, such as
+\fBether\fR and \fBarp\fR, are not permitted.  Generally the filter
+expression should be enclosed in single-quotes to prevent whitespace
+in the expression from being interpreted by the shell.  Note that it
+is possible to apply different constraints to incoming and outgoing
+packets using the \fBinbound\fR and \fBoutbound\fR qualifiers. This
+option is currently only available if both the kernel and ipppd were
+compiled with IPPP_FILTER defined.
 .TP
 .B -pc
 Disable protocol field compression negotiation (use default, i.e.
Index: ipppd/main.c
===================================================================
RCS file: /i4ldev/isdn4k-utils/ipppd/main.c,v
retrieving revision 1.24
diff -u -r1.24 main.c
--- ipppd/main.c	2002/07/18 00:06:21	1.24
+++ ipppd/main.c	2003/06/03 04:40:42
@@ -564,6 +564,9 @@
 	lns[linkunit].upap_unit = lns[linkunit].chap_unit = lns[linkunit].lcp_unit;
 	upap[lns[linkunit].upap_unit].us_unit = chap[lns[linkunit].chap_unit].unit = linkunit;
 	lcp_lowerup(lns[linkunit].lcp_unit);
+#ifdef IPPP_FILTER
+	set_filters(linkunit, &pass_filter, &active_filter);
+#endif /* IPPP_FILTER */
 
 	return 0;
 }
Index: ipppd/options.c
===================================================================
RCS file: /i4ldev/isdn4k-utils/ipppd/options.c,v
retrieving revision 1.23
diff -u -r1.23 options.c
--- ipppd/options.c	2003/01/20 02:23:28	1.23
+++ ipppd/options.c	2003/06/03 04:40:44
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
 
@@ -2614,3 +2630,33 @@
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
Index: ipppd/sys-linux.c
===================================================================
RCS file: /i4ldev/isdn4k-utils/ipppd/sys-linux.c,v
retrieving revision 1.25
diff -u -r1.25 sys-linux.c
--- ipppd/sys-linux.c	2000/07/25 20:23:51	1.25
+++ ipppd/sys-linux.c	2003/06/03 04:40:46
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
@@ -514,6 +520,40 @@
 
 	return 1;
 }
+
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
 
 /*
  * sifup - Config the interface up and enable IP packets to pass.

--------------020506020202000402030909--

