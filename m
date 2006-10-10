Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932312AbWJJKjZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932312AbWJJKjZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 06:39:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751558AbWJJKjY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 06:39:24 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:39613 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751493AbWJJKjY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 06:39:24 -0400
Date: Tue, 10 Oct 2006 12:39:10 +0200
From: Pavel Machek <pavel@ucw.cz>
To: =?iso-8859-1?Q?Fr=E9d=E9ric?= Riss <frederic.riss@gmail.com>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, len.brown@intel.com
Subject: Re: 2.6.18 suspend regression on Intel Macs
Message-ID: <20061010103910.GD31598@elf.ucw.cz>
References: <1160417982.5142.45.camel@funkylaptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1160417982.5142.45.camel@funkylaptop>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Well, I'm not sure it qualifies as a regression, because AFAIK no
> official kernels can s2ram/resume Intel Macs correctly out of the box.
...

> There has already been some discussion about the SCI_EN ACPI control bit
> not being set when the Mactel boxes come out of suspend to ram. 
> http://marc.theaimsgroup.com/?l=linux-acpi&m=114957637501557&w=2
> http://marc.theaimsgroup.com/?l=linux-kernel&m=115005083610700&w=2
> http://bugme.osdl.org/show_bug.cgi?id=6670
> 
> The symptom is:
>     irq 9: nobody cared (try booting with the "irqpoll" option)
>     Disabling IRQ #9
> when the system comes out of sleep, making ACPI non-functional.
> 
> Two days after having released 2.6.17, Linus commited a fix for this
> issue in his tree (commit 5603509137940f4cbc577281cee62110d4097b1b):

If fix was in 2.6.18-gitX, yes, that probably counts as a regression.

> I since then used lightly patched 2.6.17 kernels on my MacMini without a
> problem. With the release of 2.6.18, I decided to switch to a vanilla
> kernel but I realized that the above issue reappeared. 
> 
> I tracked it down to the ACPI merge that took place on July 1st. More
> precisely the commit 967440e3be1af06ad4dc7bb18d2e3c16130fe067 (ACPI:
> ACPICA 20060623) contains the following hunk:
> 
> @@ -635,6 +663,25 @@ acpi_status acpi_hw_register_write(u8 us
>  
>  	case ACPI_REGISTER_PM1_CONTROL:	/* 16-bit access */
>  
> +		/*
> +		 * Perform a read first to preserve certain bits (per ACPI spec)
> +		 *
> +		 * Note: This includes SCI_EN, we never want to change this bit
> +		 */
> +		status = acpi_hw_register_read(ACPI_MTX_DO_NOT_LOCK,
> +					       ACPI_REGISTER_PM1_CONTROL,
> +					       &read_value);
> +		if (ACPI_FAILURE(status)) {
> +			goto unlock_and_exit;
> +		}
> +
> +		/* Insert the bits to be preserved */
> +
> +		ACPI_INSERT_BITS(value, ACPI_PM1_CONTROL_PRESERVED_BITS,
> +				 read_value);
> +
> +		/* Now we can write the data */
> +
>  		status =
>  		    acpi_hw_low_level_write(16, value,
>  					    &acpi_gbl_FADT->xpm1a_cnt_blk);
> 
> 
> which makes Linus' fix a no-op, because it disallows setting the SCI_EN
> bit.

Okay, just submit a (tested) patch. (And add massive comments why it
is neccessary on mac mini).
									Pavel	

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
