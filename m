Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280257AbRKNHWw>; Wed, 14 Nov 2001 02:22:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280255AbRKNHWn>; Wed, 14 Nov 2001 02:22:43 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:61700 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S280258AbRKNHWg>; Wed, 14 Nov 2001 02:22:36 -0500
Message-ID: <3BF21B79.5F188A0D@zip.com.au>
Date: Tue, 13 Nov 2001 23:21:29 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.14-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "H . J . Lu" <hjl@lucon.org>
CC: hogsberg@users.sourceforge.net, jamesg@filanet.com,
        linux-1394devel@lists.sourceforge.net,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: sbp2.c on SMP
In-Reply-To: <3BEF27D1.7793AE8E@zip.com.au>,
		<3BEF27D1.7793AE8E@zip.com.au>; from akpm@zip.com.au on Sun, Nov 11, 2001 at 05:37:21PM -0800 <20011113191721.A9276@lucon.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"H . J . Lu" wrote:
> 
> Here is another patch. It fixes:
> 
> # modprobe ohci1394
> # rmmod ohci1394
> 
> H.J.
> --- linux-2.4.9-12.2mod/drivers/ieee1394/nodemgr.c.rmmod        Tue Nov 13 19:15:44 2001
> +++ linux-2.4.9-12.2mod/drivers/ieee1394/nodemgr.c      Tue Nov 13 19:11:38 2001
> @@ -570,7 +570,8 @@ static void nodemgr_remove_host(struct h
>         write_lock_irqsave(&node_lock, flags);
>         list_for_each(lh, &node_list) {
>                 ne = list_entry(lh, struct node_entry, list);
> -
> +               if (!ne)
> +                       break;
>                 /* Only checking this host */
>                 if (ne->host != host)
>                         continue;
> @@ -582,6 +583,8 @@ static void nodemgr_remove_host(struct h
>         spin_lock_irqsave (&host_info_lock, flags);
>         list_for_each(lh, &host_info_list) {
>                 struct host_info *myhi = list_entry(lh, struct host_info, list);
> +               if (!myhi)
> +                       break;
>                 if (myhi->host == host) {
>                         hi = myhi;
>                         break;

I don't think so.  Look at the definition of list_entry.
It's just a pointer offset.  So if `ne' is zero, then `lh'
must have been -16 or so.

There seems to be a problem with module reference counts:

mnm:/home/akpm> lsmod
Module                  Size  Used by
sbp2                   14656   0 (unused)
ohci1394               22224   0 (unused)
ieee1394               26768   0 [sbp2 ohci1394]
eepro100               17664   1 (autoclean)
mnm:/home/akpm> 0 mount /dev/sdb1 /mnt/sdb1
mnm:/home/akpm> lsmod
Module                  Size  Used by
sbp2                   14656   1
ohci1394               22224   0 (unused)
ieee1394               26768   0 [sbp2 ohci1394]
eepro100               17664   1 (autoclean)

So it's possible to unload ohci1394.o and ieee1394.o while they're
in use.

The fix isn't pretty, because the logical place where the module
refcount needs to be incremented in ieee1394.o is called from
external modules, as well as from within ieee1394.o itself.
The latter of course makes the module permanently unloadable.

So we introduce a `different_module' flag which is set when
the caller is from a different module.  Ugh.  Perhaps the
maintainers can do better?

Also use the hpsb_host_template.devctl() method in hl_all_hosts()
when a new client is registered to bump the refcount of ohci1394.o.

Anyway, here's my aggregate patch.  It appears to work, which is
about the best that I can say about it.



--- linux-2.4.15-pre4/drivers/ieee1394/highlevel.h	Thu Jul 19 17:48:15 2001
+++ linux-akpm/drivers/ieee1394/highlevel.h	Tue Nov 13 22:36:40 2001
@@ -115,8 +115,9 @@ void highlevel_fcp_request(struct hpsb_h
  * because the string is not copied.
  */
 struct hpsb_highlevel *hpsb_register_highlevel(const char *name,
-                                               struct hpsb_highlevel_ops *ops);
-void hpsb_unregister_highlevel(struct hpsb_highlevel *hl);
+                                               struct hpsb_highlevel_ops *ops,
+						int different_module);
+void hpsb_unregister_highlevel(struct hpsb_highlevel *hl, int different_module);
 
 /*
  * Register handlers for host address spaces.  Start and end are 48 bit pointers
--- linux-2.4.15-pre4/drivers/ieee1394/csr.c	Thu Jul 19 17:48:15 2001
+++ linux-akpm/drivers/ieee1394/csr.c	Tue Nov 13 22:36:20 2001
@@ -425,7 +425,7 @@ static struct hpsb_highlevel *hl;
 
 void init_csr(void)
 {
-        hl = hpsb_register_highlevel("standard registers", &csr_ops);
+        hl = hpsb_register_highlevel("standard registers", &csr_ops, 0);
         if (hl == NULL) {
                 HPSB_ERR("out of memory during ieee1394 initialization");
                 return;
@@ -449,5 +449,5 @@ void init_csr(void)
 
 void cleanup_csr(void)
 {
-        hpsb_unregister_highlevel(hl);
+        hpsb_unregister_highlevel(hl, 0);
 }
--- linux-2.4.15-pre4/drivers/ieee1394/highlevel.c	Mon Oct  1 21:24:24 2001
+++ linux-akpm/drivers/ieee1394/highlevel.c	Tue Nov 13 23:12:33 2001
@@ -9,6 +9,7 @@
 
 #include <linux/config.h>
 #include <linux/slab.h>
+#include <linux/module.h>
 
 #include "ieee1394.h"
 #include "ieee1394_types.h"
@@ -28,7 +29,8 @@ static struct hpsb_address_ops dummy_ops
 static struct hpsb_address_serve dummy_zero_addr, dummy_max_addr;
 
 struct hpsb_highlevel *hpsb_register_highlevel(const char *name,
-                                               struct hpsb_highlevel_ops *ops)
+                                               struct hpsb_highlevel_ops *ops,
+						int different_module)
 {
         struct hpsb_highlevel *hl;
 
@@ -38,6 +40,9 @@ struct hpsb_highlevel *hpsb_register_hig
                 return NULL;
         }
 
+	if (different_module)
+		MOD_INC_USE_COUNT;
+
         INIT_LIST_HEAD(&hl->hl_list);
         INIT_LIST_HEAD(&hl->addr_list);
         hl->name = name;
@@ -51,15 +56,17 @@ struct hpsb_highlevel *hpsb_register_hig
         return hl;
 }
 
-void hpsb_unregister_highlevel(struct hpsb_highlevel *hl)
+void hpsb_unregister_highlevel(struct hpsb_highlevel *hl, int different_module)
 {
         struct list_head *entry;
         struct hpsb_address_serve *as;
 
         if (hl == NULL) {
+		printk(KERN_ERR __FUNCTION__ ": bug. null pointer.\n");
                 return;
         }
 
+	printk(__FUNCTION__ ": %s\n", hl->name);
         write_lock_irq(&addr_space_lock);
         entry = hl->addr_list.next;
 
@@ -77,6 +84,8 @@ void hpsb_unregister_highlevel(struct hp
         write_unlock_irq(&hl_drivers_lock);
 
         kfree(hl);
+	if (different_module)
+		MOD_DEC_USE_COUNT;
 }
 
 int hpsb_register_addrspace(struct hpsb_highlevel *hl,
--- linux-2.4.15-pre4/drivers/ieee1394/hosts.c	Mon Oct  1 21:24:24 2001
+++ linux-akpm/drivers/ieee1394/hosts.c	Tue Nov 13 23:05:35 2001
@@ -42,6 +42,8 @@ void hl_all_hosts(struct hpsb_highlevel 
                 tmpl = list_entry(tlh, struct hpsb_host_template, list);
 		list_for_each(hlh, &tmpl->hosts) {
 			host = list_entry(hlh, struct hpsb_host, list);
+			if (tmpl->devctl)
+				tmpl->devctl(host, MODIFY_USAGE, init);
                         if (host->initialized) {
                                 if (init) {
                                         if (hl->op->add_host) {
--- linux-2.4.15-pre4/drivers/ieee1394/nodemgr.c	Wed Oct 17 14:19:20 2001
+++ linux-akpm/drivers/ieee1394/nodemgr.c	Tue Nov 13 22:37:42 2001
@@ -891,7 +891,7 @@ static struct hpsb_highlevel *hl;
 
 void init_ieee1394_nodemgr(void)
 {
-        hl = hpsb_register_highlevel("Node manager", &nodemgr_ops);
+        hl = hpsb_register_highlevel("Node manager", &nodemgr_ops, 0);
         if (!hl) {
 		HPSB_ERR("NodeMgr: out of memory during ieee1394 initialization");
         }
@@ -899,5 +899,5 @@ void init_ieee1394_nodemgr(void)
 
 void cleanup_ieee1394_nodemgr(void)
 {
-        hpsb_unregister_highlevel(hl);
+        hpsb_unregister_highlevel(hl, 0);
 }
--- linux-2.4.15-pre4/drivers/ieee1394/raw1394.c	Mon Oct  1 21:24:24 2001
+++ linux-akpm/drivers/ieee1394/raw1394.c	Tue Nov 13 22:37:56 2001
@@ -1013,7 +1013,7 @@ static struct file_operations file_ops =
 
 static int __init init_raw1394(void)
 {
-        hl_handle = hpsb_register_highlevel(RAW1394_DEVICE_NAME, &hl_ops);
+        hl_handle = hpsb_register_highlevel(RAW1394_DEVICE_NAME, &hl_ops, 1);
         if (hl_handle == NULL) {
                 HPSB_ERR("raw1394 failed to register with ieee1394 highlevel");
                 return -ENOMEM;
@@ -1037,7 +1037,7 @@ static void __exit cleanup_raw1394(void)
 {
         devfs_unregister_chrdev(RAW1394_DEVICE_MAJOR, RAW1394_DEVICE_NAME);
 	devfs_unregister(devfs_handle);
-        hpsb_unregister_highlevel(hl_handle);
+        hpsb_unregister_highlevel(hl_handle, 1);
 }
 
 module_init(init_raw1394);
--- linux-2.4.15-pre4/drivers/ieee1394/sbp2.c	Wed Oct 17 14:19:20 2001
+++ linux-akpm/drivers/ieee1394/sbp2.c	Tue Nov 13 23:11:39 2001
@@ -836,7 +836,7 @@ int sbp2_init(void)
 	/*
 	 * Register our high level driver with 1394 stack
 	 */
-	sbp2_hl_handle = hpsb_register_highlevel(SBP2_DEVICE_NAME, &sbp2_hl_ops);
+	sbp2_hl_handle = hpsb_register_highlevel(SBP2_DEVICE_NAME, &sbp2_hl_ops, 1);
 
 	if (sbp2_hl_handle == NULL) {
 		SBP2_ERR("sbp2 failed to register with ieee1394 highlevel");
@@ -865,7 +865,7 @@ void sbp2_cleanup(void)
 	hpsb_unregister_protocol(&sbp2_driver);
 
 	if (sbp2_hl_handle) {
-		hpsb_unregister_highlevel(sbp2_hl_handle);
+		hpsb_unregister_highlevel(sbp2_hl_handle, 1);
 		sbp2_hl_handle = NULL;
 	}
 	return;
@@ -2767,7 +2767,9 @@ static void sbp2scsi_complete_command(st
 	/*
 	 * Tell scsi stack that we're done with this command
 	 */
+	spin_lock_irq(&io_request_lock);
 	done (SCpnt);
+	spin_unlock_irq(&io_request_lock);
 
 	return;
 }
--- linux-2.4.15-pre4/drivers/ieee1394/video1394.c	Mon Oct  1 21:24:25 2001
+++ linux-akpm/drivers/ieee1394/video1394.c	Tue Nov 13 22:38:12 2001
@@ -1647,7 +1647,7 @@ MODULE_LICENSE("GPL");
 
 static void __exit video1394_exit_module (void)
 {
-	hpsb_unregister_highlevel (hl_handle);
+	hpsb_unregister_highlevel (hl_handle, 1);
 
 	devfs_unregister(devfs_handle);
 	devfs_unregister_chrdev(VIDEO1394_MAJOR, VIDEO1394_DRIVER_NAME);
@@ -1670,7 +1670,7 @@ static int __init video1394_init_module 
 	devfs_handle = devfs_mk_dir(NULL, VIDEO1394_DRIVER_NAME, NULL);
 #endif
 
-	hl_handle = hpsb_register_highlevel (VIDEO1394_DRIVER_NAME, &hl_ops);
+	hl_handle = hpsb_register_highlevel (VIDEO1394_DRIVER_NAME, &hl_ops, 1);
 	if (hl_handle == NULL) {
 		PRINT_G(KERN_ERR, "No more memory for driver\n");
 		devfs_unregister(devfs_handle);
