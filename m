Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266999AbTAFPo2>; Mon, 6 Jan 2003 10:44:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267003AbTAFPo2>; Mon, 6 Jan 2003 10:44:28 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:14371 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id <S266999AbTAFPoX>; Mon, 6 Jan 2003 10:44:23 -0500
To: davem@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] increase MAX_ADDR_LEN (resend)
References: <521y5qn7l5.fsf@topspin.com>
	<1037116836.8500.55.camel@irongate.swansea.linux.org.uk>
	<52adkele4l.fsf@topspin.com>
	<20021112.143143.100089039.davem@redhat.com>
	<52wumpbpql.fsf@topspin.com> <20021204201138.GA29792@averell>
	<52lm25ss0s.fsf@topspin.com>
X-Message-Flag: Warning: May contain useful information
X-Priority: 1
X-MSMail-Priority: High
From: Roland Dreier <roland@topspin.com>
Date: 06 Jan 2003 07:52:57 -0800
In-Reply-To: <52lm25ss0s.fsf@topspin.com>
Message-ID: <52isx2p95y.fsf_-_@topspin.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 06 Jan 2003 15:52:41.0703 (UTC) FILETIME=[A543AF70:01C2B59B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, I think this got lost in your inbox over New Year's (I send it
December 31), so I'm resending.

The patch included below is intended to increase MAX_ADDR_LEN to 32,
which will make adding IP-over-InfiniBand support much simpler.

I included the rtnetlink-based support for big hardware adresses that
we discussed earlier.  Specifically, the patch:

  1. Adds ARPHRD_INFINIBAND to if_arp.h.  This is extremely minor, but
     will make an IP-over-InfiniBand driver cleaner.

  2. Increases MAX_ADDR_LEN to 32 (from 8).

  3. Makes some small changes to net/core/dev.c to prevent the
     increased MAX_ADDR_LEN from overflowing when the SIOCGIFHWADDR
     and SIOCSIFHWADDR ioctls are used on interfaces with addr_len >
     14 (the size of sa_data in struct sockaddr).

  4. Adds RTM_SETLINK to <linux/rtnetlink.h> and adds a function
     do_setlink() to net/core/rtnetlink.c to handle this message from
     userspace.  This lets userspace set the hardware address and
     broadcast address for interfaces with addr_len > 14.

  5. Cleans up the initializer for link_rtnetlink_table[] so that it
     is much easier to read and change.

There is some suspicious-looking use of MAX_ADDR_LEN in
drivers/net/sungem.c and drivers/s390/net/lcs.c but I did not touch
those files in this patch.

This patch was created and tested with UML on kernel 2.5.47, but
applies cleanly to Linus's current 2.5.53-BK (with a few offsets).

Please apply this patch or let me know what needs to change for it to
be applied.

Thanks,
  Roland <roland@topspin.com>



diff -Naur linux-2.5.47/include/linux/if_arp.h linux-2.5.47-max-addr/include/linux/if_arp.h
--- linux-2.5.47/include/linux/if_arp.h	Sun Nov 10 19:28:29 2002
+++ linux-2.5.47-max-addr/include/linux/if_arp.h	Mon Dec 30 13:50:07 2002
@@ -40,6 +40,7 @@
 #define ARPHRD_METRICOM	23		/* Metricom STRIP (new IANA id)	*/
 #define	ARPHRD_IEEE1394	24		/* IEEE 1394 IPv4 - RFC 2734	*/
 #define ARPHRD_EUI64	27		/* EUI-64                       */
+#define ARPHRD_INFINIBAND 32		/* InfiniBand			*/
 
 /* Dummy types for non ARP hardware */
 #define ARPHRD_SLIP	256
diff -Naur linux-2.5.47/include/linux/netdevice.h linux-2.5.47-max-addr/include/linux/netdevice.h
--- linux-2.5.47/include/linux/netdevice.h	Sun Nov 10 19:28:31 2002
+++ linux-2.5.47-max-addr/include/linux/netdevice.h	Mon Dec 30 12:05:42 2002
@@ -65,7 +65,7 @@
 
 #endif
 
