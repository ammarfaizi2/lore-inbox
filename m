Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261225AbULHOJg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261225AbULHOJg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 09:09:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261221AbULHOJg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 09:09:36 -0500
Received: from linux.us.dell.com ([143.166.224.162]:225 "EHLO
	lists.us.dell.com") by vger.kernel.org with ESMTP id S261220AbULHOJP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 09:09:15 -0500
Date: Wed, 8 Dec 2004 08:07:55 -0600
From: Matt Domsch <Matt_Domsch@dell.com>
To: "Bagalkote, Sreenivas" <sreenib@lsil.com>
Cc: "'brking@us.ibm.com'" <brking@us.ibm.com>,
       "'James Bottomley'" <James.Bottomley@SteelEye.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>,
       "'bunk@fs.tum.de'" <bunk@fs.tum.de>, "'Andrew Morton'" <akpm@osdl.org>,
       "Ju, Seokmann" <sju@lsil.com>, "Doelfel, Hardy" <hdoelfel@lsil.com>,
       "Mukker, Atul" <Atulm@lsil.com>
Subject: Re: How to add/drop SCSI drives from within the driver?
Message-ID: <20041208140755.GA24779@lists.us.dell.com>
References: <0E3FA95632D6D047BA649F95DAB60E570230CA8C@exa-atlanta>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0E3FA95632D6D047BA649F95DAB60E570230CA8C@exa-atlanta>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 08, 2004 at 02:16:24AM -0500, Bagalkote, Sreenivas wrote:
> To this end, we are requesting to be allowed to add a small IOCTL to the
> driver that returns the HCTL for an LD.

I've looked into solving this another way, but I cannot see how to get
this driver-private mapping of logical drive number -> HCTL without
putting code something like this into the driver.  It's a figment of
how logical drives are projected as actual drives by the driver, and
by providing a mapping function to userspace, the driver is free to
change its mapping algorithm in the future if necessary without
breaking userspace management apps that relied on a set mapping
strategy.  Megaraid has changed their mapping strategy before (logical
drives used to be projected on channels 0..N, 16 drives per channel,
with physical non-disk devices projected on channels N+1..M.  It now
projects them as physical devices on channels 0..N (N=number of
physical channels on the controller {1,2,4} so far), and the logical
drives all on channel N+1.


>  Our strong case is really the "Adding a drive" case. Somebody may
> suggest that an application can blindly scan all channels and all
> targets on a host when it adds one drive. That would _not_ be
> correct thing to do. Application should ideally scan only the drives
> that it has added.

I'm less worried about the add case then about the remove case.
Blindly removing devices, then adding them back in, as the 'scanbus'
script widely available on the internet does, is a recipe for
disaster, frought with race conditions on 2.4 kernels (races between
sg_open() and scsi-remove-single-device, and between
scsi-add-single-device and scsi-remove-single-device, just to name
two), and outright dangerous on 2.6 (you can remove an in-use device
such as your boot disk if you use the /proc interface as root).

> --- old-rc2/drivers/scsi/megaraid/megaraid_ioctl.h	2004-12-07
> 16:40:16.000000000 -0500
> +++ new-rc2/drivers/scsi/megaraid/megaraid_ioctl.h	2004-12-07
> 23:57:51.415674008 -0500
> @@ -217,6 +219,27 @@
>  
>  } __attribute__ ((packed)) mcontroller_t;
>  
> +/**
> + * ld_device_address_t	: SCSI device address for the logical drives
> + * 
> + * @host_no		: host# to which LD belogs; as understood by
> mid-layer
> + * @channel		: channel on which LD is exported
> + * @target		: target on which the LD is exported
> + * @lun			: lun on which the LD is exported
> + * @ld			: the LD for which this information is sought
> + * @reserved		: reserved fields; must be set to zero
> + *
> + * NOTE			: Applications set the LD number and expect
> the 
> + * 			  SCSI address to be returned in the first four
> fields
> + */
> +typedef struct {

Please don't typedef structs, especially not one that's 32 bytes long.   

> +	uint32_t	host_no;

__u32 is the preferred type when sharing such with userspace.

> +	uint32_t	channel;
> +	uint32_t	scsi_id;
> +	uint32_t	lun;
> +	uint32_t	ld;
> +	uint32_t	reserved[3];

Why pad this out?

> +} ld_device_address_t;

I would also suggest __attribute__((packed)) since you're sharing with
userspace just to ensure you can never get it grown by the compiler
(it shouldn't be, but just to be safe).

Also, as I believe you intend to add some form of INQUIRY Page 81
unique ID to your firmware sets at some point, perhaps this is the
logical place to export such information too.  This would then match
SCSI_IOCTL_GET_IDLUN in concept.  

> --- old-rc2/drivers/scsi/megaraid/megaraid_mbox.c	2004-12-07
> 16:40:16.000000000 -0500
> +++ new-rc2/drivers/scsi/megaraid/megaraid_mbox.c	2004-12-08
> 01:29:39.420330024 -0500
> @@ -3642,6 +3642,7 @@
>  megaraid_mbox_mm_handler(unsigned long drvr_data, uioc_t *kioc, uint32_t
> action)
>  {
>  	adapter_t *adapter;
> +	ld_device_address_t* lda;

this will be struct ld_device_address *lda of course.

> +	case GET_LD_SADDR:

Trivial: I prefer cases which are >10 lines to be moved out-of-line
into a static inline function, for readability.

> +		
> +		lda = (ld_device_address_t*)(unsigned long)kioc->buf_vaddr;
> +
> +		if ((lda->ld < 0) || (lda->ld > MAX_LOGICAL_DRIVES_40LD)) {

It's a __u32, it can't be < 0 (and the compiler should have warned at
that).  Why MAX_LOGICAL_DRIVES_40LD and not MAX_LOGICAL_DRIVES_64LD
(which strangely is defined as 65) which is used elsewhere in the
driver for such mapping?

> +		lda->scsi_id	= (lda->ld < adapter->init_id) ? 
> +						lda->ld : lda->ld + 1;

Ahh, you project an initiator onto the logical drive channel, at
init_id, yes?  That wasn't obvious to me at first, is it necessary to
do so?  There's no real SCSI bus contention issue, and you can't
address the initiator directly.  (again, the driver does this today,
and such a change would need to be reflected in this routine


The rest seems sane to me.

Thanks,
Matt


-- 
Matt Domsch
Sr. Software Engineer, Lead Engineer
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com
