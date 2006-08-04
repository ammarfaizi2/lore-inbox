Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932555AbWHDAkL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932555AbWHDAkL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 20:40:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932562AbWHDAkK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 20:40:10 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:19124 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S932555AbWHDAkI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 20:40:08 -0400
Subject: Re: [PATCH] memory hotadd fixes [5/5] avoid registering res twice
From: keith mannthey <kmannth@us.ibm.com>
Reply-To: kmannth@us.ibm.com
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: lkml <linux-kernel@vger.kernel.org>,
       lhms-devel <lhms-devel@lists.sourceforge.net>,
       "y-goto@jp.fujitsu.com" <y-goto@jp.fujitsu.com>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <20060803123716.2e00952a.kamezawa.hiroyu@jp.fujitsu.com>
References: <20060803123716.2e00952a.kamezawa.hiroyu@jp.fujitsu.com>
Content-Type: text/plain
Organization: Linux Technology Center IBM
Date: Thu, 03 Aug 2006 17:23:30 -0700
Message-Id: <1154651010.5925.56.camel@keithlap>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-08-03 at 12:37 +0900, KAMEZAWA Hiroyuki wrote:
> both of acpi_memory_enable_device() and acpi_memory_add_device()
> may evaluate _CRS method.
> 
> We should avoid evaluate device's resource twice if we could get it
> successfully in past.
> 
> Signed-Off-By: KAMEZWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
> 
>  drivers/acpi/acpi_memhotplug.c |    4 ++++
>  1 files changed, 4 insertions(+)
> 
> Index: linux-2.6.18-rc3/drivers/acpi/acpi_memhotplug.c
> ===================================================================
> --- linux-2.6.18-rc3.orig/drivers/acpi/acpi_memhotplug.c	2006-08-02 14:12:45.000000000 +0900
> +++ linux-2.6.18-rc3/drivers/acpi/acpi_memhotplug.c	2006-08-02 14:24:10.000000000 +0900
> @@ -129,11 +129,15 @@
>  	struct acpi_memory_info *info, *n;
>  
> 
> +	if (!list_empty(&mem_device->res_list))
> +		return 0;
> +
>  	status = acpi_walk_resources(mem_device->device->handle, METHOD_NAME__CRS,
>  				     acpi_memory_get_resource, mem_device);
>  	if (ACPI_FAILURE(status)) {
>  		list_for_each_entry_safe(info, n, &mem_device->res_list, list)
>  			kfree(info);
> +		INIT_LIST_HEAD(&mem_device->res_list);
>  		return -EINVAL;
>  	}

Looks fine to me. 

Acked-By: Keith Mannthey <kmannth@us.ibm.com>







