Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310318AbSCACPE>; Thu, 28 Feb 2002 21:15:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310200AbSCACNN>; Thu, 28 Feb 2002 21:13:13 -0500
Received: from host194.steeleye.com ([216.33.1.194]:9734 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S310316AbSCACId>; Thu, 28 Feb 2002 21:08:33 -0500
Message-Id: <200203010208.g2128Qq01694@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: Chris Mason <mason@suse.com>
cc: James Bottomley <James.Bottomley@SteelEye.com>,
        "Stephen C. Tweedie" <sct@redhat.com>, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH] 2.4.x write barriers (updated for ext3) 
In-Reply-To: Message from Chris Mason <mason@suse.com> 
   of "Thu, 28 Feb 2002 13:12:40 EST." <3903140000.1014919960@tiny> 
Mime-Version: 1.0
Content-Type: multipart/mixed ;
	boundary="==_Exmh_-16076857180"
Date: Thu, 28 Feb 2002 20:08:26 -0600
From: James Bottomley <James.Bottomley@SteelEye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multipart MIME message.

--==_Exmh_-16076857180
Content-Type: text/plain; charset=us-ascii

mason@suse.com said:
> So, a little testing with scsi_info shows my scsi drives do have
> writeback cache on.  great.  What's interesting is they must be doing
> additional work for ordered tags.  If they were treating the block as
> written once in cache, using the tags should not change  performance
> at all.  But, I can clearly show the tags changing performance, and
> hear the drive write pattern change when tags are on. 

I checked all mine and they're write through.  However, I inherited all my 
drives from an enterprise vendor so this might not be that surprising.

I can surmise why ordered tags kill performance on your drive, since an 
ordered tag is required to affect the ordering of the write to the medium, not 
the cache, it is probably implemented with an implicit cache flush.

Anyway, the attached patch against 2.4.18 (and I know it's rather gross code) 
will probe the cache type and try to set it to write through on boot.  See 
what this does to your performance ordinarily, and also to your tagged write 
barrier performance.

James



--==_Exmh_-16076857180
Content-Type: text/plain ; name="sd-cache.diff"; charset=us-ascii
Content-Description: sd-cache.diff
Content-Disposition: attachment; filename="sd-cache.diff"

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.166   -> 1.167  
#	   drivers/scsi/sd.c	1.18    -> 1.19   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/02/28	jejb@malley.il.steeleye.com	1.167
# changes in sd driver
# 
# Drive cache set to write back if possible.
# --------------------------------------------
#
diff -Nru a/drivers/scsi/sd.c b/drivers/scsi/sd.c
--- a/drivers/scsi/sd.c	Thu Feb 28 20:04:49 2002
+++ b/drivers/scsi/sd.c	Thu Feb 28 20:04:49 2002
@@ -741,7 +741,7 @@
 	char nbuff[6];
 	unsigned char *buffer;
 	unsigned long spintime_value = 0;
-	int the_result, retries, spintime;
+	int the_result, retries, spintime, mode_retries;
 	int sector_size;
 	Scsi_Request *SRpnt;
 
@@ -858,6 +858,105 @@
 		else
 			printk("ready\n");
 	}
+
+	mode_retries = 2;	/* make two attempts to change the cache type */
+
+ retry_mode_select:
+	retries = 3;
+	do {
+
+		memset((void *) &cmd[0], 0, 10);
+		cmd[0] = MODE_SENSE;
+		cmd[1] = (rscsi_disks[i].device->scsi_level <= SCSI_2) ?
+			 ((rscsi_disks[i].device->lun << 5) & 0xe0) : 0;
+		cmd[1] |= 0x08;	/* DBD */
+		cmd[2] = 0x08;	/* current values, cache page */
+		cmd[4] = 24;	/* allocation length */
+
+
+		memset((void *) buffer, 0, 24);
+		SRpnt->sr_cmd_len = 0;
+		SRpnt->sr_sense_buffer[0] = 0;
+		SRpnt->sr_sense_buffer[2] = 0;
+
+		SRpnt->sr_data_direction = SCSI_DATA_READ;
+		scsi_wait_req(SRpnt, (void *) cmd, (void *) buffer,
+			    24, SD_TIMEOUT, MAX_RETRIES);
+
+		the_result = SRpnt->sr_result;
+		retries--;
+
+	} while (the_result && retries);
+
+	if (the_result) {
+		printk("%s : MODE SENSE failed.\n"
+		       "%s : status = %x, message = %02x, host = %d, driver = %02x \n",
+		       nbuff, nbuff,
+		       status_byte(the_result),
+		       msg_byte(the_result),
+		       host_byte(the_result),
+		       driver_byte(the_result)
+		    );
+		if (driver_byte(the_result) & DRIVER_SENSE)
+			print_req_sense("sd", SRpnt);
+		else
+			printk("%s : sense not available. \n", nbuff);
+	} else {
+		const char *types[] = { "write through", "none", "write back", "write back, no read (daft)" };
+		int ct = 0;
+
+		ct = (buffer[6] & 0x01 /* RCD */) | ((buffer[6] & 0x04 /* WCE */) >> 1);
+
+		printk("%s : checking drive cache: %s \n", nbuff, types[ct]);
+		if(ct != 0x0 && mode_retries-- == 0) {
+			printk("%s : FAILED to change cache to write back, continuing\n", nbuff);
+		}
+		else if(ct != 0x0) {
+			retries = 3;
+			buffer[6] &= (~0x05); /* clear RCD and WCE */
+			do {
+				memset((void *) &cmd[0], 0, 10);
+				cmd[0] = MODE_SELECT;
+				cmd[1] = (rscsi_disks[i].device->scsi_level <= SCSI_2) ?
+					((rscsi_disks[i].device->lun << 5) & 0xe0) : 0;
+				cmd[1] |= 0x10;	/* PF */
+				cmd[4] = 24;	/* allocation length */
+				
+				
+				SRpnt->sr_cmd_len = 0;
+				SRpnt->sr_sense_buffer[0] = 0;
+				SRpnt->sr_sense_buffer[2] = 0;
+				
+				SRpnt->sr_data_direction = SCSI_DATA_WRITE;
+				scsi_wait_req(SRpnt, (void *) cmd, (void *) buffer,
+					      24, SD_TIMEOUT, MAX_RETRIES);
+
+				the_result = SRpnt->sr_result;
+				retries--;
+
+			} while (the_result && retries);
+
+			if (the_result) {
+				printk("%s : MODE SELECT failed.\n"
+				       "%s : status = %x, message = %02x, host = %d, driver = %02x \n",
+				       nbuff, nbuff,
+				       status_byte(the_result),
+				       msg_byte(the_result),
+				       host_byte(the_result),
+				       driver_byte(the_result)
+				       );
+				if (driver_byte(the_result) & DRIVER_SENSE)
+					print_req_sense("sd", SRpnt);
+				else
+					printk("%s : sense not available. \n", nbuff);
+			} else {
+				printk("%s : changing drive cache to write through\n", nbuff);
+			}
+			goto retry_mode_select;
+		}
+		
+	}
+
 	retries = 3;
 	do {
 		cmd[0] = READ_CAPACITY;

--==_Exmh_-16076857180--


