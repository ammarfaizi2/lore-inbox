Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261535AbSIXBzj>; Mon, 23 Sep 2002 21:55:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261530AbSIXBzY>; Mon, 23 Sep 2002 21:55:24 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:36505 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S261531AbSIXBvj>;
	Mon, 23 Sep 2002 21:51:39 -0400
Message-ID: <3D8FC601.80BAC684@us.ibm.com>
Date: Mon, 23 Sep 2002 18:55:13 -0700
From: Larry Kessler <kessler@us.ibm.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Andrew V. Savochkin" <saw@saw.sw.com.sg>,
       cgl_discussion mailing list <cgl_discussion@osdl.org>,
       evlog mailing list <evlog-developers@lists.sourceforge.net>,
       "ipslinux (Keith Mitchell)" <ipslinux@us.ibm.com>,
       Linus Torvalds <torvalds@home.transmeta.com>,
       Rusty Russell <rusty@rustcorp.com.au>, Hien Nguyen <hien@us.ibm.com>,
       James Keniston <kenistoj@us.ibm.com>,
       Mike Sullivan <sullivam@us.ibm.com>
Subject: [PATCH-RFC] README 1ST - New problem logging macros (2.5.38)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There are 5 patches that represent the combined efforts of Rusty
Russell, the Enterprise Event logging team (Larry Kessler, Jim Keniston
and Hien Nguyen), and Mike Sullivan (all from IBM).  Patchs 1-4 are in 
separate notes.  Patch 5 is included at the end of this note.

The concept:
-----------
* Device Drivers use new macros to log "problems" when errors are
  detected.  Devices are also "introduced" at init time.

* If event logging is not configured, then the "details" passed to
  problem() and introduce() are written to printk.   

If event logging is configured....

* During the build process
  the static details (textual description, problem attribute names,
  format specifiers for problem attributes, source file name, function
  name and line number) associated with the problem() and introduce()
  calls are stored in a .log section in the .o file. 

* A user-mode utility reads the static details from the .log 
  section and creates a "formatting template", which contains the
  static details needed to interpret and format the problem data
  that's logged during runtime. 

* Developers, Distros, Sys Admins, etc. can simply edit the template
  (or provide an alternate template) to control which information from
  the problem record is displayed, how it is displayed, what language
  it is displayed in, and can add additional information like probable
  cause, recommended operator actions, recommended repair actions, etc.
  ...all without requiring any changes in the device driver source code.
     
* Event logging utilities apply the templates to problem records for 
  querying events, displaying events, event notification, and log 
  management.  Named-attributes in the problem data allow the above
  actions to key on specific attributes like MAC address, device name,
  etc.     	 


The patches for 2.5.38:
----------------------
Patch 1/5 - Logging macros and template generation code
            (separate note)
Patch 2/5 - Event Logging (separate note)
Patch 3/5 - KBUILD_MODNAME (from Kai Germaschewski; separate note)
Patch 4/5 - scsi device driver using the macros (separate note)
Patch 5/5 - eepro100 device driver using the macros (end of this note)
-> apply in the above sequence (patch 4 and 5 do not depend on
   each other, but both contain pci_problem.h)


Example:
-------
(1) disk_dummy.c uses the problem() and detail() macros:
/* serious disk problem */
    problem(LOG_ALERT, "Disk on fire!",
                detail(disk, "%s", drive->name),
                detail(temperature, "%d", drive->degC),
                detail(action, "%s", "Put out fire; run fsck."));

(2) During 'make bzImage' or 'make modules' static event data is stored
    in a .log section in the disk_dummy.o file.

(3) 'make templates' extracts this data from the disk_dummy.o file and
    generates a formatting template in templates/disk_dummy/disk_dummy.t:

      facility "disk_dummy";
      event_type 0x8ab218f4; /* file, message */
      const {
          string message = "Disk on fire!";
          string file = "disk_dummy.c";
          string function = "disk_mon";
          int line = 81;
      }
      attributes {
          string action "%s";
          string disk "%s";
          int temperature "%d"; 
      }
      format
      %file%:%function%:%line%
      %message%  action=%action% disk=%disk% temperature=%temperature%
 
    The .log section is not included in bzImage nor in modules installed
    with 'make modules_install'.  However, the original disk_dummy.o file
    still has it.  'objcopy -R .log disk_dummy.o' removes it.      

