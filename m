Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317625AbSFRVKo>; Tue, 18 Jun 2002 17:10:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317623AbSFRVKn>; Tue, 18 Jun 2002 17:10:43 -0400
Received: from pixpat.austin.ibm.com ([192.35.232.241]:64118 "EHLO ibm.com")
	by vger.kernel.org with ESMTP id <S317621AbSFRVKY>;
	Tue, 18 Jun 2002 17:10:24 -0400
Date: Tue, 18 Jun 2002 16:56:39 -0500
From: sullivan <sullivan@austin.ibm.com>
To: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Cc: James.Bottomley@steeleye.com
Subject: Re: [PATCH][RFC] Driverfs support for SCSI devices (updated)
Message-ID: <20020618165639.A1243@austin.ibm.com>
References: <sullivan@austin.ibm.com> <200206172316.g5HNGrY05827@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="2oS5YaxWCcQjTEyO"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200206172316.g5HNGrY05827@localhost.localdomain>; from James.Bottomley@steeleye.com on Mon, Jun 17, 2002 at 06:16:53PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 17, 2002 at 06:16:53PM -0500, James Bottomley wrote:
> I get a BUG in device.h:213 trying to insert the st.o module, but other than 
> that, it seems to be running OK.

Thanks James. Attached is an updated patch that fixes the st.o module and incorporates your other suggestions. The updated patch is also available at
http://www-124.ibm.com/devreg/linux-2.5.22-driverfs.patch.gz

--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="linux-2.5.22-driverfs.patch"

diff -Naur linux-2.5.22.orig/drivers/cdrom/cdrom.c linux-2.5.22-driverfs/drivers/cdrom/cdrom.c
--- linux-2.5.22.orig/drivers/cdrom/cdrom.c	Sun Jun 16 21:31:26 2002
+++ linux-2.5.22-driverfs/drivers/cdrom/cdrom.c	Mon Jun 17 21:14:07 2002
@@ -431,6 +431,11 @@
 		topCdromPtr = cdi->next;
 	cdi->ops->n_minors--;
 	devfs_unregister (cdi->de);
+	if (atomic_read (&cdi->cdrom_driverfs_dev.refcount)) {
+		device_remove_file (&cdi->cdrom_driverfs_dev, "name");
+		device_remove_file (&cdi->cdrom_driverfs_dev, "kdev");
+		put_device (&cdi->cdrom_driverfs_dev);
+	}
 	devfs_dealloc_unique_number (&cdrom_numspace, cdi->number);
 	cdinfo(CD_REG_UNREG, "drive \"/dev/%s\" unregistered\n", cdi->name);
 	return 0;
diff -Naur linux-2.5.22.orig/drivers/scsi/hosts.h linux-2.5.22-driverfs/drivers/scsi/hosts.h
--- linux-2.5.22.orig/drivers/scsi/hosts.h	Sun Jun 16 21:31:29 2002
+++ linux-2.5.22-driverfs/drivers/scsi/hosts.h	Mon Jun 17 21:14:07 2002
@@ -418,6 +418,11 @@
      */
     struct pci_dev *pci_dev;
 
+    /* 
+     * Support for driverfs filesystem
+     */
+    struct device host_driverfs_dev;
+
     /*
      * We should ensure that this is aligned, both for better performance
      * and also because some compilers (m68k) don't automatically force
@@ -478,6 +483,7 @@
                                        struct pci_dev *pdev)
 {
 	SHpnt->pci_dev = pdev;
+	SHpnt->host_driverfs_dev.parent=&pdev->dev;
 }
 
 
@@ -516,6 +522,7 @@
     void (*detach)(Scsi_Device *);
     int (*init_command)(Scsi_Cmnd *);     /* Used by new queueing code. 
                                            Selects command for blkdevs */
+    struct device_driver scsi_driverfs_driver;
 };
 
 void  scsi_initialize_queue(Scsi_Device * SDpnt, struct Scsi_Host * SHpnt);
diff -Naur linux-2.5.22.orig/drivers/scsi/scsi.c linux-2.5.22-driverfs/drivers/scsi/scsi.c
--- linux-2.5.22.orig/drivers/scsi/scsi.c	Sun Jun 16 21:31:33 2002
+++ linux-2.5.22-driverfs/drivers/scsi/scsi.c	Tue Jun 18 21:15:19 2002
@@ -1939,6 +1939,11 @@
 				}
 				printk(KERN_INFO "scsi%d : %s\n",		/* And print a little message */
 				       shpnt->host_no, name);
+				strncpy(shpnt->host_driverfs_dev.name,name,
+					DEVICE_NAME_SIZE-1);
+				sprintf(shpnt->host_driverfs_dev.bus_id,
+					"scsi%d",
+					shpnt->host_no);
 			}
 		}
 
@@ -1947,6 +1952,8 @@
 		 */
 		for (shpnt = scsi_hostlist; shpnt; shpnt = shpnt->next) {
 			if (shpnt->hostt == tpnt) {
+				/* first register parent with driverfs */
+				device_register(&shpnt->host_driverfs_dev);
 				scan_scsis(shpnt, 0, 0, 0, 0);
 				if (shpnt->select_queue_depths != NULL) {
 					(shpnt->select_queue_depths) (shpnt, shpnt->host_queue);
@@ -2101,6 +2108,7 @@
 				goto err_out;
 			}
 			devfs_unregister (SDpnt->de);
+			put_device(&SDpnt->sdev_driverfs_dev);
 		}
 	}
 
@@ -2151,6 +2159,7 @@
 		/* Remove the /proc/scsi directory entry */
 		sprintf(name,"%d",shpnt->host_no);
 		remove_proc_entry(name, tpnt->proc_dir);
+		put_device(&shpnt->host_driverfs_dev);
 		if (tpnt->release)
 			(*tpnt->release) (shpnt);
 		else {
@@ -2499,6 +2508,34 @@
 	mempool_free(sgl, sgp->pool);
 }
 
