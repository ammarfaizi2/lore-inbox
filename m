Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317003AbSGHQs5>; Mon, 8 Jul 2002 12:48:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317006AbSGHQs5>; Mon, 8 Jul 2002 12:48:57 -0400
Received: from pixpat.austin.ibm.com ([192.35.232.241]:65099 "EHLO ibm.com")
	by vger.kernel.org with ESMTP id <S317003AbSGHQsY>;
	Mon, 8 Jul 2002 12:48:24 -0400
Date: Mon, 8 Jul 2002 12:31:44 -0500
From: sullivan <sullivan@austin.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: linux-scsi@vger.kernel.org, James.Bottomley@steeleye.com, mochel@osdl.org,
       dalecki@evision-ventures.com
Subject: [PATCH] driverfs scsi fixes for 2.5.25
Message-ID: <20020708123144.A1136@austin.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="+nBD6E3TurpgldQp"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--+nBD6E3TurpgldQp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Attached are some small modifications to the scsi driverfs support:
a. Fix to correctly use bus_id in creation of scsi tape directory entries
b. Invoke driverfs_remove_partitions() directly from wipe_partitions() to separate partition and scsi disk driverfs changes.
c. Modify unique id creation in scsi_scan.c to help eliminate namespace overlap.

 

--+nBD6E3TurpgldQp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="linux-2.5.25-driverfs.patch"

diff -Naur linux-2.5.25.orig/drivers/scsi/scsi_scan.c linux-2.5.25/drivers/scsi/scsi_scan.c
--- linux-2.5.25.orig/drivers/scsi/scsi_scan.c	Fri Jul  5 18:42:33 2002
+++ linux-2.5.25/drivers/scsi/scsi_scan.c	Mon Jul  8 10:50:11 2002
@@ -1349,7 +1349,6 @@
 	return res;
 }
 
-#define SCSI_UID_DEV_ID  'U'
 #define SCSI_UID_SER_NUM 'S'
 #define SCSI_UID_UNKNOWN 'Z'
 
@@ -1359,15 +1358,17 @@
 	unsigned char *scsi_cmd = NULL;
 	int lun = SDpnt->lun;
 	int scsi_level = SDpnt->scsi_level;
+	int max_lgth = 255;
 
-	evpd_page = kmalloc(255, 
-		(SDpnt->host->unchecked_isa_dma ? GFP_DMA : GFP_ATOMIC));
-	if (!evpd_page)
+	scsi_cmd = kmalloc(MAX_COMMAND_SIZE, GFP_ATOMIC);
+	if (!scsi_cmd)
 		return NULL;
 
-	scsi_cmd = kmalloc(MAX_COMMAND_SIZE, GFP_ATOMIC);
-	if (!scsi_cmd) {
-		kfree(evpd_page);
+retry:	
+	evpd_page = kmalloc(max_lgth,
+		(SDpnt->host->unchecked_isa_dma ? GFP_DMA : GFP_ATOMIC));
+	if (!evpd_page) {
+		kfree(scsi_cmd);
 		return NULL;
 	}
 
@@ -1380,14 +1381,14 @@
 		scsi_cmd[1] = 0x01;	/* SCSI_3 and higher, don't touch */
 	scsi_cmd[2] = 0x00;
 	scsi_cmd[3] = 0;
-	scsi_cmd[4] = 255;
+	scsi_cmd[4] = max_lgth;
 	scsi_cmd[5] = 0;
 	SRpnt->sr_cmd_len = 0;
 	SRpnt->sr_sense_buffer[0] = 0;
 	SRpnt->sr_sense_buffer[2] = 0;
 	SRpnt->sr_data_direction = SCSI_DATA_READ;
 	scsi_wait_req(SRpnt, (void *) scsi_cmd, (void *) evpd_page,
-			255, SCSI_TIMEOUT+4*HZ, 3);
+			max_lgth, SCSI_TIMEOUT+4*HZ, 3);
 
 	if (SRpnt->sr_result) {
 		kfree(scsi_cmd);
@@ -1396,38 +1397,13 @@
 	}
 
 	/* check to see if response was truncated */
