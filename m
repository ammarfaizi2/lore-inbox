Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261767AbTH2WRu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 18:17:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261682AbTH2WRu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 18:17:50 -0400
Received: from smtp2.us.dell.com ([143.166.85.133]:15592 "EHLO
	smtp2.us.dell.com") by vger.kernel.org with ESMTP id S261336AbTH2WRq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 18:17:46 -0400
Date: Fri, 29 Aug 2003 17:17:17 -0500 (CDT)
From: Matt Domsch <Matt_Domsch@dell.com>
X-X-Sender: mdomsch@humbolt.us.dell.com
To: Matt Tolentino <metolent@snoqualmie.dp.intel.com>
cc: matthew.e.tolentino@intel.com, <linux-kernel@vger.kernel.org>,
       <linux-ia64@vger.kernel.org>
Subject: Re: [PATCH] efivars update
In-Reply-To: <200308292124.h7TLOCAZ000785@snoqualmie.dp.intel.com>
Message-ID: <Pine.LNX.4.44.0308291708270.27800-100000@humbolt.us.dell.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The patch is against 2.6.0-test4.  Please apply. 

Thanks for your work on this!  One bug, 3 nits...

> +static ssize_t
> +efivar_edit(struct efivar_entry *entry, const char *buf, size_t count)
...
> +       spin_lock(&efivars_lock);
> +       status = efi.set_variable(new_var->VariableName,
> +                                 &new_var->VendorGuid,
> +                                 new_var->Attributes,
> +                                 new_var->DataSize,
> +                                 new_var->Data);
> +
> +       if (status != EFI_SUCCESS) {
> +               printk(KERN_WARNING "set_variable() failed: status=%lx\n",
> +                               status);
> +               return -EIO;
> +       }
> +       spin_unlock(&efivars_lock);


Move the unlock up above the status test, else you return while
holding the lock on failure.


> +static ssize_t
> +efivar_create(struct subsystem *sub, const char *buf, size_t count)
...
> +       if (found) {
> +               printk("EFI variable already exists!\n");

level on printk please.



> +efivar_delete(struct subsystem *sub, const char *buf, size_t count)
...
> +       status = efi.set_variable(del_var->VariableName,
> +                                 &del_var->VendorGuid,
> +                                 del_var->Attributes,
> +                                 del_var->DataSize,
> +                                 del_var->Data);

Might as well just force the deletion by setting Attributes=0 or
DataSize=0 or both.  Less chance for userspace error.


> + * Overrides for Emacs so that we follow Linus's tabbing style.

Please kill this chunk.  I shouldn't have had it there in the first 
place. :-)

Looks great to me!  Thanks again.


-- 
Matt Domsch
Sr. Software Engineer, Lead Engineer
Dell Linux Solutions www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com


