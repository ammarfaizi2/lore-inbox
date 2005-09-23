Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750828AbVIWJES@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750828AbVIWJES (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 05:04:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750829AbVIWJES
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 05:04:18 -0400
Received: from gw1.cosmosbay.com ([62.23.185.226]:31701 "EHLO
	gw1.cosmosbay.com") by vger.kernel.org with ESMTP id S1750828AbVIWJES
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 05:04:18 -0400
Message-ID: <4333C4E2.9000000@cosmosbay.com>
Date: Fri, 23 Sep 2005 11:03:30 +0200
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: "David S. Miller" <davem@davemloft.net>
CC: akpm@osdl.org, kiran@scalex86.org, rusty@rustcorp.com.au,
       dipankar@in.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [patch 0/6] mm: alloc_percpu and bigrefs
References: <20050923062529.GA4209@localhost.localdomain>	<20050923001013.28b7f032.akpm@osdl.org> <20050923.001729.101033164.davem@davemloft.net>
In-Reply-To: <20050923.001729.101033164.davem@davemloft.net>
Content-Type: multipart/mixed;
 boundary="------------070104030804060206080606"
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (gw1.cosmosbay.com [172.16.8.80]); Fri, 23 Sep 2005 11:03:31 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070104030804060206080606
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit

David S. Miller a écrit :
> From: Andrew Morton <akpm@osdl.org>
> Date: Fri, 23 Sep 2005 00:10:13 -0700
> 
> 
>>Ravikiran G Thirumalai <kiran@scalex86.org> wrote:
>>
>>>Hi Andrew,
>>>This patchset contains alloc_percpu + bigrefs + bigrefs for netdevice
>>>refcount.  This patchset improves tbench lo performance by 6% on a 8 way IBM
>>>x445.
>>
>>I think we'd need more comprehensive benchmarks than this before adding
>>large amounts of complex core code.
> 
> 
> I agree.  tbench over loopback is about as far from real life
> as it gets.
> 
> I'm still against expanding these networking datastructures with
> bigrefs just for this stuff.  Some people have per-cpu and per-node on
> the brain, and it's starting to bloat things up a little bit too much.

Hi David

I agree with you about bigref might be a bit of over-engineering for netdevice 
refcount.

I sent one month ago a patch to reorder 'struct net_device' to at least make 
it SMP friendly, with no per-cpu or per-node additional memory but got no comment.

It's important to place mostly read parts together, so that a cache lines can 
be shared by CPUS. It's important to separate hot fields in three different 
cache lines to that a cpu can work on the transmit while another is receiving 
frames without paying cache line ping pongs.

Please (re)consider this patch since it really reduce CPU load and/or memory 
bus trafic between CPUS.

I ask this question :
  - Is the following comment found in netdevice.h still true ?

/*
  * This is the first field of the "visible" part of this structure
  * (i.e. as seen by users in the "Space.c" file).  It is the name
  * the interface.
  */

If it is still true, then I suspect name_hlist cannot be moved like I did.


Thank you


- [NET] : Reorder some hot fields of struct net_device and place them on 
separate cache lines in SMP to lower memory bouncing between multiple CPU 
accessing the device.

     - One part is mostly used on receive path (including eth_type_trans())
      (poll_list, poll, quota, weight, last_rx, dev_addr, broadcast)

     - One part is mostly used on queue transmit path (qdisc)
      (queue_lock, qdisc, qdisc_sleeping, qdisc_list, tx_queue_len)

     - One part is mostly used on xmit path (device)
      (xmit_lock, xmit_lock_owner, priv, hard_start_xmit, trans_start)

'features' is placed outside of these hot points, in a location that may be 
shared by all cpus (because mostly read)

Minor but maybe not possible because of ABI :
	name_hlist is moved close to name[IFNAMSIZ] to speedup __dev_get_by_name()

Signed-off-by: Eric Dumazet <dada1@cosmosbay.com>



--------------070104030804060206080606
Content-Type: text/plain;
 name="reorder_netdevice"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="reorder_netdevice"

--- linux-2.6.14-rc2/include/linux/netdevice.h	2005-09-20 05:00:41.000000000 +0200
+++ linux-2.6.14-rc2-ed/include/linux/netdevice.h	2005-09-23 10:52:43.000000000 +0200
@@ -265,6 +265,8 @@
 	 * the interface.
 	 */
 	char			name[IFNAMSIZ];
+	/* device name hash chain */
+	struct hlist_node	name_hlist;
 
 	/*
 	 *	I/O specific fields
@@ -292,6 +294,21 @@
 
 	/* ------- Fields preinitialized in Space.c finish here ------- */
 
+	/* Net device features */
+	unsigned long		features;
+#define NETIF_F_SG		1	/* Scatter/gather IO. */
+#define NETIF_F_IP_CSUM		2	/* Can checksum only TCP/UDP over IPv4. */
+#define NETIF_F_NO_CSUM		4	/* Does not require checksum. F.e. loopack. */
+#define NETIF_F_HW_CSUM		8	/* Can checksum all the packets. */
+#define NETIF_F_HIGHDMA		32	/* Can DMA to high memory. */
+#define NETIF_F_FRAGLIST	64	/* Scatter/gather IO. */
+#define NETIF_F_HW_VLAN_TX	128	/* Transmit VLAN hw acceleration */
+#define NETIF_F_HW_VLAN_RX	256	/* Receive VLAN hw acceleration */
+#define NETIF_F_HW_VLAN_FILTER	512	/* Receive filtering on VLAN */
+#define NETIF_F_VLAN_CHALLENGED	1024	/* Device cannot handle VLAN packets */
+#define NETIF_F_TSO		2048	/* Can offload TCP/IP segmentation */
+#define NETIF_F_LLTX		4096	/* LockLess TX */
+
 	struct net_device	*next_sched;
 
 	/* Interface index. Unique device identifier	*/
@@ -316,9 +333,6 @@
 	 * will (read: may be cleaned up at will).
 	 */
 
-	/* These may be needed for future network-power-down code. */
-	unsigned long		trans_start;	/* Time (in jiffies) of last Tx	*/
-	unsigned long		last_rx;	/* Time of last Rx	*/
 
 	unsigned short		flags;	/* interface flags (a la BSD)	*/
 	unsigned short		gflags;
@@ -328,15 +342,12 @@
 	unsigned		mtu;	/* interface MTU value		*/
 	unsigned short		type;	/* interface hardware type	*/
 	unsigned short		hard_header_len;	/* hardware hdr length	*/
-	void			*priv;	/* pointer to private data	*/
 
 	struct net_device	*master; /* Pointer to master device of a group,
 					  * which this device is member of.
 					  */
 
 	/* Interface address info. */
-	unsigned char		broadcast[MAX_ADDR_LEN];	/* hw bcast add	*/
-	unsigned char		dev_addr[MAX_ADDR_LEN];	/* hw address	*/
 	unsigned char		perm_addr[MAX_ADDR_LEN]; /* permanent hw address */
 	unsigned char		addr_len;	/* hardware address length	*/
 	unsigned short          dev_id;		/* for shared network cards */
@@ -346,8 +357,6 @@
 	int			promiscuity;
 	int			allmulti;
 
-	int			watchdog_timeo;
-	struct timer_list	watchdog_timer;
 
 	/* Protocol specific pointers */
 	
@@ -358,32 +367,62 @@
 	void			*ec_ptr;	/* Econet specific data	*/
 	void			*ax25_ptr;	/* AX.25 specific data */
 
-	struct list_head	poll_list;	/* Link to poll list	*/
+/*
+ * Cache line mostly used on receive path (including eth_type_trans())
+ */
+	struct list_head	poll_list ____cacheline_aligned_in_smp;
+					/* Link to poll list	*/
+
+	int			(*poll) (struct net_device *dev, int *quota);
 	int			quota;
 	int			weight;
+	unsigned long		last_rx;	/* Time of last Rx	*/
+	/* Interface address info used in eth_type_trans() */
+	unsigned char		dev_addr[MAX_ADDR_LEN];	/* hw address, (before bcast 
+							because most packets are unicast) */
+
+	unsigned char		broadcast[MAX_ADDR_LEN];	/* hw bcast add	*/
 
+/*
+ * Cache line mostly used on queue transmit path (qdisc)
+ */
+	/* device queue lock */
+	spinlock_t		queue_lock ____cacheline_aligned_in_smp;
 	struct Qdisc		*qdisc;
 	struct Qdisc		*qdisc_sleeping;
-	struct Qdisc		*qdisc_ingress;
 	struct list_head	qdisc_list;
 	unsigned long		tx_queue_len;	/* Max frames per queue allowed */
 
 	/* ingress path synchronizer */
 	spinlock_t		ingress_lock;
+	struct Qdisc		*qdisc_ingress;
+
+/*
+ * One part is mostly used on xmit path (device)
+ */
 	/* hard_start_xmit synchronizer */
-	spinlock_t		xmit_lock;
+	spinlock_t		xmit_lock ____cacheline_aligned_in_smp;
 	/* cpu id of processor entered to hard_start_xmit or -1,
 	   if nobody entered there.
 	 */
 	int			xmit_lock_owner;
-	/* device queue lock */
-	spinlock_t		queue_lock;
+	void			*priv;	/* pointer to private data	*/
+	int			(*hard_start_xmit) (struct sk_buff *skb,
+						    struct net_device *dev);
+	/* These may be needed for future network-power-down code. */
+	unsigned long		trans_start;	/* Time (in jiffies) of last Tx	*/
+
+	int			watchdog_timeo; /* used by dev_watchdog() */
+	struct timer_list	watchdog_timer;
+
+/*
+ * refcnt is a very hot point, so align it on SMP
+ */
 	/* Number of references to this device */
-	atomic_t		refcnt;
+	atomic_t		refcnt ____cacheline_aligned_in_smp;
+
 	/* delayed register/unregister */
 	struct list_head	todo_list;
-	/* device name hash chain */
-	struct hlist_node	name_hlist;
 	/* device index hash chain */
 	struct hlist_node	index_hlist;
 
@@ -396,21 +435,6 @@
 	       NETREG_RELEASED,		/* called free_netdev */
 	} reg_state;
 
-	/* Net device features */
-	unsigned long		features;
-#define NETIF_F_SG		1	/* Scatter/gather IO. */
-#define NETIF_F_IP_CSUM		2	/* Can checksum only TCP/UDP over IPv4. */
-#define NETIF_F_NO_CSUM		4	/* Does not require checksum. F.e. loopack. */
-#define NETIF_F_HW_CSUM		8	/* Can checksum all the packets. */
-#define NETIF_F_HIGHDMA		32	/* Can DMA to high memory. */
-#define NETIF_F_FRAGLIST	64	/* Scatter/gather IO. */
-#define NETIF_F_HW_VLAN_TX	128	/* Transmit VLAN hw acceleration */
-#define NETIF_F_HW_VLAN_RX	256	/* Receive VLAN hw acceleration */
-#define NETIF_F_HW_VLAN_FILTER	512	/* Receive filtering on VLAN */
-#define NETIF_F_VLAN_CHALLENGED	1024	/* Device cannot handle VLAN packets */
-#define NETIF_F_TSO		2048	/* Can offload TCP/IP segmentation */
-#define NETIF_F_LLTX		4096	/* LockLess TX */
-
 	/* Called after device is detached from network. */
 	void			(*uninit)(struct net_device *dev);
 	/* Called after last user reference disappears. */
@@ -419,10 +443,7 @@
 	/* Pointers to interface service routines.	*/
 	int			(*open)(struct net_device *dev);
 	int			(*stop)(struct net_device *dev);
-	int			(*hard_start_xmit) (struct sk_buff *skb,
-						    struct net_device *dev);
 #define HAVE_NETDEV_POLL
-	int			(*poll) (struct net_device *dev, int *quota);
 	int			(*hard_header) (struct sk_buff *skb,
 						struct net_device *dev,
 						unsigned short type,

--------------070104030804060206080606--
