Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315611AbSETBPb>; Sun, 19 May 2002 21:15:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315614AbSETBP3>; Sun, 19 May 2002 21:15:29 -0400
Received: from panda.sul.com.br ([200.219.150.4]:60168 "EHLO ns.sul.com.br")
	by vger.kernel.org with ESMTP id <S315611AbSETBPW>;
	Sun, 19 May 2002 21:15:22 -0400
Date: Sun, 19 May 2002 13:12:32 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>,
        "Leonard N.Zubkoff" <lnz@dandelion.com>, arrays@compaq.com,
        "Grant R.Guenther" <grant@torque.net>, paulus@au.ibm.com,
        "Joshua M.Thompson" <funaho@jurai.org>
Cc: Rusty Russell <rusty@rustcorp.com.au>,
        Linux Kernel Janitors Project 
	<kernel-janitor-discuss@lists.sourceforge.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [BKPATCH] drivers/block/*.c copy_{to,from}_user error handling fix
Message-ID: <20020519161232.GA6129@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Linus Torvalds <torvalds@transmeta.com>,
	Leonard N.Zubkoff <lnz@dandelion.com>, arrays@compaq.com,
	Grant R.Guenther <grant@torque.net>, paulus@au.ibm.com,
	Joshua M.Thompson <funaho@jurai.org>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Linux Kernel Janitors Project <kernel-janitor-discuss@lists.sourceforge.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

	Please consider pulling it from:

http://kernel-acme.bkbits.net:8080/block-copy_tofrom_user-2.5

- Arnaldo

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.568   -> 1.569  
#	drivers/block/swim_iop.c	1.6     -> 1.7    
#	drivers/block/cpqarray.c	1.33    -> 1.34   
#	drivers/block/paride/pt.c	1.8     -> 1.9    
#	drivers/block/paride/pg.c	1.7     -> 1.8    
#	drivers/block/swim3.c	1.8     -> 1.9    
#	  drivers/block/rd.c	1.35    -> 1.36   
#	drivers/block/DAC960.c	1.26    -> 1.27   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/05/19	acme@conectiva.com.br	1.569
# drivers/block/*.c
# 
#   - fix copy_{to,from}_user error handling, thanks to Rusty for
#     pointing this out on lkml
# --------------------------------------------
#
diff -Nru a/drivers/block/DAC960.c b/drivers/block/DAC960.c
--- a/drivers/block/DAC960.c	Sun May 19 22:03:33 2002
+++ b/drivers/block/DAC960.c	Sun May 19 22:03:33 2002
@@ -5473,9 +5473,11 @@
 	int ControllerNumber, DataTransferLength;
 	unsigned char *DataTransferBuffer = NULL;
 	if (UserSpaceUserCommand == NULL) return -EINVAL;
-	ErrorCode = copy_from_user(&UserCommand, UserSpaceUserCommand,
-				   sizeof(DAC960_V1_UserCommand_T));
-	if (ErrorCode != 0) goto Failure1;
+	if (copy_from_user(&UserCommand, UserSpaceUserCommand,
+				   sizeof(DAC960_V1_UserCommand_T))) {
+		ErrorCode = -EFAULT;
+		goto Failure1;
+	}
 	ControllerNumber = UserCommand.ControllerNumber;
 	if (ControllerNumber < 0 ||
 	    ControllerNumber > DAC960_ControllerCount - 1)
@@ -5488,9 +5490,11 @@
 	if (CommandOpcode & 0x80) return -EINVAL;
 	if (CommandOpcode == DAC960_V1_DCDB)
 	  {
-	    ErrorCode =
-	      copy_from_user(&DCDB, UserCommand.DCDB, sizeof(DAC960_V1_DCDB_T));
-	    if (ErrorCode != 0) goto Failure1;
+	    if (copy_from_user(&DCDB, UserCommand.DCDB,
+			       sizeof(DAC960_V1_DCDB_T))) {
+		ErrorCode = -EFAULT;
+		goto Failure1;
+	    }
 	    if (DCDB.Channel >= DAC960_V1_MaxChannels) return -EINVAL;
 	    if (!((DataTransferLength == 0 &&
 		   DCDB.Direction
@@ -5516,10 +5520,12 @@
 	  {
 	    DataTransferBuffer = kmalloc(-DataTransferLength, GFP_KERNEL);
 	    if (DataTransferBuffer == NULL) return -ENOMEM;
-	    ErrorCode = copy_from_user(DataTransferBuffer,
-				       UserCommand.DataTransferBuffer,
-				       -DataTransferLength);
-	    if (ErrorCode != 0) goto Failure1;
+	    if (copy_from_user(DataTransferBuffer,
+			       UserCommand.DataTransferBuffer,
+			       -DataTransferLength)) {
+		ErrorCode = -EFAULT;
+		goto Failure1;
+	    }
 	  }
 	if (CommandOpcode == DAC960_V1_DCDB)
 	  {
@@ -5567,17 +5573,21 @@
 	DAC960_ReleaseControllerLock(Controller, &ProcessorFlags);
 	if (DataTransferLength > 0)
 	  {
-	    ErrorCode = copy_to_user(UserCommand.DataTransferBuffer,
-				     DataTransferBuffer, DataTransferLength);
-	    if (ErrorCode != 0) goto Failure1;
+	    if (copy_to_user(UserCommand.DataTransferBuffer,
+			     DataTransferBuffer, DataTransferLength))
+		ErrorCode = -EFAULT;
+		goto Failure1;
+	  }
 	  }
 	if (CommandOpcode == DAC960_V1_DCDB)
 	  {
 	    Controller->V1.DirectCommandActive[DCDB.Channel]
 					      [DCDB.TargetID] = false;
-	    ErrorCode =
-	      copy_to_user(UserCommand.DCDB, &DCDB, sizeof(DAC960_V1_DCDB_T));
-	    if (ErrorCode != 0) goto Failure1;
+	    if (copy_to_user(UserCommand.DCDB, &DCDB,
+			     sizeof(DAC960_V1_DCDB_T))) {
+		ErrorCode = -EFAULT;
+		goto Failure1;
+	    }
 	  }
 	ErrorCode = CommandStatus;
       Failure1:
@@ -5600,9 +5610,11 @@
 	unsigned char *DataTransferBuffer = NULL;
 	unsigned char *RequestSenseBuffer = NULL;
 	if (UserSpaceUserCommand == NULL) return -EINVAL;
-	ErrorCode = copy_from_user(&UserCommand, UserSpaceUserCommand,
-				   sizeof(DAC960_V2_UserCommand_T));
-	if (ErrorCode != 0) goto Failure2;
+	if (copy_from_user(&UserCommand, UserSpaceUserCommand,
+			   sizeof(DAC960_V2_UserCommand_T))) {
+		ErrorCode = -EFAULT;
+		goto Failure2;
+	}
 	ControllerNumber = UserCommand.ControllerNumber;
 	if (ControllerNumber < 0 ||
 	    ControllerNumber > DAC960_ControllerCount - 1)
@@ -5621,10 +5633,12 @@
 	  {
 	    DataTransferBuffer = kmalloc(-DataTransferLength, GFP_KERNEL);
 	    if (DataTransferBuffer == NULL) return -ENOMEM;
-	    ErrorCode = copy_from_user(DataTransferBuffer,
-				       UserCommand.DataTransferBuffer,
-				       -DataTransferLength);
-	    if (ErrorCode != 0) goto Failure2;
+	    if (copy_from_user(DataTransferBuffer,
+			       UserCommand.DataTransferBuffer,
+			       -DataTransferLength)) {
+		ErrorCode = -EFAULT;
+		goto Failure2;
+	    }
 	  }
 	RequestSenseLength = UserCommand.RequestSenseLength;
 	if (RequestSenseLength > 0)
@@ -5694,25 +5708,32 @@
 	DAC960_ReleaseControllerLock(Controller, &ProcessorFlags);
 	if (RequestSenseLength > UserCommand.RequestSenseLength)
 	  RequestSenseLength = UserCommand.RequestSenseLength;
-	ErrorCode = copy_to_user(&UserSpaceUserCommand->DataTransferLength,
+	if (copy_to_user(&UserSpaceUserCommand->DataTransferLength,
 				 &DataTransferResidue,
-				 sizeof(DataTransferResidue));
-	if (ErrorCode != 0) goto Failure2;
-	ErrorCode = copy_to_user(&UserSpaceUserCommand->RequestSenseLength,
-				 &RequestSenseLength,
-				 sizeof(RequestSenseLength));
-	if (ErrorCode != 0) goto Failure2;
+				 sizeof(DataTransferResidue))) {
+		ErrorCode = -EFAULT;
+		goto Failure2;
+	}
+	if (copy_to_user(&UserSpaceUserCommand->RequestSenseLength,
+			 &RequestSenseLength, sizeof(RequestSenseLength))) {
+		ErrorCode = -EFAULT;
+		goto Failure2;
+	}
 	if (DataTransferLength > 0)
 	  {
-	    ErrorCode = copy_to_user(UserCommand.DataTransferBuffer,
-				     DataTransferBuffer, DataTransferLength);
-	    if (ErrorCode != 0) goto Failure2;
+	    if (copy_to_user(UserCommand.DataTransferBuffer,
+			     DataTransferBuffer, DataTransferLength)) {
+		ErrorCode = -EFAULT;
+		goto Failure2;
+	    }
 	  }
 	if (RequestSenseLength > 0)
 	  {
-	    ErrorCode = copy_to_user(UserCommand.RequestSenseBuffer,
-				     RequestSenseBuffer, RequestSenseLength);
-	    if (ErrorCode != 0) goto Failure2;
+	    if (copy_to_user(UserCommand.RequestSenseBuffer,
+			     RequestSenseBuffer, RequestSenseLength)) {
+		ErrorCode = -EFAULT;
+		goto Failure2;
+	    }
 	  }
 	ErrorCode = CommandStatus;
       Failure2:
@@ -5731,9 +5752,9 @@
 	DAC960_Controller_T *Controller;
 	int ControllerNumber;
 	if (UserSpaceGetHealthStatus == NULL) return -EINVAL;
-	ErrorCode = copy_from_user(&GetHealthStatus, UserSpaceGetHealthStatus,
-				   sizeof(DAC960_V2_GetHealthStatus_T));
-	if (ErrorCode != 0) return ErrorCode;
+	if (copy_from_user(&GetHealthStatus, UserSpaceGetHealthStatus,
+			   sizeof(DAC960_V2_GetHealthStatus_T)))
+		return -EFAULT;
 	ControllerNumber = GetHealthStatus.ControllerNumber;
 	if (ControllerNumber < 0 ||
 	    ControllerNumber > DAC960_ControllerCount - 1)
@@ -5741,10 +5762,10 @@
 	Controller = DAC960_Controllers[ControllerNumber];
 	if (Controller == NULL) return -ENXIO;
 	if (Controller->FirmwareType != DAC960_V2_Controller) return -EINVAL;
-	ErrorCode = copy_from_user(&HealthStatusBuffer,
-				   GetHealthStatus.HealthStatusBuffer,
-				   sizeof(DAC960_V2_HealthStatusBuffer_T));
-	if (ErrorCode != 0) return ErrorCode;
+	if (copy_from_user(&HealthStatusBuffer,
+			   GetHealthStatus.HealthStatusBuffer,
+			   sizeof(DAC960_V2_HealthStatusBuffer_T)))
+		return -EFAULT;
 	while (Controller->V2.HealthStatusBuffer->StatusChangeCounter
 	       == HealthStatusBuffer.StatusChangeCounter &&
 	       Controller->V2.HealthStatusBuffer->NextEventSequenceNumber
@@ -5754,10 +5775,11 @@
 					   DAC960_MonitoringTimerInterval);
 	    if (signal_pending(current)) return -EINTR;
 	  }
-	ErrorCode = copy_to_user(GetHealthStatus.HealthStatusBuffer,
-				 Controller->V2.HealthStatusBuffer,
-				 sizeof(DAC960_V2_HealthStatusBuffer_T));
-	return ErrorCode;
+	if (copy_to_user(GetHealthStatus.HealthStatusBuffer,
+			 Controller->V2.HealthStatusBuffer,
+			 sizeof(DAC960_V2_HealthStatusBuffer_T)))
+		return -EFAULT;
+	return 0;
       }
     }
   return -EINVAL;
diff -Nru a/drivers/block/cpqarray.c b/drivers/block/cpqarray.c
--- a/drivers/block/cpqarray.c	Sun May 19 22:03:33 2002
+++ b/drivers/block/cpqarray.c	Sun May 19 22:03:33 2002
@@ -1117,17 +1117,19 @@
 		put_user(get_start_sect(inode->i_rdev), &geo->start);
 		return 0;
 	case IDAGETDRVINFO:
-		return copy_to_user(&io->c.drv,&hba[ctlr]->drv[dsk],sizeof(drv_info_t));
+		if (copy_to_user(&io->c.drv, &hba[ctlr]->drv[dsk],
+				 sizeof(drv_info_t)))
+			return -EFAULT;
+		return 0;
 	case BLKRRPART:
 		return revalidate_logvol(inode->i_rdev, 1);
 	case IDAPASSTHRU:
 		if (!capable(CAP_SYS_RAWIO)) return -EPERM;
-		error = copy_from_user(&my_io, io, sizeof(my_io));
-		if (error) return error;
+		if (copy_from_user(&my_io, io, sizeof(my_io)))
+			return -EFAULT;
 		error = ida_ctlr_ioctl(ctlr, dsk, &my_io);
 		if (error) return error;
-		error = copy_to_user(io, &my_io, sizeof(my_io));
-		return error;
+		return copy_to_user(io, &my_io, sizeof(my_io)) ? -EFAULT : 0;
 	case IDAGETCTLRSIG:
 		if (!arg) return -EINVAL;
 		put_user(hba[ctlr]->ctlr_sig, (int*)arg);
@@ -1208,7 +1210,11 @@
 			cmd_free(h, c, 0); 
 			return(error);
 		}
-		copy_from_user(p, (void*)io->sg[0].addr, io->sg[0].size);
+		if (copy_from_user(p, (void*)io->sg[0].addr, io->sg[0].size)) {
+			kfree(p);
+			cmd_free(h, c, 0); 
+			return -EFAULT;
+		}
 		c->req.hdr.blk = pci_map_single(h->pci_dev, &(io->c), 
 				sizeof(ida_ioctl_t), 
 				PCI_DMA_BIDIRECTIONAL);
@@ -1245,7 +1251,11 @@
                         cmd_free(h, c, 0);
                         return(error);
                 }
-		copy_from_user(p, (void*)io->sg[0].addr, io->sg[0].size);
+		if (copy_from_user(p, (void*)io->sg[0].addr, io->sg[0].size)) {
+			kfree(p);
+                        cmd_free(h, c, 0);
+			return -EFAULT;
+		}
 		c->req.sg[0].size = io->sg[0].size;
 		c->req.sg[0].addr = pci_map_single(h->pci_dev, p, 
 			c->req.sg[0].size, PCI_DMA_BIDIRECTIONAL); 
@@ -1282,7 +1292,10 @@
 	case DIAG_PASS_THRU:
 	case SENSE_CONTROLLER_PERFORMANCE:
 	case READ_FLASH_ROM:
-		copy_to_user((void*)io->sg[0].addr, p, io->sg[0].size);
+		if (copy_to_user((void*)io->sg[0].addr, p, io->sg[0].size)) {
+			kfree(p);
+			return -EFAULT;
+		}
 		/* fall through and free p */
 	case IDA_WRITE:
 	case IDA_WRITE_MEDIA:
diff -Nru a/drivers/block/paride/pg.c b/drivers/block/paride/pg.c
--- a/drivers/block/paride/pg.c	Sun May 19 22:03:33 2002
+++ b/drivers/block/paride/pg.c	Sun May 19 22:03:33 2002
@@ -623,7 +623,8 @@
 	if (PG.busy) return -EBUSY;
 	if (count < hs) return -EINVAL;
 	
-	copy_from_user((char *)&hdr,buf,hs);
+	if (copy_from_user((char *)&hdr, buf, hs))
+		return -EFAULT;
 
 	if (hdr.magic != PG_MAGIC) return -EINVAL;
 	if (hdr.dlen > PG_MAX_DATA) return -EINVAL;
@@ -647,8 +648,8 @@
 
 	PG.busy = 1;
 
-	copy_from_user(PG.bufptr,buf+hs,count-hs);
-
+	if (copy_from_user(PG.bufptr, buf + hs, count - hs))
+		return -EFAULT;
 	return count;
 }
 
@@ -682,9 +683,11 @@
 	hdr.duration = (jiffies - PG.start + HZ/2) / HZ;
 	hdr.scsi = PG.status & 0x0f;
 
-	copy_to_user(buf,(char *)&hdr,hs);
-	if (copy > 0) copy_to_user(buf+hs,PG.bufptr,copy);
-	
+	if (copy_to_user(buf, (char *)&hdr, hs))
+		return -EFAULT;
+	if (copy > 0)
+		if (copy_to_user(buf+hs,PG.bufptr,copy))
+			return -EFAULT;
 	return copy+hs;
 }
 