+static int scsi_bus_match(struct device *scsi_driverfs_dev, 
+                          struct device_driver *scsi_driverfs_drv)
+{
+        char *p=0;
+
+        if (!strcmp("sd", scsi_driverfs_drv->name)) {
+                if ((p = strstr(scsi_driverfs_dev->bus_id, ":disc")) || 
+		    (p = strstr(scsi_driverfs_dev->bus_id, ":p"))) { 
+                        return 1;
+                }
+        } else if (!strcmp("sg", scsi_driverfs_drv->name)) {
+                if (strstr(scsi_driverfs_dev->bus_id, ":gen"))
+                        return 1;
+        } else if (!strcmp("sr",scsi_driverfs_drv->name)) {
+                if (strstr(scsi_driverfs_dev->bus_id,":cd"))
+                        return 1;
+        } else if (!strcmp("st",scsi_driverfs_drv->name)) {
+                if (strstr(scsi_driverfs_dev->bus_id,":mt"))
+                        return 1;
+        }
+        return 0;
+}
+
+struct bus_type scsi_driverfs_bus_type = {
+        name: "scsi",
+        match: scsi_bus_match,
+};
+
 static int __init init_scsi(void)
 {
 	struct proc_dir_entry *generic;
@@ -2544,6 +2581,8 @@
         if (scsihosts)
 		printk(KERN_INFO "scsi: host order: %s\n", scsihosts);	
 	scsi_host_no_init (scsihosts);
+
+	bus_register(&scsi_driverfs_bus_type);
 	/*
 	 * This is where the processing takes place for most everything
 	 * when commands are completed.
diff -Naur linux-2.5.22.orig/drivers/scsi/scsi.h linux-2.5.22-driverfs/drivers/scsi/scsi.h
--- linux-2.5.22.orig/drivers/scsi/scsi.h	Sun Jun 16 21:31:27 2002
+++ linux-2.5.22-driverfs/drivers/scsi/scsi.h	Tue Jun 18 18:10:20 2002
@@ -417,6 +417,8 @@
 extern volatile int in_scan_scsis;
 extern const unsigned char scsi_command_size[8];
 
+extern struct bus_type scsi_driverfs_bus_type;
+
 
 /*
  * These are the error handling functions defined in scsi_error.c
@@ -622,6 +624,7 @@
 
 	// Flag to allow revalidate to succeed in sd_open
 	int allow_revalidate;
+	struct device sdev_driverfs_dev;
 };
 
 
diff -Naur linux-2.5.22.orig/drivers/scsi/scsi_scan.c linux-2.5.22-driverfs/drivers/scsi/scsi_scan.c
--- linux-2.5.22.orig/drivers/scsi/scsi_scan.c	Sun Jun 16 21:31:35 2002
+++ linux-2.5.22-driverfs/drivers/scsi/scsi_scan.c	Tue Jun 18 18:21:26 2002
@@ -54,6 +54,7 @@
 		char *scsi_result);
 static int find_lun0_scsi_level(unsigned int channel, unsigned int dev,
 				struct Scsi_Host *shpnt);
+static void scsi_load_identifier(Scsi_Device *SDpnt, Scsi_Request * SRpnt);
 
 struct dev_info {
 	const char *vendor;
@@ -288,6 +289,31 @@
 }
 #endif
 
+/* Driverfs file content handlers */
+static ssize_t scsi_device_type_read(struct device *driverfs_dev, char *page, 
+	size_t count, loff_t off)
+{
+	struct scsi_device *SDpnt = list_entry(driverfs_dev,
+		struct scsi_device, sdev_driverfs_dev);
+
+	if ((SDpnt->type <= MAX_SCSI_DEVICE_CODE) && 
+		(scsi_device_types[(int)SDpnt->type] != NULL))
+		return off ? 0 : 
+			sprintf(page, "%s\n", 
+				scsi_device_types[(int)SDpnt->type]);
+	else
+		return off ? 0 : sprintf(page, "UNKNOWN\n");
+
+	return 0;
+}
+
+static struct driver_file_entry scsi_device_type_file = {
+	name: "type",
+	mode: S_IRUGO,
+	show: scsi_device_type_read,
+};
+/* end content handlers */
+
 static void print_inquiry(unsigned char *data)
 {
 	int i;
@@ -786,6 +812,22 @@
 
 	print_inquiry(scsi_result);
 
+	/* interrogate scsi target to provide device identifier */
+	scsi_load_identifier(SDpnt, SRpnt);
+
+	/* create driverfs files */
+	sprintf(SDpnt->sdev_driverfs_dev.bus_id,"%d:%d:%d:%d",
+		SDpnt->host->host_no, SDpnt->channel, SDpnt->id, SDpnt->lun);
+	
+	SDpnt->sdev_driverfs_dev.parent = &SDpnt->host->host_driverfs_dev;
+	SDpnt->sdev_driverfs_dev.bus = &scsi_driverfs_bus_type;
+
+	device_register(&SDpnt->sdev_driverfs_dev); 
+
+	/* Create driverfs file entries */
+	device_create_file(&SDpnt->sdev_driverfs_dev, 
+			&scsi_device_type_file);
+
         sprintf (devname, "host%d/bus%d/target%d/lun%d",
                  SDpnt->host->host_no, SDpnt->channel, SDpnt->id, SDpnt->lun);
         if (SDpnt->de) printk ("DEBUG: dir: \"%s\" already exists\n", devname);
@@ -1306,3 +1348,374 @@
 	/* haven't found lun0, should send INQUIRY but take easy route */
 	return res;
 }
+
+#define SCSI_UID_DEV_ID  'U'
+#define SCSI_UID_SER_NUM 'S'
+#define SCSI_UID_UNKNOWN 'Z'
+
+unsigned char *scsi_get_evpd_page(Scsi_Device *SDpnt, Scsi_Request * SRpnt)
+{
+	unsigned char *evpd_page = NULL;
+	unsigned char *scsi_cmd = NULL;
+	int lun = SDpnt->lun;
+	int scsi_level = SDpnt->scsi_level;
+
+	evpd_page = kmalloc(255, 
+		(SDpnt->host->unchecked_isa_dma ? GFP_DMA : GFP_ATOMIC));
+	if (!evpd_page)
+		return NULL;
+
+	scsi_cmd = kmalloc(MAX_COMMAND_SIZE, GFP_ATOMIC);
+	if (!scsi_cmd) {
+		kfree(evpd_page);
+		return NULL;
+	}
+
+	/* Use vital product pages to determine serial number */
+	/* Try Supported vital product data pages 0x00 first */
+	scsi_cmd[0] = INQUIRY;
+	if ((lun > 0) && (scsi_level <= SCSI_2))
+		scsi_cmd[1] = ((lun << 5) & 0xe0) | 0x01;
+	else
+		scsi_cmd[1] = 0x01;	/* SCSI_3 and higher, don't touch */
+	scsi_cmd[2] = 0x00;
+	scsi_cmd[3] = 0;
+	scsi_cmd[4] = 255;
+	scsi_cmd[5] = 0;
+	SRpnt->sr_cmd_len = 0;
+	SRpnt->sr_sense_buffer[0] = 0;
+	SRpnt->sr_sense_buffer[2] = 0;
+	SRpnt->sr_data_direction = SCSI_DATA_READ;
+	scsi_wait_req(SRpnt, (void *) scsi_cmd, (void *) evpd_page,
+			255, SCSI_TIMEOUT+4*HZ, 3);
+
+	if (SRpnt->sr_result) {
+		kfree(scsi_cmd);
+		kfree(evpd_page);
+		return NULL;
+	}
+
+	/* check to see if response was truncated */
+	if (evpd_page[3] > 255) {
+		int max_lgth = evpd_page[3] + 4;
+
+		kfree(evpd_page);
+		evpd_page = kmalloc(max_lgth, (SDpnt->host->unchecked_isa_dma ? 
+			GFP_DMA : GFP_ATOMIC));
+		if (!evpd_page) {
+			kfree(scsi_cmd);
+			return NULL;
+		}
+		memset(scsi_cmd, 0, MAX_COMMAND_SIZE);
+		scsi_cmd[0] = INQUIRY;
+		if ((lun > 0) && (scsi_level <= SCSI_2))
+			scsi_cmd[1] = ((lun << 5) & 0xe0) | 0x01;
+		else
+			scsi_cmd[1] = 0x01; /* SCSI_3 and higher, don't touch */
+		scsi_cmd[2] = 0x00;
+		scsi_cmd[3] = 0;
+		scsi_cmd[4] = max_lgth;
+		scsi_cmd[5] = 0;
+		SRpnt->sr_cmd_len = 0;
+		SRpnt->sr_sense_buffer[0] = 0;
+		SRpnt->sr_sense_buffer[2] = 0;
+		SRpnt->sr_data_direction = SCSI_DATA_READ;
+		scsi_wait_req(SRpnt, (void *) scsi_cmd, (void *) evpd_page,
+			max_lgth, SCSI_TIMEOUT+4*HZ, 3);
+		if (SRpnt->sr_result) {
+			kfree(scsi_cmd);
+			kfree(evpd_page);
+			return NULL;
+		}
+	}
+	kfree(scsi_cmd);
+	/* some ill behaved devices return the std inquiry here rather than
+		the evpd data. snoop the data to verify */
+	if (evpd_page[3] > 16) {
+		/* if vend id appears in the evpd page assume evpd is invalid */
+		if (!strncmp(&evpd_page[8], SDpnt->vendor, 8)) {
+			kfree(evpd_page);
+			return NULL;
+		}
+	}
+	return evpd_page;
+}
+
+int scsi_get_deviceid(Scsi_Device *SDpnt,Scsi_Request * SRpnt)
+{
+	unsigned char *id_page = NULL;
+	unsigned char *scsi_cmd = NULL;
+	int scnt, i, j, idtype;
+	char * id = SDpnt->sdev_driverfs_dev.name;
+	int lun = SDpnt->lun;
+	int scsi_level = SDpnt->scsi_level;
+
+	id_page = kmalloc(255, 
+		(SDpnt->host->unchecked_isa_dma ? GFP_DMA : GFP_ATOMIC)); 
+	if (!id_page)
+		return 0;
+
+	scsi_cmd = kmalloc(MAX_COMMAND_SIZE, GFP_ATOMIC);
+	if (!scsi_cmd)
+		goto leave;
+
+	/* Use vital product pages to determine serial number */
+	/* Try Supported vital product data pages 0x00 first */
+	scsi_cmd[0] = INQUIRY;
+	if ((lun > 0) && (scsi_level <= SCSI_2))
+		scsi_cmd[1] = ((lun << 5) & 0xe0) | 0x01;
+	else
+		scsi_cmd[1] = 0x01;	/* SCSI_3 and higher, don't touch */
+	scsi_cmd[2] = 0x83;
+	scsi_cmd[3] = 0;
+	scsi_cmd[4] = 255;
+	scsi_cmd[5] = 0;
+	SRpnt->sr_cmd_len = 0;
+	SRpnt->sr_sense_buffer[0] = 0;
+	SRpnt->sr_sense_buffer[2] = 0;
+	SRpnt->sr_data_direction = SCSI_DATA_READ;
+	scsi_wait_req(SRpnt, (void *) scsi_cmd, (void *) id_page,
+			255, SCSI_TIMEOUT+4*HZ, 3);
+	if (SRpnt->sr_result) {
+		kfree(scsi_cmd);
+		goto leave;
+	}
+
+	/* check to see if response was truncated */
+	if (id_page[3] > 255) {
+		int max_lgth = id_page[3] + 4;
+
+		kfree(id_page);
+		id_page = kmalloc(max_lgth,
+			(SDpnt->host->unchecked_isa_dma ? 
+			GFP_DMA : GFP_ATOMIC)); 
+		if (!id_page) {
+			kfree(scsi_cmd);
+			return 0;
+		}
+		memset(scsi_cmd, 0, MAX_COMMAND_SIZE);
+		scsi_cmd[0] = INQUIRY;
+		if ((lun > 0) && (scsi_level <= SCSI_2))
+			scsi_cmd[1] = ((lun << 5) & 0xe0) | 0x01;
+		else
+			scsi_cmd[1] = 0x01; /* SCSI_3 and higher, don't touch */
+		scsi_cmd[2] = 0x83;
+		scsi_cmd[3] = 0;
+		scsi_cmd[4] = max_lgth;
+		scsi_cmd[5] = 0;
+		SRpnt->sr_cmd_len = 0;
+		SRpnt->sr_sense_buffer[0] = 0;
+		SRpnt->sr_sense_buffer[2] = 0;
+		SRpnt->sr_data_direction = SCSI_DATA_READ;
+		scsi_wait_req(SRpnt, (void *) scsi_cmd, (void *) id_page,
+				max_lgth, SCSI_TIMEOUT+4*HZ, 3);
+		if (SRpnt->sr_result) {
+			kfree(scsi_cmd);
+			goto leave;
+		}
+	}
+	kfree(scsi_cmd);
+
+	idtype = 3;
+	while (idtype > 0) {
+		for(scnt = 4; scnt <= id_page[3] + 3; 
+		    scnt += id_page[scnt + 3] + 4) {
+			if ((id_page[scnt + 1] & 0x0f) != idtype) {
+				continue;
+			}
+			if ((id_page[scnt] & 0x0f) == 2) {  
+				for(i = scnt + 4, j = 1;
+				    i < scnt + 4 + id_page[scnt + 3]; 
+				    i++) {
+					if (id_page[i] > 0x20) {
+						if (j == DEVICE_NAME_SIZE) {
+							memset(id, 0, 
+							    DEVICE_NAME_SIZE);
+							break;
+						}
+						id[j++] = id_page[i];
+					}
+				}
+			} else if ((id_page[scnt] & 0x0f) == 1) {
+				static const char hex_str[]="0123456789abcdef";
+				for(i = scnt + 4, j = 1;
+				    i < scnt + 4 + id_page[scnt + 3]; 
+				    i++) {
+					if ((j + 1) == DEVICE_NAME_SIZE) {
+						memset(id, 0, DEVICE_NAME_SIZE);
+						break;
+					}
+					id[j++] = hex_str[(id_page[i] & 0xf0) >>
+								4];
+					id[j++] = hex_str[id_page[i] & 0x0f];
+				}
+			}
+			if (id[1] != 0) goto leave;
+		}
+		idtype--;
+	}
+ leave:
+	kfree(id_page);
+	if (id[1] != 0) {
+		id[0] = SCSI_UID_DEV_ID;
+		return 1;
+	}
+	return 0;
+}
+
+int scsi_get_serialnumber(Scsi_Device *SDpnt, Scsi_Request * SRpnt)
+{
+	unsigned char *serialnumber_page = NULL;
+	unsigned char *scsi_cmd = NULL;
+	int lun = SDpnt->lun;
+	int scsi_level = SDpnt->scsi_level;
+	int i, j;
+
+	serialnumber_page = kmalloc(255, (SDpnt->host->unchecked_isa_dma ? 
+			GFP_DMA : GFP_ATOMIC));
+	if (!serialnumber_page)
+		return 0;
+
+	scsi_cmd = kmalloc(MAX_COMMAND_SIZE, GFP_ATOMIC);
+	if (!scsi_cmd)
+		goto leave;
+
+	/* Use vital product pages to determine serial number */
+	/* Try Supported vital product data pages 0x00 first */
+	scsi_cmd[0] = INQUIRY;
+	if ((lun > 0) && (scsi_level <= SCSI_2))
+		scsi_cmd[1] = ((lun << 5) & 0xe0) | 0x01;
+	else	
+		scsi_cmd[1] = 0x01;	/* SCSI_3 and higher, don't touch */
+	scsi_cmd[2] = 0x80;
+	scsi_cmd[3] = 0;
+	scsi_cmd[4] = 255;
+	scsi_cmd[5] = 0;
+	SRpnt->sr_cmd_len = 0;
+	SRpnt->sr_sense_buffer[0] = 0;
+	SRpnt->sr_sense_buffer[2] = 0;
+	SRpnt->sr_data_direction = SCSI_DATA_READ;
+	scsi_wait_req(SRpnt, (void *) scsi_cmd, (void *) serialnumber_page,
+			255, SCSI_TIMEOUT+4*HZ, 3);
+
+	if (SRpnt->sr_result) {
+		kfree(scsi_cmd);
+		goto leave;
+	}
+	/* check to see if response was truncated */
+	if (serialnumber_page[3] > 255) {
+		int max_lgth = serialnumber_page[3] + 4;
+
+		kfree(serialnumber_page);
+		serialnumber_page = kmalloc(max_lgth, 
+			(SDpnt->host->unchecked_isa_dma ? 
+			GFP_DMA : GFP_ATOMIC));
+		if (!serialnumber_page) {
+			kfree(scsi_cmd);
+			return 0;
+		}
+		memset(scsi_cmd, 0, MAX_COMMAND_SIZE);
+		scsi_cmd[0] = INQUIRY;
+		if ((lun > 0) && (scsi_level <= SCSI_2))
+			scsi_cmd[1] = ((lun << 5) & 0xe0) | 0x01;
+		else
+			scsi_cmd[1] = 0x01; /* SCSI_3 and higher, don't touch */
+		scsi_cmd[2] = 0x80;
+		scsi_cmd[3] = 0;
+		scsi_cmd[4] = max_lgth;
+		scsi_cmd[5] = 0;
+		SRpnt->sr_cmd_len = 0;
+		SRpnt->sr_sense_buffer[0] = 0;
+		SRpnt->sr_sense_buffer[2] = 0;
+		SRpnt->sr_data_direction = SCSI_DATA_READ;
+		scsi_wait_req(SRpnt, (void *) scsi_cmd, 
+				(void *) serialnumber_page,
+				max_lgth, SCSI_TIMEOUT+4*HZ, 3);
+		if (SRpnt->sr_result) {
+			kfree(scsi_cmd);
+			goto leave;
+		}
+	}
+	kfree(scsi_cmd);
+
+	SDpnt->sdev_driverfs_dev.name[0] = SCSI_UID_SER_NUM;
+	for(i = 0, j = 1; i < serialnumber_page[3]; i++) {
+		if (serialnumber_page[4 + i] > 0x20)
+			SDpnt->sdev_driverfs_dev.name[j++] = 
+				serialnumber_page[4 + i];
+	}
+	for(i = 0, j = strlen(SDpnt->sdev_driverfs_dev.name); i < 8; i++) {
+		if (SDpnt->vendor[i] > 0x20) {
+			SDpnt->sdev_driverfs_dev.name[j++] = SDpnt->vendor[i];
+		}
+	}
+	kfree(serialnumber_page);
+	return 1;
+ leave:
+	memset(SDpnt->sdev_driverfs_dev.name, 0, DEVICE_NAME_SIZE);
+	kfree(serialnumber_page);
+	return 0;
+}
+
+int scsi_get_default_name(Scsi_Device *SDpnt)
+{
+	int i, j;
+
+	SDpnt->sdev_driverfs_dev.name[0] = SCSI_UID_UNKNOWN;
+	for(i = 0, j = 1; i < 8; i++) {
+		if (SDpnt->vendor[i] > 0x20) {
+			SDpnt->sdev_driverfs_dev.name[j++] = 
+				SDpnt->vendor[i];
+		}
+	}
+	for(i = 0, j = strlen(SDpnt->sdev_driverfs_dev.name); 
+	    i < 16; i++) {
+		if (SDpnt->model[i] > 0x20) {
+			SDpnt->sdev_driverfs_dev.name[j++] = 
+				SDpnt->model[i];
+		}
+	}
+	for(i = 0, j = strlen(SDpnt->sdev_driverfs_dev.name); i < 4; i++) {
+		if (SDpnt->rev[i] > 0x20) {
+			SDpnt->sdev_driverfs_dev.name[j++] = SDpnt->rev[i];
+		}
+	}	
+	return 1;
+}
+
+
+static void scsi_load_identifier(Scsi_Device *SDpnt, Scsi_Request * SRpnt)
+{
+	unsigned char *evpd_page = NULL;
+	int cnt;
+
+	memset(SDpnt->sdev_driverfs_dev.name, 0, DEVICE_NAME_SIZE);
+	evpd_page = scsi_get_evpd_page(SDpnt, SRpnt);
+	if (!evpd_page) {
+		/* try to obtain serial number anyway */
+		if (!scsi_get_serialnumber(SDpnt, SRpnt))
+			goto leave;
+		goto leave;
+	}
+
+	for(cnt = 4; cnt <= evpd_page[3] + 3; cnt++) {
+		if (evpd_page[cnt] == 0x83) {
+			if (scsi_get_deviceid(SDpnt, SRpnt))
+				goto leave;
+		}
+	}
+
+	for(cnt = 4; cnt <= evpd_page[3] + 3; cnt++) {
+		if (evpd_page[cnt] == 0x80) {
+			if (scsi_get_serialnumber(SDpnt, SRpnt))
+				goto leave;
+		}
+	}
+
+leave:
+	if (SDpnt->sdev_driverfs_dev.name[0] == 0)
+		scsi_get_default_name(SDpnt);
+
+	if (evpd_page) kfree(evpd_page);
+	return;
+}
diff -Naur linux-2.5.22.orig/drivers/scsi/scsi_syms.c linux-2.5.22-driverfs/drivers/scsi/scsi_syms.c
--- linux-2.5.22.orig/drivers/scsi/scsi_syms.c	Sun Jun 16 21:31:32 2002
+++ linux-2.5.22-driverfs/drivers/scsi/scsi_syms.c	Tue Jun 18 21:13:34 2002
@@ -101,3 +101,8 @@
 extern int scsi_delete_timer(Scsi_Cmnd *);
 EXPORT_SYMBOL(scsi_add_timer);
 EXPORT_SYMBOL(scsi_delete_timer);
+
+/*
+ * driverfs support for determining driver types
+ */
+EXPORT_SYMBOL(scsi_driverfs_bus_type);
diff -Naur linux-2.5.22.orig/drivers/scsi/sd.c linux-2.5.22-driverfs/drivers/scsi/sd.c
--- linux-2.5.22.orig/drivers/scsi/sd.c	Sun Jun 16 21:31:27 2002
+++ linux-2.5.22-driverfs/drivers/scsi/sd.c	Tue Jun 18 22:45:19 2002
@@ -128,6 +128,7 @@
 
 static Scsi_Disk * sd_get_sdisk(int index);
 
+extern void driverfs_remove_partitions(struct gendisk *hd, int minor);
 
 #if defined(CONFIG_PPC32)
 /**
@@ -1276,12 +1277,15 @@
 
 		init_mem_lth(sd_gendisks[k].de_arr, N);
 		init_mem_lth(sd_gendisks[k].flags, N);
+		init_mem_lth(sd_gendisks[k].driverfs_dev_arr, N);
 
-		if (!sd_gendisks[k].de_arr || !sd_gendisks[k].flags)
+		if (!sd_gendisks[k].de_arr || !sd_gendisks[k].flags ||
+				!sd_gendisks[k].driverfs_dev_arr)
 			goto cleanup_gendisks;
 
 		zero_mem_lth(sd_gendisks[k].de_arr, N);
 		zero_mem_lth(sd_gendisks[k].flags, N);
+		zero_mem_lth(sd_gendisks[k].driverfs_dev_arr, N);
 
 		sd_gendisks[k].major = SD_MAJOR(k);
 		sd_gendisks[k].major_name = "sd";
@@ -1290,7 +1294,6 @@
 		sd_gendisks[k].sizes = sd_sizes + k * (N << 4);
 		sd_gendisks[k].nr_real = 0;
 	}
-
 	return 0;
 
 #undef init_mem_lth
@@ -1301,6 +1304,7 @@
 	for (k = 0; k < N_USED_SD_MAJORS; k++) {
 		vfree(sd_gendisks[k].de_arr);
 		vfree(sd_gendisks[k].flags);
+		vfree(sd_gendisks[k].driverfs_dev_arr);
 	}
 cleanup_mem:
 	vfree(sd_gendisks);
@@ -1435,6 +1439,8 @@
 	SD_GENDISK(dsk_nr).nr_real++;
         devnum = dsk_nr % SCSI_DISKS_PER_MAJOR;
         SD_GENDISK(dsk_nr).de_arr[devnum] = sdp->de;
+        SD_GENDISK(dsk_nr).driverfs_dev_arr[devnum] = 
+		&sdp->sdev_driverfs_dev;
         if (sdp->removable)
 		SD_GENDISK(dsk_nr).flags[devnum] |= GENHD_FL_REMOVABLE;
 	sd_dskname(dsk_nr, diskname);
@@ -1534,6 +1540,8 @@
 	max_p = 1 << sd_gendisk.minor_shift;
 	start = dsk_nr << sd_gendisk.minor_shift;
 	dev = MKDEV_SD_PARTITION(start);
+	driverfs_remove_partitions(&SD_GENDISK (dsk_nr), 
+					SD_MINOR_NUMBER (start));
 	wipe_partitions(dev);
 	for (j = max_p - 1; j >= 0; j--)
 		sd_sizes[start + j] = 0;
@@ -1555,9 +1563,16 @@
  **/
 static int __init init_sd(void)
 {
+	int rc;
 	SCSI_LOG_HLQUEUE(3, printk("init_sd: sd driver entry point\n"));
 	sd_template.module = THIS_MODULE;
-	return scsi_register_device(&sd_template);
+	rc = scsi_register_device(&sd_template);
+	if (!rc) {
+		sd_template.scsi_driverfs_driver.name = (char *)sd_template.tag;
+		sd_template.scsi_driverfs_driver.bus = &scsi_driverfs_bus_type;
+		driver_register(&sd_template.scsi_driverfs_driver);
+	}
+	return rc;
 }
 
 /**
@@ -1590,6 +1605,7 @@
 	sd_template.dev_max = 0;
 	if (sd_gendisks != &sd_gendisk)
 		vfree(sd_gendisks);
+	remove_driver(&sd_template.scsi_driverfs_driver);
 }
 
 static Scsi_Disk * sd_get_sdisk(int index)
diff -Naur linux-2.5.22.orig/drivers/scsi/sg.c linux-2.5.22-driverfs/drivers/scsi/sg.c
--- linux-2.5.22.orig/drivers/scsi/sg.c	Sun Jun 16 21:31:31 2002
+++ linux-2.5.22-driverfs/drivers/scsi/sg.c	Tue Jun 18 22:43:06 2002
@@ -194,6 +194,7 @@
     volatile char detached;  /* 0->attached, 1->detached pending removal */
     volatile char exclude;   /* opened for exclusive access */
     char sgdebug;       /* 0->off, 1->sense, 9->dump dev, 10-> all devs */
+    struct device sg_driverfs_dev;
 } Sg_device; /* 36 bytes long on i386 */
 
 
