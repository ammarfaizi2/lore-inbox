Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261529AbSIXBw7>; Mon, 23 Sep 2002 21:52:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261532AbSIXBvl>; Mon, 23 Sep 2002 21:51:41 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:2242 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S261528AbSIXBuy>;
	Mon, 23 Sep 2002 21:50:54 -0400
Message-ID: <3D8FC5BC.51A8FCCF@us.ibm.com>
Date: Mon, 23 Sep 2002 18:54:04 -0700
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
       Rusty Russell <rusty@rustcorp.com.au>,
       evlog mailing list <evlog-developers@lists.sourceforge.net>
Subject: [PATCH-RFC] 4 of 4 - New problem logging macros, SCSI RAID device driver
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please see [PATCH-RFC] README 1st note.

Also note that this patch includes pci_problem.h, as does the eepro100.c
device driver patch included in the 'README 1st' note.
 
Summary of this patch...
 
 drivers/scsi/ips.c
    Device Driver for the IBM ServeRAID controller, with use of new 
    macros replacing prink() for error conditions.
 
 include/linux/scsi_problem.h
  -  scsi_host_detail() macro providing common information of interest
     for scsi-class devices.    
  -  scsi_host_problem and scsi_host_introduce macros   

 include/linux/pci_problem.h

  -  pci_detail() macro providing common information on a per class
     basis when problems are being reported for devices of that class. 
  -  pci_problem and pci_introduce macros


--- linux-2.5.37/drivers/scsi/ips.c	Fri Sep 20 10:20:13 2002
+++ linux-2.5.37-net/drivers/scsi/ips.c	Mon Sep 23 19:54:30 2002
@@ -176,6 +176,7 @@
 #include "scsi.h"
 #include "hosts.h"
 #include "ips.h"
+#include "scsi_problem.h"
 
 #include <linux/module.h>
 
@@ -694,7 +695,7 @@
       ips_FlashData = ( char * ) __get_free_pages( GFP_KERNEL, 7 );   
       if (ips_FlashData == NULL) {
          /* The validity of this pointer is checked in ips_make_passthru() before it is used */
-         printk( KERN_WARNING "ERROR: Can't Allocate Large Buffer for Flashing\n" );
+         problem( LOG_WARNING, "ERROR: Can't Allocate Large Buffer for Flashing\n" );
       }
    }                                                                               
 
@@ -779,6 +780,9 @@
  #endif
    if (ips_num_controllers > 0) 
       register_reboot_notifier(&ips_notifier);
+   else
+     problem(LOG_INFO, "Unable to detect any ips controllers\n",
+           detail(ips_num_controllers, "%d", ips_num_controllers));
 
    return (ips_num_controllers);
 #endif
