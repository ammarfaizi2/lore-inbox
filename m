Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136020AbRD0NUZ>; Fri, 27 Apr 2001 09:20:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136033AbRD0NUL>; Fri, 27 Apr 2001 09:20:11 -0400
Received: from zcamail04.zca.compaq.com ([161.114.32.104]:33540 "HELO
	zcamail04.zca.compaq.com") by vger.kernel.org with SMTP
	id <S136025AbRD0NTI>; Fri, 27 Apr 2001 09:19:08 -0400
Message-ID: <6B180991CB19D31183E40000F86AF80E037EBD0C@broexc2.bro.dec.com>
From: "Roets, Chris" <Chris.Roets@compaq.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Linux Cluster using shared scsi
Date: Fri, 27 Apr 2001 14:18:40 +0100
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Problem :
> install two Linux-system with a shared scsi-bus and storage on that shared
> bus.
> suppose :
> system one : SCSI ID 7
> system two : SCSI ID 6
> shared disk : SCSI ID 4
> 
> By default, you can mount the disk on both system.  This is normal
> behavior, but
> may impose data corruption.
> To prevent this, you can SCSI-reserve a disk on one system.  If the other
> system
> would try to access this device, the system should return an i/o error due
> to the reservation.
> This is a common technique used in
> - Traditional Tru64 Unix ase clustering
> - Tr64 Unix V5 Clustering to accomplish i/o barriers
> - Windows-NT Clusters
> - Steel-eye clustering
> The reservation can be done using a standard tool like scu
> 
> scu -f /dev/sdb
> scu > reserve device
> 
> On Linux, this works fine under Kernel version 2.2.16.
> Below is the code that accomplish this
> /usr/src/linux/drivers/scsi/scsi_obsolete.c in routine scsi_old_done
>             case RESERVATION_CONFLICT:
>                 printk("scsi%d (%d,%d,%d) : RESERVATION CONFLICT\n",
>                        SCpnt->host->host_no, SCpnt->channel,
>                        SCpnt->device->id, SCpnt->device->lun);
>                 status = CMD_FINISHED; /* returns I/O error */
>                 break;
>             default:
> As of kernel version 2.2.18, this code has changed, If a scsi reserve
> error
> occurs, the device driver does a scsi reset.  This way the scsi
> reservation is
> gone, and the device can be accessed.
> /usr/src/linux/drivers/scsi/scsi_obsolete.c in routine scsi_old_done 
>             case RESERVATION_CONFLICT:
>                 printk("scsi%d, channel %d : RESERVATION CONFLICT
> performing"
>                        " reset.\n", SCpnt->host->host_no, SCpnt->channel);
>                 scsi_reset(SCpnt, SCSI_RESET_SYNCHRONOUS);
>                 status = REDO;
>                 break;
> 
> Fix : delete the scsi reset in the kernel code
>             case RESERVATION_CONFLICT:
> /* Deleted Chris Roets
>                 printk("scsi%d, channel %d : RESERVATION CONFLICT
> performing"
>                        " reset.\n", SCpnt->host->host_no, SCpnt->channel);
>                 scsi_reset(SCpnt, SCSI_RESET_SYNCHRONOUS);
>                 status = REDO;
> next four lines added */
>                 printk("scsi%d (%d,%d,%d) : RESERVATION CONFLICT\n",
>                        SCpnt->host->host_no, SCpnt->channel,
>                        SCpnt->device->id, SCpnt->device->lun);
>                 status = CMD_FINISHED; /* returns I/O error */
>                 break;
> 
> and rebuild the kernel.
> 
> This should get the customer being able to continue
> 
	Questions  :
> - why  is this scsi reset done/added as of kernel version 2.2.18
> - as we are talking about an obsolete routine, how is this accomplished 
>  in the new code and how is it activated.  
> 
> 
> Chris
