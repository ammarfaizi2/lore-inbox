Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262266AbSJ2T4j>; Tue, 29 Oct 2002 14:56:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262250AbSJ2T4i>; Tue, 29 Oct 2002 14:56:38 -0500
Received: from pina.terra.com.br ([200.176.3.17]:4286 "EHLO pina.terra.com.br")
	by vger.kernel.org with ESMTP id <S262360AbSJ2TyF>;
	Tue, 29 Oct 2002 14:54:05 -0500
Subject: [PATCH 2.5.44] Pktgen for 2.5.44
From: Lucio Maciel <abslucio@terra.com.br>
To: LKML <linux-kernel@vger.kernel.org>
Cc: "David S. Miller" <davem@redhat.com>,
       Robert Olsson <Robert.Olsson@data.slu.se>
Content-Type: multipart/mixed; boundary="=-2KZa7lEe5/d7Rwv4uVva"
X-Mailer: Ximian Evolution 1.0.7 
Date: 29 Oct 2002 17:00:23 -0300
Message-Id: <1035921624.601.11.camel@walker>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-2KZa7lEe5/d7Rwv4uVva
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hello...

I have ported (integrated sounds better i think...) pktgen from
2.4.20-rc1 to 2.5.44...

I only need to change current->need_resched to need_resched() in the
source... works fine for me....

I also correct the documentation changing multiskb to clone_skb


best regards
-- 
::: Lucio F. Maciel
::: abslucio@terra.com.br
::: icq 93065464
::: Absoluta.net

--=-2KZa7lEe5/d7Rwv4uVva
Content-Disposition: attachment; filename=pktgen.diff
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-patch; name=pktgen.diff; charset=ANSI_X3.4-1968

diff -Naur -X /root/dontdiff linux-2.5.44-ori/Documentation/networking/pktg=
en.txt linux-2.5.44/Documentation/networking/pktgen.txt
--- linux-2.5.44-ori/Documentation/networking/pktgen.txt	1969-12-31 21:00:0=
0.000000000 -0300
+++ linux-2.5.44/Documentation/networking/pktgen.txt	2002-10-29 15:28:51.00=
0000000 -0300
@@ -0,0 +1,77 @@
+How to use the Linux packet generator module.
+
+1. Enable CONFIG_NET_PKTGEN to compile and build pktgen.o, install it
+   in the place where insmod may find it.
+2. Cut script "ipg" (see below).
+3. Edit script to set preferred device and destination IP address.
+3a.  Create more scripts for different interfaces.  Up to thirty-two
+     pktgen processes can be configured and run at once by using the
+     32 /proc/net/pktgen/pg* files.
+4. Run in shell: ". ipg"
+5. After this two commands are defined:
+   A. "pg" to start generator and to get results.
+   B. "pgset" to change generator parameters. F.e.
+      pgset "clone_skb 100"   sets the number of coppies of the same packe=
t=20
+                              will be sent before a new packet is allocate=
d
+      pgset "clone_skb 0"     use multiple SKBs for packet generation
+      pgset "pkt_size 9014"   sets packet size to 9014
+      pgset "frags 5"         packet will consist of 5 fragments
+      pgset "count 200000"    sets number of packets to send, set to zero
+                              for continious sends untill explicitly
+                              stopped.
+      pgset "ipg 5000"        sets artificial gap inserted between packets
+                              to 5000 nanoseconds
+      pgset "dst 10.0.0.1"    sets IP destination address
+                              (BEWARE! This generator is very aggressive!)
+      pgset "dst_min 10.0.0.1"            Same as dst
+      pgset "dst_max 10.0.0.254"          Set the maximum destination IP.
+      pgset "src_min 10.0.0.1"            Set the minimum (or only) source=
 IP.
+      pgset "src_max 10.0.0.254"          Set the maximum source IP.
+      pgset "dstmac 00:00:00:00:00:00"    sets MAC destination address
+      pgset "srcmac 00:00:00:00:00:00"    sets MAC source address
+      pgset "src_mac_count 1" Sets the number of MACs we'll range through.=
  The
+                              'minimum' MAC is what you set with srcmac.
+      pgset "dst_mac_count 1" Sets the number of MACs we'll range through.=
  The
+                              'minimum' MAC is what you set with dstmac.
+      pgset "flag [name]"     Set a flag to determine behaviour.  Current =
flags
+                              are: IPSRC_RND #IP Source is random (between=
 min/max),
+                                   IPDST_RND, UDPSRC_RND,
+                                   UDPDST_RND, MACSRC_RND, MACDST_RND=20
+      pgset "udp_src_min 9"   set UDP source port min, If < udp_src_max, t=
hen
+                              cycle through the port range.
+      pgset "udp_src_max 9"   set UDP source port max.
+      pgset "udp_dst_min 9"   set UDP destination port min, If < udp_dst_m=
ax, then
+                              cycle through the port range.
+      pgset "udp_dst_max 9"   set UDP destination port max.
+      pgset stop    	      aborts injection
+     =20
+  Also, ^C aborts generator.
+
+---- cut here
+
+#! /bin/sh
+
+modprobe pktgen
+
+PGDEV=3D/proc/net/pktgen/pg0
+
+function pgset() {
+    local result
+
+    echo $1 > $PGDEV
+
+    result=3D`cat $PGDEV | fgrep "Result: OK:"`
+    if [ "$result" =3D "" ]; then
+         cat $PGDEV | fgrep Result:
+    fi
+}
+
+function pg() {
+    echo inject > $PGDEV
+    cat $PGDEV
+}
+
+pgset "odev eth0"
+pgset "dst 0.0.0.0"
+
+---- cut here
diff -Naur -X /root/dontdiff linux-2.5.44-ori/arch/i386/defconfig linux-2.5=
.44/arch/i386/defconfig
--- linux-2.5.44-ori/arch/i386/defconfig	2002-10-19 01:02:24.000000000 -030=
0
+++ linux-2.5.44/arch/i386/defconfig	2002-10-29 15:55:04.000000000 -0300
@@ -443,6 +443,11 @@
 # CONFIG_NET_SCHED is not set
=20
 #
+# Network testing
+#
+# CONFIG_NET_PKTGEN is not set
+
+#
 # Network device support
 #
 CONFIG_NETDEVICES=3Dy
diff -Naur -X /root/dontdiff linux-2.5.44-ori/net/Config.help linux-2.5.44/=
net/Config.help
--- linux-2.5.44-ori/net/Config.help	2002-10-19 01:01:15.000000000 -0300
+++ linux-2.5.44/net/Config.help	2002-10-29 15:53:00.000000000 -0300
@@ -512,3 +512,18 @@
   performance will be written to /proc/net/profile. If you don't know
   what it is about, you don't need it: say N.
=20
+CONFIG_NET_PKTGEN
+  This module will inject preconfigured packets, at a configurable
+  rate, out of a given interface.  It is used for network interface
+  stress testing and performance analysis.  If you don't understand
+  what was just said, you don't need it: say N.
+
+  Documentation on how to use the packet generator can be found
+  at <file:Documentation/networking/pktgen.txt>.
+
+  This code is also available as a module called pktgen.o ( =3D code
+  which can be inserted in and removed from the running kernel
+  whenever you want).  If you want to compile it as a module, say M
+  here and read <file:Documentation/modules.txt>.
+
+
diff -Naur -X /root/dontdiff linux-2.5.44-ori/net/Config.in linux-2.5.44/ne=
t/Config.in
--- linux-2.5.44-ori/net/Config.in	2002-10-19 01:01:18.000000000 -0300
+++ linux-2.5.44/net/Config.in	2002-10-29 14:13:11.000000000 -0300
@@ -93,4 +93,10 @@
 #bool 'Network code profiler' CONFIG_NET_PROFILE
 endmenu
