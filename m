Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261675AbUB0CZv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 21:25:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261704AbUB0CZu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 21:25:50 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.102]:26567 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261675AbUB0CZq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 21:25:46 -0500
Subject: Re: 2.6.3-mm3 hangs on  boot x440 (scsi?)
From: john stultz <johnstul@us.ibm.com>
To: Matthew Wilcox <willy@debian.org>
Cc: Go Taniguchi <go@turbolinux.co.jp>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20040226231550.GY25779@parcelfarce.linux.theplanet.co.uk>
References: <20040222172200.1d6bdfae.akpm@osdl.org>
	 <1077668801.2857.63.camel@cog.beaverton.ibm.com>
	 <20040224170645.392abcff.akpm@osdl.org> <403E0563.9050007@turbolinux.co.jp>
	 <1077830762.2857.164.camel@cog.beaverton.ibm.com>
	 <1077836576.2857.168.camel@cog.beaverton.ibm.com>
	 <20040226231550.GY25779@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain
Message-Id: <1077848731.10076.20.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Thu, 26 Feb 2004 18:25:32 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-02-26 at 15:15, Matthew Wilcox wrote:
> On Thu, Feb 26, 2004 at 03:02:56PM -0800, john stultz wrote:
> > On Thu, 2004-02-26 at 13:26, john stultz wrote:
> > > On Thu, 2004-02-26 at 06:40, Go Taniguchi wrote:
> > > > Hi,
> > > > 
> > > > Andrew Morton wrote:
> > > > > john stultz <johnstul@us.ibm.com> wrote:
> > > > >>I went back to 2.6.3-mm1 (as it was a smaller diff) and the problem was
> > > > >>there as well. 
> > > > 
> > > > Problem patch is expanded-pci-config-space.patch.
> > > > x440 can not enable acpi by dmi_scan.
> > > > expanded-pci-config-space.patch need acpi support.
> > > > So, kernel can not get x440's xAPIC interrupt.
> > > 
> > > Wow, thanks for that analysis Go! I'll test it here to confirm. 
> > 
> > Yep, I've confirmed that backing out the expanded-pci-config-space patch
> > solves it. Thanks again, Go, for hunting that down! 
> > 
> > Matthew, any ideas why the patch fails if the system has an ACPI
> > blacklist entry?
> 
> Hrm.  I was just asked to break out some of the ACPI code rearrangement
> from the rest of the patch.  Can you try this patch instead of the
> expanded-pci-config-space.patch and tell me whether it continues to fail
> for you?
> 
> I don't understand why it should make a difference though.  It looks
> to me like the current code will also fail to call the HPET code if the
> bios is blacklisted.

Ok, think I found it!



> Index: arch/i386/kernel/acpi/boot.c
> ===================================================================
> RCS file: /var/cvs/linux-2.6/arch/i386/kernel/acpi/boot.c,v
> retrieving revision 1.10
> diff -u -p -r1.10 boot.c
> --- a/arch/i386/kernel/acpi/boot.c	17 Feb 2004 12:51:46 -0000	1.10
> +++ b/arch/i386/kernel/acpi/boot.c	26 Feb 2004 16:34:12 -0000
> @@ -506,24 +461,17 @@ acpi_boot_init (void)
>  
>  	acpi_lapic = 1;
>  
> -#endif /*CONFIG_X86_LOCAL_APIC*/
> +#endif /* CONFIG_X86_LOCAL_APIC */
>  
>  #if defined(CONFIG_X86_IO_APIC) && defined(CONFIG_ACPI_INTERPRETER)
>  
>  	/* 
>  	 * I/O APIC 
> -	 * --------
>  	 */
>  
> -	/*
> -	 * ACPI interpreter is required to complete interrupt setup,
> -	 * so if it is off, don't enumerate the io-apics with ACPI.
> -	 * If MPS is present, it will handle them,
> -	 * otherwise the system will stay in PIC mode
> -	 */
> -	if (acpi_disabled || acpi_noirq) {
> +	if (acpi_noirq) {
>  		return 1;
> -        }
> +	}
>  
>  	/*
>   	 * if "noapic" boot option, don't look for IO-APICs


That chunk shouldn't drop the "if (acpi_disabled ..." bit.
Adding that check back in fixes it for me.

thanks
-john



