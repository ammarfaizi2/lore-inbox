Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285229AbSBJXhM>; Sun, 10 Feb 2002 18:37:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285273AbSBJXhH>; Sun, 10 Feb 2002 18:37:07 -0500
Received: from smtp02.web.de ([217.72.192.151]:35106 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id <S285229AbSBJXgx>;
	Sun, 10 Feb 2002 18:36:53 -0500
Message-ID: <3C670B3A.10907@web.de>
Date: Mon, 11 Feb 2002 00:07:22 +0000
From: Todor Todorov <ttodorov@web.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20020203
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>,
        kjml <kernel-janitor-discuss@lists.sourceforge.net>
Subject: [PATCH] scsi_register cleanup
Content-Type: multipart/mixed;
 boundary="------------060004090300050803020800"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060004090300050803020800
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

this is part of the Kernel Janitor Project. As seen on the TODO list, I 
checked every call to the scsi_register() function and added a check for 
the return code where there wasn't any. Using cscope I checked every 
file that had a function calling scsi_register(), so I'm pretty much 
sure, that this is cleaned now. Patch against 2.5.3-dj4. Please review 
and apply if correct and appropriate.

Regards,
        Todor



--------------060004090300050803020800
Content-Type: text/plain;
 name="cleanup-scsi_register.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cleanup-scsi_register.diff"

diff -uNr linux-2.5.3-dj4.orig/drivers/acorn/scsi/acornscsi.c linux/drivers/acorn/scsi/acornscsi.c
--- linux-2.5.3-dj4.orig/drivers/acorn/scsi/acornscsi.c	Wed Dec 26 01:04:40 2001
+++ linux/drivers/acorn/scsi/acornscsi.c	Sun Feb 10 23:34:41 2002
@@ -2898,6 +2898,9 @@
 	ecard_claim(ecs[count]); /* Must claim here - card produces irq on reset */
 
 	instance = scsi_register(tpnt, sizeof(AS_Host));
+	if( !instance )
+		return count;
+	
 	host = (AS_Host *)instance->hostdata;
 
 	instance->io_port = ecard_address(ecs[count], ECARD_MEMC, 0);
@@ -2915,13 +2918,26 @@
 	ecs[count]->irqaddr	= (char *)ioaddr(host->card.io_intr);
 	ecs[count]->irqmask	= 0x0a;
 
-	request_region(instance->io_port + 0x800,  2, "acornscsi(sbic)");
-	request_region(host->card.io_intr,  1, "acornscsi(intr)");
-	request_region(host->card.io_page,  1, "acornscsi(page)");
+	if( !(request_region(instance->io_port + 0x800,  2, "acornscsi(sbic)")) )
+		goto unregister_scsi;
+	
+	if( !(request_region(host->card.io_intr,  1, "acornscsi(intr)")) )
+		goto release_first;
+	
+	if( !(request_region(host->card.io_page,  1, "acornscsi(page)")) )
+		goto release_second;
+		
 #ifdef USE_DMAC
-	request_region(host->dma.io_port, 256, "acornscsi(dmac)");
+	if( !(request_region(host->dma.io_port, 256, "acornscsi(dmac)")) )
+		goto release_third;
+#endif
+	
+	if( !(request_region(instance->io_port, 2048, "acornscsi(ram)")) )
+#ifdef USE_DMAC
+		goto release_fourth;
+#else
+		goto release_third;
 #endif
-	request_region(instance->io_port, 2048, "acornscsi(ram)");
 
 	if (request_irq(host->scsi.irq, acornscsi_intr, SA_INTERRUPT, "acornscsi", host)) {
 	    printk(KERN_CRIT "scsi%d: IRQ%d not free, interrupts disabled\n",
@@ -2933,7 +2949,20 @@
 
 	++count;
     }
-    return count;
+	
+out:	return count;
+
+release_fourth:
+	release_region( host->dma.io_port, 256 );
+release_third:
+	release_region( host->card.io_page,  1 );
+release_second:
+	release_region( host->card.io_intr,  1 );
+release_first:
+	release_region( instance->io_port + 0x800,  2 );
+unregister_scsi:
+	scsi_unregister( instance );
+	goto out;
 }
 
 /*
diff -uNr linux-2.5.3-dj4.orig/drivers/acorn/scsi/cumana_1.c linux/drivers/acorn/scsi/cumana_1.c
--- linux-2.5.3-dj4.orig/drivers/acorn/scsi/cumana_1.c	Wed Dec 26 01:04:40 2001
+++ linux/drivers/acorn/scsi/cumana_1.c	Sun Feb 10 23:34:16 2002
@@ -141,6 +141,9 @@
     		break;
 
         instance = scsi_register (tpnt, sizeof(struct NCR5380_hostdata));
+		if( !instance )
+			goto out;
+		
         instance->io_port = CUMANA_ADDRESS(ecs[count]);
 	instance->irq = CUMANA_IRQ(ecs[count]);
 
@@ -148,7 +151,8 @@
 	ecard_claim(ecs[count]);
 
 	instance->n_io_port = 255;
-	request_region (instance->io_port, instance->n_io_port, "CumanaSCSI-1");
+	if( !(request_region (instance->io_port, instance->n_io_port, "CumanaSCSI-1")) )
+		goto unregister_scsi;
 
         ((struct NCR5380_hostdata *)instance->hostdata)->ctrl = 0;
         outb(0x00, instance->io_port - 577);
@@ -178,7 +182,11 @@
 
 	++count;
     }
-    return count;
+	
+out:	return count;
+unregister_scsi:
+		scsi_unregister( instance );
+		goto out;
 }
 
 int cumanascsi_release (struct Scsi_Host *shpnt)
diff -uNr linux-2.5.3-dj4.orig/drivers/acorn/scsi/ecoscsi.c linux/drivers/acorn/scsi/ecoscsi.c
--- linux-2.5.3-dj4.orig/drivers/acorn/scsi/ecoscsi.c	Wed Dec 26 01:04:40 2001
+++ linux/drivers/acorn/scsi/ecoscsi.c	Sun Feb 10 23:33:34 2002
@@ -104,28 +104,25 @@
     tpnt->proc_name = "ecoscsi";
 
     instance = scsi_register (tpnt, sizeof(struct NCR5380_hostdata));
+	if( !instance )
+		return 0;
+	
     instance->io_port = 0x80ce8000;
     instance->n_io_port = 144;
     instance->irq = IRQ_NONE;
 
-    if (check_region (instance->io_port, instance->n_io_port)) {
-	scsi_unregister (instance);
-	return 0;
-    }
+    if( !(request_region (instance->io_port, instance->n_io_port, "ecoscsi")) )
+		goto unregister_scsi;
 
     ecoscsi_write (instance, MODE_REG, 0x20);		/* Is it really SCSI? */
-    if (ecoscsi_read (instance, MODE_REG) != 0x20) {	/* Write to a reg.    */
-        scsi_unregister(instance);
-        return 0;					/* and try to read    */
-    }
+    if (ecoscsi_read (instance, MODE_REG) != 0x20)	/* Write to a reg.    */
+        goto release_reg;							/* and try to read    */
+
     ecoscsi_write( instance, MODE_REG, 0x00 );		/* it back.	      */
-    if (ecoscsi_read (instance, MODE_REG) != 0x00) {
-        scsi_unregister(instance);
-        return 0;
-    }
+    if (ecoscsi_read (instance, MODE_REG) != 0x00)
+        goto release_reg;
 
     NCR5380_init(instance, 0);
-    request_region (instance->io_port, instance->n_io_port, "ecoscsi");
 
     if (instance->irq != IRQ_NONE)
 	if (request_irq(instance->irq, do_ecoscsi_intr, SA_INTERRUPT, "ecoscsi", NULL)) {
@@ -149,7 +146,13 @@
     printk("\nscsi%d:", instance->host_no);
     NCR5380_print_options(instance);
     printk("\n");
-    return 1;
+	
+	return 1;
+release_reg:
+	release_region( instance->io_port, instance->n_io_port );	
+unregister_scsi:
+	scsi_unregister( instance );
+	return 0;
 }
 
 int ecoscsi_release (struct Scsi_Host *shpnt)
diff -uNr linux-2.5.3-dj4.orig/drivers/acorn/scsi/oak.c linux/drivers/acorn/scsi/oak.c
--- linux-2.5.3-dj4.orig/drivers/acorn/scsi/oak.c	Wed Dec 26 01:04:40 2001
+++ linux/drivers/acorn/scsi/oak.c	Sun Feb 10 23:38:58 2002
@@ -127,6 +127,9 @@
             break;
 
         instance = scsi_register (tpnt, sizeof(struct NCR5380_hostdata));
+		if( !instance )
+			goto out;
+		
         instance->io_port = OAK_ADDRESS(ecs[count]);
         instance->irq = OAK_IRQ(ecs[count]);
 
@@ -134,7 +137,8 @@
 	ecard_claim(ecs[count]);
 
 	instance->n_io_port = 255;
-	request_region (instance->io_port, instance->n_io_port, "Oak SCSI");
+	if( !(request_region (instance->io_port, instance->n_io_port, "Oak SCSI")) )
+		goto unregister_scsi:
 
 	if (instance->irq != IRQ_NONE)
 	    if (request_irq(instance->irq, do_oakscsi_intr, SA_INTERRUPT, "Oak SCSI", NULL)) {
@@ -165,7 +169,11 @@
     if(count == 0)
         printk("No oak scsi devices found\n");
 #endif
+
+out:
     return count;
+unregister_scsi:
+	scsi_unregister( instance );
 }
 
 int oakscsi_release (struct Scsi_Host *shpnt)
diff -uNr linux-2.5.3-dj4.orig/drivers/scsi/aacraid/linit.c linux/drivers/scsi/aacraid/linit.c
--- linux-2.5.3-dj4.orig/drivers/scsi/aacraid/linit.c	Sun Feb 10 19:09:03 2002
+++ linux/drivers/scsi/aacraid/linit.c	Sun Feb 10 20:56:35 2002
@@ -189,6 +189,8 @@
 			 * specific information.
 			 */
 			host_ptr = scsi_register( template, sizeof(struct aac_dev) );
+			if( !host_ptr )
+				continue;
 			/* 
 			 * These three parameters can be used to allow for wide SCSI 
 			 * and for host adapters that support multiple buses.
diff -uNr linux-2.5.3-dj4.orig/drivers/scsi/gdth.c linux/drivers/scsi/gdth.c
--- linux-2.5.3-dj4.orig/drivers/scsi/gdth.c	Sun Feb 10 19:09:04 2002
+++ linux/drivers/scsi/gdth.c	Sun Feb 10 21:53:23 2002
@@ -3991,112 +3991,114 @@
         if (gdth_ctr_count >= MAXHA) 
             break;
         if (gdth_search_isa(isa_bios)) {        /* controller found */
-            shp = scsi_register(shtp,sizeof(gdth_ext_str));
-            ha = HADATA(shp);
-            if (!gdth_init_isa(isa_bios,ha)) {
-                scsi_unregister(shp);
-                continue;
-            }
+            if( (shp = scsi_register(shtp,sizeof(gdth_ext_str))) != NULL ) {
+            	ha = HADATA(shp);
+            	if (!gdth_init_isa(isa_bios,ha)) {
+                	scsi_unregister(shp);
+                	continue;
+            	}
 #ifdef __ia64__
-            break;
+            	break;
 #else
-            /* controller found and initialized */
-            printk("Configuring GDT-ISA HA at BIOS 0x%05X IRQ %u DRQ %u\n",
-                   isa_bios,ha->irq,ha->drq);
+            	/* controller found and initialized */
+            	printk("Configuring GDT-ISA HA at BIOS 0x%05X IRQ %u DRQ %u\n",
+                		isa_bios,ha->irq,ha->drq);
 
 #if LINUX_VERSION_CODE >= 0x010346 
-            if (request_irq(ha->irq,gdth_interrupt,SA_INTERRUPT,"gdth",ha))
+            	if (request_irq(ha->irq,gdth_interrupt,SA_INTERRUPT,"gdth",ha))
 #else
-            if (request_irq(ha->irq,gdth_interrupt,SA_INTERRUPT,"gdth")) 
+            	if (request_irq(ha->irq,gdth_interrupt,SA_INTERRUPT,"gdth")) 
 #endif
-            {
-                printk("GDT-ISA: Unable to allocate IRQ\n");
-                scsi_unregister(shp);
-                continue;
-            }
-            if (request_dma(ha->drq,"gdth")) {
-                printk("GDT-ISA: Unable to allocate DMA channel\n");
+            	{
+                	printk("GDT-ISA: Unable to allocate IRQ\n");
+                	scsi_unregister(shp);
+					continue;
+            	}
+            	if (request_dma(ha->drq,"gdth")) {
+                	printk("GDT-ISA: Unable to allocate DMA channel\n");
 #if LINUX_VERSION_CODE >= 0x010346 
-                free_irq(ha->irq,ha);
+                	free_irq(ha->irq,ha);
 #else
-                free_irq(ha->irq);
+                	free_irq(ha->irq);
 #endif
-                scsi_unregister(shp);
-                continue;
-            }
-            set_dma_mode(ha->drq,DMA_MODE_CASCADE);
-            enable_dma(ha->drq);
-            shp->unchecked_isa_dma = 1;
-            shp->irq = ha->irq;
-            shp->dma_channel = ha->drq;
-            hanum = gdth_ctr_count;         
-            gdth_ctr_tab[gdth_ctr_count++] = shp;
-            gdth_ctr_vtab[gdth_ctr_vcount++] = shp;
+                	scsi_unregister(shp);
+                	continue;
+            	}
+            	set_dma_mode(ha->drq,DMA_MODE_CASCADE);
+            	enable_dma(ha->drq);
+            	shp->unchecked_isa_dma = 1;
+            	shp->irq = ha->irq;
+            	shp->dma_channel = ha->drq;
+            	hanum = gdth_ctr_count;         
+            	gdth_ctr_tab[gdth_ctr_count++] = shp;
+            	gdth_ctr_vtab[gdth_ctr_vcount++] = shp;
 
-            NUMDATA(shp)->hanum = (ushort)hanum;
-            NUMDATA(shp)->busnum= 0;
+            	NUMDATA(shp)->hanum = (ushort)hanum;
+            	NUMDATA(shp)->busnum= 0;
 
-            ha->pccb = CMDDATA(shp);
+            	ha->pccb = CMDDATA(shp);
 #if LINUX_VERSION_CODE >= 0x020322
-            ha->pscratch = (void *) __get_free_pages(GFP_ATOMIC | GFP_DMA, 
+            	ha->pscratch = (void *) __get_free_pages(GFP_ATOMIC | GFP_DMA, 
                                                      GDTH_SCRATCH_ORD);
 #else
-            ha->pscratch = scsi_init_malloc(GDTH_SCRATCH, GFP_ATOMIC | GFP_DMA);
+            	ha->pscratch = scsi_init_malloc(GDTH_SCRATCH, GFP_ATOMIC | GFP_DMA);
 #endif
-            ha->scratch_busy = FALSE;
-            ha->req_first = NULL;
-            ha->tid_cnt = MAX_HDRIVES;
-            if (max_ids > 0 && max_ids < ha->tid_cnt)
-                ha->tid_cnt = max_ids;
-            for (i=0; i<GDTH_MAXCMDS; ++i)
-                ha->cmd_tab[i].cmnd = UNUSED_CMND;
-            ha->scan_mode = rescan ? 0x10 : 0;
-
-            if (ha->pscratch == NULL || !gdth_search_drives(hanum)) {
-                printk("GDT-ISA: Error during device scan\n");
-                --gdth_ctr_count;
-                --gdth_ctr_vcount;
-                if (ha->pscratch != NULL)
+            	ha->scratch_busy = FALSE;
+            	ha->req_first = NULL;
+            	ha->tid_cnt = MAX_HDRIVES;
+            	if (max_ids > 0 && max_ids < ha->tid_cnt)
+                	ha->tid_cnt = max_ids;
+            	for (i=0; i<GDTH_MAXCMDS; ++i)
+                	ha->cmd_tab[i].cmnd = UNUSED_CMND;
+            	ha->scan_mode = rescan ? 0x10 : 0;
+
+            	if (ha->pscratch == NULL || !gdth_search_drives(hanum)) {
+                	printk("GDT-ISA: Error during device scan\n");
+                	--gdth_ctr_count;
+                	--gdth_ctr_vcount;
+                	if (ha->pscratch != NULL)
 #if LINUX_VERSION_CODE >= 0x020322
-                    free_pages((unsigned long)ha->pscratch, GDTH_SCRATCH_ORD);
+                    	free_pages((unsigned long)ha->pscratch, GDTH_SCRATCH_ORD);
 #else
-                    scsi_init_free((void *)ha->pscratch, GDTH_SCRATCH);
+                    	scsi_init_free((void *)ha->pscratch, GDTH_SCRATCH);
 #endif
 #if LINUX_VERSION_CODE >= 0x010346 
-                free_irq(ha->irq,ha);
+                	free_irq(ha->irq,ha);
 #else
-                free_irq(ha->irq);
+                	free_irq(ha->irq);
 #endif
-                scsi_unregister(shp);
-                continue;
-            }
-            if (hdr_channel < 0 || hdr_channel > ha->bus_cnt)
-                hdr_channel = ha->bus_cnt;
-            ha->virt_bus = hdr_channel;
+                	scsi_unregister(shp);
+                	continue;
+            	}
+            	if (hdr_channel < 0 || hdr_channel > ha->bus_cnt)
+                	hdr_channel = ha->bus_cnt;
+            	ha->virt_bus = hdr_channel;
 
 #if LINUX_VERSION_CODE >= 0x020000
-            shp->max_id      = ha->tid_cnt;
-            shp->max_lun     = MAXLUN;
-            shp->max_channel = virt_ctr ? 0 : ha->bus_cnt;
-            if (virt_ctr)  
-#endif
-            {
-                virt_ctr = 1;
-                /* register addit. SCSI channels as virtual controllers */
-                for (b = 1; b < ha->bus_cnt + 1; ++b) {
-                    shp = scsi_register(shtp,sizeof(gdth_num_str));
-                    shp->unchecked_isa_dma = 1;
-                    shp->irq = ha->irq;
-                    shp->dma_channel = ha->drq;
-                    gdth_ctr_vtab[gdth_ctr_vcount++] = shp;
-                    NUMDATA(shp)->hanum = (ushort)hanum;
-                    NUMDATA(shp)->busnum = b;
-                }
-            }  
+            	shp->max_id      = ha->tid_cnt;
+            	shp->max_lun     = MAXLUN;
+            	shp->max_channel = virt_ctr ? 0 : ha->bus_cnt;
+            	if (virt_ctr)  
+#endif
+            	{
+                	virt_ctr = 1;
+                	/* register addit. SCSI channels as virtual controllers */
+                	for (b = 1; b < ha->bus_cnt + 1; ++b) {
+                    	if( (shp = scsi_register(shtp,sizeof(gdth_num_str))) != NULL ) {
+                    		shp->unchecked_isa_dma = 1;
+                    		shp->irq = ha->irq;
+                    		shp->dma_channel = ha->drq;
+                    		gdth_ctr_vtab[gdth_ctr_vcount++] = shp;
+                    		NUMDATA(shp)->hanum = (ushort)hanum;
+                    		NUMDATA(shp)->busnum = b;
+						}
+                	}
+            	}  
 
-            GDTH_INIT_LOCK_HA(ha);
-            gdth_enable_int(hanum);
+            	GDTH_INIT_LOCK_HA(ha);
+            	gdth_enable_int(hanum);
 #endif /* !__ia64__ */
+			}
         }
     }
 