-	if (evpd_page[3] > 255) {
-		int max_lgth = evpd_page[3] + 4;
-
+	if (evpd_page[3] > max_lgth) {
+		max_lgth = evpd_page[3] + 4;
 		kfree(evpd_page);
-		evpd_page = kmalloc(max_lgth, (SDpnt->host->unchecked_isa_dma ? 
-			GFP_DMA : GFP_ATOMIC));
-		if (!evpd_page) {
-			kfree(scsi_cmd);
-			return NULL;
-		}
 		memset(scsi_cmd, 0, MAX_COMMAND_SIZE);
-		scsi_cmd[0] = INQUIRY;
-		if ((lun > 0) && (scsi_level <= SCSI_2))
-			scsi_cmd[1] = ((lun << 5) & 0xe0) | 0x01;
-		else
-			scsi_cmd[1] = 0x01; /* SCSI_3 and higher, don't touch */
-		scsi_cmd[2] = 0x00;
-		scsi_cmd[3] = 0;
-		scsi_cmd[4] = max_lgth;
-		scsi_cmd[5] = 0;
-		SRpnt->sr_cmd_len = 0;
-		SRpnt->sr_sense_buffer[0] = 0;
-		SRpnt->sr_sense_buffer[2] = 0;
-		SRpnt->sr_data_direction = SCSI_DATA_READ;
-		scsi_wait_req(SRpnt, (void *) scsi_cmd, (void *) evpd_page,
-			max_lgth, SCSI_TIMEOUT+4*HZ, 3);
-		if (SRpnt->sr_result) {
-			kfree(scsi_cmd);
-			kfree(evpd_page);
-			return NULL;
-		}
+		goto retry;
 	}
+
 	kfree(scsi_cmd);
 	/* some ill behaved devices return the std inquiry here rather than
 		the evpd data. snoop the data to verify */
@@ -1445,19 +1421,24 @@
 {
 	unsigned char *id_page = NULL;
 	unsigned char *scsi_cmd = NULL;
-	int scnt, i, j, idtype;
-	char * id = SDpnt->sdev_driverfs_dev.name;
+	int scnt, i, j, idtype = 3, idsubtype = 6;
+	char * uid = &SDpnt->sdev_driverfs_dev.name[1];
 	int lun = SDpnt->lun;
 	int scsi_level = SDpnt->scsi_level;
-
-	id_page = kmalloc(255, 
-		(SDpnt->host->unchecked_isa_dma ? GFP_DMA : GFP_ATOMIC)); 
-	if (!id_page)
-		return 0;
+	int max_lgth = 255;
+	static const char hex_str[]="0123456789abcdef";
 
 	scsi_cmd = kmalloc(MAX_COMMAND_SIZE, GFP_ATOMIC);
 	if (!scsi_cmd)
-		goto leave;
+		return 0;
+
+retry:
+	id_page = kmalloc(max_lgth,
+		(SDpnt->host->unchecked_isa_dma ? GFP_DMA : GFP_ATOMIC));
+	if (!id_page) {
+		kfree(scsi_cmd);
+		return 0;
+	}
 
 	/* Use vital product pages to determine serial number */
 	/* Try Supported vital product data pages 0x00 first */
@@ -1468,96 +1449,82 @@
 		scsi_cmd[1] = 0x01;	/* SCSI_3 and higher, don't touch */
 	scsi_cmd[2] = 0x83;
 	scsi_cmd[3] = 0;
-	scsi_cmd[4] = 255;
+	scsi_cmd[4] = max_lgth;
 	scsi_cmd[5] = 0;
 	SRpnt->sr_cmd_len = 0;
 	SRpnt->sr_sense_buffer[0] = 0;
 	SRpnt->sr_sense_buffer[2] = 0;
 	SRpnt->sr_data_direction = SCSI_DATA_READ;
 	scsi_wait_req(SRpnt, (void *) scsi_cmd, (void *) id_page,
-			255, SCSI_TIMEOUT+4*HZ, 3);
+			max_lgth, SCSI_TIMEOUT+4*HZ, 3);
 	if (SRpnt->sr_result) {
 		kfree(scsi_cmd);
 		goto leave;
 	}
 
 	/* check to see if response was truncated */
-	if (id_page[3] > 255) {
-		int max_lgth = id_page[3] + 4;
-
+	if (id_page[3] > max_lgth) {
+		max_lgth = id_page[3] + 4;
 		kfree(id_page);
-		id_page = kmalloc(max_lgth,
-			(SDpnt->host->unchecked_isa_dma ? 
-			GFP_DMA : GFP_ATOMIC)); 
-		if (!id_page) {
-			kfree(scsi_cmd);
-			return 0;
-		}
 		memset(scsi_cmd, 0, MAX_COMMAND_SIZE);
-		scsi_cmd[0] = INQUIRY;
-		if ((lun > 0) && (scsi_level <= SCSI_2))
-			scsi_cmd[1] = ((lun << 5) & 0xe0) | 0x01;
-		else
-			scsi_cmd[1] = 0x01; /* SCSI_3 and higher, don't touch */
-		scsi_cmd[2] = 0x83;
-		scsi_cmd[3] = 0;
-		scsi_cmd[4] = max_lgth;
-		scsi_cmd[5] = 0;
-		SRpnt->sr_cmd_len = 0;
-		SRpnt->sr_sense_buffer[0] = 0;
-		SRpnt->sr_sense_buffer[2] = 0;
-		SRpnt->sr_data_direction = SCSI_DATA_READ;
-		scsi_wait_req(SRpnt, (void *) scsi_cmd, (void *) id_page,
-				max_lgth, SCSI_TIMEOUT+4*HZ, 3);
-		if (SRpnt->sr_result) {
-			kfree(scsi_cmd);
-			goto leave;
-		}
+		goto retry;
 	}
+
 	kfree(scsi_cmd);
 
-	idtype = 3;
-	while (idtype > 0) {
-		for(scnt = 4; scnt <= id_page[3] + 3; 
-		    scnt += id_page[scnt + 3] + 4) {
-			if ((id_page[scnt + 1] & 0x0f) != idtype) {
+	/* start with Identifier type NAA and work downwards */
+	while (idtype >= 0) {
+		/* examine each descriptor returned */
+		for(scnt = 4; scnt <= id_page[3] + 3;
+			scnt += id_page[scnt + 3] + 4) {
+			/* ASSOCIATION bit 4 should indicate logical unit */
+			/* if not the idtype we are currently looking for */
+			/* then try the next descriptor */
+			if ((id_page[scnt + 1] & 0x1f) != idtype)
 				continue;
-			}
-			if ((id_page[scnt] & 0x0f) == 2) {  
-				for(i = scnt + 4, j = 1;
-				    i < scnt + 4 + id_page[scnt + 3]; 
-				    i++) {
-					if (id_page[i] > 0x20) {
-						if (j == DEVICE_NAME_SIZE) {
-							memset(id, 0, 
-							    DEVICE_NAME_SIZE);
-							break;
-						}
-						id[j++] = id_page[i];
-					}
-				}
+			/* for NAA  we want to look for Register Extended */
+			/* type first (subtype = 6) */
+			if ((id_page[scnt + 1] & 0x0f) == 3)
+				if (((id_page[scnt + 4] & 0x70) >> 4) !=
+						idsubtype)
+					continue;
+			/* check if descriptor is type binary or ASCII */
+			if ((id_page[scnt] & 0x0f) == 2) {
+				/* make sure it fits, otherwise skip it */
+				if (id_page[scnt + 3] < DEVICE_NAME_SIZE)
+					strcpy(uid, &id_page[scnt + 4]);
 			} else if ((id_page[scnt] & 0x0f) == 1) {
-				static const char hex_str[]="0123456789abcdef";
-				for(i = scnt + 4, j = 1;
-				    i < scnt + 4 + id_page[scnt + 3]; 
-				    i++) {
-					if ((j + 1) == DEVICE_NAME_SIZE) {
-						memset(id, 0, DEVICE_NAME_SIZE);
-						break;
-					}
-					id[j++] = hex_str[(id_page[i] & 0xf0) >>
-								4];
-					id[j++] = hex_str[id_page[i] & 0x0f];
+				if ((id_page[scnt + 3] << 1) >=
+						DEVICE_NAME_SIZE)
+					break;
+				for(i = scnt + 4, j = 0;
+					i < scnt + 4 + id_page[scnt + 3]; i++) {
+			    		uid[j++] =
+					hex_str[(id_page[i] & 0xf0) >> 4];
+					uid[j++] = hex_str[id_page[i] & 0x0f];
 				}
 			}
-			if (id[1] != 0) goto leave;
+			if (uid[0] != 0) goto leave;
 		}
-		idtype--;
+		if ((idtype == 3) && (idsubtype == 6))
+			idsubtype--;
+		else
+			idtype--;
 	}
  leave:
 	kfree(id_page);
-	if (id[1] != 0) {
-		id[0] = SCSI_UID_DEV_ID;
+	if (uid[0] != 0) {
+		/* if vendor specific id was used add vendor string */
+		if (idtype == 0) {
+			if ((strlen(uid)+8) < DEVICE_NAME_SIZE)
+				strncpy(&uid[strlen(uid)], SDpnt->vendor, 8);
+			else {
+		    		memset(SDpnt->sdev_driverfs_dev.name, 0,
+					DEVICE_NAME_SIZE);
+				return 0;
+			}
+		}
+		SDpnt->sdev_driverfs_dev.name[0]  = hex_str[idtype];
 		return 1;
 	}
 	return 0;
@@ -1569,86 +1536,58 @@
 	unsigned char *scsi_cmd = NULL;
 	int lun = SDpnt->lun;
 	int scsi_level = SDpnt->scsi_level;
-	int i, j;
-
-	serialnumber_page = kmalloc(255, (SDpnt->host->unchecked_isa_dma ? 
-			GFP_DMA : GFP_ATOMIC));
-	if (!serialnumber_page)
-		return 0;
+	int max_lgth = 255;
 
 	scsi_cmd = kmalloc(MAX_COMMAND_SIZE, GFP_ATOMIC);
 	if (!scsi_cmd)
-		goto leave;
+		return 0;
+	
+ retry:
+	serialnumber_page = kmalloc(max_lgth, (SDpnt->host->unchecked_isa_dma ?
+			GFP_DMA : GFP_ATOMIC));
+	if (!serialnumber_page) {
+		kfree(scsi_cmd);
+		return 0;
+	}
 
 	/* Use vital product pages to determine serial number */
 	/* Try Supported vital product data pages 0x00 first */
 	scsi_cmd[0] = INQUIRY;
 	if ((lun > 0) && (scsi_level <= SCSI_2))
 		scsi_cmd[1] = ((lun << 5) & 0xe0) | 0x01;
-	else	
+	else
 		scsi_cmd[1] = 0x01;	/* SCSI_3 and higher, don't touch */
 	scsi_cmd[2] = 0x80;
 	scsi_cmd[3] = 0;
-	scsi_cmd[4] = 255;
+	scsi_cmd[4] = max_lgth;
 	scsi_cmd[5] = 0;
 	SRpnt->sr_cmd_len = 0;
 	SRpnt->sr_sense_buffer[0] = 0;
 	SRpnt->sr_sense_buffer[2] = 0;
 	SRpnt->sr_data_direction = SCSI_DATA_READ;
 	scsi_wait_req(SRpnt, (void *) scsi_cmd, (void *) serialnumber_page,
-			255, SCSI_TIMEOUT+4*HZ, 3);
+			max_lgth, SCSI_TIMEOUT+4*HZ, 3);
 
 	if (SRpnt->sr_result) {
 		kfree(scsi_cmd);
 		goto leave;
 	}
 	/* check to see if response was truncated */
-	if (serialnumber_page[3] > 255) {
-		int max_lgth = serialnumber_page[3] + 4;
-
+	if (serialnumber_page[3] > max_lgth) {
+		max_lgth = serialnumber_page[3] + 4;
 		kfree(serialnumber_page);
-		serialnumber_page = kmalloc(max_lgth, 
-			(SDpnt->host->unchecked_isa_dma ? 
-			GFP_DMA : GFP_ATOMIC));
-		if (!serialnumber_page) {
-			kfree(scsi_cmd);
-			return 0;
-		}
 		memset(scsi_cmd, 0, MAX_COMMAND_SIZE);
-		scsi_cmd[0] = INQUIRY;
-		if ((lun > 0) && (scsi_level <= SCSI_2))
-			scsi_cmd[1] = ((lun << 5) & 0xe0) | 0x01;
-		else
-			scsi_cmd[1] = 0x01; /* SCSI_3 and higher, don't touch */
-		scsi_cmd[2] = 0x80;
-		scsi_cmd[3] = 0;
-		scsi_cmd[4] = max_lgth;
-		scsi_cmd[5] = 0;
-		SRpnt->sr_cmd_len = 0;
-		SRpnt->sr_sense_buffer[0] = 0;
-		SRpnt->sr_sense_buffer[2] = 0;
-		SRpnt->sr_data_direction = SCSI_DATA_READ;
-		scsi_wait_req(SRpnt, (void *) scsi_cmd, 
-				(void *) serialnumber_page,
-				max_lgth, SCSI_TIMEOUT+4*HZ, 3);
-		if (SRpnt->sr_result) {
-			kfree(scsi_cmd);
-			goto leave;
-		}
+		goto retry;
 	}
+
 	kfree(scsi_cmd);
 
 	SDpnt->sdev_driverfs_dev.name[0] = SCSI_UID_SER_NUM;
-	for(i = 0, j = 1; i < serialnumber_page[3]; i++) {
-		if (serialnumber_page[4 + i] > 0x20)
-			SDpnt->sdev_driverfs_dev.name[j++] = 
-				serialnumber_page[4 + i];
-	}
-	for(i = 0, j = strlen(SDpnt->sdev_driverfs_dev.name); i < 8; i++) {
-		if (SDpnt->vendor[i] > 0x20) {
-			SDpnt->sdev_driverfs_dev.name[j++] = SDpnt->vendor[i];
-		}
-	}
+	strncpy(&SDpnt->sdev_driverfs_dev.name[1],
+		&serialnumber_page[4],
+		serialnumber_page[3]);
+	strncpy(&SDpnt->sdev_driverfs_dev.name[
+		strlen(SDpnt->sdev_driverfs_dev.name)], SDpnt->vendor, 8);
 	kfree(serialnumber_page);
 	return 1;
  leave:
@@ -1659,27 +1598,10 @@
 
 int scsi_get_default_name(Scsi_Device *SDpnt)
 {
-	int i, j;
-
 	SDpnt->sdev_driverfs_dev.name[0] = SCSI_UID_UNKNOWN;
-	for(i = 0, j = 1; i < 8; i++) {
-		if (SDpnt->vendor[i] > 0x20) {
-			SDpnt->sdev_driverfs_dev.name[j++] = 
-				SDpnt->vendor[i];
-		}
-	}
-	for(i = 0, j = strlen(SDpnt->sdev_driverfs_dev.name); 
-	    i < 16; i++) {
-		if (SDpnt->model[i] > 0x20) {
-			SDpnt->sdev_driverfs_dev.name[j++] = 
-				SDpnt->model[i];
-		}
-	}
-	for(i = 0, j = strlen(SDpnt->sdev_driverfs_dev.name); i < 4; i++) {
-		if (SDpnt->rev[i] > 0x20) {
-			SDpnt->sdev_driverfs_dev.name[j++] = SDpnt->rev[i];
-		}
-	}	
+	strncpy(&SDpnt->sdev_driverfs_dev.name[1], SDpnt->vendor,8);
+	strncat(SDpnt->sdev_driverfs_dev.name, SDpnt->model, 16);
+	strncat(SDpnt->sdev_driverfs_dev.name, SDpnt->rev, 4);
 	return 1;
 }
 
diff -Naur linux-2.5.25.orig/drivers/scsi/sd.c linux-2.5.25/drivers/scsi/sd.c
--- linux-2.5.25.orig/drivers/scsi/sd.c	Fri Jul  5 18:42:18 2002
+++ linux-2.5.25/drivers/scsi/sd.c	Mon Jul  8 10:35:09 2002
@@ -129,8 +129,6 @@
 
 static Scsi_Disk * sd_get_sdisk(int index);
 
-extern void driverfs_remove_partitions(struct gendisk *hd, int minor);
-
 #if defined(CONFIG_PPC32)
 /**
  *	sd_find_target - find kdev_t of first scsi disk that matches
@@ -1541,8 +1539,6 @@
 	max_p = 1 << sd_gendisk.minor_shift;
 	start = dsk_nr << sd_gendisk.minor_shift;
 	dev = MKDEV_SD_PARTITION(start);
-	driverfs_remove_partitions(&SD_GENDISK (dsk_nr), 
-					SD_MINOR_NUMBER (start));
 	wipe_partitions(dev);
 	for (j = max_p - 1; j >= 0; j--)
 		sd_sizes[start + j] = 0;
diff -Naur linux-2.5.25.orig/drivers/scsi/st.c linux-2.5.25/drivers/scsi/st.c
--- linux-2.5.25.orig/drivers/scsi/st.c	Fri Jul  5 18:42:32 2002
+++ linux-2.5.25/drivers/scsi/st.c	Mon Jul  8 10:34:27 2002
@@ -3658,7 +3658,7 @@
 	    /*  Rewind entry  */
 	    sprintf (name, "mt%s", formats[mode]);
 	    sprintf(tpnt->driverfs_dev_r[mode].bus_id, "%s:%s", 
-		    SDp->sdev_driverfs_dev.name, name);
+		    SDp->sdev_driverfs_dev.bus_id, name);
 	    sprintf(tpnt->driverfs_dev_r[mode].name, "%s%s", 
 		    SDp->sdev_driverfs_dev.name, name);
 	    tpnt->driverfs_dev_r[mode].parent = &SDp->sdev_driverfs_dev;
@@ -3677,7 +3677,7 @@
 	    /*  No-rewind entry  */
 	    sprintf (name, "mt%sn", formats[mode]);
 	    sprintf(tpnt->driverfs_dev_n[mode].bus_id, "%s:%s", 
-		    SDp->sdev_driverfs_dev.name, name);
+		    SDp->sdev_driverfs_dev.bus_id, name);
 	    sprintf(tpnt->driverfs_dev_n[mode].name, "%s%s", 
 		    SDp->sdev_driverfs_dev.name, name);
 	    tpnt->driverfs_dev_n[mode].parent= &SDp->sdev_driverfs_dev;
diff -Naur linux-2.5.25.orig/fs/partitions/check.c linux-2.5.25/fs/partitions/check.c
--- linux-2.5.25.orig/fs/partitions/check.c	Fri Jul  5 18:42:21 2002
+++ linux-2.5.25/fs/partitions/check.c	Mon Jul  8 10:37:37 2002
@@ -328,6 +328,7 @@
 	int part;
 	struct device * current_driverfs_dev;
 	
+	if (!hd->driverfs_dev_arr) return;
 	max_p=(1 << hd->minor_shift);
 	
 	/* for all parts setup parent relationships and device node names */
@@ -616,6 +617,7 @@
 	if (minor0 != minor)		/* for now only whole-disk reread */
 		return -EINVAL;		/* %%% later.. */
 
+	driverfs_remove_partitions(g, minor0);
 	/* invalidate stuff */
 	for (p = max_p - 1; p >= 0; p--) {
 		minor = minor0 + p;
diff -Naur linux-2.5.25.orig/kernel/ksyms.c linux-2.5.25/kernel/ksyms.c
--- linux-2.5.25.orig/kernel/ksyms.c	Fri Jul  5 18:42:02 2002
+++ linux-2.5.25/kernel/ksyms.c	Mon Jul  8 10:35:33 2002
@@ -330,7 +330,6 @@
 EXPORT_SYMBOL(set_device_ro);
 EXPORT_SYMBOL(bmap);
 EXPORT_SYMBOL(devfs_register_partitions);
-EXPORT_SYMBOL(driverfs_remove_partitions);
 EXPORT_SYMBOL(blkdev_open);
 EXPORT_SYMBOL(blkdev_get);
 EXPORT_SYMBOL(blkdev_put);

--+nBD6E3TurpgldQp--
