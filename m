Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261248AbULHPIB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261248AbULHPIB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 10:08:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261244AbULHPHv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 10:07:51 -0500
Received: from mail0.lsil.com ([147.145.40.20]:52125 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S261236AbULHPGy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 10:06:54 -0500
Message-ID: <0E3FA95632D6D047BA649F95DAB60E57057A1988@exa-atlanta>
From: "Mukker, Atul" <Atulm@lsil.com>
To: "'Matt Domsch'" <Matt_Domsch@dell.com>,
       "Bagalkote, Sreenivas" <sreenib@lsil.com>
Cc: "'brking@us.ibm.com'" <brking@us.ibm.com>,
       "'James Bottomley'" <James.Bottomley@SteelEye.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>,
       "'bunk@fs.tum.de'" <bunk@fs.tum.de>, "'Andrew Morton'" <akpm@osdl.org>,
       "Ju, Seokmann" <sju@lsil.com>, "Doelfel, Hardy" <hdoelfel@lsil.com>,
       "Mukker, Atul" <Atulm@lsil.com>
Subject: RE: How to add/drop SCSI drives from within the driver?
Date: Wed, 8 Dec 2004 09:55:01 -0500 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> devices projected on channels N+1..M.  It now projects them 
> as physical devices on channels 0..N (N=number of physical 
> channels on the controller {1,2,4} so far), and the logical 
> drives all on channel N+1.
It makes more sense to export the devices (non-disk, ROMB) on the physical
channel at their actual address. That the reason virtual driver were pushed
out to virtual channel

> 
> Please don't typedef structs, especially not one that's 32 
> bytes long.   
> 
> > +	uint32_t	host_no;
> 
> __u32 is the preferred type when sharing such with userspace.
Yes, typedefs are evil. Is there are good reason to prefer __u32 since
driver conventionally uses uint32_t. The latter definition is available to
userspace as well, right?

> 
> > +	uint32_t	channel;
> > +	uint32_t	scsi_id;
> > +	uint32_t	lun;
> > +	uint32_t	ld;
> > +	uint32_t	reserved[3];
> 
> Why pad this out?
Not pad, possible future expansion of the definition of this packet.

> 
> > +} ld_device_address_t;
> 
> I would also suggest __attribute__((packed)) since you're 
> sharing with userspace just to ensure you can never get it 
> grown by the compiler (it shouldn't be, but just to be safe).
Yes

> 
> Also, as I believe you intend to add some form of INQUIRY 
> Page 81 unique ID to your firmware sets at some point, 
> perhaps this is the logical place to export such information 
> too.  This would then match SCSI_IOCTL_GET_IDLUN in concept.  

The scsi megaraid stack does not have unique identifiers for the logical
drives, and when it happens for future FW, it may not be 32-bits. But you
are right, we should accommodate for this eventuality.


> >  	adapter_t *adapter;
> > +	ld_device_address_t* lda;
> 
> this will be struct ld_device_address *lda of course.
Yes

> 
> > +		if ((lda->ld < 0) || (lda->ld > 
> MAX_LOGICAL_DRIVES_40LD)) {
> 
> It's a __u32, it can't be < 0 (and the compiler should have 
You are right, only the latter check is valid


> warned at that).  Why MAX_LOGICAL_DRIVES_40LD and not 
> MAX_LOGICAL_DRIVES_64LD (which strangely is defined as 65) 
> which is used elsewhere in the driver for such mapping?
For megaraid_mbox, the max limit is 40LD, 64LD is defined in the
mega_common.h, which will be valid for other stacks. 

> 
> > +		lda->scsi_id	= (lda->ld < adapter->init_id) ? 
> > +						lda->ld : lda->ld + 1;
> 
> Ahh, you project an initiator onto the logical drive channel, 
> at init_id, yes?  That wasn't obvious to me at first, is it 
> necessary to do so?  There's no real SCSI bus contention 
> issue, and you can't address the initiator directly.  (again, 
> the driver does this today, and such a change would need to 
> be reflected in this routine
Unfortunately, the mid-layer does not allow initiator id per bus, for
multi-bus devices like megaraid. Since, we have to reserve initiator id for
physical channels, it carries over to virtual channel as well.

This also explains why MAX_LOGICAL_DRIVES_64LD is defined as (64+1)!, since
we lose one spot for initiator id.

Thanks
-Atul Mukker