@@ -1370,6 +1371,29 @@
 __setup("sg_def_reserved_size=", sg_def_reserved_size_setup);
 #endif
 
+/* Driverfs file support */
+static ssize_t sg_device_kdev_read(struct device *driverfs_dev, char *page, 
+		size_t count, loff_t off)
+{
+	Sg_device * sdp=list_entry(driverfs_dev, Sg_device, sg_driverfs_dev);
+	return off ? 0 : sprintf(page, "%x\n",sdp->i_rdev.value);
+}
+static struct driver_file_entry sg_device_kdev_file = {
+	name: "kdev",
+	mode: S_IRUGO,
+	show: sg_device_kdev_read,
+};
+
+static ssize_t sg_device_type_read(struct device *driverfs_dev, char *page, 
+		size_t count, loff_t off) 
+{
+	return off ? 0 : sprintf (page, "CHR\n");
+}
+static struct driver_file_entry sg_device_type_file = {
+	name: "type",
+	mode: S_IRUGO,
+	show: sg_device_type_read,
+};
 
 static int sg_attach(Scsi_Device * scsidp)
 {
@@ -1428,6 +1452,18 @@
     sdp->detached = 0;
     sdp->sg_tablesize = scsidp->host ? scsidp->host->sg_tablesize : 0;
     sdp->i_rdev = mk_kdev(SCSI_GENERIC_MAJOR, k);
+
+    memset(&sdp->sg_driverfs_dev, 0, sizeof(struct device));
+    sprintf(sdp->sg_driverfs_dev.bus_id, "%s:gen",
+	    scsidp->sdev_driverfs_dev.bus_id);
+    sprintf(sdp->sg_driverfs_dev.name, "%sgeneric", 
+	    scsidp->sdev_driverfs_dev.name);
+    sdp->sg_driverfs_dev.parent = &scsidp->sdev_driverfs_dev;
+    sdp->sg_driverfs_dev.bus = &scsi_driverfs_bus_type;
+    device_register(&sdp->sg_driverfs_dev);
+    device_create_file(&sdp->sg_driverfs_dev, &sg_device_type_file);
+    device_create_file(&sdp->sg_driverfs_dev, &sg_device_kdev_file);
+
     sdp->de = devfs_register (scsidp->de, "generic", DEVFS_FL_DEFAULT,
                              SCSI_GENERIC_MAJOR, k,
                              S_IFCHR | S_IRUSR | S_IWUSR | S_IRGRP,
@@ -1496,6 +1532,9 @@
             }
 	    SCSI_LOG_TIMEOUT(3, printk("sg_detach: dev=%d, dirty\n", k));
 	    devfs_unregister (sdp->de);
+	    device_remove_file(&sdp->sg_driverfs_dev,sg_device_type_file.name);
+	    device_remove_file(&sdp->sg_driverfs_dev,sg_device_kdev_file.name);
+	    put_device(&sdp->sg_driverfs_dev);
 	    sdp->de = NULL;
 	    if (NULL == sdp->headfp) {
 		kfree((char *)sdp);
@@ -1505,6 +1544,7 @@
         else { /* nothing active, simple case */
             SCSI_LOG_TIMEOUT(3, printk("sg_detach: dev=%d\n", k));
 	    devfs_unregister (sdp->de);
+	    put_device(&sdp->sg_driverfs_dev);
 	    kfree((char *)sdp);
 	    sg_dev_arr[k] = NULL;
         }
@@ -1529,9 +1569,16 @@
 MODULE_PARM_DESC(def_reserved_size, "size of buffer reserved for each fd");
 
 static int __init init_sg(void) {
+    int rc;
     if (def_reserved_size >= 0)
 	sg_big_buff = def_reserved_size;
-    return scsi_register_device(&sg_template);
+    rc = scsi_register_device(&sg_template);
+    if (!rc) {
+	sg_template.scsi_driverfs_driver.name = (char *)sg_template.tag;
+	sg_template.scsi_driverfs_driver.bus = &scsi_driverfs_bus_type;
+	driver_register(&sg_template.scsi_driverfs_driver);
+    }
+    return rc; 
 }
 
 static void __exit exit_sg( void)
@@ -1546,6 +1593,7 @@
         sg_dev_arr = NULL;
     }
     sg_template.dev_max = 0;
+    remove_driver(&sg_template.scsi_driverfs_driver);
 }
 
 