-#define MAX_ADDR_LEN	8		/* Largest hardware address length */
+#define MAX_ADDR_LEN	32		/* Largest hardware address length */
 
 /*
  *	Compute the worst case header length according to the protocols
diff -Naur linux-2.5.47/include/linux/rtnetlink.h linux-2.5.47-max-addr/include/linux/rtnetlink.h
--- linux-2.5.47/include/linux/rtnetlink.h	Sun Nov 10 19:28:29 2002
+++ linux-2.5.47-max-addr/include/linux/rtnetlink.h	Tue Dec 31 14:38:13 2002
@@ -17,6 +17,7 @@
 #define	RTM_NEWLINK	(RTM_BASE+0)
 #define	RTM_DELLINK	(RTM_BASE+1)
 #define	RTM_GETLINK	(RTM_BASE+2)
+#define	RTM_SETLINK	(RTM_BASE+3)
 
 #define	RTM_NEWADDR	(RTM_BASE+4)
 #define	RTM_DELADDR	(RTM_BASE+5)
diff -Naur linux-2.5.47/net/core/dev.c linux-2.5.47-max-addr/net/core/dev.c
--- linux-2.5.47/net/core/dev.c	Sun Nov 10 19:28:16 2002
+++ linux-2.5.47-max-addr/net/core/dev.c	Mon Dec 30 12:06:06 2002
@@ -2062,7 +2062,7 @@
 
 		case SIOCGIFHWADDR:
 			memcpy(ifr->ifr_hwaddr.sa_data, dev->dev_addr,
-			       MAX_ADDR_LEN);
+			       min(sizeof ifr->ifr_hwaddr.sa_data, (size_t) dev->addr_len));
 			ifr->ifr_hwaddr.sa_family = dev->type;
 			return 0;
 
@@ -2083,7 +2083,7 @@
 			if (ifr->ifr_hwaddr.sa_family != dev->type)
 				return -EINVAL;
 			memcpy(dev->broadcast, ifr->ifr_hwaddr.sa_data,
-			       MAX_ADDR_LEN);
+			       min(sizeof ifr->ifr_hwaddr.sa_data, (size_t) dev->addr_len));
 			notifier_call_chain(&netdev_chain,
 					    NETDEV_CHANGEADDR, dev);
 			return 0;
diff -Naur linux-2.5.47/net/core/rtnetlink.c linux-2.5.47-max-addr/net/core/rtnetlink.c
--- linux-2.5.47/net/core/rtnetlink.c	Sun Nov 10 19:28:33 2002
+++ linux-2.5.47-max-addr/net/core/rtnetlink.c	Tue Dec 31 14:38:50 2002
@@ -220,6 +220,40 @@
 	return skb->len;
 }
 
+static int do_setlink(struct sk_buff *skb, struct nlmsghdr *nlh, void *arg) {
+	struct ifinfomsg  *ifm = NLMSG_DATA(nlh);
+	struct rtattr    **ida = arg;
+	struct net_device *dev;
+	int err;
+
+	dev = dev_get_by_index(ifm->ifi_index);
+	if (!dev) {
+		return -ENODEV;
+	}
+
+	err = -EINVAL;
+
+	if (ida[IFLA_ADDRESS - 1]) {
+		if (ida[IFLA_ADDRESS - 1]->rta_len != RTA_LENGTH(dev->addr_len)) {
+			goto out;
+		}
+		memcpy(dev->dev_addr, RTA_DATA(ida[IFLA_ADDRESS - 1]), dev->addr_len);
+	}
+
+	if (ida[IFLA_BROADCAST - 1]) {
+		if (ida[IFLA_BROADCAST - 1]->rta_len != RTA_LENGTH(dev->addr_len)) {
+			goto out;
+		}
+		memcpy(dev->broadcast, RTA_DATA(ida[IFLA_BROADCAST - 1]), dev->addr_len);
+	}
+
+	err = 0;
+
+out:
+	dev_put(dev);
+	return err;
+}
+
 int rtnetlink_dump_all(struct sk_buff *skb, struct netlink_callback *cb)
 {
 	int idx;
@@ -457,32 +491,14 @@
 
 static struct rtnetlink_link link_rtnetlink_table[RTM_MAX-RTM_BASE+1] =
 {
-	{ NULL,			NULL,			},
-	{ NULL,			NULL,			},
-	{ NULL,			rtnetlink_dump_ifinfo,	},
-	{ NULL,			NULL,			},
-
-	{ NULL,			NULL,			},
-	{ NULL,			NULL,			},
-	{ NULL,			rtnetlink_dump_all,	},
-	{ NULL,			NULL,			},
-
-	{ NULL,			NULL,			},
-	{ NULL,			NULL,			},
-	{ NULL,			rtnetlink_dump_all,	},
-	{ NULL,			NULL,			},
-
-	{ neigh_add,		NULL,			},
-	{ neigh_delete,		NULL,			},
-	{ NULL,			neigh_dump_info,	},
-	{ NULL,			NULL,			},
-
-	{ NULL,			NULL,			},
-	{ NULL,			NULL,			},
-	{ NULL,			NULL,			},
-	{ NULL,			NULL,			},
+	[RTM_GETLINK  - RTM_BASE] = { .dumpit = rtnetlink_dump_ifinfo },
+	[RTM_SETLINK  - RTM_BASE] = { .doit   = do_setlink	      },
+	[RTM_GETADDR  - RTM_BASE] = { .dumpit = rtnetlink_dump_all    },
+	[RTM_GETROUTE - RTM_BASE] = { .dumpit = rtnetlink_dump_all    },
+	[RTM_NEWNEIGH - RTM_BASE] = { .doit   = neigh_add	      },
+	[RTM_DELNEIGH - RTM_BASE] = { .doit   = neigh_delete	      },
+	[RTM_GETNEIGH - RTM_BASE] = { .dumpit = neigh_dump_info	      }
 };
-
 
 static int rtnetlink_event(struct notifier_block *this, unsigned long event, void *ptr)
 {
