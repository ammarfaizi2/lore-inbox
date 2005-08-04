Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262317AbVHDJWX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262317AbVHDJWX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 05:22:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262373AbVHDJWX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 05:22:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:30362 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S262317AbVHDJWW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 05:22:22 -0400
Date: Thu, 4 Aug 2005 11:22:21 +0200
From: Andi Kleen <ak@suse.de>
To: James Cleverdon <jamesclv@us.ibm.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
       "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>
Subject: Re: [RFC][2.6.12.3] IRQ compression/sharing patch
Message-ID: <20050804092221.GL8266@wotan.suse.de>
References: <200507260012.41968.jamesclv@us.ibm.com> <20050726160319.GB5353@wotan.suse.de> <200508040005.50817.jamesclv@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200508040005.50817.jamesclv@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 04, 2005 at 12:05:50AM -0700, James Cleverdon wrote:

> diff -pruN 2.6.12.3/arch/i386/kernel/acpi/boot.c n12.3/arch/i386/kernel/acpi/boot.c
> --- 2.6.12.3/arch/i386/kernel/acpi/boot.c	2005-07-15 14:18:57.000000000 -0700
> +++ n12.3/arch/i386/kernel/acpi/boot.c	2005-08-04 00:01:10.199710211 -0700
> @@ -42,6 +42,7 @@
>  static inline void  acpi_madt_oem_check(char *oem_id, char *oem_table_id) { }
>  extern void __init clustered_apic_check(void);
>  static inline int ioapic_setup_disabled(void) { return 0; }
> +extern int gsi_irq_sharing(int gsi);
>  #include <asm/proto.h>
>  
>  #else	/* X86 */
> @@ -51,6 +52,9 @@ static inline int ioapic_setup_disabled(
>  #include <mach_mpparse.h>
>  #endif	/* CONFIG_X86_LOCAL_APIC */
>  
> +static inline int gsi_irq_sharing(int gsi) { return gsi; }

Why is this different for i386/x86-64? It shouldn't.

As a unrelated note we really need to get rid of this whole ifdef block.

> +++ n12.3/arch/x86_64/Kconfig	2005-08-03 21:31:07.487451167 -0700
> @@ -280,13 +280,13 @@ config HAVE_DEC_LOCK
>  	default y
>  
>  config NR_CPUS
> -	int "Maximum number of CPUs (2-256)"
> -	range 2 256
> +	int "Maximum number of CPUs (2-255)"
> +	range 2 255
>  	depends on SMP
> -	default "8"
> +	default "16"

Don't change the default please.

> +static int next_irq = 16;

Won't this need a lock for hotplug later?

> +
> + retry_vector:
> +	vector = assign_irq_vector(gsi);
> +
> +	/*
> +	 * Sharing vectors means sharing IRQs, so scan irq_vectors for previous
> +	 * use of vector and if found, return that IRQ.  However, we never want
> +	 * to share legacy IRQs, which usually have a different trigger mode
> +	 * than PCI.
> +	 */

Can we perhaps force such sharing early temporarily even when the table
is not filled up?  This way we would get better test coverage of all
of  this.

That would be later disabled of course.

Rest looks ok to me.

-Andi
