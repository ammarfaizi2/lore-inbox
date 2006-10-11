Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030654AbWJKGc4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030654AbWJKGc4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 02:32:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030661AbWJKGc4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 02:32:56 -0400
Received: from hera.kernel.org ([140.211.167.34]:11753 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1030654AbWJKGcz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 02:32:55 -0400
From: Len Brown <len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: 2.6.18 suspend regression on Intel Macs
Date: Wed, 11 Oct 2006 02:35:02 -0400
User-Agent: KMail/1.8.2
Cc: Pavel Machek <pavel@ucw.cz>,
       =?iso-8859-1?q?Fr=E9d=E9ric_Riss?= <frederic.riss@gmail.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
References: <1160417982.5142.45.camel@funkylaptop> <20061010195022.GA32134@elf.ucw.cz> <Pine.LNX.4.64.0610101447270.3952@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0610101447270.3952@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610110235.02435.len.brown@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 10 October 2006 17:49, Linus Torvalds wrote:
> 
> On Tue, 10 Oct 2006, Pavel Machek wrote:
> > 
> > Maybe you can just create a patch that modifies ACPI not to mask the
> > SCI bit? Reverting big chunk of ACPI code is likely not the right
> > solution.
> 
> I'm going to apply this after I've confirmed that it fixes the Mac Mini.

It is troubling that Linux now gets to add the burden of MacOS bug compatibility to
Windows bug compatibility.  I asked the apple folks and they
said they didn't see anyplace in MacOS where SCI_EN is restored
from the OS, so perhaps we are following a different path through
their firmware...

I don't think the risk here isn't that setting SCI_EN is going to break something.
The risk is that excluding it from ACPI_PM1_CONTROL_PRESERVED_BITS
will allow other writes to this register to clear that bit from the OS,
which is clearly counter to what the spec says to do.

But I looked through bugzilla to see if there are any systems whose
SCI isn't working, and I did not find any systems where the old
behaviour of not explicitly preserving SCI_EN breaks the SCI.

> It would be nice if somebody documented what the heck that "bit 9" 
> actually is that we're trying to preserve. I wonder if that one is any 
> better..

All I know is that bit 9 is to be "Ignored", which the spec says to preserve
along with other "Reserved" hardware register bits -- so we should
keep bit 9 in the mask.
 
> It's entirely possible that what we should do in acpi_hw_register_write() 
> is to always force SCI_EN to be on, but in the meantime, this would seem 
> to be the minimal fix that undoes the damage done by the ACPI merge.

Lets stick with the minimum patch until we learn more.

thanks,
-Len

Acked-by: Len Brown <len.brown@intel.com>

> 		Linus
> 
> ---
> diff --git a/drivers/acpi/hardware/hwregs.c b/drivers/acpi/hardware/hwregs.c
> index 3143f36..fa58c1e 100644
> --- a/drivers/acpi/hardware/hwregs.c
> +++ b/drivers/acpi/hardware/hwregs.c
> @@ -665,8 +665,6 @@ acpi_status acpi_hw_register_write(u8 us
>  
>  		/*
>  		 * Perform a read first to preserve certain bits (per ACPI spec)
> -		 *
> -		 * Note: This includes SCI_EN, we never want to change this bit
>  		 */
>  		status = acpi_hw_register_read(ACPI_MTX_DO_NOT_LOCK,
>  					       ACPI_REGISTER_PM1_CONTROL,
> diff --git a/include/acpi/aclocal.h b/include/acpi/aclocal.h
> index a4d0e73..063c4b5 100644
> --- a/include/acpi/aclocal.h
> +++ b/include/acpi/aclocal.h
> @@ -708,7 +708,7 @@ struct acpi_bit_register_info {
>   * must be preserved.
>   */
>  #define ACPI_PM1_STATUS_PRESERVED_BITS          0x0800	/* Bit 11 */
> -#define ACPI_PM1_CONTROL_PRESERVED_BITS         0x0201	/* Bit 9, Bit 0 (SCI_EN) */
> +#define ACPI_PM1_CONTROL_PRESERVED_BITS         0x0200	/* Bit 9 (whatever) */
>  
>  /*
>   * Register IDs
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