@@ -4105,99 +4107,101 @@
         if (gdth_ctr_count >= MAXHA) 
             break;
         if (gdth_search_eisa(eisa_slot)) {      /* controller found */
-            shp = scsi_register(shtp,sizeof(gdth_ext_str));
-            ha = HADATA(shp);
-            if (!gdth_init_eisa(eisa_slot,ha)) {
-                scsi_unregister(shp);
-                continue;
-            }
-            /* controller found and initialized */
-            printk("Configuring GDT-EISA HA at Slot %d IRQ %u\n",
-                   eisa_slot>>12,ha->irq);
+            if( (shp = scsi_register(shtp,sizeof(gdth_ext_str))) != NULL ) {
+            	ha = HADATA(shp);
+            	if (!gdth_init_eisa(eisa_slot,ha)) {
+                	scsi_unregister(shp);
+                	continue;
+            	}
+            	/* controller found and initialized */
+            	printk("Configuring GDT-EISA HA at Slot %d IRQ %u\n",
+                		eisa_slot>>12,ha->irq);
 
 #if LINUX_VERSION_CODE >= 0x010346 
-            if (request_irq(ha->irq,gdth_interrupt,SA_INTERRUPT,"gdth",ha))
+            	if (request_irq(ha->irq,gdth_interrupt,SA_INTERRUPT,"gdth",ha))
 #else
-            if (request_irq(ha->irq,gdth_interrupt,SA_INTERRUPT,"gdth")) 
+            	if (request_irq(ha->irq,gdth_interrupt,SA_INTERRUPT,"gdth")) 
 #endif
-            {
-                printk("GDT-EISA: Unable to allocate IRQ\n");
-                scsi_unregister(shp);
-                continue;
-            }
-            shp->unchecked_isa_dma = 0;
-            shp->irq = ha->irq;
-            shp->dma_channel = 0xff;
-            hanum = gdth_ctr_count;
-            gdth_ctr_tab[gdth_ctr_count++] = shp;
-            gdth_ctr_vtab[gdth_ctr_vcount++] = shp;
-
-            NUMDATA(shp)->hanum = (ushort)hanum;
-            NUMDATA(shp)->busnum= 0;
-            TRACE2(("EISA detect Bus 0: hanum %d\n",
-                    NUMDATA(shp)->hanum));
+            	{
+                	printk("GDT-EISA: Unable to allocate IRQ\n");
+                	scsi_unregister(shp);
+                	continue;
+            	}
+            	shp->unchecked_isa_dma = 0;
+            	shp->irq = ha->irq;
+            	shp->dma_channel = 0xff;
+            	hanum = gdth_ctr_count;
+            	gdth_ctr_tab[gdth_ctr_count++] = shp;
+            	gdth_ctr_vtab[gdth_ctr_vcount++] = shp;
+
+            	NUMDATA(shp)->hanum = (ushort)hanum;
+            	NUMDATA(shp)->busnum= 0;
+            	TRACE2(("EISA detect Bus 0: hanum %d\n",
+                		NUMDATA(shp)->hanum));
 
-            ha->pccb = CMDDATA(shp);
+            	ha->pccb = CMDDATA(shp);
 #if LINUX_VERSION_CODE >= 0x020322
-            ha->pscratch = (void *) __get_free_pages(GFP_ATOMIC | GFP_DMA, 
+            	ha->pscratch = (void *) __get_free_pages(GFP_ATOMIC | GFP_DMA, 
                                                      GDTH_SCRATCH_ORD);
 #else
-            ha->pscratch = scsi_init_malloc(GDTH_SCRATCH, GFP_ATOMIC | GFP_DMA);
+            	ha->pscratch = scsi_init_malloc(GDTH_SCRATCH, GFP_ATOMIC | GFP_DMA);
 #endif
-            ha->scratch_busy = FALSE;
-            ha->req_first = NULL;
-            ha->tid_cnt = MAX_HDRIVES;
-            if (max_ids > 0 && max_ids < ha->tid_cnt)
-                ha->tid_cnt = max_ids;
-            for (i=0; i<GDTH_MAXCMDS; ++i)
-                ha->cmd_tab[i].cmnd = UNUSED_CMND;
-            ha->scan_mode = rescan ? 0x10 : 0;
-
-            if (ha->pscratch == NULL || !gdth_search_drives(hanum)) {
-                printk("GDT-EISA: Error during device scan\n");
-                --gdth_ctr_count;
-                --gdth_ctr_vcount;
-                if (ha->pscratch != NULL)
+            	ha->scratch_busy = FALSE;
+            	ha->req_first = NULL;
+            	ha->tid_cnt = MAX_HDRIVES;
+            	if (max_ids > 0 && max_ids < ha->tid_cnt)
+                	ha->tid_cnt = max_ids;
+            	for (i=0; i<GDTH_MAXCMDS; ++i)
+                	ha->cmd_tab[i].cmnd = UNUSED_CMND;
+            	ha->scan_mode = rescan ? 0x10 : 0;
+
+            	if (ha->pscratch == NULL || !gdth_search_drives(hanum)) {
+                	printk("GDT-EISA: Error during device scan\n");
+                	--gdth_ctr_count;
+                	--gdth_ctr_vcount;
+                	if (ha->pscratch != NULL)
 #if LINUX_VERSION_CODE >= 0x020322
-                    free_pages((unsigned long)ha->pscratch, GDTH_SCRATCH_ORD);
+                    	free_pages((unsigned long)ha->pscratch, GDTH_SCRATCH_ORD);
 #else
-                    scsi_init_free((void *)ha->pscratch, GDTH_SCRATCH);
+                    	scsi_init_free((void *)ha->pscratch, GDTH_SCRATCH);
 #endif
 #if LINUX_VERSION_CODE >= 0x010346 
-                free_irq(ha->irq,ha);
+                	free_irq(ha->irq,ha);
 #else
-                free_irq(ha->irq);
+                	free_irq(ha->irq);
 #endif
-                scsi_unregister(shp);
-                continue;
-            }
-            if (hdr_channel < 0 || hdr_channel > ha->bus_cnt)
-                hdr_channel = ha->bus_cnt;
-            ha->virt_bus = hdr_channel;
+                	scsi_unregister(shp);
+                	continue;
+            	}
+            	if (hdr_channel < 0 || hdr_channel > ha->bus_cnt)
+                	hdr_channel = ha->bus_cnt;
+            	ha->virt_bus = hdr_channel;
 
 #if LINUX_VERSION_CODE >= 0x020000
-            shp->max_id      = ha->tid_cnt;
-            shp->max_lun     = MAXLUN;
-            shp->max_channel = virt_ctr ? 0 : ha->bus_cnt;
-            if (virt_ctr)  
-#endif
-            {
-                virt_ctr = 1;
-                /* register addit. SCSI channels as virtual controllers */
-                for (b = 1; b < ha->bus_cnt + 1; ++b) {
-                    shp = scsi_register(shtp,sizeof(gdth_num_str));
-                    shp->unchecked_isa_dma = 0;
-                    shp->irq = ha->irq;
-                    shp->dma_channel = 0xff;
-                    gdth_ctr_vtab[gdth_ctr_vcount++] = shp;
-                    NUMDATA(shp)->hanum = (ushort)hanum;
-                    NUMDATA(shp)->busnum = b;
-                }
-            }  
-
-            GDTH_INIT_LOCK_HA(ha);
-            gdth_enable_int(hanum);
-        }
+            	shp->max_id      = ha->tid_cnt;
+            	shp->max_lun     = MAXLUN;
+            	shp->max_channel = virt_ctr ? 0 : ha->bus_cnt;
+            	if (virt_ctr)  
+#endif
+            	{
+                	virt_ctr = 1;
+                	/* register addit. SCSI channels as virtual controllers */
+                	for (b = 1; b < ha->bus_cnt + 1; ++b) {
+                    	if( (shp = scsi_register(shtp,sizeof(gdth_num_str))) != NULL ) {
+                    		shp->unchecked_isa_dma = 0;
+                    		shp->irq = ha->irq;
+                    		shp->dma_channel = 0xff;
+                    		gdth_ctr_vtab[gdth_ctr_vcount++] = shp;
+                    		NUMDATA(shp)->hanum = (ushort)hanum;
+                    		NUMDATA(shp)->busnum = b;
+						}
+                	}
+            	}  
+
+            	GDTH_INIT_LOCK_HA(ha);
+            	gdth_enable_int(hanum);
+        	}
+		}
     }
 
     /* scanning for PCI controllers */