diff -Nru a/drivers/block/paride/pt.c b/drivers/block/paride/pt.c
--- a/drivers/block/paride/pt.c	Sun May 19 22:03:33 2002
+++ b/drivers/block/paride/pt.c	Sun May 19 22:03:33 2002
@@ -860,7 +860,10 @@
 		    n -= k;
 		    b = k;
 		    if (b > count) b = count;
-		    copy_to_user(buf+t,PT.bufptr,b);
+		    if (copy_to_user(buf + t, PT.bufptr, b)) {
+	    		pi_disconnect(PI);
+			return -EFAULT;
+		    }
 		    t += b;
 		    count -= b;
 	        }
@@ -944,7 +947,10 @@
 		    if (k > PT_BUFSIZE) k = PT_BUFSIZE;
 		    b = k;
 		    if (b > count) b = count;
-		    copy_from_user(PT.bufptr,buf+t,b);
+		    if (copy_from_user(PT.bufptr, buf + t, b)) {
+			pi_disconnect(PI);
+			return -EFAULT;
+		    }
                     pi_write_block(PI,PT.bufptr,k);
 		    t += b;
 		    count -= b;
diff -Nru a/drivers/block/rd.c b/drivers/block/rd.c
--- a/drivers/block/rd.c	Sun May 19 22:03:33 2002
+++ b/drivers/block/rd.c	Sun May 19 22:03:33 2002
@@ -318,7 +318,8 @@
 	left = initrd_end - initrd_start - *ppos;
 	if (count > left) count = left;
 	if (count == 0) return 0;
