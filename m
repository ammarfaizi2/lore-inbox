Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135584AbRAVXg1>; Mon, 22 Jan 2001 18:36:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135780AbRAVXgS>; Mon, 22 Jan 2001 18:36:18 -0500
Received: from 213.237.12.194.adsl.brh.worldonline.dk ([213.237.12.194]:21329
	"HELO firewall.jaquet.dk") by vger.kernel.org with SMTP
	id <S135750AbRAVXgE>; Mon, 22 Jan 2001 18:36:04 -0500
Date: Tue, 23 Jan 2001 00:35:57 +0100
From: Rasmus Andersen <rasmus@jaquet.dk>
To: compaqandlinux@cpqlin.van-dijk.net
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [PATCH] drivers/scsi/cpqfcTSinit.c cleanup (241p9)
Message-ID: <20010123003557.J602@jaquet.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

The following patch makes drivers/scsi/cpqfcTSinit.c check the
return code of ioremap, makes it use the return code of 
request_region instead of check_region and converts the touched
code to use forward gotos on error paths.

It applies cleanly against ac10 and 241p9.

Comments?


--- linux-ac10-clean/drivers/scsi/cpqfcTSinit.c	Sun Nov 12 04:01:11 2000
+++ linux-ac10/drivers/scsi/cpqfcTSinit.c	Sun Jan 21 23:39:23 2001
@@ -96,7 +96,7 @@
    Name) are not necessary.
    
 */
-static void Cpqfc_initHBAdata( CPQFCHBA *cpqfcHBAdata, struct pci_dev *PciDev )
+static int Cpqfc_initHBAdata( CPQFCHBA *cpqfcHBAdata, struct pci_dev *PciDev )
 {
              
   cpqfcHBAdata->PciDev = PciDev; // copy PCI info ptr
@@ -115,6 +115,9 @@
   cpqfcHBAdata->fcChip.Registers.ReMapMemBase = 
     ioremap( PciDev->base_address[3] & PCI_BASE_ADDRESS_MEM_MASK,
              0x200);
+
+  if (!cpqfcHBAdata->fcChip.Registers.ReMapMemBase)
+	  return 1;
   
   cpqfcHBAdata->fcChip.Registers.RAMBase = 
     PciDev->base_address[4];
@@ -209,7 +212,7 @@
   cpqfcHBAdata->fcChip.ReadWriteWWN = CpqTsReadWriteWWN;
   cpqfcHBAdata->fcChip.ReadWriteNVRAM = CpqTsReadWriteNVRAM;
 
- 
+  return 0;
 
 }
 
@@ -329,8 +332,11 @@
       cpqfcHBAdata->HBAnum = NumberOfAdapters;
 
       cpqfcHBAdata->HostAdapter = HostAdapter; // back ptr
-      Cpqfc_initHBAdata( cpqfcHBAdata, PciDev ); // fill MOST fields
-     
+      if (!Cpqfc_initHBAdata( cpqfcHBAdata, PciDev )) { // fill MOST fields
+	      printk(KERN_WARNING "Error initializing cpqfc data\n");
+	      goto err_unregister;
+      }
+		      
       cpqfcHBAdata->HBAnum = NumberOfAdapters;
 
 
@@ -342,33 +348,25 @@
 		       HostAdapter) )
       {
 	printk(" IRQ %u already used\n", HostAdapter->irq);
-        scsi_unregister( HostAdapter);
-	continue;
+	goto err_unmap;
       }
 
       // Since we have two 256-byte I/O port ranges (upper
-      // and lower), check them both
-      if( check_region( cpqfcHBAdata->fcChip.Registers.IOBaseU, 0xff) )
+      // and lower), get them both
+      if(!request_region( cpqfcHBAdata->fcChip.Registers.IOBaseU, 0xff, DEV_NAME) )
       {
 	printk("  cpqfcTS address in use: %x\n", 
 			cpqfcHBAdata->fcChip.Registers.IOBaseU);
-	free_irq( HostAdapter->irq, HostAdapter);
-        scsi_unregister( HostAdapter);
-	continue;
+	goto err_free_irq;
       }	
       
-      if( check_region( cpqfcHBAdata->fcChip.Registers.IOBaseL, 0xff) )
+      if(!request_region( cpqfcHBAdata->fcChip.Registers.IOBaseL, 0xff, DEV_NAME) )
       {
   	printk("  cpqfcTS address in use: %x\n", 
 	      			cpqfcHBAdata->fcChip.Registers.IOBaseL);
-	free_irq( HostAdapter->irq, HostAdapter);
-        scsi_unregister( HostAdapter);
-	continue;
+	goto err_release_register;
       }	
       
-      // OK, we should be able to grab everything we need now.
-      request_region( cpqfcHBAdata->fcChip.Registers.IOBaseL, 0xff, DEV_NAME);
-      request_region( cpqfcHBAdata->fcChip.Registers.IOBaseU, 0xff, DEV_NAME);
       DEBUG_PCI(printk("  Requesting 255 I/O addresses @ %x\n",
         cpqfcHBAdata->fcChip.Registers.IOBaseL ));
       DEBUG_PCI(printk("  Requesting 255 I/O addresses @ %x\n",
@@ -419,6 +417,18 @@
       }
       
       NumberOfAdapters++; 
+      continue;
+
+    err_release_register:
+	release_region(cpqfcHBAdata->fcChip.Registers.IOBaseU, 0xff);
+    err_free_irq:
+	free_irq( HostAdapter->irq, HostAdapter);
+    err_unmap:
+	iounmap(PciDev->base_address[3] & PCI_BASE_ADDRESS_MEM_MASK,
+             0x200);
+    err_unregister:
+        scsi_unregister( HostAdapter);
+
     } // end of while()
   }
 
@@ -707,7 +717,7 @@
  /* we get "vfree: bad address" executing this - need to investigate... 
   if( (void*)((unsigned long)cpqfcHBAdata->fcChip.Registers.MemBase) !=
       cpqfcHBAdata->fcChip.Registers.ReMapMemBase)
-    vfree( cpqfcHBAdata->fcChip.Registers.ReMapMemBase);
+    iounmap( cpqfcHBAdata->fcChip.Registers.ReMapMemBase);
 */
 
   LEAVE("cpqfcTS_release");

-- 
        Rasmus(rasmus@jaquet.dk)

Are they taking DDT?
                -- Vice President Dan Quayle asking doctors at a Manhattan
                   AIDS clinic about their treatments of choice, 4/30/92
                   (reported in Esquire, 8/92, and NY Post early May 92)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