diff -Naur linux-2.5.22.orig/drivers/scsi/sr.c linux-2.5.22-driverfs/drivers/scsi/sr.c
--- linux-2.5.22.orig/drivers/scsi/sr.c	Sun Jun 16 21:31:27 2002
+++ linux-2.5.22-driverfs/drivers/scsi/sr.c	Tue Jun 18 22:44:21 2002
@@ -730,6 +730,32 @@
 	return 1;
 }
 
+/* Driverfs file support */
+static ssize_t sr_device_kdev_read(struct device *driverfs_dev, 
+				   char *page, size_t count, loff_t off)
+{
+	kdev_t kdev; 
+	kdev.value=(int)driverfs_dev->driver_data;
+	return off ? 0 : sprintf(page, "%x\n",kdev.value);
+}
+static struct driver_file_entry sr_device_kdev_file = {
+	name: "kdev",
+	mode: S_IRUGO,
+	show: sr_device_kdev_read,
+};
+
+static ssize_t sr_device_type_read(struct device *driverfs_dev, 
+				   char *page, size_t count, loff_t off) 
+{
+	return off ? 0 : sprintf (page, "CHR\n");
+}
+static struct driver_file_entry sr_device_type_file = {
+	name: "type",
+	mode: S_IRUGO,
+	show: sr_device_type_read,
+};
+
+
 void sr_finish()
 {
 	int i;
@@ -775,6 +801,20 @@
 
 		sprintf(name, "sr%d", i);
 		strcpy(SCp->cdi.name, name);
+		sprintf(SCp->cdi.cdrom_driverfs_dev.bus_id, "%s:cd",
+			SCp->device->sdev_driverfs_dev.bus_id);
+		sprintf(SCp->cdi.cdrom_driverfs_dev.name, "%scdrom",
+			SCp->device->sdev_driverfs_dev.name);
+		SCp->cdi.cdrom_driverfs_dev.parent = 
+			&SCp->device->sdev_driverfs_dev;
+		SCp->cdi.cdrom_driverfs_dev.bus = &scsi_driverfs_bus_type;
+		SCp->cdi.cdrom_driverfs_dev.driver_data = 
+			(void *)__mkdev(MAJOR_NR, i);
+		device_register(&SCp->cdi.cdrom_driverfs_dev);
+		device_create_file(&SCp->cdi.cdrom_driverfs_dev,
+				&sr_device_type_file);
+		device_create_file(&SCp->cdi.cdrom_driverfs_dev,
+				&sr_device_kdev_file);
                 SCp->cdi.de = devfs_register(SCp->device->de, "cd",
                                     DEVFS_FL_DEFAULT, MAJOR_NR, i,
                                     S_IFBLK | S_IRUGO | S_IWUGO,
@@ -815,7 +855,14 @@
 
 static int __init init_sr(void)
 {
-	return scsi_register_device(&sr_template);
+	int rc;
+	rc = scsi_register_device(&sr_template);
+	if (!rc) {
+		sr_template.scsi_driverfs_driver.name = (char *)sr_template.tag;
+		sr_template.scsi_driverfs_driver.bus = &scsi_driverfs_bus_type;
+		driver_register(&sr_template.scsi_driverfs_driver);
+	}
+	return rc;
 }
 
 static void __exit exit_sr(void)
@@ -832,6 +879,7 @@
 	blk_clear(MAJOR_NR);
 
 	sr_template.dev_max = 0;
+	remove_driver(&sr_template.scsi_driverfs_driver);
 }
 
 module_init(init_sr);
diff -Naur linux-2.5.22.orig/drivers/scsi/st.c linux-2.5.22-driverfs/drivers/scsi/st.c
--- linux-2.5.22.orig/drivers/scsi/st.c	Sun Jun 16 21:31:34 2002
+++ linux-2.5.22-driverfs/drivers/scsi/st.c	Tue Jun 18 18:09:33 2002
@@ -3677,6 +3677,31 @@
 
 #endif
 
+/* Driverfs file support */
+static ssize_t st_device_kdev_read(struct device *driverfs_dev, 
+				   char *page, size_t count, loff_t off)
+{
+	kdev_t kdev; 
+	kdev.value=(int)driverfs_dev->driver_data;
+	return off ? 0 : sprintf(page, "%x\n",kdev.value);
+}
+static struct driver_file_entry st_device_kdev_file = {
+	name: "kdev",
+	mode: S_IRUGO,
+	show: st_device_kdev_read,
+};
+
+static ssize_t st_device_type_read(struct device *driverfs_dev, 
+				   char *page, size_t count, loff_t off) 
+{
+	return off ? 0 : sprintf (page, "CHR\n");
+}
+static struct driver_file_entry st_device_type_file = {
+	name: "type",
+	mode: S_IRUGO,
+	show: st_device_type_read,
+};
+
 
 static struct file_operations st_fops =
 {
@@ -3779,6 +3804,18 @@
 
 	    /*  Rewind entry  */
 	    sprintf (name, "mt%s", formats[mode]);
+	    sprintf(tpnt->driverfs_dev_r[mode].bus_id, "%s:%s", 
+		    SDp->sdev_driverfs_dev.name, name);
+	    sprintf(tpnt->driverfs_dev_r[mode].name, "%s%s", 
+		    SDp->sdev_driverfs_dev.name, name);
+	    tpnt->driverfs_dev_r[mode].parent = &SDp->sdev_driverfs_dev;
+	    tpnt->driverfs_dev_r[mode].bus = &scsi_driverfs_bus_type;
+	    tpnt->driverfs_dev_r[mode].driver_data =
+			(void *)__mkdev(MAJOR_NR, i + (mode << 5));
+	    device_register(&tpnt->driverfs_dev_r[mode]);
+	    device_create_file(&tpnt->driverfs_dev_r[mode], 
+			       &st_device_type_file);
+	    device_create_file(&tpnt->driverfs_dev_r[mode], &st_device_kdev_file);
 	    tpnt->de_r[mode] =
 		devfs_register (SDp->de, name, DEVFS_FL_DEFAULT,
 				MAJOR_NR, i + (mode << 5),
@@ -3786,6 +3823,19 @@
 				&st_fops, NULL);
 	    /*  No-rewind entry  */
 	    sprintf (name, "mt%sn", formats[mode]);
+	    sprintf(tpnt->driverfs_dev_n[mode].bus_id, "%s:%s", 
+		    SDp->sdev_driverfs_dev.name, name);
+	    sprintf(tpnt->driverfs_dev_n[mode].name, "%s%s", 
+		    SDp->sdev_driverfs_dev.name, name);
+	    tpnt->driverfs_dev_n[mode].parent= &SDp->sdev_driverfs_dev;
+	    tpnt->driverfs_dev_n[mode].bus = &scsi_driverfs_bus_type;
+	    tpnt->driverfs_dev_n[mode].driver_data =
+			(void *)__mkdev(MAJOR_NR, i + (mode << 5) + 128);
+	    device_register(&tpnt->driverfs_dev_n[mode]);
+	    device_create_file(&tpnt->driverfs_dev_n[mode], 
+			&st_device_type_file);
+	    device_create_file(&tpnt->driverfs_dev_n[mode], 
+			&st_device_kdev_file);
 	    tpnt->de_n[mode] =
 		devfs_register (SDp->de, name, DEVFS_FL_DEFAULT,
 				MAJOR_NR, i + (mode << 5) + 128,
@@ -3894,8 +3944,18 @@
 			for (mode = 0; mode < ST_NBR_MODES; ++mode) {
 				devfs_unregister (tpnt->de_r[mode]);
 				tpnt->de_r[mode] = NULL;
+				device_remove_file(&tpnt->driverfs_dev_r[mode],
+						   st_device_type_file.name);
+				device_remove_file(&tpnt->driverfs_dev_r[mode],
+						   st_device_kdev_file.name);
+				put_device(&tpnt->driverfs_dev_r[mode]);
 				devfs_unregister (tpnt->de_n[mode]);
 				tpnt->de_n[mode] = NULL;
+				device_remove_file(&tpnt->driverfs_dev_n[mode],
+						   st_device_type_file.name);
+				device_remove_file(&tpnt->driverfs_dev_n[mode],
+						   st_device_kdev_file.name);
+				put_device(&tpnt->driverfs_dev_n[mode]);
 			}
 			kfree(tpnt);
 			scsi_tapes[i] = 0;
@@ -3921,8 +3981,16 @@
 		verstr, st_buffer_size, st_write_threshold,
 		st_max_buffers, st_max_sg_segs);
 
-	if (devfs_register_chrdev(SCSI_TAPE_MAJOR, "st", &st_fops) >= 0)
-		return scsi_register_device(&st_template);
+	if (devfs_register_chrdev(SCSI_TAPE_MAJOR, "st", &st_fops) >= 0) {
+		if (scsi_register_device(&st_template) == 0) {
+			st_template.scsi_driverfs_driver.name = 
+				(char *)st_template.tag;
+			st_template.scsi_driverfs_driver.bus = 
+				&scsi_driverfs_bus_type;
+			driver_register(&st_template.scsi_driverfs_driver);
+			return 0;
+		}
+	}
 
 	printk(KERN_ERR "Unable to get major %d for SCSI tapes\n", MAJOR_NR);
 	return 1;
@@ -3951,6 +4019,7 @@
 		}
 	}
 	st_template.dev_max = 0;
