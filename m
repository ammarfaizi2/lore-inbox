Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268148AbUHKSMc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268148AbUHKSMc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 14:12:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268142AbUHKSMc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 14:12:32 -0400
Received: from palrel10.hp.com ([156.153.255.245]:63436 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S268148AbUHKSKc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 14:10:32 -0400
Date: Wed, 11 Aug 2004 11:10:30 -0700
To: Jeff Garzik <jgarzik@pobox.com>, netdev@oss.sgi.com,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6] Wireless Extension v17 for Linus
Message-ID: <20040811181030.GA23701@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi Jeff,

	New improved version of my previous patch :
http://marc.theaimsgroup.com/?l=linux-netdev&m=109158012711737&w=2

	When you think it's over, you always end up receiving new
feedback. This version only fixes a few comments and remove some
useless and potentially confusing consts. No code change to previous
version.
	By the way, I would not mind a ack that you have properly
received this patch (and the driver patch) and that they are queued
for Linus...

	Have fun...

	Jean

----------------------------------------------------------

diff -u -p linux/include/linux/netdevice.we16.h linux/include/linux/netdevice.h
--- linux/include/linux/netdevice.we16.h	Tue Aug  3 11:13:59 2004
+++ linux/include/linux/netdevice.h	Tue Aug  3 11:16:30 2004
@@ -304,7 +304,9 @@ struct net_device
 
 	/* List of functions to handle Wireless Extensions (instead of ioctl).
 	 * See <net/iw_handler.h> for details. Jean II */
-	struct iw_handler_def *	wireless_handlers;
+	const struct iw_handler_def *	wireless_handlers;
+	/* Instance data managed by the core of Wireless Extensions. */
+	struct iw_public_data *	wireless_data;
 
 	struct ethtool_ops *ethtool_ops;
 
diff -u -p linux/include/linux/wireless.we16.h linux/include/linux/wireless.h
--- linux/include/linux/wireless.we16.h	Tue Aug  3 11:14:07 2004
+++ linux/include/linux/wireless.h	Tue Aug  3 11:23:15 2004
@@ -1,10 +1,10 @@
 /*
  * This file define a set of standard wireless extensions
  *
- * Version :	16	2.4.03
+ * Version :	17	21.6.04
  *
  * Authors :	Jean Tourrilhes - HPL - <jt@hpl.hp.com>
- * Copyright (c) 1997-2002 Jean Tourrilhes, All Rights Reserved.
+ * Copyright (c) 1997-2004 Jean Tourrilhes, All Rights Reserved.
  */
 
 #ifndef _LINUX_WIRELESS_H
@@ -47,12 +47,12 @@
  *	# include/net/iw_handler.h
  *
  * Note as well that /proc/net/wireless implementation has now moved in :
- *	# include/linux/wireless.c
+ *	# net/core/wireless.c
  *
  * Wireless Events (2002 -> onward) :
  * --------------------------------
  * Events are defined at the end of this file, and implemented in :
- *	# include/linux/wireless.c
+ *	# net/core/wireless.c
  *
  * Other comments :
  * --------------
@@ -82,7 +82,7 @@
  * (there is some stuff that will be added in the future...)
  * I just plan to increment with each new version.
  */
-#define WIRELESS_EXT	16
+#define WIRELESS_EXT	17
 
 /*
  * Changes :
@@ -175,6 +175,13 @@
  *	- Remove IW_MAX_GET_SPY because conflict with enhanced spy support
  *	- Add SIOCSIWTHRSPY/SIOCGIWTHRSPY and "struct iw_thrspy"
  *	- Add IW_ENCODE_TEMP and iw_range->encoding_login_index
+ *
+ * V16 to V17
+ * ----------
+ *	- Add flags to frequency -> auto/fixed
+ *	- Document (struct iw_quality *)->updated, add new flags (INVALID)
+ *	- Wireless Event capability in struct iw_range
+ *	- Add support for relative TxPower (yick !)
  */
 
 /**************************** CONSTANTS ****************************/
@@ -251,7 +258,7 @@
 
 /* -------------------- DEV PRIVATE IOCTL LIST -------------------- */
 
-/* These 16 ioctl are wireless device private.
+/* These 32 ioctl are wireless device private, for 16 commands.
  * Each driver is free to use them for whatever purpose it chooses,
  * however the driver *must* export the description of those ioctls
  * with SIOCGIWPRIV and *must* use arguments as defined below.
@@ -266,8 +273,8 @@
  * We now have 32 commands, so a bit more space ;-).
  * Also, all 'odd' commands are only usable by root and don't return the
  * content of ifr/iwr to user (but you are not obliged to use the set/get
- * convention, just use every other two command).
- * And I repeat : you are not obliged to use them with iwspy, but you
+ * convention, just use every other two command). More details in iwpriv.c.
+ * And I repeat : you are not forced to use them with iwpriv, but you
  * must be compliant with it.
  */
 
