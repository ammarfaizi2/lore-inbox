Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264226AbTDPEbC (for <rfc822;willy@w.ods.org>); Wed, 16 Apr 2003 00:31:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264227AbTDPEbC 
	(for <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 00:31:02 -0400
Received: from itaqui.terra.com.br ([200.176.3.19]:63617 "EHLO
	itaqui.terra.com.br") by vger.kernel.org with ESMTP id S264226AbTDPEao 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 00:30:44 -0400
From: Lucas Correia Villa Real <lucasvr@gobolinux.org>
Organization: Ozzmosis Corp.
To: erich@uruk.org, linux-kernel@vger.kernel.org
Subject: Re: Small fix for VMWare 3.2 (3.x?) on Redhat 9 (any 2.4.20+ kernel?)
Date: Wed, 16 Apr 2003 01:42:47 -0300
User-Agent: KMail/1.5
References: <E193vrp-0006P4-00@trillium-hollow.org>
In-Reply-To: <E193vrp-0006P4-00@trillium-hollow.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304160142.48072.lucasvr@gobolinux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 11 April 2003 07:34, erich@uruk.org wrote:
> FYI...
>
> I'm running Redhat 9, and to get my copy of VMWare 3.2 working with it,
> I had to make a one-line fix to a source file inside the "vmnet.tar" file
> for building the vmnet module.
>
> With the fix, VMWare's scripts throw off a lot of what seem to be
> irrelevant error messages while configuring, but it runs flawlessly
> once the "vmware-config.pl" script completes.
>
> In the default installation, the source files for the vmnet module are in:
>
>    /usr/lib/vmware/modules/source/vmnet.tar
>
> Here's the patch:
> ------------------------------------------------------------------------
> diff -ruN vmnet-only.orig/driver.c vmnet-only/driver.c
> --- vmnet-only.orig/driver.c    2002-09-09 20:22:41.000000000 -0700
> +++ vmnet-only/driver.c 2003-04-10 18:51:22.000000000 -0700
> @@ -1485,7 +1485,7 @@
>
>     len += sprintf(buf+len, "pids ");
>
> -   for_each_task(p) {
> +   for_each_process(p) {
>        if (VNetProcessOwnsPort(p, port)) {
>           len += sprintf(buf+len, "%d", p->pid);
>           if (seen) {
> ------------------------------------------------------------------------
>
> --
>     Erich Stefan Boleyn     <erich@uruk.org>     http://www.uruk.org/
> "Reality is truly stranger than fiction; Probably why fiction is so
> popular"
>

I'm sending a patch I made to the same driver in order to add devfs support. I 
decided to use the /dev/vmware directory to keep things organized (should I 
use /dev/misc instead?). /etc/devfsd.conf should handle the symlinks 
properly, then.
I have also removed the "hardcoded" pathnames in the LOG() calls.

Comments?
Lucas



Binary files vmnet-only/bridge.o and vmnet-only-lucasvr/bridge.o differ
diff -Nur vmnet-only/driver.c vmnet-only-lucasvr/driver.c
--- vmnet-only/driver.c	2003-04-05 14:49:27.000000000 -0300
+++ vmnet-only-lucasvr/driver.c	2003-04-08 23:19:49.000000000 -0300
@@ -1,7 +1,11 @@
-/* **********************************************************
+/* *************************************************************
  * Copyright (C) 1998-2000 VMware, Inc.
  * All Rights Reserved
- * **********************************************************/
+ *
+ * Changes:
+ * 08-04-2003 - Lucas Correia Villa Real <lucasvr@gobolinux.org>
+ *                    Added support to DevFS.
+ * *************************************************************/
 
 #include "driver-config.h"
 
@@ -40,6 +44,7 @@
 #define __KERNEL_SYSCALLS__
 #include <asm/io.h>
 
+#include <linux/devfs_fs_kernel.h>
 #include <linux/proc_fs.h>
 #include <linux/file.h>
 
@@ -62,6 +67,10 @@
 extern int VNetNetIf_Create(char *devName, VNetPort **ret, int hubNum);
 extern int VNetBridge_Create(char *devName, VNetPort **ret);
 
+/*
+ * DevFS handle
+ */
+static devfs_handle_t devfs_handle;
 
 /*
  *  Structure for cycle detection of host interfaces.
@@ -213,7 +222,7 @@
 int 
 VNetRegister(int value)
 {
-   LOG(0, (KERN_WARNING "/dev/vmnet: VNetRegister called\n"));
+   LOG(0, (KERN_WARNING "vmnet: VNetRegister called\n"));
    return 0;
 }
 
@@ -238,8 +247,9 @@
 int 
 init_module(void)
 {
-   int retval;
+   int retval, minor, devices;
    int i;
+   char name[8];
    
    VNetHub_Init();
    
@@ -256,18 +266,45 @@
    vnetFileOps.ioctl = VNetFileOpIoctl;
    vnetFileOps.open = VNetFileOpOpen;
    vnetFileOps.release = VNetFileOpClose;
-
+   
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
+	   printk(KERN_ERR "vmnet: could not create 'misc' device subdir\n");
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
       return -ENOENT;
    }
-
+#endif /* CONFIG_DEVFS_FS */
+   
    retval = VNetProc_Init();
    if (retval) {
-      LOG(0, (KERN_NOTICE "/dev/vmnet: could not register proc fs\n"));
+      LOG(0, (KERN_NOTICE "vmnet: could not register proc fs\n"));
+#ifdef CONFIG_DEVFS_FS
+	  devfs_unregister(devfs_handle);
+	  devfs_unregister_chrdev(VNET_MAJOR_NUMBER, "vmnet");
+#else
       unregister_chrdev(VNET_MAJOR_NUMBER, "vmnet");
+#endif
       return -ENOENT;
    }
    
@@ -307,12 +344,21 @@
    int retval;
 
    VNetProc_Cleanup();
-      
-   retval =  unregister_chrdev(VNET_MAJOR_NUMBER, "vmnet");
+
+#ifdef CONFIG_DEVFS_FS
+   devfs_unregister(devfs_handle);
+   retval = devfs_unregister_chrdev(VNET_MAJOR_NUMBER, "vmnet");
    if (retval != 0 ) {
-      LOG(0, (KERN_WARNING "/dev/vmnet: could not unregister major device 
%d\n",
+      LOG(0, (KERN_WARNING "vmnet: could not unregister major device %d\n",
 	      VNET_MAJOR_NUMBER));
    }
+#else
+   retval = unregister_chrdev(VNET_MAJOR_NUMBER, "vmnet");
+   if (retval != 0 ) {
+      LOG(0, (KERN_WARNING "vmnet: could not unregister major device %d\n",
+	      VNET_MAJOR_NUMBER));
+   }
+#endif
 
    return 0;
 }
@@ -372,7 +418,7 @@
    int hubNum;
    int retval;
    
-   LOG(1, (KERN_DEBUG "/dev/vmnet: open called by PID %d (%s)\n",
+   LOG(1, (KERN_DEBUG "vmnet: open called by PID %d (%s)\n",
            current->pid, current->comm));
    
    /*
@@ -415,7 +461,7 @@
    
    filp->private_data = port;
    
-   LOG(1, (KERN_DEBUG "/dev/vmnet: port on hub %d successfully opened\n", 
hubNum));
+   LOG(1, (KERN_DEBUG "vmnet: port on hub %d successfully opened\n", 
hubNum));
    
    compat_mod_inc_refcount;
 
@@ -451,7 +497,7 @@
    VNetJack *peer;
    
    if (!port) {
-      LOG(1, (KERN_DEBUG "/dev/vmnet: bad file pointer on close\n"));
+      LOG(1, (KERN_DEBUG "vmnet: bad file pointer on close\n"));
 #ifdef KERNEL_2_1
       return -EBADF;
 #else
@@ -509,7 +555,7 @@
    VNetPort *port = (VNetPort*)filp->private_data;
    
    if (!port) {
-      LOG(1, (KERN_DEBUG "/dev/vmnet: bad file pointer on read\n"));
+      LOG(1, (KERN_DEBUG "vmnet: bad file pointer on read\n"));
       return -EBADF;
    }
    
@@ -553,7 +599,7 @@
    VNetPort *port = (VNetPort*)filp->private_data;
 
    if (!port) {
-      LOG(1, (KERN_DEBUG "/dev/vmnet: bad file pointer on write\n"));
+      LOG(1, (KERN_DEBUG "vmnet: bad file pointer on write\n"));
       return -EBADF;
    }
    
@@ -589,7 +635,7 @@
    VNetPort *port = (VNetPort*)filp->private_data;
 
    if (!port) {
-      LOG(1, (KERN_DEBUG "/dev/vmnet: bad file pointer on poll\n"));
+      LOG(1, (KERN_DEBUG "vmnet: bad file pointer on poll\n"));
       return -EBADF;
    }
    
@@ -611,7 +657,7 @@
    VNetPort *port = (VNetPort*)filp->private_data;
 
    if (!port) {
-      LOG(1, (KERN_DEBUG "/dev/vmnet: bad file pointer on select\n"));
+      LOG(1, (KERN_DEBUG "vmnet: bad file pointer on select\n"));
       return -EBADF;
    }
    
@@ -692,7 +738,7 @@
    VNetPort *p;
    
    if (!port) {
-      LOG(1, (KERN_DEBUG "/dev/vmnet: bad file pointer on ioctl\n"));
+      LOG(1, (KERN_DEBUG "vmnet: bad file pointer on ioctl\n"));
       return -EBADF;
    }
 
@@ -754,7 +800,7 @@
          retval2 = VNetConnect(&port->jack, peer);
          if (retval2) {
             // assert xxx redo this
-            LOG(1, (KERN_NOTICE "/dev/vmnet: cycle on connect failure\n"));
+            LOG(1, (KERN_NOTICE "vmnet: cycle on connect failure\n"));
             return -EBADF;
          }
          return retval;
@@ -1109,13 +1155,13 @@
       }
       for (i = 1; i < VNET_NUM_IPBASED_MACS; i++) {
          if (!ipmacs[i]) {
-            LOG(0, (KERN_INFO "/dev/vmnet: assigning IP-based address %d.\n", 
i));
+            LOG(0, (KERN_INFO "vmnet: assigning IP-based address %d.\n", i));
             paddr[3] = VMX86_MAC_IPBASED | i;
             break;
          }
       }
       if (i == VNET_NUM_IPBASED_MACS) {
-         LOG(0, (KERN_NOTICE "/dev/vmnet: out of IP-based MAC 
addresses.\n"));
+         LOG(0, (KERN_NOTICE "vmnet: out of IP-based MAC addresses.\n"));
          return -EBUSY;
       }
       break;
diff -Nur vmnet-only/vmnetInt.h vmnet-only-lucasvr/vmnetInt.h
--- vmnet-only/vmnetInt.h	2003-04-08 22:11:30.000000000 -0300
+++ vmnet-only-lucasvr/vmnetInt.h	2003-04-08 22:20:53.000000000 -0300
@@ -51,8 +51,12 @@
 
 
 #ifndef KERNEL_2_5_2
+#ifndef major
 #   define major(_dev) MAJOR(_dev)
+#endif /* major */
+#ifndef minor
 #   define minor(_dev) MINOR(_dev)
+#endif /* minor */
 #endif