(4)  'make templates_install' copies disk_dummy/disk_dummy.t to 
     /var/evlog/templates.  
  
(5) 'evlfacility -a disk_dummy' adds the facility to the registry.
    'evltc disk_dummy.t' compiles the template, and generates
     /var/evlog/templates/disk_dummy/0x8ab218f4.to, which is used
     by the event logging utilities.

(6) When a problem() is logged by the device driver, the static info. is
    not stored in the event.  Instead it is read by event logging 
    utilities from the 0x8ab218f4.to file after the problem record is
    read from the event log file. 

(7) The template under (3) above would allow the command...
        >evlview -b -f 'disk="sda3" && temperature>80'
    to display events where sda3's temperature was greater than 80...
        
recid=2163, size=33, format=BINARY, event_type=0x8ab218f4, facility=disk_dummy, 
severity=ALERT, uid=root, gid=root, pid=1, pgrp=0, 
time=Fri 20 Sep 2002 04:00:01 PM PDT, flags=0x2 (KERNEL), thread=0x0, 
processor=2
disk_dummy.c:dummy_mon:62
Disk on fire!  action=Put out fire; run fsck. disk=sda3 temperature=88

    Some other examples...

        evlview -b -f 'disk="sda3" && temperature>80' -m

Sep 20 16:00:01 elm3b99 kernel: disk_dummy.c:dummy_mon:62
Disk on fire!  action=Put out fire; run fsck. disk=sda3 temperature=88
        
        ...-m causes a printk style display.

    By editing disk_dummy.t, recompiling it, and then reissuing the above 
    command, the same problem data would be displayed differently...

Sep 20 16:00:01 elm3b99 kernel: 
<<< Se quema el disco!  Se quema el disco!    >>> 
!!!  temperatura=88 degrees C  el disko=sda3


Notes:
-----
For the following 3 invocations, the first 2 work, the 3rd does not...

problem(LOG_ALERT, "Disk on fire");    // OK

#define DISK_ON_FIRE "Disk on fire"
problem(LOG_ALERT, DISK_ON_FIRE);     // OK

msg = "Disk on fire";
problem(LOG_ALERT, msg);  // No good

Furthermore, you cannot have more than one problem() call on a single
line.  This restriction does not apply to the detail() macro.

See http://evlog.sourceforge.net/ for more details about event logging.

Go to https://sourceforge.net/project/showfiles.php?group_id=34226
  to download release evlog-2.5_kernel, 1.4.2_k2.5 for the companion 
  user lib and utilities.


To-do List
----------

1) Resolve "one problem() per line" restriction.
2) Generate shell scripts during 'make templates_install' that 
   execute 'evlfacility' for all facilities and 'evltc' for all .t
   files (currently have to do one at a time).
3) For event-logging not configured case, buffer problem() data and 
   make a single call to printk(), since multiple printks are 
   non-atomic.
4) Define valid severities to use with for problem()...3 or 4.


An actual device driver
-----------------------

Note that this patch includes pci_problem.h, as does the ips.c
device driver patch included in the '4 of 4' note.
 
Summary of this patch...
 
 drivers/net/eepro100.c
    Device Driver for the Intel PCI EtherExpressPro with new logging 
    macros replacing prink() for error conditions.
 
 include/linux/net_problem.h
  -  net_detail() macro providing common information of interest
     for ethernet-class devices.    
  -  net_problem, net_pci_problem, and net_introduce macros   

 include/linux/pci_problem.h

  -  pci_detail() macro providing common information on a per class
     basis when problems are being reported for devices of that class. 
  -  pci_problem and pci_introduce macros.


--- linux-2.5.37/drivers/net/eepro100.c	Fri Sep 20 10:20:31 2002
+++ linux-2.5.37-net/drivers/net/eepro100.c	Mon Sep 23 20:20:14 2002
@@ -119,6 +119,7 @@
 #include <linux/etherdevice.h>
 #include <linux/skbuff.h>
 #include <linux/ethtool.h>
+#include <linux/net_problem.h>
 
 MODULE_AUTHOR("Maintainer: Andrey V. Savochkin <saw@saw.sw.com.sg>");
 MODULE_DESCRIPTION("Intel i82557/i82558/i82559 PCI EtherExpressPro driver");
