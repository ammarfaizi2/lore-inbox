Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750844AbWCVP5q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750844AbWCVP5q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 10:57:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750839AbWCVP5q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 10:57:46 -0500
Received: from sccrmhc11.comcast.net ([204.127.200.81]:13031 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S1750844AbWCVP5o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 10:57:44 -0500
Date: Wed, 22 Mar 2006 09:57:42 -0600
From: Corey Minyard <minyard@acm.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Yani Ioannou <yani.ioannou@gmail.com>
Subject: [PATCH] Fix release function in IPMI device model
Message-ID: <20060322155742.GA28674@i2.minyard.local>
Reply-To: minyard@acm.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>On Tue, 2006-03-21 at 16:13 -0600, Corey Minyard wrote:
>>+static void ipmi_bmc_release(struct device *dev)
>>+{
>>+	printk(KERN_DEBUG "ipmi_bmc release\n");
>>+}
>eehhhh NO.
>Please read the many comments and documentations about why a release
>function is NOT allowed to be empty. In fact the kernel warned you about
>that, didn't it? 

Arjun, is this ok?  I'm not 100% sure I understand all the subtleties of
the device model, but I assume all I have to do is keep around the
device memory until the release function is called.  Also, the device
might come from somplace else (if it is on the PCI bus, for instance),
so I just free the memory in that case since the memory for the
device structure didn't come from this memory.

And "many comments" might be stretching it.  I found one comment in the
device model documentataion directory, nothing in any of the include
files describing the device model.  I should have looked more carefully
when converting the patch over from Yani, but something non-obvious and 
import like this deserves a comment in both the documentation and include
file by the release function, something like:

/* IMPORTANT: You must define a release function, and the memory for the
   device structure *MUST* be kept around until the release function is
   called. */

Here's the patch...


Arjun van de Ven pointed out that the changeover to the driver model
in the IPMI driver had some bugs in it dealing with the release
function and cleanup.  This patch fixes that and also adds a semaphore
around the BMC functions and converts the BMC counter to a kref, which
I meant to do earlier, but didn't write down :(.

Signed-off-by: Corey Minyard <minyard@acm.org>

Index: linux-2.6.16/drivers/char/ipmi/ipmi_msghandler.c
===================================================================
--- linux-2.6.16.orig/drivers/char/ipmi/ipmi_msghandler.c
+++ linux-2.6.16/drivers/char/ipmi/ipmi_msghandler.c
@@ -168,7 +168,8 @@ struct bmc_device
 	struct ipmi_device_id  id;
 	unsigned char          guid[16];
 	int                    guid_set;
-	int                    interfaces;
+
+	struct kref	       refcount;
 
 	/* bmc device attributes */
 	struct device_attribute device_id_attr;
@@ -352,6 +353,7 @@ static struct device_driver ipmidriver =
 	.name = "ipmi",
 	.bus = &platform_bus_type
 };
+static DECLARE_MUTEX(ipmidriver_sem);
 
 #define MAX_IPMI_INTERFACES 4
 static ipmi_smi_t ipmi_interfaces[MAX_IPMI_INTERFACES];
@@ -1800,7 +1802,7 @@ static struct bmc_device *ipmi_find_bmc_
 
 static void ipmi_bmc_release(struct device *dev)
 {
-	printk(KERN_DEBUG "ipmi_bmc release\n");
+	kfree(to_bmc_device(to_platform_device(dev)));
 }
 
 static ssize_t device_id_show(struct device *dev,
@@ -1913,6 +1915,38 @@ static ssize_t guid_show(struct device *
 			(long long) bmc->guid[8]);
 }
 
