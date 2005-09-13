Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932276AbVIMUXw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932276AbVIMUXw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 16:23:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932314AbVIMUXv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 16:23:51 -0400
Received: from magic.adaptec.com ([216.52.22.17]:17812 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S932276AbVIMUXu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 16:23:50 -0400
Message-ID: <4327354E.7090409@adaptec.com>
Date: Tue, 13 Sep 2005 16:23:42 -0400
From: Luben Tuikov <luben_tuikov@adaptec.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: James Bottomley <James.Bottomley@SteelEye.com>
CC: Patrick Mansfield <patmans@us.ibm.com>, Douglas Gilbert <dougg@torque.net>,
       Christoph Hellwig <hch@infradead.org>, Luben Tuikov <ltuikov@yahoo.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH 2.6.13 5/14] sas-class: sas_discover.c Discover process
 (end devices)
References: <1126308304.4799.45.camel@mulgrave>	 <20050910024454.20602.qmail@web51613.mail.yahoo.com>	 <20050911094656.GC5429@infradead.org> <43251D8C.7020409@torque.net>	 <1126537041.4825.28.camel@mulgrave> <20050912164548.GB11455@us.ibm.com>	 <1126545680.4825.40.camel@mulgrave>  <20050912184629.GA13489@us.ibm.com> <1126639342.4809.53.camel@mulgrave>
In-Reply-To: <1126639342.4809.53.camel@mulgrave>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 13 Sep 2005 20:23:48.0782 (UTC) FILETIME=[0C6FB4E0:01C5B8A1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/13/05 15:22, James Bottomley wrote:
> On Mon, 2005-09-12 at 11:46 -0700, Patrick Mansfield wrote:
> 
>>Though we still have problems with scsi_report_lun_scan code like:
>>
>>                } else if (lun > sdev->host->max_lun) {
>>
>>max_lun just has to be large, at least greater than 0xc001 (49153), maybe
>>even 0xffffffff, correct?
>>
>>But then some sequential scanning could take a while. Maybe the above
>>check is not needed.
> 
> 
> Try this as a straw horse for doing full u64 luns.

James, this patch is wrong.

A SCSI LUN is not "u64 lun", it has never been and it will
never be.

A SCSI LUN is "u8 LUN[8]" -- it is this from the Application
Layer down to the _transport layer_ (if you cared to look at
_any_ LL transport).

(It is also capitalized since it is an abbreviation.)

To compare/print it, please use, as shown at the top of the
file "sas.h":

(be64_to_cpu(*(__be64 *)(_x)))

where _x is only the "LUN" of the definition above.

If you want to print it, please use "%016llx".

It also appears that you've never compiled your patch on
x86_64.

Alternatively, you can take a look at the SAS Layer.

	Luben

> 
> I've converted all the mid-layer and the ULDs; I ran out of steam at the
> lld's.
> 
> This should work transparently for all luns up to 255 (using
> representation 00b), so I've limited all of our sequential LUN scans to
> 255
> 
> This actually boots ... but I don't have a system with >1 LUN currently.
> 
> James

[cut]

> diff --git a/include/scsi/scsi_device.h b/include/scsi/scsi_device.h
> --- a/include/scsi/scsi_device.h
> +++ b/include/scsi/scsi_device.h
> @@ -66,7 +66,8 @@ struct scsi_device {
>  					   jiffie count on our counter, they
>  					   could all be from the same event. */
>  
> -	unsigned int id, lun, channel;
> +	unsigned int id, channel;
> +	u64 lun;
>  
>  	unsigned int manufacturer;	/* Manufacturer of device, for using 
>  					 * vendor-specific cmd's */
> @@ -179,20 +180,20 @@ static inline struct scsi_target *scsi_t
>  extern struct scsi_device *__scsi_add_device(struct Scsi_Host *,
>  		uint, uint, uint, void *hostdata);
>  extern int scsi_add_device(struct Scsi_Host *host, uint channel,
> -			   uint target, uint lun);
> +			   uint target, u64 lun);
>  extern void scsi_remove_device(struct scsi_device *);
>  extern int scsi_device_cancel(struct scsi_device *, int);
>  
>  extern int scsi_device_get(struct scsi_device *);
>  extern void scsi_device_put(struct scsi_device *);
>  extern struct scsi_device *scsi_device_lookup(struct Scsi_Host *,
> -					      uint, uint, uint);
> +					      uint, uint, u64);
>  extern struct scsi_device *__scsi_device_lookup(struct Scsi_Host *,
> -						uint, uint, uint);
> +						uint, uint, u64);
>  extern struct scsi_device *scsi_device_lookup_by_target(struct scsi_target *,
> -							uint);
> +							u64);
>  extern struct scsi_device *__scsi_device_lookup_by_target(struct scsi_target *,
> -							  uint);
> +							  u64);
>  extern void starget_for_each_device(struct scsi_target *, void *,
>  		     void (*fn)(struct scsi_device *, void *));
>  
> @@ -248,12 +249,13 @@ extern void scsi_device_resume(struct sc
>  extern void scsi_target_quiesce(struct scsi_target *);
>  extern void scsi_target_resume(struct scsi_target *);
>  extern void scsi_scan_target(struct device *parent, unsigned int channel,
> -			     unsigned int id, unsigned int lun, int rescan);
> +			     unsigned int id, u64 lun, int rescan);
>  extern void scsi_target_reap(struct scsi_target *);
>  extern void scsi_target_block(struct device *);
>  extern void scsi_target_unblock(struct device *);
>  extern void scsi_remove_target(struct device *);
> -extern void int_to_scsilun(unsigned int, struct scsi_lun *);
> +extern void int_to_scsilun(u64, struct scsi_lun *);
> +extern u64 scsilun_to_int(struct scsi_lun *);
>  extern const char *scsi_device_state_name(enum scsi_device_state);
>  extern int scsi_is_sdev_device(const struct device *);
>  extern int scsi_is_target_device(const struct device *);
> diff --git a/include/scsi/scsi_host.h b/include/scsi/scsi_host.h
> --- a/include/scsi/scsi_host.h
> +++ b/include/scsi/scsi_host.h
> @@ -494,7 +494,10 @@ struct Scsi_Host {
>  	 * or lun (i.e. 8 for normal systems).
>  	 */
>  	unsigned int max_id;
> -	unsigned int max_lun;
> +	#define SCSI_UNLIMITED_LUNS	(0xffffffffffffffffULL)
> +	/* Any luns beyond 255 *require* report luns to find */
> +	#define SCSI_SCAN_LIMIT_LUNS	256
> +	u64 max_lun;
>  	unsigned int max_channel;
>  
>  	/*
> 
> 
> 

