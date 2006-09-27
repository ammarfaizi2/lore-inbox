Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932354AbWI0OfJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932354AbWI0OfJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 10:35:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932347AbWI0OfJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 10:35:09 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:44087 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP id S932309AbWI0OfH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 10:35:07 -0400
Message-ID: <451A8C17.7010803@de.ibm.com>
Date: Wed, 27 Sep 2006 16:35:03 +0200
From: Martin Peschke <mp3@de.ibm.com>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [Patch] SCSI I/O statistics
References: <1159286194.2925.5.camel@dyn-9-152-230-71.boeblingen.de.ibm.com> <20060926103930.471b75a5.akpm@osdl.org>
In-Reply-To: <20060926103930.471b75a5.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Tue, 26 Sep 2006 17:56:33 +0200
> I've added linux-scsi.  I suspect this is somewhat of a big deal...

Oops, I didn't mean to pass them over... Thanks.

> Could you please describe these metrics in more detail, so we can have a
> better understanding of
> 
> - what they do
 >
> - what the dynamics are
 >
> - what the user interface is (eg: how does one read them, how does one reset
>   them, etc).

(Documentation/statistics.txt, -mm only so far, contains a general
description of the statistics layer used here. It describes the user
interface among other things.)


My small test system has 3 debugfs directories, one for each SCSI LUN:

[root@t2930041 statistics]# ll /sys/kernel/debug/statistics
total 0
drwxr-xr-x  2 root root 0 Aug  2 08:02 scsi-0:0:0:0
drwxr-xr-x  2 root root 0 Aug  2 08:02 scsi-0:0:0:1
drwxr-xr-x  2 root root 0 Aug  2 08:02 scsi-0:0:0:2

For each SCSI LUN, this set of statistics is provided:

[root@t2930041 statistics]# cat scsi-0\:0\:0\:0/definition
name=size_write state=released units=bytes/request type=sparse entries=256
name=size_read state=released units=bytes/request type=sparse entries=256
name=latency_write state=released units=microsec/request
   type=histogram_log2 range_min=0 entries=13 base_interval=1
name=latency_read state=released units=microsec/request
   type=histogram_log2 range_min=0 entries=13 base_interval=1
name=latency_nodata state=released units=microsec/request
   type=histogram_log2 range_min=0 entries=13 base_interval=1
name=result state=released units=flags/request type=sparse entries=256
name=queue_used_depth state=released units=requests/ type=utilisation

Statistics called size_write and size_read are about the sizes of the
data payload of SCSI commands with outbound and inbound data transfer.
Please note that these statistics reflect all SCSI commands and SCSI
command opcodes. That is, theses statistics also account for the
usually rare SCSI command opcodes among the more common SCSI READ
and WRITE commands.
By default, a histogram-like statistic, called sparse, is used to
get a list of actual request sizes and their frequency.

Statistics named latency_write, latency_read and latency_nodata provide
latencies for SCSI commands with outbound, inbound and no data transfer.
Latencies are calculated from two timestamps, one stored when the SCSI
mid layer calls the HBA driver's queuecommand function, the other stored
when the HBA driver's has called the SCSI mid layer's completion routine.
If a SCSI command is reissued by the Linux SCSI stack, i.e. for recovery
purposes, every retry is accounted for in the statistics.
By default, a histogram with logarithmic scale is used to gather data
for latency ranges, and to get more detail for fast requests.

The statistic named result provides informationon about the occurence of
SCSI command results (including SCSI Status as reported by SCSI devices).
By default, the data gathering mode called "sparse" is used, because it
shows frequencies of certain SCSI Status values, for example.

The statistic called queue_used_depth shows the utilisation (incl.
num, min, avg, max) of a SCSI device in the scope of a Linux system.
It measures the number of SCSI commands pending at the SCSI device
for this Linux system, whenever a new SCSI command is issued to the
SCSI device. The Linux SCSI stack limits the number of pending SCSI
commands (see queue_depth attribute in sysfs).


Users can start, stop, tweak etc. statistics. Please see
Documentation/statistics.txt for a complete reference.

Some basic examples:

echo name=latency_write state=on > scsi-0:0:0:1/definition
(start gathering latencies of commmands with outbount data transfer)

echo state=on > scsi-0:0:0:1/definition
(start data gathering for all statistics of LUN)

echo state=off > scsi-0:0:0:1/definition
(stop data gathering for all statistics of LUN)

echo state=released > scsi-0:0:0:1/definition
(stop statistics, if applicable, and release all memory used for
accumulating data)

echo reset > scsi-0:0:0:1/definition
(reset all statistics of LUN)

> - what the overhead is (speed, space)

