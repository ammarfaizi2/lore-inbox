Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277559AbRJKA0H>; Wed, 10 Oct 2001 20:26:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277560AbRJKAZ6>; Wed, 10 Oct 2001 20:25:58 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:52443 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S277559AbRJKAZw>;
	Wed, 10 Oct 2001 20:25:52 -0400
Date: Wed, 10 Oct 2001 17:26:15 -0700
To: kuznet@ms2.inr.ac.ru
Cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
Subject: Re: RFC : Wireless Netlink events
Message-ID: <20011010172615.B18055@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
In-Reply-To: <20011010111404.D17439@bougret.hpl.hp.com> <200110101848.WAA05322@ms2.inr.ac.ru>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="tThc/1wpZn/ma/RB"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200110101848.WAA05322@ms2.inr.ac.ru>; from kuznet@ms2.inr.ac.ru on Wed, Oct 10, 2001 at 10:48:22PM +0400
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 10, 2001 at 10:48:22PM +0400, kuznet@ms2.inr.ac.ru wrote:
> Hello!

	Second try...
	I'm now using RTM_NEWLINK and pass the full and complete
wireless event in a RTA structure (therefore, there is no need to
query the ioctl after the event).
	Ready for more comments...

	Jean

--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="wireless_netlink-2.diff"

diff -u -p linux/include/linux/wireless.w12.h linux/include/linux/wireless.h
--- linux/include/linux/wireless.w12.h	Tue Oct  9 16:17:40 2001
+++ linux/include/linux/wireless.h	Wed Oct 10 15:16:04 2001
@@ -567,4 +567,21 @@ struct	iw_priv_args
 	char		name[IFNAMSIZ];	/* Name of the extension */
 };
 
+/* ---------------------- RTNETLINK SUPPORT ---------------------- */
+/*
+ * RTnetlink (or routing socket) is a raw socket where a user app can
+ * listen to various selected events from the netowrking layer.
+ */
+
+/*
+ * This is how a Wireless Event will appear on this socket...
+ * This will be an optional field (RTA) of the NEWLINK message
+ */
+struct rta_ifla_wireless
+{
+	__u32		command;		/* Wireless IOCTL */
+	struct	iwreq	data;			/* IOCTL fixed payload */
+	char		option[0];		/* Optional data */
+};
+
 #endif	/* _LINUX_WIRELESS_H */
diff -u -p linux/include/linux/rtnetlink.w12.h linux/include/linux/rtnetlink.h
--- linux/include/linux/rtnetlink.w12.h	Tue Oct  9 17:14:51 2001
+++ linux/include/linux/rtnetlink.h	Wed Oct 10 16:17:51 2001
@@ -440,12 +440,14 @@ enum
 #define IFLA_COST IFLA_COST
 	IFLA_PRIORITY,
 #define IFLA_PRIORITY IFLA_PRIORITY
-	IFLA_MASTER
+	IFLA_MASTER,
 #define IFLA_MASTER IFLA_MASTER
+	IFLA_WIRELESS		/* Wireless Extension event - see wireless.h */
+#define IFLA_WIRELESS IFLA_WIRELESS
 };
 
 
-#define IFLA_MAX IFLA_MASTER
+#define IFLA_MAX IFLA_WIRELESS
 
 #define IFLA_RTA(r)  ((struct rtattr*)(((char*)(r)) + NLMSG_ALIGN(sizeof(struct ifinfomsg))))
 #define IFLA_PAYLOAD(n) NLMSG_PAYLOAD(n,sizeof(struct ifinfomsg))
