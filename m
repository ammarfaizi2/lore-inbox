Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262405AbUKKXe7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262405AbUKKXe7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 18:34:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262541AbUKKX3V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 18:29:21 -0500
Received: from fmr05.intel.com ([134.134.136.6]:32400 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S262443AbUKKX0K
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 18:26:10 -0500
Subject: Re: [PATCH] fix  platform_rename_gsi related ia32 build breakage
From: Len Brown <len.brown@intel.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Natalie Protasevich <Natalie.Protasevich@UNISYS.com>,
       Bjorn Helgaas <bjorn.helgaas@hp.com>
In-Reply-To: <Pine.LNX.4.58.0411111427050.2301@ppc970.osdl.org>
References: <4192A959.9020806@conectiva.com.br>
	 <4192A9BF.2080606@conectiva.com.br> <4192ADF4.1050907@conectiva.com.br>
	 <Pine.LNX.4.58.0411101621020.2301@ppc970.osdl.org>
	 <1100211749.5510.753.camel@d845pe>
	 <Pine.LNX.4.58.0411111427050.2301@ppc970.osdl.org>
Content-Type: text/plain
Organization: 
Message-Id: <1100215538.5876.779.camel@d845pe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 11 Nov 2004 18:25:38 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-11-11 at 17:30, Linus Torvalds wrote:
> 
> On Thu, 11 Nov 2004, Len Brown wrote:
> >
> > I used a function pointer here because the same kernel binary must
> be
> > able to run on an ES7000 or a non-ES7000, so the compile-time inline
> > idiom doesn't work.
> 
> Sure it does. Do something like this in a header file
> 
>         static inline int translate_irq_number(...)
>         {
>                 #ifdef CONFIG_ACPI_BOOT
>                         return fn_ptr_xxx();
>                 #else
>                         return irq;
>                 #endif
>         }

sure, we could add a wrapper for the wrapper,
but the ifdefs are already gone without doing this --
platform_rename_gsi is present with or without ACPI.

I suppose I could shrink the kernel by 4-bytes by compiling out the
function pointer when IO_APIC is not defined.  I'll be happy to optimize
for that case if you think it justifies the code; though if I were
optimizing for that case, this probably isn't where I'd start.

> which means that yes, it uses the function pointer when it is
> meaningful, but if there is no point, the code just goes away.
> 
> > If you read this far and have suggestions for a more descriptive
> name than platform_rename_gsi(), just let me know.
> 
> At _least_ write out what the hell "gsi" is.
> 
> TLA's are bad. "gsi" apparently isn't the Geological Survey of
> Ireland, but that's all I can tell from google.

The _gsi in platform_rename_gsi was consistent with the surrounding use
in the ACPI case.  I decided to re-use the same funtion for the MPS case
for simplicity, even though io_apic.c uses _irq.  If you like, I can add
a synonym using an inline for _irq, but I thought we were moving away
from using _irq, not towards it.

GSI = Global System Interrupt
IRQ = overused so much it means nothing at all

While this fact may not win you over as a fan, GSI is actually
consistent with the language in the ACPI spec.  I don't know if that is
where Bjorn came up with the name, but I do think it was a positive
change.  The reason is that "global" actually means something -- and it
still has the same semantics no matter if your machine passes around cpu
interrupt vectors or if it passes around pin numbers.

cheers,
-Len