@@ -352,6 +359,18 @@
 #define IW_MODE_SECOND	5	/* Secondary master/repeater (backup) */
 #define IW_MODE_MONITOR	6	/* Passive monitor (listen only) */
 
+/* Statistics flags (bitmask in updated) */
+#define IW_QUAL_QUAL_UPDATED	0x1	/* Value was updated since last read */
+#define IW_QUAL_LEVEL_UPDATED	0x2
+#define IW_QUAL_NOISE_UPDATED	0x4
+#define IW_QUAL_QUAL_INVALID	0x10	/* Driver doesn't provide value */
+#define IW_QUAL_LEVEL_INVALID	0x20
+#define IW_QUAL_NOISE_INVALID	0x40
+
+/* Frequency flags */
+#define IW_FREQ_AUTO		0x00	/* Let the driver decides */
+#define IW_FREQ_FIXED		0x01	/* Force a specific value */
+
 /* Maximum number of size of encoding token available
  * they are listed in the range structure */
 #define IW_MAX_ENCODING_SIZES	8
@@ -390,6 +409,7 @@
 #define IW_TXPOW_TYPE		0x00FF	/* Type of value */
 #define IW_TXPOW_DBM		0x0000	/* Value is in dBm */
 #define IW_TXPOW_MWATT		0x0001	/* Value is in mW */
+#define IW_TXPOW_RELATIVE	0x0002	/* Value is in arbitrary units */
 #define IW_TXPOW_RANGE		0x1000	/* Range of value between min/max */
 
 /* Retry limits and lifetime flags available */
@@ -418,6 +438,25 @@
 /* Max number of char in custom event - use multiple of them if needed */
 #define IW_CUSTOM_MAX		256	/* In bytes */
 
+/* Event capability macros - in (struct iw_range *)->event_capa
+ * Because we have more than 32 possible events, we use an array of
+ * 32 bit bitmasks. Note : 32 bits = 0x20 = 2^5. */
+#define IW_EVENT_CAPA_BASE(cmd)		((cmd >= SIOCIWFIRSTPRIV) ? \
+					 (cmd - SIOCIWFIRSTPRIV + 0x60) : \
+					 (cmd - SIOCSIWCOMMIT))
+#define IW_EVENT_CAPA_INDEX(cmd)	(IW_EVENT_CAPA_BASE(cmd) >> 5)
+#define IW_EVENT_CAPA_MASK(cmd)		(1 << (IW_EVENT_CAPA_BASE(cmd) & 0x1F))
+/* Event capability constants - event autogenerated by the kernel
+ * This list is valid for most 802.11 devices, customise as needed... */
+#define IW_EVENT_CAPA_K_0	(IW_EVENT_CAPA_MASK(0x8B04) | \
+				 IW_EVENT_CAPA_MASK(0x8B06) | \
+				 IW_EVENT_CAPA_MASK(0x8B1A))
+#define IW_EVENT_CAPA_K_1	(IW_EVENT_CAPA_MASK(0x8B2A))
+/* "Easy" macro to set events in iw_range (less efficient) */
+#define IW_EVENT_CAPA_SET(event_capa, cmd) (event_capa[IW_EVENT_CAPA_INDEX(cmd)] |= IW_EVENT_CAPA_MASK(cmd))
+#define IW_EVENT_CAPA_SET_KERNEL(event_capa) {event_capa[0] |= IW_EVENT_CAPA_K_0; event_capa[1] |= IW_EVENT_CAPA_K_1; }
+
+
 /****************************** TYPES ******************************/
 
 /* --------------------------- SUBTYPES --------------------------- */
@@ -456,7 +495,7 @@ struct	iw_freq
 	__s32		m;		/* Mantissa */
 	__s16		e;		/* Exponent */
 	__u8		i;		/* List index (when in range struct) */
-	__u8		pad;		/* Unused - just for alignement */
+	__u8		flags;		/* Flags (fixed/auto) */
 };
 
 /*
@@ -610,11 +649,12 @@ struct	iw_range
 	/* Old Frequency (backward compat - moved lower ) */
 	__u16		old_num_channels;
 	__u8		old_num_frequency;
-	/* Filler to keep "version" at the same offset */
-	__s32		old_freq[6];
+
+	/* Wireless event capability bitmasks */
+	__u32		event_capa[6];
 
 	/* signal level threshold range */