@@ -861,8 +865,11 @@
 #if LINUX_VERSION_CODE >= LinuxVersionCode(2,4,0)
             if (check_mem_region(mem_addr, mem_len)) {
                /* Couldn't allocate io space */
-               printk(KERN_WARNING "(%s%d) couldn't allocate IO space %x len %d.\n",
-                      ips_name, ips_next_controller, io_addr, io_len);
+               pci_problem(LOG_WARNING, dev[i], "check_mem_region failed. Couldn't allocate IO space\n",
+                           detail(ips_name, "%s", ips_name),
+                           detail(ips_number, "%d", ips_next_controller),
+                           detail(io_addr, "%x", io_addr),
+                           detail(io_len, "%d", io_len));
 
                ips_next_controller++;
 
@@ -889,8 +896,11 @@
 
             if (check_region(io_addr, io_len)) {
                /* Couldn't allocate io space */
-               printk(KERN_WARNING "(%s%d) couldn't allocate IO space %x len %d.\n",
-                      ips_name, ips_next_controller, io_addr, io_len);
+               pci_problem(LOG_WARNING, dev[i], "check_region failed. Couldn't allocate IO space\n",
+                           detail(ips_name, "%s", ips_name),
+                           detail(ips_number, "%d", ips_next_controller),
+                           detail(io_addr, "%x", io_addr),
+                           detail(io_len, "%d", io_len));
 
                ips_next_controller++;
 
@@ -902,8 +912,9 @@
 
          /* get planer status */
          if (pci_read_config_word(dev[i], 0x04, &planer)) {
-            printk(KERN_WARNING "(%s%d) can't get planer status.\n",
-                   ips_name, ips_next_controller);
+            pci_problem(LOG_WARNING, dev[i], "Can't get planer status.\n",
+                        detail(ips_name, "%s", ips_name),
+                        detail(ips_number, "%d", ips_next_controller));
 
             ips_next_controller++;
 
@@ -926,8 +937,9 @@
 
          /* get the revision ID */
          if (pci_read_config_byte(dev[i], PCI_REVISION_ID, &revision_id)) {
-            printk(KERN_WARNING "(%s%d) can't get revision id.\n",
-                   ips_name, ips_next_controller);
+            pci_problem(LOG_WARNING, dev[i],  "Can't get revision id.\n",
+                        detail(ips_name, "%s", ips_name),
+                        detail(ips_number, "%d", ips_next_controller));
 
             ips_next_controller++;
 
@@ -937,8 +949,9 @@
 #if LINUX_VERSION_CODE < LinuxVersionCode(2,4,0)
          /* get the subdevice id */
          if (pci_read_config_word(dev[i], PCI_SUBSYSTEM_ID, &subdevice_id)) {
-            printk(KERN_WARNING "(%s%d) can't get subdevice id.\n",
-                   ips_name, ips_next_controller);
+            pci_problem(LOG_WARNING, dev[i],  "Can't get subdevice id.\n",
+                        detail(ips_name, "%s", ips_name),
+                        detail(ips_number, "%d", ips_next_controller));
 
             ips_next_controller++;
 
@@ -952,13 +965,17 @@
          sh = scsi_register(SHT, sizeof(ips_ha_t));
 
          if (sh == NULL) {
-            printk(KERN_WARNING "(%s%d) Unable to register controller with SCSI subsystem - skipping controller\n",
-                   ips_name, ips_next_controller);
+            pci_problem(LOG_WARNING, dev[i],  "Unable to register controller with the SCSI subsystem - skipping controller\n",
+                        detail(ips_name, "%s", ips_name),
+                        detail(ips_number, "%d", ips_next_controller));
 
             ips_next_controller++;
 
             continue;
          }
+         scsi_host_introduce(sh, "controller", 
+                             detail(ips_name, "%s", ips_name),
+                             detail(ips_number, "%d", ips_next_controller));
 
          ha = IPS_HA(sh);
          memset(ha, 0, sizeof(ips_ha_t));
@@ -979,8 +996,9 @@
          ha->enq = kmalloc(sizeof(IPS_ENQ), GFP_KERNEL);
 
          if (!ha->enq) {
-            printk(KERN_WARNING "(%s%d) Unable to allocate host inquiry structure - skipping contoller\n",
-                   ips_name, ips_next_controller);
+            scsi_host_problem(LOG_WARNING, sh,  "Unable to allocate host inquiry structure - skipping contoller\n",
+                              detail(ips_name, "%s", ips_name),
+                              detail(ips_number, "%d", ips_next_controller));
 
             ha->active = 0;
             ips_free(ha);
@@ -996,8 +1014,9 @@
          ha->adapt = kmalloc(sizeof(IPS_ADAPTER), GFP_KERNEL);
 
          if (!ha->adapt) {
-            printk(KERN_WARNING "(%s%d) Unable to allocate host adapt structure - skipping controller\n",
-                   ips_name, ips_next_controller);
+            scsi_host_problem(LOG_WARNING, sh,  "Unable to allocate host adapt structure - skipping controller\n",
+                              detail(ips_name, "%s", ips_name),
+                              detail(ips_number, "%d", ips_next_controller));
 
             ha->active = 0;
             ips_free(ha);
@@ -1013,8 +1032,9 @@
          ha->conf = kmalloc(sizeof(IPS_CONF), GFP_KERNEL);
 
          if (!ha->conf) {
-            printk(KERN_WARNING "(%s%d) Unable to allocate host conf structure - skipping controller\n",
-                   ips_name, ips_next_controller);
+            scsi_host_problem(LOG_WARNING, sh,  "Unable to allocate host conf structure - skipping controller\n",
+                              detail(ips_name, "%s", ips_name),
+                              detail(ips_number, "%d", ips_next_controller));
 
             ha->active = 0;
             ips_free(ha);
@@ -1030,8 +1050,9 @@
          ha->nvram = kmalloc(sizeof(IPS_NVRAM_P5), GFP_KERNEL);
 
          if (!ha->nvram) {
-            printk(KERN_WARNING "(%s%d) Unable to allocate host nvram structure - skipping controller\n",
-                   ips_name, ips_next_controller);
+            scsi_host_problem(LOG_WARNING, sh,  "Unable to allocate host nvram structure - skipping controller\n",
+                              detail(ips_name, "%s", ips_name),
+                              detail(ips_number, "%d", ips_next_controller));
 
             ha->active = 0;
             ips_free(ha);
@@ -1047,8 +1068,9 @@
          ha->subsys = kmalloc(sizeof(IPS_SUBSYS), GFP_KERNEL);
 
          if (!ha->subsys) {
-            printk(KERN_WARNING "(%s%d) Unable to allocate host subsystem structure - skipping controller\n",
-                   ips_name, ips_next_controller);
+            scsi_host_problem(LOG_WARNING, sh,  "Unable to allocate host subsystem structure - skipping controller\n",
+                              detail(ips_name, "%s", ips_name),
+                              detail(ips_number, "%d", ips_next_controller));
 
             ha->active = 0;
             ips_free(ha);
@@ -1064,8 +1086,9 @@
          ha->dummy = kmalloc(sizeof(IPS_IO_CMD), GFP_KERNEL);
 
          if (!ha->dummy) {
-            printk(KERN_WARNING "(%s%d) Unable to allocate host dummy structure - skipping controller\n",
-                   ips_name, ips_next_controller);
+            scsi_host_problem(LOG_WARNING, sh,  "Unable to allocate host dummy structure - skipping controller\n",
+                              detail(ips_name, "%s", ips_name),
+                              detail(ips_number, "%d", ips_next_controller));
 
             ha->active = 0;
             ips_free(ha);
@@ -1086,8 +1109,9 @@
          ha->ioctl_datasize = count;
 
          if (!ha->ioctl_data) {
-            printk(KERN_WARNING "(%s%d) Unable to allocate ioctl data\n",
-                   ips_name, ips_next_controller);
+            scsi_host_problem(LOG_WARNING, sh, "Unable to allocate ioctl data\n",
+                              detail(ips_name, "%s", ips_name),
+                              detail(ips_number, "%d", ips_next_controller));
 
             ha->ioctl_data = NULL;
             ha->ioctl_order = 0;
@@ -1189,8 +1213,9 @@
                /*
                 * Initialization failed
                 */
-               printk(KERN_WARNING "(%s%d) unable to initialize controller - skipping controller\n",
-                      ips_name, ips_next_controller);
+               scsi_host_problem(LOG_WARNING, sh,  "Initialization of controller failed - skipping controller\n",
+                                 detail(ips_name, "%s", ips_name),
+                                 detail(ips_number, "%d", ips_next_controller));
 
                ha->active = 0;
                ips_free(ha);
@@ -1206,8 +1231,9 @@
 
          /* install the interrupt handler */
          if (request_irq(irq, do_ipsintr, SA_SHIRQ, ips_name, ha)) {
-            printk(KERN_WARNING "(%s%d) unable to install interrupt handler - skipping controller\n",
-                   ips_name, ips_next_controller);
+            scsi_host_problem(LOG_WARNING, sh,  "Unable to install interrupt handler - skipping controller\n",
+                              detail(ips_name, "%s", ips_name),
+                              detail(ips_number, "%d", ips_next_controller));
 
             ha->active = 0;
             ips_free(ha);
@@ -1226,8 +1252,9 @@
          ha->max_cmds = 1;
          if (!ips_allocatescbs(ha)) {
             /* couldn't allocate a temp SCB */
-            printk(KERN_WARNING "(%s%d) unable to allocate CCBs - skipping contoller\n",
-                   ips_name, ips_next_controller);
+            scsi_host_problem(LOG_WARNING, sh, "Unable to allocate CCBs - skipping contoller\n",
+                              detail(ips_name, "%s", ips_name),
+                              detail(ips_number, "%d", ips_next_controller));
 
             ha->active = 0;
             ips_free(ha);
@@ -1252,7 +1279,9 @@
    for (i = 0; i < ips_next_controller; i++) {
 
       if (ips_ha[i] == 0) {
-         printk(KERN_WARNING "(%s%d) ignoring bad controller\n", ips_name, i);
+         problem(LOG_WARNING, "Ignoring bad controller\n", 
+                           detail(ips_name, "%s", ips_name),
+                           detail(ips_index, "%d", i));
          continue;
       }
 
@@ -1293,8 +1322,8 @@
    for (i = 0; i < IPS_MAX_ADAPTERS && ips_sh[i] != sh; i++);
 
    if (i == IPS_MAX_ADAPTERS) {
-      printk(KERN_WARNING "(%s) release, invalid Scsi_Host pointer.\n",
-            ips_name);
+      problem(LOG_WARNING, "release fails, invalid Scsi_Host pointer.\n",
+                        detail(ips_name, "%s", ips_name));
 #if LINUX_VERSION_CODE >= LinuxVersionCode(2,4,0)
       BUG();
 #endif
@@ -1326,7 +1355,9 @@
 
    /* send command */
    if (ips_send_wait(ha, scb, ips_cmd_timeout, IPS_INTR_ON) == IPS_FAILURE)
-      printk(KERN_NOTICE "(%s%d) Incomplete Flush.\n", ips_name, ha->host_num);
+      scsi_host_problem(LOG_NOTICE, sh, "Incomplete Flush during release.\n",
+                        detail(ips_name, "%s", ips_name),
+                        detail(ips_number, "%d", ha->host_num));
 
    printk(KERN_NOTICE "(%s%d) Flushing Complete.\n", ips_name, ha->host_num);
 
@@ -1402,7 +1433,9 @@
 
       /* send command */
       if (ips_send_wait(ha, scb, ips_cmd_timeout, IPS_INTR_ON) == IPS_FAILURE)
-         printk(KERN_NOTICE "(%s%d) Incomplete Flush.\n", ips_name, ha->host_num);
+        problem(LOG_NOTICE, "Incomplete Flush during halt.\n",
+                          detail(ips_name, "%s", ips_name),
+                          detail(ips_number, "%d", ha->host_num));
       else
          printk(KERN_NOTICE "(%s%d) Flushing Complete.\n", ips_name, ha->host_num);
    }
@@ -1589,16 +1622,17 @@
     * command must have already been sent
     * reset the controller
     */
-   printk(KERN_NOTICE "(%s%d) Resetting controller.\n",
-          ips_name, ha->host_num);
+   scsi_host_problem(LOG_NOTICE, SC->host, "Resetting controller.\n",
+                        detail(ips_name, "%s", ips_name),
+                        detail(ips_number, "%d", ha->host_num));
    ret = (*ha->func.reset)(ha);
 
    if (!ret) {
       Scsi_Cmnd *scsi_cmd;
 
-      printk(KERN_NOTICE
-             "(%s%d) Controller reset failed - controller now offline.\n",
-             ips_name, ha->host_num);
+      scsi_host_problem(LOG_NOTICE, SC->host, "Controller reset has failed - controller now offline.\n",
+                        detail(ips_name, "%s", ips_name),
+                        detail(ips_number, "%d", ha->host_num));
 
       /* Now fail all of the active commands */
       DEBUG_VAR(1, "(%s%d) Failing active commands",
@@ -1628,9 +1662,10 @@
    if (!ips_clear_adapter(ha, IPS_INTR_IORL)) {
       Scsi_Cmnd *scsi_cmd;
 
-      printk(KERN_NOTICE
-             "(%s%d) Controller reset failed - controller now offline.\n",
-             ips_name, ha->host_num);
+      scsi_host_problem(LOG_NOTICE, SC->host,
+             "Controller reset failed - controller now offline.\n",
+                        detail(ips_name, "%s", ips_name),
+                        detail(ips_number, "%d", ha->host_num));
 
       /* Now fail all of the active commands */
       DEBUG_VAR(1, "(%s%d) Failing active commands",
@@ -2106,9 +2141,9 @@
          break;
 
       if (cstatus.fields.command_id > (IPS_MAX_CMDS - 1)) {
-         printk(KERN_WARNING "(%s%d) Spurious interrupt; no ccb.\n",
-                ips_name, ha->host_num);
-
+         problem(LOG_WARNING,  "Spurious interrupt; no ccb.\n",
+                           detail(ips_name, "%s", ips_name),
+                           detail(ips_number, "%d", ha->host_num));
          continue;
       }
 
@@ -2434,7 +2469,7 @@
       if(pt->CoppCP.cmd.flashfw.count + ha->flash_datasize >
         (PAGE_SIZE << ha->flash_order)){
          ips_free_flash_copperhead(ha);
-         printk(KERN_WARNING "failed size sanity check\n");
+         scsi_host_problem(LOG_WARNING, scb->scsi_cmd->host,  "failed size sanity check\n");
          return IPS_FAILURE;
       }
    }
@@ -3120,15 +3155,17 @@
    ips_ffdc_reset(ha, IPS_INTR_IORL);
 
    if (!ips_read_config(ha, IPS_INTR_IORL)) {
-      printk(KERN_WARNING "(%s%d) unable to read config from controller.\n",
-             ips_name, ha->host_num);
+      problem(LOG_WARNING, "Unable to read config from controller.\n",
+                        detail(ips_name, "%s", ips_name),
+                        detail(ips_number, "%d", ha->host_num));
 
       return (0);
    } /* end if */
 
    if (!ips_read_adapter_status(ha, IPS_INTR_IORL)) {
-      printk(KERN_WARNING "(%s%d) unable to read controller status.\n",
-             ips_name, ha->host_num);
+      problem(LOG_WARNING, "Unable to read controller status.\n",
+                        detail(ips_name, "%s", ips_name),
+                        detail(ips_number, "%d", ha->host_num));
 
       return (0);
    }
@@ -3137,16 +3174,18 @@
    ips_identify_controller(ha);
 
    if (!ips_read_subsystem_parameters(ha, IPS_INTR_IORL)) {
-      printk(KERN_WARNING "(%s%d) unable to read subsystem parameters.\n",
-             ips_name, ha->host_num);
+      problem(LOG_WARNING, "Unable to read subsystem parameters.\n",
+                        detail(ips_name, "%s", ips_name),
+                        detail(ips_number, "%d", ha->host_num));
 
       return (0);
    }
 
    /* write nvram user page 5 */
    if (!ips_write_driver_status(ha, IPS_INTR_IORL)) {
-      printk(KERN_WARNING "(%s%d) unable to write driver info to controller.\n",
-             ips_name, ha->host_num);
+      problem(LOG_WARNING, "Unable to write driver info to controller.\n",
+                        detail(ips_name, "%s", ips_name),
+                        detail(ips_number, "%d", ha->host_num));
 
       return (0);
    }
@@ -4028,16 +4067,18 @@
    METHOD_TRACE("ipsintr_done", 2);
 
    if (!scb) {
-      printk(KERN_WARNING "(%s%d) Spurious interrupt; scb NULL.\n",
-             ips_name, ha->host_num);
+      problem(LOG_WARNING, "Spurious interrupt; scb NULL.\n",
+                        detail(ips_name, "%s", ips_name),
+                        detail(ips_number, "%d", ha->host_num));
 
       return ;
    }
 
    if (scb->scsi_cmd == NULL) {
       /* unexpected interrupt */
-      printk(KERN_WARNING "(%s%d) Spurious interrupt; scsi_cmd not set.\n",
-             ips_name, ha->host_num);
+      problem(LOG_WARNING, "Spurious interrupt; scsi_cmd not set.\n",
+                        detail(ips_name, "%s", ips_name),
+                        detail(ips_number, "%d", ha->host_num));
 
       return;
    }
@@ -5459,8 +5500,11 @@
    }
 
    if (PostByte[0] < IPS_GOOD_POST_STATUS) {
-      printk(KERN_WARNING "(%s%d) reset controller fails (post status %x %x).\n",
-             ips_name, ha->host_num, PostByte[0], PostByte[1]);
+      problem(LOG_WARNING, "Reset copperhead controller fails\n",
+                        detail(ips_name, "%s", ips_name),
+                        detail(ips_number, "%d", ha->host_num),
+                        detail(status1, "%x", PostByte[0]),
+                        detail(status2, "%x", PostByte[1]));
 
       return (0);
    }
@@ -5551,8 +5595,11 @@
    }
 
    if (PostByte[0] < IPS_GOOD_POST_STATUS) {
-      printk(KERN_WARNING "(%s%d) reset controller fails (post status %x %x).\n",
-             ips_name, ha->host_num, PostByte[0], PostByte[1]);
+      problem(LOG_WARNING, "Reset copperhead_mmio controller fails\n",
+                        detail(ips_name, "%s", ips_name),
+                        detail(ips_number, "%d", ha->host_num),
+                        detail(status1, "%x", PostByte[0]),
+                        detail(status2, "%x", PostByte[1]));
 
       return (0);
    }
@@ -5638,8 +5685,9 @@
 
    if (i >= 45) {
       /* error occurred */
-      printk(KERN_WARNING "(%s%d) timeout waiting for post.\n",
-             ips_name, ha->host_num);
+      problem(LOG_WARNING, "Timeout waiting for post.\n",
+                        detail(ips_name, "%s", ips_name),
+                        detail(ips_number, "%d", ha->host_num));
 
       return (0);
    }
@@ -5651,8 +5699,10 @@
    writel(Isr, ha->mem_ptr + IPS_REG_I2O_HIR);
 
    if (Post < (IPS_GOOD_POST_STATUS << 8)) {
-      printk(KERN_WARNING "(%s%d) reset controller fails (post status %x).\n",
-             ips_name, ha->host_num, Post);
+      problem(LOG_WARNING, "Reset morpheus controller fails.\n",
+                        detail(ips_name, "%s", ips_name),
+                        detail(ips_number, "%d", ha->host_num),
+                        detail(post, "%x", Post));
 
       return (0);
    }
@@ -5670,8 +5720,9 @@
 
    if (i >= 240) {
       /* error occurred */
-      printk(KERN_WARNING "(%s%d) timeout waiting for config.\n",
-             ips_name, ha->host_num);
+      problem(LOG_WARNING, "timeout waiting for config.\n",
+                        detail(ips_name, "%s", ips_name),
+                        detail(ips_number, "%d", ha->host_num));
 
       return (0);
    }
@@ -6012,10 +6063,13 @@
          if (!(val & IPS_BIT_START_STOP))
             break;
 
-         printk(KERN_WARNING "(%s%d) ips_issue val [0x%x].\n",
-                ips_name, ha->host_num, val);
-         printk(KERN_WARNING "(%s%d) ips_issue semaphore chk timeout.\n",
-                ips_name, ha->host_num);
+         problem(LOG_WARNING, "copperhead ips_issue val\n",
+                        detail(ips_name, "%s", ips_name),
+                        detail(ips_number, "%d", ha->host_num),
+                        detail(val, "%x", val));
+         problem(LOG_WARNING, "copperhead ips_issue semaphore chk timeout.\n",
+                        detail(ips_name, "%s", ips_name),
+                           detail(ips_number, "%d", ha->host_num));
 
          IPS_HA_UNLOCK(cpu_flags);
 
@@ -6075,11 +6129,14 @@
          if (!(val & IPS_BIT_START_STOP))
             break;
 
-         printk(KERN_WARNING "(%s%d) ips_issue val [0x%x].\n",
-                ips_name, ha->host_num, val);
-         printk(KERN_WARNING "(%s%d) ips_issue semaphore chk timeout.\n",
-                ips_name, ha->host_num);
-
+         problem(LOG_WARNING, "copperhead_mmio ips_issue val\n",
+                        detail(ips_name, "%s", ips_name),
+                        detail(ips_number, "%d", ha->host_num),
+                        detail(val, "%x", val));
+         problem(LOG_WARNING, "copperhead_mmio ips_issue semaphore chk timeout.\n",
+                        detail(ips_name, "%s", ips_name),
+                           detail(ips_number, "%d", ha->host_num));
+         
          IPS_HA_UNLOCK(cpu_flags);
 
          return (IPS_FAILURE);
@@ -6337,8 +6394,9 @@
    METHOD_TRACE("ips_write_driver_status", 1);
 
    if (!ips_readwrite_page5(ha, FALSE, intr)) {
-      printk(KERN_WARNING "(%s%d) unable to read NVRAM page 5.\n",
-             ips_name, ha->host_num);
+      problem(LOG_WARNING, "Unable to read NVRAM page 5.\n",
+                        detail(ips_name, "%s", ips_name),
+                        detail(ips_number, "%d", ha->host_num));
 
       return (0);
    }
@@ -6374,8 +6432,9 @@
 
    /* now update the page */
    if (!ips_readwrite_page5(ha, TRUE, intr)) {
-      printk(KERN_WARNING "(%s%d) unable to write NVRAM page 5.\n",
-             ips_name, ha->host_num);
+     problem(LOG_WARNING, "Unable to update NVRAM page 5.\n",
+                        detail(ips_name, "%s", ips_name),
+                        detail(ips_number, "%d", ha->host_num));
 
       return (0);
    }
@@ -7321,16 +7380,22 @@
  if  (strncmp(FirmwareVersion, Compatable[ ha->nvram->adapter_type ], IPS_COMPAT_ID_LENGTH) != 0)
  {
      if (ips_cd_boot == 0)                                                                              
-       printk(KERN_WARNING "Warning: Adapter %d Firmware Compatible Version is %s, but should be %s\n", 
-              ha->host_num, FirmwareVersion, Compatable[ ha->nvram->adapter_type ]);                    
+       problem(LOG_WARNING, "Warning: Firmware Version mismatch\n", 
+                         detail(ips_name, "%s", ips_name),
+                         detail(ips_number, "%d", ha->host_num),
+                         detail(firmwareversion, "%s", FirmwareVersion),
+                         detail(compatableversion, "%s", Compatable[ ha->nvram->adapter_type ]));
      MatchError = 1;
  }
 
  if  (strncmp(BiosVersion, IPS_COMPAT_BIOS, IPS_COMPAT_ID_LENGTH) != 0)
  {
      if (ips_cd_boot == 0)                                                                          
-       printk(KERN_WARNING "Warning: Adapter %d BIOS Compatible Version is %s, but should be %s\n", 
-              ha->host_num, BiosVersion, IPS_COMPAT_BIOS);                                          
+       problem(LOG_WARNING, "Warning: BIOS Version mismatch\n", 
+                         detail(ips_name, "%s", ips_name),
+                         detail(ips_number, "%d", ha->host_num),
+                         detail(biosversion, "%s", BiosVersion),
+                         detail(compatableversion, "%s", IPS_COMPAT_BIOS));
      MatchError = 1;
  }
 
@@ -7340,7 +7405,7 @@
  {
      ha->nvram->version_mismatch = 1;
      if (ips_cd_boot == 0)                                               
-       printk(KERN_WARNING "Warning ! ! ! ServeRAID Version Mismatch\n");
+       problem(LOG_WARNING, "Warning ! ! ! ServeRAID Version Mismatch\n");
  }
  else
  {
@@ -7524,7 +7589,9 @@
        uint32_t offs;
 
        if (check_mem_region(mem_addr, mem_len)) {
-          printk(KERN_WARNING "Couldn't allocate IO Memory space %x len %d.\n", mem_addr, mem_len);
+          pci_problem(LOG_WARNING, pci_dev,  "Couldn't allocate IO Memory space\n", 
+                      detail(mem_addr, "%x", mem_addr),
+                      detail(mem_len, "%d", mem_len));
           return -1;
           }
 
@@ -7541,7 +7608,9 @@
     /* setup I/O mapped area (if applicable) */
     if (io_addr) {
        if (check_region(io_addr, io_len)) {
-          printk(KERN_WARNING "Couldn't allocate IO space %x len %d.\n", io_addr, io_len);
+          pci_problem(LOG_WARNING, pci_dev,  "Couldn't allocate IO space\n", 
+                      detail(mem_addr, "%x", mem_addr),
+                      detail(mem_len, "%d", mem_len));
           return -1;
        }
        request_region(io_addr, io_len, "ips");
@@ -7549,7 +7618,7 @@
 
     /* get the revision ID */
     if (pci_read_config_byte(pci_dev, PCI_REVISION_ID, &revision_id)) {
-       printk(KERN_WARNING "Can't get revision id.\n" );
+       pci_problem(LOG_WARNING, pci_dev, "Can't get the revision id.\n" );
        return -1;
     }
 
@@ -7562,10 +7631,12 @@
     scsi_set_pci_device(sh, pci_dev);
 #endif
     if (sh == NULL) {
-       printk(KERN_WARNING "Unable to register controller with SCSI subsystem\n" );
+      pci_problem(LOG_WARNING, pci_dev, "Unable to register controller with SCSI subsystem. Failing init.\n",
+                        detail(name, "%s", driver_template.name));
        return -1;
     }
 
+    scsi_host_introduce(sh, "adapter");
     ha = IPS_HA(sh);
     memset(ha, 0, sizeof(ips_ha_t));
     
@@ -7584,7 +7655,7 @@
     ha->enq = kmalloc(sizeof(IPS_ENQ), GFP_KERNEL);
 
     if (!ha->enq) {
-       printk(KERN_WARNING "Unable to allocate host inquiry structure\n" );
+       scsi_host_problem(LOG_WARNING, sh, "Unable to allocate host inquiry structure\n" );
        ha->active = 0;
        ips_free(ha);
        scsi_unregister(sh);
@@ -7596,7 +7667,7 @@
     ha->adapt = pci_alloc_consistent(ha->pcidev, sizeof(IPS_ADAPTER) +
                                      sizeof(IPS_IO_CMD), &dma_address);
     if (!ha->adapt) {
-       printk(KERN_WARNING "Unable to allocate host adapt & dummy structures\n");
+       scsi_host_problem(LOG_WARNING, sh, "Unable to allocate host adapt & dummy structures\n");
        ha->active = 0;
        ips_free(ha);
        scsi_unregister(sh);
@@ -7610,7 +7681,7 @@
     ha->conf = kmalloc(sizeof(IPS_CONF), GFP_KERNEL);
 
     if (!ha->conf) {
-       printk(KERN_WARNING "Unable to allocate host conf structure\n" );
+       scsi_host_problem(LOG_WARNING, sh, "Unable to allocate host conf structure\n" );
        ha->active = 0;
        ips_free(ha);
        scsi_unregister(sh);
@@ -7622,7 +7693,7 @@
     ha->nvram = kmalloc(sizeof(IPS_NVRAM_P5), GFP_KERNEL);
 
     if (!ha->nvram) {
-       printk(KERN_WARNING "Unable to allocate host NVRAM structure\n" );
+       scsi_host_problem(LOG_WARNING, sh, "Unable to allocate host NVRAM structure\n" );
        ha->active = 0;
        ips_free(ha);
        scsi_unregister(sh);
@@ -7634,7 +7705,7 @@
     ha->subsys = kmalloc(sizeof(IPS_SUBSYS), GFP_KERNEL);
 
     if (!ha->subsys) {
-       printk(KERN_WARNING "Unable to allocate host subsystem structure\n" );
+       scsi_host_problem(LOG_WARNING, sh, "Unable to allocate host subsystem structure\n" );
        ha->active = 0;
        ips_free(ha);
        scsi_unregister(sh);
@@ -7651,7 +7722,7 @@
     ha->ioctl_datasize = count;
 
     if (!ha->ioctl_data) {
-       printk(KERN_WARNING "Unable to allocate IOCTL data\n" );
+       scsi_host_problem(LOG_WARNING, sh, "Unable to allocate IOCTL data. Disabling ioctls.\n" );
        ha->ioctl_data = NULL;
        ha->ioctl_order = 0;
        ha->ioctl_datasize = 0;
@@ -7748,7 +7819,7 @@
           /*
            * Initialization failed
            */
-          printk(KERN_WARNING "Unable to initialize controller\n" );
+          scsi_host_problem(LOG_WARNING, sh, "Unable to initialize controller. Initialization failed.\n" );
           ha->active = 0;
           ips_free(ha);
           scsi_unregister(sh);
@@ -7760,7 +7831,7 @@
 
     /* Install the interrupt handler */
      if (request_irq(irq, do_ipsintr, SA_SHIRQ, ips_name, ha)) {
-       printk(KERN_WARNING "Unable to install interrupt handler\n" );
+       scsi_host_problem(LOG_WARNING, sh, "Unable to install interrupt handler\n" );
        ha->active = 0;
        ips_free(ha);
        scsi_unregister(sh);
@@ -7774,7 +7845,7 @@
      */
     ha->max_cmds = 1;
     if (!ips_allocatescbs(ha)) {
-       printk(KERN_WARNING "Unable to allocate a CCB\n" );
+       scsi_host_problem(LOG_WARNING, sh, "Unable to allocate a CCB\n" );
        ha->active = 0;
        free_irq(ha->irq, ha);
        ips_free(ha);
@@ -7816,7 +7887,7 @@
     }
 
     if (!ips_hainit(ha)) {
-       printk(KERN_WARNING "Unable to initialize controller\n" );
+       scsi_host_problem(LOG_WARNING, sh, "Unable to initialize controller\n" );
        ha->active = 0;
        ips_free(ha);
        free_irq(ha->irq, ha);
@@ -7830,7 +7901,7 @@
 
     /* allocate CCBs */
     if (!ips_allocatescbs(ha)) {
-       printk(KERN_WARNING "Unable to allocate CCBs\n" );
+       scsi_host_problem(LOG_WARNING, sh, "Unable to allocate CCBs\n" );
        ha->active = 0;
        ips_free(ha);
        free_irq(ha->irq, ha);
--- linux-2.5.37/drivers/scsi/scsi_problem.h	Wed Dec 31 18:00:00 1969
+++ linux-2.5.37-net/drivers/scsi/scsi_problem.h	Mon Sep 23 19:56:37 2002
@@ -0,0 +1,64 @@
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
+#ifndef _SCSI_PROBLEM_H
+#define _SCSI_PROBLEM_H
+
+#include "scsi.h"
+#include "hosts.h"
+#include <linux/pci_problem.h>
+#include <linux/problem.h>
+
+
+#define scsi_host_detail(dev) \
+	detail(scsi_hostno, "%d", (dev)->host_no), \
+        detail(name, "%s", (dev)->hostt->name)
+
+/* This macro could conditionally provide detail() based on
+ * the value of dev, but one problem() per line restriction 
+ * has to be resolved first (just do a printk
+ * to warn the developer if they have used this macro without 
+ * valid args) */
+/* DD writers should use for pci based scsi adapter drivers */
+#define scsi_host_problem(sev, dev, string,...) \
+do { \
+   if (dev)  \
+     problem(sev, string, scsi_host_detail((struct Scsi_Host*)dev), ## __VA_ARGS__); \
+   else  { \
+     if (!dev) \
+       printk("scsi_problem. Invalid usage struct Scsi_Host * is NULL\n"); \
+   } \
+} while (0)
+
+
+/* Since this ultimately resolves to the problem() macro where the
+ * string provided must be unique, a string comment argument is added
+ * to allow multiple introduces to occur from within the same file
+ */
+#define scsi_host_introduce(dev, comment, ...) \
+   introduce(__stringify(KBUILD_MODNAME) " introduces Scsi Adapter: " comment, dev, ## __VA_ARGS__, scsi_host_detail(dev))
+
+#endif	/* _SCSI_PROBLEM_H */
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
