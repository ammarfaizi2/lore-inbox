Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262245AbULCPLY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262245AbULCPLY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Dec 2004 10:11:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262248AbULCPLY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Dec 2004 10:11:24 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:51664 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262245AbULCPK7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Dec 2004 10:10:59 -0500
Message-ID: <41B081FC.6040400@us.ibm.com>
Date: Fri, 03 Dec 2004 09:10:52 -0600
From: Brian King <brking@us.ibm.com>
Reply-To: brking@us.ibm.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Bagalkote, Sreenivas" <sreenib@lsil.com>
CC: "'James Bottomley'" <James.Bottomley@SteelEye.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>,
       "'bunk@fs.tum.de'" <bunk@fs.tum.de>, "'Andrew Morton'" <akpm@osdl.org>,
       "'Matt_Domsch@dell.com'" <Matt_Domsch@dell.com>,
       "Ju, Seokmann" <sju@lsil.com>, "Doelfel, Hardy" <hdoelfel@lsil.com>,
       "Mukker, Atul" <Atulm@lsil.com>
Subject: Re: How to add/drop SCSI drives from within the driver?
References: <0E3FA95632D6D047BA649F95DAB60E570230CA69@exa-atlanta>
In-Reply-To: <0E3FA95632D6D047BA649F95DAB60E570230CA69@exa-atlanta>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This looks to be adding an LLD specific interface to userspace to
add/delete disks. Why can't the existing sysfs interfaces be used
to to this? (scan attribute on host and delete attribute on device).

-Brian

