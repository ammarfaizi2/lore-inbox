Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129706AbRANXKH>; Sun, 14 Jan 2001 18:10:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129789AbRANXJ6>; Sun, 14 Jan 2001 18:09:58 -0500
Received: from mail.libertysurf.net ([213.36.80.91]:42024 "EHLO
	mail.libertysurf.net") by vger.kernel.org with ESMTP
	id <S129706AbRANXJv>; Sun, 14 Jan 2001 18:09:51 -0500
Message-ID: <3A623265.A2D49E80@paulbristow.net>
Date: Mon, 15 Jan 2001 00:12:37 +0100
From: Paul Bristow <paul@paulbristow.net>
Organization: http://paulbristow.net
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
CC: Linus Torvalds <torvalds@transmeta.com>,
        Sam Varshavchik <mrsam@courier-mta.com>
Subject: [PATCH] ide-floppy ATAPI format capability (official)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

This is Sam Varshavchik's ATAPI format patch, synced in with my update
to the driver.  It requires ide-floppy.c V0.96.  This patch brings the
driver to 0.97.

This patch updates ide-floppy to include ATAPI formatting ioctls.  Like
other devices, we allow O_NDELAY to open a drive without a disk, or with
an unreadable disk, so that we can get the format capacity of the drive
or begin the format.

This has not yet been extensively tested.  Anyone with an LS-120 drive
is welcome to format 1.44MB floppies with it.  You will need Sams floppy
formatting utility which is available at
http://www.email-scan.com/floppy.

Feedback is welcome.

Regards, 

Paul Bristow

Linux IDE-Floppy Maintainer

Patch follows:


--- linux/drivers/ide/ide-floppy-0.96.c Sun Jan 14 23:29:02 2001
+++ linux/drivers/ide/ide-floppy.c      Sun Jan 14 23:49:23 2001
@@ -1,5 +1,5 @@
 /*
- * linux/drivers/ide/ide-floppy.c      Version 0.96    Jan 7, 2001
+ * linux/drivers/ide/ide-floppy.c      Version 0.97    Jan 14 2001
  *
  * Copyright (C) 1996 - 1999 Gadi Oxman <gadio@netvision.net.il>
  * Copyright (C) 2000 - 2001 Paul Bristow <paul@paulbristow.net>
@@ -46,10 +46,34 @@
  * Ver 0.95  Nov  7 00   Brought across to kernel 2.4
  * Ver 0.96  Jan  7 01   Actually in line with release version of 2.4.0
  *                       including set_bit patch from Rusty Russel
+ * Ver 0.96.sv Jan 6 01  Sam Varshavchik <mrsam@courier-mta.com>
+ *                       Implement low level formatting.  Reimplemented
+ *                       IDEFLOPPY_CAPABILITIES_PAGE, since we need the
srfp
+ *                       bit.  My LS-120 drive barfs on
+ *                       IDEFLOPPY_CAPABILITIES_PAGE, but maybe it's
just me.
+ *                       Compromise by not reporting a failure to get
this
+ *                       mode page.  Implemented four IOCTLs in order
to
+ *                       implement formatting.  IOCTls begin with
0x4600,
+ *                       0x46 is 'F' as in Format.
+ *                       Also, O_NDELAY on open will allow the device
to be
+ *                       opened without a disk available.  This can be
used to
+ *                       open an unformatted disk, or get the device
capacity.
  *           
+ *            Jan 9 01   Userland option to select format verify.
+ *                       Added PC_SUPPRESS_ERROR flag - some idefloppy
drives
+ *                       do not implement IDEFLOPPY_CAPABILITIES_PAGE,
and
+ *                       return a sense error.  Suppress error
reporting in
+ *                       this particular case in order to avoid
spurious
+ *                       errors in syslog.  The culprit is
+ *                       idefloppy_get_capability_page(), so move it to
+ *                       idefloppy_begin_format() so that it's not used
+ *                       unless absolutely necessary.
+ *                       If drive does not support format progress
indication
+ *                       monitor the dsc bit in the status register.
+ *     Ver 0.97  Jan 14 01  Issued release 0.97 for kernel 2.4.0
  */
 
-#define IDEFLOPPY_VERSION "0.96"
+#define IDEFLOPPY_VERSION "0.97"
 
 #include <linux/config.h>
 #include <linux/module.h>
@@ -136,6 +160,8 @@
 #define        PC_DMA_ERROR                    4       /* 1 when
encountered problem during DMA */
 #define        PC_WRITING                      5       /* Data
direction */
 
+#define        PC_SUPPRESS_ERROR               6       /* Suppress
error reporting */
+
 /*
  *     Removable Block Access Capabilities Page
  */
@@ -249,6 +275,7 @@
         *      Last error information
         */
        byte sense_key, asc, ascq;
+       int progress_indication;
 
        /*
         *      Device information
@@ -257,7 +284,7 @@
        idefloppy_capacity_descriptor_t capacity;               /* Last
format capacity */
        idefloppy_flexible_disk_page_t flexible_disk_page;      /* Copy
of the flexible disk page */
        int wp;                                                 /* Write
protect */
-
+       int srfp;                       /* Supports format progress
report */
        unsigned long flags;                    /* Status/Action flags :
long for set_bit() */
 } idefloppy_floppy_t;
 