-	__s32	sensitivity;
+	__s32		sensitivity;
 
 	/* Quality of link & SNR stuff */
 	/* Quality range (link, level, noise)
diff -u -p linux/include/net/iw_handler.we16.h linux/include/net/iw_handler.h
--- linux/include/net/iw_handler.we16.h	Tue Aug  3 11:14:22 2004
+++ linux/include/net/iw_handler.h	Tue Aug 10 17:41:03 2004
@@ -1,10 +1,10 @@
 /*
  * This file define the new driver API for Wireless Extensions
  *
- * Version :	5	4.12.02
+ * Version :	6	21.6.04
  *
  * Authors :	Jean Tourrilhes - HPL - <jt@hpl.hp.com>
- * Copyright (c) 2001-2002 Jean Tourrilhes, All Rights Reserved.
+ * Copyright (c) 2001-2004 Jean Tourrilhes, All Rights Reserved.
  */
 
 #ifndef _IW_HANDLER_H
@@ -206,7 +206,7 @@
  * will be needed...
  * I just plan to increment with each new version.
  */
-#define IW_HANDLER_VERSION	5
+#define IW_HANDLER_VERSION	6
 
 /*
  * Changes :
@@ -224,11 +224,18 @@
  * V4 to V5
  * --------
  *	- Add new spy support : struct iw_spy_data & prototypes
+ *
+ * V5 to V6
+ * --------
+ *	- Change the way we get to spy_data method for added safety
+ *	- Remove spy #ifdef, they are always on -> cleaner code
+ *	- Add IW_DESCR_FLAG_NOMAX flag for very large requests
+ *	- Start migrating get_wireless_stats to struct iw_handler_def
  */
 
 /**************************** CONSTANTS ****************************/
 
-/* Enable enhanced spy support. Disable to reduce footprint */
+/* Enhanced spy support available */
 #define IW_WIRELESS_SPY
 #define IW_WIRELESS_THRSPY
 
@@ -258,6 +265,7 @@
 #define IW_DESCR_FLAG_EVENT	0x0002	/* Generate an event on SET */
 #define IW_DESCR_FLAG_RESTRICT	0x0004	/* GET : request is ROOT only */
 				/* SET : Omit payload from generated iwevent */
+#define IW_DESCR_FLAG_NOMAX	0x0008	/* GET : no limit on request size */
 /* Driver level flags */
 #define IW_DESCR_FLAG_WAIT	0x0100	/* Wait for driver event */
 
@@ -311,23 +319,25 @@ struct iw_handler_def
 	/* Array of handlers for standard ioctls
 	 * We will call dev->wireless_handlers->standard[ioctl - SIOCSIWNAME]
 	 */
-	iw_handler *		standard;
+	const iw_handler *	standard;
 
 	/* Array of handlers for private ioctls
 	 * Will call dev->wireless_handlers->private[ioctl - SIOCIWFIRSTPRIV]
 	 */
-	iw_handler *		private;
+	const iw_handler *	private;
 
 	/* Arguments of private handler. This one is just a list, so you
 	 * can put it in any order you want and should not leave holes...
 	 * We will automatically export that to user space... */
-	struct iw_priv_args *	private_args;
+	const struct iw_priv_args *	private_args;
 
-	/* Driver enhanced spy support */
-	long			spy_offset;	/* Spy data offset */
+	/* This field will be *removed* in the next version of WE */
+	long			spy_offset;	/* DO NOT USE */
 
-	/* In the long term, get_wireless_stats will move from
-	 * 'struct net_device' to here, to minimise bloat. */
+	/* New location of get_wireless_stats, to de-bloat struct net_device.
+	 * The old pointer in struct net_device will be gradually phased
+	 * out, and drivers are encouraged to use this one... */
+	struct iw_statistics*	(*get_wireless_stats)(struct net_device *dev);
 };
 
 /* ---------------------- IOCTL DESCRIPTION ---------------------- */
