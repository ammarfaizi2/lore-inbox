Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261284AbUK0G6C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261284AbUK0G6C (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Nov 2004 01:58:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261185AbUKZTDG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 14:03:06 -0500
Received: from ns.sbs.sk ([192.108.125.11]:56335 "EHLO alpha.sbs.sk")
	by vger.kernel.org with ESMTP id S261160AbUKZTAV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:00:21 -0500
Message-ID: <41A5B137.6070405@siemens.com>
Date: Thu, 25 Nov 2004 11:17:27 +0100
From: Ferenci Daniel <Daniel.Ferenci@siemens.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: linux-x25@vger.kernel.org
Subject: x25 forward
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Change log:

X25 forward is patch into x25 stack.

This patch contains also fixing of x25.h bug.

- why the kernel needed patching

Curently x25 has ability just to forward outgoing and incomming x25 
connections but no forwarding.

- the overall design approach in the patch

This is simplified x25 network approach.
Regulary x25 network can change network connection settings for all 
peers. This patch just forward all x25 traffic.
So it means hldc connection is established with lapb stack and all x25 
traffic is sent to coresponding peer.

- implementation details

There is a forward structure for that purpose.
It contains from device and to device.
For every new connection new element of this structure is created.
For every dead connection element is deleted.
When packet arrives for existing structure element it is checked and 
sent to peer device.

x25.h bugfix:
 wrong default value of X25_DEFAULT_THROUGHPUT Cisco routers use to drop 
connections.

-> wrong X25_DEFAULT_THROUGHPUT	0x0A			/* Deafult Throughput */
-> good X25_DEFAULT_THROUGHPUT	0xAA			/* Deafult Throughput *

- testing results

I used it with x25 tap.
I tested it several times on Wincor/Siemens ATM without problems.
Some problems with NCR ATMs but not clear whether because of this patch.

Signed-off-by: Daniel Ferenci <dafe@dafe.net>

-----
diff --new-file -u --recursive linux-2.4.25/net/x25/af_x25.c linux-2.4.25.intel/net/x25/af_x25.c
--- linux-2.4.25/net/x25/af_x25.c	Sat Aug  3 02:39:46 2002
+++ linux-2.4.25.intel/net/x25/af_x25.c	Sat Nov 13 09:30:12 2004
@@ -26,6 +26,7 @@
  *	2000-10-02	Henner Eisen	Made x25_kick() single threaded per socket.
  *	2000-10-27	Henner Eisen    MSG_DONTWAIT for fragment allocation.
  *	2000-11-14	Henner Eisen    Closing datalink from NETDEV_GOING_DOWN
+ *	2000-11-12	Daniel Ferenci	Forward capability added
  */
 
 #include <linux/config.h>
@@ -70,6 +71,8 @@
 
 static x25_address null_x25_address = {"               "};
 
+struct x25_forward *volatile x25_forward_list=NULL;
+
 int x25_addr_ntoa(unsigned char *p, x25_address *called_addr, x25_address *calling_addr)
 {
 	int called_len, calling_len;
@@ -766,6 +769,16 @@
 	x25_address source_addr, dest_addr;
 	struct x25_facilities facilities;
 	int len;
+	struct net_device *dev;
+	struct sk_buff *skbn;
+	struct x25_neigh *neigh_new;
+	struct x25_forward *frwd, *x25_frwd = x25_forward_list;
+	struct x25_forward *new_frwd;
+	
+	/*clone skb*/
+	if ((skbn = skb_clone(skb, GFP_ATOMIC)) == NULL) {
+			return 0;
+	}
 
 	/*
 	 *	Remove the LCI and frame type.
@@ -787,10 +800,55 @@
 	 *	We can't accept the Call Request.
 	 */
 	if (sk == NULL || sk->ack_backlog == sk->max_ack_backlog) {
-		x25_transmit_clear_request(neigh, lci, 0x01);
+		/* dafe - if there is no listener try to reroute packet somewhere*/
+		printk(KERN_DEBUG "x25_rx_call_request(): src addr is: %s \n", source_addr.x25_addr);
+		if ((dev = x25_get_route(&source_addr)) != NULL)
+		{
+			printk(KERN_DEBUG "x25_rx_call_request(): we got dev for route.\n");
+			/*if there is a route and packet is not for us route it away*/
+			if ((neigh_new = x25_get_neigh(dev)) == NULL) {
+				printk(KERN_ERR "X.25: unknown neighbour - %s\n", dev->name);
+				kfree_skb(skbn);
+				return 0;
+			}
+			printk(KERN_DEBUG "x25_receive_data(): found device to forward: %s.\n", dev->name);
+			/* check if it is no loop */ 
+			if (dev == neigh->dev) {
+				printk(KERN_ERR "X.25: devices for forwarding are the same, must be loop!");
+				kfree_skb(skbn);
+				return 0;
+			}
+			
+			/* check whether for the given lci is there a existing forward entry already*/
+			x25_frwd = x25_forward_list;
+	
+			while (x25_frwd != NULL) {
+				frwd     = x25_frwd;
+				x25_frwd = x25_frwd->next;
+
+				if (frwd->lci == lci) {
+					printk(KERN_WARNING "X.25: call request for lci which is already registered!, transmitting but not registering new pair.\n");
+					x25_transmit_link(skbn, neigh_new);
+					return 0;
+				}
+			}
+			
+			x25_transmit_link(skbn, neigh_new);
+			/*remember lci and from device and to device for later routing*/
+			 if ((new_frwd = kmalloc(sizeof(struct x25_forward), GFP_ATOMIC)) == NULL)
+				 return -ENOMEM;
+			 new_frwd->lci = lci;
+			 new_frwd->dev1 = dev;
+			 new_frwd->dev2 = neigh->dev;
+			 new_frwd->next = x25_forward_list;
+			 x25_forward_list = new_frwd;
+		} else {
+			x25_transmit_clear_request(neigh, lci, 0x01);
+		}
 		return 0;
 	}
-
+	kfree_skb(skbn);
+	
 	/*
 	 *	Try to reach a compromise on the requested facilities.
 	 */
@@ -1305,11 +1363,67 @@
 void x25_kill_by_neigh(struct x25_neigh *neigh)
 {
 	struct sock *s;
+	struct x25_forward *frwd, *x25_frwd = x25_forward_list;
+	struct net_device * dev = neigh->dev;
 
 	for( s=x25_list; s != NULL; s=s->next){
 		if( s->protinfo.x25->neighbour == neigh )
 			x25_disconnect(s, ENETUNREACH, 0, 0);
-	} 
+	}
+	
+	/* clean forward lit */
+	
+	/* delete first objects if neccessary */
+	while (x25_forward_list != NULL) {
+		if ((x25_frwd->dev1 == dev) || (x25_frwd->dev2 == dev)) {
+				x25_forward_list = x25_frwd->next;
+				printk(KERN_DEBUG "x25_kill_by_neigh: Deleting the x25_forward entry lci %d, dev1 %s, dev2 %s ", x25_frwd->lci, x25_frwd->dev1->name, x25_frwd->dev2->name);
+				kfree(x25_frwd);
+				x25_frwd = x25_forward_list;
+		} else break;
+	}
+	
+	/* delelte next objects if neccessary */
+	if (x25_forward_list != NULL) 
+	{
+		while (x25_frwd->next != NULL) {
+			frwd     = x25_frwd->next;
+			
+			if ((frwd->dev1 == dev) || (frwd->dev2 == dev)) {
+				x25_frwd->next = frwd->next;
+				printk(KERN_DEBUG "x25_kill_by_neigh: Deleting the x25_forward entry lci %d, dev1 %s, dev2 %s ", frwd->lci, frwd->dev1->name, frwd->dev2->name);
+				kfree(frwd);
+			}
+		
+			x25_frwd = x25_frwd->next;
+		}
+	}
+	
+	printk(KERN_DEBUG "x25_kill_by_neigh: x25_forward_list after deleting: %x", x25_forward_list);
+	
+	x25_frwd = x25_forward_list;
+	
+	while (x25_frwd != NULL) {
+		frwd     = x25_frwd;
+		x25_frwd = x25_frwd->next;
+
+		printk(KERN_DEBUG "x25_kill_by_neigh: x25_forward entry lci %d, dev1 %s, dev2 %s ", frwd->lci, frwd->dev1->name, frwd->dev2->name);
+	}
+}
+
+/*
+ *	Release all memory associated with X.25 forwarding structures.
+ */
+void __exit x25_forward_free(void)
+{
+	struct x25_forward *frwd, *x25_frwd = x25_forward_list;
+
+	while (x25_frwd != NULL) {
+		frwd     = x25_frwd;
+		x25_frwd = x25_frwd->next;
+
+		kfree(frwd);
+	}
 }
 
 static int __init x25_init(void)
@@ -1367,6 +1481,7 @@
 
 	x25_link_free();
 	x25_route_free();
+	x25_forward_free();
 
 #ifdef CONFIG_SYSCTL
 	x25_unregister_sysctl();
diff --new-file -u --recursive linux-2.4.25/net/x25/x25_dev.c linux-2.4.25.intel/net/x25/x25_dev.c
--- linux-2.4.25/net/x25/x25_dev.c	Mon Jan 22 22:32:10 2001
+++ linux-2.4.25.intel/net/x25/x25_dev.c	Sat Nov 13 09:30:50 2004
@@ -15,6 +15,7 @@
  *	History
  *	X.25 001	Jonathan Naylor	Started coding.
  *      2000-09-04	Henner Eisen	Prevent freeing a dangling skb.
+ *	2004-11-12	Daniel Ferenci  forwarding capability added
  */
 
 #include <linux/config.h>
@@ -45,12 +46,33 @@
 #include <linux/if_arp.h>
 #include <net/x25.h>
 
+extern struct x25_forward * x25_forward_list;
+
+static void x25_debug_skb(struct sk_buff *skb){
+	unsigned char * i;
+	
+	printk(KERN_ERR "head: %x\n", skb->head);
+	for (i=skb->head; i < skb->data; i++) printk(KERN_ERR "%x,", *i);
+	printk(KERN_ERR "data: %x", skb->data);
+	for (i=skb->data; i < skb->tail; i++) printk(KERN_ERR "%x,", *i);
+	printk(KERN_ERR "tail: %x", skb->tail);
+	for (i=skb->tail; i < skb->end; i++) printk(KERN_ERR "%x,", *i);
+	printk(KERN_ERR "end: %x", skb->end);
+}
+
 static int x25_receive_data(struct sk_buff *skb, struct x25_neigh *neigh)
 {
 	struct sock *sk;
 	unsigned short frametype;
 	unsigned int lci;
-
+	struct x25_neigh *neigh_new;
+	x25_address source_addr, dest_addr;
+	struct net_device *peer;
+	struct x25_forward *frwd;
+	
+	
+	/* for debug purposses x25_debug_skb(skb);*/
+	
 	frametype = skb->data[2];
         lci = ((skb->data[0] << 8) & 0xF00) + ((skb->data[1] << 0) & 0x0FF);
 
@@ -87,9 +109,39 @@
 		return x25_rx_call_request(skb, neigh, lci);
 
 	/*
-	 *	Its not a Call Request, nor is it a control frame.
-	 *      Let caller throw it away.
-	 */
+	 * Is this packet for us? Check lci in forward list
+	*/
+	printk(KERN_DEBUG "x25_receive_data(): no listener found check for forward lci: %2d.\n", lci);
+	
+	for (frwd = x25_forward_list; frwd != NULL ; frwd = frwd->next) {
+		printk(KERN_DEBUG "x25_receive_data(): finding lci: %2d stored lci: %2d\n", lci, frwd->lci);
+				
+		if (frwd->lci == lci) {
+			struct sk_buff *skbn = pskb_copy (skb, GFP_ATOMIC);
+			printk(KERN_DEBUG "x25_receive_data(): found forward lci.\n");
+			/* Should forward but where?*/
+			if (neigh->dev == frwd->dev1) {
+				peer = frwd->dev2;
+			} else {
+				peer = frwd->dev1;
+			}
+			printk(KERN_DEBUG "x25_receive_data(): found device to forward: %s.\n", peer->name);
+			if ( peer == neigh->dev) 
+			{
+				printk(KERN_DEBUG "x25_receive_data(): this must be a problem form device == to device - droping packet");
+				return 0;
+			}
+			
+			/* send it to peer */
+			if ((neigh_new = x25_get_neigh(peer)) == NULL) {
+				printk(KERN_DEBUG "X.25: unknown neighbour - %s\n", peer->name);
+				return 0;
+			}
+			
+			x25_transmit_link(skbn, neigh_new);
+			return 1;
+		}
+	}
 /*
 	x25_transmit_clear_request(neigh, lci, 0x0D);
 */
diff --new-file -u --recursive linux-2.4.25/net/x25/x25_route.c linux-2.4.25.intel/net/x25/x25_route.c
--- linux-2.4.25/net/x25/x25_route.c	Mon Jan 22 22:32:10 2001
+++ linux-2.4.25.intel/net/x25/x25_route.c	Sat Nov 13 09:31:17 2004
@@ -14,6 +14,7 @@
  *
  *	History
  *	X.25 001	Jonathan Naylor	Started coding.
+ *	2004-11-12	Daniel Ferenci forwarding capability added
  */
 
 #include <linux/config.h>
@@ -46,6 +47,8 @@
 
 static struct x25_route *x25_route_list /* = NULL initially */;
 
+extern struct x25_forward * x25_forward_list; 
+
 /*
  *	Add a new route.
  */
@@ -124,7 +127,9 @@
 void x25_route_device_down(struct net_device *dev)
 {
 	struct x25_route *route, *x25_route = x25_route_list;
+	struct x25_forward *frwd, *x25_frwd = x25_forward_list;
 
+	/* clean route list*/
 	while (x25_route != NULL) {
 		route     = x25_route;
 		x25_route = x25_route->next;
@@ -132,6 +137,45 @@
 		if (route->dev == dev)
 			x25_remove_route(route);
 	}
+	
+	/* clean forward lit */
+	
+	/* delete first objects if neccessary */
+	while (x25_forward_list != NULL) {
+		if ((x25_frwd->dev1 == dev) || (x25_frwd->dev2 == dev)) {
+				x25_forward_list = x25_frwd->next;
+				printk(KERN_DEBUG "x25_route_device_down: Deleting the x25_forward entry lci %d, dev1 %s, dev2 %s ", x25_frwd->lci, x25_frwd->dev1->name, x25_frwd->dev2->name);
+				kfree(x25_frwd);
+				x25_frwd = x25_forward_list;
+		} else break;
+	}
+	
+	/* delelte next objects if neccessary */
+	if (x25_forward_list != NULL) 
+	{
+		while (x25_frwd->next != NULL) {
+			frwd     = x25_frwd->next;
+			
+			if ((frwd->dev1 == dev) || (frwd->dev2 == dev)) {
+				x25_frwd->next = frwd->next;
+				printk(KERN_DEBUG "x25_route_device_down: Deleting the x25_forward entry lci %d, dev1 %s, dev2 %s ", frwd->lci, frwd->dev1->name, frwd->dev2->name);
+				kfree(frwd);
+			}
+		
+			x25_frwd = x25_frwd->next;
+		}
+	}
+	
+	printk(KERN_DEBUG "x25_route_device_down: x25_forward_list after deleting: %x", x25_forward_list);
+	
+	x25_frwd = x25_forward_list;
+	
+	while (x25_frwd != NULL) {
+		frwd     = x25_frwd;
+		x25_frwd = x25_frwd->next;
+
+		printk(KERN_DEBUG "x25_route_device_down: x25_forward entry lci %d, dev1 %s, dev2 %s ", frwd->lci, frwd->dev1->name, frwd->dev2->name);
+	}
 }
 
 /*
--- linux-2.4.25/include/net/x25.h	Mon Jan 22 22:32:10 2001
+++ linux-2.4.25.intel/include/net/x25.h	Thu Aug 19 09:53:41 2004
@@ -76,7 +76,7 @@
 
 #define	X25_DEFAULT_WINDOW_SIZE	2			/* Default Window Size	*/
 #define	X25_DEFAULT_PACKET_SIZE	X25_PS128		/* Default Packet Size */
-#define	X25_DEFAULT_THROUGHPUT	0x0A			/* Deafult Throughput */
+#define	X25_DEFAULT_THROUGHPUT	0xAA			/* Deafult Throughput */
 #define	X25_DEFAULT_REVERSE	0x00			/* Default Reverse Charging */
 
 #define X25_SMODULUS 		8
@@ -139,6 +139,13 @@
 	unsigned long 		vc_facil_mask;	/* inc_call facilities mask */
 } x25_cb;
 
+struct x25_forward {
+	unsigned int lci;
+	struct net_device *dev1;
+	struct net_device *dev2;
+	struct x25_forward *next;
+};
+
 /* af_x25.c */
 extern int  sysctl_x25_restart_request_timeout;
 extern int  sysctl_x25_call_request_timeout;
@@ -153,6 +160,8 @@
 extern void x25_destroy_socket(struct sock *);
 extern int  x25_rx_call_request(struct sk_buff *, struct x25_neigh *, unsigned int);
 extern void x25_kill_by_neigh(struct x25_neigh *);
+extern void x25_forward_free(void);
+
 
 /* x25_dev.c */
 extern void x25_send_frame(struct sk_buff *, struct x25_neigh *);