@@ -269,6 +296,7 @@
 #define IDEFLOPPY_USE_READ12           2       /* Use READ12/WRITE12 or
READ10/WRITE10 */
 #define IDEFLOPPY_CLIK_DRIVE      3       /* Avoid commands not
supported in Clik drive */
 #define IDEFLOPPY_POWERBOOK_ZIP   4       /* Kludge for Apple Powerbook
Zip drive */
+#define IDEFLOPPY_FORMAT_IN_PROGRESS   5       /* Format in progress */
 
 /*
  *     ATAPI floppy drive packet commands
@@ -299,6 +327,15 @@
 #define MODE_SENSE_SAVED               0x03
 
 /*
+ *     IOCTLs used in low-level formatting.
+ */
+
+#define        IDEFLOPPY_IOCTL_FORMAT_SUPPORTED        0x4600
+#define        IDEFLOPPY_IOCTL_FORMAT_GET_CAPACITY     0x4601
+#define        IDEFLOPPY_IOCTL_FORMAT_START            0x4602
+#define IDEFLOPPY_IOCTL_FORMAT_GET_PROGRESS    0x4603
+
+/*
  *     Special requests for our block device strategy routine.
  */
 #define        IDEFLOPPY_FIRST_RQ              90
@@ -582,7 +619,7 @@
        u8              asc;                    /* Additional Sense Code
*/
        u8              ascq;                   /* Additional Sense Code
Qualifier */
        u8              replaceable_unit_code;  /* Field Replaceable
Unit Code */
-       u8              reserved[3];
+       u8              sksv[3];
        u8              pad[2];                 /* Padding to 20 bytes
*/
 } idefloppy_request_sense_result_t;
 
@@ -767,6 +804,9 @@
        idefloppy_floppy_t *floppy = drive->driver_data;
 
        floppy->sense_key = result->sense_key; floppy->asc =
result->asc; floppy->ascq = result->ascq;
+       floppy->progress_indication= result->sksv[0] & 0x80 ?
+               (unsigned short)get_unaligned((u16
*)(result->sksv+1)):0x10000;
+
   if (floppy->failed_pc) {
     IDEFLOPPY_DEBUG("ide-floppy: pc = %x, sense key = %x, asc = %x,
ascq =
%x\n",floppy->failed_pc->c[0],result->sense_key,result->asc,result->ascq);
   }
@@ -990,8 +1030,11 @@
                 *      a legitimate error code was received.
                 */
                if (!test_bit (PC_ABORT, &pc->flags)) {
+                       if (!test_bit (PC_SUPPRESS_ERROR, &pc->flags)) {
+                               ;
       IDEFLOPPY_DEBUG( "ide-floppy: %s: I/O error, pc = %2x, key = %2x,
asc = %2x, ascq = %2x\n",
                                drive->name, pc->c[0],
floppy->sense_key, floppy->asc, floppy->ascq);
+                       }
                        pc->error = IDEFLOPPY_ERROR_GENERAL;           
/* Giving up */
                }
                floppy->failed_pc=NULL;
@@ -1063,6 +1106,27 @@
        pc->request_transfer = 255;
 }
 