@@ -374,18 +384,29 @@ struct iw_ioctl_description
  */
 struct iw_spy_data
 {
-#ifdef IW_WIRELESS_SPY
 	/* --- Standard spy support --- */
 	int			spy_number;
 	u_char			spy_address[IW_MAX_SPY][ETH_ALEN];
 	struct iw_quality	spy_stat[IW_MAX_SPY];
-#ifdef IW_WIRELESS_THRSPY
 	/* --- Enhanced spy support (event) */
 	struct iw_quality	spy_thr_low;	/* Low threshold */
 	struct iw_quality	spy_thr_high;	/* High threshold */
 	u_char			spy_thr_under[IW_MAX_SPY];
-#endif /* IW_WIRELESS_THRSPY */
-#endif /* IW_WIRELESS_SPY */
+};
+
+/* --------------------- DEVICE WIRELESS DATA --------------------- */
+/*
+ * This is all the wireless data specific to a device instance that
+ * is managed by the core of Wireless Extensions.
+ * We only keep pointer to those structures, so that a driver is free
+ * to share them between instances.
+ * This structure should be initialised before registering the device.
+ * Access to this data follow the same rules as any other struct net_device
+ * data (i.e. valid as long as struct net_device exist, same locking rules).
+ */
+struct iw_public_data {
+	/* Driver enhanced spy support */
+	struct iw_spy_data *	spy_data;
 };
 
 /**************************** PROTOTYPES ****************************/
@@ -393,6 +414,9 @@ struct iw_spy_data
  * Functions part of the Wireless Extensions (defined in net/core/wireless.c).
  * Those may be called only within the kernel.
  */
+
+/* Data needed by fs/compat_ioctl.c for 32->64 bit conversion */
+extern const char iw_priv_type_size[];
 
 /* First : function strictly used inside the kernel */
 
