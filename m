Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135681AbRAGEzH>; Sat, 6 Jan 2001 23:55:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135733AbRAGEyr>; Sat, 6 Jan 2001 23:54:47 -0500
Received: from mail.courier-mta.com ([216.254.50.2]:16656 "EHLO
	mail.courier-mta.com") by vger.kernel.org with ESMTP
	id <S135681AbRAGEyl>; Sat, 6 Jan 2001 23:54:41 -0500
Date: Sat, 6 Jan 2001 23:54:37 -0500 (EST)
From: Sam Varshavchik <mrsam@courier-mta.com>
Reply-To: mrsam@courier-mta.com
To: Gadi Oxman <gadio@netvision.net.il>
cc: linux-kernel@vger.kernel.org
Subject: PATCH: format floppies in ATAPI IDE floppy drives.
Message-ID: <Pine.LNX.4.30.0101062343020.30089-100000@ny.email-scan.com>
X-No-Archive: Yes
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the ability to format standard 3.5" floppies in ATAPI IDE
floppy drives.  It's actually against ide-floppy.c from a test 2.4 kernel,
but I expect it to apply to the 2.4-final (I don't recall seeing any
updates to ide-floppy.c, recently).

A short userland utility is required to use this patch.  I've written a
pretty raw userland utility for that.  I'll clean it up and make it more
presentable later.  Download the userland code from
http://www.email-scan.com/idefloppy/

The tarball includes some additional documentation and musings.


--- drivers/ide/ide-floppy.c.orig	Fri Oct 27 02:35:48 2000
+++ drivers/ide/ide-floppy.c	Sat Jan  6 23:01:35 2001
@@ -1,5 +1,5 @@
 /*
- * linux/drivers/ide/ide-floppy.c	Version 0.9	Jul   4, 1999
+ * linux/drivers/ide/ide-floppy.c	Version 0.9.sv	Jan 6 2001
  *
  * Copyright (C) 1996 - 1999 Gadi Oxman <gadio@netvision.net.il>
  */
@@ -29,9 +29,18 @@
  * Ver 0.9   Jul  4 99   Fix a bug which might have caused the number of
  *                        bytes requested on each interrupt to be zero.
  *                        Thanks to <shanos@es.co.nz> for pointing this out.
+ * Ver 0.9.sv Jan 6 01   Sam Varshavchik <mrsam@courier-mta.com>
+ *                       Implement low level formatting.  Reimplemented
+ *                       IDEFLOPPY_CAPABILITIES_PAGE, since we need the srfp
+ *                       bit.  My LS-120 drive barfs on
+ *                       IDEFLOPPY_CAPABILITIES_PAGE, but maybe it's just me.
+ *                       Compromise by not reporting a failure to get this
+ *                       mode page.  Implemented four IOCTLs in order to
+ *                       implement formatting.  IOCTls begin with 0x4600,
+ *                       0x46 is 'F' as in Format.
  */

-#define IDEFLOPPY_VERSION "0.9"
+#define IDEFLOPPY_VERSION "0.9.sv"

 #include <linux/config.h>
 #include <linux/module.h>
@@ -228,6 +237,7 @@
 	 *	Last error information
 	 */
 	byte sense_key, asc, ascq;
+	int progress_indication;

 	/*
 	 *	Device information
@@ -236,7 +246,7 @@
 	idefloppy_capacity_descriptor_t capacity;		/* Last format capacity */
 	idefloppy_flexible_disk_page_t flexible_disk_page;	/* Copy of the flexible disk page */
 	int wp;							/* Write protect */
-
+	int srfp;			/* Supports format progress report */
 	unsigned int flags;			/* Status/Action flags */
 } idefloppy_floppy_t;

@@ -246,6 +256,7 @@
 #define IDEFLOPPY_DRQ_INTERRUPT		0	/* DRQ interrupt device */
 #define IDEFLOPPY_MEDIA_CHANGED		1	/* Media may have changed */
 #define IDEFLOPPY_USE_READ12		2	/* Use READ12/WRITE12 or READ10/WRITE10 */
