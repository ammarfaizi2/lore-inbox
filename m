Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135535AbRAVXfR>; Mon, 22 Jan 2001 18:35:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130794AbRAVXfI>; Mon, 22 Jan 2001 18:35:08 -0500
Received: from 213.237.12.194.adsl.brh.worldonline.dk ([213.237.12.194]:21073
	"HELO firewall.jaquet.dk") by vger.kernel.org with SMTP
	id <S131022AbRAVXew>; Mon, 22 Jan 2001 18:34:52 -0500
Date: Tue, 23 Jan 2001 00:34:45 +0100
From: Rasmus Andersen <rasmus@jaquet.dk>
To: dledford@redhat.com
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [PATCH] drivers/scsi/aic7xxx.c: check_region -> request_region (241p9)
Message-ID: <20010123003445.I602@jaquet.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

The following patch makes drivers/scsi/aic7xxx.c use the return
code of request_region instead of check_region. Since this
touched a lot of error paths I converted them to forward gotos
while I was there anyway.

It applies cleanly against ac10 and 241p9.

Comments?


--- linux-ac10-clean/drivers/scsi/aic7xxx.c	Sat Jan 20 15:17:12 2001
+++ linux-ac10/drivers/scsi/aic7xxx.c	Mon Jan 22 23:13:42 2001
@@ -9687,7 +9687,7 @@
           pci_write_config_dword(pdev, DEVCONFIG, devconfig);
 #endif /* AIC7XXX_STRICT_PCI_SETUP */
 
-          if(temp_p->base && check_region(temp_p->base, MAXREG - MINREG))
+          if(temp_p->base && !request_region(temp_p->base, MAXREG - MINREG, "aic7xxx"))
           {
             printk("aic7xxx: <%s> at PCI %d/%d/%d\n", 
               board_names[aic_pdevs[i].board_name_index],
@@ -9695,9 +9695,7 @@
               PCI_SLOT(temp_p->pci_device_fn),
               PCI_FUNC(temp_p->pci_device_fn));
             printk("aic7xxx: I/O ports already in use, ignoring.\n");
-            kfree(temp_p);
-            temp_p = NULL;
-            continue;
+            goto err_free;
           }
 
           temp_p->unpause = INTEN;
@@ -9712,9 +9710,7 @@
               PCI_SLOT(temp_p->pci_device_fn),
               PCI_FUNC(temp_p->pci_device_fn));
             printk("aic7xxx: Controller disabled by BIOS, ignoring.\n");
-            kfree(temp_p);
-            temp_p = NULL;
-            continue;
+            goto err_release;
           }
 
 #ifdef MMAPIO
@@ -9747,7 +9743,7 @@
                 printk(KERN_INFO "aic7xxx: MMAPed I/O failed, reverting to "
                                  "Programmed I/O.\n");
                 iounmap((void *) (((unsigned long) temp_p->maddr) & PAGE_MASK));
-                temp_p->maddr = 0;
+                temp_p->maddr = NULL;
                 if(temp_p->base == 0)
                 {
                   printk("aic7xxx: <%s> at PCI %d/%d/%d\n", 
@@ -9756,9 +9752,7 @@
                     PCI_SLOT(temp_p->pci_device_fn),
                     PCI_FUNC(temp_p->pci_device_fn));
                   printk("aic7xxx: Controller disabled by BIOS, ignoring.\n");
-                  kfree(temp_p);
-                  temp_p = NULL;
-                  continue;
+                  goto err_unmap;
                 }
               }
             }
@@ -9766,12 +9760,6 @@
 #endif
 
           /*
-           * Lock out other contenders for our i/o space.
-           */
-          if(temp_p->base)
-            request_region(temp_p->base, MAXREG - MINREG, "aic7xxx");
-
-          /*
            * We HAVE to make sure the first pause_sequencer() and all other
            * subsequent I/O that isn't PCI config space I/O takes place
            * after the MMAPed I/O region is configured and tested.  The
@@ -9806,12 +9794,7 @@
           sxfrctl1 = aic_inb(temp_p, SXFRCTL1);
 
           if (aic7xxx_chip_reset(temp_p) == -1)
-          {
-            release_region(temp_p->base, MAXREG - MINREG);
-            kfree(temp_p);
-            temp_p = NULL;
-            continue;
-          }
+            goto err_unmap;
           /*
            * Very quickly put the term setting back into the register since
            * the chip reset may cause odd things to happen.  This is to keep
@@ -10096,6 +10079,18 @@
           printk(KERN_INFO "aic7xxx: Unable to allocate device memory, "
             "skipping.\n");
         }
+        continue;
+
+      err_unmap:
+        if (temp_p->maddr)
+                iounmap((void *) (((unsigned long) temp_p->maddr) & PAGE_MASK));
+      err_release:
+        if (temp_p->base)
+                release_region(temp_p->base, MAXREG - MINREG);
+      err_free:
+        kfree(temp_p);
+        temp_p = NULL;
+        
       } /* while(pdev=....) */
     } /* for PCI_DEVICES */
   } /* PCI BIOS present */

-- 
Regards,
        Rasmus(rasmus@jaquet.dk)

Duct tape is like the force; it has a light side and a dark side, and
it holds the universe together.
  -- Anonymous
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
