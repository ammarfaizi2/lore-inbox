Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932161AbWIZRjq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932161AbWIZRjq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 13:39:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932175AbWIZRjq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 13:39:46 -0400
Received: from smtp.osdl.org ([65.172.181.4]:54948 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932161AbWIZRjo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 13:39:44 -0400
Date: Tue, 26 Sep 2006 10:39:30 -0700
From: Andrew Morton <akpm@osdl.org>
To: Martin Peschke <mp3@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [Patch] SCSI I/O statistics
Message-Id: <20060926103930.471b75a5.akpm@osdl.org>
In-Reply-To: <1159286194.2925.5.camel@dyn-9-152-230-71.boeblingen.de.ibm.com>
References: <1159286194.2925.5.camel@dyn-9-152-230-71.boeblingen.de.ibm.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Sep 2006 17:56:33 +0200
Martin Peschke <mp3@de.ibm.com> wrote:

> Patch is against 2.6.18-mm1. Please apply.
> 
> This patch makes the SCSI mid layer report statistics data, i.e. request
> sizes, request latencies, request results and queue utilisation.
> For sample output please see below. This data is only gathered if these
> statistics have been enabled by users at run time (default is off).
> 
> It is crucial (for us) to be able to look at such kernel level data in
> case of customer situations. It allows us to determine what kind of
> requests might be involved in performance situations. This information
> helps to understand whether one faces a device issue or a Linux issue.
> Not being able to tap into performance data is regarded as a big minus
> by some enterprise customers, who are reluctant to use Linux SCSI
> support or Linux.
> 

OK, this seems to be a nice application of the new statistics layer.

> 
> 
> size_write missed 0x0
> size_write 0x1000 128631
> size_write 0xc000 4344
> size_write 0x80000 1898
> size_write 0x10000 1675
> size_write 0x1e000 1483
> size_write 0x1d000 1385
> size_write 0x2c000 1349
> size_write 0x14000 1305
> size_write 0xf000 1245
> size_write 0x2b000 1224
> size_write 0xd000 1223
> size_write 0x12000 1222
> size_write 0x11000 1198
> size_write 0x3a000 1186
> size_write 0x1c000 1182
> size_write 0x13000 1173

I've added linux-scsi.  I suspect this is somewhat of a big deal...

Could you please describe these metrics in more detail, so we can have a
better understanding of

- what they do

- what the dynamics are

- what the user interface is (eg: how does one read them, how does one reset
  them, etc).

- what the overhead is (speed, space)

- Should it have been done at the block layer rather than at the scsi layer?

> size_write 0x5a000 908
> size_write 0x58000 907
> size_write 0x62000 906
> size_write 0x5c000 906
> size_write 0x64000 906
> size_write 0x5e000 901

Doesn't blktrace do this too?

> latency_read >1024000 0
> latency_nodata <=0 0
> latency_nodata <=1000 1041
> latency_nodata <=2000 30
> latency_nodata <=4000 13
> latency_nodata <=8000 1
> latency_nodata <=16000 0
> latency_nodata <=32000 0
> latency_nodata <=64000 0
> latency_nodata <=128000 0
> latency_nodata <=256000 0
> latency_nodata <=512000 0
> latency_nodata <=1024000 0
> latency_nodata >1024000 0
> result missed 0x0
> result 0x0 1375358
> queue_used_depth 1375459 1 4.749 32 102.764
>

Patch mostly-included for reference below.

btw, we'd more typically put the #ifdef _outside_ the
scsi_stat_completion() implementation and provide a static inline stub if
!CONFIG_STATISTICS.  But I guess in this modern gcc's will inline the
funtion and will then omit it all, so it's the same thing...


> 
>  #include <linux/workqueue.h>
> +#include <linux/statistic.h>
>  #include <asm/atomic.h>
>  
>  struct request_queue;
> @@ -45,6 +46,17 @@ enum scsi_device_state {
>  				 * to the scsi lld. */
>  };
>  
> +enum scsi_unit_stats {
> +	SCSI_STAT_U_SW,		/* size, write */
> +	SCSI_STAT_U_SR,		/* size, read */
> +	SCSI_STAT_U_LW,		/* latency, write */
> +	SCSI_STAT_U_LR,		/* latency, read */
> +	SCSI_STAT_U_LN,		/* latency, no data */
> +	SCSI_STAT_U_R,		/* result */
> +	SCSI_STAT_U_QUD,	/* queue used depth */
> +	_SCSI_STAT_U_NUMBER,
> +};
> +
>  struct scsi_device {
>  	struct Scsi_Host *host;
>  	struct request_queue *request_queue;
> @@ -133,6 +145,9 @@ struct scsi_device {
>  	atomic_t iodone_cnt;
>  	atomic_t ioerr_cnt;
>  
> +	struct statistic_interface stat_if;
> +	struct statistic	   stat[_SCSI_STAT_U_NUMBER];
> +
>  	int timeout;
>  
>  	struct device		sdev_gendev;
> diff -urp a/include/scsi/scsi_cmnd.h b/include/scsi/scsi_cmnd.h
> --- a/include/scsi/scsi_cmnd.h	2006-09-18 09:23:10.000000000 +0200
> +++ b/include/scsi/scsi_cmnd.h	2006-09-18 09:54:06.000000000 +0200
> @@ -54,6 +54,9 @@ struct scsi_cmnd {
>  	 */
>  	unsigned long jiffies_at_alloc;
>  
> +	struct timeval issued;
> +	struct timeval received;
> +
>  	int retries;
>  	int allowed;
>  	int timeout_per_command;
> diff -urp a/drivers/scsi/scsi_scan.c b/drivers/scsi/scsi_scan.c
> --- a/drivers/scsi/scsi_scan.c	2006-09-18 09:23:08.000000000 +0200
> +++ b/drivers/scsi/scsi_scan.c	2006-09-18 11:21:38.000000000 +0200
> @@ -133,6 +133,54 @@ static void scsi_unlock_floptical(struct
>  			 SCSI_TIMEOUT, 3);
>  }
>  
> +static struct statistic_info scsi_statinfo_u[] = {
> +	[SCSI_STAT_U_SW] = {
> +		.name	  = "size_write",
> +		.x_unit	  = "bytes",
> +		.y_unit	  = "request",
> +		.defaults = "type=sparse entries=256"
> +	},
> +	[SCSI_STAT_U_SR] = {
> +		.name	  = "size_read",
> +		.x_unit	  = "bytes",
> +		.y_unit	  = "request",
> +		.defaults = "type=sparse entries=256"
> +	},
> +	[SCSI_STAT_U_LW] = {
> +		.name	  = "latency_write",
> +		.x_unit	  = "microsec",
> +		.y_unit	  = "request",
> +		.defaults = "type=histogram_log2 entries=13 "
> +			    "base_interval=1000 range_min=0"
> +	},
> +	[SCSI_STAT_U_LR] = {
> +		.name	  = "latency_read",
> +		.x_unit	  = "microsec",
> +		.y_unit	  = "request",
> +		.defaults = "type=histogram_log2 entries=13 "
> +			    "base_interval=1000 range_min=0"
> +	},
> +	[SCSI_STAT_U_LN] = {
> +		.name	  = "latency_nodata",
> +		.x_unit	  = "microsec",
> +		.y_unit	  = "request",
> +		.defaults = "type=histogram_log2 entries=13 "
> +			    "base_interval=1000 range_min=0"
> +	},
> +	[SCSI_STAT_U_R] = {
> +		.name	  = "result",
> +		.x_unit	  = "flags",
> +		.y_unit	  = "request",
> +		.defaults = "type=sparse entries=256"
> +	},
> +	[SCSI_STAT_U_QUD] = {
> +		.name	  = "queue_used_depth",
> +		.x_unit	  = "requests",
> +		.y_unit   = "",
> +		.defaults = "type=utilisation"
> +	}
> +};
> +
>  /**
>   * scsi_alloc_sdev - allocate and setup a scsi_Device
>   *
> @@ -150,6 +198,7 @@ static struct scsi_device *scsi_alloc_sd
>  	struct scsi_device *sdev;
>  	int display_failure_msg = 1, ret;
>  	struct Scsi_Host *shost = dev_to_shost(starget->dev.parent);
> +	char name[64];
>  
>  	sdev = kzalloc(sizeof(*sdev) + shost->transportt->device_size,
>  		       GFP_ATOMIC);
> @@ -206,6 +255,14 @@ static struct scsi_device *scsi_alloc_sd
>  
>  	scsi_sysfs_device_initialize(sdev);
>  
> + 	sprintf(name, "scsi-%d:%d:%d:%d", sdev->host->host_no, sdev->channel,
> + 		sdev->id, sdev->lun);
> + 	sdev->stat_if.stat = sdev->stat;
> + 	sdev->stat_if.info = scsi_statinfo_u;
> + 	sdev->stat_if.number = _SCSI_STAT_U_NUMBER;
> + 	if (statistic_create(&sdev->stat_if, name))
> +		goto out_device_destroy;
> +
>  	if (shost->hostt->slave_alloc) {
>  		ret = shost->hostt->slave_alloc(sdev);
>  		if (ret) {
> @@ -215,12 +272,14 @@ static struct scsi_device *scsi_alloc_sd
>  			 */
>  			if (ret == -ENXIO)
>  				display_failure_msg = 0;
> -			goto out_device_destroy;
> +			goto out_stat_destroy;
>  		}
>  	}
>  
>  	return sdev;
>  
> +out_stat_destroy:
> +	statistic_remove(&sdev->stat_if);
>  out_device_destroy:
>  	transport_destroy_device(&sdev->sdev_gendev);
>  	put_device(&sdev->sdev_gendev);
> diff -urp a/drivers/scsi/scsi_sysfs.c b/drivers/scsi/scsi_sysfs.c
> --- a/drivers/scsi/scsi_sysfs.c	2006-09-18 09:23:08.000000000 +0200
> +++ b/drivers/scsi/scsi_sysfs.c	2006-09-18 09:47:13.000000000 +0200
> @@ -247,6 +247,8 @@ static void scsi_device_dev_release_user
>  
>  	scsi_target_reap(scsi_target(sdev));
>  
> +	statistic_remove(&sdev->stat_if);
> +
>  	kfree(sdev->inquiry);
>  	kfree(sdev);
>  
> diff -urp a/drivers/scsi/scsi.c b/drivers/scsi/scsi.c
> --- a/drivers/scsi/scsi.c	2006-09-18 09:23:08.000000000 +0200
> +++ b/drivers/scsi/scsi.c	2006-09-18 11:04:44.000000000 +0200
> @@ -582,6 +582,9 @@ int scsi_dispatch_cmd(struct scsi_cmnd *
>  		cmd->result = (DID_NO_CONNECT << 16);
>  		scsi_done(cmd);
>  	} else {
> +#ifdef CONFIG_STATISTICS
> +		do_gettimeofday(&cmd->issued);
> +#endif
>  		rtn = host->hostt->queuecommand(cmd, scsi_done);
>  	}
>  	spin_unlock_irqrestore(host->host_lock, flags);
> @@ -653,6 +656,10 @@ void __scsi_done(struct scsi_cmnd *cmd)
>  {
>  	struct request *rq = cmd->request;
>  
> +#ifdef CONFIG_STATISTICS
> +	do_gettimeofday(&cmd->received);
> +#endif
> +
>  	/*
>  	 * Set the serial numbers back to zero
>  	 */
> diff -urp a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
> --- a/drivers/scsi/scsi_lib.c	2006-09-18 09:23:08.000000000 +0200
> +++ b/drivers/scsi/scsi_lib.c	2006-09-18 11:22:29.000000000 +0200
> @@ -1358,6 +1358,30 @@ static void scsi_kill_request(struct req
>  	__scsi_done(cmd);
>  }
>  
> +static void scsi_stat_completion(struct scsi_cmnd *cmd)
> +{
> +#ifdef CONFIG_STATISTICS
> +	struct statistic *stat = cmd->device->stat;
> +	unsigned size = cmd->request_bufflen;
> +	s64 issued = timeval_to_us(&cmd->issued);
> +	s64 received = timeval_to_us(&cmd->received);
> +	s64 latency = received - issued;
> +	unsigned long flags;
> +
> +	local_irq_save(flags);
> +	_statistic_inc(stat, SCSI_STAT_U_R, cmd->result);
> +	if (cmd->sc_data_direction == DMA_TO_DEVICE) {
> +		_statistic_inc(stat, SCSI_STAT_U_SW, size);
> +		_statistic_inc(stat, SCSI_STAT_U_LW, latency);
> +	} else if (cmd->sc_data_direction == DMA_FROM_DEVICE) {
> +		_statistic_inc(stat, SCSI_STAT_U_SR, size);
> +		_statistic_inc(stat, SCSI_STAT_U_LR, latency);
> +	} else if (cmd->sc_data_direction == DMA_NONE)
> +		_statistic_inc(stat, SCSI_STAT_U_LN, latency);
> +	local_irq_restore(flags);
> +#endif
> +}
> +
>  static void scsi_softirq_done(struct request *rq)
>  {
>  	struct scsi_cmnd *cmd = rq->completion_data;
> @@ -1376,6 +1400,7 @@ static void scsi_softirq_done(struct req
>  	}
>  			
>  	scsi_log_completion(cmd, disposition);
> +	scsi_stat_completion(cmd);
>  
>  	switch (disposition) {
>  		case SUCCESS:
> @@ -1452,6 +1477,7 @@ static void scsi_request_fn(struct reque
>  		if (!(blk_queue_tagged(q) && !blk_queue_start_tag(q, req)))
>  			blkdev_dequeue_request(req);
>  		sdev->device_busy++;
> +		statistic_inc(sdev->stat, SCSI_STAT_U_QUD, sdev->device_busy);
>  
>  		spin_unlock(q->queue_lock);
>  		cmd = req->special;
> diff -urp a/include/linux/time.h b/include/linux/time.h
> --- a/include/linux/time.h	2006-09-18 09:23:10.000000000 +0200
> +++ b/include/linux/time.h	2006-09-18 09:49:30.000000000 +0200
> @@ -132,8 +132,20 @@ static inline s64 timespec_to_ns(const s
>  }
>  
>  /**
> + * timeval_to_us - Convert timeval to microseconds
> + * @tv:		pointer to the timeval variable to be converted
> + *
> + * Returns the scalar nanosecond representation of the timeval
> + * parameter.
> + */
> +static inline s64 timeval_to_us(const struct timeval *tv)
> +{
> +	return ((s64) tv->tv_sec * USEC_PER_SEC) + tv->tv_usec;
> +}
> +
> +/**
>   * timeval_to_ns - Convert timeval to nanoseconds
> - * @ts:		pointer to the timeval variable to be converted
> + * @tv:		pointer to the timeval variable to be converted
>   *
>   * Returns the scalar nanosecond representation of the timeval
>   * parameter.
> 