+	remove_driver(&st_template.scsi_driverfs_driver);
 	printk(KERN_INFO "st: Unloaded.\n");
 }
 
diff -Naur linux-2.5.22.orig/drivers/scsi/st.h linux-2.5.22-driverfs/drivers/scsi/st.h
--- linux-2.5.22.orig/drivers/scsi/st.h	Sun Jun 16 21:31:28 2002
+++ linux-2.5.22-driverfs/drivers/scsi/st.h	Mon Jun 17 21:14:07 2002
@@ -94,6 +94,8 @@
 	int current_mode;
 	devfs_handle_t de_r[ST_NBR_MODES];  /*  Rewind entries     */
 	devfs_handle_t de_n[ST_NBR_MODES];  /*  No-rewind entries  */
+	struct device driverfs_dev_r[ST_NBR_MODES];
+	struct device driverfs_dev_n[ST_NBR_MODES];
 
 	/* Status variables */
 	int partition;
diff -Naur linux-2.5.22.orig/fs/partitions/check.c linux-2.5.22-driverfs/fs/partitions/check.c
--- linux-2.5.22.orig/fs/partitions/check.c	Sun Jun 16 21:31:30 2002
+++ linux-2.5.22-driverfs/fs/partitions/check.c	Mon Jun 17 21:14:07 2002
@@ -22,6 +22,7 @@
 #include <linux/init.h>
 #include <linux/raid/md.h>
 #include <linux/buffer_head.h>	/* for invalidate_bdev() */
