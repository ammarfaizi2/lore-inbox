Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751169AbWGGDcT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751169AbWGGDcT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 23:32:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751170AbWGGDcT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 23:32:19 -0400
Received: from main.gmane.org ([80.91.229.2]:29602 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751169AbWGGDcS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 23:32:18 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Parag Warudkar <kernel-stuff@comcast.net>
Subject: Re: [BUG] sleeping function called from invalid context during resume
Date: Fri, 7 Jul 2006 03:32:08 +0000 (UTC)
Message-ID: <loom.20060707T052608-633@post.gmane.org>
References: <1152241296.6163.4.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 68.60.177.223 (Mozilla/5.0 (compatible; Konqueror/3.5; Linux) KHTML/3.5.3 (like Gecko))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

john stultz <johnstul <at> us.ibm.com> writes:

> 
> I got the following on my laptop w/ 2.6.18-rc1.
> 
> thanks
> -john
 
> Back to C!
> BUG: sleeping function called from invalid context at mm/slab.c:2882
> in_atomic():0, irqs_disabled():1
>  [<c0103d59>] show_trace_log_lvl+0x149/0x170
>  [<c01052ab>] show_trace+0x1b/0x20
>  [<c01052d4>] dump_stack+0x24/0x30
>  [<c0116e51>] __might_sleep+0xa1/0xc0
>  [<c0165cb5>] kmem_cache_zalloc+0xa5/0xc0
>  [<c0264b5a>] acpi_os_acquire_object+0x11/0x41
>  [<c027a898>] acpi_ut_allocate_object_desc_dbg+0xf/0x45
>  [<c027a926>] acpi_ut_create_internal_object_dbg+0x16/0x69
>  [<c0276bd3>] acpi_rs_set_srs_method_data+0x80/0xdd
>  [<c02762e5>] acpi_set_current_resources+0x31/0x3f
>  [<c02826bf>] acpi_pci_link_set+0xfc/0x1a5
>  [<c0282a25>] irqrouter_resume+0x52/0x73
>  [<c02b92aa>] __sysdev_resume+0x1a/0x90
>  [<c02b9367>] sysdev_resume+0x47/0x70
>  [<c02bf1f8>] device_power_up+0x8/0x10
>  [<c0142185>] suspend_enter+0x65/0x80

Hmm.. This was fixed in -mm back in February
(http://www.ussg.iu.edu/hypermail/linux/kernel/0602.1/2022.html). 
Not sure why it hasn't flowed in to mainline. Does this patch below (against 
2.6.18-rc1) fix it?

Parag

Signed-off-by: Parag Warudkar <kernel-stuff@comcast.net>

--- linux-2.6.17/drivers/acpi/osl.c.orig        2006-07-06 
23:22:03.000000000 -0400
+++ linux-2.6.17/drivers/acpi/osl.c     2006-07-06 23:29:43.000000000 -0400
@@ -1130,7 +1130,11 @@ acpi_status acpi_os_release_object(acpi_

 void *acpi_os_acquire_object(acpi_cache_t * cache)
 {
-       void *object = kmem_cache_zalloc(cache, GFP_KERNEL);
+       void* object;
+       if (acpi_in_resume)
+               object = kmem_cache_zalloc(cache, GFP_ATOMIC);
+       else
+               object = kmem_cache_zalloc(cache, GFP_KERNEL);
        WARN_ON(!object);
        return object;
 }


