Return-Path: <linux-kernel-owner+w=401wt.eu-S965111AbXADXga@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965111AbXADXga (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 18:36:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965104AbXADXg2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 18:36:28 -0500
Received: from sd291.sivit.org ([194.146.225.122]:1617 "EHLO sd291.sivit.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965101AbXADXg0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 18:36:26 -0500
Subject: Re: sonypc with Sony Vaio VGN-SZ1VP
From: Stelian Pop <stelian@popies.net>
To: Andrew Morton <akpm@osdl.org>
Cc: Mattia Dongili <malattia@linux.it>, Len Brown <lenb@kernel.org>,
       Ismail Donmez <ismail@pardus.org.tr>, Andrea Gelmini <gelma@gelma.net>,
       linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
       Cacy Rodney <cacy-rodney-cacy@tlen.pl>
In-Reply-To: <20070104125107.b82db604.akpm@osdl.org>
References: <49814.213.30.172.234.1159357906.squirrel@webmail.popies.net>
	 <200701040024.29793.lenb@kernel.org>
	 <1167905384.7763.36.camel@localhost.localdomain>
	 <20070104191512.GC25619@inferi.kami.home>
	 <20070104125107.b82db604.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-15
Date: Fri, 05 Jan 2007 00:36:23 +0100
Message-Id: <1167953784.4901.5.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le jeudi 04 janvier 2007 à 12:51 -0800, Andrew Morton a écrit :

> The place to start (please) is the patches in -mm:
> 
> 2.6-sony_acpi4.patch
> sony_apci-resume.patch
> sony_apci-resume-fix.patch
> acpi-add-backlight-support-to-the-sony_acpi.patch
> acpi-add-backlight-support-to-the-sony_acpi-v2.patch
> video-sysfs-support-take-2-add-dev-argument-for-backlight_device_register-sony_acpi-fix.patch

In addition to those, I also have the attached patch in my local tree.

Stelian.

---

Added acpi_bus_generate event for forwarding Fn-keys pressed to acpi subsystem,
and made correspondent necessary changes for this to work.

Signed-off-by: Nilton Volpato <nilton.volpato@gmail.com>
---

 drivers/acpi/sony_acpi.c |   55 ++++++++++++++++++++++++----------------------
 1 files changed, 29 insertions(+), 26 deletions(-)

diff --git a/drivers/acpi/sony_acpi.c b/drivers/acpi/sony_acpi.c
index e23522a..0c9367f 100644
--- a/drivers/acpi/sony_acpi.c
+++ b/drivers/acpi/sony_acpi.c
@@ -33,7 +33,7 @@
 
 #define ACPI_SNC_CLASS		"sony"
 #define ACPI_SNC_HID		"SNY5001"
-#define ACPI_SNC_DRIVER_NAME	"ACPI Sony Notebook Control Driver v0.2"
+#define ACPI_SNC_DRIVER_NAME	"ACPI Sony Notebook Control Driver v0.3"
 
 #define LOG_PFX			KERN_WARNING "sony_acpi: "
 
@@ -61,6 +61,7 @@ static struct acpi_driver sony_acpi_driv
 
 static acpi_handle sony_acpi_handle;
 static struct proc_dir_entry *sony_acpi_dir;
+static struct acpi_device *sony_acpi_acpi_device = NULL;
 
 static struct sony_acpi_value {
 	char			*name;	 /* name of the entry */
@@ -245,7 +246,9 @@ static int sony_acpi_write(struct file *
 
 static void sony_acpi_notify(acpi_handle handle, u32 event, void *data)
 {
-	printk(LOG_PFX "sony_acpi_notify\n");
+	if (debug)
+		printk(LOG_PFX "sony_acpi_notify, event: %d\n", event);
+	acpi_bus_generate_event(sony_acpi_acpi_device, 1, event);
 }
 
 static acpi_status sony_walk_callback(acpi_handle handle, u32 level,
@@ -269,6 +272,8 @@ static int sony_acpi_add(struct acpi_dev
 	int result;
 	struct sony_acpi_value *item;
 
+	sony_acpi_acpi_device = device;
+
 	sony_acpi_handle = device->handle;
 
 	acpi_driver_data(device) = NULL;
@@ -282,16 +287,16 @@ static int sony_acpi_add(struct acpi_dev
 			result = -ENODEV;
 			goto outwalk;
 		}
+	}
 
-		status = acpi_install_notify_handler(sony_acpi_handle,
-						     ACPI_DEVICE_NOTIFY,
-						     sony_acpi_notify,
-						     NULL);
-		if (ACPI_FAILURE(status)) {
-			printk(LOG_PFX "unable to install notify handler\n");
-			result = -ENODEV;
-			goto outnotify;
-		}
+	status = acpi_install_notify_handler(sony_acpi_handle,
+					     ACPI_DEVICE_NOTIFY,
+					     sony_acpi_notify,
+					     NULL);
+	if (ACPI_FAILURE(status)) {
+		printk(LOG_PFX "unable to install notify handler\n");
+		result = -ENODEV;
+		goto outnotify;
 	}
 
 	for (item = sony_acpi_values; item->name; ++item) {
@@ -310,7 +315,7 @@ static int sony_acpi_add(struct acpi_dev
 		    		 item->acpiset, &handle)))
 		    	continue;
 
-		item->proc = create_proc_entry(item->name, 0600,
+		item->proc = create_proc_entry(item->name, 0666,
 					       acpi_device_dir(device));
 		if (!item->proc) {
 			printk(LOG_PFX "unable to create proc entry\n");
@@ -329,13 +334,11 @@ static int sony_acpi_add(struct acpi_dev
 	return 0;
 
 outproc:
-	if (debug) {
-		status = acpi_remove_notify_handler(sony_acpi_handle,
-						    ACPI_DEVICE_NOTIFY,
-						    sony_acpi_notify);
-		if (ACPI_FAILURE(status))
-			printk(LOG_PFX "unable to remove notify handler\n");
-	}
+	status = acpi_remove_notify_handler(sony_acpi_handle,
+					    ACPI_DEVICE_NOTIFY,
+					    sony_acpi_notify);
+	if (ACPI_FAILURE(status))
+		printk(LOG_PFX "unable to remove notify handler\n");
 outnotify:
 	for (item = sony_acpi_values; item->name; ++item)
 		if (item->proc)
@@ -350,13 +353,13 @@ static int sony_acpi_remove(struct acpi_
 	acpi_status status;
 	struct sony_acpi_value *item;
 
-	if (debug) {
-		status = acpi_remove_notify_handler(sony_acpi_handle,
-						    ACPI_DEVICE_NOTIFY,
-						    sony_acpi_notify);
-		if (ACPI_FAILURE(status))
-			printk(LOG_PFX "unable to remove notify handler\n");
-	}
+	sony_acpi_acpi_device = NULL;
+
+	status = acpi_remove_notify_handler(sony_acpi_handle,
+					    ACPI_DEVICE_NOTIFY,
+					    sony_acpi_notify);
+	if (ACPI_FAILURE(status))
+		printk(LOG_PFX "unable to remove notify handler\n");
 
 	for (item = sony_acpi_values; item->name; ++item)
 		if (item->proc)

-- 
Stelian Pop <stelian@popies.net>

