Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277695AbRJICMz>; Mon, 8 Oct 2001 22:12:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277697AbRJICMh>; Mon, 8 Oct 2001 22:12:37 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:12495 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S277695AbRJICMS>;
	Mon, 8 Oct 2001 22:12:18 -0400
Date: Mon, 8 Oct 2001 19:12:47 -0700
To: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Wireless Extension update
Message-ID: <20011008191247.B6816@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi,

	Surprise, it's not an IrDA patch ! Just a quick update of the
Wireless Extensions definitions. Drivers are comming next...

	Changelog :
	o Define our own wireless device private ioctl range to avoid
name space collisions with stuff like 'mii-tools'.
	o Update various statistics bits

	Would you mind pushing that in the kernel ? That would allow
me to push out the new Wireless Tools and send driver patches to the
various maintainers..
	Thanks...

	Jean

diff -u -p linux/include/linux/wireless.w11.h linux/include/linux/wireless.h
--- linux/include/linux/wireless.w11.h	Fri Oct  5 18:36:40 2001
+++ linux/include/linux/wireless.h	Tue Oct  9 00:22:03 2001
@@ -1,7 +1,7 @@
 /*
  * This file define a set of standard wireless extensions
  *
- * Version :	11	28.3.01
+ * Version :	12	5.10.01
  *
  * Authors :	Jean Tourrilhes - HPL - <jt@hpl.hp.com>
  */
@@ -63,7 +63,7 @@
  * (there is some stuff that will be added in the future...)
  * I just plan to increment with each new version.
  */
-#define WIRELESS_EXT	11
+#define WIRELESS_EXT	12
 
 /*
  * Changes :
@@ -116,6 +116,13 @@
  * ----------
  *	- Add WE version in range (help backward/forward compatibility)
  *	- Add retry ioctls (work like PM)
+ *
+ * V11 to V12
+ * ----------
+ *	- Add SIOCSIWSTATS to get /proc/net/wireless programatically
+ *	- Add DEV PRIVATE IOCTL to avoid collisions in SIOCDEVPRIVATE space
+ *	- Add new statistics (frag, retry, beacon)
+ *	- Add average quality (for user space calibration)
  */
 
 /* -------------------------- IOCTL LIST -------------------------- */
@@ -137,6 +144,8 @@
 #define SIOCGIWRANGE	0x8B0B		/* Get range of parameters */
 #define SIOCSIWPRIV	0x8B0C		/* Unused */
 #define SIOCGIWPRIV	0x8B0D		/* get private ioctl interface info */
+#define SIOCSIWSTATS	0x8B0E		/* Unused */
+#define SIOCGIWSTATS	0x8B0F		/* Get /proc/net/wireless stats */
 
 /* Mobile IP support */
 #define SIOCSIWSPY	0x8B10		/* set spy addresses */
@@ -177,11 +186,33 @@
 #define SIOCSIWPOWER	0x8B2C		/* set Power Management settings */
 #define SIOCGIWPOWER	0x8B2D		/* get Power Management settings */
 
+/* -------------------- DEV PRIVATE IOCTL LIST -------------------- */
+
+/* These 16 ioctl are wireless device private.
+ * Each driver is free to use them for whatever purpose it chooses,
+ * however the driver *must* export the description of those ioctls
+ * with SIOCGIWPRIV and *must* use arguments as defined below.
+ * If you don't follow those rules, DaveM is going to hate you (reason :
+ * it make mixed 32/64bit operation impossible).
+ */
+#define SIOCIWFIRSTPRIV	0x8BE0
+#define SIOCIWLASTPRIV	0x8BFF
+/* Previously, we were using SIOCDEVPRIVATE, but we know have our
+ * separate range because of collisions with other tools such as
+ * 'mii-tool'.
+ * We now have 32 commands, so a bit more space ;-).
+ * Also, all 'odd' commands are only usable by root and don't return the
+ * content of ifr/iwr to user (but you are not obliged to use the set/get
+ * convention, just use every other two command).
+ * And I repeat : you are not obliged to use them with iwspy, but you
+ * must be compliant with it.
+ */
+
 /* ------------------------- IOCTL STUFF ------------------------- */
 
 /* The first and the last (range) */
 #define SIOCIWFIRST	0x8B00
-#define SIOCIWLAST	0x8B30
+#define SIOCIWLAST	SIOCIWLASTPRIV		/* 0x8BFF */
 
 /* Even : get (world access), odd : set (root access) */
 #define IW_IS_SET(cmd)	(!((cmd) & 0x1))
@@ -191,7 +222,7 @@
 /*
  * The following is used with SIOCGIWPRIV. It allow a driver to define
  * the interface (name, type of data) for its private ioctl.
- * Privates ioctl are SIOCDEVPRIVATE -> SIOCDEVPRIVATE + 0xF
+ * Privates ioctl are SIOCIWFIRSTPRIV -> SIOCIWLASTPRIV
  */
 
 #define IW_PRIV_TYPE_MASK	0x7000	/* Type of arguments */
@@ -334,23 +365,38 @@ struct	iw_freq
  */
 struct	iw_quality
 {
-	__u8		qual;		/* link quality (%retries, SNR or better...) */
-	__u8		level;		/* signal level */
-	__u8		noise;		/* noise level */
+	__u8		qual;		/* link quality (%retries, SNR,
+					   %missed beacons or better...) */
+	__u8		level;		/* signal level (dBm) */
+	__u8		noise;		/* noise level (dBm) */
 	__u8		updated;	/* Flags to know if updated */
 };
 
 /*
  *	Packet discarded in the wireless adapter due to
  *	"wireless" specific problems...
+ *	Note : the list of counter and statistics in net_device_stats
+ *	is already pretty exhaustive, and you should use that first.
+ *	This is only additional stats...
  */
 struct	iw_discarded
 {
-	__u32		nwid;		/* Wrong nwid */
-	__u32		code;		/* Unable to code/decode */
+	__u32		nwid;		/* Rx : Wrong nwid/essid */
+	__u32		code;		/* Rx : Unable to code/decode (WEP) */
+	__u32		fragment;	/* Rx : Can't perform MAC reassembly */
+	__u32		retries;	/* Tx : Max MAC retries num reached */
 	__u32		misc;		/* Others cases */
 };
 
