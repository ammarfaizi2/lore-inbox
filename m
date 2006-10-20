Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992562AbWJTHtL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992562AbWJTHtL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 03:49:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992572AbWJTHtL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 03:49:11 -0400
Received: from web31805.mail.mud.yahoo.com ([68.142.207.68]:30650 "HELO
	web31805.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S2992562AbWJTHtG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 03:49:06 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=zrliP07dCbFCkSrLU66l5WA6Vo5tqES6bhgYXVePfWaMViggMJH6/TskYlVfbmFwbjC4GN40usXUyoLHUtpD6GVUA29EOVmlt4AAenJIOj5434z/CHdVXzMDLm2PGbWGNA4PcCbwdU4Bzoa6pDCL8NCWLrPwCP1hV7DEb5G0jxU=  ;
Message-ID: <20061020074905.79740.qmail@web31805.mail.mud.yahoo.com>
Date: Fri, 20 Oct 2006 00:49:05 -0700 (PDT)
From: Luben Tuikov <ltuikov@yahoo.com>
Reply-To: ltuikov@yahoo.com
Subject: Re: [PATCH] Migrate libsas ATA code into a separate file
To: "Darrick J. Wong" <djwong@us.ibm.com>,
       linux-scsi <linux-scsi@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alexis Bruemmer <alexisb@us.ibm.com>
In-Reply-To: <4536A009.3030609@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- "Darrick J. Wong" <djwong@us.ibm.com> wrote:
> This is a respin of my earlier patch that migrates the ATA support code
> into a separate file.  For now, the controversial linking bits have
> been removed per James Bottomley's request for a patch that contains
> only the migration diffs, which means that libsas continues to require
> libata.  I intend to address that problem in a separate patch.
> 
> This patch is against the aic94xx-sas-2.6 git tree, and it has been
> sanity tested on my x206m with Seagate SATA and SAS disks without
> uncovering any new problems.
> 
> Signed-off-by: Darrick J. Wong <djwong@us.ibm.com>

It is unsettling to see how the Linux's libata "model" is overlaid
onto SAS and how SAS is made to fit into Linux's libata model.
First, libata isn't a proper SAT Layer, second, the architecture
of this, is _upside down_.

This further distances the Linux storage subsystem from being a
professional storage system, which can be relied upon in
commercial (storage) products.

It seems that the Linux storage subsystem has taken a turn to go
in a completely different direction from the SCSI Architecture Model,
and they are getting further appart, by decisions like this one.

It is not so much about just "getting the architecture right", but
it is also that if the architecture _is_ gotten right, a lot of (old)
capabilities currently missing from Linux SCSI and new ones, as they
come, would be able to be implemented without much trouble.  The reason
for this is that the SCSI Architecture Model will continue to evolve, and
implement new protocols and capabilities, but the Linux storage
system seems to be (de)evolving in opposite direction (as this
patch shows).

    Luben

> 
> --
> 
> diff --git a/drivers/scsi/libsas/Makefile b/drivers/scsi/libsas/Makefile
> index 44d972a..6383eb5 100644
> --- a/drivers/scsi/libsas/Makefile
> +++ b/drivers/scsi/libsas/Makefile
> @@ -33,4 +33,5 @@ libsas-y +=  sas_init.o     \
>  		sas_dump.o     \
>  		sas_discover.o \
>  		sas_expander.o \
> -		sas_scsi_host.o
> +		sas_scsi_host.o \
> +		sas_ata.o
> diff --git a/drivers/scsi/libsas/sas_ata.c b/drivers/scsi/libsas/sas_ata.c
> new file mode 100644
> index 0000000..de42b5b
> --- /dev/null
> +++ b/drivers/scsi/libsas/sas_ata.c
> @@ -0,0 +1,339 @@
> +/*
> + * Support for SATA devices on Serial Attached SCSI (SAS) controllers
> + *
> + * Copyright (C) 2006 IBM Corporation
> + *
> + * Written by: Darrick J. Wong <djwong@us.ibm.com>, IBM Corporation
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation; either version 2 of the
> + * License, or (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307
> + * USA
> + */
> +
> +#include <scsi/sas_ata.h>
> +#include "sas_internal.h"
> +#include <scsi/scsi_host.h>
> +#include <scsi/scsi_device.h>
> +#include <scsi/scsi_tcq.h>
> +#include <scsi/scsi.h>
> +#include <scsi/scsi_transport.h>
> +#include <scsi/scsi_transport_sas.h>
> +#include "../scsi_sas_internal.h"
> +
> +static enum ata_completion_errors sas_to_ata_err(struct task_status_struct *ts)
> +{
> +	/* Cheesy attempt to translate SAS errors into ATA.  Hah! */
> +
> +	/* transport error */
> +	if (ts->resp == SAS_TASK_UNDELIVERED)
> +		return AC_ERR_ATA_BUS;
> +
> +	/* ts->resp == SAS_TASK_COMPLETE */
> +	/* task delivered, what happened afterwards? */
> +	switch (ts->stat) {
> +		case SAS_DEV_NO_RESPONSE:
> +			return AC_ERR_TIMEOUT;
> +
> +		case SAS_INTERRUPTED:
> +		case SAS_PHY_DOWN:
> +		case SAS_NAK_R_ERR:
> +			return AC_ERR_ATA_BUS;
> +
> +
> +		case SAS_DATA_UNDERRUN:
> +			/*
> +			 * Some programs that use the taskfile interface
> +			 * (smartctl in particular) can cause underrun
> +			 * problems.  Ignore these errors, perhaps at our
> +			 * peril.
> +			 */
> +			return 0;
> +
> +		case SAS_DATA_OVERRUN:
> +		case SAS_QUEUE_FULL:
> +		case SAS_DEVICE_UNKNOWN:
> +		case SAS_SG_ERR:
> +			return AC_ERR_INVALID;
> +
> +		case SAM_CHECK_COND:
> +		case SAS_OPEN_TO:
> +		case SAS_OPEN_REJECT:
> +			SAS_DPRINTK("%s: Saw error %d.  What to do?\n",
> +				    __FUNCTION__, ts->stat);
> +			return AC_ERR_OTHER;
> +
> +		case SAS_ABORTED_TASK:
> +			return AC_ERR_DEV;
> +
> +		case SAS_PROTO_RESPONSE:
> +			/* This means the ending_fis has the error
> +			 * value; return 0 here to collect it */
> +			return 0;
> +		default:
> +			return 0;
> +	}
> +}
> +
> +static void sas_ata_task_done(struct sas_task *task)
> +{
> +	struct ata_queued_cmd *qc = task->uldd_task;
> +	struct domain_device *dev = qc->ap->private_data;
> +	struct task_status_struct *stat = &task->task_status;
> +	struct ata_task_resp *resp = (struct ata_task_resp *)stat->buf;
> +	enum ata_completion_errors ac;
> +
> +	if (stat->stat == SAS_PROTO_RESPONSE) {
> +		ata_tf_from_fis(resp->ending_fis, &dev->sata_dev.tf);
> +		qc->err_mask |= ac_err_mask(dev->sata_dev.tf.command);
> +		dev->sata_dev.sstatus = resp->sstatus;
> +		dev->sata_dev.serror = resp->serror;
> +		dev->sata_dev.scontrol = resp->scontrol;
> +		dev->sata_dev.ap->sactive = resp->sactive;
> +	} else if (stat->stat != SAM_STAT_GOOD) {
> +		ac = sas_to_ata_err(stat);
> +		if (ac) {
> +			SAS_DPRINTK("%s: SAS error %x\n", __FUNCTION__,
> +				    stat->stat);
> +			/* We saw a SAS error. Send a vague error. */
> +			qc->err_mask = ac;
> +			dev->sata_dev.tf.feature = 0x04; /* status err */
> +			dev->sata_dev.tf.command = ATA_ERR;
> +		}
> +	}
> +
> +	ata_qc_complete(qc);
> +	list_del_init(&task->list);
> +	sas_free_task(task);
> +}
> +
> +static unsigned int sas_ata_qc_issue(struct ata_queued_cmd *qc)
> +{
> +	int res = -ENOMEM;
> +	struct sas_task *task;
> +	struct domain_device *dev = qc->ap->private_data;
> +	struct sas_ha_struct *sas_ha = dev->port->ha;
> +	struct Scsi_Host *host = sas_ha->core.shost;
> +	struct sas_internal *i = to_sas_internal(host->transportt);
> +	struct scatterlist *sg;
> +	unsigned int num = 0;
> +	unsigned int xfer = 0;
> +
> +	task = sas_alloc_task(GFP_ATOMIC);
> +	if (!task)
> +		goto out;
> +	task->dev = dev;
> +	task->task_proto = SAS_PROTOCOL_STP;
> +	task->task_done = sas_ata_task_done;
> +
> +	if (qc->tf.command == ATA_CMD_FPDMA_WRITE ||
> +	    qc->tf.command == ATA_CMD_FPDMA_READ) {
> +		/* Need to zero out the tag libata assigned us */
> +		qc->tf.nsect = 0;
> +	}
> +
> +	ata_tf_to_fis(&qc->tf, (u8*)&task->ata_task.fis, 0);
> +	task->uldd_task = qc;
> +	if (is_atapi_taskfile(&qc->tf)) {
> +		memcpy(task->ata_task.atapi_packet, qc->cdb, qc->dev->cdb_len);
> +		task->total_xfer_len = qc->nbytes + qc->pad_len;
> +		task->num_scatter = qc->pad_len ? qc->n_elem + 1 : qc->n_elem;
> +	} else {
> +		ata_for_each_sg(sg, qc) {
> +			num++;
> +			xfer += sg->length;
> +		}
> +
> +		task->total_xfer_len = xfer;
> +		task->num_scatter = num;
> +	}
> +
> +	task->data_dir = qc->dma_dir;
> +	task->scatter = qc->__sg;
> +	task->ata_task.retry_count = 1;
> +	task->task_state_flags = SAS_TASK_STATE_PENDING;
> +
> +	switch (qc->tf.protocol) {
> +	case ATA_PROT_NCQ:
> +		task->ata_task.use_ncq = 1;
> +		/* fall through */
> +	case ATA_PROT_ATAPI_DMA:
> +	case ATA_PROT_DMA:
> +		task->ata_task.dma_xfer = 1;
> +		break;
> +	}
> +
> +	if (sas_ha->lldd_max_execute_num < 2)
> +		res = i->dft->lldd_execute_task(task, 1, GFP_ATOMIC);
> +	else
> +		res = sas_queue_up(task);
> +
> +	/* Examine */
> +	if (res) {
> +		SAS_DPRINTK("lldd_execute_task returned: %d\n", res);
> +
> +		sas_free_task(task);
> +		if (res == -SAS_QUEUE_FULL)
> +			return -ENOMEM;
> +	}
> +
> +out:
> +	return res;
> +}
> +
> +static u8 sas_ata_check_status(struct ata_port *ap)
> +{
> +	struct domain_device *dev = ap->private_data;
> +	return dev->sata_dev.tf.command;
> +}
> +
> +static void sas_ata_phy_reset(struct ata_port *ap)
> +{
> +	struct domain_device *dev = ap->private_data;
> +	struct sas_internal *i =
> +		to_sas_internal(dev->port->ha->core.shost->transportt);
> +	int res = 0;
> +
> +	if (i->dft->lldd_I_T_nexus_reset)
> +		res = i->dft->lldd_I_T_nexus_reset(dev);
> +
> +	if (res)
> +		SAS_DPRINTK("%s: Unable to reset I T nexus?\n", __FUNCTION__);
> +
> +	switch (dev->sata_dev.command_set) {
> +		case ATA_COMMAND_SET:
> +			SAS_DPRINTK("%s: Found ATA device.\n", __FUNCTION__);
> +			ap->device[0].class = ATA_DEV_ATA;
> +			break;
> +		case ATAPI_COMMAND_SET:
> +			SAS_DPRINTK("%s: Found ATAPI device.\n", __FUNCTION__);
> +			ap->device[0].class = ATA_DEV_ATAPI;
> +			break;
> +		default:
> +			SAS_DPRINTK("%s: Unknown SATA command set: %d.\n",
> +				    __FUNCTION__,
> +				    dev->sata_dev.command_set);
> +			ap->device[0].class = ATA_DEV_ATA;
> +			break;
> +	}
> +
> +	ap->cbl = ATA_CBL_SATA;
> +}
> +
> +static void sas_ata_post_internal(struct ata_queued_cmd *qc)
> +{
> +	if (qc->flags & ATA_QCFLAG_FAILED)
> +		qc->err_mask |= AC_ERR_OTHER;
> +
> +	if (qc->err_mask)
> +		SAS_DPRINTK("%s: Failure; reset phy!\n", __FUNCTION__);
> +}
> +
> +static void sas_ata_tf_read(struct ata_port *ap, struct ata_taskfile *tf)
> +{
> +	struct domain_device *dev = ap->private_data;
> +	memcpy(tf, &dev->sata_dev.tf, sizeof (*tf));
> +}
> +
> +static void sas_ata_scr_write(struct ata_port *ap, unsigned int sc_reg_in,
> +			      u32 val)
> +{
> +	struct domain_device *dev = ap->private_data;
> +
> +	SAS_DPRINTK("STUB %s\n", __FUNCTION__);
> +	switch (sc_reg_in) {
> +		case SCR_STATUS:
> +			dev->sata_dev.sstatus = val;
> +			break;
> +		case SCR_CONTROL:
> +			dev->sata_dev.scontrol = val;
> +			break;
> +		case SCR_ERROR:
> +			dev->sata_dev.serror = val;
> +			break;
> +		case SCR_ACTIVE:
> +			dev->sata_dev.ap->sactive = val;
> +			break;
> +	}
> +}
> +
> +static u32 sas_ata_scr_read(struct ata_port *ap, unsigned int sc_reg_in)
> +{
> +	struct domain_device *dev = ap->private_data;
> +
> +	SAS_DPRINTK("STUB %s\n", __FUNCTION__);
> +	switch (sc_reg_in) {
> +		case SCR_STATUS:
> +			return dev->sata_dev.sstatus;
> +		case SCR_CONTROL:
> +			return dev->sata_dev.scontrol;
> +		case SCR_ERROR:
> +			return dev->sata_dev.serror;
> +		case SCR_ACTIVE:
> +			return dev->sata_dev.ap->sactive;
> +		default:
> +			return 0xffffffffU;
> +	}
> +}
> +
> +static struct ata_port_operations sas_sata_ops = {
> +	.port_disable		= ata_port_disable,
> +	.check_status		= sas_ata_check_status,
> +	.check_altstatus	= sas_ata_check_status,
> +	.dev_select		= ata_noop_dev_select,
> +	.phy_reset		= sas_ata_phy_reset,
> +	.post_internal_cmd	= sas_ata_post_internal,
> +	.tf_read		= sas_ata_tf_read,
> +	.qc_prep		= ata_noop_qc_prep,
> +	.qc_issue		= sas_ata_qc_issue,
> +	.port_start		= ata_sas_port_start,
> +	.port_stop		= ata_sas_port_stop,
> +	.scr_read		= sas_ata_scr_read,
> +	.scr_write		= sas_ata_scr_write
> +};
> +
> +static struct ata_port_info sata_port_info = {
> +	.flags = ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY | ATA_FLAG_SATA_RESET |
> +		ATA_FLAG_MMIO | ATA_FLAG_PIO_DMA | ATA_FLAG_NCQ,
> +	.pio_mask = 0x1f, /* PIO0-4 */
> +	.mwdma_mask = 0x07, /* MWDMA0-2 */
> +	.udma_mask = ATA_UDMA6,
> +	.port_ops = &sas_sata_ops
> +};
> +
> +int sas_ata_init_host_and_port(struct domain_device *found_dev,
> +			       struct scsi_target *starget)
> +{
> +	struct Scsi_Host *shost = dev_to_shost(&starget->dev);
> +	struct sas_ha_struct *ha = SHOST_TO_SAS_HA(shost);
> +	struct ata_port *ap;
> +
> +	ata_host_init(&found_dev->sata_dev.ata_host,
> +		      &ha->pcidev->dev,
> +		      sata_port_info.flags,
> +		      &sas_sata_ops);
> +	ap = ata_sas_port_alloc(&found_dev->sata_dev.ata_host,
> +				&sata_port_info,
> +				shost);
> +	if (!ap) {
> +		SAS_DPRINTK("ata_sas_port_alloc failed.\n");
> +		return -ENODEV;
> +	}
> +
> +	ap->private_data = found_dev;
> +	ap->cbl = ATA_CBL_SATA;
> +	ap->scsi_host = shost;
> +	found_dev->sata_dev.ap = ap;
> +
> +	return 0;
> +}
> diff --git a/drivers/scsi/libsas/sas_scsi_host.c b/drivers/scsi/libsas/sas_scsi_host.c
> index 8c88150..349e9a7 100644
> --- a/drivers/scsi/libsas/sas_scsi_host.c
> +++ b/drivers/scsi/libsas/sas_scsi_host.c
> @@ -31,6 +31,7 @@ #include <scsi/scsi_tcq.h>
>  #include <scsi/scsi.h>
>  #include <scsi/scsi_transport.h>
>  #include <scsi/scsi_transport_sas.h>
> +#include <scsi/sas_ata.h>
>  #include "../scsi_sas_internal.h"
>  
>  #include <linux/err.h>
> @@ -166,7 +167,7 @@ static struct sas_task *sas_create_task(
>  	return task;
>  }
>  
> -static int sas_queue_up(struct sas_task *task)
> +int sas_queue_up(struct sas_task *task)
>  {
>  	struct sas_ha_struct *sas_ha = task->dev->port->ha;
>  	struct scsi_core *core = &sas_ha->core;
> @@ -186,11 +187,6 @@ static int sas_queue_up(struct sas_task 
>  	return 0;
>  }
>  
> -static inline int dev_is_sata(struct domain_device *dev)
> -{
> -	return (dev->rphy->identify.target_port_protocols & SAS_PROTOCOL_SATA);
> -}
> -
>  /**
>   * sas_queuecommand -- Enqueue a command for processing
>   * @parameters: See SCSI Core documentation
> @@ -541,93 +537,6 @@ enum scsi_eh_timer_return sas_scsi_timed
>  	return EH_NOT_HANDLED;
>  }
>  
> -
> -static enum ata_completion_errors sas_to_ata_err(struct task_status_struct *ts)
> -{
> -	/* Cheesy attempt to translate SAS errors into ATA.  Hah! */
> -
> -	/* transport error */
> -	if (ts->resp == SAS_TASK_UNDELIVERED)
> -		return AC_ERR_ATA_BUS;
> -
> -	/* ts->resp == SAS_TASK_COMPLETE */
> -	/* task delivered, what happened afterwards? */
> -	switch (ts->stat) {
> -		case SAS_DEV_NO_RESPONSE:
> -			return AC_ERR_TIMEOUT;
> -
> -		case SAS_INTERRUPTED:
> -		case SAS_PHY_DOWN:
> -		case SAS_NAK_R_ERR:
> -			return AC_ERR_ATA_BUS;
> -
> -
> -		case SAS_DATA_UNDERRUN:
> -			/*
> -			 * Some programs that use the taskfile interface
> -			 * (smartctl in particular) can cause underrun
> -			 * problems.  Ignore these errors, perhaps at our
> -			 * peril.
> -			 */
> -			return 0;
> -
> -		case SAS_DATA_OVERRUN:
> -		case SAS_QUEUE_FULL:
> -		case SAS_DEVICE_UNKNOWN:
> -		case SAS_SG_ERR:
> -			return AC_ERR_INVALID;
> -
> -		case SAM_CHECK_COND:
> -		case SAS_OPEN_TO:
> -		case SAS_OPEN_REJECT:
> -			SAS_DPRINTK("%s: Saw error %d.  What to do?\n",
> -				    __FUNCTION__, ts->stat);
> -			return AC_ERR_OTHER;
> -
> -		case SAS_ABORTED_TASK:
> -			return AC_ERR_DEV;
> -
> -		case SAS_PROTO_RESPONSE:
> -			/* This means the ending_fis has the error
> -			 * value; return 0 here to collect it */
> -			return 0;
> -		default:
> -			return 0;
> -	}
> -}
> -
> -static void sas_ata_task_done(struct sas_task *task)
> -{
> -	struct ata_queued_cmd *qc = task->uldd_task;
> -	struct domain_device *dev = qc->ap->private_data;
> -	struct task_status_struct *stat = &task->task_status;
> -	struct ata_task_resp *resp = (struct ata_task_resp *)stat->buf;
> -	enum ata_completion_errors ac;
> -
> -	if (stat->stat == SAS_PROTO_RESPONSE) {
> -		ata_tf_from_fis(resp->ending_fis, &dev->sata_dev.tf);
> -		qc->err_mask |= ac_err_mask(dev->sata_dev.tf.command);
> -		dev->sata_dev.sstatus = resp->sstatus;
> -		dev->sata_dev.serror = resp->serror;
> -		dev->sata_dev.scontrol = resp->scontrol;
> -		dev->sata_dev.ap->sactive = resp->sactive;
> -	} else if (stat->stat != SAM_STAT_GOOD) {
> -		ac = sas_to_ata_err(stat);
> -		if (ac) {
> -			SAS_DPRINTK("%s: SAS error %x\n", __FUNCTION__,
> -				    stat->stat);
> -			/* We saw a SAS error. Send a vague error. */
> -			qc->err_mask = ac;
> -			dev->sata_dev.tf.feature = 0x04; /* status err */
> -			dev->sata_dev.tf.command = ATA_ERR;
> -		}
> -	}
> -
> -	ata_qc_complete(qc);
> -	list_del_init(&task->list);
> -	sas_free_task(task);
> -}
> -
>  int sas_ioctl(struct scsi_device *sdev, int cmd, void __user *arg)
>  {
>  	struct domain_device *dev = sdev_to_domain_dev(sdev);
> @@ -638,200 +547,6 @@ int sas_ioctl(struct scsi_device *sdev, 
>  	return -EINVAL;
>  }
>  
> -static unsigned int sas_ata_qc_issue(struct ata_queued_cmd *qc)
> -{
> -	int res = -ENOMEM;
> -	struct sas_task *task;
> -	struct domain_device *dev = qc->ap->private_data;
> -	struct sas_ha_struct *sas_ha = dev->port->ha;
> -	struct Scsi_Host *host = sas_ha->core.shost;
> -	struct sas_internal *i = to_sas_internal(host->transportt);
> -	struct scatterlist *sg;
> -	unsigned int num = 0;
> -	unsigned int xfer = 0;
> -
> -	task = sas_alloc_task(GFP_ATOMIC);
> -	if (!task)
> -		goto out;
> -	task->dev = dev;
> -	task->task_proto = SAS_PROTOCOL_STP;
> -	task->task_done = sas_ata_task_done;
> -
> -	if (qc->tf.command == ATA_CMD_FPDMA_WRITE ||
> -	    qc->tf.command == ATA_CMD_FPDMA_READ) {
> -		/* Need to zero out the tag libata assigned us */
> -		qc->tf.nsect = 0;
> -	}
> -
> -	ata_tf_to_fis(&qc->tf, (u8*)&task->ata_task.fis, 0);
> -	task->uldd_task = qc;
> -	if (is_atapi_taskfile(&qc->tf)) {
> -		memcpy(task->ata_task.atapi_packet, qc->cdb, qc->dev->cdb_len);
> -		task->total_xfer_len = qc->nbytes + qc->pad_len;
> -		task->num_scatter = qc->pad_len ? qc->n_elem + 1 : qc->n_elem;
> -	} else {
> -		ata_for_each_sg(sg, qc) {
> -			num++;
> -			xfer += sg->length;
> -		}
> -
> -		task->total_xfer_len = xfer;
> -		task->num_scatter = num;
> -	}
> -
> -	task->data_dir = qc->dma_dir;
> -	task->scatter = qc->__sg;
> -	task->ata_task.retry_count = 1;
> -	task->task_state_flags = SAS_TASK_STATE_PENDING;
> -
> -	switch (qc->tf.protocol) {
> -	case ATA_PROT_NCQ:
> -		task->ata_task.use_ncq = 1;
> -		/* fall through */
> -	case ATA_PROT_ATAPI_DMA:
> -	case ATA_PROT_DMA:
> -		task->ata_task.dma_xfer = 1;
> -		break;
> -	}
> -
> -	if (sas_ha->lldd_max_execute_num < 2)
> -		res = i->dft->lldd_execute_task(task, 1, GFP_ATOMIC);
> -	else
> -		res = sas_queue_up(task);
> -
> -	/* Examine */
> -	if (res) {
> -		SAS_DPRINTK("lldd_execute_task returned: %d\n", res);
> -
> -		sas_free_task(task);
> -		if (res == -SAS_QUEUE_FULL)
> -			return -ENOMEM;
> -	}
> -
> -out:
> -	return res;
> -}
> -
> -static u8 sas_ata_check_status(struct ata_port *ap)
> -{
> -	struct domain_device *dev = ap->private_data;
> -	return dev->sata_dev.tf.command;
> -}
> -
> -static void sas_ata_phy_reset(struct ata_port *ap)
> -{
> -	struct domain_device *dev = ap->private_data;
> -	struct sas_internal *i =
> -		to_sas_internal(dev->port->ha->core.shost->transportt);
> -	int res = 0;
> -
> -	if (i->dft->lldd_I_T_nexus_reset)
> -		res = i->dft->lldd_I_T_nexus_reset(dev);
> -
> -	if (res)
> -		SAS_DPRINTK("%s: Unable to reset I T nexus?\n", __FUNCTION__);
> -
> -	switch (dev->sata_dev.command_set) {
> -		case ATA_COMMAND_SET:
> -			SAS_DPRINTK("%s: Found ATA device.\n", __FUNCTION__);
> -			ap->device[0].class = ATA_DEV_ATA;
> -			break;
> -		case ATAPI_COMMAND_SET:
> -			SAS_DPRINTK("%s: Found ATAPI device.\n", __FUNCTION__);
> -			ap->device[0].class = ATA_DEV_ATAPI;
> -			break;
> -		default:
> -			SAS_DPRINTK("%s: Unknown SATA command set: %d.\n",
> -				    __FUNCTION__,
> -				    dev->sata_dev.command_set);
> -			ap->device[0].class = ATA_DEV_ATA;
> -			break;
> -	}
> -
> -	ap->cbl = ATA_CBL_SATA;
> -}
> -
> -static void sas_ata_post_internal(struct ata_queued_cmd *qc)
> -{
> -	if (qc->flags & ATA_QCFLAG_FAILED)
> -		qc->err_mask |= AC_ERR_OTHER;
> -
> -	if (qc->err_mask)
> -		SAS_DPRINTK("%s: Failure; reset phy!\n", __FUNCTION__);
> -}
> -
> -static void sas_ata_tf_read(struct ata_port *ap, struct ata_taskfile *tf)
> -{
> -	struct domain_device *dev = ap->private_data;
> -	memcpy(tf, &dev->sata_dev.tf, sizeof (*tf));
> -}
> -
> -static void sas_ata_scr_write(struct ata_port *ap, unsigned int sc_reg_in,
> -			      u32 val)
> -{
> -	struct domain_device *dev = ap->private_data;
> -
> -	SAS_DPRINTK("STUB %s\n", __FUNCTION__);
> -	switch (sc_reg_in) {
> -		case SCR_STATUS:
> -			dev->sata_dev.sstatus = val;
> -			break;
> -		case SCR_CONTROL:
> -			dev->sata_dev.scontrol = val;
> -			break;
> -		case SCR_ERROR:
> -			dev->sata_dev.serror = val;
> -			break;
> -		case SCR_ACTIVE:
> -			dev->sata_dev.ap->sactive = val;
> -			break;
> -	}
> -}
> -
> -static u32 sas_ata_scr_read(struct ata_port *ap, unsigned int sc_reg_in)
> -{
> -	struct domain_device *dev = ap->private_data;
> -
> -	SAS_DPRINTK("STUB %s\n", __FUNCTION__);
> -	switch (sc_reg_in) {
> -		case SCR_STATUS:
> -			return dev->sata_dev.sstatus;
> -		case SCR_CONTROL:
> -			return dev->sata_dev.scontrol;
> -		case SCR_ERROR:
> -			return dev->sata_dev.serror;
> -		case SCR_ACTIVE:
> -			return dev->sata_dev.ap->sactive;
> -		default:
> -			return 0xffffffffU;
> -	}
> -}
> -
> -static struct ata_port_operations sas_sata_ops = {
> -	.port_disable		= ata_port_disable,
> -	.check_status		= sas_ata_check_status,
> -	.check_altstatus	= sas_ata_check_status,
> -	.dev_select		= ata_noop_dev_select,
> -	.phy_reset		= sas_ata_phy_reset,
> -	.post_internal_cmd	= sas_ata_post_internal,
> -	.tf_read		= sas_ata_tf_read,
> -	.qc_prep		= ata_noop_qc_prep,
> -	.qc_issue		= sas_ata_qc_issue,
> -	.port_start		= ata_sas_port_start,
> -	.port_stop		= ata_sas_port_stop,
> -	.scr_read		= sas_ata_scr_read,
> -	.scr_write		= sas_ata_scr_write
> -};
> -
> -static struct ata_port_info sata_port_info = {
> -	.flags = ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY | ATA_FLAG_SATA_RESET |
> -		ATA_FLAG_MMIO | ATA_FLAG_PIO_DMA | ATA_FLAG_NCQ,
> -	.pio_mask = 0x1f, /* PIO0-4 */
> -	.mwdma_mask = 0x07, /* MWDMA0-2 */
> -	.udma_mask = ATA_UDMA6,
> -	.port_ops = &sas_sata_ops
> -};
> -
>  struct domain_device *sas_find_dev_by_rphy(struct sas_rphy *rphy)
>  {
>  	struct Scsi_Host *shost = dev_to_shost(rphy->dev.parent);
> @@ -869,32 +584,16 @@ static inline struct domain_device *sas_
>  
>  int sas_target_alloc(struct scsi_target *starget)
>  {
> -	struct Scsi_Host *shost = dev_to_shost(&starget->dev);
> -	struct sas_ha_struct *ha = SHOST_TO_SAS_HA(shost);
>  	struct domain_device *found_dev = sas_find_target(starget);
> +	int res;
>  
>  	if (!found_dev)
>  		return -ENODEV;
>  
>  	if (dev_is_sata(found_dev)) {
> -		struct ata_port *ap;
> -
> -		ata_host_init(&found_dev->sata_dev.ata_host,
> -			      &ha->pcidev->dev,
> -			      sata_port_info.flags,
> -			      &sas_sata_ops);
> -		ap = ata_sas_port_alloc(&found_dev->sata_dev.ata_host,
> -					&sata_port_info,
> -					shost);
> -		if (!ap) {
> -			SAS_DPRINTK("ata_sas_port_alloc failed.\n");
> -			return -ENODEV;
> -		}
> -
> -		ap->private_data = found_dev;
> -		ap->cbl = ATA_CBL_SATA;
> -		ap->scsi_host = shost;
> -		found_dev->sata_dev.ap = ap;
> +		res = sas_ata_init_host_and_port(found_dev, starget);
> +		if (res)
> +			return res;
>  	}
>  
>  	starget->hostdata = found_dev;
> diff --git a/include/scsi/libsas.h b/include/scsi/libsas.h
> index 161ca8a..3704fbf 100644
> --- a/include/scsi/libsas.h
> +++ b/include/scsi/libsas.h
> @@ -600,6 +600,7 @@ struct sas_domain_function_template {
>  extern int sas_register_ha(struct sas_ha_struct *);
>  extern int sas_unregister_ha(struct sas_ha_struct *);
>  
> +int sas_queue_up(struct sas_task *task);
>  extern int sas_queuecommand(struct scsi_cmnd *,
>  		     void (*scsi_done)(struct scsi_cmnd *));
>  extern int sas_target_alloc(struct scsi_target *);
> diff --git a/include/scsi/sas_ata.h b/include/scsi/sas_ata.h
> new file mode 100644
> index 0000000..72a1904
> --- /dev/null
> +++ b/include/scsi/sas_ata.h
> @@ -0,0 +1,39 @@
> +/*
> + * Support for SATA devices on Serial Attached SCSI (SAS) controllers
> + *
> + * Copyright (C) 2006 IBM Corporation
> + *
> + * Written by: Darrick J. Wong <djwong@us.ibm.com>, IBM Corporation
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation; either version 2 of the
> + * License, or (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307
> + * USA
> + *
> + */
> +
> +#ifndef _SAS_ATA_H_
> +#define _SAS_ATA_H_
> +
> +#include <linux/libata.h>
> +#include <scsi/libsas.h>
> +
> +static inline int dev_is_sata(struct domain_device *dev)
> +{
> +	return (dev->rphy->identify.target_port_protocols & SAS_PROTOCOL_SATA);
> +}
> +
> +int sas_ata_init_host_and_port(struct domain_device *found_dev,
> +			       struct scsi_target *starget);
> +
> +#endif /* _SAS_ATA_H_ */
> -
> To unsubscribe from this list: send the line "unsubscribe linux-scsi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