@@ -4214,100 +4218,102 @@
         for (ctr = 0; ctr < cnt; ++ctr) {
             if (gdth_ctr_count >= MAXHA)
                 break;
-            shp = scsi_register(shtp,sizeof(gdth_ext_str));
-            ha = HADATA(shp);
-            if (!gdth_init_pci(&pcistr[ctr],ha)) {
-                scsi_unregister(shp);
-                continue;
-            }
-            /* controller found and initialized */
-            printk("Configuring GDT-PCI HA at %d/%d IRQ %u\n",
-                   pcistr[ctr].bus,PCI_SLOT(pcistr[ctr].device_fn),ha->irq);
+            if( (shp = scsi_register(shtp,sizeof(gdth_ext_str))) != NULL ) {
+            	ha = HADATA(shp);
+            	if (!gdth_init_pci(&pcistr[ctr],ha)) {
+                	scsi_unregister(shp);
+                	continue;
+            	}
+            	/* controller found and initialized */
+            	printk("Configuring GDT-PCI HA at %d/%d IRQ %u\n",
+                		pcistr[ctr].bus,PCI_SLOT(pcistr[ctr].device_fn),ha->irq);
 
 #if LINUX_VERSION_CODE >= 0x010346 
-            if (request_irq(ha->irq, gdth_interrupt,
+            	if (request_irq(ha->irq, gdth_interrupt,
                             SA_INTERRUPT|SA_SHIRQ, "gdth", ha))
 #else
-            if (request_irq(ha->irq, gdth_interrupt,
+            	if (request_irq(ha->irq, gdth_interrupt,
                             SA_INTERRUPT|SA_SHIRQ, "gdth")) 
 #endif
-            {
-                printk("GDT-PCI: Unable to allocate IRQ\n");
-                scsi_unregister(shp);
-                continue;
-            }
-            shp->unchecked_isa_dma = 0;
-            shp->irq = ha->irq;
-            shp->dma_channel = 0xff;
-            hanum = gdth_ctr_count;
-            gdth_ctr_tab[gdth_ctr_count++] = shp;
-            gdth_ctr_vtab[gdth_ctr_vcount++] = shp;
+            	{
+                	printk("GDT-PCI: Unable to allocate IRQ\n");
+                	scsi_unregister(shp);
+                	continue;
+            	}
+            	shp->unchecked_isa_dma = 0;
+            	shp->irq = ha->irq;
+            	shp->dma_channel = 0xff;
+            	hanum = gdth_ctr_count;
+            	gdth_ctr_tab[gdth_ctr_count++] = shp;
+            	gdth_ctr_vtab[gdth_ctr_vcount++] = shp;
 
-            NUMDATA(shp)->hanum = (ushort)hanum;
-            NUMDATA(shp)->busnum= 0;
+            	NUMDATA(shp)->hanum = (ushort)hanum;
+            	NUMDATA(shp)->busnum= 0;
 
-            ha->pccb = CMDDATA(shp);
+            	ha->pccb = CMDDATA(shp);
 #if LINUX_VERSION_CODE >= 0x020322
-            ha->pscratch = (void *) __get_free_pages(GFP_ATOMIC | GFP_DMA, 
+            	ha->pscratch = (void *) __get_free_pages(GFP_ATOMIC | GFP_DMA, 
                                                      GDTH_SCRATCH_ORD);
 #else
-            ha->pscratch = scsi_init_malloc(GDTH_SCRATCH, GFP_ATOMIC | GFP_DMA);
+            	ha->pscratch = scsi_init_malloc(GDTH_SCRATCH, GFP_ATOMIC | GFP_DMA);
 #endif
-            ha->scratch_busy = FALSE;
-            ha->req_first = NULL;
-            ha->tid_cnt = pcistr[ctr].device_id >= 0x200 ? MAXID : MAX_HDRIVES;
-            if (max_ids > 0 && max_ids < ha->tid_cnt)
-                ha->tid_cnt = max_ids;
-            for (i=0; i<GDTH_MAXCMDS; ++i)
-                ha->cmd_tab[i].cmnd = UNUSED_CMND;
-            ha->scan_mode = rescan ? 0x10 : 0;
-
-            if (ha->pscratch == NULL || !gdth_search_drives(hanum)) {
-                printk("GDT-PCI: Error during device scan\n");
-                --gdth_ctr_count;
-                --gdth_ctr_vcount;
-                if (ha->pscratch != NULL)
+            	ha->scratch_busy = FALSE;
+            	ha->req_first = NULL;
+            	ha->tid_cnt = pcistr[ctr].device_id >= 0x200 ? MAXID : MAX_HDRIVES;
+            	if (max_ids > 0 && max_ids < ha->tid_cnt)
+                	ha->tid_cnt = max_ids;
+            	for (i=0; i<GDTH_MAXCMDS; ++i)
+                	ha->cmd_tab[i].cmnd = UNUSED_CMND;
+            	ha->scan_mode = rescan ? 0x10 : 0;
+
+            	if (ha->pscratch == NULL || !gdth_search_drives(hanum)) {
+                	printk("GDT-PCI: Error during device scan\n");
+                	--gdth_ctr_count;
+                	--gdth_ctr_vcount;
+                	if (ha->pscratch != NULL)
 #if LINUX_VERSION_CODE >= 0x020322
-                    free_pages((unsigned long)ha->pscratch, GDTH_SCRATCH_ORD);
+                    	free_pages((unsigned long)ha->pscratch, GDTH_SCRATCH_ORD);
 #else
-                    scsi_init_free((void *)ha->pscratch, GDTH_SCRATCH);
+                    	scsi_init_free((void *)ha->pscratch, GDTH_SCRATCH);
 #endif
 #if LINUX_VERSION_CODE >= 0x010346 
-                free_irq(ha->irq,ha);
+                	free_irq(ha->irq,ha);
 #else
-                free_irq(ha->irq);
+                	free_irq(ha->irq);
 #endif
-                scsi_unregister(shp);
-                continue;
-            }
-            if (hdr_channel < 0 || hdr_channel > ha->bus_cnt)
-                hdr_channel = ha->bus_cnt;
-            ha->virt_bus = hdr_channel;
+                	scsi_unregister(shp);
+                	continue;
+            	}
+            	if (hdr_channel < 0 || hdr_channel > ha->bus_cnt)
+                	hdr_channel = ha->bus_cnt;
+            	ha->virt_bus = hdr_channel;
 
 #if LINUX_VERSION_CODE >= 0x020000
-            shp->max_id      = ha->tid_cnt;
-            shp->max_lun     = MAXLUN;
-            shp->max_channel = virt_ctr ? 0 : ha->bus_cnt;
-            if (virt_ctr)  
-#endif
-            {
-                virt_ctr = 1;
-                /* register addit. SCSI channels as virtual controllers */
-                for (b = 1; b < ha->bus_cnt + 1; ++b) {
-                    shp = scsi_register(shtp,sizeof(gdth_num_str));
-                    shp->unchecked_isa_dma = 0;
-                    shp->irq = ha->irq;
-                    shp->dma_channel = 0xff;
-                    gdth_ctr_vtab[gdth_ctr_vcount++] = shp;
-                    NUMDATA(shp)->hanum = (ushort)hanum;
-                    NUMDATA(shp)->busnum = b;
-                }
-            }  
-
-            GDTH_INIT_LOCK_HA(ha);
-            gdth_enable_int(hanum);
-        }
-    }
+            	shp->max_id      = ha->tid_cnt;
+            	shp->max_lun     = MAXLUN;
+            	shp->max_channel = virt_ctr ? 0 : ha->bus_cnt;
+            	if (virt_ctr)  
+#endif
+            	{
+                	virt_ctr = 1;
+                	/* register addit. SCSI channels as virtual controllers */
+                	for (b = 1; b < ha->bus_cnt + 1; ++b) {
+                    	if( (shp = scsi_register(shtp,sizeof(gdth_num_str))) != NULL ) {
+                    		shp->unchecked_isa_dma = 0;
+                    		shp->irq = ha->irq;
+                    		shp->dma_channel = 0xff;
+                    		gdth_ctr_vtab[gdth_ctr_vcount++] = shp;
+                    		NUMDATA(shp)->hanum = (ushort)hanum;
+                    		NUMDATA(shp)->busnum = b;
+						}
+                	}
+            	}  
+
+            	GDTH_INIT_LOCK_HA(ha);
+            	gdth_enable_int(hanum);
+        	}
+    	}
+	}
 
     TRACE2(("gdth_detect() %d controller detected\n",gdth_ctr_count));
     if (gdth_ctr_count > 0) {
diff -uNr linux-2.5.3-dj4.orig/drivers/scsi/pci2220i.c linux/drivers/scsi/pci2220i.c
--- linux-2.5.3-dj4.orig/drivers/scsi/pci2220i.c	Sun Feb 10 19:09:04 2002
+++ linux/drivers/scsi/pci2220i.c	Sun Feb 10 22:00:10 2002
@@ -2643,6 +2643,9 @@
 	while ( (pcidev = pci_find_device (VENDOR_PSI, DEVICE_BIGD_1, pcidev)) != NULL )
 		{
 		pshost = scsi_register (tpnt, sizeof(ADAPTER2220I));
+		if( pshost == NULL )
+			continue;
+
 		padapter = HOSTDATA(pshost);
 
 		if ( GetRegs (pshost, TRUE, pcidev) )
diff -uNr linux-2.5.3-dj4.orig/drivers/scsi/pcmcia/nsp_cs.c linux/drivers/scsi/pcmcia/nsp_cs.c
--- linux-2.5.3-dj4.orig/drivers/scsi/pcmcia/nsp_cs.c	Wed Dec 26 01:04:40 2001
+++ linux/drivers/scsi/pcmcia/nsp_cs.c	Sun Feb 10 22:07:18 2002
@@ -1185,8 +1185,16 @@
 
 	DEBUG(0, __FUNCTION__ " this_id=%d\n", sht->this_id);
 
-	request_region(data->BaseAddress, data->NumAddress, "nsp_cs");
+	if( !( request_region(data->BaseAddress, data->NumAddress, "nsp_cs") ) )
+		return 0;
+	
 	host		  = scsi_register(sht, 0);
+	
+	if( !host ) {
+		release_region( data->BaseAddress, data->NumAddress );
+		return 0;
+	}
+	
 	host->io_port	  = data->BaseAddress;
 	host->unique_id	  = data->BaseAddress;
 	host->n_io_port	  = data->NumAddress;

--------------060004090300050803020800--

