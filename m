Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264934AbTFQWAi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 18:00:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264938AbTFQWAi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 18:00:38 -0400
Received: from cerebus.wirex.com ([65.102.14.138]:51965 "EHLO
	figure1.int.wirex.com") by vger.kernel.org with ESMTP
	id S264934AbTFQWAb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 18:00:31 -0400
Date: Tue, 17 Jun 2003 15:13:35 -0700
From: Chris Wright <chris@wirex.com>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] PCI device list locking
Message-ID: <20030617151335.A17117@figure1.int.wirex.com>
Mail-Followup-To: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
References: <20030617212628.GA12723@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030617212628.GA12723@kroah.com>; from greg@kroah.com on Tue, Jun 17, 2003 at 02:26:28PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Greg KH (greg@kroah.com) wrote:
> 
> Comments?  Places I missed protecting?

Is it safe to ignore pcibios_init?  This happens after smp_init, but are
could there be multiple events (that would effect pcibios_sort)?

> --- a/drivers/pci/proc.c	Tue Jun 17 12:47:27 2003
> +++ b/drivers/pci/proc.c	Tue Jun 17 12:47:27 2003
> @@ -12,6 +12,7 @@
>  #include <linux/proc_fs.h>
>  #include <linux/seq_file.h>
>  #include <linux/smp_lock.h>
> +#include "pci.h"
>  
>  #include <asm/uaccess.h>
>  #include <asm/byteorder.h>
> @@ -311,20 +312,32 @@
>  	struct list_head *p = &pci_devices;
>  	loff_t n = *pos;
>  
> -	/* XXX: surely we need some locking for traversing the list? */
> +	spin_lock(&pci_bus_lock);

should you just grab this lock here (pci_seq_start), and release in
pci_seq_stop, holding for duration of ->seq_start() ->seq_next()
->seq_stop().  IOW, what happens when you grab list element in
->seq_start(), it's removed from list, you reference a bogus ->next
pointer in ->seq_next()?

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