+#include <linux/kmod.h>
 
 #include "check.h"
 
@@ -221,6 +222,136 @@
 #endif
 }
 
+/* Driverfs file support */
+static ssize_t partition_device_kdev_read(struct device *driverfs_dev, 
+			char *page, size_t count, loff_t off)
+{
+	kdev_t kdev; 
+	kdev.value=(int)driverfs_dev->driver_data;
+	return off ? 0 : sprintf (page, "%x\n",kdev.value);
+}
+static struct driver_file_entry partition_device_kdev_file = {
+	name: "kdev",
+	mode: S_IRUGO,
+	show: partition_device_kdev_read,
+};
+
+static ssize_t partition_device_type_read(struct device *driverfs_dev, 
+			char *page, size_t count, loff_t off) 
+{
+	return off ? 0 : sprintf (page, "BLK\n");
+}
+static struct driver_file_entry partition_device_type_file = {
+	name: "type",
+	mode: S_IRUGO,
+	show: partition_device_type_read,
+};
+
+void driverfs_create_partitions(struct gendisk *hd, int minor)
+{
+	int pos = -1;
+	int devnum = minor >> hd->minor_shift;
+	char dirname[256];
+	struct device *parent = 0;
+	int max_p;
+	int part;
+	devfs_handle_t dir = 0;
+	
+	/* get parent driverfs device structure */
+	if (hd->driverfs_dev_arr)
+		parent = hd->driverfs_dev_arr[devnum];
+	else /* if driverfs not supported by subsystem, skip partitions */
+		return;
+	
+	/* get parent device node directory name */
+	if (hd->de_arr) {
+		dir = hd->de_arr[devnum];
+		if (dir)
+			pos = devfs_generate_path (dir, dirname, 
+						   sizeof dirname);
+	}
+	
+	if (pos < 0) {
+		disk_name(hd, minor, dirname);
+		pos = 0;
+	}
+	
+	max_p = (1 << hd->minor_shift);
+	
+	/* for all partitions setup parents and device node names */
+	for(part=0; part < max_p; part++) {
+		if ((part == 0) || (hd->part[minor + part].nr_sects >= 1)) {
+			struct device * current_driverfs_dev = 
+				&hd->part[minor+part].hd_driverfs_dev;
+			current_driverfs_dev->parent = parent;
+			/* handle disc case */
+			current_driverfs_dev->driver_data =
+					(void *)__mkdev(hd->major, minor+part);
+			if (part == 0) {
+				if (parent)  {
+					sprintf(current_driverfs_dev->name,
+						"%sdisc", parent->name);
+					sprintf(current_driverfs_dev->bus_id,
+						"%s:disc", parent->bus_id);
+				} else {
+					sprintf(current_driverfs_dev->name, 
+						"disc");
+					sprintf(current_driverfs_dev->bus_id,
+						"disc");
+				}
+			} else { /* this is a partition */
+				if (parent) {
+					sprintf(current_driverfs_dev->name,
+						"%spart%d", parent->name, part);
+					sprintf(current_driverfs_dev->bus_id,
+						"%s:p%d", parent->bus_id, part);
+				} else {
+					sprintf(current_driverfs_dev->name, 
+						"part%d", part);
+					sprintf(current_driverfs_dev->bus_id, 
+						"p%d" ,part);
+				}
+			}
+			if (parent) current_driverfs_dev->bus = parent->bus;
+			device_register(current_driverfs_dev);
+			device_create_file(current_driverfs_dev,
+					&partition_device_type_file);
+			device_create_file(current_driverfs_dev,
+					&partition_device_kdev_file);
+		}
+	}
+	return;
+}
+
+void driverfs_remove_partitions(struct gendisk *hd, int minor)
+{
+	int max_p;
+	int part;
+	struct device * current_driverfs_dev;
+	
+	max_p=(1 << hd->minor_shift);
+	
+	/* for all parts setup parent relationships and device node names */
+	for(part=1; part < max_p; part++) {
+		if ((hd->part[minor + part].nr_sects >= 1)) {
+			current_driverfs_dev = 
+				&hd->part[minor + part].hd_driverfs_dev;
+			device_remove_file(current_driverfs_dev,
+					partition_device_type_file.name);
+			device_remove_file(current_driverfs_dev,
+					partition_device_kdev_file.name);
+			put_device(current_driverfs_dev);	
+		}
+	}
+	current_driverfs_dev = &hd->part[minor].hd_driverfs_dev;
+	device_remove_file(current_driverfs_dev, 
+				partition_device_type_file.name);
+	device_remove_file(current_driverfs_dev, 
+				partition_device_kdev_file.name);
+	put_device(current_driverfs_dev);	
+	return;
+}
+
 static void check_partition(struct gendisk *hd, kdev_t dev, int first_part_minor)
 {
 	devfs_handle_t de = NULL;
@@ -281,6 +412,13 @@
 	truncate_inode_pages(bdev->bd_inode->i_mapping, 0);
 	bdput(bdev);
 	i = first_part_minor - 1;
+
+	/* Setup driverfs tree */
+	if (hd->sizes)
+		driverfs_create_partitions(hd, i);
+	else
+		driverfs_remove_partitions(hd, i);
+
 	devfs_register_partitions (hd, i, hd->sizes ? 0 : 1);
 }
 
