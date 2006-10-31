Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422726AbWJaHxL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422726AbWJaHxL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 02:53:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422732AbWJaHxL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 02:53:11 -0500
Received: from web31805.mail.mud.yahoo.com ([68.142.207.68]:22915 "HELO
	web31805.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1422726AbWJaHxJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 02:53:09 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=KmvlLZrFX19ag6YPNjf4RTnFgNJnmOlNaJRFS9FiKq+BAT+RwgeOKNKTvCZozRblEkT4vUQJWfFntG03JOPmMhbVv0bzjQeltCyIXk1AFwlfXBtWp18eOEFizW+iDtYH2T/RX87SFTKpum3KQUYOqEdpi37mlElF3TK97aNrlc4=  ;
X-YMail-OSG: 2UYuzzkVM1nv_vY4XhNcwu6FKQ9rMAp1GjhAl8PtOWgi_mFbQ7U61skXTLnsYHOXAth_dHNDEHa6iw_XsP61wfKuwMuAFcqZk7UePpt6qTJham0mBpJlpMPQ5gYL9FXoTMQZ7pZHyYk-
Date: Mon, 30 Oct 2006 23:53:08 -0800 (PST)
From: Luben Tuikov <ltuikov@yahoo.com>
Reply-To: ltuikov@yahoo.com
Subject: Re: [PATCH] 3/3: Handle REQ_TASK_ABORT in aic94xx
To: "Darrick J. Wong" <djwong@us.ibm.com>,
       linux-scsi <linux-scsi@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Alexis Bruemmer <alexisb@us.ibm.com>
In-Reply-To: <45468860.5060103@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-ID: <355151.48546.qm@web31805.mail.mud.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- "Darrick J. Wong" <djwong@us.ibm.com> wrote:
> This patch straightens out the code that distinguishes the various escb
> opcodes in escb_tasklet_complete so that they can be handled correctly. 
> It also provides all the necessary code to create a workqueue item that
> tells libsas to abort a sas_task.
> 
> Signed-off-by: Darrick J. Wong <djwong@us.ibm.com>
> 
> --
> 
> diff --git a/drivers/scsi/aic94xx/aic94xx_scb.c b/drivers/scsi/aic94xx/aic94xx_scb.c
> index 7ee49b5..1911c5d 100644
> --- a/drivers/scsi/aic94xx/aic94xx_scb.c
> +++ b/drivers/scsi/aic94xx/aic94xx_scb.c
> @@ -25,6 +25,7 @@
>   */
>  
>  #include <linux/pci.h>
> +#include <scsi/scsi_host.h>
>  
>  #include "aic94xx.h"
>  #include "aic94xx_reg.h"
> @@ -342,6 +343,18 @@ void asd_invalidate_edb(struct asd_ascb 
>  	}
>  }
>  
> +/* start up the ABORT TASK tmf... */
> +static void task_kill_later(struct asd_ascb *ascb)
> +{
> +	struct asd_ha_struct *asd_ha = ascb->ha;
> +	struct sas_ha_struct *sas_ha = &asd_ha->sas_ha;
> +	struct Scsi_Host *shost = sas_ha->core.shost;
> +	struct sas_task *task = ascb->uldd_task;
> +
> +	INIT_WORK(&task->abort_work, (void (*)(void *))sas_task_abort, task);
> +	queue_work(shost->work_q, &task->abort_work);
> +}
> +
>  static void escb_tasklet_complete(struct asd_ascb *ascb,
>  				  struct done_list_struct *dl)
>  {
> @@ -368,6 +381,58 @@ static void escb_tasklet_complete(struct
>  			    ascb->scb->header.opcode);
>  	}
>  
> +	/* Catch these before we mask off the sb_opcode bits */
> +	switch (sb_opcode) {
> +	case REQ_TASK_ABORT: {
> +		struct asd_ascb *a, *b;
> +		u16 tc_abort;
> +
> +		tc_abort = *((u16*)(&dl->status_block[1]));
> +		tc_abort = le16_to_cpu(tc_abort);
> +
> +		ASD_DPRINTK("%s: REQ_TASK_ABORT, reason=0x%X\n",
> +			    __FUNCTION__, dl->status_block[3]);
> +
> +		/* Find the pending task and abort it. */
> +		list_for_each_entry_safe(a, b, &asd_ha->seq.pend_q, list)
> +			if (a->tc_index == tc_abort) {
> +				task_kill_later(a);
> +				break;
> +			}
> +		goto out;
> +	}
> +	case REQ_DEVICE_RESET: {
> +		struct asd_ascb *a, *b;
> +		u16 conn_handle;
> +
> +		conn_handle = *((u16*)(&dl->status_block[1]));
> +		conn_handle = le16_to_cpu(conn_handle);
> +
> +		ASD_DPRINTK("%s: REQ_DEVICE_RESET, reason=0x%X\n", __FUNCTION__,
> +			    dl->status_block[3]);
> +
> +		/* Kill all pending tasks and reset the device */
> +		list_for_each_entry_safe(a, b, &asd_ha->seq.pend_q, list) {
> +			struct sas_task *task = a->uldd_task;
> +			struct domain_device *dev = task->dev;
> +			u16 x;
> +
> +			x = *((u16*)(&dev->lldd_dev));
> +			if (x == conn_handle)
> +				task_kill_later(a);
> +		}
> +
> +		/* FIXME: Reset device port (huh?) */
> +		goto out;

"huh?" -- LOL, that's a very funny comment.

Good luck!
   Luben

> +	}
> +	case SIGNAL_NCQ_ERROR:
> +		ASD_DPRINTK("%s: SIGNAL_NCQ_ERROR\n", __FUNCTION__);
> +		goto out;
> +	case CLEAR_NCQ_ERROR:
> +		ASD_DPRINTK("%s: CLEAR_NCQ_ERROR\n", __FUNCTION__);
> +		goto out;
> +	}
> +
>  	sb_opcode &= ~DL_PHY_MASK;
>  
>  	switch (sb_opcode) {
> @@ -397,22 +462,6 @@ static void escb_tasklet_complete(struct
>  		sas_phy_disconnected(sas_phy);
>  		sas_ha->notify_port_event(sas_phy, PORTE_TIMER_EVENT);
>  		break;
> -	case REQ_TASK_ABORT:
> -		ASD_DPRINTK("%s: phy%d: REQ_TASK_ABORT\n", __FUNCTION__,
> -			    phy_id);
> -		break;
> -	case REQ_DEVICE_RESET:
> -		ASD_DPRINTK("%s: phy%d: REQ_DEVICE_RESET\n", __FUNCTION__,
> -			    phy_id);
> -		break;
> -	case SIGNAL_NCQ_ERROR:
> -		ASD_DPRINTK("%s: phy%d: SIGNAL_NCQ_ERROR\n", __FUNCTION__,
> -			    phy_id);
> -		break;
> -	case CLEAR_NCQ_ERROR:
> -		ASD_DPRINTK("%s: phy%d: CLEAR_NCQ_ERROR\n", __FUNCTION__,
> -			    phy_id);
> -		break;
>  	default:
>  		ASD_DPRINTK("%s: phy%d: unknown event:0x%x\n", __FUNCTION__,
>  			    phy_id, sb_opcode);
> @@ -432,7 +481,7 @@ static void escb_tasklet_complete(struct
>  
>  		break;
>  	}
> -
> +out:
>  	asd_invalidate_edb(ascb, edb);
>  }
>  
> -
> To unsubscribe from this list: send the line "unsubscribe linux-scsi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