@@ -325,7 +326,8 @@
 	while(inb(cmd_ioaddr) && --wait >= 0);
 #ifndef final_version
 	if (wait < 0)
-		printk(KERN_ALERT "eepro100: wait_for_cmd_done timeout!\n");
+		problem(LOG_ALERT, "eepro100: wait_for_cmd_done timeout!",
+				detail(ioaddr, "%lx", cmd_ioaddr));
 #endif
 }
 
@@ -568,6 +570,7 @@
 	static int cards_found /* = 0 */;
 
 	static int did_version /* = 0 */;		/* Already printed version info. */
+	pci_introduce(pdev);
 	if (speedo_debug > 0  &&  did_version++ == 0)
 		printk(version);
 
@@ -586,12 +589,12 @@
 
 	if (!request_region(pci_resource_start(pdev, 1),
 			pci_resource_len(pdev, 1), "eepro100")) {
-		printk (KERN_ERR "eepro100: cannot reserve I/O ports\n");
+		pci_problem(LOG_ERR, pdev, "eepro100: cannot reserve I/O ports");
 		goto err_out_none;
 	}
 	if (!request_mem_region(pci_resource_start(pdev, 0),
 			pci_resource_len(pdev, 0), "eepro100")) {
-		printk (KERN_ERR "eepro100: cannot reserve MMIO region\n");
+		pci_problem(LOG_ERR, pdev, "eepro100: cannot reserve MMIO region");
 		goto err_out_free_pio_region;
 	}
 
@@ -605,8 +608,10 @@
 	ioaddr = (unsigned long)ioremap(pci_resource_start(pdev, 0),
 									pci_resource_len(pdev, 0));
 	if (!ioaddr) {
-		printk (KERN_ERR "eepro100: cannot remap MMIO region %lx @ %lx\n",
-				pci_resource_len(pdev, 0), pci_resource_start(pdev, 0));
+		pci_problem(LOG_ERR, pdev,
+					"eepro100: cannot remap MMIO region %lx @ %lx",
+					detail(region, "%lx", pci_resource_len(pdev, 0)),
+					detail(base, "%lx", pci_resource_start(pdev, 0)));
 		goto err_out_free_mmio_region;
 	}
 	if (speedo_debug > 2)
@@ -653,11 +658,12 @@
 
 	dev = init_etherdev(NULL, sizeof(struct speedo_private));
 	if (dev == NULL) {
-		printk(KERN_ERR "eepro100: Could not allocate ethernet device.\n");
+		pci_problem(LOG_ERR, pdev, "Could not allocate ethernet device.");
 		pci_free_consistent(pdev, size, tx_ring_space, tx_ring_dma);
 		return -1;
 	}
 
+	net_introduce(dev);
 	SET_MODULE_OWNER(dev);
 
 	if (dev->mem_start > 0)
@@ -700,9 +706,9 @@
 			}
 		}
 		if (sum != 0xBABA)
-			printk(KERN_WARNING "%s: Invalid EEPROM checksum %#4.4x, "
-				   "check settings before activating this device!\n",
-				   dev->name, sum);
+			net_pci_problem(LOG_WARNING, dev, pdev, "Invalid EEPROM checksum, "
+				   "check settings before activating this device!",
+				   detail(checksum, "%#4.4x", sum));
 		/* Don't  unregister_netdev(dev);  as the EEPro may actually be
 		   usable, especially if the MAC address is set later.
 		   On the other hand, it may be unusable if MDI data is corrupted. */