+#define	IDEFLOPPY_FORMAT_IN_PROGRESS	3	/* Format in progress */

 /*
  *	ATAPI floppy drive packet commands
@@ -276,6 +287,15 @@
 #define MODE_SENSE_SAVED		0x03

 /*
+ *	IOCTLs used in low-level formatting.
+ */
+
+#define	IDEFLOPPY_IOCTL_FORMAT_SUPPORTED	0x4600
+#define	IDEFLOPPY_IOCTL_FORMAT_GET_CAPACITY	0x4601
+#define	IDEFLOPPY_IOCTL_FORMAT_START		0x4602
+#define IDEFLOPPY_IOCTL_FORMAT_GET_PROGRESS	0x4603
+
+/*
  *	Special requests for our block device strategy routine.
  */
 #define	IDEFLOPPY_FIRST_RQ		90
@@ -559,7 +579,7 @@
 	u8		asc;			/* Additional Sense Code */
 	u8		ascq;			/* Additional Sense Code Qualifier */
 	u8		replaceable_unit_code;	/* Field Replaceable Unit Code */
-	u8		reserved[3];
+	u8		sksv[3];
 	u8		pad[2];			/* Padding to 20 bytes */
 } idefloppy_request_sense_result_t;

@@ -746,6 +766,8 @@
 	idefloppy_floppy_t *floppy = drive->driver_data;

 	floppy->sense_key = result->sense_key; floppy->asc = result->asc; floppy->ascq = result->ascq;
+	floppy->progress_indication= result->sksv[0] & 0x80 ?
+		(unsigned short)get_unaligned((u16 *)(result->sksv+1)):0x10000;
 #if IDEFLOPPY_DEBUG_LOG
 	if (floppy->failed_pc)
 		printk (KERN_INFO "ide-floppy: pc = %x, sense key = %x, asc = %x, ascq = %x\n",floppy->failed_pc->c[0],result->sense_key,result->asc,result->ascq);
@@ -954,7 +976,7 @@
 		return ide_do_reset (drive);
 	}
 	ide_set_handler (drive, &idefloppy_pc_intr, IDEFLOPPY_WAIT_CMD, NULL);	/* Set the interrupt routine */
-	atapi_output_bytes (drive, floppy->pc->c, 12);		/* Send the actual packet */
+	atapi_output_bytes (drive, floppy->pc->c, 12); /* Send the actual packet */
 	return ide_started;
 }

@@ -1062,6 +1084,22 @@
 	pc->request_transfer = 255;
 }

+static void idefloppy_create_format_unit_cmd (idefloppy_pc_t *pc, int b, int l)
+{
+	idefloppy_init_pc (pc);
+	pc->c[0] = IDEFLOPPY_FORMAT_UNIT_CMD;
+	pc->c[1] = 0x17;
+
+	memset(pc->buffer, 0, 12);
+	pc->buffer[1] = 0xA2;	/* Format list header, byte 1: FOV/DCRT/IMM */
+	pc->buffer[3] = 8;
+
+	put_unaligned(htonl(b), (unsigned int *)(&pc->buffer[4]));
+	put_unaligned(htonl(l), (unsigned int *)(&pc->buffer[8]));
+	pc->buffer_size=12;
+	set_bit(PC_WRITING, &pc->flags);
+}
+
 /*
  *	A mode sense command is used to "sense" floppy parameters.
  */
@@ -1235,6 +1273,25 @@
 	return 0;
 }

+static int idefloppy_get_capability_page(ide_drive_t *drive)
+{
+	idefloppy_floppy_t *floppy = drive->driver_data;
+	idefloppy_pc_t pc;
+	idefloppy_mode_parameter_header_t *header;
+	idefloppy_capabilities_page_t *page;
+
+	floppy->srfp=0;
+	idefloppy_create_mode_sense_cmd (&pc, IDEFLOPPY_CAPABILITIES_PAGE,
+						 MODE_SENSE_CURRENT);
+	if (idefloppy_queue_pc_tail (drive,&pc)) {
+		return 1;
+	}
+	header = (idefloppy_mode_parameter_header_t *) pc.buffer;
+	page= (idefloppy_capabilities_page_t *)(header+1);
+	floppy->srfp=page->srfp;
+	return (0);
+}
+
 /*
  *	Determine if a media is present in the floppy drive, and if so,
  *	its LBA capacity.
@@ -1286,11 +1343,172 @@
 #endif /* IDEFLOPPY_DEBUG_INFO */
 	}
 	(void) idefloppy_get_flexible_disk_page (drive);
