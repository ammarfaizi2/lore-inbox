Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281202AbRKPDdI>; Thu, 15 Nov 2001 22:33:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281203AbRKPDc6>; Thu, 15 Nov 2001 22:32:58 -0500
Received: from c1473286-a.stcla1.sfba.home.com ([24.176.137.160]:13071 "HELO
	ocean.lucon.org") by vger.kernel.org with SMTP id <S281202AbRKPDco>;
	Thu, 15 Nov 2001 22:32:44 -0500
Date: Thu, 15 Nov 2001 19:32:35 -0800
From: "H . J . Lu" <hjl@lucon.org>
To: Andrew Morton <akpm@zip.com.au>
Cc: hogsberg@users.sourceforge.net, jamesg@filanet.com,
        linux-1394devel@lists.sourceforge.net,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: sbp2.c on SMP
Message-ID: <20011115193234.A22081@lucon.org>
In-Reply-To: <3BEF27D1.7793AE8E@zip.com.au>, <3BEF27D1.7793AE8E@zip.com.au>; <20011113191721.A9276@lucon.org> <3BF21B79.5F188A0D@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3BF21B79.5F188A0D@zip.com.au>; from akpm@zip.com.au on Tue, Nov 13, 2001 at 11:21:29PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 13, 2001 at 11:21:29PM -0800, Andrew Morton wrote:
> "H . J . Lu" wrote:
> > 
> > Here is another patch. It fixes:
> > 
> > # modprobe ohci1394
> > # rmmod ohci1394
> > 
> > H.J.
> > --- linux-2.4.9-12.2mod/drivers/ieee1394/nodemgr.c.rmmod        Tue Nov 13 19:15:44 2001
> > +++ linux-2.4.9-12.2mod/drivers/ieee1394/nodemgr.c      Tue Nov 13 19:11:38 2001
> > @@ -570,7 +570,8 @@ static void nodemgr_remove_host(struct h
> >         write_lock_irqsave(&node_lock, flags);
> >         list_for_each(lh, &node_list) {
> >                 ne = list_entry(lh, struct node_entry, list);
> > -
> > +               if (!ne)
> > +                       break;
> >                 /* Only checking this host */
> >                 if (ne->host != host)
> >                         continue;
> > @@ -582,6 +583,8 @@ static void nodemgr_remove_host(struct h
> >         spin_lock_irqsave (&host_info_lock, flags);
> >         list_for_each(lh, &host_info_list) {
> >                 struct host_info *myhi = list_entry(lh, struct host_info, list);
> > +               if (!myhi)
> > +                       break;
> >                 if (myhi->host == host) {
> >                         hi = myhi;
> >                         break;
> 
> I don't think so.  Look at the definition of list_entry.
> It's just a pointer offset.  So if `ne' is zero, then `lh'
> must have been -16 or so.
> 

I don't thik so. Zero `ne' means the `list' field which `lh' points
to is NULL.

> There seems to be a problem with module reference counts:
> 
> mnm:/home/akpm> lsmod
> Module                  Size  Used by
> sbp2                   14656   0 (unused)
> ohci1394               22224   0 (unused)
> ieee1394               26768   0 [sbp2 ohci1394]
> eepro100               17664   1 (autoclean)
> mnm:/home/akpm> 0 mount /dev/sdb1 /mnt/sdb1
> mnm:/home/akpm> lsmod
> Module                  Size  Used by
> sbp2                   14656   1
> ohci1394               22224   0 (unused)
> ieee1394               26768   0 [sbp2 ohci1394]
> eepro100               17664   1 (autoclean)
> 
> So it's possible to unload ohci1394.o and ieee1394.o while they're
> in use.
> 
> The fix isn't pretty, because the logical place where the module
> refcount needs to be incremented in ieee1394.o is called from
> external modules, as well as from within ieee1394.o itself.
> The latter of course makes the module permanently unloadable.
> 
> So we introduce a `different_module' flag which is set when
> the caller is from a different module.  Ugh.  Perhaps the
> maintainers can do better?
> 
> Also use the hpsb_host_template.devctl() method in hl_all_hosts()
> when a new client is registered to bump the refcount of ohci1394.o.
> 
> Anyway, here's my aggregate patch.  It appears to work, which is
> about the best that I can say about it.
> 

I think you missed hpsb_register_lowlevel/hpsb_unregister_lowlevel.


H.J.
---
--- linux-2.4.9-12.2mod/drivers/ieee1394/csr.c.rmmod	Thu Jul 19 17:48:15 2001
+++ linux-2.4.9-12.2mod/drivers/ieee1394/csr.c	Thu Nov 15 17:05:58 2001
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
--- linux-2.4.9-12.2mod/drivers/ieee1394/highlevel.c.rmmod	Mon Nov 12 16:46:35 2001
+++ linux-2.4.9-12.2mod/drivers/ieee1394/highlevel.c	Thu Nov 15 18:30:47 2001
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
@@ -51,7 +56,7 @@ struct hpsb_highlevel *hpsb_register_hig
         return hl;
 }
 
-void hpsb_unregister_highlevel(struct hpsb_highlevel *hl)
+void hpsb_unregister_highlevel(struct hpsb_highlevel *hl, int different_module)
 {
         struct list_head *entry;
         struct hpsb_address_serve *as;
@@ -77,6 +82,8 @@ void hpsb_unregister_highlevel(struct hp
         write_unlock_irq(&hl_drivers_lock);
 
         kfree(hl);
+	if (different_module)
+		MOD_DEC_USE_COUNT;
 }
 
 int hpsb_register_addrspace(struct hpsb_highlevel *hl,
--- linux-2.4.9-12.2mod/drivers/ieee1394/highlevel.h.rmmod	Thu Jul 19 17:48:15 2001
+++ linux-2.4.9-12.2mod/drivers/ieee1394/highlevel.h	Thu Nov 15 17:05:58 2001
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
--- linux-2.4.9-12.2mod/drivers/ieee1394/hosts.c.rmmod	Sun Aug 12 12:39:02 2001
+++ linux-2.4.9-12.2mod/drivers/ieee1394/hosts.c	Thu Nov 15 18:00:05 2001
@@ -11,6 +11,7 @@
  */
 
 #include <linux/config.h>
+#include <linux/module.h>
 
 #include <linux/types.h>
 #include <linux/init.h>
@@ -39,6 +40,8 @@ void hl_all_hosts(struct hpsb_highlevel 
 
         for (tmpl = templates; tmpl != NULL; tmpl = tmpl->next) {
                 for (host = tmpl->hosts; host != NULL; host = host->next) {
+			if (tmpl->devctl)
+				tmpl->devctl(host, MODIFY_USAGE, init);
                         if (host->initialized) {
                                 if (init) {
                                         if (hl->op->add_host) {
@@ -258,6 +261,7 @@ int hpsb_register_lowlevel(struct hpsb_h
 		init_hosts(tmpl);
 	}
 
+	MOD_INC_USE_COUNT;
         return 0;
 }
 
@@ -268,4 +272,6 @@ void hpsb_unregister_lowlevel(struct hps
         if (remove_template(tmpl)) {
                 HPSB_PANIC("remove_template failed on %s", tmpl->name);
         }
+
+	MOD_DEC_USE_COUNT;
 }
--- linux-2.4.9-12.2mod/drivers/ieee1394/nodemgr.c.rmmod	Tue Nov 13 19:15:44 2001
+++ linux-2.4.9-12.2mod/drivers/ieee1394/nodemgr.c	Thu Nov 15 18:27:05 2001
@@ -570,7 +570,8 @@ static void nodemgr_remove_host(struct h
 	write_lock_irqsave(&node_lock, flags);
 	list_for_each(lh, &node_list) {
 		ne = list_entry(lh, struct node_entry, list);
-
+		if (!ne)
+			break;
 		/* Only checking this host */
 		if (ne->host != host)
 			continue;
@@ -582,6 +583,8 @@ static void nodemgr_remove_host(struct h
 	spin_lock_irqsave (&host_info_lock, flags);
 	list_for_each(lh, &host_info_list) {
 		struct host_info *myhi = list_entry(lh, struct host_info, list);
+		if (!myhi)
+			break;
 		if (myhi->host == host) {
 			hi = myhi;
 			break;
@@ -612,7 +615,7 @@ static struct hpsb_highlevel *hl;
 
 void init_ieee1394_nodemgr(void)
 {
-        hl = hpsb_register_highlevel("Node manager", &nodemgr_ops);
+        hl = hpsb_register_highlevel("Node manager", &nodemgr_ops, 0);
         if (!hl) {
                 HPSB_ERR("Out of memory during ieee1394 initialization");
         }
@@ -620,5 +623,5 @@ void init_ieee1394_nodemgr(void)
 
 void cleanup_ieee1394_nodemgr(void)
 {
-        hpsb_unregister_highlevel(hl);
+        hpsb_unregister_highlevel(hl, 0);
 }
--- linux-2.4.9-12.2mod/drivers/ieee1394/raw1394.c.rmmod	Sun Nov 11 21:06:48 2001
+++ linux-2.4.9-12.2mod/drivers/ieee1394/raw1394.c	Thu Nov 15 17:05:58 2001
@@ -1002,7 +1002,7 @@ static struct file_operations file_ops =
 
 static int __init init_raw1394(void)
 {
-        hl_handle = hpsb_register_highlevel(RAW1394_DEVICE_NAME, &hl_ops);
+        hl_handle = hpsb_register_highlevel(RAW1394_DEVICE_NAME, &hl_ops, 1);
         if (hl_handle == NULL) {
                 HPSB_ERR("raw1394 failed to register with ieee1394 highlevel");
                 return -ENOMEM;
@@ -1026,7 +1026,7 @@ static void __exit cleanup_raw1394(void)
 {
         devfs_unregister_chrdev(RAW1394_DEVICE_MAJOR, RAW1394_DEVICE_NAME);
 	devfs_unregister(devfs_handle);
-        hpsb_unregister_highlevel(hl_handle);
+        hpsb_unregister_highlevel(hl_handle, 1);
 }
 
 module_init(init_raw1394);
--- linux-2.4.9-12.2mod/drivers/ieee1394/sbp2.c.rmmod	Thu Nov 15 17:08:49 2001
+++ linux-2.4.9-12.2mod/drivers/ieee1394/sbp2.c	Thu Nov 15 18:31:56 2001
@@ -914,7 +914,7 @@ int sbp2_init(void)
 	/*
 	 * Register our high level driver with 1394 stack
 	 */
-	sbp2_hl_handle = hpsb_register_highlevel(SBP2_DEVICE_NAME, &sbp2_hl_ops);
+	sbp2_hl_handle = hpsb_register_highlevel(SBP2_DEVICE_NAME, &sbp2_hl_ops, 1);
 
 	if (sbp2_hl_handle == NULL) {
 		SBP2_ERR("sbp2: sbp2 failed to register with ieee1394 highlevel");
@@ -948,7 +948,7 @@ void sbp2_cleanup(void)
 	SBP2_DEBUG("sbp2: sbp2_cleanup");
 
 	if (sbp2_hl_handle) {
-		hpsb_unregister_highlevel(sbp2_hl_handle);
+		hpsb_unregister_highlevel(sbp2_hl_handle, 1);
 		sbp2_hl_handle = NULL;
 	}
 	return;
@@ -3454,7 +3456,7 @@ static int sbp2scsi_detect (Scsi_Host_Te
 	if (!sbp2_host_count) {
 		SBP2_ERR("sbp2: Please load the lower level IEEE-1394 driver (e.g. ohci1394) before sbp2...");
 		if (sbp2_hl_handle) {
-			hpsb_unregister_highlevel(sbp2_hl_handle);
+			hpsb_unregister_highlevel(sbp2_hl_handle, 1);
 			sbp2_hl_handle = NULL;
 		}
 	}
--- linux-2.4.9-12.2mod/drivers/ieee1394/video1394.c.rmmod	Sun Nov 11 21:06:48 2001
+++ linux-2.4.9-12.2mod/drivers/ieee1394/video1394.c	Thu Nov 15 17:05:58 2001
@@ -1643,7 +1643,7 @@ MODULE_LICENSE("GPL");
 
 static void __exit video1394_exit_module (void)
 {
-	hpsb_unregister_highlevel (hl_handle);
+	hpsb_unregister_highlevel (hl_handle, 1);
 
 	devfs_unregister(devfs_handle);
 	devfs_unregister_chrdev(VIDEO1394_MAJOR, VIDEO1394_DRIVER_NAME);
@@ -1666,7 +1666,7 @@ static int __init video1394_init_module 
 	devfs_handle = devfs_mk_dir(NULL, VIDEO1394_DRIVER_NAME, NULL);
 #endif
 
-	hl_handle = hpsb_register_highlevel (VIDEO1394_DRIVER_NAME, &hl_ops);
+	hl_handle = hpsb_register_highlevel (VIDEO1394_DRIVER_NAME, &hl_ops, 1);
 	if (hl_handle == NULL) {
 		PRINT_G(KERN_ERR, "No more memory for driver\n");
 		devfs_unregister(devfs_handle);
