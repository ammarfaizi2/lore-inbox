Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270617AbTGNOwp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 10:52:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270634AbTGNOwo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 10:52:44 -0400
Received: from ns2.eclipse.net.uk ([212.104.129.133]:64008 "EHLO
	smtp2.ex.eclipse.net.uk") by vger.kernel.org with ESMTP
	id S270617AbTGNOwA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 10:52:00 -0400
From: Ian Hastie <ianh@iahastie.clara.net>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test1 + nvidia 4363 driver
Date: Mon, 14 Jul 2003 16:01:30 +0100
User-Agent: KMail/1.5.2
References: <20030714162056.27616c6c.martin.zwickel@technotrend.de>
In-Reply-To: <20030714162056.27616c6c.martin.zwickel@technotrend.de>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_RXsE/S6arPbU6tP"
Message-Id: <200307141601.38041.ianh@iahastie.local.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_RXsE/S6arPbU6tP
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Monday 14 Jul 2003 15:20, Martin Zwickel wrote:
> Hi there!
>
> Anybody got a working patch for nvidia 4363 to let it work with the
> 2.6.0-test1 kernel?
> The 2.5 nvidia patch doesn't work for the 2.6 kernel.

Just a quick hack to the official unofficial patch!  It's working OK for me 
right now.  You'll need to apply the 2.5 patch then this one afterwards.

-- 
Ian.

--Boundary-00=_RXsE/S6arPbU6tP
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="NVIDIA_kernel-1.0-4363-2.5-2.6.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="NVIDIA_kernel-1.0-4363-2.5-2.6.diff"

--- NVIDIA_kernel-1.0-4363/nv-linux.h.old	2003-07-14 15:39:35.000000000 +0100
+++ NVIDIA_kernel-1.0-4363/nv-linux.h	2003-07-14 15:47:54.000000000 +0100
@@ -32,6 +32,8 @@
 #  define KERNEL_2_4
 #elif LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 0)
 #  define KERNEL_2_5
+#elif LINUX_VERSION_CODE < KERNEL_VERSION(2, 7, 0)
+#  define KERNEL_2_6
 #else
 #  error This driver does not support development kernels!
 #endif
@@ -46,7 +48,7 @@
 #define __SMP__
 #endif
 
-#if defined (MODVERSIONS) && !defined (KERNEL_2_5)
+#if defined (MODVERSIONS) && !(defined (KERNEL_2_5) || defined(KERNEL_2_6))
 #include <linux/modversions.h>
 #endif
 
@@ -62,7 +64,7 @@
 #include <linux/poll.h>             /* poll_wait                        */
 #include <linux/delay.h>            /* mdelay, udelay                   */
 
-#ifdef KERNEL_2_5
+#if defined(KERNEL_2_5) || defined(KERNEL_2_6)
 #include <linux/sched.h>            /* suser(), capable() replacement   */
 #include <linux/moduleparam.h>      /* module_param()                   */
 #include <linux/smp_lock.h>         /* kernel_locked                    */
@@ -126,7 +128,7 @@
 #define PUT_MODULE_SYMBOL(sym)        inter_module_put((char *) sym)
 #define NV_VMA_PRIVATE(vma)           ((vma)->vm_private_data)
 
-#ifdef KERNEL_2_5
+#if defined(KERNEL_2_5) || defined(KERNEL_2_6)
 #  define NV_DEVICE_NUMBER(_minor)      ((kdev_val(_minor)) & 0x0f)
 #  define NV_IS_CONTROL_DEVICE(_minor)  (((kdev_val(_minor)) & 0xff) == 0xff)
 #  define NV_IS_SUSER()                 capable(CAP_SYS_ADMIN)
@@ -150,7 +152,7 @@
 #  define NV_MODULE_PARAMETER(x)        MODULE_PARM(x, "i")
 #endif
 
-#ifndef KERNEL_2_5
+#if !defined(KERNEL_2_5) && !defined(KERNEL_2_6)
   typedef void irqreturn_t;
 # define IRQ_NONE
 # define IRQ_RETVAL(x)
@@ -163,7 +165,7 @@
   typedef void* devfs_handle_t;
 #endif
 
-#ifdef KERNEL_2_5
+#if defined(KERNEL_2_5) || defined(KERNEL_2_6)
 #define NV_DEVFS_REGISTER(_name, _minor)                            \
 ({                                                                  \
     devfs_handle_t __handle = NULL;                                 \
@@ -193,7 +195,7 @@
  * relevant releases to date use it. This version was backported to 2.4 by
  * RedHat without means to identify the change, hence this hack.
  */
-#ifdef KERNEL_2_5
+#if defined(KERNEL_2_5) || defined(KERNEL_2_6)
 #define NV_REMAP_PAGE_RANGE(a, b...)    remap_page_range(vma, a, ## b)
 #else
 #if defined(REMAP_PAGE_RANGE_5)
--- NVIDIA_kernel-1.0-4363/nv.c.old	2003-07-14 15:51:39.000000000 +0100
+++ NVIDIA_kernel-1.0-4363/nv.c	2003-07-14 15:49:48.000000000 +0100
@@ -720,7 +720,7 @@
 
     nv_printf(NV_DBG_ERRORS, "nvidia: loading %s\n", pNVRM_ID);
 
-#if defined(CONFIG_DEVFS_FS) && !defined(KERNEL_2_5)
+#if defined(CONFIG_DEVFS_FS) && !(defined(KERNEL_2_5) || defined(KERNEL_2_6))
     rc = devfs_register_chrdev(nv_major, "nvidia", &nv_fops);
 #else
     rc = register_chrdev(nv_major, "nvidia", &nv_fops);
@@ -806,7 +806,7 @@
     return 0;
 
  failed:
-#if defined(CONFIG_DEVFS_FS) && !defined(KERNEL_2_5)
+#if defined(CONFIG_DEVFS_FS) && !(defined(KERNEL_2_5) || defined(KERNEL_2_6))
     devfs_unregister_chrdev(nv_major, "nvidia");
 #else
     unregister_chrdev(nv_major, "nvidia");
@@ -856,7 +856,7 @@
         }
     }
 
-#if defined(CONFIG_DEVFS_FS) && !defined(KERNEL_2_5)
+#if defined(CONFIG_DEVFS_FS) && !(defined(KERNEL_2_5) || defined(KERNEL_2_6))
     rc = devfs_unregister_chrdev(nv_major, "nvidia");
 #else
     rc = unregister_chrdev(nv_major, "nvidia");
@@ -1461,7 +1461,7 @@
 
     switch (_IOC_NR(cmd))
     {
-#if !defined(KERNEL_2_5)
+#if !defined(KERNEL_2_5) && !defined(KERNEL_2_6)
         /* debug tool; zap the module use count so we can unload driver */
         /*             even if it is confused */
         case _IOC_NR(NV_IOCTL_MODULE_RESET):

--Boundary-00=_RXsE/S6arPbU6tP--

