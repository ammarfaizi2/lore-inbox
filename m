Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262624AbVAFL6Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262624AbVAFL6Z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 06:58:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262630AbVAFL6Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 06:58:24 -0500
Received: from mail.renesas.com ([202.234.163.13]:10928 "EHLO
	mail01.idc.renesas.com") by vger.kernel.org with ESMTP
	id S262624AbVAFLzN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 06:55:13 -0500
Date: Thu, 06 Jan 2005 20:55:03 +0900 (JST)
Message-Id: <20050106.205503.719899966.takata.hirokazu@renesas.com>
To: Nicolas Pitre <nico@cam.org>
Cc: linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>,
       Andrew Morton <akpm@osdl.org>, netdev@oss.sgi.com,
       takata@linux-m32r.org
Subject: [PATCH 2.6.10-mm2] net: netconsole support for smc91x
From: Hirokazu Takata <takata@linux-m32r.org>
X-Mailer: Mew version 3.3 on XEmacs 21.4.16 (Corporate Culture)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is for "netconsole" support of smc91x driver.
It looks working.  Could you please include this?

Thank you.

Signed-off-by: Hayato Fujiwara <fujiwara@linux-m32r.org>
Signed-off-by: Hirokazu Takata <takata@linux-m32r.org>
---

 drivers/net/smc91x.c |   16 ++++++++++++++++
 1 files changed, 16 insertions(+)


diff -ruNp a/drivers/net/smc91x.c b/drivers/net/smc91x.c
--- a/drivers/net/smc91x.c	2004-12-25 06:35:40.000000000 +0900
+++ b/drivers/net/smc91x.c	2005-01-06 19:40:56.000000000 +0900
@@ -1333,6 +1333,19 @@ static irqreturn_t smc_interrupt(int irq
 	return IRQ_HANDLED;
 }
 
+#ifdef CONFIG_NET_POLL_CONTROLLER
+/*
+ * Polling receive - used by netconsole and other diagnostic tools
+ * to allow network i/o with interrupts disabled.
+ */
+static void smc_poll_controller(struct net_device *dev)
+{
+	disable_irq(dev->irq);
+	smc_interrupt(dev->irq, dev, NULL);
+	enable_irq(dev->irq);
+}
+#endif
+
 /* Our watchdog timed out. Called by the networking layer */
 static void smc_timeout(struct net_device *dev)
 {
@@ -1912,6 +1925,9 @@ static int __init smc_probe(struct net_d
 	dev->get_stats = smc_query_statistics;
 	dev->set_multicast_list = smc_set_multicast_list;
 	dev->ethtool_ops = &smc_ethtool_ops;
+#ifdef CONFIG_NET_POLL_CONTROLLER
+	dev->poll_controller = smc_poll_controller;
+#endif
 
 	tasklet_init(&lp->tx_task, smc_hardware_send_pkt, (unsigned long)dev);
 	INIT_WORK(&lp->phy_configure, smc_phy_configure, dev);


---
Usage:

- Config:
  Device Drivers -> Networking support -> Network device support ->
  Network console logging support (NETCONSOLE)

- Kernel parameter:
  Please set a kernel parameter "netconsole=...".
  (more info: Documentation/networking/netcosole.txt)

- Observation on a remote host:
    $ netcat -u -l -p <port> -v


This is an example output log:

$ netcat -u -l -p 6666 -v
listening on [any] 6666 ...
connect to [192.168.0.1] from mappi001 [192.168.0.101] 6665
Kernel command line: console=tty1 console=ttyS0,115200n8x root=/dev/nfsroot nfsroot=192.168.0.1:/project/m32r-linux/export/rootfs2.6_small,rsize=1024,wsize=1024 nfsaddrs=192.168.0.101:192.168.0.1:192.168.0.1:255.255.255.0:mappi001 mem=32M netconsole=6665@192.168.0.101/eth0,6666@192.168.0.1/ 
netconsole: local port 6665
netconsole: local IP 192.168.0.101
netconsole: interface eth0
netconsole: remote port 6666
netconsole: remote IP 192.168.0.1
netconsole: remote ethernet address ff:ff:ff:ff:ff:ff
PID hash table entries: 256 (order: 8, 4096 bytes)
Timer start : latch = 5859
Console: colour dummy device 80x25
Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
Memory: 30288k/32772k available (1528k kernel code, 2436k reserved, 281k data, 108k init)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
M32R-mp information
  On-chip CPUs : 2
  CPU model : M32R-MP 012U2/CHAOS(Ver.)
CPU present map : 3
Booting processor 1/1
Waiting for send to finish...
Initializing CPU#1
CPU#1 (phys ID: 1) waiting for CALLOUT
+After Startup.
Before Callout 1.
After Callout 1.
OK.
Boot done.
Brought up 2 CPUs
CPU#0 : CPU clock 300.00MHz, Bus clock 75.00MHz, loops_per_jiffy[1196032]
CPU#1 : CPU clock 300.00MHz, Bus clock 75.00MHz, loops_per_jiffy[1196032]
Before bogomips.
Total of 2 processors activated (478.41 BogoMIPS).
Before bogocount - setting activated=1.
NET: Registered protocol family 16
Linux Kernel Card Services
  options:  none
devfs: 2004-01-31 Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
ds1302: Set PLD_RTCBAUR = 37
ds1302: RTC not found.
Serial: M32R SIO driver $Revision: 1.9 $ IRQ sharing disabled
ttyS0 at I/O 0x4c20000 (irq = 80) is a M32RSIO
io scheduler noop registered
io scheduler deadline registered
io scheduler cfq registered
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
elevator: using deadline as default io scheduler
nbd: registered device at major 43
smc91x.c: v1.1, sep 22 2004 by Nicolas Pitre <nico@cam.org>
eth0: SMC91C11xFD (rev 1) at 0xa0000300 IRQ 129
eth0: Ethernet addr: 08:00:70:25:b0:e1
netconsole: device eth0 not up yet, forcing it
eth0: link down
eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
netconsole: network logging started
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 50MHz system bus speed for PIO modes; override with idebus=xx
hda: HMS360404D5CF00, CFA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 67
hda: max request size: 128KiB
hda: 7999488 sectors (4095 MB) w/128KiB Cache, CHS=7936/16/63
 /dev/ide/host0/bus0/target0/lun0: p1
NET: Registered protocol family 2
IP: routing cache hash table of 256 buckets, 4Kbytes
TCP established hash table entries: 2048 (order: 3, 32768 bytes)
TCP bind hash table entries: 2048 (order: 2, 24576 bytes)
TCP: Hash tables configured (established 2048 bind 2048)
NET: Registered protocol family 1
NET: Registered protocol family 17
IP-Config: Complete:
      device=eth0, addr=192.168.0.101, mask=255.255.255.0, gw=192.168.0.1,
     host=mappi001, domain=, nis-domain=(none),
     bootserver=192.168.0.1, rootserver=192.168.0.1, rootpath=
Looking up port of RPC 100003/2 on 192.168.0.1
Looking up port of RPC 100005/1 on 192.168.0.1
VFS: Mounted root (nfs filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 108k freed

--
Hirokazu Takata <takata@linux-m32r.org>
Linux/M32R Project:  http://www.linux-m32r.org/