@@ -568,9 +570,15 @@ extern void __rta_fill(struct sk_buff *s
 
 extern void rtmsg_ifinfo(int type, struct net_device *dev, unsigned change);
 
+#if defined(CONFIG_NET_RADIO) || defined(CONFIG_NET_PCMCIA_RADIO)
+extern void rtmsg_iwinfo(int type, struct net_device *dev,  struct ifreq *ifr,
+			 unsigned command);
+#endif	/* CONFIG_NET_RADIO || CONFIG_NET_PCMCIA_RADIO */
+
 #else
 
 #define rtmsg_ifinfo(a,b,c) do { } while (0)
+#define rtmsg_iwinfo(a,b,c) do { } while (0)
 
 #endif
 
diff -u -p linux/net/core/dev.w12.c linux/net/core/dev.c
--- linux/net/core/dev.w12.c	Tue Oct  9 16:18:44 2001
+++ linux/net/core/dev.c	Wed Oct 10 15:22:33 2001
@@ -2242,7 +2242,21 @@ static int dev_ifsioc(struct ifreq *ifr,
 				if (dev->do_ioctl) {
 					if (!netif_device_present(dev))
 						return -ENODEV;
-					return dev->do_ioctl(dev, ifr, cmd);
+					/* Ask the driver to do its job */
+					err = dev->do_ioctl(dev, ifr, cmd);
+					/* If the device is up, we generate
+					 * a Wireless RTnetlink event on a few
+					 * interesting configuration change */
+					if((!err) && (dev->flags & IFF_UP) &&
+					   ((cmd == SIOCSIWNWID) ||
+					    (cmd == SIOCSIWESSID) || 
+					    (cmd == SIOCSIWMODE) || 
+					    (cmd == SIOCSIWFREQ) ||
+					    (cmd == SIOCSIWENCODE))) {
+						rtmsg_iwinfo(RTM_NEWLINK,
+							     dev, ifr, cmd);
+					}
+					return err;
 				}
 				return -EOPNOTSUPP;
 			}
diff -u -p linux/net/core/rtnetlink.w12.c linux/net/core/rtnetlink.c
--- linux/net/core/rtnetlink.w12.c	Tue Oct  9 16:18:54 2001
+++ linux/net/core/rtnetlink.c	Wed Oct 10 16:41:27 2001
@@ -49,6 +49,9 @@
 #include <net/udp.h>
 #include <net/sock.h>
 #include <net/pkt_sched.h>
+#if defined(CONFIG_NET_RADIO) || defined(CONFIG_NET_PCMCIA_RADIO)
+#include <linux/wireless.h>		/* Note : will define WIRELESS_EXT */
+#endif	/* CONFIG_NET_RADIO || CONFIG_NET_PCMCIA_RADIO */
 
 DECLARE_MUTEX(rtnl_sem);
 
@@ -266,6 +269,97 @@ void rtmsg_ifinfo(int type, struct net_d
 	NETLINK_CB(skb).dst_groups = RTMGRP_LINK;
 	netlink_broadcast(rtnl, skb, 0, RTMGRP_LINK, GFP_KERNEL);
 }
+
+#ifdef WIRELESS_EXT
+static int rtnetlink_fill_iwinfo(struct sk_buff *skb, struct net_device *dev,
+				 int type, struct iwreq *iwr, unsigned command)
+{
+	struct ifinfomsg *r;
+	struct nlmsghdr  *nlh;
+	unsigned char	 *b = skb->tail;
+	int		  option_size = 0;	/* Size of optional data */
+	struct rta_ifla_wireless *event = NULL;	/* Mallocated whole event */
+
+	nlh = NLMSG_PUT(skb, 0, 0, type, sizeof(*r));
+	r = NLMSG_DATA(nlh);
+	r->ifi_family = AF_UNSPEC;
+	r->ifi_type = dev->type;
+	r->ifi_index = dev->ifindex;
+	r->ifi_flags = dev->flags;
+	r->ifi_change = 0;	/* Wireless changes don't affect those flags */
+
+	/* Get the size of optional data */
+	switch(command) {
+	case SIOCSIWESSID:
+		option_size = IW_ESSID_MAX_SIZE + 1;
+		break;
+	case SIOCSIWENCODE:
+		/* Security : we never propagate the key to user space,
+		 * on the other hand we propagate the flags in iwr */
+		option_size = 0;
+		break;
+	default:
+		/* No optional data, everything is in iwr */
+		option_size = 0;
+		break;
+	}
+
+	/* Reduce option_size to what's really needed */
+	if((option_size != 0) && (iwr->u.data.pointer != 0) &&
+	   (iwr->u.data.length <= option_size))
+		option_size = iwr->u.data.length;
+	else
+		option_size = 0;	/* Invalid -> ignore */
+
+	/* Create temporary buffer to hold the event */
+	event = kmalloc(sizeof(struct rta_ifla_wireless) + option_size,
+			GFP_KERNEL);
+
+	/* Fill event */
+	event->command = command;
+	memcpy(&event->data, iwr, sizeof(struct iwreq));
+	if(option_size != 0)
+		if (copy_from_user(event->option, iwr->u.data.pointer,
+				   option_size))
+			/* Should not happen because the driver accepted it */
+			goto rtattr_failure;
+
+	/* Add it in the netlink packet */
+	RTA_PUT(skb, IFLA_WIRELESS,
+		sizeof(struct rta_ifla_wireless) + option_size, event);
+	/* Cleanup */
+	kfree(event);
+
+	nlh->nlmsg_len = skb->tail - b;
+	return skb->len;
+
+nlmsg_failure:
+rtattr_failure:
+	if(event != NULL)
+		kfree(event);
+	skb_trim(skb, b - skb->data);
+	return -1;
+}
+
+void rtmsg_iwinfo(int type, struct net_device *dev, struct ifreq *ifr,
+		  unsigned command)
+{
+	struct sk_buff *skb;
+	int size = NLMSG_GOODSIZE;
+
+	skb = alloc_skb(size, GFP_KERNEL);
+	if (!skb)
+		return;
+
+	if (rtnetlink_fill_iwinfo(skb, dev, type,
+				  (struct iwreq *) ifr, command) < 0) {
+		kfree_skb(skb);
+		return;
+	}
+	NETLINK_CB(skb).dst_groups = RTMGRP_LINK;
+	netlink_broadcast(rtnl, skb, 0, RTMGRP_LINK, GFP_KERNEL);
+}
+#endif	/* WIRELESS_EXT */
 
 static int rtnetlink_done(struct netlink_callback *cb)
 {

--tThc/1wpZn/ma/RB--
