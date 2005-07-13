Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262412AbVGMAe1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262412AbVGMAe1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 20:34:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262512AbVGMAe1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 20:34:27 -0400
Received: from gate.crashing.org ([63.228.1.57]:8900 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262412AbVGMAeW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 20:34:22 -0400
Subject: Re: [PATCH][help?] Radeonfb acpi resume
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Micheal Marineau <marineam@engr.orst.edu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <42D19EE1.90809@engr.orst.edu>
References: <42D19EE1.90809@engr.orst.edu>
Content-Type: text/plain
Date: Wed, 13 Jul 2005 10:32:47 +1000
Message-Id: <1121214768.31924.412.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-07-10 at 15:19 -0700, Micheal Marineau wrote:
> I've been forward porting this patch for a while now and need
> some input on it. You can see the last time someone posted it
> to the list here:
> http://www.ussg.iu.edu/hypermail/linux/kernel/0410.0/0600.html
> 
> The big issue mentioned in that thread, that it reqires a key
> press during the resume process to keep going still exists and
> I have been unable to understand why.  The issue is in radeon_pm.c
> in this block that follows the last hunk of the diff:
> 
>         if (rinfo->no_schedule) {
>                 if (try_acquire_console_sem())
>                         return 0;
>         } else
>                 acquire_console_sem();
> 
> Specificly it's acquire_console_sem(); where the resume stops waiting
> for a key press.  What could be stopping things?

I don't see any reason for that. That definitely shouldn't happen.

   .../...

> diff -ru linux-2.6.12.orig/drivers/video/aty/radeon_pm.c
> linux-2.6.12/drivers/video/aty/radeon_pm.c
> --- linux-2.6.12.orig/drivers/video/aty/radeon_pm.c	2005-06-17
> 12:48:29.000000000 -0700
> +++ linux-2.6.12/drivers/video/aty/radeon_pm.c	2005-07-03
> 19:55:36.000000000 -0700
> @@ -2606,10 +2606,13 @@
> 
>   done:
>  	pdev->dev.power.power_state = state;
> +	pci_save_state (pdev);
> 
>  	return 0;
>  }

Hrm... radeonfb already saves the config space elsewhere. Note that it
could maybe be converted to pci_save_state() / pci_restore_state() but
currently, I do my own as I use that for "testing" if the card is still
in it's previous state or was shut down. (I could probably use the
content of a register instead, like CLK_PIN_CNTL)

> +extern void acpi_vgapost (unsigned long slot);
> +
>  int radeonfb_pci_resume(struct pci_dev *pdev)
>  {
>          struct fb_info *info = pci_get_drvdata(pdev);
> @@ -2619,6 +2622,12 @@
>  	if (pdev->dev.power.power_state == 0)
>  		return 0;
> 
> +	if (pdev->dev.power.power_state != 4)
> +	{
> +		pci_restore_state (pdev);
> +		acpi_vgapost (pdev->devfn);
> +	}
> +
>  	if (rinfo->no_schedule) {
>  		if (try_acquire_console_sem())
>  			return 0;

The above will probably blow up anything that is not an x86 with ACPI.
Besides there is already a mecanism in that file for calling functions
for re-posting cards (since I have code to explicitely re-post rv280 and
rv350 mobility on macs), you should hook into that existing mecanism
when you detect ACPI.

Ben.
 