-	copy_to_user(buf, (char *)initrd_start + *ppos, count);
+	if (copy_to_user(buf, (char *)initrd_start + *ppos, count))
+		return -EFAULT;
 	*ppos += count;
 	return count;
 }
diff -Nru a/drivers/block/swim3.c b/drivers/block/swim3.c
--- a/drivers/block/swim3.c	Sun May 19 22:03:33 2002
+++ b/drivers/block/swim3.c	Sun May 19 22:03:33 2002
@@ -840,9 +840,10 @@
 		err = fd_eject(fs);
 		return err;
 	case FDGETPRM:
-	        err = copy_to_user((void *) param, (void *) &floppy_type,
-				   sizeof(struct floppy_struct));
-		return err;
+	        if (copy_to_user((void *) param, (void *)&floppy_type,
+				 sizeof(struct floppy_struct)))
+			return -EFAULT;
+		return 0;
 	}
 	return -ENOTTY;
 }
diff -Nru a/drivers/block/swim_iop.c b/drivers/block/swim_iop.c
--- a/drivers/block/swim_iop.c	Sun May 19 22:03:33 2002
+++ b/drivers/block/swim_iop.c	Sun May 19 22:03:33 2002
@@ -360,9 +360,10 @@
 		err = swimiop_eject(fs);
 		return err;
 	case FDGETPRM:
-	        err = copy_to_user((void *) param, (void *) &floppy_type,
-				   sizeof(struct floppy_struct));
-		return err;
+	        if (copy_to_user((void *) param, (void *) &floppy_type,
+				 sizeof(struct floppy_struct)))
+			return -EFAULT;
+		return 0;
 	}
 	return -ENOTTY;
 }