Since users can tweak statistics, for example add more buckets to a
histogram to retain more detail, space requirements vary.
As a rule thumb, a statistic, if allocated (state attribute is off or
on), consumes 8 bytes per bucket and per online CPU.

For example, the latency_write histogram (13 buckets) on a 4-way system
consumes:
   round_up(13 * 8 bytes) * 4
= round_up(104 bytes) * 4
= 128 bytes * 4
= 512 bytes

We have run benchmarks with this patch, all these statistics enabled
and, for comparison, all statistics disabled.
Machine is a System z9, 8 CPUs, iozone sequential read and write on
1 up to 64 disks on a IBM DS8000 attached through 8 4Gbit FCP links.
No measurable impact on I/O thoughput. CPU cost about 2 percent.

> - Should it have been done at the block layer rather than at the scsi layer?

It's a possibilty. AFAICS we won't lose anything.

>> size_write 0x5a000 908
>> size_write 0x58000 907
>> size_write 0x62000 906
>> size_write 0x5c000 906
>> size_write 0x64000 906
>> size_write 0x5e000 901
> 
> Doesn't blktrace do this too?

One can distill all sorts of information from blktrace events,
including request sizes and latencies.

I ran blktrace. It must be a great tracing tool for optimising
request merging, queue (un)plugging etc.

But I doubt that blktrace can be the sole performance analysis tool
at customer sites, because it generates tons of data, which needs to
be handled immediately by user space tools. A trace for a single disk
can fill up another disk pretty quick. Imagine a busy server with
many devices attached and high CPU load. Who can guarantee that
tools like bltrace, blkparse and btt get the required share?
Large (per CPU and per device) relay buffers eating up kernel memory?
Side effects of storing traces to disks?
etc.

> btw, we'd more typically put the #ifdef _outside_ the
> scsi_stat_completion() implementation and provide a static inline stub if
> !CONFIG_STATISTICS.  But I guess in this modern gcc's will inline the
> funtion and will then omit it all, so it's the same thing...

Not sure. I don't mind changing it.

