Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261471AbULFJjJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261471AbULFJjJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 04:39:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261474AbULFJjJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 04:39:09 -0500
Received: from [202.125.86.130] ([202.125.86.130]:60384 "EHLO
	ns2.astrainfonets.net") by vger.kernel.org with ESMTP
	id S261471AbULFJib convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 04:38:31 -0500
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: Net Filter Driver --- How to send the information to application after packet arrives 
X-MimeOLE: Produced By Microsoft Exchange V6.5.6944.0
Date: Mon, 6 Dec 2004 15:12:46 +0530
Message-ID: <4EE0CBA31942E547B99B3D4BFAB348112586AA@mail.esn.co.in>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Net Filter Driver --- How to send the information to application after packet arrives 
Thread-Index: AcTbdVwSXJA++5YsRFWUhqFRQVAFtQ==
From: "Srinivas G." <srinivasg@esntechnologies.co.in>
To: "linux-kernel-Mailing-list" <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear All,

I am new to net work drivers. 

I have developed a very simple/small net filter driver to capture the
network packets from my network path. It was working fine. Whenever a
packet goes through my network path it was simply prints a message. It
was printing the messages fine.

Now I want to send the buffer address which is allocated in the "hook"
function in the driver code to the application. Is there any way to send
it to the application? (As I know ioctl and mmap, but these two are
initiated from the application. Actually I want send the signal from
"hook" function to the application whenever a packet arrives. Is there
any method which was already exists? OR Can I implement it as CHARACTER
driver to work with mmap?)

Please go though the code attached below.

========================================================================
===================

#include <linux/module.h>		/* for module parameters */
#include <linux/kernel.h>		/* for printk function */
#include <linux/init.h>			/* for module explicit
definitions */
#include <linux/netfilter.h>		/* for netfilter structure */
#include <linux/netfilter_ipv4.h>	/* for IPv4 specific defines */
#include <linux/vmalloc.h>		/* for vmalloc function */

#ifdef NETFILTER_DBG
#define PRINTK(fmt,arg...) printk("NET_DBG <%s> | "
fmt,__FUNCTION__,##arg);
#else
#define PRINTK(fmt,arg...) while(0)
#endif

/* define the maximum packet buffer */
#define MAX_PACK_BUFF   2048

MODULE_LICENSE("GPL");
MODULE_AUTHOR("Srinivas G at ESN Technologies");

/* define netfilter structure here */
static struct nf_hook_ops netfilter_hook;

/* pointer to a buffer */
unsigned char *ptr_packet_buff;

/* function prototype which is called when a packet arrives */
unsigned int netfilter_drv_hook(unsigned int hooknum, 
				struct sk_buff **skb,
		      		const struct net_device *in, 
				const struct net_device *out,
		      		int (*okfn)(struct sk_buff *))
{
	PRINTK("One Packet arrvied!\n");

	/* alocate the packet buffer */
	ptr_packet_buff = (unsigned char *)vmalloc(MAX_PACK_BUFF);
	
	/* the received packet was dropped here itself */
	return NF_DROP;
}
	
	

/* netfilter_init: initialization function */
static int
__init init_netfilter(void)
{
	PRINTK("invoked!\n");
	
	/* assign the function pointer */
	netfilter_hook.hook = netfilter_drv_hook;

	/* assign the protocol family i.e. IPv4 */
	netfilter_hook.pf = PF_INET;

	/* assign the hook number like NF_IP_LOCAL_IN etc. */
	netfilter_hook.hooknum = NF_IP_PRE_ROUTING;

	/* assign the hook priority */
	netfilter_hook.priority = NF_IP_PRI_FIRST;

	/* register the netfilter driver with pointer to structure */
	nf_register_hook(&netfilter_hook);

	return 0;
}

/* netfilter_exit: cleanup function */
static void
__exit netfilter_exit(void)
{
	PRINTK("invoked!\n");

	/* unregister the driver */
	nf_unregister_hook(&netfilter_hook);
	
}

/* explicit module definitions */
module_init(init_netfilter);
module_exit(netfilter_exit);

========================================================================
====

Please give me an idea/solution.

Thanks and regards,
Srinivas G


