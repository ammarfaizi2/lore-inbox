Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270684AbRHNSpY>; Tue, 14 Aug 2001 14:45:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270681AbRHNSpL>; Tue, 14 Aug 2001 14:45:11 -0400
Received: from shad0w.dial.nildram.co.uk ([195.112.18.51]:11529 "EHLO
	mail.shad0w.org.uk") by vger.kernel.org with ESMTP
	id <S270632AbRHNSod>; Tue, 14 Aug 2001 14:44:33 -0400
Date: Tue, 14 Aug 2001 19:47:05 +0100 (BST)
From: Chris Crowther <chrisc@shad0w.org.uk>
To: <linux-kernel@vger.kernel.org>
Subject: [PATCH] CDP handler for linux
Message-ID: <Pine.LNX.4.33.0108141934130.3283-100000@monolith.shad0w.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

'lo all,

	Hmm, why am I scared about this?  Oh well, here goes.

	I've been working on an addition to the kernel over the past
couple of days that enables the kernel to interpret CDP (Cisco Discovery
Protocol) packets which can be transmited by various pieces of Cisco kit.

	I've got it to the stage where it will read neighbors packets and
display them via a /proc/net entry, but I've only really tested it with
the router I have access to here, so I was wondering:

	1) am I nuts
	2) is anyone else interested in this
	3) can anyone tell me if it reads packets from other pieces of kit
OK? :)

	The code is stable enough that the kernel does panic and my
