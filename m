Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261625AbTDQQgw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 12:36:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261700AbTDQQgw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 12:36:52 -0400
Received: from ivoti.terra.com.br ([200.176.3.20]:18390 "EHLO
	ivoti.terra.com.br") by vger.kernel.org with ESMTP id S261625AbTDQQgs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 12:36:48 -0400
From: Lucas Correia Villa Real <lucasvr@gobolinux.org>
Organization: Ozzmosis Corp.
To: erich@uruk.org
Subject: [patch] VMnet/VMware workstation 4.0
Date: Thu, 17 Apr 2003 13:48:56 -0300
User-Agent: KMail/1.5
References: <E193vrp-0006P4-00@trillium-hollow.org> <200304160142.48072.lucasvr@gobolinux.org>
In-Reply-To: <200304160142.48072.lucasvr@gobolinux.org>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200304171214.35344.lucasvr@gobolinux.org>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is there a "correct" place at vmware.com to send these patches? I tryied 
sending it to feature-request@vmware.com, but I got no response from them. 

Anyway, below follows the patch providing support to devfs on the vmnet driver 
for vmware workstation 4.0. 

Lucas


--- driver.c.orig	2003-04-17 11:43:48.000000000 -0300
+++ driver.c	2003-04-17 11:55:14.000000000 -0300
@@ -1,5 +1,9 @@
 /* **********************************************************
  * Copyright 1998 VMware, Inc.  All rights reserved. -- VMware Confidential
+ *
+ * Changes:
+ * 17-04-2003 - Lucas Correia Villa Real <lucasvr@gobolinux.org>
+ *              Added support to DevFS.
  * **********************************************************/
 #define FILECODEINT 330
 
@@ -40,6 +44,7 @@
 #define __KERNEL_SYSCALLS__
 #include <asm/io.h>
 
+#include <linux/devfs_fs_kernel.h>
 #include <linux/proc_fs.h>
 #include <linux/file.h>
 
@@ -63,6 +68,10 @@
 extern int VNetNetIf_Create(char *devName, VNetPort **ret, int hubNum);
 extern int VNetBridge_Create(char *devName, VNetPort **ret);
 
+/*
+ * DevFS handle
+ */
+static devfs_handle_t devfs_handle;
 
 /*
  *  Structure for cycle detection of host interfaces.
@@ -191,7 +200,7 @@
 int 
 VNetRegister(int value)
 {
-   LOG(0, (KERN_WARNING "/dev/vmnet: VNetRegister called\n"));
+   LOG(0, (KERN_WARNING "vmnet: VNetRegister called\n"));
    return 0;
 }
 
@@ -277,7 +286,8 @@
 int 
 init_module(void)
 {
-   int retval;
+   int retval, minor, devices;
+   char name[8];
 
    /*
     * First initialize everything, and as a last step register
@@ -287,7 +297,7 @@
    
    retval = VNetProc_Init();
    if (retval) {
-      LOG(0, (KERN_NOTICE "/dev/vmnet: could not register proc fs\n"));
+      LOG(0, (KERN_NOTICE "vmnet: could not register proc fs\n"));
       return -ENOENT;
    }
    
@@ -303,14 +313,36 @@
    vnetFileOps.open = VNetFileOpOpen;
    vnetFileOps.release = VNetFileOpClose;
 
+#ifdef CONFIG_DEVFS_FS
+   retval = devfs_register_chrdev(VNET_MAJOR_NUMBER, "vmnet", &vnetFileOps);
+   if (retval < 0) {
+	   LOG(0, (KERN_NOTICE "vmnet: could not register major device %d\n",
+	      VNET_MAJOR_NUMBER));
+	   return -ENOENT;
+   }
+   
+   devfs_handle = devfs_mk_dir(NULL, "vmware", NULL);
+   if (! devfs_handle)
+	   printk(KERN_ERR "vmnet: could not create 'vmware' device subdir\n");
+
+   devices = 10;
+   for (minor=0; minor<devices; minor++) {
+	   snprintf (name, sizeof (name), "vmnet%d", minor);
+	   devfs_register(devfs_handle, name,
+		   DEVFS_FL_DEFAULT, VNET_MAJOR_NUMBER, minor,
+		   S_IFCHR | S_IRUGO | S_IWUGO,
+		   &vnetFileOps, NULL);
+   }
+#else  
    retval = register_chrdev(VNET_MAJOR_NUMBER, "vmnet", &vnetFileOps);
    if (retval) {
-      LOG(0, (KERN_NOTICE "/dev/vmnet: could not register major device %d\n",
+      LOG(0, (KERN_NOTICE "vmnet: could not register major device %d\n",
 	      VNET_MAJOR_NUMBER));
       VNetProc_Cleanup();
       return -ENOENT;
    }
-
+#endif /* CONFIG_DEVFS_FS */
+   
 #ifndef KERNEL_2_1      
    register_symtab(&vnet_syms);
 #endif
@@ -340,9 +372,14 @@
 {
    int retval;
 
+#ifdef CONFIG_DEVFS_FS
+   devfs_unregister(devfs_handle);
+   retval = devfs_unregister_chrdev(VNET_MAJOR_NUMBER, "vmnet");
+#else
    retval =  unregister_chrdev(VNET_MAJOR_NUMBER, "vmnet");
+#endif
    if (retval != 0 ) {
-      LOG(0, (KERN_WARNING "/dev/vmnet: could not unregister major device 
%d\n",
+      LOG(0, (KERN_WARNING "vmnet: could not unregister major device %d\n",
 	      VNET_MAJOR_NUMBER));
    }
    VNetProc_Cleanup();
@@ -403,7 +440,7 @@
    int hubNum;
    int retval;
    
-   LOG(1, (KERN_DEBUG "/dev/vmnet: open called by PID %d (%s)\n",
+   LOG(1, (KERN_DEBUG "vmnet: open called by PID %d (%s)\n",
            current->pid, current->comm));
 
    /*
@@ -449,7 +486,7 @@
    
    filp->private_data = port;
    
-   LOG(1, (KERN_DEBUG "/dev/vmnet: port on hub %d successfully opened\n", 
hubNum));
+   LOG(1, (KERN_DEBUG "vmnet: port on hub %d successfully opened\n", 
hubNum));
    
    compat_mod_inc_refcount;
 
@@ -485,7 +522,7 @@
    VNetJack *peer;
    
    if (!port) {
-      LOG(1, (KERN_DEBUG "/dev/vmnet: bad file pointer on close\n"));
+      LOG(1, (KERN_DEBUG "vmnet: bad file pointer on close\n"));
 #ifdef KERNEL_2_1
       return -EBADF;
 #else
@@ -544,7 +581,7 @@
    VNetPort *port = (VNetPort*)filp->private_data;
    
    if (!port) {
-      LOG(1, (KERN_DEBUG "/dev/vmnet: bad file pointer on read\n"));
+      LOG(1, (KERN_DEBUG "vmnet: bad file pointer on read\n"));
       return -EBADF;
    }
    
@@ -588,7 +625,7 @@
    VNetPort *port = (VNetPort*)filp->private_data;
 
    if (!port) {
-      LOG(1, (KERN_DEBUG "/dev/vmnet: bad file pointer on write\n"));
+      LOG(1, (KERN_DEBUG "vmnet: bad file pointer on write\n"));
       return -EBADF;
    }
    
@@ -624,7 +661,7 @@
    VNetPort *port = (VNetPort*)filp->private_data;
 
    if (!port) {
-      LOG(1, (KERN_DEBUG "/dev/vmnet: bad file pointer on poll\n"));
+      LOG(1, (KERN_DEBUG "vmnet: bad file pointer on poll\n"));
       return -EBADF;
    }
    
@@ -646,7 +683,7 @@
    VNetPort *port = (VNetPort*)filp->private_data;
 
    if (!port) {
-      LOG(1, (KERN_DEBUG "/dev/vmnet: bad file pointer on select\n"));
+      LOG(1, (KERN_DEBUG "vmnet: bad file pointer on select\n"));
       return -EBADF;
    }
    
@@ -723,7 +760,7 @@
    VNet_SetMacAddrIOCTL macAddr;
    
    if (!port) {
-      LOG(1, (KERN_DEBUG "/dev/vmnet: bad file pointer on ioctl\n"));
+      LOG(1, (KERN_DEBUG "vmnet: bad file pointer on ioctl\n"));
       return -EBADF;
    }
 
@@ -773,7 +810,7 @@
          VNetFree(&new->jack);
          if (retval2) {
             // assert xxx redo this
-            LOG(1, (KERN_NOTICE "/dev/vmnet: cycle on connect failure\n"));
+            LOG(1, (KERN_NOTICE "vmnet: cycle on connect failure\n"));
             return -EBADF;
          }
          return retval;

