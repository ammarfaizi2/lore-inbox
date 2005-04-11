Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261833AbVDKRSB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261833AbVDKRSB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 13:18:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261863AbVDKRSB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 13:18:01 -0400
Received: from fmr23.intel.com ([143.183.121.15]:14218 "EHLO
	scsfmr003.sc.intel.com") by vger.kernel.org with ESMTP
	id S261833AbVDKRRY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 13:17:24 -0400
Subject: Re: [PATCH] Fix reloading GDT on ACPI S3 wakeup
From: Len Brown <len.brown@intel.com>
To: Juerg Billeter <juerg@paldo.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1112976854.8880.15.camel@juerg-p4.bitron.ch>
References: <1112976854.8880.15.camel@juerg-p4.bitron.ch>
Content-Type: text/plain
Organization: 
Message-Id: <1113239836.2418.38.camel@d845pe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 11 Apr 2005 13:17:16 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've applied Nickolai's patch -- thanks for the ping.

-Len

On Fri, 2005-04-08 at 12:14, Juerg Billeter wrote:
> Hi
> 
> This patch - based on
> http://marc.theaimsgroup.com/?l=linux-kernel&m=110055503031009&w=2 -
> makes ACPI S3 wakeup work for me on a ThinkPad T40p laptop with a SMP
> kernel. Without it only UP kernels work. I've been using the patch for
> three months now without any issues.
> 
> The ACPI resume code currently uses a real-mode 16-bit lgdt
> instruction
> to reload the GDT.  This only restores the lower 24 bits of the GDT
> base
> address.  In recent SMP kernels, the GDT seems to have moved out of
> the
> lower 16 megs, thereby causing the ACPI resume to fail -- an invalid
> GDT
> was being loaded.
> 
> Regards,
> 
> Juerg
> 
> --
> Signed-off-by: Juerg Billeter <juerg@paldo.org>
> 
> diff -uNr linux-2.6.10.orig/arch/i386/kernel/acpi/wakeup.S
> linux-2.6.10/arch/i386/kernel/acpi/wakeup.S
> --- linux-2.6.10.orig/arch/i386/kernel/acpi/wakeup.S    2004-12-24
> 22:34:26.000000000 +0100
> +++ linux-2.6.10/arch/i386/kernel/acpi/wakeup.S 2005-01-08
> 23:34:38.551471486 +0100
> @@ -74,8 +74,9 @@
>         movw    %ax,%fs
>         movw    $0x0e00 + 'i', %fs:(0x12)
>        
> -       # need a gdt
> -       lgdt    real_save_gdt - wakeup_code
> +       # need a gdt -- use lgdtl to force 32-bit operands, in case
> +       # the GDT is located past 16 megabytes
> +       lgdtl   real_save_gdt - wakeup_code
> 
>         movl    real_save_cr0 - wakeup_code, %eax
>         movl    %eax, %cr0
> 
> 
> 
> 

