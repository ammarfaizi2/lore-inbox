Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261338AbTDQMm2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 08:42:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261334AbTDQMm2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 08:42:28 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:16797 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S261328AbTDQMmY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 08:42:24 -0400
From: Alan Cox <alan@redhat.com>
Message-Id: <200304171252.h3HCqG909973@devserv.devel.redhat.com>
Subject: Re: [ANNOUNCE]: version 2.00.3 megaraid driver for 2.4.x and 2.5.67 kernels
To: hch@infradead.org (Christoph Hellwig)
Date: Thu, 17 Apr 2003 08:52:16 -0400 (EDT)
Cc: atulm@lsil.com (Mukker Atul), alan@redhat.com ('alan@redhat.com'),
       James.Bottomley@steeleye.com ('James.Bottomley@steeleye.com'),
       linux-kernel@vger.kernel.org ('linux-kernel@vger.kernel.org'),
       linux-scsi@vger.kernel.org ('linux-scsi@vger.kernel.org'),
       linux-megaraid-devel@dell.com ('linux-megaraid-devel@dell.com'),
       linux-megaraid-announce@dell.com ('linux-megaraid-announce@dell.com')
In-Reply-To: <20030417133820.A12503@infradead.org> from "Christoph Hellwig" at Ebr 17, 2003 01:38:20 
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>     a) please avoid typedefs for structs.  Also adapter_t is a bit
>     too generic.  What about struct mega_adapter instead?
>     b) please don't use such global arrays but always use the
>     ->hostdata field.

a) megaraid always used a set of basic typedefs. Seems to be your personal
view not general comment

b) Probably right

> static struct notifier_block mega_notifier = {
> 	.notifier_call = megaraid_reboot_notify
> };
> 
>     Do you really need this?  Why can you use
>     struct device_driver->shutdown?

Not on 2.2

> 	if( max_mbox_busy_wait > MBOX_BUSY_WAIT )
> 		max_mbox_busy_wait = MBOX_BUSY_WAIT;
> }
> 
>     Please run the whole driver through scripts/Lindent

Looks fine to me anyway

> megaraid_detect(Scsi_Host_Template *host_template)
> 
>     Please get rid of ->detect and use the new-style pci API +
>     scsi_add_host instead.

Doesnt work on 2.4

> static void internal_done (Scsi_Cmnd *cmd)
> {
> 	internal_done_errcode = cmd->result;
> 	internal_done_flag++;
> 	wake_up (&internal_wait);
> }
> 
> /* shouldn't be used, but included for completeness */

>     This looks horribly racy.

Its ok on older kernels 2.2/2.4 wont afaik ever use it.

> 	return FALSE;
> 
>     Please don't use TRUE/FALSE but 1/0 directly.

TRUE/FALSE is IMHO perfectly clear

> 	if (!try_module_get(THIS_MODULE)) {
> 		return -ENXIO;
> 	}
> 
>    This is broken as hell (and I fixed it in the old megraid driver
>    ages ago!)  Just set ->owner in the file_operation.

Definitely wants fixing
 
> 	while( atomic_read(&adapter->pend_cmds) > 0 ||
> 			!list_empty(&adapter->pending_list) ) {
> 
> 		sleep_on_timeout( &wq, 1*HZ );	/* sleep for 1s */
> 	}
> 
>   Again racy.  You need to opencode this (similar to wait_event, maybe
>   just add wait_even_timeout).

Actually the timeout means the worst that occurs is you wait a 
second, and the code is portable to old 2.2/2.4

> static Scsi_Host_Template driver_template = MEGARAID;
> 
>     Get rid of the ugly macro and add the members right here.
> 
> While we're at it:  Please also get rid of all those prototypes in
> megaraid.h

2.2
