Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751381AbWFZCZm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751381AbWFZCZm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 22:25:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751409AbWFZCZm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 22:25:42 -0400
Received: from xenotime.net ([66.160.160.81]:47247 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751380AbWFZCZl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 22:25:41 -0400
Date: Sun, 25 Jun 2006 19:28:27 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Alex Davis <alex14641@yahoo.com>
Cc: linux-kernel@vger.kernel.org, scsi <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH] Fix bug: accessing past end of array.
Message-Id: <20060625192827.730f1a8d.rdunlap@xenotime.net>
In-Reply-To: <20060626020646.49093.qmail@web50406.mail.yahoo.com>
References: <20060626020646.49093.qmail@web50406.mail.yahoo.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[adding linux-scsi]

On Sun, 25 Jun 2006 19:06:46 -0700 (PDT) Alex Davis wrote:

> If the card is re-inserted 2 or more times, we access elements
> past the end of the aha152x_host array.

When I was testing/reproducing this, I observed that removing
the card did not cause the aha152x_detach() function to be called
(in drivers/scsi/pcmcia/aha152x_stub.c).  However, I didn't
find out why that doesn't happen.  I think fixing this would
be a big help.


> Also correct spelling errors.
> 
> This is for 2.6.17.
> 
> Signed-off-by Alex Davis <alex14641 at yahoo dot com>
> =========================================================================
> diff -u linux-2.6.17.1-orig/drivers/scsi/aha152x.c linux-2.6.17.1/drivers/scsi/aha152x.c
> --- linux-2.6.17.1-orig/drivers/scsi/aha152x.c	2006-06-17 21:49:35.000000000 -0400
> +++ linux-2.6.17.1/drivers/scsi/aha152x.c	2006-06-25 20:06:05.000000000 -0400
> @@ -766,7 +766,7 @@
>  	struct Scsi_Host *shpnt = lookup_irq(irqno);
>  
>  	if (!shpnt) {
> -        	printk(KERN_ERR "aha152x: catched software interrupt %d for unknown controller.\n",
> irqno);
> +        	printk(KERN_ERR "aha152x: caught software interrupt %d for unknown controller.\n",
> irqno);
>  		return IRQ_NONE;
>  	}
>  
> @@ -779,6 +779,7 @@
>  struct Scsi_Host *aha152x_probe_one(struct aha152x_setup *setup)
>  {
>  	struct Scsi_Host *shpnt;
> +	int i;
>  
>  	shpnt = scsi_host_alloc(&aha152x_driver_template, sizeof(struct aha152x_hostdata));
>  	if (!shpnt) {
> @@ -787,6 +788,22 @@
>  	}
>  
>  	/* need to have host registered before triggering any interrupt */
> +
> +	/* find an empty slot. */
> +	for ( i = 0; i < ARRAY_SIZE(aha152x_host); ++i ) {
> +		if ( aha152x_host[i] == NULL ) {
> +			break;
> +		}
> +	}
> +
> +	/* no empty slots? */
> +	if ( i >= ARRAY_SIZE(aha152x_host) ) {
> +		printk(KERN_ERR "aha152x: too many hosts: %d\n", i + 1);
> +		return NULL;
> +	}
> +
> +	registered_count = i;
> +
>  	aha152x_host[registered_count] = shpnt;
>  
>  	memset(HOSTDATA(shpnt), 0, sizeof *HOSTDATA(shpnt));
> @@ -915,6 +932,8 @@
>  
>  void aha152x_release(struct Scsi_Host *shpnt)
>  {
> +	int i;
> +
>  	if(!shpnt)
>  		return;
>  
> @@ -933,6 +952,12 @@
>  
>  	scsi_remove_host(shpnt);
>  	scsi_host_put(shpnt);
> +	for ( i = 0; i < ARRAY_SIZE(aha152x_host); ++i ) {
> +		if ( aha152x_host[i] == shpnt ) {
> +			aha152x_host[i] = NULL;
> +			break;
> +		}
> +	}
>  }
>  
>  
> @@ -1458,7 +1483,7 @@
>  	unsigned char rev, dmacntrl0;
>  
>  	if (!shpnt) {
> -		printk(KERN_ERR "aha152x: catched interrupt %d for unknown controller.\n", irqno);
> +		printk(KERN_ERR "aha152x: caught interrupt %d for unknown controller.\n", irqno);
>  		return IRQ_NONE;
>  	}
>  
> @@ -2976,6 +3001,9 @@
>  	Scsi_Cmnd *ptr;
>  	unsigned long flags;
>  
> +	if(!shpnt)
> +		return;
> +
>  	DO_LOCK(flags);
>  	printk(KERN_DEBUG "\nqueue status:\nissue_SC:\n");
>  	for (ptr = ISSUE_SC; ptr; ptr = SCNEXT(ptr))
> @@ -3941,7 +3969,6 @@
>  
>  	for(i=0; i<ARRAY_SIZE(setup); i++) {
>  		aha152x_release(aha152x_host[i]);
> -		aha152x_host[i]=NULL;
>  	}
>  }
> 

---
~Randy