+static void
+cleanup_bmc_device(struct kref *ref)
+{
+	struct bmc_device *bmc;
+
+	bmc = container_of(ref, struct bmc_device, refcount);
+
+	device_remove_file(&bmc->dev.dev,
+			   &bmc->device_id_attr);
+	device_remove_file(&bmc->dev.dev,
+			   &bmc->provides_dev_sdrs_attr);
+	device_remove_file(&bmc->dev.dev,
+			   &bmc->revision_attr);
+	device_remove_file(&bmc->dev.dev,
+			   &bmc->firmware_rev_attr);
+	device_remove_file(&bmc->dev.dev,
+			   &bmc->version_attr);
+	device_remove_file(&bmc->dev.dev,
+			   &bmc->add_dev_support_attr);
+	device_remove_file(&bmc->dev.dev,
+			   &bmc->manufacturer_id_attr);
+	device_remove_file(&bmc->dev.dev,
+			   &bmc->product_id_attr);
+	if (bmc->id.aux_firmware_revision_set)
+		device_remove_file(&bmc->dev.dev,
+				   &bmc->aux_firmware_rev_attr);
+	if (bmc->guid_set)
+		device_remove_file(&bmc->dev.dev,
+				   &bmc->guid_attr);
+	platform_device_unregister(&bmc->dev);
+}
+
 static void ipmi_bmc_unregister(ipmi_smi_t intf)
 {
 	struct bmc_device *bmc = intf->bmc;
@@ -1924,31 +1958,9 @@ static void ipmi_bmc_unregister(ipmi_smi
 		intf->my_dev_name = NULL;
 	}
 
-	bmc->interfaces--;
-	if (bmc->interfaces == 0) {
-		device_remove_file(&bmc->dev.dev,
-				&bmc->device_id_attr);
-		device_remove_file(&bmc->dev.dev,
-				&bmc->provides_dev_sdrs_attr);
-		device_remove_file(&bmc->dev.dev,
-				&bmc->revision_attr);
-		device_remove_file(&bmc->dev.dev,
-				&bmc->firmware_rev_attr);
-		device_remove_file(&bmc->dev.dev,
-				&bmc->version_attr);
-		device_remove_file(&bmc->dev.dev,
-				&bmc->add_dev_support_attr);
-		device_remove_file(&bmc->dev.dev,
-				&bmc->manufacturer_id_attr);
-		device_remove_file(&bmc->dev.dev,
-				&bmc->product_id_attr);
-		device_remove_file(&bmc->dev.dev,
-				&bmc->aux_firmware_rev_attr);
-		if (bmc->guid_set)
-			device_remove_file(&bmc->dev.dev,
-					   &bmc->guid_attr);
-		platform_device_unregister(&bmc->dev);
-	}
+	down(&ipmidriver_sem);
+	kref_put(&bmc->refcount, cleanup_bmc_device);
+	up(&ipmidriver_sem);
 }
 
 static int ipmi_bmc_register(ipmi_smi_t intf)
@@ -1959,6 +1971,8 @@ static int ipmi_bmc_register(ipmi_smi_t 
 	int               size;
 	char              dummy[1];
 
+	down(&ipmidriver_sem);
+
 	/*
 	 * Try to find if there is an bmc_device struct
 	 * representing the interfaced BMC already
@@ -1979,7 +1993,8 @@ static int ipmi_bmc_register(ipmi_smi_t 
 		intf->bmc = old_bmc;
 		bmc = old_bmc;
 
-		bmc->interfaces++;
+		kref_get(&bmc->refcount);
+		up(&ipmidriver_sem);
 
 		printk(KERN_INFO
 		       "ipmi: interfacing existing BMC (man_id: 0x%6.6x,"
@@ -1992,14 +2007,17 @@ static int ipmi_bmc_register(ipmi_smi_t 
 		bmc->dev.id = bmc->id.device_id;
 		bmc->dev.dev.driver = &ipmidriver;
 		bmc->dev.dev.release = ipmi_bmc_release;
-		bmc->interfaces = 1;
+		kref_init(&bmc->refcount);
 
 		rv = platform_device_register(&bmc->dev);
+		up(&ipmidriver_sem);
 		if (rv) {
 			printk(KERN_ERR
 			       "ipmi_msghandler:"
 			       " Unable to register bmc device: %d\n",
 			       rv);
+			/* Don't go to out_err, you can only do that if
+			   the device is registered already. */
 			return rv;
 		}
 