+static void idefloppy_create_format_unit_cmd (idefloppy_pc_t *pc, int
b, int l,
+                                             int flags)
+{
+       idefloppy_init_pc (pc);
+       pc->c[0] = IDEFLOPPY_FORMAT_UNIT_CMD;
+       pc->c[1] = 0x17;
+
+       memset(pc->buffer, 0, 12);
+       pc->buffer[1] = 0xA2;
+       /* Default format list header, byte 1: FOV/DCRT/IMM bits set */
+
+       if (flags & 1)                          /* Verify bit on... */
+               pc->buffer[1] ^= 0x20;          /* ... turn off DCRT bit
*/
+       pc->buffer[3] = 8;
+
+       put_unaligned(htonl(b), (unsigned int *)(&pc->buffer[4]));
+       put_unaligned(htonl(l), (unsigned int *)(&pc->buffer[8]));
+       pc->buffer_size=12;
+       set_bit(PC_WRITING, &pc->flags);
+}
+
 /*
  *     A mode sense command is used to "sense" floppy parameters.
  */
@@ -1233,6 +1297,28 @@
 }
 
 
+static int idefloppy_get_capability_page(ide_drive_t *drive)
+{
+       idefloppy_floppy_t *floppy = drive->driver_data;
+       idefloppy_pc_t pc;
+       idefloppy_mode_parameter_header_t *header;
+       idefloppy_capabilities_page_t *page;
+
+       floppy->srfp=0;
+       idefloppy_create_mode_sense_cmd (&pc,
IDEFLOPPY_CAPABILITIES_PAGE,
+                                                MODE_SENSE_CURRENT);
+
+       set_bit(PC_SUPPRESS_ERROR, &pc.flags);
+       if (idefloppy_queue_pc_tail (drive,&pc)) {
+               return 1;
+       }
+
+       header = (idefloppy_mode_parameter_header_t *) pc.buffer;
+       page= (idefloppy_capabilities_page_t *)(header+1);
+       floppy->srfp=page->srfp;
+       return (0);
+}
+
 /*
  *     Determine if a media is present in the floppy drive, and if so,
  *     its LBA capacity.
@@ -1305,6 +1391,186 @@
 
 
 /*
+** Obtain the list of formattable capacities.
+** Very similar to idefloppy_get_capacity, except that we push the
capacity
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
+                                           struct inode *inode,
+                                           struct file *file,
+                                           int *arg)   /* Cheater */
+{
+        idefloppy_pc_t pc;
+       idefloppy_capacity_header_t *header;
+        idefloppy_capacity_descriptor_t *descriptor;
+       int i, descriptors, blocks, length;
+       int u_array_size;
+       int u_index;
+       int *argp;
+
+       if (get_user(u_array_size, arg))
+               return (-EFAULT);
+
+       if (u_array_size <= 0)
+               return (-EINVAL);
+
+       idefloppy_create_read_capacity_cmd (&pc);
+       if (idefloppy_queue_pc_tail (drive, &pc)) {
+               printk (KERN_ERR "ide-floppy: Can't get floppy
parameters\n");
+                return (-EIO);
+        }
+        header = (idefloppy_capacity_header_t *) pc.buffer;
+        descriptors = header->length /
+               sizeof (idefloppy_capacity_descriptor_t);
+       descriptor = (idefloppy_capacity_descriptor_t *) (header + 1);
+
+       u_index=0;
+       argp=arg+1;
+
+       /*
+       ** We always skip the first capacity descriptor.  That's the
+       ** current capacity.  We are interested in the remaining
descriptors,
+       ** the formattable capacities.
+       */
+
+       for (i=0; i<descriptors; i++, descriptor++)
+       {
+               if (u_index >= u_array_size)
+                       break;  /* User-supplied buffer too small */
+               if (i == 0)
+                       continue;       /* Skip the first descriptor */
+
+               blocks = ntohl (descriptor->blocks);
+               length = ntohs (descriptor->length);
+
+               if (put_user(blocks, argp))
+                       return (-EFAULT);
+               ++argp;
+
+               if (put_user(length, argp))
+                       return (-EFAULT);
+               ++argp;
+
+               ++u_index;
+       }
+
+       if (put_user(u_index, arg))
+               return (-EFAULT);
+       return (0);
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
+**        int flags;
+**        } ;
+**
+** flags is a bitmask, currently, the only defined flag is:
+**
+**        0x01 - verify media after format.
+*/
+
+static int idefloppy_begin_format(ide_drive_t *drive,
+                                 struct inode *inode,
+                                 struct file *file,
+                                 int *arg)
+{
+       int blocks;
+       int length;
+       int flags;
+       idefloppy_pc_t pc;
+
+       if (get_user(blocks, arg)
+           || get_user(length, arg+1)
+           || get_user(flags, arg+2))
+       {
+               return (-EFAULT);
+       }
+
+       (void) idefloppy_get_capability_page (drive);   /* Get the SFRP
bit */
+       idefloppy_create_format_unit_cmd(&pc, blocks, length, flags);
+       if (idefloppy_queue_pc_tail (drive, &pc))
+       {
+                return (-EIO);
+        }
+       return (0);
+}
+
+/*
+** Get ATAPI_FORMAT_UNIT progress indication.
+**
+** Userland gives a pointer to an int.  The int is set to a progresss
+** indicator 0-65536, with 65536=100%.
+**
+** If the drive does not support format progress indication, we just
check
+** the dsc bit, and return either 0 or 65536.
+*/
+
+static int idefloppy_get_format_progress(ide_drive_t *drive,
+                                        struct inode *inode,
+                                        struct file *file,
+                                        int *arg)
+{
+       idefloppy_floppy_t *floppy = drive->driver_data;
+       idefloppy_pc_t pc;
+       int progress_indication=0x10000;
+
+       if (floppy->srfp)
+       {
+               idefloppy_create_request_sense_cmd(&pc);
+               if (idefloppy_queue_pc_tail (drive, &pc))
+               {
+                       return (-EIO);
+               }
+
+               if (floppy->sense_key == 2 && floppy->asc == 4 &&
+                   floppy->ascq == 4)
+               {
+                       progress_indication=floppy->progress_indication;
+               }
+               /* Else assume format_unit has finished, and we're
+               ** at 0x10000 */
+       }
+       else
+       {
+               idefloppy_status_reg_t status;
+               unsigned long flags;
+
+               __save_flags(flags);
+               __cli();
+               status.all=GET_STAT();
+               __restore_flags(flags);
+
+               progress_indication= !status.b.dsc ? 0:0x10000;
+       }
+       if (put_user(progress_indication, arg))
+               return (-EFAULT);
+
+       return (0);
+}
+
+/*
  *     Our special ide-floppy ioctl's.
  *
  *      Supports eject command 
@@ -1315,7 +1581,8 @@
        idefloppy_pc_t pc;
   idefloppy_floppy_t *floppy = drive->driver_data;
 
-       if (cmd == CDROMEJECT) {
+       switch (cmd) {
+       case CDROMEJECT:
                if (drive->usage > 1)
                        return -EBUSY;
     /* The IOMEGA Clik! Drive doesn't support this command - no room
for an eject mechanism */
@@ -1326,6 +1593,51 @@
                idefloppy_create_start_stop_cmd (&pc, 2);
                (void) idefloppy_queue_pc_tail (drive, &pc);
                return 0;
+       case IDEFLOPPY_IOCTL_FORMAT_SUPPORTED:
+               return (0);
+       case IDEFLOPPY_IOCTL_FORMAT_GET_CAPACITY:
+               return (idefloppy_get_format_capacities(drive, inode,
file,
+                                                       (int *)arg));
+       case IDEFLOPPY_IOCTL_FORMAT_START:
+
+               if (!(file->f_mode & 2))
+                       return (-EPERM);
+
+               {
+                       idefloppy_floppy_t *floppy = drive->driver_data;
+
+                       set_bit(IDEFLOPPY_FORMAT_IN_PROGRESS,
&floppy->flags);
+
+                       if (drive->usage > 1)
+                       {
+                               /* Don't format if someone is using the
disk */
+
+                               clear_bit(IDEFLOPPY_FORMAT_IN_PROGRESS,
+                                         &floppy->flags);
+                               return -EBUSY;
+                       }
+                       else
+                       {
+                               int rc=idefloppy_begin_format(drive,
inode,
+                                                             file,
+                                                             (int
*)arg);
+
+                               if (rc)
+                                      
clear_bit(IDEFLOPPY_FORMAT_IN_PROGRESS,
+                                                 &floppy->flags);
+                               return (rc);
+
+                       /*
+                       ** Note, the bit will be cleared when the device
is
+                       ** closed.  This is the cleanest way to handle
the
+                       ** situation where the drive does not support
+                       ** format progress reporting.
+                       */
+                       }
+               }
+       case IDEFLOPPY_IOCTL_FORMAT_GET_PROGRESS:
+               return (idefloppy_get_format_progress(drive, inode,
file,
+                                                     (int *)arg));
        }
        return -EIO;
 }