+	(void) idefloppy_get_capability_page (drive);
+
 	drive->part[0].nr_sects = floppy->blocks * floppy->bs_factor;
 	return rc;
 }

 /*
+** Obtain the list of formattable capacities.
+** Very similar to idefloppy_get_capacity, except that we push the capacity
+** descriptors to userland, instead of our own structures.
+**
+** Userland gives us the following structure:
+**
+** struct idefloppy_format_capacities {
+**        int nformats;
+**        struct {
+**                int nblocks;
+**                int blocksize;
+**                } formats[];
+**        } ;
+**
+** userland initializes nformats to the number of allocated formats[]
+** records.  On exit we set nformats to the number of records we've
+** actually initialized.
+**
+*/
+
+static int idefloppy_get_format_capacities (ide_drive_t *drive,
+					    struct inode *inode,
+					    struct file *file,
+					    int *arg)	/* Cheater */
+{
+        idefloppy_pc_t pc;
+	idefloppy_capacity_header_t *header;
+        idefloppy_capacity_descriptor_t *descriptor;
+	int i, descriptors, blocks, length;
+	int u_array_size;
+	int u_index;
+	int *argp;
+
+	if (get_user(u_array_size, arg))
+		return (-EFAULT);
+
+	if (u_array_size <= 0)
+		return (-EINVAL);
+
+	idefloppy_create_read_capacity_cmd (&pc);
+	if (idefloppy_queue_pc_tail (drive, &pc)) {
+		printk (KERN_ERR "ide-floppy: Can't get floppy parameters\n");
+                return (-EIO);
+        }
+        header = (idefloppy_capacity_header_t *) pc.buffer;
+        descriptors = header->length /
+		sizeof (idefloppy_capacity_descriptor_t);
+	descriptor = (idefloppy_capacity_descriptor_t *) (header + 1);
+
+	u_index=0;
+	argp=arg+1;
+
+	/*
+	** We always skip the first capacity descriptor.  That's the
+	** current capacity.  We are interested in the remaining descriptors,
+	** the formattable capacities.
+	*/
+
+	for (i=0; i<descriptors; i++, descriptor++)
+	{
+		if (u_index >= u_array_size)
+			break;	/* User-supplied buffer too small */
+		if (i == 0)
+			continue;	/* Skip the first descriptor */
+
+		blocks = ntohl (descriptor->blocks);
+		length = ntohs (descriptor->length);
+
+		if (put_user(blocks, argp))
+			return (-EFAULT);
+		++argp;
+
+		if (put_user(length, argp))
+			return (-EFAULT);
+		++argp;
+
+		++u_index;
+	}
+
+	if (put_user(u_index, arg))
+		return (-EFAULT);
+	return (0);
+}
+
+/*
+** Send ATAPI_FORMAT_UNIT to the drive.
+**
+** Userland gives us the following structure:
+**
+** struct idefloppy_format_command {
+**        int nblocks;
+**        int blocksize;
+**        } ;
+*/
+
+static int idefloppy_begin_format(ide_drive_t *drive,
+				  struct inode *inode,
+				  struct file *file,
+				  int *arg)
+{
+	int blocks;
+	int length;
+	idefloppy_pc_t pc;
+
+	if (get_user(blocks, arg)
+	    || get_user(length, arg+1))
+	{
+		return (-EFAULT);
+	}
+
+	idefloppy_create_format_unit_cmd(&pc, blocks, length);
+	if (idefloppy_queue_pc_tail (drive, &pc))
+	{
+                return (-EIO);
+        }
+	return (0);
+}
+
+/*
+** Get ATAPI_FORMAT_UNIT progress indication.
+**
+** Userland gives a pointer to an int.  The int is set to a progresss
+** indicator 0-65536, with 65536=100%.
+**
+** If the drive does not support format progress indication, we just return
+** a 65536, screw it.
+*/
+
+static int idefloppy_get_format_progress(ide_drive_t *drive,
+					 struct inode *inode,
+					 struct file *file,
+					 int *arg)
+{
+	idefloppy_floppy_t *floppy = drive->driver_data;
+	idefloppy_pc_t pc;
+	int progress_indication=0x10000;
+
+	if (floppy->srfp)
+	{
+		idefloppy_create_request_sense_cmd(&pc);
+		if (idefloppy_queue_pc_tail (drive, &pc))
+		{
+			return (-EIO);
+		}
+
+		if (floppy->sense_key == 2 && floppy->asc == 4 &&
+		    floppy->ascq == 4)
+		{
+			progress_indication=floppy->progress_indication;
+		}
+	}
+
+	if (put_user(progress_indication, arg))
+		return (-EFAULT);
+
+	return (0);
+}
+
+/*
  *	Our special ide-floppy ioctl's.
  *
  *	Currently there aren't any ioctl's.
@@ -1300,7 +1518,8 @@
 {
 	idefloppy_pc_t pc;

-	if (cmd == CDROMEJECT) {
+	switch (cmd) {
+	case CDROMEJECT:
 		if (drive->usage > 1)
 			return -EBUSY;
 		idefloppy_create_prevent_cmd (&pc, 0);
@@ -1308,6 +1527,51 @@
 		idefloppy_create_start_stop_cmd (&pc, 2);
 		(void) idefloppy_queue_pc_tail (drive, &pc);
 		return 0;
+	case IDEFLOPPY_IOCTL_FORMAT_SUPPORTED:
+		return (0);
+	case IDEFLOPPY_IOCTL_FORMAT_GET_CAPACITY:
+		return (idefloppy_get_format_capacities(drive, inode, file,
+							(int *)arg));
+	case IDEFLOPPY_IOCTL_FORMAT_START:
+
+		if (!(file->f_mode & 2))
+			return (-EPERM);
+
+		{
+			idefloppy_floppy_t *floppy = drive->driver_data;
+
+			set_bit(IDEFLOPPY_FORMAT_IN_PROGRESS, &floppy->flags);
+
+			if (drive->usage > 1)
+			{
+				/* Don't format if someone is using the disk */
+
+				clear_bit(IDEFLOPPY_FORMAT_IN_PROGRESS,
+					  &floppy->flags);
+				return -EBUSY;
+			}
+			else
+			{
+				int rc=idefloppy_begin_format(drive, inode,
+							      file,
+							      (int *)arg);
+
+				if (rc)
+					clear_bit(IDEFLOPPY_FORMAT_IN_PROGRESS,
+						  &floppy->flags);
+				return (rc);
+
+			/*
+			** Note, the bit will be cleared when the device is
+			** closed.  This is the cleanest way to handle the
+			** situation where the drive does not support
+			** format progress reporting.
+			*/
+			}
+		}
+	case IDEFLOPPY_IOCTL_FORMAT_GET_PROGRESS:
+		return (idefloppy_get_format_progress(drive, inode, file,
+						      (int *)arg));
 	}
  	return -EIO;
 }
