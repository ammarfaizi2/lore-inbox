Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261628AbVADNNb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261628AbVADNNb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 08:13:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261624AbVADNM0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 08:12:26 -0500
Received: from gprs214-115.eurotel.cz ([160.218.214.115]:17297 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S261612AbVADNJS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 08:09:18 -0500
Date: Tue, 4 Jan 2005 14:08:46 +0100
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>,
       Linux-pm mailing list <linux-pm@lists.osdl.org>,
       Andrew Morton <akpm@zip.com.au>
Subject: Re: mark older power managment as deprecated
Message-ID: <20050104130846.GB3981@elf.ucw.cz>
References: <20050104124659.GA22256@elf.ucw.cz> <20050104130442.A18550@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050104130442.A18550@flint.arm.linux.org.uk>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > +typedef int __bitwise pm_dev_t;
> >  
> > -typedef int pm_dev_t;
> > +#define PM_UNKNOWN_DEV	((__force pm_request_t) 0)	/* generic */
> > +#define PM_SYS_DEV	((__force pm_request_t) 1)	/* system device (fan, KB controller, ...) */
> > +#define PM_PCI_DEV	((__force pm_request_t) 2)	/* PCI device */
> > +#define PM_USB_DEV	((__force pm_request_t) 3)	/* USB device */
> > +#define PM_SCSI_DEV	((__force pm_request_t) 4)	/* SCSI device */
> > +#define PM_ISA_DEV	((__force pm_request_t) 5)	/* ISA device */
> > +#define	PM_MTD_DEV	((__force pm_request_t) 6)	/* Memory Technology Device */
> 
> Shouldn't these beeeeeeeeeeeeeeeeeeeeeeee pm_dev_t?

Oops, right. Here's updated diff.
								Pavel

--- clean-mm/include/linux/pm.h	2005-01-03 17:15:43.000000000 +0100
+++ linux-mm/include/linux/pm.h	2005-01-04 13:11:18.000000000 +0100
@@ -28,44 +28,28 @@
 #include <asm/atomic.h>
 
 /*
- * Power management requests
+ * Power management requests... these are passed to pm_send_all() and friends.
+ *
+ * these functions are old and deprecated, see below.
  */
-enum
-{
-	PM_SUSPEND, /* enter D1-D3 */
-	PM_RESUME,  /* enter D0 */
-
-	PM_SAVE_STATE,  /* save device's state */
+typedef int __bitwise pm_request_t;
 
-	/* enable wake-on */
-	PM_SET_WAKEUP,
+#define PM_SUSPEND	((__force pm_request_t) 1)	/* enter D1-D3 */
+#define PM_RESUME	((__force pm_request_t) 2)	/* enter D0 */
 
-	/* bus resource management */
-	PM_GET_RESOURCES,
-	PM_SET_RESOURCES,
-
-	/* base station management */
-	PM_EJECT,
-	PM_LOCK,
-};
-
-typedef int pm_request_t;
 
 /*
- * Device types
+ * Device types... these are passed to pm_register
  */
-enum
-{
-	PM_UNKNOWN_DEV = 0, /* generic */
-	PM_SYS_DEV,	    /* system device (fan, KB controller, ...) */
-	PM_PCI_DEV,	    /* PCI device */
-	PM_USB_DEV,	    /* USB device */
-	PM_SCSI_DEV,	    /* SCSI device */
-	PM_ISA_DEV,	    /* ISA device */
-	PM_MTD_DEV,	    /* Memory Technology Device */
-};
+typedef int __bitwise pm_dev_t;
 
-typedef int pm_dev_t;
+#define PM_UNKNOWN_DEV	((__force pm_dev_t) 0)	/* generic */
+#define PM_SYS_DEV	((__force pm_dev_t) 1)	/* system device (fan, KB controller, ...) */
+#define PM_PCI_DEV	((__force pm_dev_t) 2)	/* PCI device */
+#define PM_USB_DEV	((__force pm_dev_t) 3)	/* USB device */
+#define PM_SCSI_DEV	((__force pm_dev_t) 4)	/* SCSI device */
+#define PM_ISA_DEV	((__force pm_dev_t) 5)	/* ISA device */
+#define	PM_MTD_DEV	((__force pm_dev_t) 6)	/* Memory Technology Device */
 
 /*
  * System device hardware ID (PnP) values
@@ -119,32 +103,27 @@
 /*
  * Register a device with power management
  */
-struct pm_dev *pm_register(pm_dev_t type,
-			   unsigned long id,
-			   pm_callback callback);
+struct pm_dev __deprecated *pm_register(pm_dev_t type, unsigned long id, pm_callback callback);
 
 /*
  * Unregister a device with power management
  */
-void pm_unregister(struct pm_dev *dev);
+void __deprecated pm_unregister(struct pm_dev *dev);
 
 /*
  * Unregister all devices with matching callback
  */
-void pm_unregister_all(pm_callback callback);
+void __deprecated pm_unregister_all(pm_callback callback);
 
 /*
  * Send a request to a single device
  */
-int pm_send(struct pm_dev *dev, pm_request_t rqst, void *data);
+int __deprecated pm_send(struct pm_dev *dev, pm_request_t rqst, void *data);
 
 /*
  * Send a request to all devices
  */
-int pm_send_all(pm_request_t rqst, void *data);
-
-static inline void pm_access(struct pm_dev *dev) {}
-static inline void pm_dev_idle(struct pm_dev *dev) {}
+int __deprecated pm_send_all(pm_request_t rqst, void *data);
 
 #else /* CONFIG_PM */
 
@@ -171,16 +150,10 @@
 	return 0;
 }
 
-static inline struct pm_dev *pm_find(pm_dev_t type, struct pm_dev *from)
-{
-	return 0;
-}
-
-static inline void pm_access(struct pm_dev *dev) {}
-static inline void pm_dev_idle(struct pm_dev *dev) {}
-
 #endif /* CONFIG_PM */
 
+/* Functions above this comment are list-based old-style power
+ * managment. Please avoid using them.  */
 
 /*
  * Callbacks for platform drivers to implement.


-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
