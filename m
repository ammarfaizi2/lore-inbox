Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750747AbVHPXrr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750747AbVHPXrr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 19:47:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750746AbVHPXrd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 19:47:33 -0400
Received: from ausc60ps301.us.dell.com ([143.166.148.206]:52147 "EHLO
	ausc60ps301.us.dell.com") by vger.kernel.org with ESMTP
	id S1750745AbVHPXrc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 19:47:32 -0400
X-IronPort-AV: i="3.96,114,1122872400"; 
   d="scan'208"; a="280501160:sNHT28430024"
Date: Tue, 16 Aug 2005 19:02:13 -0500
From: Doug Warzecha <Douglas_Warzecha@dell.com>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, Michael_E_Brown@dell.com,
       Matt_Domsch@dell.com
Subject: Re: [RFC][PATCH 2.6.13-rc6] add Dell Systems Management Base Driver (dcdbas) with sysfs support
Message-ID: <20050817000213.GA3645@sysman-doug.us.dell.com>
References: <20050815200522.GA3667@sysman-doug.us.dell.com> <20050816055247.GA20697@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050816055247.GA20697@kroah.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 15, 2005 at 10:52:48PM -0700, Greg KH wrote:
> On Mon, Aug 15, 2005 at 03:05:22PM -0500, Doug Warzecha wrote:
> > +
> > +1) Lock smi_data.
> > +2) Determine buffer size needed for system management command.
> > +3) Write buffer size needed to smi_data_buf_size.
> > +   (Driver will ensure that its SMI data buffer is at least that size.)
> 
> Why have this step?  Why is it needed?  Just go off of the size of the
> buffer that is written to smi_data.  Or am I missing something?

I'll change smi_data_write to do that.

> > +4) If physical address of SMI data buffer is needed to set up system
> > +   management command, read physical address from smi_data_buf_phys_addr
> > +   and add to command data.
> 
> How do you know this?

It depends on the SMI calling convention.  Dell OpenManage needs the physical address for the SMI to get the ESM log on the PowerEdge systems listed in this doc.

> > +#define DCDBAS_DEV_ATTR_RW(_name) \
> > +	DEVICE_ATTR(_name,0644,_name##_show,_name##_store);
> > +
> > +#define DCDBAS_DEV_ATTR_RO(_name) \
> > +	DEVICE_ATTR(_name,0444,_name##_show,NULL);
> 
> Why let all users read this data?

Will be changed so that only owner can read.

> > +#define DCDBAS_BIN_ATTR_RW(_name) \
> > +struct bin_attribute bin_attr_##_name = { \
> > +	.attr =  { .name = __stringify(_name), \
> > +		   .mode = 0644, \
> 
> Why let everyone read this data?

Will be changed so that only owner can read.

> > +struct callintf_cmd {
> > +	u32 magic;
> 
> Why even have this?  Does it really stop anything except random
> scribblings?

It's to stop random writing.

> > +	u16 command_address;
> > +	u8 command_code;
> > +	u8 reserved;
> > +	u32 command_signature;
> > +	u8 command_buffer[1];
> > +} __attribute__ ((packed));
> 
> As these cross the userspace/kernelspace boundry, please use the __u32,
> __u16, and __u8 variable types.

Will be changed.

> > +struct apm_cmd {
> > +	u8 command;
> > +	s8 status;
> > +	u16 reserved;
> > +	union {
> > +		struct {
> > +			u8 parm[MAX_SYSMGMT_SHORTCMD_PARMBUF_LEN];
> > +		} __attribute__ ((packed)) shortreq;
> > +
> > +		struct {
> > +			u16 num_sg_entries;
> > +			struct {
> > +				u32 size;
> > +				u64 addr;
> > +			} __attribute__ ((packed))
> > +			    sglist[MAX_SYSMGMT_LONGCMD_SGENTRY_NUM];
> > +		} __attribute__ ((packed)) longreq;
> > +	} __attribute__ ((packed)) parameters;
> > +} __attribute__ ((packed));
> 
> Same here (I think...)

Will be changed.

Doug