+/*
+ *	Packet/Time period missed in the wireless adapter due to
+ *	"wireless" specific problems...
+ */
+struct	iw_missed
+{
+	__u32		beacon;		/* Missed beacons/superframe */
+};
+
 /* ------------------------ WIRELESS STATS ------------------------ */
 /*
  * Wireless statistics (used for /proc/net/wireless)
@@ -363,6 +409,7 @@ struct	iw_statistics
 	struct iw_quality	qual;		/* Quality of the link
 						 * (instant/mean/max) */
 	struct iw_discarded	discard;	/* Packet discarded counts */
+	struct iw_missed	miss;		/* Packet missed counts */
 };
 
 /* ------------------------ IOCTL REQUEST ------------------------ */
@@ -493,6 +540,19 @@ struct	iw_range
 	__s32		max_retry;	/* Maximal number of retries */
 	__s32		min_r_time;	/* Minimal retry lifetime */
 	__s32		max_r_time;	/* Maximal retry lifetime */
+
+	/* Average quality of link & SNR */
+	struct iw_quality	avg_qual;	/* Quality of the link */
+	/* This should contain the average/typical values of the quality
+	 * indicator. This should be the threshold between a "good" and
+	 * a "bad" link (example : monitor going from green to orange).
+	 * Currently, user space apps like quality monitors don't have any
+	 * way to calibrate the measurement. With this, they can split
+	 * the range between 0 and max_qual in different quality level
+	 * (using a geometric subdivision centered on the average).
+	 * I expect that people doing the user space apps will feedback
+	 * us on which value we need to put in each driver...
+	 */
 };
 
 /*
diff -u -p linux/net/core/dev.w11.c linux/net/core/dev.c
--- linux/net/core/dev.w11.c	Fri Oct  5 18:39:10 2001
+++ linux/net/core/dev.c	Mon Oct  8 18:36:03 2001
@@ -1817,7 +1817,7 @@ static int sprintf_wireless_stats(char *
 
 	if (stats != (struct iw_statistics *) NULL) {
 		size = sprintf(buffer,
-			       "%6s: %04x  %3d%c  %3d%c  %3d%c  %6d %6d %6d\n",
+			       "%6s: %04x  %3d%c  %3d%c  %3d%c  %6d %6d %6d %6d %6d   %6d\n",
 			       dev->name,
 			       stats->status,
 			       stats->qual.qual,
@@ -1828,7 +1828,10 @@ static int sprintf_wireless_stats(char *
 			       stats->qual.updated & 4 ? '.' : ' ',
 			       stats->discard.nwid,
 			       stats->discard.code,
-			       stats->discard.misc);
+			       stats->discard.fragment,
+			       stats->discard.retries,
+			       stats->discard.misc,
+			       stats->miss.beacon);
 		stats->qual.updated = 0;
 	}
 	else
@@ -1852,8 +1855,8 @@ static int dev_get_wireless_info(char * 
 	struct net_device *	dev;
 
 	size = sprintf(buffer,
-		       "Inter-| sta-|   Quality        |   Discarded packets\n"
-		       " face | tus | link level noise |  nwid  crypt   misc\n"
+		       "Inter-| sta-|   Quality        |   Discarded packets               | Missed\n"
+		       " face | tus | link level noise |  nwid  crypt   frag  retry   misc | beacon\n"
 			);
 	
 	pos += size;
@@ -1884,6 +1887,33 @@ static int dev_get_wireless_info(char * 
 	return len;
 }
 #endif	/* CONFIG_PROC_FS */
+
+/*
+ *	Allow programatic access to /proc/net/wireless even if /proc
+ *	doesn't exist... Also more efficient...
+ */
+static inline int dev_iwstats(struct net_device *dev, struct ifreq *ifr)
+{
+	/* Get stats from the driver */
+	struct iw_statistics *stats = (dev->get_wireless_stats ?
+				       dev->get_wireless_stats(dev) :
+				       (struct iw_statistics *) NULL);
+
+	if (stats != (struct iw_statistics *) NULL) {
+		struct iwreq *	wrq = (struct iwreq *)ifr;
+
+		/* Copy statistics to the user buffer */
+		if(copy_to_user(wrq->u.data.pointer, stats,
+				sizeof(struct iw_statistics)))
+			return -EFAULT;
+
+		/* Check if we need to clear the update flag */
+		if(wrq->u.data.flags != 0)
+			stats->qual.updated = 0;
+		return(0);
+	} else
+		return -EOPNOTSUPP;
+}
 #endif	/* WIRELESS_EXT */
 
 /**
@@ -2182,6 +2212,11 @@ static int dev_ifsioc(struct ifreq *ifr,
 			dev->name[IFNAMSIZ-1] = 0;
 			notifier_call_chain(&netdev_chain, NETDEV_CHANGENAME, dev);
 			return 0;
+
+#ifdef WIRELESS_EXT
+		case SIOCGIWSTATS:
+			return dev_iwstats(dev, ifr);
+#endif	/* WIRELESS_EXT */
 
 		/*
 		 *	Unknown or private ioctl