>>  #include <linux/workqueue.h>
>> +#include <linux/statistic.h>
>>  #include <asm/atomic.h>
>>  
>>  struct request_queue;
>> @@ -45,6 +46,17 @@ enum scsi_device_state {
>>  				 * to the scsi lld. */
>>  };
>>  
>> +enum scsi_unit_stats {
>> +	SCSI_STAT_U_SW,		/* size, write */
>> +	SCSI_STAT_U_SR,		/* size, read */
>> +	SCSI_STAT_U_LW,		/* latency, write */
>> +	SCSI_STAT_U_LR,		/* latency, read */
>> +	SCSI_STAT_U_LN,		/* latency, no data */
>> +	SCSI_STAT_U_R,		/* result */
>> +	SCSI_STAT_U_QUD,	/* queue used depth */
>> +	_SCSI_STAT_U_NUMBER,
>> +};
>> +
>>  struct scsi_device {
>>  	struct Scsi_Host *host;
>>  	struct request_queue *request_queue;
>> @@ -133,6 +145,9 @@ struct scsi_device {
>>  	atomic_t iodone_cnt;
>>  	atomic_t ioerr_cnt;
>>  
>> +	struct statistic_interface stat_if;
>> +	struct statistic	   stat[_SCSI_STAT_U_NUMBER];
>> +
>>  	int timeout;
>>  
>>  	struct device		sdev_gendev;
>> diff -urp a/include/scsi/scsi_cmnd.h b/include/scsi/scsi_cmnd.h
>> --- a/include/scsi/scsi_cmnd.h	2006-09-18 09:23:10.000000000 +0200
>> +++ b/include/scsi/scsi_cmnd.h	2006-09-18 09:54:06.000000000 +0200
>> @@ -54,6 +54,9 @@ struct scsi_cmnd {
>>  	 */
>>  	unsigned long jiffies_at_alloc;
>>  
>> +	struct timeval issued;
>> +	struct timeval received;
>> +
>>  	int retries;
>>  	int allowed;
>>  	int timeout_per_command;
>> diff -urp a/drivers/scsi/scsi_scan.c b/drivers/scsi/scsi_scan.c
>> --- a/drivers/scsi/scsi_scan.c	2006-09-18 09:23:08.000000000 +0200
>> +++ b/drivers/scsi/scsi_scan.c	2006-09-18 11:21:38.000000000 +0200
>> @@ -133,6 +133,54 @@ static void scsi_unlock_floptical(struct
>>  			 SCSI_TIMEOUT, 3);
>>  }
>>  
>> +static struct statistic_info scsi_statinfo_u[] = {
>> +	[SCSI_STAT_U_SW] = {
>> +		.name	  = "size_write",
>> +		.x_unit	  = "bytes",
>> +		.y_unit	  = "request",
>> +		.defaults = "type=sparse entries=256"
>> +	},
>> +	[SCSI_STAT_U_SR] = {
>> +		.name	  = "size_read",
>> +		.x_unit	  = "bytes",
>> +		.y_unit	  = "request",
>> +		.defaults = "type=sparse entries=256"
>> +	},
>> +	[SCSI_STAT_U_LW] = {
>> +		.name	  = "latency_write",
>> +		.x_unit	  = "microsec",
>> +		.y_unit	  = "request",
>> +		.defaults = "type=histogram_log2 entries=13 "
>> +			    "base_interval=1000 range_min=0"
>> +	},
>> +	[SCSI_STAT_U_LR] = {
>> +		.name	  = "latency_read",
>> +		.x_unit	  = "microsec",
>> +		.y_unit	  = "request",
>> +		.defaults = "type=histogram_log2 entries=13 "
>> +			    "base_interval=1000 range_min=0"
>> +	},
>> +	[SCSI_STAT_U_LN] = {
>> +		.name	  = "latency_nodata",
>> +		.x_unit	  = "microsec",
>> +		.y_unit	  = "request",
>> +		.defaults = "type=histogram_log2 entries=13 "
>> +			    "base_interval=1000 range_min=0"
>> +	},
>> +	[SCSI_STAT_U_R] = {
>> +		.name	  = "result",
>> +		.x_unit	  = "flags",
>> +		.y_unit	  = "request",
>> +		.defaults = "type=sparse entries=256"
>> +	},
>> +	[SCSI_STAT_U_QUD] = {
>> +		.name	  = "queue_used_depth",
>> +		.x_unit	  = "requests",
>> +		.y_unit   = "",
>> +		.defaults = "type=utilisation"
>> +	}
>> +};
>> +
>>  /**
>>   * scsi_alloc_sdev - allocate and setup a scsi_Device
>>   *
>> @@ -150,6 +198,7 @@ static struct scsi_device *scsi_alloc_sd
>>  	struct scsi_device *sdev;
>>  	int display_failure_msg = 1, ret;
>>  	struct Scsi_Host *shost = dev_to_shost(starget->dev.parent);
>> +	char name[64];
>>  
>>  	sdev = kzalloc(sizeof(*sdev) + shost->transportt->device_size,
>>  		       GFP_ATOMIC);
>> @@ -206,6 +255,14 @@ static struct scsi_device *scsi_alloc_sd
>>  
>>  	scsi_sysfs_device_initialize(sdev);
>>  
>> + 	sprintf(name, "scsi-%d:%d:%d:%d", sdev->host->host_no, sdev->channel,
>> + 		sdev->id, sdev->lun);
>> + 	sdev->stat_if.stat = sdev->stat;
>> + 	sdev->stat_if.info = scsi_statinfo_u;
>> + 	sdev->stat_if.number = _SCSI_STAT_U_NUMBER;
>> + 	if (statistic_create(&sdev->stat_if, name))
>> +		goto out_device_destroy;
>> +
>>  	if (shost->hostt->slave_alloc) {
>>  		ret = shost->hostt->slave_alloc(sdev);
>>  		if (ret) {
>> @@ -215,12 +272,14 @@ static struct scsi_device *scsi_alloc_sd
>>  			 */
>>  			if (ret == -ENXIO)
>>  				display_failure_msg = 0;
>> -			goto out_device_destroy;
>> +			goto out_stat_destroy;
>>  		}
>>  	}
>>  
>>  	return sdev;
>>  
>> +out_stat_destroy:
>> +	statistic_remove(&sdev->stat_if);
>>  out_device_destroy:
>>  	transport_destroy_device(&sdev->sdev_gendev);
>>  	put_device(&sdev->sdev_gendev);
>> diff -urp a/drivers/scsi/scsi_sysfs.c b/drivers/scsi/scsi_sysfs.c
>> --- a/drivers/scsi/scsi_sysfs.c	2006-09-18 09:23:08.000000000 +0200
>> +++ b/drivers/scsi/scsi_sysfs.c	2006-09-18 09:47:13.000000000 +0200
>> @@ -247,6 +247,8 @@ static void scsi_device_dev_release_user
>>  
>>  	scsi_target_reap(scsi_target(sdev));
>>  
>> +	statistic_remove(&sdev->stat_if);
>> +
>>  	kfree(sdev->inquiry);
>>  	kfree(sdev);
>>  
>> diff -urp a/drivers/scsi/scsi.c b/drivers/scsi/scsi.c
>> --- a/drivers/scsi/scsi.c	2006-09-18 09:23:08.000000000 +0200
>> +++ b/drivers/scsi/scsi.c	2006-09-18 11:04:44.000000000 +0200
>> @@ -582,6 +582,9 @@ int scsi_dispatch_cmd(struct scsi_cmnd *
>>  		cmd->result = (DID_NO_CONNECT << 16);
>>  		scsi_done(cmd);
>>  	} else {
>> +#ifdef CONFIG_STATISTICS
>> +		do_gettimeofday(&cmd->issued);
>> +#endif
>>  		rtn = host->hostt->queuecommand(cmd, scsi_done);
>>  	}
>>  	spin_unlock_irqrestore(host->host_lock, flags);
>> @@ -653,6 +656,10 @@ void __scsi_done(struct scsi_cmnd *cmd)
>>  {
>>  	struct request *rq = cmd->request;
>>  
>> +#ifdef CONFIG_STATISTICS
>> +	do_gettimeofday(&cmd->received);
>> +#endif
>> +
>>  	/*
>>  	 * Set the serial numbers back to zero
>>  	 */
>> diff -urp a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
>> --- a/drivers/scsi/scsi_lib.c	2006-09-18 09:23:08.000000000 +0200
>> +++ b/drivers/scsi/scsi_lib.c	2006-09-18 11:22:29.000000000 +0200
>> @@ -1358,6 +1358,30 @@ static void scsi_kill_request(struct req
>>  	__scsi_done(cmd);
>>  }
>>  
>> +static void scsi_stat_completion(struct scsi_cmnd *cmd)
>> +{
>> +#ifdef CONFIG_STATISTICS
>> +	struct statistic *stat = cmd->device->stat;
>> +	unsigned size = cmd->request_bufflen;
>> +	s64 issued = timeval_to_us(&cmd->issued);
>> +	s64 received = timeval_to_us(&cmd->received);
>> +	s64 latency = received - issued;
>> +	unsigned long flags;
>> +
>> +	local_irq_save(flags);
>> +	_statistic_inc(stat, SCSI_STAT_U_R, cmd->result);
>> +	if (cmd->sc_data_direction == DMA_TO_DEVICE) {
>> +		_statistic_inc(stat, SCSI_STAT_U_SW, size);
>> +		_statistic_inc(stat, SCSI_STAT_U_LW, latency);
>> +	} else if (cmd->sc_data_direction == DMA_FROM_DEVICE) {
>> +		_statistic_inc(stat, SCSI_STAT_U_SR, size);
>> +		_statistic_inc(stat, SCSI_STAT_U_LR, latency);
>> +	} else if (cmd->sc_data_direction == DMA_NONE)
>> +		_statistic_inc(stat, SCSI_STAT_U_LN, latency);
>> +	local_irq_restore(flags);
>> +#endif
>> +}
>> +
>>  static void scsi_softirq_done(struct request *rq)
>>  {
>>  	struct scsi_cmnd *cmd = rq->completion_data;
>> @@ -1376,6 +1400,7 @@ static void scsi_softirq_done(struct req
>>  	}
>>  			
>>  	scsi_log_completion(cmd, disposition);
>> +	scsi_stat_completion(cmd);
>>  
>>  	switch (disposition) {
>>  		case SUCCESS:
>> @@ -1452,6 +1477,7 @@ static void scsi_request_fn(struct reque
>>  		if (!(blk_queue_tagged(q) && !blk_queue_start_tag(q, req)))
>>  			blkdev_dequeue_request(req);
>>  		sdev->device_busy++;
>> +		statistic_inc(sdev->stat, SCSI_STAT_U_QUD, sdev->device_busy);
>>  
>>  		spin_unlock(q->queue_lock);
>>  		cmd = req->special;
>> diff -urp a/include/linux/time.h b/include/linux/time.h
>> --- a/include/linux/time.h	2006-09-18 09:23:10.000000000 +0200
>> +++ b/include/linux/time.h	2006-09-18 09:49:30.000000000 +0200
>> @@ -132,8 +132,20 @@ static inline s64 timespec_to_ns(const s
>>  }
>>  
>>  /**
>> + * timeval_to_us - Convert timeval to microseconds
>> + * @tv:		pointer to the timeval variable to be converted
>> + *
>> + * Returns the scalar nanosecond representation of the timeval
>> + * parameter.
>> + */
>> +static inline s64 timeval_to_us(const struct timeval *tv)
>> +{
>> +	return ((s64) tv->tv_sec * USEC_PER_SEC) + tv->tv_usec;
>> +}
>> +
>> +/**
>>   * timeval_to_ns - Convert timeval to nanoseconds
>> - * @ts:		pointer to the timeval variable to be converted
>> + * @tv:		pointer to the timeval variable to be converted
>>   *
>>   * Returns the scalar nanosecond representation of the timeval
>>   * parameter.
>>