diff -Naur linux-2.5.22.orig/include/linux/cdrom.h linux-2.5.22-driverfs/include/linux/cdrom.h
--- linux-2.5.22.orig/include/linux/cdrom.h	Sun Jun 16 21:31:23 2002
+++ linux-2.5.22-driverfs/include/linux/cdrom.h	Mon Jun 17 21:14:07 2002
@@ -716,6 +716,7 @@
 
 #ifdef __KERNEL__
 #include <linux/devfs_fs_kernel.h>
+#include <linux/device.h>
 
 struct cdrom_write_settings {
 	unsigned char fpacket;		/* fixed/variable packets */
@@ -730,6 +731,7 @@
 	struct cdrom_device_info *next; /* next device_info for this major */
 	void *handle;		        /* driver-dependent data */
 	devfs_handle_t de;		/* real driver should create this  */
+	struct device cdrom_driverfs_dev; /* driverfs implementation */
 	int number;			/* generic driver updates this  */
 /* specifications */
         kdev_t dev;	                /* device number */
diff -Naur linux-2.5.22.orig/include/linux/genhd.h linux-2.5.22-driverfs/include/linux/genhd.h
--- linux-2.5.22.orig/include/linux/genhd.h	Sun Jun 16 21:31:26 2002
+++ linux-2.5.22-driverfs/include/linux/genhd.h	Mon Jun 17 21:14:07 2002
@@ -12,6 +12,7 @@
 #include <linux/config.h>
 #include <linux/types.h>
 #include <linux/major.h>
+#include <linux/device.h>
 
 enum {
 /* These three have identical behaviour; use the second one if DOS fdisk gets
@@ -62,6 +63,7 @@
 	unsigned long nr_sects;
 	devfs_handle_t de;              /* primary (master) devfs entry  */
 	int number;                     /* stupid old code wastes space  */
+	struct device hd_driverfs_dev;  /* support driverfs hiearchy     */
 };
 
 #define GENHD_FL_REMOVABLE  1
@@ -80,6 +82,7 @@
 	struct block_device_operations *fops;
 
 	devfs_handle_t *de_arr;         /* one per physical disc */
+	struct device **driverfs_dev_arr;/* support driverfs hierarchy */
 	char *flags;                    /* one per physical disc */
 };
 
@@ -241,6 +244,7 @@
 
 extern void devfs_register_partitions (struct gendisk *dev, int minor,
 				       int unregister);
+extern void driverfs_remove_partitions (struct gendisk *hd, int minor);
 
 static inline unsigned int disk_index (kdev_t dev)
 {
diff -Naur linux-2.5.22.orig/kernel/ksyms.c linux-2.5.22-driverfs/kernel/ksyms.c
--- linux-2.5.22.orig/kernel/ksyms.c	Sun Jun 16 21:31:23 2002
+++ linux-2.5.22-driverfs/kernel/ksyms.c	Mon Jun 17 21:14:07 2002
@@ -335,6 +335,7 @@
 EXPORT_SYMBOL(set_device_ro);
 EXPORT_SYMBOL(bmap);
 EXPORT_SYMBOL(devfs_register_partitions);
+EXPORT_SYMBOL(driverfs_remove_partitions);
 EXPORT_SYMBOL(blkdev_open);
 EXPORT_SYMBOL(blkdev_get);
 EXPORT_SYMBOL(blkdev_put);

--2oS5YaxWCcQjTEyO--
