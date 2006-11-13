Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932293AbWKMVEr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932293AbWKMVEr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 16:04:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755352AbWKMVEq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 16:04:46 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:35081 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1755348AbWKMVEU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 16:04:20 -0500
Date: Mon, 13 Nov 2006 22:04:25 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [2.6 patch] the scheduled removal of the frame diverter
Message-ID: <20061113210425.GI22565@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the scheduled removal of the frame diverter.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 Documentation/feature-removal-schedule.txt |   15 
 drivers/net/Space.c                        |    1 
 include/linux/Kbuild                       |    1 
 include/linux/divert.h                     |  132 -----
 include/linux/netdevice.h                  |    6 
 include/linux/sockios.h                    |    4 
 net/Kconfig                                |   27 -
 net/core/Makefile                          |    1 
 net/core/dev.c                             |   20 
 net/core/dv.c                              |  546 ---------------------
 net/core/sysctl_net_core.c                 |   14 
 net/socket.c                               |    6 
 12 files changed, 6 insertions(+), 767 deletions(-)

--- linux-2.6.19-rc5-mm1/Documentation/feature-removal-schedule.txt.old	2006-11-13 18:33:44.000000000 +0100
+++ linux-2.6.19-rc5-mm1/Documentation/feature-removal-schedule.txt	2006-11-13 18:34:12.000000000 +0100
@@ -219,21 +219,6 @@ Who:	Patrick McHardy <kaber@trash.net>
 
 ---------------------------
 
-What:	frame diverter
-When:	November 2006
-Why:	The frame diverter is included in most distribution kernels, but is
-	broken. It does not correctly handle many things:
-	- IPV6
-	- non-linear skb's
-	- network device RCU on removal
-	- input frames not correctly checked for protocol errors
-	It also adds allocation overhead even if not enabled.
-	It is not clear if anyone is still using it.
-Who:	Stephen Hemminger <shemminger@osdl.org>
-
----------------------------
-
-
 What:	PHYSDEVPATH, PHYSDEVBUS, PHYSDEVDRIVER in the uevent environment
 When:	October 2008
 Why:	The stacking of class devices makes these values misleading and
--- linux-2.6.19-rc5-mm1/net/Kconfig.old	2006-11-13 18:30:23.000000000 +0100
+++ linux-2.6.19-rc5-mm1/net/Kconfig	2006-11-13 18:30:34.000000000 +0100
@@ -175,33 +175,6 @@ source "net/ipx/Kconfig"
 source "drivers/net/appletalk/Kconfig"
 source "net/x25/Kconfig"
 source "net/lapb/Kconfig"
