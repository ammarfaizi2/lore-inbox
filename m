Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274064AbRJJCTv>; Tue, 9 Oct 2001 22:19:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274162AbRJJCTn>; Tue, 9 Oct 2001 22:19:43 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:19190 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S274064AbRJJCTf>;
	Tue, 9 Oct 2001 22:19:35 -0400
Date: Tue, 9 Oct 2001 19:19:59 -0700
To: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: RFC : Wireless Netlink events
Message-ID: <20011009191959.B16952@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
In-Reply-To: <20011009184700.B16874@bougret.hpl.hp.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="4Ckj6UjgE2iN1+kY"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011009184700.B16874@bougret.hpl.hp.com>; from jt on Tue, Oct 09, 2001 at 06:47:00PM -0700
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 09, 2001 at 06:47:00PM -0700, jt wrote:
> 	Hi,
> 
> 	Somebody asked me if it was possible to monitor wireless
> configuration change on 802.11 interfaces.
> 	Looking into the kernel, I noticed that RTnetlink was the
> prefered way to export events related to interface changes. So, I
> quickly hacked some RTnetlink Wireless Events, and it basically work
> the way I want.
> 
> 	Now, I've got some questions :
> 	o Have I done it the right way ? Is there anything I forgot ?
> 	o Is there a way to do a reverse of SIOCGIFINDEX ? If you have
> an interface index, how do you get its name ?
> 	o Should I put the full interface name in the event ? That
> would make events larger but help query the interface when receiving
> the event.
> 	o Any other comments ?
> 
> 	My plan is to continue experimenting with this patch a few
> days and collect comments, and then do a new update of Wireless
> Extensions with this patch.
> 	Regards,
> 
> 	Jean

	I'll probably get more comments if I attach the patch, isn't
it ?

	Jean

--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="wireless_netlink.diff"

diff -u -p linux/include/linux/wireless.w12.h linux/include/linux/wireless.h
--- linux/include/linux/wireless.w12.h	Tue Oct  9 16:17:40 2001
+++ linux/include/linux/wireless.h	Tue Oct  9 18:20:26 2001
@@ -567,4 +567,27 @@ struct	iw_priv_args
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
+ * Apart from the generic stuff, we just pass the IOCTL number of
+ * the command triggering the event. The user can then just query
+ * (the same IOCTL | 0x1) to get the new state of the interface...
+ * This way, we can keep our events short and efficients...
+ */
+struct iwinfomsg
+{
+	__u8		ifi_family;
+	__u8		__ifi_pad;
+	__u16		ifi_type;		/* ARPHRD_* */
+	__s32		ifi_index;		/* Link index	*/
+	__u32		iwi_command;		/* Wireless IOCTL */
+	/* Maybe I should add 'char name[IFNAMSIZ]' around here... */
+};
+
 #endif	/* _LINUX_WIRELESS_H */
diff -u -p linux/include/linux/rtnetlink.w12.h linux/include/linux/rtnetlink.h
--- linux/include/linux/rtnetlink.w12.h	Tue Oct  9 17:14:51 2001
+++ linux/include/linux/rtnetlink.h	Tue Oct  9 17:15:47 2001
@@ -46,7 +46,10 @@
 #define	RTM_DELTFILTER	(RTM_BASE+29)
 #define	RTM_GETTFILTER	(RTM_BASE+30)
 
-#define	RTM_MAX		(RTM_BASE+31)
+/* Reconfiguration of a Wireless Interface - see wireless.h - Jean II */
+#define RTM_SETWIRELESS	(RTM_BASE+32)
+
+#define	RTM_MAX		(RTM_BASE+33)
 
 /* 
    Generic structure for encapsulation optional route information.
@@ -568,9 +571,14 @@ extern void __rta_fill(struct sk_buff *s
 
 extern void rtmsg_ifinfo(int type, struct net_device *dev, unsigned change);
 
+#if defined(CONFIG_NET_RADIO) || defined(CONFIG_NET_PCMCIA_RADIO)
+extern void rtmsg_iwinfo(int type, struct net_device *dev, unsigned command);
+#endif	/* CONFIG_NET_RADIO || CONFIG_NET_PCMCIA_RADIO */
+
 #else
 
 #define rtmsg_ifinfo(a,b,c) do { } while (0)
+#define rtmsg_iwinfo(a,b,c) do { } while (0)
 
 #endif
 
diff -u -p linux/net/core/dev.w12.c linux/net/core/dev.c
--- linux/net/core/dev.w12.c	Tue Oct  9 16:18:44 2001
+++ linux/net/core/dev.c	Tue Oct  9 17:33:31 2001
@@ -2242,7 +2242,20 @@ static int dev_ifsioc(struct ifreq *ifr,
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
+					    (cmd == SIOCSIWFREQ))) {
+						rtmsg_iwinfo(RTM_SETWIRELESS,
+							     dev, cmd);
+					}
+					return err;
 				}
 				return -EOPNOTSUPP;
 			}
diff -u -p linux/net/core/rtnetlink.w12.c linux/net/core/rtnetlink.c
--- linux/net/core/rtnetlink.w12.c	Tue Oct  9 16:18:54 2001
+++ linux/net/core/rtnetlink.c	Tue Oct  9 17:40:03 2001
@@ -49,6 +49,9 @@
 #include <net/udp.h>
 #include <net/sock.h>
 #include <net/pkt_sched.h>
+#if defined(CONFIG_NET_RADIO) || defined(CONFIG_NET_PCMCIA_RADIO)
+#include <linux/wireless.h>		/* Note : will define WIRELESS_EXT */
+#endif	/* CONFIG_NET_RADIO || CONFIG_NET_PCMCIA_RADIO */
 
 DECLARE_MUTEX(rtnl_sem);
 
@@ -266,6 +269,37 @@ void rtmsg_ifinfo(int type, struct net_d
 	NETLINK_CB(skb).dst_groups = RTMGRP_LINK;
 	netlink_broadcast(rtnl, skb, 0, RTMGRP_LINK, GFP_KERNEL);
 }
+
+#ifdef WIRELESS_EXT
+void rtmsg_iwinfo(int type, struct net_device *dev, unsigned command)
+{
+	struct sk_buff *skb;
+	int size = NLMSG_GOODSIZE;
+	struct iwinfomsg *r;	/* Defined in wireless.h */
+	struct nlmsghdr  *nlh;
+
+	skb = alloc_skb(size, GFP_KERNEL);
+	if (!skb)
+		return;
+
+	/* Set up our event */
+	nlh = NLMSG_PUT(skb, 0, 0, type, sizeof(*r));
+	r = NLMSG_DATA(nlh);
+	r->ifi_family = AF_UNSPEC;
+	r->ifi_type = dev->type;
+	r->ifi_index = dev->ifindex;
+	r->iwi_command = command;
+
+	/* Send it to all listeners */
+	NETLINK_CB(skb).dst_groups = RTMGRP_LINK;
+	netlink_broadcast(rtnl, skb, 0, RTMGRP_LINK, GFP_KERNEL);
+
+	return;
+nlmsg_failure:
+	kfree_skb(skb);
+	return;
+}
+#endif	/* WIRELESS_EXT */
 
 static int rtnetlink_done(struct netlink_callback *cb)
 {

--4Ckj6UjgE2iN1+kY--
