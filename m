Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261184AbUBVHPu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Feb 2004 02:15:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261185AbUBVHPu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Feb 2004 02:15:50 -0500
Received: from defout.telus.net ([199.185.220.240]:30887 "EHLO
	priv-edtnes46.telusplanet.net") by vger.kernel.org with ESMTP
	id S261184AbUBVHPp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Feb 2004 02:15:45 -0500
Subject: Re: drivers/ieee1394/sbp2.c:734: error: `host' undeclared (first
	use in this function) 2.6.3-bk3
From: Bob Gill <gillb4@telusplanet.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1077434283.4023.15.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Sun, 22 Feb 2004 00:18:03 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok.  I rebuilt the kernel 3 times.  I built it twice with the following
change in sbp2.c:727
#ifdef CONFIG_IEEE1394_SBP2_PHYS_DMA
                /* Handle data movement if physical dma is not
                 * enabled/supportedon host controller */
                        hpsb_register_addrspace(&sbp2_highlevel,
hi->host, &sbp2_physdma_ops,
                                        0x0ULL, 0xfffffffcULL);
#endif

(twice to confirm that the kernel builds without throwing any errors). 
It builds sbp2.  I then removed the patch and built with my build script
set as:
# CONFIG_IEEE1394_SBP2_PHYS_DMA is not set

----------------------------------------------
both build all of the 1394 modules.  Unfortunately, neither change gives
me devices in /proc/scsi/scsi (or /proc/partitions) with 2.6,3-bk3.  
/var/log/messages doesn't show much about what is going on, but dmesg
shows:
kudzu: numerical sysctl 1 23 is obsolete.
SCSI subsystem initialized
ohci1394: $Rev: 1131 $ Ben Collins <bcollins@debian.org>
ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[9] 
MMIO=[eb005000-eb0057ff]  Max
Packet=[2048]
kudzu: numerical sysctl 1 49 is obsolete.
ip_conntrack version 2.1 (8191 buckets, 65528 max) - 296 bytes per
conntrack
ieee1394: Node added: ID:BUS[0-00:1023]  GUID[080046010203ab38]
ieee1394: Node added: ID:BUS[0-01:1023]  GUID[0030e000e0000b39]
ieee1394: Node added: ID:BUS[0-02:1023]  GUID[0030e000e0000ae3]
ieee1394: Host added: ID:BUS[0-03:1023]  GUID[001106001a250051]
eth0: Media Link On 10mbps half-duplex
raw1394: /dev/raw1394 device initialized
video1394: Installed video1394 module

------------a cut and paste of what I get---------------
[root@localhost root]# cat /proc/scsi/scsi
Attached devices:
[root@localhost root]#
[root@localhost root]# lsmod | grep ieee
ieee1394               88628  4 video1394,dv1394,raw1394,ohci1394
[root@localhost root]#
[root@localhost root]# cat /proc/partitions
major minor  #blocks  name
                                                                                
   3     0   20010312 hda
   3     1      30208 hda1
   3     2    1050840 hda2
   3     3   18922680 hda3
   3    64   80043264 hdb
   3    65   80035798 hdb1
[root@localhost root]#
[root@localhost udev]# ls /udev/sd*
/udev/sda  /udev/sda1  /udev/sdb  /udev/sdb1  /udev/sdc  /udev/sdc1
[root@localhost udev]#
[root@localhost udev]# od /udev/sda
od: /udev/sda: No such device or address
[root@localhost udev]#
[root@localhost devices]# ls /sys/bus/ieee1394/devices
001106001a250051  0030e000e0000b39  080046010203ab38-0
0030e000e0000ae3  080046010203ab38  fw-host0
[root@localhost devices]#
[root@localhost fw-host0]# cat
/sys/bus/ieee1394/devices/fw-host0/node_count
4
[root@localhost fw-host0]#
[root@localhost fw-host0]# cat
/sys/bus/ieee1394/devices/fw-host0/nodes_active
4
[root@localhost fw-host0]#
[root@localhost fw-host0]# cat
/sys/bus/ieee1394/devices/fw-host0/is_root
1
[root@localhost fw-host0]#
[root@localhost fw-host0]# cat
/sys/bus/ieee1394/devices/fw-host0/is_busmgr
0
[root@localhost fw-host0]#
[root@localhost fw-host0]# cat
/sys/bus/ieee1394/devices/fw-host0/in_bus_reset
0
[root@localhost fw-host0]#

Both of the changes allow the kernel to build, but neither gives me
devices.  2.6.3-bk2 gives me:
[bob@localhost bob]$ cat /proc/partitions
major minor  #blocks  name
 
   3     0   20010312 hda
   3     1      30208 hda1
   3     2    1050840 hda2
   3     3   18922680 hda3
   3    64   80043264 hdb
   3    65   80035798 hdb1
   8     0  134217727 sda
   8     1  134215011 sda1
   8    16  134217727 sdb
   8    17  134215011 sdb1
[bob@localhost bob]$

Thanks for your replies.  
Please email me off the list if you need more information or need me to
do any testing.  Also, my PCI hardware is:
00:0d.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host
Controller (rev 43)
(and the controller in the devices are Oxford Semi FW900's.)

Thanks,
Bob

