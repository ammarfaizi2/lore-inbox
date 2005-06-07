Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261319AbVFGB7U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261319AbVFGB7U (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 21:59:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261318AbVFGB7K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 21:59:10 -0400
Received: from zproxy.gmail.com ([64.233.162.200]:32734 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261241AbVFGB6c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 21:58:32 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=ikAS3vlqPwQJETy+4U6YKbAmp5+UwvQqmKxHVCf2sgiPA2j6YEQ9OTjMdPeNXM2Qk4JWrrz7HpnTkPXIAMLBZzUPGzN2CualCMocomCK74yowU2PpDRduAcvCHx4Z9IFjWdDfaWXdsJrYMLx8P0iuRnQd3pRBPUlGX90eBLRxy4=
Message-ID: <42A4FF41.4050302@gmail.com>
Date: Tue, 07 Jun 2005 10:58:25 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050402)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: axboe@suse.de, James.Bottomley@steeleye.com, bzolnier@gmail.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH Linux 2.6.12-rc5-mm2 06/09] blk: update SCSI to use the
 new blk_ordered
References: <20050605055337.6301E65A@htj.dyndns.org> <20050605055337.3CC8625A@htj.dyndns.org> <42A2A507.8060600@pobox.com>
In-Reply-To: <42A2A507.8060600@pobox.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  Hi, Jeff.

Jeff Garzik wrote:
> Tejun Heo wrote:
> 
>> 06_blk_update_scsi_to_use_new_ordered.patch
>>
>>     All ordered request related stuff delegated to HLD.  Midlayer
>>     now doens't deal with ordered setting or prepare_flush
>>     callback.  sd.c updated to deal with blk_queue_ordered
>>     setting.  Currently, ordered tag isn't used as SCSI midlayer
>>     cannot guarantee request ordering.
>>
>> Signed-off-by: Tejun Heo <htejun@gmail.com>
>>
>>  drivers/scsi/hosts.c       |    9 -----
>>  drivers/scsi/scsi_lib.c    |   46 --------------------------
>>  drivers/scsi/sd.c          |   79 
>> +++++++++++++++++++--------------------------
>>  include/scsi/scsi_driver.h |    1  include/scsi/scsi_host.h   |    1 
>>  5 files changed, 34 insertions(+), 102 deletions(-)
>>
>> Index: blk-fixes/drivers/scsi/sd.c
>> ===================================================================
>> --- blk-fixes.orig/drivers/scsi/sd.c    2005-06-05 14:53:32.000000000 
>> +0900
>> +++ blk-fixes/drivers/scsi/sd.c    2005-06-05 14:53:35.000000000 +0900
>> @@ -103,6 +103,7 @@ struct scsi_disk {
>>      u8        write_prot;
>>      unsigned    WCE : 1;    /* state of disk WCE bit */
>>      unsigned    RCD : 1;    /* state of disk RCD bit, unused */
>> +    unsigned    DPOFUA : 1;    /* state of disk DPOFUA bit */
>>  };
>>  
>>  static DEFINE_IDR(sd_index_idr);
>> @@ -122,8 +123,7 @@ static void sd_shutdown(struct device *d
>>  static void sd_rescan(struct device *);
>>  static int sd_init_command(struct scsi_cmnd *);
>>  static int sd_issue_flush(struct device *, sector_t *);
>> -static void sd_end_flush(request_queue_t *, struct request *);
>> -static int sd_prepare_flush(request_queue_t *, struct request *);
>> +static void sd_prepare_flush(request_queue_t *, struct request *);
>>  static void sd_read_capacity(struct scsi_disk *sdkp, char *diskname,
>>           struct scsi_request *SRpnt, unsigned char *buffer);
>>  
>> @@ -138,8 +138,6 @@ static struct scsi_driver sd_template =      
>> .rescan            = sd_rescan,
>>      .init_command        = sd_init_command,
>>      .issue_flush        = sd_issue_flush,
>> -    .prepare_flush        = sd_prepare_flush,
>> -    .end_flush        = sd_end_flush,
>>  };
>>  
>>  /*
>> @@ -346,6 +344,7 @@ static int sd_init_command(struct scsi_c
>>     
>>      if (block > 0xffffffff) {
>>          SCpnt->cmnd[0] += READ_16 - READ_6;
>> +        SCpnt->cmnd[1] |= blk_fua_rq(rq) ? 0x8 : 0;
>>          SCpnt->cmnd[2] = sizeof(block) > 4 ? (unsigned char) (block 
>> >> 56) & 0xff : 0;
>>          SCpnt->cmnd[3] = sizeof(block) > 4 ? (unsigned char) (block 
>> >> 48) & 0xff : 0;
>>          SCpnt->cmnd[4] = sizeof(block) > 4 ? (unsigned char) (block 
>> >> 40) & 0xff : 0;
>> @@ -360,11 +359,12 @@ static int sd_init_command(struct scsi_c
>>          SCpnt->cmnd[13] = (unsigned char) this_count & 0xff;
>>          SCpnt->cmnd[14] = SCpnt->cmnd[15] = 0;
>>      } else if ((this_count > 0xff) || (block > 0x1fffff) ||
>> -           SCpnt->device->use_10_for_rw) {
>> +           SCpnt->device->use_10_for_rw || blk_fua_rq(rq)) {
> 
> 
> This seems suspicious, like it would cause unwanted use of READ(10) for 
> some devices that prefer READ(6) ?
> 

  As READ/WRITE(6) doesn't have FUA field, we have to use WRITE(10) or 
WRITE(16) on FUA writes.  Above addition affects only FUA writes (no 
effect on READs or normal WRITEs).

  FUA write requests are generated only when a device reports DPOFUA 
capability during sd attach, and only READ/WRITE(>=10) have FUA field, 
so I think it's logical to assume that devices which report DPOFUA 
support READ/WRITE(10).

  Also, currently all SCSI disks default to READ/WRITE(10) and 
use_10_for_rw is turned off only when READ/WRITE(10) fails w/ 
ILLEGAL_REQUEST.  So, the assumption is that devices are at least 
capable of properly terminating READ/WRITE(10)s with ILLEGAL REQUEST 
when it doesn't like'em (thus turning off FUA).

  Hmmm... Do you think I should add more tests before enabling FUA such 
that we know WRITE(10) is supported (capacity test comes to mind).

> 
>>          if (this_count > 0xffff)
>>              this_count = 0xffff;
>>  
>>          SCpnt->cmnd[0] += READ_10 - READ_6;
>> +        SCpnt->cmnd[1] |= blk_fua_rq(rq) ? 0x8 : 0;
>>          SCpnt->cmnd[2] = (unsigned char) (block >> 24) & 0xff;
>>          SCpnt->cmnd[3] = (unsigned char) (block >> 16) & 0xff;
>>          SCpnt->cmnd[4] = (unsigned char) (block >> 8) & 0xff;
>> @@ -739,43 +739,12 @@ static int sd_issue_flush(struct device      
>> return sd_sync_cache(sdp);
>>  }
>>  
>> -static void sd_end_flush(request_queue_t *q, struct request *flush_rq)
>> +static void sd_prepare_flush(request_queue_t *q, struct request *rq)
>>  {
>> -    struct request *rq = flush_rq->end_io_data;
>> -    struct scsi_cmnd *cmd = rq->special;
>> -    unsigned int bytes = rq->hard_nr_sectors << 9;
>> -
>> -    if (!flush_rq->errors) {
>> -        spin_unlock(q->queue_lock);
>> -        scsi_io_completion(cmd, bytes, 0);
>> -        spin_lock(q->queue_lock);
>> -    } else if (blk_barrier_postflush(rq)) {
>> -        spin_unlock(q->queue_lock);
>> -        scsi_io_completion(cmd, 0, bytes);
>> -        spin_lock(q->queue_lock);
>> -    } else {
>> -        /*
>> -         * force journal abort of barriers
>> -         */
>> -        end_that_request_first(rq, -EOPNOTSUPP, rq->hard_nr_sectors);
>> -        end_that_request_last(rq, -EOPNOTSUPP);
>> -    }
>> -}
>> -
>> -static int sd_prepare_flush(request_queue_t *q, struct request *rq)
>> -{
>> -    struct scsi_device *sdev = q->queuedata;
>> -    struct scsi_disk *sdkp = dev_get_drvdata(&sdev->sdev_gendev);
>> -
>> -    if (sdkp->WCE) {
>> -        memset(rq->cmd, 0, sizeof(rq->cmd));
>> -        rq->flags |= REQ_BLOCK_PC | REQ_SOFTBARRIER;
>> -        rq->timeout = SD_TIMEOUT;
>> -        rq->cmd[0] = SYNCHRONIZE_CACHE;
>> -        return 1;
>> -    }
>> -
>> -    return 0;
>> +    memset(rq->cmd, 0, sizeof(rq->cmd));
>> +    rq->flags |= REQ_BLOCK_PC | REQ_SOFTBARRIER;
>> +    rq->timeout = SD_TIMEOUT;
>> +    rq->cmd[0] = SYNCHRONIZE_CACHE;
>>  }
>>  
>>  static void sd_rescan(struct device *dev)
>> @@ -1433,10 +1402,13 @@ sd_read_cache_type(struct scsi_disk *sdk
>>              sdkp->RCD = 0;
>>          }
>>  
>> +        sdkp->DPOFUA = (data.device_specific & 0x10) != 0;
>> +
>>          ct =  sdkp->RCD + 2*sdkp->WCE;
>>  
>> -        printk(KERN_NOTICE "SCSI device %s: drive cache: %s\n",
>> -               diskname, types[ct]);
>> +        printk(KERN_NOTICE "SCSI device %s: drive cache: %s%s\n",
>> +               diskname, types[ct],
>> +               sdkp->DPOFUA ? " with forced unit access" : "");
> 
> 
> This is IMO a bit verbose.  Just " w/ FUA" might be better.
> 

  Sure.