@@ -784,11 +790,9 @@
 		} while (self_test_results[1] == -1  &&  --boguscnt >= 0);
 
 		if (boguscnt < 0) {		/* Test optimized out. */
-			printk(KERN_ERR "Self test failed, status %8.8x:\n"
-				   KERN_ERR " Failure to initialize the i82557.\n"
-				   KERN_ERR " Verify that the card is a bus-master"
-				   " capable slot.\n",
-				   self_test_results[1]);
+			net_pci_problem(LOG_ERR, dev, pdev, 
+				"Self test failed.Failure to initialize the i82557. Verify that the card is a bus-master capable slot.\n",
+				detail(results, "%8.8x", self_test_results[1]));
 		} else
 			printk(KERN_INFO "  General self-test: %s.\n"
 				   KERN_INFO "  Serial sub-system self-test: %s.\n"
@@ -931,7 +935,9 @@
 	do {
 		val = inl(ioaddr + SCBCtrlMDI);
 		if (--boguscnt < 0) {
-			printk(KERN_ERR " mdio_read() timed out with val = %8.8x.\n", val);
+			problem(LOG_ERR, " mdio_read() timed out.\n",
+				detail(ioaddr, "%lx", ioaddr),
+				detail(value, "%8.8x", val));
 			break;
 		}
 	} while (! (val & 0x10000000));
@@ -947,7 +953,9 @@
 	do {
 		val = inl(ioaddr + SCBCtrlMDI);
 		if (--boguscnt < 0) {
-			printk(KERN_ERR" mdio_write() timed out with val = %8.8x.\n", val);
+			problem(LOG_ERR, " mdio_write() timed out.\n",
+				detail(ioaddr, "%lx", ioaddr),
+				detail(value, "%8.8x", val));
 			break;
 		}
 	} while (! (val & 0x10000000));
@@ -1370,11 +1378,12 @@
 	int status = inw(ioaddr + SCBStatus);
 	unsigned long flags;
 
-	printk(KERN_WARNING "%s: Transmit timed out: status %4.4x "
-		   " %4.4x at %d/%d command %8.8x.\n",
-		   dev->name, status, inw(ioaddr + SCBCmd),
-		   sp->dirty_tx, sp->cur_tx,
-		   sp->tx_ring[sp->dirty_tx % TX_RING_SIZE].status);
+	net_pci_problem(LOG_WARNING, dev, sp->pdev,  "Transmit timed out\n",
+		detail(scbstatus, "%4.4x", status),
+		detail(scbcmd, "%4.4x", inw(ioaddr + SCBCmd)),
+		detail(dirty_tx, "%d", sp->dirty_tx),
+		detail(current_tx, "%d", sp->cur_tx),
+		detail(commandstatus, "%8.8x", sp->tx_ring[sp->dirty_tx % TX_RING_SIZE].status));
 
 	speedo_show_state(dev);
 #if 0
@@ -1436,7 +1445,7 @@
 
 	/* Check if there are enough space. */
 	if ((int)(sp->cur_tx - sp->dirty_tx) >= TX_QUEUE_LIMIT) {
-		printk(KERN_ERR "%s: incorrect tbusy state, fixed.\n", dev->name);
+		net_pci_problem(LOG_ERR, dev, sp->pdev,  "incorrect tbusy state, fixed.\n");
 		netif_stop_queue(dev);
 		sp->tx_full = 1;
 		spin_unlock_irqrestore(&sp->lock, flags);
@@ -1529,9 +1538,10 @@
 	}
 
 	if (speedo_debug && (int)(sp->cur_tx - dirty_tx) > TX_RING_SIZE) {
-		printk(KERN_ERR "out-of-sync dirty pointer, %d vs. %d,"
-			   " full=%d.\n",
-			   dirty_tx, sp->cur_tx, sp->tx_full);
+		net_pci_problem(LOG_ERR, dev, sp->pdev,  "out-of-sync dirty pointer\n",
+			detail(dirty_tx, "%d", dirty_tx),
+			detail(current_tx, "%d", sp->cur_tx),
+			detail(tx_full, "%d", sp->tx_full));
 		dirty_tx += TX_RING_SIZE;
 	}
 
@@ -1563,7 +1573,8 @@
 
 #ifndef final_version
 	if (dev == NULL) {
-		printk(KERN_ERR "speedo_interrupt(): irq %d for unknown device.\n", irq);
+		net_problem(LOG_ERR, dev,"speedo_interrupt() for unknown device\n",
+			detail(irq, "%d", irq));
 		return;
 	}
 #endif
@@ -1574,8 +1585,7 @@
 #ifndef final_version
 	/* A lock to prevent simultaneous entry on SMP machines. */
 	if (test_and_set_bit(0, (void*)&sp->in_interrupt)) {
-		printk(KERN_ERR"%s: SMP simultaneous entry of an interrupt handler.\n",
-			   dev->name);
+		net_pci_problem(LOG_ERR, dev, sp->pdev, "SMP simultaneous entry of an interrupt handler.\n");
 		sp->in_interrupt = 0;	/* Avoid halting machine. */
 		return;
 	}
@@ -1640,8 +1650,8 @@
 		spin_unlock(&sp->lock);
 
 		if (--boguscnt < 0) {
-			printk(KERN_ERR "%s: Too much work at interrupt, status=0x%4.4x.\n",
-				   dev->name, status);
+			net_pci_problem(LOG_ERR, dev, sp->pdev, "Too much work at interrupt\n",
+				detail(status, "%4.4x", status));
 			/* Clear all interrupt sources. */
 			/* Will change from 0xfc00 to 0xff00 when we start handling
 			   FCP and ER interrupts --Dragan */
@@ -1712,8 +1722,8 @@
 			unsigned int forw;
 			int forw_entry;
 			if (speedo_debug > 2 || !(sp->rx_ring_state & RrOOMReported)) {
-				printk(KERN_WARNING "%s: can't fill rx buffer (force %d)!\n",
-						dev->name, force);
+				net_pci_problem(LOG_WARNING, dev, sp->pdev,  "can't fill rx buffer\n",
+					detail(force, "%d", force));
 				speedo_show_state(dev);
 				sp->rx_ring_state |= RrOOMReported;
 			}
@@ -1793,14 +1803,13 @@
 				   pkt_len);
 		if ((status & (RxErrTooBig|RxOK|0x0f90)) != RxOK) {
 			if (status & RxErrTooBig)
-				printk(KERN_ERR "%s: Ethernet frame overran the Rx buffer, "
-					   "status %8.8x!\n", dev->name, status);
+				net_pci_problem(LOG_ERR, dev, sp->pdev,  "Ethernet frame overran the Rx buffer\n",
+					detail(status, "%8.8x", status));
 			else if (! (status & RxOK)) {
 				/* There was a fatal error.  This *should* be impossible. */
 				sp->stats.rx_errors++;
-				printk(KERN_ERR "%s: Anomalous event in speedo_rx(), "
-					   "status %8.8x.\n",
-					   dev->name, status);
+				net_pci_problem(LOG_ERR, dev, sp->pdev, "Anomalous event in speedo_rx()\n",
+					detail(status, "%8.8x", status));
 			}
 		} else {
 			struct sk_buff *skb;
@@ -1827,8 +1836,7 @@
 				/* Pass up the already-filled skbuff. */
 				skb = sp->rx_skbuff[entry];
 				if (skb == NULL) {
-					printk(KERN_ERR "%s: Inconsistent Rx descriptor chain.\n",
-						   dev->name);
+					net_pci_problem(LOG_ERR, dev, sp->pdev, "Inconsistent Rx descriptor chain.\n");
 					break;
 				}
 				sp->rx_skbuff[entry] = NULL;
@@ -2193,8 +2201,7 @@
 		mc_blk = kmalloc(sizeof(*mc_blk) + 2 + multicast_filter_limit*6,
 						 GFP_ATOMIC);
 		if (mc_blk == NULL) {
-			printk(KERN_ERR "%s: Failed to allocate a setup frame.\n",
-				   dev->name);
+			net_pci_problem(LOG_ERR, dev, sp->pdev,  "Failed to allocate a setup frame.\n");
 			sp->rx_mode = -1; /* We failed, try again. */
 			return;
 		}
--- linux-2.5.37/drivers/include/linux/net_problem.h	Wed Dec 31 18:00:00 1969
+++ linux-2.5.37-net/include/linux/net_problem.h	Mon Sep 23 20:04:23 2002
@@ -0,0 +1,97 @@
+/*
+ * Linux Event Logging for the Enterprise
+ * Copyright (c) International Business Machines Corp., 2002
+ *
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ *
+ *  Please send e-mail to lkessler@users.sourceforge.net if you have
+ *  questions or comments.
+ *
+ *  Project Website:  http://evlog.sourceforge.net/
+ *
+ */
+
+#ifndef _NET_PROBLEM_H
+#define _NET_PROBLEM_H
+
+#include <linux/pci.h>
+#include <linux/pci_problem.h>
+#include <linux/problem.h>
+
+/* Many network devices start with a bus specific probe and
+ * have a bus specific reference (ie. pci_dev) before a
+ * net_device instance is allocated. Logging that needs to
+ * occur during these phases would only be able to make pci_dev
+ * info available. To simplify the interface for the DD writer
+ * the same macro would always be used, ie. net_pci_problem()
+ * for a pci based network device (suggestions on shortening the
+ * name would be appreciated). Unfortunately the problem() macros
+ * limit us to one invocation per line, so multiple invocations
+ * based on the the value of the parameters is not allowed :(
+ * The alternative is to have the dd writer use different macros 
+ * depending on the info  available. ie. problem(), pci_problem(),
+ * net_problem() or net_pci_problem. Complicating
+ * this is that since the net_device structure doesn't have
+ * a bus specific type & member included, invoking 
+ * net_problem(struct *net_device) doesn't allow the bus instance
+ * to be located and information to be added to the record automatically
+ * from within the net_problem macro.
+ */
+
+/* Added macaddr to net_detail since support
+ * for byte[] fmt objects exists          */
+#define net_detail(dev) \
+	detail(net_name, "%s", (dev)->name), \
+	array_detail(net_mac, "%02hhx", ":", (dev)->dev_addr, 8), \
+	detail(net_addr, "%p", (dev))
+
+/* This macro could conditionally drop down to invoking
+ * problem() without net_detail() if dev is NULL, but one problem() 
+ * per line restriction must be resolved first  (just do a printk
+ * to warn the developer if they have used this macro without 
+ * valid args */
+#define net_problem(sev, dev, string,...) \
+do { \
+  if (dev)     \
+    problem(sev, string, net_detail((struct net_device*)dev), ## __VA_ARGS__); \
+  else  \
+    printk("net_problem. Invalid usage struct net_device * is NULL\n"); \
+} while (0)
+
+
+/* This macro could conditionally add details depending on the
+ * value of dev and pdev. But one problem() 
+ * per line restriction must be resolved first  (just do a printk
+ * to warn the developer if they have used this macro without 
+ * valid args */
+/* For use by PCI based network drivers */
+#define net_pci_problem(sev, dev, pdev, string,...) \
+do { \
+  if ( (dev) && (pdev) )     \
+    problem(sev, string, net_detail((struct net_device*)dev), pci_detail((struct pci_dev *)pdev), ## __VA_ARGS__); \
+  else { \
+    if (!dev)             \
+      printk("net_problem. Invalid usage struct net_device * is NULL\n"); \
+    if (!pdev)             \
+      printk("net_problem. Invalid usage struct pci_dev * is NULL\n"); \
+  } \
+} while (0)
+
+static inline void net_introduce(struct net_device *dev) {
+  if (dev) introduce(__stringify(KBUILD_MODNAME) " introduces network device: ", dev, net_detail(dev));
+}
+
+#endif	/* _NET_PROBLEM_H */
--- linux-2.5.37/drivers/include/linux/pci_problem.h	Wed Dec 31 18:00:00 1969
+++ linux-2.5.37-net/include/linux/pci_problem.h	Mon Sep 23 19:56:11 2002
@@ -0,0 +1,52 @@
+/*
+ * Linux Event Logging for the Enterprise
+ * Copyright (c) International Business Machines Corp., 2002
+ *
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ *
+ *  Please send e-mail to lkessler@users.sourceforge.net if you have
+ *  questions or comments.
+ *
+ *  Project Website:  http://evlog.sourceforge.net/
+ *
+ */
+
+#ifndef _PCI_PROBLEM_H
+#define _PCI_PROBLEM_H
+
+#include <linux/problem.h>
+
+#define pci_detail(pdev) \
+	detail(pci_name, "%s", (pdev)->name), \
+	detail(pci_slot, "%s", (pdev)->slot_name), \
+	detail(pci_vendorid, "%x", (pdev)->vendor), \
+	detail(pci_deviceid, "%x", (pdev)->device), \
+	detail(pci_dev_addr, "%p", (pdev))
+
+#define pci_problem(sev, pdev, string,...) \
+do { \
+  if (pdev)  \
+    problem(sev, string, pci_detail((struct pci_dev *)pdev), ## __VA_ARGS__); \
+  else       \
+    printk("pci_problem. Invalid usage struct pci_dev * is NULL\n"); \
+} while (0)
+
+static inline void pci_introduce(struct pci_dev *pdev) {
+	introduce(__stringify(KBUILD_MODNAME) "introduces pci device: ", pdev, pci_detail(pdev));
+}
+
+
+#endif	/* _PCI_PROBLEM_H */