@@ -1326,16 +1590,22 @@

 	MOD_INC_USE_COUNT;
 	if (drive->usage == 1) {
+
+		clear_bit(IDEFLOPPY_FORMAT_IN_PROGRESS, &floppy->flags);
+		/* Just in case */
+
 		idefloppy_create_test_unit_ready_cmd(&pc);
 		if (idefloppy_queue_pc_tail(drive, &pc)) {
 			idefloppy_create_start_stop_cmd (&pc, 1);
 			(void) idefloppy_queue_pc_tail (drive, &pc);
 		}
+
 		if (idefloppy_get_capacity (drive)) {
 			drive->usage--;
 			MOD_DEC_USE_COUNT;
 			return -EIO;
 		}
+
 		if (floppy->wp && (filp->f_mode & 2)) {
 			drive->usage--;
 			MOD_DEC_USE_COUNT;
@@ -1346,6 +1616,12 @@
 		(void) idefloppy_queue_pc_tail (drive, &pc);
 		check_disk_change(inode->i_rdev);
 	}
+	else if (test_bit(IDEFLOPPY_FORMAT_IN_PROGRESS, &floppy->flags))
+	{
+		drive->usage--;
+		MOD_DEC_USE_COUNT;
+		return -EBUSY;
+	}
 	return 0;
 }

@@ -1358,9 +1634,13 @@
 #endif /* IDEFLOPPY_DEBUG_LOG */

 	if (!drive->usage) {
+		idefloppy_floppy_t *floppy = drive->driver_data;
+
 		invalidate_buffers (inode->i_rdev);
 		idefloppy_create_prevent_cmd (&pc, 0);
 		(void) idefloppy_queue_pc_tail (drive, &pc);
+
+		clear_bit(IDEFLOPPY_FORMAT_IN_PROGRESS, &floppy->flags);
 	}
 	MOD_DEC_USE_COUNT;
 }

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