Bagalkote, Sreenivas wrote:
> Hello All,
> 
> I am trying to implement a feature in my SCSI driver, where it can
> trigger the SCSI mid-layer to scan or remove a particular drive. I 
> appreciate any help in nudging me in the right direction.
> 
> The exported functions - 
> 
> scsi_add_device( host, channel, target, lun )
> scsi_remove_device( struct scsi_device* )
> 
> seem to work well in my limited testing. Are there any caveats in this
> method? Does this method work well without exceptions? I am inlining
> the full patch for megaraid SCSI driver taken against 2.6.10-rc2. I am
> also attaching it to this mail.
> 
> Thank you,
> Sreenivas
> 
> 
> ----
> diff -Naur old-rc3/drivers/scsi/megaraid/mega_common.h
> new-rc2/drivers/scsi/megaraid/mega_common.h
> --- old-rc2/drivers/scsi/megaraid/mega_common.h	2004-10-18
> 17:54:31.000000000 -0400
> +++ new-rc2/drivers/scsi/megaraid/mega_common.h	2004-12-02
> 20:23:35.000000000 -0500
> @@ -242,6 +242,15 @@
>  					[SCP2TARGET(scp)] & 0xFF);	\
>  	}
>  
> +/**
> + * MRAID_LD_TARGET
> + * @param adp		- Adapter's soft state
> + * @param ld		- Logical drive number
> + *
> + * Macro to retrieve the SCSI target id of a logical drive
> + */
> +#define MRAID_LD_TARGET(adp, ld) (((ld) < (adp)->init_id) ? (ld) : (ld)+1)
> 
> +
>  /*
>   * ### Helper routines ###
>   */
> diff -Naur old-rc2/drivers/scsi/megaraid/megaraid_ioctl.h
> new-rc2/drivers/scsi/megaraid/megaraid_ioctl.h
> --- old-rc2/drivers/scsi/megaraid/megaraid_ioctl.h	2004-12-02
> 20:20:16.000000000 -0500
> +++ new-rc2/drivers/scsi/megaraid/megaraid_ioctl.h	2004-12-02
> 20:23:25.000000000 -0500
> @@ -51,8 +51,11 @@
>  #define MEGAIOC_QNADAP		'm'	/* Query # of adapters		*/
>  #define MEGAIOC_QDRVRVER	'e'	/* Query driver version		*/
>  #define MEGAIOC_QADAPINFO   	'g'	/* Query adapter information	*/
> +#define MEGAIOC_ADD_LD		'a'
> +#define MEGAIOC_DEL_LD		'r'
>  
>  #define USCSICMD		0x80
> +#define UIOC_NONE		0x00000
>  #define UIOC_RD			0x00001
>  #define UIOC_WR			0x00002
>  
> @@ -62,6 +65,8 @@
>  #define GET_ADAP_INFO		0x30000
>  #define GET_CAP			0x40000
>  #define GET_STATS		0x50000
> +#define	ADD_LD			0x60000
> +#define DEL_LD			0x70000
>  #define GET_IOCTL_VERSION	0x01
>  
>  #define EXT_IOCTL_SIGN_SZ	16
> diff -Naur old-rc2/drivers/scsi/megaraid/megaraid_mbox.c
> new-rc2/drivers/scsi/megaraid/megaraid_mbox.c
> --- old-rc2/drivers/scsi/megaraid/megaraid_mbox.c	2004-12-02
> 20:20:16.000000000 -0500
> +++ new-rc2/drivers/scsi/megaraid/megaraid_mbox.c	2004-12-02
> 20:32:33.408278216 -0500
> @@ -10,7 +10,7 @@
>   *	   2 of the License, or (at your option) any later version.
>   *
>   * FILE		: megaraid_mbox.c
> - * Version	: v2.20.4.1 (Nov 04 2004)
> + * Version	: v2.20.4.1+ TEST VERSION
>   *
>   * Authors:
>   * 	Atul Mukker		<Atul.Mukker@lsil.com>
> @@ -3642,6 +3642,10 @@
>  megaraid_mbox_mm_handler(unsigned long drvr_data, uioc_t *kioc, uint32_t
> action)
>  {
>  	adapter_t *adapter;
> +	uint32_t ld;
> +	struct scsi_device* sdev;
> +	int ch;
> +	int tg;
>  
>  	if (action != IOCTL_ISSUE) {
>  		con_log(CL_ANN, (KERN_WARNING
> @@ -3670,6 +3674,31 @@
>  
>  		return kioc->status;
>  
> +	case ADD_LD:
> +		ld = *(uint32_t*) kioc->buf_vaddr;
> +		ch = adapter->max_channel;
> +		tg = MRAID_LD_TARGET( adapter, ld );
> +		scsi_add_device(adapter->host, ch, tg, 0);
> +
> +		kioc->status = 0;
> +		kioc->done(kioc);
> +		return kioc->status;
> +
> +	case DEL_LD:
> +		ld = *(uint32_t*) kioc->buf_vaddr;
> +		ch = adapter->max_channel;
> +		tg = MRAID_LD_TARGET( adapter, ld );
> +		sdev = scsi_device_lookup( adapter->host, ch, tg, 0);
> +		
> +		if( sdev ) {
> +			scsi_remove_device( sdev );
> +			scsi_device_put( sdev );
> +		}
> +
> +		kioc->status = 0;
> +		kioc->done(kioc);
> +		return kioc->status;
> +
>  	case MBOX_CMD:
>  
>  		return megaraid_mbox_mm_command(adapter, kioc);
> diff -Naur old-rc2/drivers/scsi/megaraid/megaraid_mbox.h
> new-rc2/drivers/scsi/megaraid/megaraid_mbox.h
> --- old-rc2/drivers/scsi/megaraid/megaraid_mbox.h	2004-12-02
> 20:20:16.000000000 -0500
> +++ new-rc2/drivers/scsi/megaraid/megaraid_mbox.h	2004-12-02
> 20:32:09.737876664 -0500
> @@ -21,8 +21,8 @@
>  #include "megaraid_ioctl.h"
>  
>  
> -#define MEGARAID_VERSION	"2.20.4.1"
> -#define MEGARAID_EXT_VERSION	"(Release Date: Thu Nov  4 17:44:59 EST
> 2004)"
> +#define MEGARAID_VERSION	"2.20.4.1+ TEST VERSION"
> +#define MEGARAID_EXT_VERSION	"(Release Date: TEST VERSION)"
>  
>  
>  /*
> diff -Naur old-rc2/drivers/scsi/megaraid/megaraid_mm.c
> new-rc2/drivers/scsi/megaraid/megaraid_mm.c
> --- old-rc2/drivers/scsi/megaraid/megaraid_mm.c	2004-12-02
> 20:20:16.000000000 -0500
> +++ new-rc2/drivers/scsi/megaraid/megaraid_mm.c	2004-12-02
> 20:22:57.000000000 -0500
> @@ -373,6 +373,34 @@
>  			if (mraid_mm_attach_buf(adp, kioc, kioc->xferlen))
>  				return (-ENOMEM);
>  		}
> +		else if (subopcode == MEGAIOC_ADD_LD) {
> +
> +			kioc->opcode	= ADD_LD;
> +			kioc->data_dir	= UIOC_NONE;
> +			kioc->xferlen	= sizeof(uint32_t);
> +
> +			if (mraid_mm_attach_buf(adp, kioc, kioc->xferlen))
> +				return -(ENOMEM);
> +
> +			if (copy_from_user(kioc->buf_vaddr, mimd.data,
> +							kioc->xferlen)) {
> +				return (-EFAULT);
> +			}
> +		}
> +		else if (subopcode == MEGAIOC_DEL_LD) {
> +
> +			kioc->opcode	= DEL_LD;
> +			kioc->data_dir	= UIOC_NONE;
> +			kioc->xferlen	= sizeof(uint32_t);
> +
> +			if (mraid_mm_attach_buf(adp, kioc, kioc->xferlen))
> +				return -(ENOMEM);
> +
> +			if (copy_from_user(kioc->buf_vaddr, mimd.data,
> +							kioc->xferlen)) {
> +				return (-EFAULT);
> +			}
> +		}
>  		else {
>  			con_log(CL_ANN, (KERN_WARNING
>  					"megaraid cmm: Invalid subop\n"));
> @@ -809,6 +837,9 @@
>  
>  			return 0;
>  
> +		case MEGAIOC_ADD_LD:
> +		case MEGAIOC_DEL_LD:
> +			return 0;
>  		default:
>  			return (-EINVAL);
>  		}
> diff -Naur old-rc2/drivers/scsi/megaraid/megaraid_mm.h
> new-rc2/drivers/scsi/megaraid/megaraid_mm.h
> --- old-rc2/drivers/scsi/megaraid/megaraid_mm.h	2004-12-02
> 20:20:16.000000000 -0500
> +++ new-rc2/drivers/scsi/megaraid/megaraid_mm.h	2004-12-02
> 20:33:00.709127856 -0500
> @@ -29,9 +29,9 @@
>  #include "megaraid_ioctl.h"
>  
>  
> -#define LSI_COMMON_MOD_VERSION	"2.20.2.2"
> +#define LSI_COMMON_MOD_VERSION	"2.20.2.2+ TEST VERSION"
>  #define LSI_COMMON_MOD_EXT_VERSION	\
> -		"(Release Date: Thu Nov  4 17:46:29 EST 2004)"
> +		"(Release Date: TEST VERSION)"
>  
>  
>  #define LSI_DBGLVL			dbglevel
> ----
> 

-- 
Brian King
eServer Storage I/O
IBM Linux Technology Center

