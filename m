Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317258AbSGCVm7>; Wed, 3 Jul 2002 17:42:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317260AbSGCVm6>; Wed, 3 Jul 2002 17:42:58 -0400
Received: from gans.physik3.uni-rostock.de ([139.30.44.2]:42246 "EHLO
	gans.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id <S317258AbSGCVms>; Wed, 3 Jul 2002 17:42:48 -0400
Date: Wed, 3 Jul 2002 23:45:19 +0200 (CEST)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: lkml <linux-kernel@vger.kernel.org>
Subject: [patch,rfc] make depencies on header files explicit
Message-ID: <Pine.LNX.4.33.0207032331010.31929-100000@gans.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It seems to be quite common to assume that sched.h and all the other 
headers it drags in are available without declaration anyways. Since
I aim at invalidating this assumption by removing all unneccessary 
includes, I have started to make dependencies on header files included
by sched.h explicit.
This is, again, just a small start, a patch covering the whole include/
subtree would be approximately 25 times as large. However, before I'll
dig into this further, I'd like to make sure I haven't missed some
implicit rules about which headers might be assumed available, or should
be included by the importing .c file, or something like that.
So any comments about this project are welcome.

Tim

P.S.: This was dont by extensive ctagging and grepping, followed by
inspection and change by hand.


--- linux-2.5.24/include/linux/pkt_cls.h	Fri Jun 21 00:53:43 2002
+++ linux-2.5.24-headfix/include/linux/pkt_cls.h	Wed Jul  3 22:46:08 2002
@@ -1,6 +1,8 @@
 #ifndef __LINUX_PKT_CLS_H
 #define __LINUX_PKT_CLS_H
 
+#include <asm/types.h>
+
 struct tc_police
 {
 	__u32			index;

--- linux-2.5.24/include/net/af_unix.h	Fri Jun 21 00:53:55 2002
+++ linux-2.5.24-headfix/include/net/af_unix.h	Wed Jul  3 22:47:53 2002
@@ -1,5 +1,11 @@
 #ifndef __LINUX_NET_AFUNIX_H
 #define __LINUX_NET_AFUNIX_H
+
+#include <linux/spinlock.h>
+#include <linux/wait.h>
+#include <asm/atomic.h>
+#include <asm/semaphore.h>
+
 extern void unix_proto_init(struct net_proto *pro);
 extern void unix_inflight(struct file *fp);
 extern void unix_notinflight(struct file *fp);

--- linux-2.5.24/include/net/bluetooth/hci.h	Fri Jun 21 00:53:50 2002
+++ linux-2.5.24-headfix/include/net/bluetooth/hci.h	Wed Jul  3 22:19:20 2002
@@ -29,6 +29,10 @@
 #ifndef __HCI_H
 #define __HCI_H
 
+#include <asm/bitops.h>
+#include <asm/param.h>
+#include <asm/types.h>
+
 #define HCI_MAX_ACL_SIZE	1024
 #define HCI_MAX_SCO_SIZE	255
 #define HCI_MAX_EVENT_SIZE	260

--- linux-2.5.24/include/net/bluetooth/hci_core.h	Fri Jun 21 00:53:53 2002
+++ linux-2.5.24-headfix/include/net/bluetooth/hci_core.h	Wed Jul  3 22:22:34 2002
@@ -29,6 +29,15 @@
 #ifndef __HCI_CORE_H
 #define __HCI_CORE_H
 
+#include <linux/jiffies.h>
+#include <linux/list.h>
+#include <linux/spinlock.h>
+#include <linux/stddef.h>
+#include <linux/timer.h>
+#include <linux/wait.h>
+#include <asm/atomic.h>
+#include <asm/semaphore.h>
+#include <asm/types.h>
 #include <net/bluetooth/hci.h>
 
 /* HCI upper protocols */

--- linux-2.5.24/include/net/bluetooth/l2cap.h	Fri Jun 21 00:53:46 2002
+++ linux-2.5.24-headfix/include/net/bluetooth/l2cap.h	Wed Jul  3 22:15:28 2002
@@ -29,6 +29,10 @@
 #ifndef __L2CAP_H
 #define __L2CAP_H
 
+#include <linux/spinlock.h>
+#include <asm/param.h>
+#include <asm/types.h>
+
 /* L2CAP defaults */
 #define L2CAP_DEFAULT_MTU 	672
 #define L2CAP_DEFAULT_FLUSH_TO	0xFFFF

--- linux-2.5.24/include/net/bluetooth/sco.h	Fri Jun 21 00:53:46 2002
+++ linux-2.5.24-headfix/include/net/bluetooth/sco.h	Wed Jul  3 22:18:08 2002
@@ -29,6 +29,11 @@
 #ifndef __SCO_H
 #define __SCO_H
 
+#include <linux/spinlock.h>
+#include <asm/param.h>
+#include <asm/types.h>
+
+
 /* SCO defaults */
 #define SCO_DEFAULT_MTU 	500
 #define SCO_DEFAULT_FLUSH_TO	0xFFFF

--- linux-2.5.24/include/net/dn.h	Wed Jul  3 22:06:42 2002
+++ linux-2.5.24-headfix/include/net/dn.h	Wed Jul  3 22:07:23 2002
@@ -2,6 +2,8 @@
 #define _NET_DN_H
 
 #include <linux/dn.h>
+#include <linux/jiffies.h>
+#include <linux/timer.h>
 #include <asm/byteorder.h>
 
 typedef unsigned short dn_address;
 

--- linux-2.5.24/include/net/dn_dev.h	Fri Jun 21 00:53:42 2002
+++ linux-2.5.24-headfix/include/net/dn_dev.h	Wed Jul  3 22:04:01 2002
@@ -1,6 +1,9 @@
 #ifndef _NET_DN_DEV_H
 #define _NET_DN_DEV_H
 
+#include <linux/kernel.h>
+#include <linux/stddef.h>
+#include <linux/timer.h>
 
 struct dn_dev;
 

--- linux-2.5.24/include/net/dn_fib.h	Wed Jul  3 22:40:08 2002
+++ linux-2.5.24-headfix/include/net/dn_fib.h	Wed Jul  3 22:40:23 2002
@@ -2,6 +2,8 @@
 #define _NET_DN_FIB_H
 
 #include <linux/config.h>
+#include <asm/atomic.h>
+#include <asm/types.h>
 
 #ifdef CONFIG_DECNET_ROUTER
 

--- linux-2.5.24/include/net/dn_nsp.h	Fri Jun 21 00:53:55 2002
+++ linux-2.5.24-headfix/include/net/dn_nsp.h	Wed Jul  3 22:49:18 2002
@@ -13,6 +13,9 @@
     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
     GNU General Public License for more details.
 *******************************************************************************/
+
+#include <asm/atomic.h>
+
 /* dn_nsp.c functions prototyping */
 
 extern void dn_nsp_send_data_ack(struct sock *sk);

--- linux-2.5.24/include/net/dn_route.h	Fri Jun 21 00:53:43 2002
+++ linux-2.5.24-headfix/include/net/dn_route.h	Wed Jul  3 22:04:27 2002
@@ -1,6 +1,8 @@
 #ifndef _NET_DN_ROUTE_H
 #define _NET_DN_ROUTE_H
 
+#include <linux/jiffies.h>
+
 /******************************************************************************
     (c) 1995-1998 E.M. Serrat		emserrat@geocities.com
     

--- linux-2.5.24/include/net/dst.h	Fri Jun 21 00:53:56 2002
+++ linux-2.5.24-headfix/include/net/dst.h	Wed Jul  3 22:53:15 2002
@@ -9,6 +9,7 @@
 #define _NET_DST_H
 
 #include <linux/config.h>
+#include <linux/jiffies.h>
 #include <net/neighbour.h>
 
 /*

--- linux-2.5.24/include/net/flow.h	Fri Jun 21 00:53:49 2002
+++ linux-2.5.24-headfix/include/net/flow.h	Wed Jul  3 22:28:12 2002
@@ -7,6 +7,9 @@
 #ifndef _NET_FLOW_H
 #define _NET_FLOW_H
 
+#include <asm/atomic.h>
+#include <asm/types.h>
+
 struct flowi {
 	int	proto;		/*	{TCP, UDP, ICMP}	*/
 

--- linux-2.5.24/include/net/if_inet6.h	Fri Jun 21 00:53:57 2002
+++ linux-2.5.24-headfix/include/net/if_inet6.h	Wed Jul  3 22:56:14 2002
@@ -15,6 +15,12 @@
 #ifndef _NET_IF_INET6_H
 #define _NET_IF_INET6_H
 
+#include <linux/spinlock.h>
+#include <linux/string.h>
+#include <linux/timer.h>
+#include <asm/atomic.h>
+#include <asm/types.h>
+
 #define IF_RA_RCVD	0x20
 #define IF_RS_SENT	0x10
 

--- linux-2.5.24/include/net/inet_common.h	Fri Jun 21 00:53:55 2002
+++ linux-2.5.24-headfix/include/net/inet_common.h	Wed Jul  3 22:48:38 2002
@@ -1,6 +1,8 @@
 #ifndef _INET_COMMON_H
 #define _INET_COMMON_H
 
+#include <asm/atomic.h>
+
 extern struct proto_ops		inet_stream_ops;
 extern struct proto_ops		inet_dgram_ops;
 

--- linux-2.5.24/include/net/inet_ecn.h	Fri Jun 21 00:53:56 2002
+++ linux-2.5.24-headfix/include/net/inet_ecn.h	Wed Jul  3 22:52:11 2002
@@ -1,6 +1,8 @@
 #ifndef _INET_ECN_H_
 #define _INET_ECN_H_
 
+#include <asm/types.h>
+
 static inline int INET_ECN_is_ce(__u8 dsfield)
 {
 	return (dsfield&3) == 3;

--- linux-2.5.24/include/net/ip6_fw.h	Fri Jun 21 00:53:50 2002
+++ linux-2.5.24-headfix/include/net/ip6_fw.h	Wed Jul  3 22:33:35 2002
@@ -1,6 +1,8 @@
 #ifndef __NET_IP6_FW_H
 #define __NET_IP6_FW_H
 
+#include <asm/types.h>
+
 #define IP6_FW_LISTHEAD		0x1000
 #define IP6_FW_ACCEPT		0x0001
 #define IP6_FW_REJECT		0x0002

--- linux-2.5.24/include/net/ip_fib.h	Fri Jun 21 00:53:50 2002
+++ linux-2.5.24-headfix/include/net/ip_fib.h	Wed Jul  3 22:28:47 2002
@@ -17,6 +17,8 @@
 #define _NET_IP_FIB_H
 
 #include <linux/config.h>
+#include <asm/atomic.h>
+#include <asm/types.h>
 
 struct kern_rta
 {

--- linux-2.5.24/include/net/ipconfig.h	Fri Jun 21 00:53:54 2002
+++ linux-2.5.24-headfix/include/net/ipconfig.h	Wed Jul  3 22:42:10 2002
@@ -6,6 +6,9 @@
  *  Automatic IP Layer Configuration
  */
 
+
+#include <asm/types.h>
+
 /* The following are initdata: */
 
 extern int ic_enable;		/* Enable or disable the whole shebang */

--- linux-2.5.24/include/net/ipip.h	Fri Jun 21 00:53:57 2002
+++ linux-2.5.24-headfix/include/net/ipip.h	Wed Jul  3 22:54:09 2002
@@ -2,6 +2,9 @@
 #define __NET_IPIP_H 1
 
 #include <linux/if_tunnel.h>
+#include <linux/stddef.h>
+#include <asm/param.h>
+#include <asm/types.h>
 
 /* Keep error state on tunnel for 30 sec */
 #define IPTUNNEL_ERR_TIMEO	(30*HZ)

--- linux-2.5.24/include/net/irda/ircomm_event.h	Fri Jun 21 00:53:52 2002
+++ linux-2.5.24-headfix/include/net/irda/ircomm_event.h	Wed Jul  3 21:54:28 2002
@@ -31,6 +31,7 @@
 #ifndef IRCOMM_EVENT_H
 #define IRCOMM_EVENT_H
 
+#include <asm/types.h>
 #include <net/irda/irmod.h>
 
 typedef enum {

--- linux-2.5.24/include/net/irda/ircomm_param.h	Fri Jun 21 00:53:57 2002
+++ linux-2.5.24-headfix/include/net/irda/ircomm_param.h	Wed Jul  3 21:57:29 2002
@@ -31,6 +31,7 @@
 #ifndef IRCOMM_PARAMS_H
 #define IRCOMM_PARAMS_H
 
+#include <asm/types.h>
 #include <net/irda/parameters.h>
 
 /* Parameters common to all service types */

--- linux-2.5.24/include/net/irda/irlmp_event.h	Fri Jun 21 00:53:53 2002
+++ linux-2.5.24-headfix/include/net/irda/irlmp_event.h	Wed Jul  3 21:55:12 2002
@@ -27,6 +27,8 @@
 #ifndef IRLMP_EVENT_H
 #define IRLMP_EVENT_H
 
+#include <asm/types.h>
+
 /* A few forward declarations (to make compiler happy) */
 struct irlmp_cb;
 struct lsap_cb;

--- linux-2.5.24/include/net/irda/irmod.h	Wed Jul  3 22:00:08 2002
+++ linux-2.5.24-headfix/include/net/irda/irmod.h	Wed Jul  3 21:59:36 2002
@@ -26,6 +26,8 @@
 #ifndef IRMOD_H
 #define IRMOD_H
 
+#include <asm/bitops.h>
+
 /* Misc status information */
 typedef enum {
 	STATUS_OK,

--- linux-2.5.24/include/net/irda/parameters.h	Fri Jun 21 00:53:43 2002
+++ linux-2.5.24-headfix/include/net/irda/parameters.h	Wed Jul  3 21:50:17 2002
@@ -34,6 +34,8 @@
 #ifndef IRDA_PARAMS_H
 #define IRDA_PARAMS_H
 
+#include <asm/types.h>
+
 /*
  *  The currently supported types. Beware not to change the sequence since
  *  it a good reason why the sized integers has a value equal to their size

--- linux-2.5.24/include/net/irda/toshoboe.h	Fri Jun 21 00:53:57 2002
+++ linux-2.5.24-headfix/include/net/irda/toshoboe.h	Wed Jul  3 21:58:02 2002
@@ -26,6 +26,8 @@
 #ifndef TOSHOBOE_H
 #define TOSHOBOE_H
 
+#include <asm/types.h>
+
 /* Registers */
 /*Receive and transmit task registers (read only) */
 #define OBOE_RCVT	(0x00+(self->base))

--- linux-2.5.24/include/net/irda/vlsi_ir.h	Fri Jun 21 00:53:43 2002
+++ linux-2.5.24-headfix/include/net/irda/vlsi_ir.h	Wed Jul  3 21:53:18 2002
@@ -27,6 +27,10 @@
 #ifndef IRDA_VLSI_FIR_H
 #define IRDA_VLSI_FIR_H
 
+#include <linux/spinlock.h>
+#include <linux/time.h>
+#include <asm/types.h>
+
 /* ================================================================ */
 
 /* non-standard PCI registers */

--- linux-2.5.24/include/net/irda/w83977af.h	Fri Jun 21 00:53:57 2002
+++ linux-2.5.24-headfix/include/net/irda/w83977af.h	Wed Jul  3 21:56:18 2002
@@ -5,6 +5,7 @@
 #define W977_EFIO2_BASE 0x3f0
 #define W977_DEVICE_IR 0x06
 
+#include <asm/types.h>
 
 /*
  * Enter extended function mode

--- linux-2.5.24/include/net/irda/w83977af_ir.h	Fri Jun 21 00:53:43 2002
+++ linux-2.5.24-headfix/include/net/irda/w83977af_ir.h	Wed Jul  3 21:51:03 2002
@@ -26,6 +26,7 @@
 #define W83977AF_IR_H
 
 #include <asm/io.h>
+#include <asm/types.h>
 
 /* Flags for configuration register CRF0 */
 #define ENBNKSEL	0x01

--- linux-2.5.24/include/net/iw_handler.h	Fri Jun 21 00:53:45 2002
+++ linux-2.5.24-headfix/include/net/iw_handler.h	Wed Jul  3 22:11:01 2002
@@ -10,6 +10,8 @@
 #ifndef _IW_HANDLER_H
 #define _IW_HANDLER_H
 
+#include <linux/string.h>
+
 /************************** DOCUMENTATION **************************/
 /*
  * Initial driver API (1996 -> onward) :

--- linux-2.5.24/include/net/lapb.h	Fri Jun 21 00:53:51 2002
+++ linux-2.5.24-headfix/include/net/lapb.h	Wed Jul  3 22:35:10 2002
@@ -1,6 +1,8 @@
 #ifndef _LAPB_H
 #define _LAPB_H 
 #include <linux/lapb.h>
+#include <linux/timer.h>
+#include <asm/param.h>
 
 #define	LAPB_HEADER_LEN	20		/* LAPB over Ethernet + a bit more */
 

--- linux-2.5.24/include/net/llc_c_ac.h	Fri Jun 21 00:53:57 2002
+++ linux-2.5.24-headfix/include/net/llc_c_ac.h	Wed Jul  3 22:56:51 2002
@@ -11,6 +11,9 @@
  *
  * See the GNU General Public License for more details.
  */
+
+#include <asm/types.h>
+
 /* Connection component state transition actions */
 /*
  * Connection state transition actions

--- linux-2.5.24/include/net/llc_c_ev.h	Fri Jun 21 00:53:45 2002
+++ linux-2.5.24-headfix/include/net/llc_c_ev.h	Wed Jul  3 22:08:31 2002
@@ -1,5 +1,8 @@
 #ifndef LLC_C_EV_H
 #define LLC_C_EV_H
+
+#include <asm/types.h>
+
 /*
  * Copyright (c) 1997 by Procom Technology,Inc.
  *		 2001 by Arnaldo Carvalho de Melo <acme@conectiva.com.br>

--- linux-2.5.24/include/net/llc_c_st.h	Fri Jun 21 00:53:55 2002
+++ linux-2.5.24-headfix/include/net/llc_c_st.h	Wed Jul  3 22:44:30 2002
@@ -11,6 +11,9 @@
  *
  * See the GNU General Public License for more details.
  */
+
+#include <asm/types.h>
+
 /* Connection component state management */
 /* connection states */
 #define LLC_CONN_OUT_OF_SVC		 0	/* prior to allocation */

--- linux-2.5.24/include/net/llc_conn.h	Fri Jun 21 00:53:56 2002
+++ linux-2.5.24-headfix/include/net/llc_conn.h	Wed Jul  3 22:51:42 2002
@@ -12,6 +12,7 @@
  * See the GNU General Public License for more details.
  */
 #include <linux/timer.h>
+#include <linux/kernel.h>
 #include <net/llc_if.h>
 
 #undef DEBUG_LLC_CONN_ALLOC

--- linux-2.5.24/include/net/llc_evnt.h	Fri Jun 21 00:53:46 2002
+++ linux-2.5.24-headfix/include/net/llc_evnt.h	Wed Jul  3 22:11:31 2002
@@ -1,5 +1,9 @@
 #ifndef LLC_EVNT_H
 #define LLC_EVNT_H
+
+#include <linux/list.h>
+#include <asm/types.h>
+
 /*
  * Copyright (c) 1997 by Procom Technology,Inc.
  * 		 2001 by Arnaldo Carvalho de Melo <acme@conectiva.com.br>

--- linux-2.5.24/include/net/llc_mac.h	Fri Jun 21 00:53:48 2002
+++ linux-2.5.24-headfix/include/net/llc_mac.h	Wed Jul  3 22:25:46 2002
@@ -11,6 +11,9 @@
  *
  * See the GNU General Public License for more details.
  */
+
+#include <asm/types.h>
+
 /* Defines MAC-layer interface to LLC layer */
 extern int mac_send_pdu(struct sk_buff *skb);
 extern int mac_indicate(struct sk_buff *skb, struct net_device *dev,

--- linux-2.5.24/include/net/llc_main.h	Fri Jun 21 00:53:50 2002
+++ linux-2.5.24-headfix/include/net/llc_main.h	Wed Jul  3 22:32:58 2002
@@ -11,6 +11,12 @@
  *
  * See the GNU General Public License for more details.
  */
+
+#include <linux/list.h>
+#include <linux/spinlock.h>
+#include <linux/timer.h>
+#include <asm/types.h>
+
 #define LLC_EVENT		 1
 #define LLC_PACKET		 2
 #define LLC_TYPE_1		 1

--- linux-2.5.24/include/net/llc_pdu.h	Fri Jun 21 00:53:47 2002
+++ linux-2.5.24-headfix/include/net/llc_pdu.h	Wed Jul  3 22:25:10 2002
@@ -11,6 +11,9 @@
  *
  * See the GNU General Public License for more details.
  */
+
+#include <asm/types.h>
+
 /* LLC PDU structure */
 /* Lengths of frame formats */
 #define LLC_PDU_LEN_I	4       /* header and 2 control bytes */

--- linux-2.5.24/include/net/llc_s_ev.h	Fri Jun 21 00:53:44 2002
+++ linux-2.5.24-headfix/include/net/llc_s_ev.h	Wed Jul  3 22:05:48 2002
@@ -1,5 +1,8 @@
 #ifndef LLC_S_EV_H
 #define LLC_S_EV_H
+
+#include <asm/types.h>
+
 /*
  * Copyright (c) 1997 by Procom Technology,Inc.
  * 		 2001 by Arnaldo Carvalho de Melo <acme@conectiva.com.br>

--- linux-2.5.24/include/net/llc_s_st.h	Fri Jun 21 00:53:53 2002
+++ linux-2.5.24-headfix/include/net/llc_s_st.h	Wed Jul  3 22:41:00 2002
@@ -11,6 +11,9 @@
  *
  * See the GNU General Public License for more details.
  */
+
+#include <asm/types.h>
+
 /* Defines SAP component states */
 
 #define LLC_SAP_STATE_INACTIVE	1

--- linux-2.5.24/include/net/llc_stat.h	Fri Jun 21 00:53:54 2002
+++ linux-2.5.24-headfix/include/net/llc_stat.h	Wed Jul  3 22:42:50 2002
@@ -11,6 +11,9 @@
  *
  * See the GNU General Public License for more details.
  */
+
+#include <asm/types.h>
+
 /* Station component state table */
 /* Station component states */
 #define LLC_STATION_STATE_DOWN		1	/* initial state */

--- linux-2.5.24/include/net/neighbour.h	Fri Jun 21 00:53:57 2002
+++ linux-2.5.24-headfix/include/net/neighbour.h	Wed Jul  3 22:54:56 2002
@@ -45,7 +45,7 @@
 
 #include <asm/atomic.h>
 #include <linux/skbuff.h>
-
+#include <linux/jiffies.h>
 #include <linux/err.h>
 
 #define NUD_IN_TIMER	(NUD_INCOMPLETE|NUD_DELAY|NUD_PROBE)

--- linux-2.5.24/include/net/netrom.h	Fri Jun 21 00:53:41 2002
+++ linux-2.5.24-headfix/include/net/netrom.h	Wed Jul  3 22:02:51 2002
@@ -6,7 +6,11 @@
 
 #ifndef _NETROM_H
 #define _NETROM_H 
+
+#include <linux/timer.h>
+#include <linux/types.h>
 #include <linux/netrom.h>
+#include <asm/param.h>
 
 #define	NR_NETWORK_LEN			15
 #define	NR_TRANSPORT_LEN		5

--- linux-2.5.24/include/net/pkt_sched.h	Fri Jun 21 00:53:46 2002
+++ linux-2.5.24-headfix/include/net/pkt_sched.h	Wed Jul  3 22:24:31 2002
@@ -10,7 +10,11 @@
 #include <linux/config.h>
 #include <linux/types.h>
 #include <linux/pkt_sched.h>
+#include <linux/jiffies.h>
+#include <linux/spinlock.h>
+#include <linux/time.h>
 #include <net/pkt_cls.h>
+#include <asm/atomic.h>
 
 #ifdef CONFIG_X86_TSC
 #include <asm/msr.h>

--- linux-2.5.24/include/net/profile.h	Fri Jun 21 00:53:43 2002
+++ linux-2.5.24-headfix/include/net/profile.h	Wed Jul  3 22:05:07 2002
@@ -8,6 +8,7 @@
 #include <linux/time.h>
 #include <linux/kernel.h>
 #include <asm/system.h>
+#include <asm/atomic.h>
 
 #ifdef CONFIG_X86_TSC
 #include <asm/msr.h>

--- linux-2.5.24/include/net/raw.h	Fri Jun 21 00:53:50 2002
+++ linux-2.5.24-headfix/include/net/raw.h	Wed Jul  3 22:29:26 2002
@@ -17,6 +17,7 @@
 #ifndef _RAW_H
 #define _RAW_H
 
+#include <linux/spinlock.h>
 
 extern struct proto raw_prot;
 

--- linux-2.5.24/include/net/rawv6.h	Fri Jun 21 00:53:51 2002
+++ linux-2.5.24-headfix/include/net/rawv6.h	Wed Jul  3 22:36:48 2002
@@ -3,6 +3,9 @@
 
 #ifdef __KERNEL__
 
+#include <linux/spinlock.h>
+#include <asm/types.h>
+
 #define RAWV6_HTABLE_SIZE	MAX_INET_PROTOS
 extern struct sock *raw_v6_htable[RAWV6_HTABLE_SIZE];
 extern rwlock_t raw_v6_lock;

--- linux-2.5.24/include/net/rose.h	Fri Jun 21 00:53:45 2002
+++ linux-2.5.24-headfix/include/net/rose.h	Wed Jul  3 22:09:39 2002
@@ -7,6 +7,9 @@
 #ifndef _ROSE_H
 #define _ROSE_H 
 #include <linux/rose.h>
+#include <linux/timer.h>
+#include <linux/types.h>
+#include <asm/param.h>
 
 #define	ROSE_ADDR_LEN			5
 

--- linux-2.5.24/include/net/scm.h	Fri Jun 21 00:53:52 2002
+++ linux-2.5.24-headfix/include/net/scm.h	Wed Jul  3 22:38:02 2002
@@ -2,6 +2,8 @@
 #define __LINUX_NET_SCM_H
 
 #include <linux/limits.h>
+#include <linux/string.h>
+#include <asm/current.h>
 
 /* Well, we should have at least one descriptor open
  * to accept passed FDs 8)

--- linux-2.5.24/include/net/snmp.h	Fri Jun 21 00:53:50 2002
+++ linux-2.5.24-headfix/include/net/snmp.h	Wed Jul  3 22:32:04 2002
@@ -22,6 +22,7 @@
 #define _SNMP_H
 
 #include <linux/cache.h>
+#include <linux/smp.h>
  
 /*
  *	We use all unsigned longs. Linux will soon be so reliable that even these

--- linux-2.5.24/include/net/syncppp.h	Fri Jun 21 00:53:48 2002
+++ linux-2.5.24-headfix/include/net/syncppp.h	Wed Jul  3 22:26:54 2002
@@ -20,6 +20,9 @@
 #ifndef _SYNCPPP_H_
 #define _SYNCPPP_H_ 1
 
+#include <linux/timer.h>
+#include <linux/types.h>
+
 #ifdef __KERNEL__
 struct slcp {
 	u16	state;          /* state machine */

--- linux-2.5.24/include/net/x25.h	Fri Jun 21 00:53:54 2002
+++ linux-2.5.24-headfix/include/net/x25.h	Wed Jul  3 22:43:43 2002
@@ -10,6 +10,9 @@
 #ifndef _X25_H
 #define _X25_H 
 #include <linux/x25.h>
+#include <linux/timer.h>
+#include <linux/types.h>
+#include <asm/param.h>
 
 #define	X25_ADDR_LEN			16
 