Index: linux-2.6.16/drivers/char/ipmi/ipmi_si_intf.c
===================================================================
--- linux-2.6.16.orig/drivers/char/ipmi/ipmi_si_intf.c
+++ linux-2.6.16/drivers/char/ipmi/ipmi_si_intf.c
@@ -231,6 +231,7 @@ struct smi_info
 
 	struct list_head link;
 };
+#define to_smi_device(device) container_of(device, struct smi_info, idev)
 
 static int try_smi_init(struct smi_info *smi);
 
@@ -1161,7 +1162,6 @@ static void port_cleanup(struct smi_info
 
 		release_region (addr, mapsize);
 	}
-	kfree(info);
 }
 
 static int port_setup(struct smi_info *info)
@@ -1270,7 +1270,6 @@ static void mem_cleanup(struct smi_info 
 
 		release_mem_region(addr, mapsize);
 	}
-	kfree(info);
 }
 
 static int mem_setup(struct smi_info *info)
@@ -2235,7 +2234,7 @@ static int is_new_interface(struct smi_i
 
 static void si_release(struct device *dev)
 {
-	printk(KERN_DEBUG "ipmi_si release\n");
+	kfree(to_smi_device(to_platform_device(dev)));
 }
 
 static int try_smi_init(struct smi_info *new_smi)
@@ -2395,7 +2394,7 @@ static int try_smi_init(struct smi_info 
 		printk(KERN_ERR
 		       "ipmi_si: Unable to register device: error %d\n",
 		       rv);
-		goto out_err_unreg_dev;
+		goto out_err_stop_timer;
 	}
 
 	rv = ipmi_smi_add_proc_entry(new_smi->intf, "type",
@@ -2405,7 +2404,7 @@ static int try_smi_init(struct smi_info 
 		printk(KERN_ERR
 		       "ipmi_si: Unable to create proc entry: %d\n",
 		       rv);
-		goto out_err_unreg_dev;
+		goto out_err_stop_timer;
 	}
 
 	rv = ipmi_smi_add_proc_entry(new_smi->intf, "si_stats",
@@ -2415,7 +2414,7 @@ static int try_smi_init(struct smi_info 
 		printk(KERN_ERR
 		       "ipmi_si: Unable to create proc entry: %d\n",
 		       rv);
-		goto out_err_unreg_dev;
+		goto out_err_stop_timer;
 	}
 
 	list_add_tail(&new_smi->link, &smi_infos);
@@ -2426,10 +2425,6 @@ static int try_smi_init(struct smi_info 
 
 	return 0;
 
- out_err_unreg_dev:
-	if (new_smi->dev_registered)
-		platform_device_unregister(&new_smi->idev);
-
  out_err_stop_timer:
 	atomic_inc(&new_smi->stop_operation);
 	wait_for_timer_and_thread(new_smi);
@@ -2456,6 +2451,11 @@ static int try_smi_init(struct smi_info 
 	if (new_smi->io_cleanup)
 		new_smi->io_cleanup(new_smi);
 
+	if (new_smi->dev_registered)
+		platform_device_unregister(&new_smi->idev);
+	else
+		kfree(new_smi);
+
 	up(&smi_infos_lock);
 
 	return rv;
@@ -2583,9 +2583,6 @@ static void __devexit cleanup_one_si(str
 		       rv);
 	}
 
-	if (to_clean->dev_registered)
-		platform_device_unregister(&to_clean->idev);
-
 	to_clean->handlers->cleanup(to_clean->si_sm);
 
 	kfree(to_clean->si_sm);
@@ -2594,6 +2591,13 @@ static void __devexit cleanup_one_si(str
 		to_clean->addr_source_cleanup(to_clean);
 	if (to_clean->io_cleanup)
 		to_clean->io_cleanup(to_clean);
+
+	if (to_clean->dev_registered)
+		/* We registered the device, let the release free it. */
+		platform_device_unregister(&to_clean->idev);
+	else
+		/* The device came from elsewhere, we free now. */
+		kfree(to_clean);
 }
 
 static __exit void cleanup_ipmi_si(void)