=20
+mainmenu_option next_comment
+comment 'Network testing'
+tristate 'Packet Generator (USE WITH CAUTION)' CONFIG_NET_PKTGEN
+endmenu
+
+
 endmenu
diff -Naur -X /root/dontdiff linux-2.5.44-ori/net/core/Makefile linux-2.5.4=
4/net/core/Makefile
--- linux-2.5.44-ori/net/core/Makefile	2002-10-19 01:02:31.000000000 -0300
+++ linux-2.5.44/net/core/Makefile	2002-10-29 14:13:33.000000000 -0300
@@ -17,6 +17,7 @@
 obj-$(CONFIG_NETFILTER) +=3D netfilter.o
 obj-$(CONFIG_NET_DIVERT) +=3D dv.o
 obj-$(CONFIG_NET_PROFILE) +=3D profile.o
+obj-$(CONFIG_NET_PKTGEN) +=3D pktgen.o
 obj-$(CONFIG_NET_RADIO) +=3D wireless.o
 # Ugly. I wish all wireless drivers were moved in drivers/net/wireless
 obj-$(CONFIG_NET_PCMCIA_RADIO) +=3D wireless.o
diff -Naur -X /root/dontdiff linux-2.5.44-ori/net/core/pktgen.c linux-2.5.4=
4/net/core/pktgen.c
--- linux-2.5.44-ori/net/core/pktgen.c	1969-12-31 21:00:00.000000000 -0300
+++ linux-2.5.44/net/core/pktgen.c	2002-10-29 15:50:23.000000000 -0300
@@ -0,0 +1,1388 @@
+/* -*-linux-c-*-
+ * $Id: pktgen.c,v 1.8 2002/07/15 19:30:17 robert Exp $
+ * pktgen.c: Packet Generator for performance evaluation.
+ *
+ * Copyright 2001, 2002 by Robert Olsson <robert.olsson@its.uu.se>
+ *				 Uppsala University, Sweden
+ *
+ * A tool for loading the network with preconfigurated packets.
+ * The tool is implemented as a linux module.  Parameters are output=20
+ * device, IPG (interpacket gap), number of packets, and whether
+ * to use multiple SKBs or just the same one.
+ * pktgen uses the installed interface's output routine.
+ *
+ * Additional hacking by:
+ *
+ * Jens.Laas@data.slu.se
+ * Improved by ANK. 010120.
+ * Improved by ANK even more. 010212.
+ * MAC address typo fixed. 010417 --ro
+ * Integrated.  020301 --DaveM
+ * Added multiskb option 020301 --DaveM
+ * Scaling of results. 020417--sigurdur@linpro.no
+ * Significant re-work of the module:
+ *   *  Updated to support generation over multiple interfaces at once
+ *       by creating 32 /proc/net/pg* files.  Each file can be manipulated
+ *       individually.
+ *   *  Converted many counters to __u64 to allow longer runs.
+ *   *  Allow configuration of ranges, like min/max IP address, MACs,
+ *       and UDP-ports, for both source and destination, and can
+ *       set to use a random distribution or sequentially walk the range.
+ *   *  Can now change some values after starting.
+ *   *  Place 12-byte packet in UDP payload with magic number,
+ *       sequence number, and timestamp.  Will write receiver next.
+ *   *  The new changes seem to have a performance impact of around 1%,
+ *       as far as I can tell.
+ *   --Ben Greear <greearb@candelatech.com>
+ * Integrated to 2.5.x 021029 --Lucio Maciel (luciomaciel@zipmail.com.br)
+ *
+ * Renamed multiskb to clone_skb and cleaned up sending core for two disti=
nct=20
+ * skb modes. A clone_skb=3D0 mode for Ben "ranges" work and a clone_skb !=
=3D 0=20
+ * as a "fastpath" with a configurable number of clones after alloc's.
+ *
+ * clone_skb=3D0 means all packets are allocated this also means ranges ti=
me=20
+ * stamps etc can be used. clone_skb=3D100 means 1 malloc is followed by 1=
00=20
+ * clones.
+ *
+ * Also moved to /proc/net/pktgen/=20
+ * --ro=20
+ *
+ * See Documentation/networking/pktgen.txt for how to use this.
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/sched.h>
+#include <linux/types.h>
+#include <linux/string.h>
+#include <linux/ptrace.h>
+#include <linux/errno.h>
+#include <linux/ioport.h>
+#include <linux/slab.h>
+#include <linux/interrupt.h>
+#include <linux/pci.h>
+#include <linux/delay.h>
+#include <linux/init.h>
+#include <linux/inet.h>
+#include <asm/byteorder.h>
+#include <asm/bitops.h>
+#include <asm/io.h>
+#include <asm/dma.h>
+#include <asm/uaccess.h>
+
+#include <linux/in.h>
+#include <linux/ip.h>
+#include <linux/udp.h>
+#include <linux/skbuff.h>
+#include <linux/netdevice.h>
+#include <linux/inetdevice.h>
+#include <linux/rtnetlink.h>
+#include <linux/proc_fs.h>
+#include <linux/if_arp.h>
+#include <net/checksum.h>
+#include <asm/timex.h>
+
+#define cycles()	((u32)get_cycles())
+
+
+#define VERSION "pktgen version 1.2"
+static char version[] __initdata =3D=20
+  "pktgen.c: v1.2: Packet Generator for packet performance testing.\n";
+
+/* Used to help with determining the pkts on receive */
+
+#define PKTGEN_MAGIC 0xbe9be955
+
+
+/* Keep information per interface */
+struct pktgen_info {
+	/* Parameters */
+
+	/* If min !=3D max, then we will either do a linear iteration, or
+	 * we will do a random selection from within the range.
+	 */
+	__u32 flags;    =20
+
+#define F_IPSRC_RND   (1<<0)  /* IP-Src Random  */
+#define F_IPDST_RND   (1<<1)  /* IP-Dst Random  */
+#define F_UDPSRC_RND  (1<<2)  /* UDP-Src Random */
+#define F_UDPDST_RND  (1<<3)  /* UDP-Dst Random */
+#define F_MACSRC_RND  (1<<4)  /* MAC-Src Random */
+#define F_MACDST_RND  (1<<5)  /* MAC-Dst Random */
+#define F_SET_SRCMAC  (1<<6)  /* Specify-Src-Mac=20
+				 (default is to use Interface's MAC Addr) */
+#define F_SET_SRCIP   (1<<7)  /*  Specify-Src-IP
+				  (default is to use Interface's IP Addr) */=20
+
+=09
+	int pkt_size;    /* =3D ETH_ZLEN; */
+	int nfrags;
+	__u32 ipg;       /* Default Interpacket gap in nsec */
+	__u64 count;     /* Default No packets to send */
+	__u64 sofar;     /* How many pkts we've sent so far */
+	__u64 errors;    /* Errors when trying to transmit, pkts will be re-sent =
*/
+	struct timeval started_at;
+	struct timeval stopped_at;
+	__u64 idle_acc;
+	__u32 seq_num;
+=09
+	int clone_skb;   /* Use multiple SKBs during packet gen.  If this number
+			  * is greater than 1, then that many coppies of the same
+			  * packet will be sent before a new packet is allocated.
+			  * For instance, if you want to send 1024 identical packets
+			  * before creating a new packet, set clone_skb to 1024.
+			  */
+	int busy;
+	int do_run_run;   /* if this changes to false, the test will stop */
+=09
+	char outdev[32];
+	char dst_min[32];
+	char dst_max[32];
+	char src_min[32];
+	char src_max[32];
+
+	/* If we're doing ranges, random or incremental, then this
+	 * defines the min/max for those ranges.
+	 */
+	__u32 saddr_min; /* inclusive, source IP address */
+	__u32 saddr_max; /* exclusive, source IP address */
+	__u32 daddr_min; /* inclusive, dest IP address */
+	__u32 daddr_max; /* exclusive, dest IP address */
+
+	__u16 udp_src_min; /* inclusive, source UDP port */
+	__u16 udp_src_max; /* exclusive, source UDP port */
+	__u16 udp_dst_min; /* inclusive, dest UDP port */
+	__u16 udp_dst_max; /* exclusive, dest UDP port */
+
+	__u32 src_mac_count; /* How many MACs to iterate through */
+	__u32 dst_mac_count; /* How many MACs to iterate through */
+=09
+	unsigned char dst_mac[6];
+	unsigned char src_mac[6];
+=09
+	__u32 cur_dst_mac_offset;
+	__u32 cur_src_mac_offset;
+	__u32 cur_saddr;
+	__u32 cur_daddr;
+	__u16 cur_udp_dst;
+	__u16 cur_udp_src;
+=09
+	__u8 hh[14];
+	/* =3D {=20
+	   0x00, 0x80, 0xC8, 0x79, 0xB3, 0xCB,=20
+	  =20
+	   We fill in SRC address later
+	   0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	   0x08, 0x00
+	   };
+	*/
+	__u16 pad; /* pad out the hh struct to an even 16 bytes */
+	char result[512];
+
+	/* proc file names */
+	char fname[80];
+	char busy_fname[80];
+=09
+	struct proc_dir_entry *proc_ent;
+	struct proc_dir_entry *busy_proc_ent;
+};
+
+struct pktgen_hdr {
+	__u32 pgh_magic;
+	__u32 seq_num;
+	struct timeval timestamp;
+};
+
+static int cpu_speed;
+static int debug;
+
+/* Module parameters, defaults. */
+static int count_d =3D 100000;
+static int ipg_d =3D 0;
+static int clone_skb_d =3D 0;
+
+
+#define MAX_PKTGEN 8
+static struct pktgen_info pginfos[MAX_PKTGEN];
+
+
+/** Convert to miliseconds */
+inline __u64 tv_to_ms(const struct timeval* tv) {
+	__u64 ms =3D tv->tv_usec / 1000;
+	ms +=3D (__u64)tv->tv_sec * (__u64)1000;
+	return ms;
+}
+
+inline __u64 getCurMs(void) {
+	struct timeval tv;
+	do_gettimeofday(&tv);
+	return tv_to_ms(&tv);
+}
+
+#define PG_PROC_DIR "pktgen"
+static struct proc_dir_entry *proc_dir =3D 0;
+
+static struct net_device *setup_inject(struct pktgen_info* info)
+{
+	struct net_device *odev;
+
+	rtnl_lock();
+	odev =3D __dev_get_by_name(info->outdev);
+	if (!odev) {
+		sprintf(info->result, "No such netdevice: \"%s\"", info->outdev);
+		goto out_unlock;
+	}
+
+	if (odev->type !=3D ARPHRD_ETHER) {
+		sprintf(info->result, "Not ethernet device: \"%s\"", info->outdev);
+		goto out_unlock;
+	}
+
+	if (!netif_running(odev)) {
+		sprintf(info->result, "Device is down: \"%s\"", info->outdev);
+		goto out_unlock;
+	}
+
+	/* Default to the interface's mac if not explicitly set. */
+	if (!(info->flags & F_SET_SRCMAC)) {
+		memcpy(&(info->hh[6]), odev->dev_addr, 6);
+	}
+	else {
+		memcpy(&(info->hh[6]), info->src_mac, 6);
+	}
+
+	/* Set up Dest MAC */
+	memcpy(&(info->hh[0]), info->dst_mac, 6);
+=09
+	info->saddr_min =3D 0;
+	info->saddr_max =3D 0;
+	if (strlen(info->src_min) =3D=3D 0) {
+		if (odev->ip_ptr) {
+			struct in_device *in_dev =3D odev->ip_ptr;
+
+			if (in_dev->ifa_list) {
+				info->saddr_min =3D in_dev->ifa_list->ifa_address;
+				info->saddr_max =3D info->saddr_min;
+			}
+		}
+	}
+	else {
+		info->saddr_min =3D in_aton(info->src_min);
+		info->saddr_max =3D in_aton(info->src_max);
+	}
+
+	info->daddr_min =3D in_aton(info->dst_min);
+	info->daddr_max =3D in_aton(info->dst_max);
+
+	/* Initialize current values. */
+	info->cur_dst_mac_offset =3D 0;
+	info->cur_src_mac_offset =3D 0;
+	info->cur_saddr =3D info->saddr_min;
+	info->cur_daddr =3D info->daddr_min;
+	info->cur_udp_dst =3D info->udp_dst_min;
+	info->cur_udp_src =3D info->udp_src_min;
+=09
+	atomic_inc(&odev->refcnt);
+	rtnl_unlock();
+
+	return odev;
+
+out_unlock:
+	rtnl_unlock();
+	return NULL;
+}
+
+static void nanospin(int ipg, struct pktgen_info* info)
+{
+	u32 idle_start, idle;
+
+	idle_start =3D cycles();
+
+	for (;;) {
+		barrier();
+		idle =3D cycles() - idle_start;
+		if (idle * 1000 >=3D ipg * cpu_speed)
+			break;
+	}
+	info->idle_acc +=3D idle;
+}
+
+static int calc_mhz(void)
+{
+	struct timeval start, stop;
+	u32 start_s, elapsed;
+
+	do_gettimeofday(&start);
+	start_s =3D cycles();
+	do {
+		barrier();
+		elapsed =3D cycles() - start_s;
+		if (elapsed =3D=3D 0)
+			return 0;
+	} while (elapsed < 1000 * 50000);
+	do_gettimeofday(&stop);
+	return elapsed/(stop.tv_usec-start.tv_usec+1000000*(stop.tv_sec-start.tv_=
sec));
+}
+
+static void cycles_calibrate(void)
+{
+	int i;
+
+	for (i =3D 0; i < 3; i++) {
+		int res =3D calc_mhz();
+		if (res > cpu_speed)
+			cpu_speed =3D res;
+	}
+}
+
+
+/* Increment/randomize headers according to flags and current values
+ * for IP src/dest, UDP src/dst port, MAC-Addr src/dst
+ */
+static void mod_cur_headers(struct pktgen_info* info) {=09
+	__u32 imn;
+	__u32 imx;
+=09
+	/*  Deal with source MAC */
+	if (info->src_mac_count > 1) {
+		__u32 mc;
+		__u32 tmp;
+		if (info->flags & F_MACSRC_RND) {
+			mc =3D net_random() % (info->src_mac_count);
+		}
+		else {
+			mc =3D info->cur_src_mac_offset++;
+			if (info->cur_src_mac_offset > info->src_mac_count) {
+				info->cur_src_mac_offset =3D 0;
+			}
+		}
+
+		tmp =3D info->src_mac[5] + (mc & 0xFF);
+		info->hh[11] =3D tmp;
+		tmp =3D (info->src_mac[4] + ((mc >> 8) & 0xFF) + (tmp >> 8));
+		info->hh[10] =3D tmp;
+		tmp =3D (info->src_mac[3] + ((mc >> 16) & 0xFF) + (tmp >> 8));
+		info->hh[9] =3D tmp;
+		tmp =3D (info->src_mac[2] + ((mc >> 24) & 0xFF) + (tmp >> 8));
+		info->hh[8] =3D tmp;
+		tmp =3D (info->src_mac[1] + (tmp >> 8));
+		info->hh[7] =3D tmp;=09
+	}
+
+	/*  Deal with Destination MAC */
+	if (info->dst_mac_count > 1) {
+		__u32 mc;
+		__u32 tmp;
+		if (info->flags & F_MACDST_RND) {
+			mc =3D net_random() % (info->dst_mac_count);
+		}
+		else {
+			mc =3D info->cur_dst_mac_offset++;
+			if (info->cur_dst_mac_offset > info->dst_mac_count) {
+				info->cur_dst_mac_offset =3D 0;
+			}
+		}
+
+		tmp =3D info->dst_mac[5] + (mc & 0xFF);
+		info->hh[5] =3D tmp;
+		tmp =3D (info->dst_mac[4] + ((mc >> 8) & 0xFF) + (tmp >> 8));
+		info->hh[4] =3D tmp;
+		tmp =3D (info->dst_mac[3] + ((mc >> 16) & 0xFF) + (tmp >> 8));
+		info->hh[3] =3D tmp;
+		tmp =3D (info->dst_mac[2] + ((mc >> 24) & 0xFF) + (tmp >> 8));
+		info->hh[2] =3D tmp;
+		tmp =3D (info->dst_mac[1] + (tmp >> 8));
+		info->hh[1] =3D tmp;=09
+	}
+
+	if (info->udp_src_min < info->udp_src_max) {
+		if (info->flags & F_UDPSRC_RND) {
+			info->cur_udp_src =3D ((net_random() % (info->udp_src_max - info->udp_s=
rc_min))
+					     + info->udp_src_min);
+		}
+		else {
+		     info->cur_udp_src++;
+		     if (info->cur_udp_src >=3D info->udp_src_max) {
+			     info->cur_udp_src =3D info->udp_src_min;
+		     }
+		}
+	}
+
+	if (info->udp_dst_min < info->udp_dst_max) {
+		if (info->flags & F_UDPDST_RND) {
+			info->cur_udp_dst =3D ((net_random() % (info->udp_dst_max - info->udp_d=
st_min))
+					     + info->udp_dst_min);
+		}
+		else {
+		     info->cur_udp_dst++;
+		     if (info->cur_udp_dst >=3D info->udp_dst_max) {
+			     info->cur_udp_dst =3D info->udp_dst_min;
+		     }
+		}
+	}
+
+	if ((imn =3D ntohl(info->saddr_min)) < (imx =3D ntohl(info->saddr_max))) =
{
+		__u32 t;
+		if (info->flags & F_IPSRC_RND) {
+			t =3D ((net_random() % (imx - imn)) + imn);
+		}
+		else {
+		     t =3D ntohl(info->cur_saddr);
+		     t++;
+		     if (t >=3D imx) {
+			     t =3D imn;
+		     }
+		}
+		info->cur_saddr =3D htonl(t);
+	}
+
+	if ((imn =3D ntohl(info->daddr_min)) < (imx =3D ntohl(info->daddr_max))) =
{
+		__u32 t;
+		if (info->flags & F_IPDST_RND) {
+			t =3D ((net_random() % (imx - imn)) + imn);
+		}
+		else {
+		     t =3D ntohl(info->cur_daddr);
+		     t++;
+		     if (t >=3D imx) {
+			     t =3D imn;
+		     }
+		}
+		info->cur_daddr =3D htonl(t);
+	}
+}/* mod_cur_headers */
+
+
+static struct sk_buff *fill_packet(struct net_device *odev, struct pktgen_=
info* info)
+{
+	struct sk_buff *skb =3D NULL;
+	__u8 *eth;
+	struct udphdr *udph;
+	int datalen, iplen;
+	struct iphdr *iph;
+	struct pktgen_hdr *pgh =3D NULL;
+=09
+	skb =3D alloc_skb(info->pkt_size + 64 + 16, GFP_ATOMIC);
+	if (!skb) {
+		sprintf(info->result, "No memory");
+		return NULL;
+	}
+
+	skb_reserve(skb, 16);
+
+	/*  Reserve for ethernet and IP header  */
+	eth =3D (__u8 *) skb_push(skb, 14);
+	iph =3D (struct iphdr *)skb_put(skb, sizeof(struct iphdr));
+	udph =3D (struct udphdr *)skb_put(skb, sizeof(struct udphdr));
+
+	/* Update any of the values, used when we're incrementing various
+	 * fields.
+	 */
+	mod_cur_headers(info);
+
+	memcpy(eth, info->hh, 14);
+=09
+	datalen =3D info->pkt_size - 14 - 20 - 8; /* Eth + IPh + UDPh */
+	if (datalen < sizeof(struct pktgen_hdr)) {
+		datalen =3D sizeof(struct pktgen_hdr);
+	}
+=09
+	udph->source =3D htons(info->cur_udp_src);
+	udph->dest =3D htons(info->cur_udp_dst);
+	udph->len =3D htons(datalen + 8); /* DATA + udphdr */
+	udph->check =3D 0;  /* No checksum */
+
+	iph->ihl =3D 5;
+	iph->version =3D 4;
+	iph->ttl =3D 3;
+	iph->tos =3D 0;
+	iph->protocol =3D IPPROTO_UDP; /* UDP */
+	iph->saddr =3D info->cur_saddr;
+	iph->daddr =3D info->cur_daddr;
+	iph->frag_off =3D 0;
+	iplen =3D 20 + 8 + datalen;
+	iph->tot_len =3D htons(iplen);
+	iph->check =3D 0;
+	iph->check =3D ip_fast_csum((void *) iph, iph->ihl);
+	skb->protocol =3D __constant_htons(ETH_P_IP);
+	skb->mac.raw =3D ((u8 *)iph) - 14;
+	skb->dev =3D odev;
+	skb->pkt_type =3D PACKET_HOST;
+
+	if (info->nfrags <=3D 0) {
+		pgh =3D (struct pktgen_hdr *)skb_put(skb, datalen);
+	} else {
+		int frags =3D info->nfrags;
+		int i;
+
+		/* TODO: Verify this is OK...it sure is ugly. --Ben */
+		pgh =3D (struct pktgen_hdr*)(((char*)(udph)) + 8);
+	=09
+		if (frags > MAX_SKB_FRAGS)
+			frags =3D MAX_SKB_FRAGS;
+		if (datalen > frags*PAGE_SIZE) {
+			skb_put(skb, datalen-frags*PAGE_SIZE);
+			datalen =3D frags*PAGE_SIZE;
+		}
+
+		i =3D 0;
+		while (datalen > 0) {
+			struct page *page =3D alloc_pages(GFP_KERNEL, 0);
+			skb_shinfo(skb)->frags[i].page =3D page;
+			skb_shinfo(skb)->frags[i].page_offset =3D 0;
+			skb_shinfo(skb)->frags[i].size =3D
+				(datalen < PAGE_SIZE ? datalen : PAGE_SIZE);
+			datalen -=3D skb_shinfo(skb)->frags[i].size;
+			skb->len +=3D skb_shinfo(skb)->frags[i].size;
+			skb->data_len +=3D skb_shinfo(skb)->frags[i].size;
+			i++;
+			skb_shinfo(skb)->nr_frags =3D i;
+		}
+
+		while (i < frags) {
+			int rem;
+
+			if (i =3D=3D 0)
+				break;
+
+			rem =3D skb_shinfo(skb)->frags[i - 1].size / 2;
+			if (rem =3D=3D 0)
+				break;
+
+			skb_shinfo(skb)->frags[i - 1].size -=3D rem;
+
+			skb_shinfo(skb)->frags[i] =3D skb_shinfo(skb)->frags[i - 1];
+			get_page(skb_shinfo(skb)->frags[i].page);
+			skb_shinfo(skb)->frags[i].page =3D skb_shinfo(skb)->frags[i - 1].page;
+			skb_shinfo(skb)->frags[i].page_offset +=3D skb_shinfo(skb)->frags[i - 1=
].size;
+			skb_shinfo(skb)->frags[i].size =3D rem;
+			i++;
+			skb_shinfo(skb)->nr_frags =3D i;
+		}
+	}
+
+	/* Stamp the time, and sequence number, convert them to network byte orde=
r */
+	if (pgh) {
+		pgh->pgh_magic =3D htonl(PKTGEN_MAGIC);
+		do_gettimeofday(&(pgh->timestamp));
+		pgh->timestamp.tv_usec =3D htonl(pgh->timestamp.tv_usec);
+		pgh->timestamp.tv_sec =3D htonl(pgh->timestamp.tv_sec);
+		pgh->seq_num =3D htonl(info->seq_num);
+	}
+=09
+	return skb;
+}
+
+
+static void inject(struct pktgen_info* info)
+{
+	struct net_device *odev =3D NULL;
+	struct sk_buff *skb =3D NULL;
+	__u64 total =3D 0;
+	__u64 idle =3D 0;
+	__u64 lcount =3D 0;
+	int nr_frags =3D 0;
+	int last_ok =3D 1;	   /* Was last skb sent?=20
+				    * Or a failed transmit of some sort?  This will keep
+				    * sequence numbers in order, for example.
+				    */
+	__u64 fp =3D 0;
+	__u32 fp_tmp =3D 0;
+
+	odev =3D setup_inject(info);
+	if (!odev)
+		return;
+
+	info->do_run_run =3D 1; /* Cranke yeself! */
+	info->idle_acc =3D 0;
+	info->sofar =3D 0;
+	lcount =3D info->count;
+
+
+	/* Build our initial pkt and place it as a re-try pkt. */
+	skb =3D fill_packet(odev, info);
+	if (skb =3D=3D NULL) goto out_reldev;
+
+	do_gettimeofday(&(info->started_at));
+
+	while(info->do_run_run) {
+
+		/* Set a time-stamp, so build a new pkt each time */
+
+		if (last_ok) {
+			if (++fp_tmp >=3D info->clone_skb ) {
+				kfree_skb(skb);
+				skb =3D fill_packet(odev, info);
+				if (skb =3D=3D NULL) {
+					break;
+				}
+				fp++;
+				fp_tmp =3D 0; /* reset counter */
+			}
+			atomic_inc(&skb->users);
+		}
+
+		nr_frags =3D skb_shinfo(skb)->nr_frags;
+		  =20
+		spin_lock_bh(&odev->xmit_lock);
+		if (!netif_queue_stopped(odev)) {
+
+			if (odev->hard_start_xmit(skb, odev)) {
+				if (net_ratelimit()) {
+				   printk(KERN_INFO "Hard xmit error\n");
+				}
+				info->errors++;
+				last_ok =3D 0;
+			}
+			else {
+			   last_ok =3D 1;=09
+			   info->sofar++;
+			   info->seq_num++;
+			}
+		}
+		else {
+			/* Re-try it next time */
+			last_ok =3D 0;
+		}
+	=09
+
+		spin_unlock_bh(&odev->xmit_lock);
+
+		if (info->ipg) {
+			/* Try not to busy-spin if we have larger sleep times.
+			 * TODO:  Investigate better ways to do this.
+			 */
+			if (info->ipg < 10000) { /* 10 usecs or less */
+				nanospin(info->ipg, info);
+			}
+			else if (info->ipg < 10000000) { /* 10ms or less */
+				udelay(info->ipg / 1000);
+			}
+			else {
+				mdelay(info->ipg / 1000000);
+			}
+		}
+	=09
+		if (signal_pending(current)) {
+			break;
+		}
+
+		/* If lcount is zero, then run forever */
+		if ((lcount !=3D 0) && (--lcount =3D=3D 0)) {
+			if (atomic_read(&skb->users) !=3D 1) {
+				u32 idle_start, idle;
+
+				idle_start =3D cycles();
+				while (atomic_read(&skb->users) !=3D 1) {
+					if (signal_pending(current)) {
+						break;
+					}
+					schedule();
+				}
+				idle =3D cycles() - idle_start;
+				info->idle_acc +=3D idle;
+			}
+			break;
+		}
+
+		if (netif_queue_stopped(odev) || need_resched()) {
+			u32 idle_start, idle;
+
+			idle_start =3D cycles();
+			do {
+				if (signal_pending(current)) {
+					info->do_run_run =3D 0;
+					break;
+				}
+				if (!netif_running(odev)) {
+					info->do_run_run =3D 0;
+					break;
+				}
+				if (need_resched())
+					schedule();
+				else
+					do_softirq();
+			} while (netif_queue_stopped(odev));
+			idle =3D cycles() - idle_start;
+			info->idle_acc +=3D idle;
+		}
+	}/* while we should be running */
+
+	do_gettimeofday(&(info->stopped_at));
+
+	total =3D (info->stopped_at.tv_sec - info->started_at.tv_sec) * 1000000 +
+		info->stopped_at.tv_usec - info->started_at.tv_usec;
+
+	idle =3D (__u32)(info->idle_acc)/(__u32)(cpu_speed);
+
+	{
+		char *p =3D info->result;
+		__u64 pps =3D (__u32)(info->sofar * 1000) / ((__u32)(total) / 1000);
+		__u64 bps =3D pps * 8 * (info->pkt_size + 4); /* take 32bit ethernet CRC=
 into account */
+		p +=3D sprintf(p, "OK: %llu(c%llu+d%llu) usec, %llu (%dbyte,%dfrags) %ll=
upps %lluMb/sec (%llubps)  errors: %llu",
+			     (unsigned long long) total,
+			     (unsigned long long) (total - idle),
+			     (unsigned long long) idle,
+			     (unsigned long long) info->sofar,
+			     skb->len + 4, /* Add 4 to account for the ethernet checksum */
+			     nr_frags,
+			     (unsigned long long) pps,
+			     (unsigned long long) (bps / (u64) 1024 / (u64) 1024),
+			     (unsigned long long) bps,
+			     (unsigned long long) info->errors
+			     );
+	}
+=09
+out_reldev:
+	if (odev) {
+		dev_put(odev);
+		odev =3D NULL;
+	}
+
+	/* TODO:  Is this worth printing out (other than for debug?) */
+	printk("fp =3D %llu\n", (unsigned long long) fp);
+	return;
+
+}
+
+/* proc/net/pktgen/pg */
+
+static int proc_busy_read(char *buf , char **start, off_t offset,
+			     int len, int *eof, void *data)
+{
+	char *p;
+	int idx =3D (int)(long)(data);
+	struct pktgen_info* info =3D NULL;
+=09
+	if ((idx < 0) || (idx >=3D MAX_PKTGEN)) {
+		printk("ERROR: idx: %i is out of range in proc_write\n", idx);
+		return -EINVAL;
+	}
+	info =3D &(pginfos[idx]);
+ =20
+	p =3D buf;
+	p +=3D sprintf(p, "%d\n", info->busy);
+	*eof =3D 1;
+ =20
+	return p-buf;
+}
+
+static int proc_read(char *buf , char **start, off_t offset,
+			int len, int *eof, void *data)
+{
+	char *p;
+	int i;
+	int idx =3D (int)(long)(data);
+	struct pktgen_info* info =3D NULL;
+	__u64 sa;
+	__u64 stopped;
+	__u64 now =3D getCurMs();
+=09
+	if ((idx < 0) || (idx >=3D MAX_PKTGEN)) {
+		printk("ERROR: idx: %i is out of range in proc_write\n", idx);
+		return -EINVAL;
+	}
+	info =3D &(pginfos[idx]);
+ =20
+	p =3D buf;
+	p +=3D sprintf(p, "%s\n", VERSION); /* Help with parsing compatibility */
+	p +=3D sprintf(p, "Params: count %llu  pkt_size: %u  frags: %d  ipg: %u  =
clone_skb: %d odev \"%s\"\n",
+		     (unsigned long long) info->count,
+		     info->pkt_size, info->nfrags, info->ipg,
+		     info->clone_skb, info->outdev);
+	p +=3D sprintf(p, "     dst_min: %s  dst_max: %s  src_min: %s  src_max: %=
s\n",
+		     info->dst_min, info->dst_max, info->src_min, info->src_max);
+	p +=3D sprintf(p, "     src_mac: ");
+	for (i =3D 0; i < 6; i++) {
+		p +=3D sprintf(p, "%02X%s", info->src_mac[i], i =3D=3D 5 ? "  " : ":");
+	}
+	p +=3D sprintf(p, "dst_mac: ");
+	for (i =3D 0; i < 6; i++) {
+		p +=3D sprintf(p, "%02X%s", info->dst_mac[i], i =3D=3D 5 ? "\n" : ":");
+	}
+	p +=3D sprintf(p, "     udp_src_min: %d  udp_src_max: %d  udp_dst_min: %d=
  udp_dst_max: %d\n",
+		     info->udp_src_min, info->udp_src_max, info->udp_dst_min,
+		     info->udp_dst_max);
+	p +=3D sprintf(p, "     src_mac_count: %d  dst_mac_count: %d\n     Flags:=
 ",
+		     info->src_mac_count, info->dst_mac_count);
+	if (info->flags &  F_IPSRC_RND) {
+		p +=3D sprintf(p, "IPSRC_RND  ");
+	}
+	if (info->flags & F_IPDST_RND) {
+		p +=3D sprintf(p, "IPDST_RND  ");
+	}
+	if (info->flags & F_UDPSRC_RND) {
+		p +=3D sprintf(p, "UDPSRC_RND  ");
+	}
+	if (info->flags & F_UDPDST_RND) {
+		p +=3D sprintf(p, "UDPDST_RND  ");
+	}
+	if (info->flags & F_MACSRC_RND) {
+		p +=3D sprintf(p, "MACSRC_RND  ");
+	}
+	if (info->flags & F_MACDST_RND) {
+		p +=3D sprintf(p, "MACDST_RND  ");
+	}
+	p +=3D sprintf(p, "\n");
+=09
+	sa =3D tv_to_ms(&(info->started_at));
+	stopped =3D tv_to_ms(&(info->stopped_at));
+	if (info->do_run_run) {
+		stopped =3D now; /* not really stopped, more like last-running-at */
+	}
+	p +=3D sprintf(p, "Current:\n     pkts-sofar: %llu  errors: %llu\n     st=
arted: %llums  stopped: %llums  now: %llums  idle: %lluns\n",
+		     (unsigned long long) info->sofar,
+		     (unsigned long long) info->errors,
+		     (unsigned long long) sa,
+		     (unsigned long long) stopped,
+		     (unsigned long long) now,
+		     (unsigned long long) info->idle_acc);
+	p +=3D sprintf(p, "     seq_num: %d  cur_dst_mac_offset: %d  cur_src_mac_=
offset: %d\n",
+		     info->seq_num, info->cur_dst_mac_offset, info->cur_src_mac_offset);
+	p +=3D sprintf(p, "     cur_saddr: 0x%x  cur_daddr: 0x%x  cur_udp_dst: %d=
  cur_udp_src: %d\n",
+		     info->cur_saddr, info->cur_daddr, info->cur_udp_dst, info->cur_udp_=
src);
+=09
+	if (info->result[0])
+		p +=3D sprintf(p, "Result: %s\n", info->result);
+	else
+		p +=3D sprintf(p, "Result: Idle\n");
+	*eof =3D 1;
+
+	return p - buf;
+}
+
+static int count_trail_chars(const char *user_buffer, unsigned int maxlen)
+{
+	int i;
+
+	for (i =3D 0; i < maxlen; i++) {
+		char c;
+
+		if (get_user(c, &user_buffer[i]))
+			return -EFAULT;
+		switch (c) {
+		case '\"':
+		case '\n':
+		case '\r':
+		case '\t':
+		case ' ':
+		case '=3D':
+			break;
+		default:
+			goto done;
+		};
+	}
+done:
+	return i;
+}
+
+static unsigned long num_arg(const char *user_buffer, unsigned long maxlen=
,
+			     unsigned long *num)
+{
+	int i =3D 0;
+
+	*num =3D 0;
+ =20
+	for(; i < maxlen; i++) {
+		char c;
+
+		if (get_user(c, &user_buffer[i]))
+			return -EFAULT;
+		if ((c >=3D '0') && (c <=3D '9')) {
+			*num *=3D 10;
+			*num +=3D c -'0';
+		} else
+			break;
+	}
+	return i;
+}
+
+static int strn_len(const char *user_buffer, unsigned int maxlen)
+{
+	int i =3D 0;
+
+	for(; i < maxlen; i++) {
+		char c;
+
+		if (get_user(c, &user_buffer[i]))
+			return -EFAULT;
+		switch (c) {
+		case '\"':
+		case '\n':
+		case '\r':
+		case '\t':
+		case ' ':
+			goto done_str;
+		default:
+			break;
+		};
+	}
+done_str:
+	return i;
+}
+
+static int proc_write(struct file *file, const char *user_buffer,
+			 unsigned long count, void *data)
+{
+	int i =3D 0, max, len;
+	char name[16], valstr[32];
+	unsigned long value =3D 0;
+	int idx =3D (int)(long)(data);
+	struct pktgen_info* info =3D NULL;
+	char* result =3D NULL;
+	int tmp;
+=09
+	if ((idx < 0) || (idx >=3D MAX_PKTGEN)) {
+		printk("ERROR: idx: %i is out of range in proc_write\n", idx);
+		return -EINVAL;
+	}
+	info =3D &(pginfos[idx]);
+	result =3D &(info->result[0]);
+=09
+	if (count < 1) {
+		sprintf(result, "Wrong command format");
+		return -EINVAL;
+	}
+ =20
+	max =3D count - i;
+	tmp =3D count_trail_chars(&user_buffer[i], max);
+	if (tmp < 0)
+		return tmp;
+	i +=3D tmp;
+ =20
+	/* Read variable name */
+
+	len =3D strn_len(&user_buffer[i], sizeof(name) - 1);
+	if (len < 0)
+		return len;
+	memset(name, 0, sizeof(name));
+	copy_from_user(name, &user_buffer[i], len);
+	i +=3D len;
+ =20
+	max =3D count -i;
+	len =3D count_trail_chars(&user_buffer[i], max);
+	if (len < 0)
+		return len;
+	i +=3D len;
+
+	if (debug)
+		printk("pg: %s,%lu\n", name, count);
+
+	if (!strcmp(name, "stop")) {
+		if (info->do_run_run) {
+			strcpy(result, "Stopping");
+		}
+		else {
+			strcpy(result, "Already stopped...\n");
+		}
+		info->do_run_run =3D 0;
+		return count;
+	}
+
+	if (!strcmp(name, "pkt_size")) {
+		len =3D num_arg(&user_buffer[i], 10, &value);
+		if (len < 0)
+			return len;
+		i +=3D len;
+		if (value < 14+20+8)
+			value =3D 14+20+8;
+		info->pkt_size =3D value;
+		sprintf(result, "OK: pkt_size=3D%u", info->pkt_size);
+		return count;
+	}
+	if (!strcmp(name, "frags")) {
+		len =3D num_arg(&user_buffer[i], 10, &value);
+		if (len < 0)
+			return len;
+		i +=3D len;
+		info->nfrags =3D value;
+		sprintf(result, "OK: frags=3D%u", info->nfrags);
+		return count;
+	}
+	if (!strcmp(name, "ipg")) {
+		len =3D num_arg(&user_buffer[i], 10, &value);
+		if (len < 0)
+			return len;
+		i +=3D len;
+		info->ipg =3D value;
+		sprintf(result, "OK: ipg=3D%u", info->ipg);
+		return count;
+	}
+ 	if (!strcmp(name, "udp_src_min")) {
+		len =3D num_arg(&user_buffer[i], 10, &value);
+		if (len < 0)
+			return len;
+		i +=3D len;
+	 	info->udp_src_min =3D value;
+		sprintf(result, "OK: udp_src_min=3D%u", info->udp_src_min);
+		return count;
+	}
+ 	if (!strcmp(name, "udp_dst_min")) {
+		len =3D num_arg(&user_buffer[i], 10, &value);
+		if (len < 0)
+			return len;
+		i +=3D len;
+	 	info->udp_dst_min =3D value;
+		sprintf(result, "OK: udp_dst_min=3D%u", info->udp_dst_min);
+		return count;
+	}
+ 	if (!strcmp(name, "udp_src_max")) {
+		len =3D num_arg(&user_buffer[i], 10, &value);
+		if (len < 0)
+			return len;
+		i +=3D len;
+	 	info->udp_src_max =3D value;
+		sprintf(result, "OK: udp_src_max=3D%u", info->udp_src_max);
+		return count;
+	}
+ 	if (!strcmp(name, "udp_dst_max")) {
+		len =3D num_arg(&user_buffer[i], 10, &value);
+		if (len < 0)
+			return len;
+		i +=3D len;
+	 	info->udp_dst_max =3D value;
+		sprintf(result, "OK: udp_dst_max=3D%u", info->udp_dst_max);
+		return count;
+	}
+	if (!strcmp(name, "clone_skb")) {
+		len =3D num_arg(&user_buffer[i], 10, &value);
+		if (len < 0)
+			return len;
+		i +=3D len;
+		info->clone_skb =3D value;
+=09
+		sprintf(result, "OK: clone_skb=3D%d", info->clone_skb);
+		return count;
+	}
+	if (!strcmp(name, "count")) {
+		len =3D num_arg(&user_buffer[i], 10, &value);
+		if (len < 0)
+			return len;
+		i +=3D len;
+		info->count =3D value;
+		sprintf(result, "OK: count=3D%llu", (unsigned long long) info->count);
+		return count;
+	}
+	if (!strcmp(name, "src_mac_count")) {
+		len =3D num_arg(&user_buffer[i], 10, &value);
+		if (len < 0)
+			return len;
+		i +=3D len;
+		info->src_mac_count =3D value;
+		sprintf(result, "OK: src_mac_count=3D%d", info->src_mac_count);
+		return count;
+	}
+	if (!strcmp(name, "dst_mac_count")) {
+		len =3D num_arg(&user_buffer[i], 10, &value);
+		if (len < 0)
+			return len;
+		i +=3D len;
+		info->dst_mac_count =3D value;
+		sprintf(result, "OK: dst_mac_count=3D%d", info->dst_mac_count);
+		return count;
+	}
+	if (!strcmp(name, "odev")) {
+		len =3D strn_len(&user_buffer[i], sizeof(info->outdev) - 1);
+		if (len < 0)
+			return len;
+		memset(info->outdev, 0, sizeof(info->outdev));
+		copy_from_user(info->outdev, &user_buffer[i], len);
+		i +=3D len;
+		sprintf(result, "OK: odev=3D%s", info->outdev);
+		return count;
+	}
+	if (!strcmp(name, "flag")) {
+		char f[32];
+		memset(f, 0, 32);
+		len =3D strn_len(&user_buffer[i], sizeof(f) - 1);
+		if (len < 0)
+			return len;
+		copy_from_user(f, &user_buffer[i], len);
+		i +=3D len;
+		if (strcmp(f, "IPSRC_RND") =3D=3D 0) {
+			info->flags |=3D F_IPSRC_RND;
+		}
+		else if (strcmp(f, "!IPSRC_RND") =3D=3D 0) {
+			info->flags &=3D ~F_IPSRC_RND;
+		}
+		else if (strcmp(f, "IPDST_RND") =3D=3D 0) {
+			info->flags |=3D F_IPDST_RND;
+		}
+		else if (strcmp(f, "!IPDST_RND") =3D=3D 0) {
+			info->flags &=3D ~F_IPDST_RND;
+		}
+		else if (strcmp(f, "UDPSRC_RND") =3D=3D 0) {
+			info->flags |=3D F_UDPSRC_RND;
+		}
+		else if (strcmp(f, "!UDPSRC_RND") =3D=3D 0) {
+			info->flags &=3D ~F_UDPSRC_RND;
+		}
+		else if (strcmp(f, "UDPDST_RND") =3D=3D 0) {
+			info->flags |=3D F_UDPDST_RND;
+		}
+		else if (strcmp(f, "!UDPDST_RND") =3D=3D 0) {
+			info->flags &=3D ~F_UDPDST_RND;
+		}
+		else if (strcmp(f, "MACSRC_RND") =3D=3D 0) {
+			info->flags |=3D F_MACSRC_RND;
+		}
+		else if (strcmp(f, "!MACSRC_RND") =3D=3D 0) {
+			info->flags &=3D ~F_MACSRC_RND;
+		}
+		else if (strcmp(f, "MACDST_RND") =3D=3D 0) {
+			info->flags |=3D F_MACDST_RND;
+		}
+		else if (strcmp(f, "!MACDST_RND") =3D=3D 0) {
+			info->flags &=3D ~F_MACDST_RND;
+		}
+		else {
+			sprintf(result, "Flag -:%s:- unknown\nAvailable flags, (prepend ! to un=
-set flag):\n%s",
+				f,
+				"IPSRC_RND, IPDST_RND, UDPSRC_RND, UDPDST_RND, MACSRC_RND, MACDST_RND\=
n");
+			return count;
+		}
+		sprintf(result, "OK: flags=3D0x%x", info->flags);
+		return count;
+	}
+	if (!strcmp(name, "dst_min") || !strcmp(name, "dst")) {
+		len =3D strn_len(&user_buffer[i], sizeof(info->dst_min) - 1);
+		if (len < 0)
+			return len;
+		memset(info->dst_min, 0, sizeof(info->dst_min));
+		copy_from_user(info->dst_min, &user_buffer[i], len);
+		if(debug)
+			printk("pg: dst_min set to: %s\n", info->dst_min);
+		i +=3D len;
+		sprintf(result, "OK: dst_min=3D%s", info->dst_min);
+		return count;
+	}
+	if (!strcmp(name, "dst_max")) {
+		len =3D strn_len(&user_buffer[i], sizeof(info->dst_max) - 1);
+		if (len < 0)
+			return len;
+		memset(info->dst_max, 0, sizeof(info->dst_max));
+		copy_from_user(info->dst_max, &user_buffer[i], len);
+		if(debug)
+			printk("pg: dst_max set to: %s\n", info->dst_max);
+		i +=3D len;
+		sprintf(result, "OK: dst_max=3D%s", info->dst_max);
+		return count;
+	}
+	if (!strcmp(name, "src_min")) {
+		len =3D strn_len(&user_buffer[i], sizeof(info->src_min) - 1);
+		if (len < 0)
+			return len;
+		memset(info->src_min, 0, sizeof(info->src_min));
+		copy_from_user(info->src_min, &user_buffer[i], len);
+		if(debug)
+			printk("pg: src_min set to: %s\n", info->src_min);
+		i +=3D len;
+		sprintf(result, "OK: src_min=3D%s", info->src_min);
+		return count;
+	}
+	if (!strcmp(name, "src_max")) {
+		len =3D strn_len(&user_buffer[i], sizeof(info->src_max) - 1);
+		if (len < 0)
+			return len;
+		memset(info->src_max, 0, sizeof(info->src_max));
+		copy_from_user(info->src_max, &user_buffer[i], len);
+		if(debug)
+			printk("pg: src_max set to: %s\n", info->src_max);
+		i +=3D len;
+		sprintf(result, "OK: src_max=3D%s", info->src_max);
+		return count;
+	}
+	if (!strcmp(name, "dstmac")) {
+		char *v =3D valstr;
+		unsigned char *m =3D info->dst_mac;
+
+		len =3D strn_len(&user_buffer[i], sizeof(valstr) - 1);
+		if (len < 0)
+			return len;
+		memset(valstr, 0, sizeof(valstr));
+		copy_from_user(valstr, &user_buffer[i], len);
+		i +=3D len;
+
+		for(*m =3D 0;*v && m < info->dst_mac + 6; v++) {
+			if (*v >=3D '0' && *v <=3D '9') {
+				*m *=3D 16;
+				*m +=3D *v - '0';
+			}
+			if (*v >=3D 'A' && *v <=3D 'F') {
+				*m *=3D 16;
+				*m +=3D *v - 'A' + 10;
+			}
+			if (*v >=3D 'a' && *v <=3D 'f') {
+				*m *=3D 16;
+				*m +=3D *v - 'a' + 10;
+			}
+			if (*v =3D=3D ':') {
+				m++;
+				*m =3D 0;
+			}
+		}	 =20
+		sprintf(result, "OK: dstmac");
+		return count;
+	}
+	if (!strcmp(name, "srcmac")) {
+		char *v =3D valstr;
+		unsigned char *m =3D info->src_mac;
+
+		len =3D strn_len(&user_buffer[i], sizeof(valstr) - 1);
+		if (len < 0)
+			return len;
+		memset(valstr, 0, sizeof(valstr));
+		copy_from_user(valstr, &user_buffer[i], len);
+		i +=3D len;
+
+		for(*m =3D 0;*v && m < info->src_mac + 6; v++) {
+			if (*v >=3D '0' && *v <=3D '9') {
+				*m *=3D 16;
+				*m +=3D *v - '0';
+			}
+			if (*v >=3D 'A' && *v <=3D 'F') {
+				*m *=3D 16;
+				*m +=3D *v - 'A' + 10;
+			}
+			if (*v >=3D 'a' && *v <=3D 'f') {
+				*m *=3D 16;
+				*m +=3D *v - 'a' + 10;
+			}
+			if (*v =3D=3D ':') {
+				m++;
+				*m =3D 0;
+			}
+		}	 =20
+		sprintf(result, "OK: srcmac");
+		return count;
+	}
+
+	if (!strcmp(name, "inject") || !strcmp(name, "start")) {
+		MOD_INC_USE_COUNT;
+		if (info->busy) {
+			strcpy(info->result, "Already running...\n");
+		}
+		else {
+			info->busy =3D 1;
+			strcpy(info->result, "Starting");
+			inject(info);
+			info->busy =3D 0;
+		}
+		MOD_DEC_USE_COUNT;
+		return count;
+	}
+
+	sprintf(info->result, "No such parameter \"%s\"", name);
+	return -EINVAL;
+}
+
+
+int create_proc_dir(void)
+{
+	int     len;
+	/*  does proc_dir already exists */
+	len =3D strlen(PG_PROC_DIR);
+
+	for (proc_dir =3D proc_net->subdir; proc_dir;
+	     proc_dir=3Dproc_dir->next) {
+		if ((proc_dir->namelen =3D=3D len) &&
+		    (! memcmp(proc_dir->name, PG_PROC_DIR, len)))
+			break;
+	}
+	if (!proc_dir)
+		proc_dir =3D create_proc_entry(PG_PROC_DIR, S_IFDIR, proc_net);
+	if (!proc_dir) return -ENODEV;
+	return 1;
+}
+
+int remove_proc_dir(void)
+{
+	remove_proc_entry(PG_PROC_DIR, proc_net);
+	return 1;
+}
+
+static int __init init(void)
+{
+	int i;
+	printk(version);
+	cycles_calibrate();
+	if (cpu_speed =3D=3D 0) {
+		printk("pktgen: Error: your machine does not have working cycle counter.=
\n");
+		return -EINVAL;
+	}
+
+	create_proc_dir();
+
+	for (i =3D 0; i<MAX_PKTGEN; i++) {
+		memset(&(pginfos[i]), 0, sizeof(pginfos[i]));
+		pginfos[i].pkt_size =3D ETH_ZLEN;
+		pginfos[i].nfrags =3D 0;
+		pginfos[i].clone_skb =3D clone_skb_d;
+		pginfos[i].ipg =3D ipg_d;
+		pginfos[i].count =3D count_d;
+		pginfos[i].sofar =3D 0;
+		pginfos[i].hh[12] =3D 0x08; /* fill in protocol.  Rest is filled in late=
r. */
+		pginfos[i].hh[13] =3D 0x00;
+		pginfos[i].udp_src_min =3D 9; /* sink NULL */
+		pginfos[i].udp_src_max =3D 9;
+		pginfos[i].udp_dst_min =3D 9;
+		pginfos[i].udp_dst_max =3D 9;
+	=09
+		sprintf(pginfos[i].fname, "net/%s/pg%i", PG_PROC_DIR, i);
+		pginfos[i].proc_ent =3D create_proc_entry(pginfos[i].fname, 0600, 0);
+		if (!pginfos[i].proc_ent) {
+			printk("pktgen: Error: cannot create net/%s/pg procfs entry.\n", PG_PRO=
C_DIR);
+			goto cleanup_mem;
+		}
+		pginfos[i].proc_ent->read_proc =3D proc_read;
+		pginfos[i].proc_ent->write_proc =3D proc_write;
+		pginfos[i].proc_ent->data =3D (void*)(long)(i);
+
+		sprintf(pginfos[i].busy_fname, "net/%s/pg_busy%i",  PG_PROC_DIR, i);
+		pginfos[i].busy_proc_ent =3D create_proc_entry(pginfos[i].busy_fname, 0,=
 0);
+		if (!pginfos[i].busy_proc_ent) {
+			printk("pktgen: Error: cannot create net/%s/pg_busy procfs entry.\n", P=
G_PROC_DIR);
+			goto cleanup_mem;
+		}
+		pginfos[i].busy_proc_ent->read_proc =3D proc_busy_read;
+		pginfos[i].busy_proc_ent->data =3D (void*)(long)(i);
+	}
+	return 0;
+=09
+cleanup_mem:
+	for (i =3D 0; i<MAX_PKTGEN; i++) {
+		if (strlen(pginfos[i].fname)) {
+			remove_proc_entry(pginfos[i].fname, NULL);
+		}
+		if (strlen(pginfos[i].busy_fname)) {
+			remove_proc_entry(pginfos[i].busy_fname, NULL);
+		}
+	}
+	return -ENOMEM;
+}
+
+
+static void __exit cleanup(void)
+{
+	int i;
+	for (i =3D 0; i<MAX_PKTGEN; i++) {
+		if (strlen(pginfos[i].fname)) {
+			remove_proc_entry(pginfos[i].fname, NULL);
+		}
+		if (strlen(pginfos[i].busy_fname)) {
+			remove_proc_entry(pginfos[i].busy_fname, NULL);
+		}
+	}
+	remove_proc_dir();
+}
+
+module_init(init);
+module_exit(cleanup);
+
+MODULE_AUTHOR("Robert Olsson <robert.olsson@its.uu.se");
+MODULE_DESCRIPTION("Packet Generator tool");
+MODULE_LICENSE("GPL");
+MODULE_PARM(count_d, "i");
+MODULE_PARM(ipg_d, "i");
+MODULE_PARM(cpu_speed, "i");
+MODULE_PARM(clone_skb_d, "i");

--=-2KZa7lEe5/d7Rwv4uVva--