@@ -1342,6 +1654,10 @@
 
        MOD_INC_USE_COUNT;
        if (drive->usage == 1) {
+
+               clear_bit(IDEFLOPPY_FORMAT_IN_PROGRESS, &floppy->flags);
+               /* Just in case */
+
     IDEFLOPPY_DEBUG( "Testing if unit is ready...\n");
                idefloppy_create_test_unit_ready_cmd(&pc);
                if (idefloppy_queue_pc_tail(drive, &pc)) {
@@ -1352,7 +1668,14 @@
     { 
            IDEFLOPPY_DEBUG( "Yes unit is ready\n");
                }
-               if (idefloppy_get_capacity (drive)) {
+               if (idefloppy_get_capacity (drive)
+                  && (filp->f_flags & O_NDELAY) == 0
+                   /*
+                   ** Allow O_NDELAY to open a drive without a disk, or
with
+                   ** an unreadable disk, so that we can get the format
+                   ** capacity of the drive or begin the format - Sam
+                   */
+                   ) {
                        drive->usage--;
                        MOD_DEC_USE_COUNT;
       IDEFLOPPY_DEBUG( "I/O Error Getting Capacity\n");
@@ -1371,6 +1694,12 @@
     }
                check_disk_change(inode->i_rdev);
        }
+       else if (test_bit(IDEFLOPPY_FORMAT_IN_PROGRESS, &floppy->flags))
+       {
+               drive->usage--;
+               MOD_DEC_USE_COUNT;
+               return -EBUSY;
+       }
        return 0;
 }
 
@@ -1387,6 +1716,7 @@
                if (!test_bit(IDEFLOPPY_CLIK_DRIVE, &floppy->flags)) {
                idefloppy_create_prevent_cmd (&pc, 0);
                (void) idefloppy_queue_pc_tail (drive, &pc);
+               clear_bit(IDEFLOPPY_FORMAT_IN_PROGRESS, &floppy->flags);
        }
   }
        MOD_DEC_USE_COUNT;
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