-
-config NET_DIVERT
-	bool "Frame Diverter (EXPERIMENTAL)"
-	depends on EXPERIMENTAL && BROKEN
-	---help---
-	  The Frame Diverter allows you to divert packets from the
-	  network, that are not aimed at the interface receiving it (in
-	  promisc. mode). Typically, a Linux box setup as an Ethernet bridge
-	  with the Frames Diverter on, can do some *really* transparent www
-	  caching using a Squid proxy for example.
-
-	  This is very useful when you don't want to change your router's
-	  config (or if you simply don't have access to it).
-
-	  The other possible usages of diverting Ethernet Frames are
-	  numberous:
-	  - reroute smtp traffic to another interface
-	  - traffic-shape certain network streams
-	  - transparently proxy smtp connections
-	  - etc...
-
-	  For more informations, please refer to:
-	  <http://diverter.sourceforge.net/>
-	  <http://perso.wanadoo.fr/magpie/EtherDivert.html>
-
-	  If unsure, say N.
-
 source "net/econet/Kconfig"
 source "net/wanrouter/Kconfig"
 source "net/sched/Kconfig"
--- linux-2.6.19-rc5-mm1/net/core/Makefile.old	2006-11-13 18:33:29.000000000 +0100
+++ linux-2.6.19-rc5-mm1/net/core/Makefile	2006-11-13 18:33:38.000000000 +0100
@@ -12,7 +12,6 @@ obj-y		     += dev.o ethtool.o dev_mcast
 
 obj-$(CONFIG_XFRM) += flow.o
 obj-$(CONFIG_SYSFS) += net-sysfs.o
-obj-$(CONFIG_NET_DIVERT) += dv.o
 obj-$(CONFIG_NET_PKTGEN) += pktgen.o
 obj-$(CONFIG_WIRELESS_EXT) += wireless.o
 obj-$(CONFIG_NETPOLL) += netpoll.o
--- linux-2.6.19-rc5-mm1/include/linux/netdevice.h.old	2006-11-13 18:34:31.000000000 +0100
+++ linux-2.6.19-rc5-mm1/include/linux/netdevice.h	2006-11-13 18:39:13.000000000 +0100
@@ -38,7 +38,6 @@
 #include <linux/percpu.h>
 #include <linux/dmaengine.h>
 
-struct divert_blk;
 struct vlan_group;
 struct ethtool_ops;
 struct netpoll_info;
@@ -515,11 +514,6 @@ struct net_device
 	/* bridge stuff */
 	struct net_bridge_port	*br_port;
 
-#ifdef CONFIG_NET_DIVERT
-	/* this will get initialized at each interface type init routine */
-	struct divert_blk	*divert;
-#endif /* CONFIG_NET_DIVERT */
-
 	/* class/net/name entry */
 	struct device		dev;
 	/* space for optional statistics and wireless sysfs groups */
--- linux-2.6.19-rc5-mm1/include/linux/sockios.h.old	2006-11-13 18:41:11.000000000 +0100
+++ linux-2.6.19-rc5-mm1/include/linux/sockios.h	2006-11-13 18:42:06.000000000 +0100
@@ -72,8 +72,8 @@
 #define SIOCGIFTXQLEN	0x8942		/* Get the tx queue length	*/
 #define SIOCSIFTXQLEN	0x8943		/* Set the tx queue length 	*/
 
-#define SIOCGIFDIVERT	0x8944		/* Frame diversion support */
-#define SIOCSIFDIVERT	0x8945		/* Set frame diversion options */
+/* SIOCGIFDIVERT was:	0x8944		Frame diversion support */
+/* SIOCSIFDIVERT was:	0x8945		Set frame diversion options */
 
 #define SIOCETHTOOL	0x8946		/* Ethtool interface		*/
 
--- linux-2.6.19-rc5-mm1/include/linux/Kbuild.old	2006-11-13 18:44:46.000000000 +0100
+++ linux-2.6.19-rc5-mm1/include/linux/Kbuild	2006-11-13 18:44:54.000000000 +0100
@@ -193,7 +193,6 @@ unifdef-y += cuda.h
 unifdef-y += cyclades.h
 unifdef-y += dccp.h
 unifdef-y += dirent.h
-unifdef-y += divert.h
 unifdef-y += dlm.h
 unifdef-y += elfcore.h
 unifdef-y += errno.h
--- linux-2.6.19-rc5-mm1/net/core/sysctl_net_core.c.old	2006-11-13 18:31:36.000000000 +0100
+++ linux-2.6.19-rc5-mm1/net/core/sysctl_net_core.c	2006-11-13 18:31:48.000000000 +0100
@@ -21,10 +21,6 @@ extern __u32 sysctl_rmem_max;
 
 extern int sysctl_core_destroy_delay;
 
-#ifdef CONFIG_NET_DIVERT
-extern char sysctl_divert_version[];
-#endif /* CONFIG_NET_DIVERT */
-
 #ifdef CONFIG_XFRM
 extern u32 sysctl_xfrm_aevent_etime;
 extern u32 sysctl_xfrm_aevent_rseqth;
@@ -105,16 +101,6 @@ ctl_table core_table[] = {
 		.mode		= 0644,
 		.proc_handler	= &proc_dointvec
 	},
-#ifdef CONFIG_NET_DIVERT
-	{
-		.ctl_name	= NET_CORE_DIVERT_VERSION,
-		.procname	= "divert_version",
-		.data		= (void *)sysctl_divert_version,
-		.maxlen		= 32,
-		.mode		= 0444,
-		.proc_handler	= &proc_dostring
-	},
-#endif /* CONFIG_NET_DIVERT */
 #ifdef CONFIG_XFRM
 	{
 		.ctl_name	= NET_CORE_AEVENT_ETIME,
--- linux-2.6.19-rc5-mm1/net/core/dev.c.old	2006-11-13 18:37:00.000000000 +0100
+++ linux-2.6.19-rc5-mm1/net/core/dev.c	2006-11-13 18:40:25.000000000 +0100
@@ -98,7 +98,6 @@
 #include <linux/seq_file.h>
 #include <linux/stat.h>
 #include <linux/if_bridge.h>
-#include <linux/divert.h>
 #include <net/dst.h>
 #include <net/pkt_sched.h>
 #include <net/checksum.h>
@@ -1827,8 +1826,6 @@ int netif_receive_skb(struct sk_buff *sk
 ncls:
 #endif
 
-	handle_diverter(skb);
-
 	if (handle_bridge(&skb, &pt_prev, &ret, orig_dev))
 		goto out;
 
@@ -2898,10 +2895,6 @@ int register_netdevice(struct net_device
 	spin_lock_init(&dev->ingress_lock);
 #endif
 
-	ret = alloc_divert_blk(dev);
-	if (ret)
-		goto out;
-
 	dev->iflink = -1;
 
 	/* Init, if this function is available */
@@ -2910,13 +2903,13 @@ int register_netdevice(struct net_device
 		if (ret) {
 			if (ret > 0)
 				ret = -EIO;
-			goto out_err;
+			goto out;
 		}
 	}
  
 	if (!dev_valid_name(dev->name)) {
 		ret = -EINVAL;
-		goto out_err;
+		goto out;
 	}
 
 	dev->ifindex = dev_new_index();
@@ -2930,7 +2923,7 @@ int register_netdevice(struct net_device
 			= hlist_entry(p, struct net_device, name_hlist);
 		if (!strncmp(d->name, dev->name, IFNAMSIZ)) {
 			ret = -EEXIST;
- 			goto out_err;
+ 			goto out;
 		}
  	}
 
@@ -2974,7 +2967,7 @@ int register_netdevice(struct net_device
 
 	ret = netdev_register_sysfs(dev);
 	if (ret)
-		goto out_err;
+		goto out;
 	dev->reg_state = NETREG_REGISTERED;
 
 	/*
@@ -3001,9 +2994,6 @@ int register_netdevice(struct net_device
 
 out:
 	return ret;
-out_err:
-	free_divert_blk(dev);
-	goto out;
 }
 
 /**
@@ -3329,8 +3319,6 @@ int unregister_netdevice(struct net_devi
 	/* Notifier chain MUST detach us from master device. */
 	BUG_TRAP(!dev->master);
 
-	free_divert_blk(dev);
-
 	/* Finish processing unregister after unlock */
 	net_set_todo(dev);
 
--- linux-2.6.19-rc5-mm1/net/socket.c.old	2006-11-13 18:38:32.000000000 +0100
+++ linux-2.6.19-rc5-mm1/net/socket.c	2006-11-13 18:42:26.000000000 +0100
@@ -77,7 +77,6 @@
 #include <linux/cache.h>
 #include <linux/module.h>
 #include <linux/highmem.h>
-#include <linux/divert.h>
 #include <linux/mount.h>
 #include <linux/security.h>
 #include <linux/syscalls.h>
@@ -855,11 +854,6 @@ static long sock_ioctl(struct file *file
 				err = vlan_ioctl_hook(argp);
 			mutex_unlock(&vlan_ioctl_mutex);
 			break;
-		case SIOCGIFDIVERT:
-		case SIOCSIFDIVERT:
-			/* Convert this to call through a hook */
-			err = divert_ioctl(cmd, argp);
-			break;
 		case SIOCADDDLCI:
 		case SIOCDELDLCI:
 			err = -ENOPKG;
--- linux-2.6.19-rc5-mm1/drivers/net/Space.c.old	2006-11-13 18:38:49.000000000 +0100
+++ linux-2.6.19-rc5-mm1/drivers/net/Space.c	2006-11-13 18:38:52.000000000 +0100
@@ -33,7 +33,6 @@
 #include <linux/errno.h>
 #include <linux/init.h>
 #include <linux/netlink.h>
-#include <linux/divert.h>
 
 /* A unified ethernet device probe.  This is the easiest way to have every
    ethernet adaptor have the name "eth[0123...]".
--- linux-2.6.19-rc5-mm1/include/linux/divert.h	2006-09-20 05:42:06.000000000 +0200
+++ /dev/null	2006-09-19 00:45:31.000000000 +0200
@@ -1,132 +0,0 @@
-/*
- * Frame Diversion, Benoit Locher <Benoit.Locher@skf.com>
- *
- * Changes:
- * 		06/09/2000	BL:	initial version
- * 
- */
- 
-#ifndef _LINUX_DIVERT_H
-#define _LINUX_DIVERT_H
-
-#include <asm/types.h>
-
-#define	MAX_DIVERT_PORTS	8	/* Max number of ports to divert (tcp, udp) */
-
-/* Divertable protocols */
-#define	DIVERT_PROTO_NONE	0x0000
-#define	DIVERT_PROTO_IP		0x0001
-#define	DIVERT_PROTO_ICMP	0x0002
-#define	DIVERT_PROTO_TCP	0x0004
-#define	DIVERT_PROTO_UDP	0x0008
-
-/*
- *	This is an Ethernet Frame Diverter option block
- */
-struct divert_blk
-{
-	int		divert;  /* are we active */
-	unsigned int protos;	/* protocols */
-	__u16		tcp_dst[MAX_DIVERT_PORTS]; /* specific tcp dst ports to divert */
-	__u16		tcp_src[MAX_DIVERT_PORTS]; /* specific tcp src ports to divert */
-	__u16		udp_dst[MAX_DIVERT_PORTS]; /* specific udp dst ports to divert */
-	__u16		udp_src[MAX_DIVERT_PORTS]; /* specific udp src ports to divert */
-};
-
-/*
- * Diversion control block, for configuration with the userspace tool
- * divert
- */
-
-typedef union _divert_cf_arg
-{
-	__s16		int16;
-	__u16		uint16;
-	__s32		int32;
-	__u32		uint32;
-	__s64		int64;
-	__u64		uint64;
-	void	__user *ptr;
-} divert_cf_arg;
-
-
-struct divert_cf
-{
-	int	cmd;				/* Command */
-	divert_cf_arg 	arg1,
-					arg2,
-					arg3;
-	int	dev_index;	/* device index (eth0=0, etc...) */
-};
-
-
-/* Diversion commands */
-#define	DIVCMD_DIVERT			1 /* ENABLE/DISABLE diversion */
-#define	DIVCMD_IP				2 /* ENABLE/DISABLE whold IP diversion */
-#define	DIVCMD_TCP				3 /* ENABLE/DISABLE whold TCP diversion */
-#define	DIVCMD_TCPDST			4 /* ADD/REMOVE TCP DST port for diversion */
-#define	DIVCMD_TCPSRC			5 /* ADD/REMOVE TCP SRC port for diversion */
-#define	DIVCMD_UDP				6 /* ENABLE/DISABLE whole UDP diversion */
-#define	DIVCMD_UDPDST			7 /* ADD/REMOVE UDP DST port for diversion */
-#define	DIVCMD_UDPSRC			8 /* ADD/REMOVE UDP SRC port for diversion */
-#define	DIVCMD_ICMP				9 /* ENABLE/DISABLE whole ICMP diversion */
-#define	DIVCMD_GETSTATUS		10 /* GET the status of the diverter */
-#define	DIVCMD_RESET			11 /* Reset the diverter on the specified dev */
-#define DIVCMD_GETVERSION		12 /* Retrieve the diverter code version (char[32]) */
-
-/* General syntax of the commands:
- * 
- * DIVCMD_xxxxxx(arg1, arg2, arg3, dev_index)
- * 
- * SIOCSIFDIVERT:
- *   DIVCMD_DIVERT(DIVARG1_ENABLE|DIVARG1_DISABLE, , ,ifindex)
- *   DIVCMD_IP(DIVARG1_ENABLE|DIVARG1_DISABLE, , , ifindex)
- *   DIVCMD_TCP(DIVARG1_ENABLE|DIVARG1_DISABLE, , , ifindex)
- *   DIVCMD_TCPDST(DIVARG1_ADD|DIVARG1_REMOVE, port, , ifindex)
- *   DIVCMD_TCPSRC(DIVARG1_ADD|DIVARG1_REMOVE, port, , ifindex)
- *   DIVCMD_UDP(DIVARG1_ENABLE|DIVARG1_DISABLE, , , ifindex)
- *   DIVCMD_UDPDST(DIVARG1_ADD|DIVARG1_REMOVE, port, , ifindex)
- *   DIVCMD_UDPSRC(DIVARG1_ADD|DIVARG1_REMOVE, port, , ifindex)
- *   DIVCMD_ICMP(DIVARG1_ENABLE|DIVARG1_DISABLE, , , ifindex)
- *   DIVCMD_RESET(, , , ifindex)
- *   
- * SIOGIFDIVERT:
- *   DIVCMD_GETSTATUS(divert_blk, , , ifindex)
- *   DIVCMD_GETVERSION(string[3])
- */
-
-
-/* Possible values for arg1 */
-#define	DIVARG1_ENABLE			0 /* ENABLE something */
-#define	DIVARG1_DISABLE			1 /* DISABLE something */
-#define DIVARG1_ADD				2 /* ADD something */
-#define DIVARG1_REMOVE			3 /* REMOVE something */
-
-
-#ifdef __KERNEL__
-
-/* diverter functions */
-#include <linux/skbuff.h>
-
-#ifdef CONFIG_NET_DIVERT
-#include <linux/netdevice.h>
-
-int alloc_divert_blk(struct net_device *);
-void free_divert_blk(struct net_device *);
-int divert_ioctl(unsigned int cmd, struct divert_cf __user *arg);
-void divert_frame(struct sk_buff *skb);
-static inline void handle_diverter(struct sk_buff *skb)
-{
-	/* if diversion is supported on device, then divert */
-	if (skb->dev->divert && skb->dev->divert->divert)
-		divert_frame(skb);
-}
-
-#else
-# define alloc_divert_blk(dev)		(0)
-# define free_divert_blk(dev)		do {} while (0)
-# define divert_ioctl(cmd, arg)		(-ENOPKG)
-# define handle_diverter(skb)		do {} while (0)
-#endif
-#endif 
-#endif	/* _LINUX_DIVERT_H */
--- linux-2.6.19-rc5-mm1/net/core/dv.c	2006-09-20 05:42:06.000000000 +0200
+++ /dev/null	2006-09-19 00:45:31.000000000 +0200
@@ -1,546 +0,0 @@
-/*
- * INET		An implementation of the TCP/IP protocol suite for the LINUX
- *		operating system.  INET is implemented using the  BSD Socket
- *		interface as the means of communication with the user level.
- *
- *		Generic frame diversion
- *
- * Authors:	
- * 		Benoit LOCHER:	initial integration within the kernel with support for ethernet
- * 		Dave Miller:	improvement on the code (correctness, performance and source files)
- *
- */
-#include <linux/module.h>
-#include <linux/types.h>
-#include <linux/kernel.h>
-#include <linux/sched.h>
-#include <linux/string.h>
-#include <linux/mm.h>
-#include <linux/socket.h>
-#include <linux/in.h>
-#include <linux/inet.h>
-#include <linux/ip.h>
-#include <linux/udp.h>
-#include <linux/netdevice.h>
-#include <linux/etherdevice.h>
-#include <linux/skbuff.h>
-#include <linux/capability.h>
-#include <linux/errno.h>
-#include <linux/init.h>
-#include <net/dst.h>
-#include <net/arp.h>
-#include <net/sock.h>
-#include <net/ipv6.h>
-#include <net/ip.h>
-#include <asm/uaccess.h>
-#include <asm/system.h>
-#include <asm/checksum.h>
-#include <linux/divert.h>
-#include <linux/sockios.h>
-
-const char sysctl_divert_version[32]="0.46";	/* Current version */
-
-static int __init dv_init(void)
-{
-	return 0;
-}
-module_init(dv_init);
-
-/*
- * Allocate a divert_blk for a device. This must be an ethernet nic.
- */
-int alloc_divert_blk(struct net_device *dev)
-{
-	int alloc_size = (sizeof(struct divert_blk) + 3) & ~3;
-
-	dev->divert = NULL;
-	if (dev->type == ARPHRD_ETHER) {
-		dev->divert = kzalloc(alloc_size, GFP_KERNEL);
-		if (dev->divert == NULL) {
-			printk(KERN_INFO "divert: unable to allocate divert_blk for %s\n",
-			       dev->name);
-			return -ENOMEM;
-		}
-		dev_hold(dev);
-	}
-
-	return 0;
-} 
-
-/*
- * Free a divert_blk allocated by the above function, if it was 
- * allocated on that device.
- */
-void free_divert_blk(struct net_device *dev)
-{
-	if (dev->divert) {
-		kfree(dev->divert);
-		dev->divert=NULL;
-		dev_put(dev);
-	}
-}
-
-/*
- * Adds a tcp/udp (source or dest) port to an array
- */
-static int add_port(u16 ports[], u16 port)
-{
-	int i;
-
-	if (port == 0)
-		return -EINVAL;
-
-	/* Storing directly in network format for performance,
-	 * thanks Dave :)
-	 */
-	port = htons(port);
-
-	for (i = 0; i < MAX_DIVERT_PORTS; i++) {
-		if (ports[i] == port)
-			return -EALREADY;
-	}
-	
-	for (i = 0; i < MAX_DIVERT_PORTS; i++) {
-		if (ports[i] == 0) {
-			ports[i] = port;
-			return 0;
-		}
-	}
-
-	return -ENOBUFS;
-}
-
-/*
- * Removes a port from an array tcp/udp (source or dest)
- */
-static int remove_port(u16 ports[], u16 port)
-{
-	int i;
-
-	if (port == 0)
-		return -EINVAL;
-	
-	/* Storing directly in network format for performance,
-	 * thanks Dave !
-	 */
-	port = htons(port);
-
-	for (i = 0; i < MAX_DIVERT_PORTS; i++) {
-		if (ports[i] == port) {
-			ports[i] = 0;
-			return 0;
-		}
-	}
-
-	return -EINVAL;
-}
-
-/* Some basic sanity checks on the arguments passed to divert_ioctl() */
-static int check_args(struct divert_cf *div_cf, struct net_device **dev)
-{
-	char devname[32];
-	int ret;
-
-	if (dev == NULL)
-		return -EFAULT;
-	
-	/* GETVERSION: all other args are unused */
-	if (div_cf->cmd == DIVCMD_GETVERSION)
-		return 0;
-	
-	/* Network device index should reasonably be between 0 and 1000 :) */
-	if (div_cf->dev_index < 0 || div_cf->dev_index > 1000) 
-		return -EINVAL;
-			
-	/* Let's try to find the ifname */
-	sprintf(devname, "eth%d", div_cf->dev_index);
-	*dev = dev_get_by_name(devname);
-	
-	/* dev should NOT be null */
-	if (*dev == NULL)
-		return -EINVAL;
-
-	ret = 0;
-
-	/* user issuing the ioctl must be a super one :) */
-	if (!capable(CAP_SYS_ADMIN)) {
-		ret = -EPERM;
-		goto out;
-	}
-
-	/* Device must have a divert_blk member NOT null */
-	if ((*dev)->divert == NULL)
-		ret = -EINVAL;
-out:
-	dev_put(*dev);
-	return ret;
-}
-
-/*
- * control function of the diverter
- */
-#if 0
-#define	DVDBG(a)	\
-	printk(KERN_DEBUG "divert_ioctl() line %d %s\n", __LINE__, (a))
-#else
-#define	DVDBG(a)
-#endif
-
-int divert_ioctl(unsigned int cmd, struct divert_cf __user *arg)
-{
-	struct divert_cf	div_cf;
-	struct divert_blk	*div_blk;
-	struct net_device	*dev;
-	int			ret;
-
-	switch (cmd) {
-	case SIOCGIFDIVERT:
-		DVDBG("SIOCGIFDIVERT, copy_from_user");
-		if (copy_from_user(&div_cf, arg, sizeof(struct divert_cf)))
-			return -EFAULT;
-		DVDBG("before check_args");
-		ret = check_args(&div_cf, &dev);
-		if (ret)
-			return ret;
-		DVDBG("after checkargs");
-		div_blk = dev->divert;
-			
-		DVDBG("befre switch()");
-		switch (div_cf.cmd) {
-		case DIVCMD_GETSTATUS:
-			/* Now, just give the user the raw divert block
-			 * for him to play with :)
-			 */
-			if (copy_to_user(div_cf.arg1.ptr, dev->divert,
-					 sizeof(struct divert_blk)))
-				return -EFAULT;
-			break;
-
-		case DIVCMD_GETVERSION:
-			DVDBG("GETVERSION: checking ptr");
-			if (div_cf.arg1.ptr == NULL)
-				return -EINVAL;
-			DVDBG("GETVERSION: copying data to userland");
-			if (copy_to_user(div_cf.arg1.ptr,
-					 sysctl_divert_version, 32))
-				return -EFAULT;
-			DVDBG("GETVERSION: data copied");
-			break;
-
-		default:
-			return -EINVAL;
-		}
-
-		break;
-
-	case SIOCSIFDIVERT:
-		if (copy_from_user(&div_cf, arg, sizeof(struct divert_cf)))
-			return -EFAULT;
-
-		ret = check_args(&div_cf, &dev);
-		if (ret)
-			return ret;
-
-		div_blk = dev->divert;
-
-		switch(div_cf.cmd) {
-		case DIVCMD_RESET:
-			div_blk->divert = 0;
-			div_blk->protos = DIVERT_PROTO_NONE;
-			memset(div_blk->tcp_dst, 0,
-			       MAX_DIVERT_PORTS * sizeof(u16));
-			memset(div_blk->tcp_src, 0,
-			       MAX_DIVERT_PORTS * sizeof(u16));
-			memset(div_blk->udp_dst, 0,
-			       MAX_DIVERT_PORTS * sizeof(u16));
-			memset(div_blk->udp_src, 0,
-			       MAX_DIVERT_PORTS * sizeof(u16));
-			return 0;
-				
-		case DIVCMD_DIVERT:
-			switch(div_cf.arg1.int32) {
-			case DIVARG1_ENABLE:
-				if (div_blk->divert)
-					return -EALREADY;
-				div_blk->divert = 1;
-				break;
-
-			case DIVARG1_DISABLE:
-				if (!div_blk->divert)
-					return -EALREADY;
-				div_blk->divert = 0;
-				break;
-
-			default:
-				return -EINVAL;
-			}
-
-			break;
-
-		case DIVCMD_IP:
-			switch(div_cf.arg1.int32) {
-			case DIVARG1_ENABLE:
-				if (div_blk->protos & DIVERT_PROTO_IP)
-					return -EALREADY;
-				div_blk->protos |= DIVERT_PROTO_IP;
-				break;
-
-			case DIVARG1_DISABLE:
-				if (!(div_blk->protos & DIVERT_PROTO_IP))
-					return -EALREADY;
-				div_blk->protos &= ~DIVERT_PROTO_IP;
-				break;
-
-			default:
-				return -EINVAL;
-			}
-
-			break;
-
-		case DIVCMD_TCP:
-			switch(div_cf.arg1.int32) {
-			case DIVARG1_ENABLE:
-				if (div_blk->protos & DIVERT_PROTO_TCP)
-					return -EALREADY;
-				div_blk->protos |= DIVERT_PROTO_TCP;
-				break;
-
-			case DIVARG1_DISABLE:
-				if (!(div_blk->protos & DIVERT_PROTO_TCP))
-					return -EALREADY;
-				div_blk->protos &= ~DIVERT_PROTO_TCP;
-				break;
-
-			default:
-				return -EINVAL;
-			}
-
-			break;
-
-		case DIVCMD_TCPDST:
-			switch(div_cf.arg1.int32) {
-			case DIVARG1_ADD:
-				return add_port(div_blk->tcp_dst,
-						div_cf.arg2.uint16);
-				
-			case DIVARG1_REMOVE:
-				return remove_port(div_blk->tcp_dst,
-						   div_cf.arg2.uint16);
-
-			default:
-				return -EINVAL;
-			}
-
-			break;
-
-		case DIVCMD_TCPSRC:
-			switch(div_cf.arg1.int32) {
-			case DIVARG1_ADD:
-				return add_port(div_blk->tcp_src,
-						div_cf.arg2.uint16);
-
-			case DIVARG1_REMOVE:
-				return remove_port(div_blk->tcp_src,
-						   div_cf.arg2.uint16);
-
-			default:
-				return -EINVAL;
-			}
-
-			break;
-
-		case DIVCMD_UDP:
-			switch(div_cf.arg1.int32) {
-			case DIVARG1_ENABLE:
-				if (div_blk->protos & DIVERT_PROTO_UDP)
-					return -EALREADY;
-				div_blk->protos |= DIVERT_PROTO_UDP;
-				break;
-
-			case DIVARG1_DISABLE:
-				if (!(div_blk->protos & DIVERT_PROTO_UDP))
-					return -EALREADY;
-				div_blk->protos &= ~DIVERT_PROTO_UDP;
-				break;
-
-			default:
-				return -EINVAL;
-			}
-
-			break;
-
-		case DIVCMD_UDPDST:
-			switch(div_cf.arg1.int32) {
-			case DIVARG1_ADD:
-				return add_port(div_blk->udp_dst,
-						div_cf.arg2.uint16);
-
-			case DIVARG1_REMOVE:
-				return remove_port(div_blk->udp_dst,
-						   div_cf.arg2.uint16);
-
-			default:
-				return -EINVAL;
-			}
-
-			break;
-
-		case DIVCMD_UDPSRC:
-			switch(div_cf.arg1.int32) {
-			case DIVARG1_ADD:
-				return add_port(div_blk->udp_src,
-						div_cf.arg2.uint16);
-
-			case DIVARG1_REMOVE:
-				return remove_port(div_blk->udp_src,
-						   div_cf.arg2.uint16);
-
-			default:
-				return -EINVAL;
-			}
-
-			break;
-
-		case DIVCMD_ICMP:
-			switch(div_cf.arg1.int32) {
-			case DIVARG1_ENABLE:
-				if (div_blk->protos & DIVERT_PROTO_ICMP)
-					return -EALREADY;
-				div_blk->protos |= DIVERT_PROTO_ICMP;
-				break;
-
-			case DIVARG1_DISABLE:
-				if (!(div_blk->protos & DIVERT_PROTO_ICMP))
-					return -EALREADY;
-				div_blk->protos &= ~DIVERT_PROTO_ICMP;
-				break;
-
-			default:
-				return -EINVAL;
-			}
-
-			break;
-
-		default:
-			return -EINVAL;
-		}
-
-		break;
-
-	default:
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
-
-/*
- * Check if packet should have its dest mac address set to the box itself
- * for diversion
- */
-
-#define	ETH_DIVERT_FRAME(skb) \
-	memcpy(eth_hdr(skb), skb->dev->dev_addr, ETH_ALEN); \
-	skb->pkt_type=PACKET_HOST
-		
-void divert_frame(struct sk_buff *skb)
-{
-	struct ethhdr			*eth = eth_hdr(skb);
-	struct iphdr			*iph;
-	struct tcphdr			*tcph;
-	struct udphdr			*udph;
-	struct divert_blk		*divert = skb->dev->divert;
-	int				i, src, dst;
-	unsigned char			*skb_data_end = skb->data + skb->len;
-
-	/* Packet is already aimed at us, return */
-	if (!compare_ether_addr(eth->h_dest, skb->dev->dev_addr))
-		return;
-	
-	/* proto is not IP, do nothing */
-	if (eth->h_proto != htons(ETH_P_IP))
-		return;
-	
-	/* Divert all IP frames ? */
-	if (divert->protos & DIVERT_PROTO_IP) {
-		ETH_DIVERT_FRAME(skb);
-		return;
-	}
-	
-	/* Check for possible (maliciously) malformed IP frame (thanks Dave) */
-	iph = (struct iphdr *) skb->data;
-	if (((iph->ihl<<2)+(unsigned char*)(iph)) >= skb_data_end) {
-		printk(KERN_INFO "divert: malformed IP packet !\n");
-		return;
-	}
-
-	switch (iph->protocol) {
-	/* Divert all ICMP frames ? */
-	case IPPROTO_ICMP:
-		if (divert->protos & DIVERT_PROTO_ICMP) {
-			ETH_DIVERT_FRAME(skb);
-			return;
-		}
-		break;
-
-	/* Divert all TCP frames ? */
-	case IPPROTO_TCP:
-		if (divert->protos & DIVERT_PROTO_TCP) {
-			ETH_DIVERT_FRAME(skb);
-			return;
-		}
-
-		/* Check for possible (maliciously) malformed IP
-		 * frame (thanx Dave)
-		 */
-		tcph = (struct tcphdr *)
-			(((unsigned char *)iph) + (iph->ihl<<2));
-		if (((unsigned char *)(tcph+1)) >= skb_data_end) {
-			printk(KERN_INFO "divert: malformed TCP packet !\n");
-			return;
-		}
-
-		/* Divert some tcp dst/src ports only ?*/
-		for (i = 0; i < MAX_DIVERT_PORTS; i++) {
-			dst = divert->tcp_dst[i];
-			src = divert->tcp_src[i];
-			if ((dst && dst == tcph->dest) ||
-			    (src && src == tcph->source)) {
-				ETH_DIVERT_FRAME(skb);
-				return;
-			}
-		}
-		break;
-
-	/* Divert all UDP frames ? */
-	case IPPROTO_UDP:
-		if (divert->protos & DIVERT_PROTO_UDP) {
-			ETH_DIVERT_FRAME(skb);
-			return;
-		}
-
-		/* Check for possible (maliciously) malformed IP
-		 * packet (thanks Dave)
-		 */
-		udph = (struct udphdr *)
-			(((unsigned char *)iph) + (iph->ihl<<2));
-		if (((unsigned char *)(udph+1)) >= skb_data_end) {
-			printk(KERN_INFO
-			       "divert: malformed UDP packet !\n");
-			return;
-		}
-
-		/* Divert some udp dst/src ports only ? */
-		for (i = 0; i < MAX_DIVERT_PORTS; i++) {
-			dst = divert->udp_dst[i];
-			src = divert->udp_src[i];
-			if ((dst && dst == udph->dest) ||
-			    (src && src == udph->source)) {
-				ETH_DIVERT_FRAME(skb);
-				return;
-			}
-		}
-		break;
-	}
-}
