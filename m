Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263459AbTEGOmA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 10:42:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263489AbTEGOmA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 10:42:00 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:25504 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263459AbTEGOl6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 10:41:58 -0400
Content-Type: text/plain; charset=US-ASCII
From: James Cleverdon <jamesclv@us.ibm.com>
Reply-To: jamesclv@us.ibm.com
Organization: IBM xSeries Linux Solutions
To: john stultz <johnstul@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] linux-2.5.69_clear-smi-fix_A0
Date: Wed, 7 May 2003 07:54:08 -0700
User-Agent: KMail/1.4.3
Cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       Andrew Grover <andrew.grover@intel.com>
References: <1052258319.4503.7.camel@w-jstultz2.beaverton.ibm.com>
In-Reply-To: <1052258319.4503.7.camel@w-jstultz2.beaverton.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200305070754.08881.jamesclv@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John,

That looks reasonable to me.  The one possible catch would be for systems so 
old they don't do SMI -- 386s and 486s, I imagine.  If this code doesn't barf 
on them when CONFIG_IO_APIC is turned on, then it should be fine (minus the 
printk).

(I believe there was at least one such system, the Intel Xpress box.  It 
contained a 486 and seperate APIC chips.)

		James

On Tuesday 06 May 2003 02:58 pm, john stultz wrote:
> All,
> 	I've been having problems with ACPI on a box here in our lab, it ends
> up that when we clear_IO_APIC() at boot time, we clear the SMI pin that
> is setup by the BIOS. This basically clobbers the SMI and we can then
> never make the transition into ACPI mode.
>
> I'm not sure if this is the right solution, but I figured I'd post it
> and take the flamage if I'm just being dumb. Basically in
> clear_IO_APIC_pin, I read the apic entry to make sure the delivery_mode
> isn't dest_SMI. If it is, we leave the apic entry alone and return.
>
> With this patch, the box boots and SMIs appear to function properly.
>
> Let me know if you have any thoughts or suggestions.
>
> thanks
> -john
>
>
> diff -Nru a/arch/i386/kernel/io_apic.c b/arch/i386/kernel/io_apic.c
> --- a/arch/i386/kernel/io_apic.c	Tue May  6 14:46:58 2003
> +++ b/arch/i386/kernel/io_apic.c	Tue May  6 14:46:58 2003
> @@ -219,6 +219,14 @@
>  {
>  	struct IO_APIC_route_entry entry;
>  	unsigned long flags;
> +
> +	/* Check delivery_mode to be sure we're not clearing an SMI pin */
> +	*(((int*)&entry) + 0) = io_apic_read(apic, 0x10 + 2 * pin);
> +	*(((int*)&entry) + 1) = io_apic_read(apic, 0x11 + 2 * pin);
> +	if (entry.delivery_mode == dest_SMI){
> +		printk(KERN_INFO "apic %i pin %i is an SMI pin!\n", apic, pin);
> +		return;
> +	}
>
>  	/*
>  	 * Disable it in the IO-APIC irq-routing table:

-- 
James Cleverdon
IBM xSeries Linux Solutions
{jamesclv(Unix, preferred), cleverdj(Notes)} at us dot ibm dot com