> 
>>          return;
>>      }
>> @@ -1469,6 +1441,7 @@ static int sd_revalidate_disk(struct gen
>>      struct scsi_device *sdp = sdkp->device;
>>      struct scsi_request *sreq;
>>      unsigned char *buffer;
>> +    unsigned ordered;
>>  
>>      SCSI_LOG_HLQUEUE(3, printk("sd_revalidate_disk: disk=%s\n", 
>> disk->disk_name));
>>  
>> @@ -1514,7 +1487,22 @@ static int sd_revalidate_disk(struct gen
>>                      sreq, buffer);
>>          sd_read_cache_type(sdkp, disk->disk_name, sreq, buffer);
>>      }
>> -       
>> +
>> +    /*
>> +     * We now have all cache related info, determine how we deal
>> +     * with ordered requests.  Note that as the current SCSI
>> +     * dispatch function can alter request order, we cannot use
>> +     * QUEUE_ORDERED_TAG_* even when ordered tag is supported.
>> +     */
>> +    if (sdkp->WCE)
>> +        ordered = sdkp->DPOFUA
>> +            ? QUEUE_ORDERED_DRAIN_FUA : QUEUE_ORDERED_DRAIN_FLUSH;
> 
> 
> Certainly 'DPO and FUA' implies we have FUA, but I wonder if this test 
> is unnecessarily narrow.

  Meaning...?

-- 
tejun