diff -u -p linux/net/core/dev.we16.c linux/net/core/dev.c
--- linux/net/core/dev.we16.c	Tue Aug  3 11:14:45 2004
+++ linux/net/core/dev.c	Tue Aug  3 11:15:09 2004
@@ -2787,7 +2787,7 @@ int dev_ioctl(unsigned int cmd, void __u
 				/* Follow me in net/core/wireless.c */
 				ret = wireless_process_ioctl(&ifr, cmd);
 				rtnl_unlock();
-				if (!ret && IW_IS_GET(cmd) &&
+				if (IW_IS_GET(cmd) &&
 				    copy_to_user(arg, &ifr,
 					    	 sizeof(struct ifreq)))
 					ret = -EFAULT;
diff -u -p linux/net/core/wireless.we16.c linux/net/core/wireless.c
--- linux/net/core/wireless.we16.c	Tue Aug  3 11:14:54 2004
+++ linux/net/core/wireless.c	Tue Aug 10 17:42:35 2004
@@ -2,7 +2,7 @@
  * This file implement the Wireless Extensions APIs.
  *
  * Authors :	Jean Tourrilhes - HPL - <jt@hpl.hp.com>
- * Copyright (c) 1997-2003 Jean Tourrilhes, All Rights Reserved.
+ * Copyright (c) 1997-2004 Jean Tourrilhes, All Rights Reserved.
  *
  * (As all part of the Linux kernel, this file is GPL)
  */
@@ -48,6 +48,16 @@
  *	o Add common spy support : iw_handler_set_spy(), wireless_spy_update()
  *	o Add enhanced spy support : iw_handler_set_thrspy() and event.
  *	o Add WIRELESS_EXT version display in /proc/net/wireless
+ *
+ * v6 - 18.06.04 - Jean II
+ *	o Change get_spydata() method for added safety
+ *	o Remove spy #ifdef, they are always on -> cleaner code
+ *	o Allow any size GET request if user specifies length > max
+ *		and if request has IW_DESCR_FLAG_NOMAX flag or is SIOCGIWPRIV
+ *	o Start migrating get_wireless_stats to struct iw_handler_def
+ *	o Add wmb() in iw_handler_set_spy() for non-coherent archs/cpus
+ * Based on patch from Pavel Roskin <proski@gnu.org> :
+ *	o Fix kernel data leak to user space in private handler handling
  */
 
 /***************************** INCLUDES *****************************/
@@ -69,10 +79,6 @@
 
 /**************************** CONSTANTS ****************************/
 
-/* Enough lenience, let's make sure things are proper... */
-#define WE_STRICT_WRITE		/* Check write buffer size */
-/* I'll probably drop both the define and kernel message in the next version */
-
 /* Debugging stuff */
 #undef WE_IOCTL_DEBUG		/* Debug IOCTL API */
 #undef WE_EVENT_DEBUG		/* Debug Event dispatcher */
@@ -186,6 +192,7 @@ static const struct iw_ioctl_description
 		.token_size	= sizeof(struct sockaddr) +
 				  sizeof(struct iw_quality),
 		.max_tokens	= IW_MAX_AP,
+		.flags		= IW_DESCR_FLAG_NOMAX,
 	},
 	[SIOCSIWSCAN	- SIOCIWFIRST] = {
 		.header_type	= IW_HEADER_TYPE_PARAM,
@@ -194,6 +201,7 @@ static const struct iw_ioctl_description
 		.header_type	= IW_HEADER_TYPE_POINT,
 		.token_size	= 1,
 		.max_tokens	= IW_SCAN_MAX_DATA,
+		.flags		= IW_DESCR_FLAG_NOMAX,
 	},
 	[SIOCSIWESSID	- SIOCIWFIRST] = {
 		.header_type	= IW_HEADER_TYPE_POINT,
@@ -296,7 +304,7 @@ static const int standard_event_num = (s
 				       sizeof(struct iw_ioctl_description));
 
 /* Size (in bytes) of the various private data types */
-static const char priv_type_size[] = {
+const char iw_priv_type_size[] = {
 	0,				/* IW_PRIV_TYPE_NONE */
 	1,				/* IW_PRIV_TYPE_BYTE */
 	1,				/* IW_PRIV_TYPE_CHAR */
@@ -363,12 +371,15 @@ static inline iw_handler get_handler(str
  */
 static inline struct iw_statistics *get_wireless_stats(struct net_device *dev)
 {
+	/* New location */
+	if((dev->wireless_handlers != NULL) &&
+	   (dev->wireless_handlers->get_wireless_stats != NULL))
+		return dev->wireless_handlers->get_wireless_stats(dev);
+
+	/* Old location, will be phased out in next WE */
 	return (dev->get_wireless_stats ?
 		dev->get_wireless_stats(dev) :
 		(struct iw_statistics *) NULL);
-	/* In the future, get_wireless_stats may move from 'struct net_device'
-	 * to 'struct iw_handler_def', to de-bloat struct net_device.
-	 * Definitely worse a thought... */
 }
 
 /* ---------------------------------------------------------------- */
@@ -403,14 +414,32 @@ static inline int call_commit_handler(st
 
 /* ---------------------------------------------------------------- */
 /*
- * Number of private arguments
+ * Calculate size of private arguments
  */
 static inline int get_priv_size(__u16	args)
 {
 	int	num = args & IW_PRIV_SIZE_MASK;
 	int	type = (args & IW_PRIV_TYPE_MASK) >> 12;
 
-	return num * priv_type_size[type];
+	return num * iw_priv_type_size[type];
+}
+
+/* ---------------------------------------------------------------- */
+/*
+ * Re-calculate the size of private arguments
+ */
+static inline int adjust_priv_size(__u16		args,
+				   union iwreq_data *	wrqu)
+{
+	int	num = wrqu->data.length;
+	int	max = args & IW_PRIV_SIZE_MASK;
+	int	type = (args & IW_PRIV_TYPE_MASK) >> 12;
+
+	/* Make sure the driver doesn't goof up */
+	if (max < num)
+		num = max;
+
+	return num * iw_priv_type_size[type];
 }
 
 
@@ -440,11 +469,14 @@ static __inline__ void wireless_seq_prin
 		seq_printf(seq, "%6s: %04x  %3d%c  %3d%c  %3d%c  %6d %6d %6d "
 				"%6d %6d   %6d\n",
 			   dev->name, stats->status, stats->qual.qual,
-			   stats->qual.updated & 1 ? '.' : ' ',
+			   stats->qual.updated & IW_QUAL_QUAL_UPDATED
+			   ? '.' : ' ',
 			   ((__u8) stats->qual.level),
-			   stats->qual.updated & 2 ? '.' : ' ',
+			   stats->qual.updated & IW_QUAL_LEVEL_UPDATED
+			   ? '.' : ' ',
 			   ((__u8) stats->qual.noise),
-			   stats->qual.updated & 4 ? '.' : ' ',
+			   stats->qual.updated & IW_QUAL_NOISE_UPDATED
+			   ? '.' : ' ',
 			   stats->discard.nwid, stats->discard.code,
 			   stats->discard.fragment, stats->discard.retries,
 			   stats->discard.misc, stats->miss.beacon);
@@ -555,13 +587,15 @@ static inline int ioctl_export_private(s
 	/* Check NULL pointer */
 	if(iwr->u.data.pointer == NULL)
 		return -EFAULT;
-#ifdef WE_STRICT_WRITE
+
 	/* Check if there is enough buffer up there */
 	if(iwr->u.data.length < dev->wireless_handlers->num_private_args) {
-		printk(KERN_ERR "%s (WE) : Buffer for request SIOCGIWPRIV too small (%d<%d)\n", dev->name, iwr->u.data.length, dev->wireless_handlers->num_private_args);
+		/* User space can't know in advance how large the buffer
+		 * needs to be. Give it a hint, so that we can support
+		 * any size buffer we want somewhat efficiently... */
+		iwr->u.data.length = dev->wireless_handlers->num_private_args;
 		return -E2BIG;
 	}
-#endif	/* WE_STRICT_WRITE */
 
 	/* Set the number of available ioctls. */
 	iwr->u.data.length = dev->wireless_handlers->num_private_args;
@@ -590,7 +624,6 @@ static inline int ioctl_standard_call(st
 	const struct iw_ioctl_description *	descr;
 	struct iw_request_info			info;
 	int					ret = -EINVAL;
-	int					user_size = 0;
 
 	/* Get the description of the IOCTL */
 	if((cmd - SIOCIWFIRST) >= standard_ioctl_num)
@@ -621,8 +654,14 @@ static inline int ioctl_standard_call(st
 #endif	/* WE_SET_EVENT */
 	} else {
 		char *	extra;
+		int	extra_size;
+		int	user_length = 0;
 		int	err;
 
+		/* Calculate space needed by arguments. Always allocate
+		 * for max space. Easier, and won't last long... */
+		extra_size = descr->max_tokens * descr->token_size;
+
 		/* Check what user space is giving us */
 		if(IW_IS_SET(cmd)) {
 			/* Check NULL pointer */
@@ -639,18 +678,33 @@ static inline int ioctl_standard_call(st
 			if(iwr->u.data.pointer == NULL)
 				return -EFAULT;
 			/* Save user space buffer size for checking */
-			user_size = iwr->u.data.length;
+			user_length = iwr->u.data.length;
+
+			/* Don't check if user_length > max to allow forward
+			 * compatibility. The test user_length < min is
+			 * implied by the test at the end. */
+
+			/* Support for very large requests */
+			if((descr->flags & IW_DESCR_FLAG_NOMAX) &&
+			   (user_length > descr->max_tokens)) {
+				/* Allow userspace to GET more than max so
+				 * we can support any size GET requests.
+				 * There is still a limit : -ENOMEM. */
+				extra_size = user_length * descr->token_size;
+				/* Note : user_length is originally a __u16,
+				 * and token_size is controlled by us,
+				 * so extra_size won't get negative and
+				 * won't overflow... */
+			}
 		}
 
 #ifdef WE_IOCTL_DEBUG
 		printk(KERN_DEBUG "%s (WE) : Malloc %d bytes\n",
-		       dev->name, descr->max_tokens * descr->token_size);
+		       dev->name, extra_size);
 #endif	/* WE_IOCTL_DEBUG */
 
-		/* Always allocate for max space. Easier, and won't last
-		 * long... */
-		extra = kmalloc(descr->max_tokens * descr->token_size,
-				GFP_KERNEL);
+		/* Create the kernel buffer */
+		extra = kmalloc(extra_size, GFP_KERNEL);
 		if (extra == NULL) {
 			return -ENOMEM;
 		}
@@ -676,14 +730,11 @@ static inline int ioctl_standard_call(st
 
 		/* If we have something to return to the user */
 		if (!ret && IW_IS_GET(cmd)) {
-#ifdef WE_STRICT_WRITE
 			/* Check if there is enough buffer up there */
-			if(user_size < iwr->u.data.length) {
-				printk(KERN_ERR "%s (WE) : Buffer for request %04X too small (%d<%d)\n", dev->name, cmd, user_size, iwr->u.data.length);
+			if(user_length < iwr->u.data.length) {
 				kfree(extra);
 				return -E2BIG;
 			}
-#endif	/* WE_STRICT_WRITE */
 
 			err = copy_to_user(iwr->u.data.pointer, extra,
 					   iwr->u.data.length *
@@ -746,7 +797,7 @@ static inline int ioctl_private_call(str
 				     iw_handler		handler)
 {
 	struct iwreq *			iwr = (struct iwreq *) ifr;
-	struct iw_priv_args *		descr = NULL;
+	const struct iw_priv_args *	descr = NULL;
 	struct iw_request_info		info;
 	int				extra_size = 0;
 	int				i;
@@ -786,7 +837,7 @@ static inline int ioctl_private_call(str
 			   ((extra_size + offset) <= IFNAMSIZ))
 				extra_size = 0;
 		} else {
-			/* Size of set arguments */
+			/* Size of get arguments */
 			extra_size = get_priv_size(descr->get_args);
 
 			/* Does it fits in iwr ? */
@@ -816,7 +867,7 @@ static inline int ioctl_private_call(str
 				return -EFAULT;
 
 			/* Does it fits within bounds ? */
-			if(iwr->u.data.length > (descr->set_args &
+			if(iwr->u.data.length > (descr->get_args &
 						 IW_PRIV_SIZE_MASK))
 				return -E2BIG;
 		} else {
@@ -856,6 +907,14 @@ static inline int ioctl_private_call(str
 
 		/* If we have something to return to the user */
 		if (!ret && IW_IS_GET(cmd)) {
+
+			/* Adjust for the actual length if it's variable,
+			 * avoid leaking kernel bits outside. */
+			if (!(descr->get_args & IW_PRIV_SIZE_FIXED)) {
+				extra_size = adjust_priv_size(descr->get_args,
+							      &(iwr->u));
+			}
+
 			err = copy_to_user(iwr->u.data.pointer, extra,
 					   extra_size);
 			if (err)
@@ -1127,9 +1186,25 @@ void wireless_send_event(struct net_devi
  * One of the main advantage of centralising spy support here is that
  * it becomes much easier to improve and extend it without having to touch
  * the drivers. One example is the addition of the Spy-Threshold events.
- * Note : IW_WIRELESS_SPY is defined in iw_handler.h
  */
 
+/* ---------------------------------------------------------------- */
+/*
+ * Return the pointer to the spy data in the driver.
+ * Because this is called on the Rx path via wireless_spy_update(),
+ * we want it to be efficient...
+ */
+static inline struct iw_spy_data * get_spydata(struct net_device *dev)
+{
+	/* This is the new way */
+	if(dev->wireless_data)
+		return(dev->wireless_data->spy_data);
+
+	/* This is the old way. Doesn't work for multi-headed drivers.
+	 * It will be removed in the next version of WE. */
+	return (dev->priv + dev->wireless_handlers->spy_offset);
+}
+
 /*------------------------------------------------------------------*/
 /*
  * Standard Wireless Handler : set Spy List
@@ -1139,16 +1214,30 @@ int iw_handler_set_spy(struct net_device
 		       union iwreq_data *	wrqu,
 		       char *			extra)
 {
-#ifdef IW_WIRELESS_SPY
-	struct iw_spy_data *	spydata = (dev->priv +
-					   dev->wireless_handlers->spy_offset);
+	struct iw_spy_data *	spydata = get_spydata(dev);
 	struct sockaddr *	address = (struct sockaddr *) extra;
 
+	if(!dev->wireless_data)
+		/* Help user know that driver needs updating */
+		printk(KERN_DEBUG "%s (WE) : Driver using old/buggy spy support, please fix driver !\n",
+		       dev->name);
+	/* Make sure driver is not buggy or using the old API */
+	if(!spydata)
+		return -EOPNOTSUPP;
+
 	/* Disable spy collection while we copy the addresses.
-	 * As we don't disable interrupts, we need to do this to avoid races.
-	 * As we are the only writer, this is good enough. */
+	 * While we copy addresses, any call to wireless_spy_update()
+	 * will NOP. This is OK, as anyway the addresses are changing. */
 	spydata->spy_number = 0;
 
+	/* We want to operate without locking, because wireless_spy_update()
+	 * most likely will happen in the interrupt handler, and therefore
+	 * have its own locking constraints and needs performance.
+	 * The rtnl_lock() make sure we don't race with the other iw_handlers.
+	 * This make sure wireless_spy_update() "see" that the spy list
+	 * is temporarily disabled. */
+	wmb();
+
 	/* Are there are addresses to copy? */
 	if(wrqu->data.length > 0) {
 		int i;
@@ -1174,13 +1263,14 @@ int iw_handler_set_spy(struct net_device
 			       spydata->spy_address[i][5]);
 #endif	/* WE_SPY_DEBUG */
 	}
+
+	/* Make sure above is updated before re-enabling */
+	wmb();
+
 	/* Enable addresses */
 	spydata->spy_number = wrqu->data.length;
 
 	return 0;
-#else /* IW_WIRELESS_SPY */
-	return -EOPNOTSUPP;
-#endif /* IW_WIRELESS_SPY */
 }
 
 /*------------------------------------------------------------------*/
@@ -1192,12 +1282,14 @@ int iw_handler_get_spy(struct net_device
 		       union iwreq_data *	wrqu,
 		       char *			extra)
 {
-#ifdef IW_WIRELESS_SPY
-	struct iw_spy_data *	spydata = (dev->priv +
-					   dev->wireless_handlers->spy_offset);
+	struct iw_spy_data *	spydata = get_spydata(dev);
 	struct sockaddr *	address = (struct sockaddr *) extra;
 	int			i;
 
+	/* Make sure driver is not buggy or using the old API */
+	if(!spydata)
+		return -EOPNOTSUPP;
+
 	wrqu->data.length = spydata->spy_number;
 
 	/* Copy addresses. */
@@ -1214,9 +1306,6 @@ int iw_handler_get_spy(struct net_device
 	for(i = 0; i < spydata->spy_number; i++)
 		spydata->spy_stat[i].updated = 0;
 	return 0;
-#else /* IW_WIRELESS_SPY */
-	return -EOPNOTSUPP;
-#endif /* IW_WIRELESS_SPY */
 }
 
 /*------------------------------------------------------------------*/
@@ -1228,11 +1317,13 @@ int iw_handler_set_thrspy(struct net_dev
 			  union iwreq_data *	wrqu,
 			  char *		extra)
 {
-#ifdef IW_WIRELESS_THRSPY
-	struct iw_spy_data *	spydata = (dev->priv +
-					   dev->wireless_handlers->spy_offset);
+	struct iw_spy_data *	spydata = get_spydata(dev);
 	struct iw_thrspy *	threshold = (struct iw_thrspy *) extra;
 
+	/* Make sure driver is not buggy or using the old API */
+	if(!spydata)
+		return -EOPNOTSUPP;
+
 	/* Just do it */
 	memcpy(&(spydata->spy_thr_low), &(threshold->low),
 	       2 * sizeof(struct iw_quality));
@@ -1245,9 +1336,6 @@ int iw_handler_set_thrspy(struct net_dev
 #endif	/* WE_SPY_DEBUG */
 
 	return 0;
-#else /* IW_WIRELESS_THRSPY */
-	return -EOPNOTSUPP;
-#endif /* IW_WIRELESS_THRSPY */
 }
 
 /*------------------------------------------------------------------*/
@@ -1259,22 +1347,20 @@ int iw_handler_get_thrspy(struct net_dev
 			  union iwreq_data *	wrqu,
 			  char *		extra)
 {
-#ifdef IW_WIRELESS_THRSPY
-	struct iw_spy_data *	spydata = (dev->priv +
-					   dev->wireless_handlers->spy_offset);
+	struct iw_spy_data *	spydata = get_spydata(dev);
 	struct iw_thrspy *	threshold = (struct iw_thrspy *) extra;
 
+	/* Make sure driver is not buggy or using the old API */
+	if(!spydata)
+		return -EOPNOTSUPP;
+
 	/* Just do it */
 	memcpy(&(threshold->low), &(spydata->spy_thr_low),
 	       2 * sizeof(struct iw_quality));
 
 	return 0;
-#else /* IW_WIRELESS_THRSPY */
-	return -EOPNOTSUPP;
-#endif /* IW_WIRELESS_THRSPY */
 }
 
-#ifdef IW_WIRELESS_THRSPY
 /*------------------------------------------------------------------*/
 /*
  * Prepare and send a Spy Threshold event
@@ -1312,7 +1398,6 @@ static void iw_send_thrspy_event(struct 
 	/* Send event to user space */
 	wireless_send_event(dev, SIOCGIWTHRSPY, &wrqu, (char *) &threshold);
 }
-#endif /* IW_WIRELESS_THRSPY */
 
 /* ---------------------------------------------------------------- */
 /*
@@ -1325,12 +1410,14 @@ void wireless_spy_update(struct net_devi
 			 unsigned char *	address,
 			 struct iw_quality *	wstats)
 {
-#ifdef IW_WIRELESS_SPY
-	struct iw_spy_data *	spydata = (dev->priv +
-					   dev->wireless_handlers->spy_offset);
+	struct iw_spy_data *	spydata = get_spydata(dev);
 	int			i;
 	int			match = -1;
 
+	/* Make sure driver is not buggy or using the old API */
+	if(!spydata)
+		return;
+
 #ifdef WE_SPY_DEBUG
 	printk(KERN_DEBUG "wireless_spy_update() :  offset %ld, spydata %p, address %02X:%02X:%02X:%02X:%02X:%02X\n", dev->wireless_handlers->spy_offset, spydata, address[0], address[1], address[2], address[3], address[4], address[5]);
 #endif	/* WE_SPY_DEBUG */
@@ -1342,7 +1429,7 @@ void wireless_spy_update(struct net_devi
 			       sizeof(struct iw_quality));
 			match = i;
 		}
-#ifdef IW_WIRELESS_THRSPY
+
 	/* Generate an event if we cross the spy threshold.
 	 * To avoid event storms, we have a simple hysteresis : we generate
 	 * event only when we go under the low threshold or above the
@@ -1362,8 +1449,6 @@ void wireless_spy_update(struct net_devi
 			}
 		}
 	}
-#endif /* IW_WIRELESS_THRSPY */
-#endif /* IW_WIRELESS_SPY */
 }
 
 EXPORT_SYMBOL(iw_handler_get_spy);

