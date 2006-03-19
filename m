Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751051AbWCSV3B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751051AbWCSV3B (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Mar 2006 16:29:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751053AbWCSV3A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Mar 2006 16:29:00 -0500
Received: from ausc60ps301.us.dell.com ([143.166.148.206]:49548 "EHLO
	ausc60ps301.us.dell.com") by vger.kernel.org with ESMTP
	id S1751022AbWCSV3A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Mar 2006 16:29:00 -0500
X-IronPort-AV: i="4.03,109,1141624800"; 
   d="scan'208"; a="62040607:sNHT30571146"
Date: Sun, 19 Mar 2006 15:29:01 -0600
From: Matt Domsch <Matt_Domsch@dell.com>
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: matthew.e.tolentino@intel.com, linux-kernel@vger.kernel.org,
       mactel-linux-devel@lists.sourceforge.net
Subject: Re: [PATCH] - make sure that EFI variable data size is always 64 bit
Message-ID: <20060319212901.GA30843@lists.us.dell.com>
References: <20060319184325.GA7605@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060319184325.GA7605@srcf.ucam.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 19, 2006 at 06:43:25PM +0000, Matthew Garrett wrote:
> The EFI spec states that the data size of an EFI variable is 64 bits. 
> "unsigned long", on the other hand, isn't on IA32.
> 
> diff --git a/drivers/firmware/efivars.c b/drivers/firmware/efivars.c
> index bda5bce..488c24c 100644
> --- a/drivers/firmware/efivars.c
> +++ b/drivers/firmware/efivars.c
> @@ -110,7 +110,7 @@ static LIST_HEAD(efivar_list);
>  struct efi_variable {
>  	efi_char16_t  VariableName[1024/sizeof(efi_char16_t)];
>  	efi_guid_t    VendorGuid;
> -	unsigned long DataSize;
> +	__u64	      DataSize;
>  	__u8          Data[1024];
>  	efi_status_t  Status;
>  	__u32         Attributes;
> diff --git a/include/linux/efi.h b/include/linux/efi.h
> index 9e97bc2..3f0a179 100644
> --- a/include/linux/efi.h
> +++ b/include/linux/efi.h
> @@ -163,7 +163,7 @@ typedef efi_status_t efi_get_wakeup_time
>  					    efi_time_t *tm);
>  typedef efi_status_t efi_set_wakeup_time_t (efi_bool_t enabled, efi_time_t *tm);
>  typedef efi_status_t efi_get_variable_t (efi_char16_t *name, efi_guid_t *vendor, u32 *attr,
> -					 unsigned long *data_size, void *data);
> +					 __u64 *data_size, void *data);
>  typedef efi_status_t efi_get_next_variable_t (unsigned long *name_size, efi_char16_t *name,
>  					      efi_guid_t *vendor);
>  typedef efi_status_t efi_set_variable_t (efi_char16_t *name, efi_guid_t *vendor, 



NAK.  efibootmgr, the main userspace consumer of this struct, also
thinks this is an "unsigned long".   This wasn't specified up through
EFI 1.10, which I complained about (it, and efi_status_t being defined
as an unsigned long) both force userspace consumers of this struct to
match size of the kernel (i.e. compile a 32-bit binary for 32-bit kernel,
and compile a 64-bit binary for 64-bit kernel).

-Matt


-- 
Matt Domsch
Software Architect
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com