workstation hasn't exploded yet, but there's still some gaps in the
recieve code, and it doesn't delete neighors whose TTL's have expired yet
(I'm about to start do that).

	The plan is eventualy to make the addition transmit CDP packets as
well.

	Please don't chargrill me :)  Patch follows, option is flagged as
Experimental in the Config file and it's under Network Options, comments
and suggestions are very welcome (as long as they're nice and/or
contsructive).

diff -urN -X dontdiff linux-2.4/Documentation/Configure.help linux-2.4.7-cdp/Documentation/Configure.help
--- linux-2.4/Documentation/Configure.help	Mon Jul 30 10:52:41 2001
+++ linux-2.4.7-cdp/Documentation/Configure.help	Tue Aug 14 14:37:35 2001
@@ -4226,6 +4226,31 @@
   The kHTTPd is experimental. Be careful when using it on a production
   machine. Also note that kHTTPd doesn't support virtual servers yet.

+CDP Reporting (EXPERIMENTAL)
+CONFIG_CDP
+  This is support for reporting the Cisco CDP packets which can be
+  broadcast by various Cisco kit.  Information is written to proc file
+  system.
+
+  This protocol support is also available as a module ( = code which
+  can be inserted in and removed from the running kernel whenever you
+  want). The module will be called cdp.o. If you want to compile it
+  as a module, say M here and read Documentation/modules.txt.
+
+  Be sure to say Y to "/proc file system support" otherwise you won't
+  see anything.
+
+CDP Debuging
+CONFIG_CDP_DEBUG
+  Enable debuging information in the CDP code - this generate a lot of
+  information at KERN_DEBUG level - it should only be used for
+  troubleshooting - you *really* do *not* want to use it on a production
+  system, your log files will be full of data.  Every incoming packet
+  generates over 20 lines of debuging information.
+
+  You probably want to say N here - only enable if you know you really
+  want it.
+
 IPX networking
 CONFIG_IPX
   This is support for the Novell networking protocol, IPX, commonly
diff -urN -X dontdiff linux-2.4/include/net/cdp.h linux-2.4.7-cdp/include/net/cdp.h
--- linux-2.4/include/net/cdp.h	Thu Jan  1 01:00:00 1970
+++ linux-2.4.7-cdp/include/net/cdp.h	Tue Aug 14 19:16:35 2001
@@ -0,0 +1,79 @@
+/*
+ *
+ *	Bassed on documentation from Cisco, detailing the CDP packet format,
+ * 	which is available from:
+ *	http://www.cisco.com/univercd/cc/td/doc/product/lan/trsrb/frames.htm#xtocid842812
+ *
+ *	Portions Copyright (c) 2001 Chris Crowther
+ *	Chris Crowther admits no liability nor provides warranty for any
+ *	of this software.  This material is provided "AS-IS" and at no charge.
+ *
+ *	This software is released under the the GNU Public Licence (GPL).
+*/
+
+/* values for our cdp packets */
+#define CDP_VERSION		0x1
+#define CDP_TTL			180	/* send our packets with a TTL of 180 seconds */
+
+/* timer values */
+#define CDP_POLL		HZ*5	/* poll the neighbor list every 5 seconds for expired
+						entires */
+#define CDP_TXTIME		HZ*60	/* send out packets every 60 seconds */
+
+
+/* the packet types */
+#define CDP_TYPE_DEVICEID	0x0001
+#define CDP_TYPE_ADDRESS 	0x0002
+#define CDP_TYPE_PORTID		0x0003
+#define CDP_TYPE_CAPABILITIES	0x0004
+#define CDP_TYPE_VERSION	0x0005
+#define CDP_TYPE_PLATFORM	0x0006
+#define CDP_TYPE_IPPREFIX	0x0007
+
+/* the capability masks */
+#define CDP_CAPABILITY_L3R	0x01	/* a layer 3 router */
+#define CDP_CAPABILITY_L2TB	0x02	/* a layer 2 transparent bridge */
+#define CDP_CAPABILITY_L2SRB	0x04	/* a layer 2 source-root bridge */
+#define CDP_CAPABILITY_L2SW	0x08	/* a layer 2 switch (non-spanning tree) */
+#define CDP_CAPABILITY_L3TXRX	0x10	/* a layer 3 (non routing) host */
+#define CDP_CAPABILITY_IGRPFW	0x20	/* does not forward IGMP Packets to non-routers */
+#define CDP_CAPABILITY_L1	0x40	/* a layer 1 repeater */
+
+/* the actual neighbor entry */
+struct s_cdp_neighbor {
+
+	unsigned char *remote_ethernet;	/* Remote MAC */
+	char *local_iface;		/* Device we saw the packet on*/
+	struct timeval timestamp;	/* Time packet arrived */
+	unsigned char cdp_version;	/* Version of CDP - always 1 afaik*/
+	unsigned char cdp_ttl;		/* Holdtime */
+	unsigned short cdp_checksum;	/* Standard IP packet checksum */
+	char *cdp_neighbor_sw_ver;	/* Software version on neighbor */
+	char *cdp_neighbor_id;		/* FQDN of remote device */
+	struct in_addr cdp_addresss;	/* FIXME This should really be a linked list of
+					addresses, since routers can have more than one.
+					Is it possible to have IPX or AppleNet addresses
+					here also? */
+	char *cdp_capabitlities;	/* String of capability codes */
+	int cdp_capab_mask;		/* Mask of capabilities */
+	char *cdp_platform;		/* Model name */
+	char *cdp_portID;		/* Remote port origin */
+
+	struct s_cdp_neighbor *next;
+	struct s_cdp_neighbor *prev;
+};
+
+/* linked list of addresses */
+struct cdp_neighbor_addresses {
+	struct in_addr cdp_addresss;
+
+	struct cdp_neighbor_addresses *next;
+	struct cdp_neighbor_addresses *prev;
+};
+
+/* head struct */
+struct s_cdp_neighbors {
+	struct s_cdp_neighbor *head;
+	struct s_cdp_neighbor *foot;
+};
+
diff -urN -X dontdiff linux-2.4/net/802/Makefile linux-2.4.7-cdp/net/802/Makefile
--- linux-2.4/net/802/Makefile	Fri Dec 29 22:07:24 2000
+++ linux-2.4.7-cdp/net/802/Makefile	Thu Aug  9 12:17:09 2001
@@ -50,6 +50,10 @@
 	SNAP=y
 endif

+ifdef CONFIG_CDP
+	SNAP=y
+endif
+
 ifeq ($(SNAP),y)
 obj-y += p8022.o psnap.o
 endif
diff -urN -X dontdiff linux-2.4/net/Config.in linux-2.4.7-cdp/net/Config.in
--- linux-2.4/net/Config.in	Wed Mar  7 06:44:15 2001
+++ linux-2.4.7-cdp/net/Config.in	Tue Aug 14 14:48:59 2001
@@ -49,6 +49,14 @@
 fi

 comment ' '
+
+dep_tristate 'The Cisco Discovery Protocol (EXPERIMENTAL)' CONFIG_CDP $CONFIG_EXPERIMENTAL
+if [ "$CONFIG_CDP" != "n" ]; then
+	source net/cdp/Config.in
+fi
+
+comment ' '
+
 tristate 'The IPX protocol' CONFIG_IPX
 if [ "$CONFIG_IPX" != "n" ]; then
    source net/ipx/Config.in
diff -urN -X dontdiff linux-2.4/net/Makefile linux-2.4.7-cdp/net/Makefile
--- linux-2.4/net/Makefile	Tue Jun 12 03:15:27 2001
+++ linux-2.4.7-cdp/net/Makefile	Thu Aug  9 12:13:33 2001
@@ -32,6 +32,7 @@
 subdir-$(CONFIG_NET_SCHED)	+= sched
 subdir-$(CONFIG_BRIDGE)		+= bridge
 subdir-$(CONFIG_IPX)		+= ipx
+subdir-$(CONFIG_CDP)		+= cdp
 subdir-$(CONFIG_ATALK)		+= appletalk
 subdir-$(CONFIG_WAN_ROUTER)	+= wanrouter
 subdir-$(CONFIG_X25)		+= x25
diff -urN -X dontdiff linux-2.4/net/cdp/Config.in linux-2.4.7-cdp/net/cdp/Config.in
--- linux-2.4/net/cdp/Config.in	Thu Jan  1 01:00:00 1970
+++ linux-2.4.7-cdp/net/cdp/Config.in	Tue Aug 14 14:48:00 2001
@@ -0,0 +1,5 @@
+#
+# CDP anscialry options
+#
+
+bool '  Enable Debug code' CONFIG_CDP_DEBUG $CONFIG_CDP
diff -urN -X dontdiff linux-2.4/net/cdp/Makefile linux-2.4.7-cdp/net/cdp/Makefile
--- linux-2.4/net/cdp/Makefile	Thu Jan  1 01:00:00 1970
+++ linux-2.4.7-cdp/net/cdp/Makefile	Thu Aug  9 12:11:44 2001
@@ -0,0 +1,25 @@
+#
+# Makefile for the Linux CDP layer.
+#
+# Note! Dependencies are done automagically by 'make dep', which also
+# removes any old dependencies. DON'T put your own dependencies here
+# unless it's something special (ie not a .c file).
+#
+# Note 2! The CFLAGS definition is now in the main makefile...
+
+# We only get in/to here if CONFIG_CDP = 'y' or 'm'
+
+O_TARGET := cdp.o
+
+export-objs = af_cdp.o
+
+obj-y	:= af_cdp.o
+
+ifeq ($(CONFIG_CDP),m)
+  obj-m += $(O_TARGET)
+endif
+
+include $(TOPDIR)/Rules.make
+
+tar:
+		tar -cvf /dev/f1 .
diff -urN -X dontdiff linux-2.4/net/cdp/af_cdp.c linux-2.4.7-cdp/net/cdp/af_cdp.c
--- linux-2.4/net/cdp/af_cdp.c	Thu Jan  1 01:00:00 1970
+++ linux-2.4.7-cdp/net/cdp/af_cdp.c	Tue Aug 14 19:14:11 2001
@@ -0,0 +1,509 @@
+/*
+ *      Implements a CDP handler.
+ *
+ * 	This code is derived from protocol specifications by Cisco Systems
+ *	and various code culled from the Kernel source tree, mostly the IPX
+ *	code.
+ *
+ *	Unless otherwise commented, all revisions by Chris Crowther.
+ *
+ *	Revision 0.1.0:	Initial coding.
+ *	Revision 0.1.1:	Incoming CDP packet handling working, prefix's and addresses
+ *			need handling still.
+ *
+ *	Portions Copyright (c) 2001 Chris Crowther.
+ *	Chris Crowther admits no liability nor provides warranty for any
+ *	of this software.  This material is provided "AS-IS" and at no charge.
+ *
+ *	This software is released under the the GNU Public Licence (GPL).
+ *
+*/
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/errno.h>
+#include <linux/types.h>
+#include <linux/socket.h>
+#include <linux/in.h>
+#include <linux/if.h>
+#include <linux/if_ether.h>
+#include <linux/kernel.h>
+#include <linux/string.h>
+#include <linux/sockios.h>
+#include <linux/skbuff.h>
+#include <linux/netdevice.h>
+#include <linux/time.h>
+#include <linux/proc_fs.h>
+#include <linux/init.h>
+
+#include <asm/byteorder.h>
+#include <asm/system.h>
+
+#include <net/psnap.h>
+#include <net/cdp.h>
+
+/* module info */
+MODULE_AUTHOR("Chris Crowther <chrisc@shad0w.org.uk>");
+MODULE_DESCRIPTION("Linux Cisco Discovery Protocol");
+
+/* globals */
+static struct s_cdp_neighbors cdp_neighbors;
+static struct timer_list cdp_poll_neighbors_timer;
+static struct timer_list cdp_tx_data_timer;
+
+/* linked list functions */
+struct s_cdp_neighbor *cdp_find_neighbor(unsigned char *remote_ethernet)
+{
+
+	struct s_cdp_neighbor *p = cdp_neighbors.head;
+
+	while(p != NULL)
+	{
+		#ifdef CONFIG_CDP_DEBUG
+		printk(KERN_DEBUG "CDP: Comparing neighbor with %.2X:%.2X:%.2X:%.2X:%.2X:%.2X\n",
+			p->remote_ethernet[0],
+			p->remote_ethernet[1],
+			p->remote_ethernet[2],
+			p->remote_ethernet[3],
+			p->remote_ethernet[4],
+			p->remote_ethernet[5]);
+		#endif
+		if (!memcmp(remote_ethernet, p->remote_ethernet, ETH_ALEN))
+		{
+			#ifdef CONFIG_CDP_DEBUG
+			printk(KERN_DEBUG "CDP: Matches existing entry\n");
+			#endif
+			return p;
+		} else {
+			#ifdef CONFIG_CDP_DEBUG
+			printk(KERN_DEBUG "CDP: Doesn't match, trying next entry (if any)\n");
+			#endif
+			p = p->next;
+		}
+	}
+
+	/* fallthrough */
+	return NULL;
+}
+
+/* removes a neighbor element from the list, then free's it */
+void cdp_delete_neighbor(struct s_cdp_neighbor *p)
+{
+	if(p->prev)
+		p->prev->next = p->next;
+
+	if(p->next)
+		p->next->prev = p->prev;
+
+	if (cdp_neighbors.head == p)
+		cdp_neighbors.head = p->next;
+
+	if (cdp_neighbors.foot == p)
+		cdp_neighbors.foot = p->prev;
+
+	#ifdef CONFIG_CDP_DEBUG
+	printk(KERN_DEBUG "CDP: Freeing neighbor entry at memory ref: 0x%X\n",p);
+	#endif
+	kfree(p);
+}
+
+/* update a neighbor entry with newer values */
+int cdp_update_neighbor(struct sk_buff *skb, struct s_cdp_neighbor *p)
+{
+
+	/* We store all data localy in host byte order, which means we need to run ntoh[l/s] over
+		all the numeric values (except single bytes of course).  It's safe to always run
+		this since it has no effect on the data if the host byte order is the same network
+		byte order (as is the case with Big Endian systmes). */
+
+	/* temporary holders for packet data */
+	unsigned short type = 0, length = 0, len = 0;
+	unsigned char *data = "";
+	char *buf = "";
+
+	/* If we have less than 4 bytes of data, we don't have a valid CDP packet, return
+		NULL so we know to toast the record */
+	if(skb->len < 4)
+		return NULL;
+
+	/* copy the timestamp from the skb to the neighbor so we know
+		when it arrived, and therefore know when to expire it */
+	memcpy(&(p->timestamp),&(skb->stamp),sizeof(struct timeval));
+	memcpy(&(p->cdp_version),(skb->data)++,1);
+	memcpy(&(p->cdp_ttl),(skb->data)++,1);
+	memcpy(&(p->cdp_checksum),(skb->data)++,2); (skb->data)++;
+
+	/* FIXME i haven't got round to actually checking this yet - we should really do it now */
+	p->cdp_checksum = ntohs(p->cdp_checksum);
+
+	/* FIXME  compare the checksum here as a kludge to see if there's any change in data */
+
+	if ((p->remote_ethernet = (unsigned char *)kmalloc(sizeof(unsigned char)*ETH_ALEN,GFP_ATOMIC)) == NULL)
+	{
+		printk(KERN_CRIT "CDP: Could not allocate memory for neighbor key member.\n");
+		return NULL;
+	} else {
+		memcpy(p->remote_ethernet, (char *)(skb->mac.ethernet->h_source), ETH_ALEN);
+	}
+
+	if ((p->local_iface = (char *)kmalloc(sizeof(unsigned char)*strlen(skb->dev->name),GFP_ATOMIC)) == NULL)
+	{
+		printk(KERN_CRIT "CDP: Could not allocate memory for neighbor member.\n");
+		kfree(p->remote_ethernet);
+		return NULL;
+	} else {
+		strncpy(p->local_iface,(char *)(skb->dev->name),IFNAMSIZ);
+	}
+
+	/* only go while we're at less than the tail value - we can't actually go equal
+		to it, since we must have at least 4 bytes left for our type and length fields */
+
+	while(skb->data < skb->tail)
+	{
+		type = 0;
+		length = 0;
+
+		memcpy(&type, (skb->data)++, 2); (skb->data)++;
+		memcpy(&length, (skb->data)++, 2); (skb->data)++;
+		/* make sure the byte order is right */
+		type = ntohs(type);
+		length = (ntohs(length)-4); /* length includes the type field and length field
+							for some reason */
+
+		data = (unsigned char *)kmalloc(sizeof(unsigned char)*length,GFP_ATOMIC);
+		memcpy(data, (skb->data), length);
+
+		/* jump to the end of this piece of data */
+		skb->data += length;
+
+		#ifdef CONFIG_CDP_DEBUG
+		printk(KERN_DEBUG "CDP: Data Type = %.4X\n",type);
+		printk(KERN_DEBUG "CDP: Data Length = %d bytes\n",length);
+		#endif
+
+		/* process the data */
+		switch (type)
+		{
+			case CDP_TYPE_IPPREFIX:
+				/* FIXME Need to work out how the prefix is stored */
+
+			break;
+
+			case CDP_TYPE_PLATFORM:
+				p->cdp_platform = (char *)kmalloc(sizeof(char)*length+1,GFP_ATOMIC);
+				memcpy(p->cdp_platform, data, length);
+				*(p->cdp_platform+length) = '\000';
+			break;
+
+			case CDP_TYPE_VERSION:
+				p->cdp_neighbor_sw_ver = (char *)kmalloc(sizeof(char)*length+1,GFP_ATOMIC);
+				memcpy(p->cdp_neighbor_sw_ver, data, length);
+				*(p->cdp_neighbor_sw_ver+length) = '\000';
+			break;
+
+			case CDP_TYPE_CAPABILITIES:
+
+				memcpy(&(p->cdp_capab_mask), data, length);
+				p->cdp_capab_mask = ntohl(p->cdp_capab_mask);
+
+				#ifdef CONFIG_CDP_DEBUG
+				printk(KERN_DEBUG "CDP: Capab Mask = %.8X\n",p->cdp_capab_mask);
+				#endif
+
+				if ((p->cdp_capab_mask & CDP_CAPABILITY_L3R) == CDP_CAPABILITY_L3R)
+					len += sprintf(buf+len, "R");
+				if ((p->cdp_capab_mask & CDP_CAPABILITY_L2TB) == CDP_CAPABILITY_L2TB)
+					len += sprintf(buf+len, "T");
+				if ((p->cdp_capab_mask & CDP_CAPABILITY_L2SRB) == CDP_CAPABILITY_L2SRB)
+					len += sprintf(buf+len, "B");
+				if ((p->cdp_capab_mask & CDP_CAPABILITY_L2SW) == CDP_CAPABILITY_L2SW)
+					len += sprintf(buf+len, "S");
+				if ((p->cdp_capab_mask & CDP_CAPABILITY_L3TXRX) == CDP_CAPABILITY_L3TXRX)
+					len += sprintf(buf+len, "r");
+				if ((p->cdp_capab_mask & CDP_CAPABILITY_IGRPFW) == CDP_CAPABILITY_IGRPFW)
+					len += sprintf(buf+len, "I");
+				if ((p->cdp_capab_mask & CDP_CAPABILITY_L1) == CDP_CAPABILITY_L1)
+					len += sprintf(buf+len, "H");
+
+				memcpy(p->cdp_capabitlities, buf, len);
+				*(p->cdp_capabitlities+len) = '\000';
+			break;
+
+			case CDP_TYPE_PORTID:
+				p->cdp_portID = (char *)kmalloc(sizeof(char)*length+1,GFP_ATOMIC);
+				memcpy(p->cdp_portID, data, length);
+				*(p->cdp_portID+length) = '\000';
+			break;
+
+			case CDP_TYPE_ADDRESS:
+				/* FIXME Need to check which byteorder the address is in */
+			break;
+
+			case CDP_TYPE_DEVICEID:
+				p->cdp_neighbor_id = (char *)kmalloc(sizeof(char)*length+1,GFP_ATOMIC);
+				memcpy(p->cdp_neighbor_id, data, length);
+				*(p->cdp_neighbor_id+length) = '\000';
+			break;
+
+			default:
+				/* do nothing if we don't know what type it is */
+				#ifdef CONFIG_CDP_DEBUG
+				printk(KERN_DEBUG "CDP: Unknown type 0x%.4X\n",type);
+				#endif
+			break;
+		}
+
+		/* blast it */
+		kfree(data);
+
+		/* we must have at least 4 bytes left, if we don't, just skip out */
+		if ((skb->tail - skb->data) < 4)
+			break;
+	}
+
+	#ifdef CONFIG_CDP_DEBUG
+	printk(KERN_DEBUG "CDP: Version = %i\n",p->cdp_version);
+	printk(KERN_DEBUG "CDP: TTL = %i\n",p->cdp_ttl);
+	printk(KERN_DEBUG "CDP: Checksum = 0x%.4X\n",p->cdp_checksum);
+	#endif
+
+return 1;
+}
+
+void cdp_init_neighbor(struct s_cdp_neighbor *p)
+{
+	/* itialise all the memebers, in case no value is assigned */
+	p->remote_ethernet = "";
+	p->local_iface = "";
+	p->cdp_version = 1;		/* the CDP definition says version is always 1 */
+	p->cdp_ttl = 128;		/* a default TTL so it will timeout */
+	p->cdp_addresss.s_addr = 0;
+	p->cdp_neighbor_sw_ver = "";
+	p->cdp_neighbor_id = "";
+	p->cdp_capabitlities = "";
+	p->cdp_capab_mask = 0;
+	p->cdp_platform = "";
+	p->cdp_portID = "";
+	p->next = p->prev = NULL;
+}
+
+struct s_cdp_neighbor *cdp_add_neighbor(struct sk_buff *skb)
+{
+
+	struct s_cdp_neighbor *p;
+
+	if ((p = (struct s_cdp_neighbor *)kmalloc(sizeof(struct s_cdp_neighbor),GFP_ATOMIC)) == NULL)
+	{
+		printk(KERN_CRIT "CDP: Can not allocate memory for new neighbor.\n");
+		return NULL;
+	} else {
+		#ifdef CONFIG_CDP_DEBUG
+		printk(KERN_DEBUG "CDP: Allocated new neighbor at memory ref: 0x%X\n",p);
+		#endif
+
+		/* init all the fields so they have some data */
+		cdp_init_neighbor(p);
+
+		/* Try and assign values, if we can't blow the struct away */
+		if (!cdp_update_neighbor(skb,p))
+		{
+			kfree(p);
+			return NULL;
+		}
+
+		if (cdp_neighbors.head == NULL)
+		{
+			cdp_neighbors.foot = cdp_neighbors.head = p;
+		} else {
+			p->prev = cdp_neighbors.foot;
+			cdp_neighbors.foot->next = p;
+			cdp_neighbors.foot = p;
+		}
+	}
+
+	return p;
+}
+
+/* proc fs functions */
+int cdp_get_neighbor_info(char *buffer, char **start, off_t offset, int length)
+{
+	struct s_cdp_neighbor *p = cdp_neighbors.head;
+	int len=0;
+	off_t pos=0;
+	off_t begin=0;
+
+	len += sprintf(buffer,"Device ID\t\tLocal Intrfce\tHoldtme\tCapability\tPlatform\tPort ID\n");
+
+	cli();
+
+	while (p != NULL)
+	{
+		len += sprintf(buffer+len, "%s\t%s\t%d\t%s\t%s\t%s\n",p->cdp_neighbor_id,p->local_iface,p->cdp_ttl,p->cdp_capabitlities,p->cdp_platform,p->cdp_portID);
+
+		p = p->next;
+
+		pos=begin+len;
+		if(pos<offset)
+		{
+			len=0;
+			begin=pos;
+		}
+		if(pos>offset+length)
+			break;
+	}
+
+	sti();
+
+	*start=buffer+(offset-begin);
+	len-=(offset-begin);
+	if(len>length)
+		len=length;
+
+	return len;
+}
+
+/* network functions */
+
+/* deletes timed out neighbor entries (ie TTL expired) */
+static void SMP_TIMER_NAME(cdp_check_expire)(unsigned long unused)
+{
+	unsigned long now = jiffies;
+
+	mod_timer(&cdp_poll_neighbors_timer, now + CDP_POLL);
+}
+SMP_TIMER_DEFINE(cdp_check_expire, cdp_expire_task);
+
+/* announce to anyone who is listening (ie, Cisco kit) what we are */
+static void SMP_TIMER_NAME(cdp_send_update)(unsigned long unused)
+{
+	unsigned long now = jiffies;
+	unsigned int len = 0;
+	char *buf = "";
+
+	/*
+	 * XXX How do we check for capabilities?
+	 *
+	 * L2 Switching: CONFIG_DGRS
+	 * L2 SRB: CONFIG_NET_FASTROUTE
+	 * L3 Routing: CONFIG_WAN_ROUTER, CONFIG_IP_ADVANCED_ROUTER, CONFIG_IP_MROUTE
+	 * L3 RX/TX: !CONFIG_IP_ADVANCED_ROUTER & CONFIG_INET, CONFIG_IPX, CONFIG_SPX
+	 *
+	 * As far as I know, Linux doesn't do any of the other capabilities.
+	 *
+	 * I'm assuming that unless Advanced Router is enabled, we're not routing TCP/IP,
+	 * this isn't technicaly true, but it's good enough - people using a linux box as
+	 * a router are probably going to have it enabled.
+	 *
+	 * Can the kernel route IPX packets?
+	*/
+
+	mod_timer(&cdp_tx_data_timer, now + CDP_TXTIME);
+}
+SMP_TIMER_DEFINE(cdp_send_update, cdp_update_task);
+
+/* function triggered by arriving CDP packets, as determined by the SNAP ID */
+int cdp_rcv(struct sk_buff *skb, struct net_device *dev, struct packet_type *pt)
+{
+
+	struct s_cdp_neighbor *p = NULL;
+
+	#ifdef CONFIG_CDP_DEBUG
+	printk(KERN_DEBUG "CDP: Packet from %.2X:%.2X:%.2X:%.2X:%.2X:%.2X\n",
+		skb->mac.ethernet->h_source[0],
+		skb->mac.ethernet->h_source[1],
+		skb->mac.ethernet->h_source[2],
+		skb->mac.ethernet->h_source[3],
+		skb->mac.ethernet->h_source[4],
+		skb->mac.ethernet->h_source[5]
+		);
+	#endif
+
+	p = cdp_find_neighbor(skb->mac.ethernet->h_source);
+
+	if ( p == NULL)
+	{
+		#ifdef CONFIG_CDP_DEBUG
+		printk(KERN_DEBUG "CDP: Creating new neighbor.\n");
+		#endif
+		cdp_add_neighbor(skb);
+	}
+	else
+	{
+		#ifdef CONFIG_CDP_DEBUG
+		printk(KERN_DEBUG "CDP: Updating existing neighbor at memory ref: 0x%X\n",p);
+		#endif
+		cdp_update_neighbor(skb,p);
+	}
+
+	/* we're done with the packet now */
+//	kfree_skb(skb);
+
+return 0;
+}
+
+/* init/exit/module functions/globals */
+
+static struct datalink_proto *pSNAP_datalink;
+static unsigned char cdp_snap_id[5] = { 0x0, 0x0, 0x0c, 0x20, 0x00 };
+static const char banner[] __initdata =
+	KERN_INFO "CDP: Linux Cisco Discovery Protocol 0.0.1\n"
+	KERN_INFO "CDP: Portions Copyright (c) 2001 Chris Crowther\n";
+
+static int __init cdp_init(void)
+{
+	pSNAP_datalink = register_snap_client(cdp_snap_id, cdp_rcv);
+	if (!pSNAP_datalink)
+	{
+		printk(KERN_CRIT "CDP: Unable to register with SNAP\n");
+		return 0;
+	}
+	/* initialise the neighbors linked list */
+	cdp_neighbors.head = cdp_neighbors.foot = NULL;
+
+	/* initialise + register timers */
+	cdp_poll_neighbors_timer.function = cdp_check_expire;
+	cdp_tx_data_timer.function = cdp_send_update;
+
+	cdp_poll_neighbors_timer.expires = jiffies + CDP_POLL;
+	cdp_tx_data_timer.expires = jiffies + CDP_POLL;
+
+	add_timer(&cdp_poll_neighbors_timer);
+	add_timer(&cdp_tx_data_timer);
+
+	/* create /proc/net entry, if proc fs is enabled */
+#ifdef CONFIG_PROC_FS
+        proc_net_create("cdp_neighbors", 0, cdp_get_neighbor_info);
+#endif
+	printk(banner);
+	return 0;
+}
+
+module_init(cdp_init);
+
+static void __exit cdp_bibi(void)
+{
+
+	struct s_cdp_neighbor *p = cdp_neighbors.head;
+
+	proc_net_remove("cdp_neighbors");
+
+	unregister_snap_client(cdp_snap_id);
+	pSNAP_datalink = NULL;
+
+	/* remove timers */
+	del_timer(&cdp_poll_neighbors_timer);
+	del_timer(&cdp_tx_data_timer);
+
+	/* Unallocate all the neighbor entries */
+	while(p!=NULL)
+	{
+		cdp_delete_neighbor(p);
+		p = cdp_neighbors.head;
+	}
+
+	cdp_neighbors.foot = cdp_neighbors.head = NULL;
+
+	printk(KERN_INFO "CDP: Exiting\n");
+}
+
+module_exit(cdp_bibi);
+

-- 
Chris "_Shad0w_" Crowther
shad0w@shad0w.org.uk
http://www.shad0w.org.uk/

