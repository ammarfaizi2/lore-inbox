Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261799AbULUQwU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261799AbULUQwU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Dec 2004 11:52:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261789AbULUQwU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Dec 2004 11:52:20 -0500
Received: from rproxy.gmail.com ([64.233.170.202]:36204 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261799AbULUQvu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Dec 2004 11:51:50 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=rTkz/Uf9aVXacpfDFAZgIZhrMAbBB1xsi9tznU3XHCxUPfgNa/cTzJwv4LhGlM4CG0gE8cGNLvu8OaC1R2+IkPu89YHhMh7DsIpSxSPY0j7KIOOBzvGzwdqSbvtklcqmQx6ID3NtpHEGfw0CRGlcd2fREREqvHSecO7fc5me3FU=
Message-ID: <29495f1d041221085144b08901@mail.gmail.com>
Date: Tue, 21 Dec 2004 08:51:49 -0800
From: Nish Aravamudan <nish.aravamudan@gmail.com>
Reply-To: Nish Aravamudan <nish.aravamudan@gmail.com>
To: Kylene Hall <kjhall@us.ibm.com>
Subject: Re: [PATCH 1/1] driver: Tpm hardware enablement --updated version
Cc: linux-kernel@vger.kernel.org, greg@kroah.com, sailer@watson.ibm.com,
       leendert@watson.ibm.com, emilyr@us.ibm.com, toml@us.ibm.com,
       tpmdd-devel@lists.sourceforge.net
In-Reply-To: <Pine.LNX.4.58.0412201146060.10943@jo.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <Pine.LNX.4.58.0412081546470.24510@jo.austin.ibm.com>
	 <Pine.LNX.4.58.0412161632200.4219@jo.austin.ibm.com>
	 <Pine.LNX.4.58.0412171642570.9229@jo.austin.ibm.com>
	 <Pine.LNX.4.58.0412201146060.10943@jo.austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Dec 2004 11:50:00 -0600 (CST), Kylene Hall <kjhall@us.ibm.com> wrote:
> This patch is a device driver to enable new hardware.  The new hardware is
> the TPM chip as described by specifications at 
> <http://www.trustedcomputinggroup.org>.  The TPM chip will enable you to
> use hardware to securely store and protect your keys and personal data.
> To use the chip according to the specification, you will need the Trusted
> Software Stack (TSS) of which an implementation for Linux is available at:
> <http://sourceforge.net/projects/trousers>.
> 
> > > Updates include: splitting out the vendor specific code into separated
> > > drivers from the base TPM functionality, fixed busy waiting loops,
> > > concerns about timer handling and rmmod, buffer name.
> 
> > Updates include a consolodated buffer mutex, numerous naming improvements,
> > better placement of pci_driver and file_operations structure
> > initializations, change to use of EXPORT_SYMBOL_GPL, improvement of
> > Kconfig help texts and creation of a tpm directory
> 
> Updates include moving the pci_ids table into the individual vendor
> specific .c files and including a tpm description file in the
> Documentation directory.
> 
> Thanks,
> Kylene
> 
> Signed-off-by: Leendert van Doorn <leendert@watson.ibm.com>
> Signed-off-by: Reiner Sailer <sailer@watson.ibm.com>
> Signed-off-by: Dave Safford <safford@watson.ibm.com>
> Signed-off-by: Kylene Hall <kjhall@us.ibm.com>

<snip>

> diff -uprN linux-2.6.9/drivers/char/tpm/tpm.c linux-2.6.9-tpm/drivers/char/tpm/tpm.c
> --- linux-2.6.9/drivers/char/tpm/tpm.c  1969-12-31 18:00:00.000000000 -0600
> +++ linux-2.6.9-tpm/drivers/char/tpm/tpm.c      2004-12-17 17:40:21.000000000 -0600
> @@ -0,0 +1,508 @@
> +/*
> + * Copyright (C) 2004 IBM Corporation
> + *
> + * Authors:
> + * Leendert van Doorn <leendert@watson.ibm.com>
> + * Reiner Sailer <sailer@watson.ibm.com>
> + * Dave Safford <safford@watson.ibm.com>
> + * Kylene Hall <kjhall@us.ibm.com>
> + *
> + * Maintained by: <tpmdd_devel@lists.sourceforge.net>
> + *
> + * Device driver for TCG/TCPA TPM (trusted platform module).
> + * Specifications at www.trustedcomputinggroup.org
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation, version 2 of the
> + * License.
> + *
> + * Note, the TPM chip is not interrupt driven (only polling)
> + * and can have very long timeouts (minutes!). Hence the unusual
> + * calls to schedule_timeout.

<snip>

> +       do {
> +               u8 status = inb(chip->vendor->base + 1);
> +               if ((status & chip->vendor->req_complete_mask) ==
> +                   chip->vendor->req_complete_val) {
> +                       down(&chip->timer_manipulation_mutex);
> +                       del_singleshot_timer_sync(&chip->device_timer);
> +                       up(&chip->timer_manipulation_mutex);
> +                       goto out_recv;
> +               }
> +               schedule_timeout(TPM_TIMEOUT);
> +               rmb();
> +       } while (!chip->time_expired);

All of these calls to schedule_timeout() are broken. You must set the
state appropriately before calling schedule_timeout() or it will
return immediately. For your reference here is the difference between
the two states with respects to calling schedule_timeout() directly:

TASK_INTERRUPTIBLE: sleep, waking up early on both signals and waitqueue events
TASK_UNINTERRUPTIBLE: sleep, waking up early on watiqueue events

Keep in mind that if TASK_INTERRUPTIBLE is used, you *must* be
prepared to handle signals (check return value, indicating an early
return, and signals_pending(current), indicating whether the cause of
early return is either a signal or waitqueue event).

Also, as a final consideration, because of the way the loadavg is
calculated, a TASK_UNINTERRUPTIBLE sleep will factor in as a 1 to the
load.

-Nish
