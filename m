Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262487AbUKVTjM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262487AbUKVTjM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 14:39:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262364AbUKVTh3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 14:37:29 -0500
Received: from fmr01.intel.com ([192.55.52.18]:18831 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id S262644AbUKVTar (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 14:30:47 -0500
Subject: Re: 2.6.10-rc2 doesn't boot (if no floppy device)
From: Len Brown <len.brown@intel.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Adrian Bunk <bunk@stusta.de>, Chris Wright <chrisw@osdl.org>,
       Bjorn Helgaas <bjorn.helgaas@hp.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0411200940410.20993@ppc970.osdl.org>
References: <20041115152721.U14339@build.pdx.osdl.net>
	 <1100819685.987.120.camel@d845pe> <20041118230948.W2357@build.pdx.osdl.net>
	 <1100941324.987.238.camel@d845pe> <20041120124001.GA2829@stusta.de>
	 <Pine.LNX.4.58.0411200940410.20993@ppc970.osdl.org>
Content-Type: text/plain
Organization: 
Message-Id: <1101151780.20006.69.camel@d845pe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 22 Nov 2004 14:29:40 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-11-20 at 13:28, Linus Torvalds wrote:
> 
> On Sat, 20 Nov 2004, Adrian Bunk wrote:
> >
> > With your patch, the boot failure goes away.
> > This was with a kernel without Linus' patch applied.
> 
> It boots for me too, but it all seems pretty accidental.
> 
> In particular, the code will disable irq12 (mouse interrupt), so the
> mouse has no chance of working. Having tested it, it so happens that
> if I boot with a mouse actually conntected, the BIOS will not use
> irq12 for PCI devices, so that will hide the problem since ACPI won't
> try to disable it when it doesn't see it.

This is not an accident that is being hidden by mistake.
The BIOS probes for the legacy mouse.

If it finds one, it gives it IRQ12.
If it doesn't find one it gives IRQ12 to PCI.

Other BIOS's are not as good as these and they don't give the free IRQs
to PCI.  Sub-optimal, but perfectly legal.

Exact same situation Chris and Adrian see with the floppy and IRQ6.
Exact same situation could potentially be seen with any motherboard
device and any IRQ -- except, of course, those that can't be probed or
are otherwise hard-coded for well known legacy devices, such as the RTC
on IRQ8.

> But if I had more PCI devices, or another legacy device that doesn't
> have the same kind of "test if something is connected" logic, it
> really looks like it would break again. (It's entirely possible that
> Windows has the exact same issue, of course, at which point it's
> fairly safe to say that manufacturers will have tested this and just
> not done it, but I don't feel all that safe making that assumption).

Windows uses ACPI to probe the legacy motherboard devices, and ACPI uses
what the BIOS finds.  If the BIOS and ACPI don't know about the
motherboard device, then it isn't an ACPI system and among other
failures, it would never have got a nifty Made for Windows sticker, and
thus would have market penetration of approximately 0.

Linux is just now learning to use ACPI for probing legacy motherboard
devices.  I believe that this transition can be made safely and that
legacy probes should continue to work both during and after the
transition.

> So I think the simpler fix is just this one-liner: we should not
> disable preexisting links, because non-PCI devices may depend on the
> same routing information, and thus the comments about "being activated
> on use" is not actually true.
> 

>                 Linus
> 
> ===== drivers/acpi/pci_link.c 1.34 vs edited =====
> --- 1.34/drivers/acpi/pci_link.c        2004-11-01 23:40:09 -08:00
> +++ edited/drivers/acpi/pci_link.c      2004-11-20 09:43:56 -08:00
> @@ -685,9 +685,6 @@
>         acpi_link.count++;
> 
>  end:
> -       /* disable all links -- to be activated on use */
> -       acpi_ut_evaluate_object(link->handle, "_DIS", 0, NULL);
> -
>         if (result)
>                 kfree(link);

This is not a fix, it will break systems in the field.

When we enable a link, we must set the ELCR.
When we disable a link, we must clear the ELCR.
We need to be able to enable and disable all links in the system.

The bug was that while we were were setting the ELCR
when we enabled a link, we were not clearing it when we disabled one.

We also have an issue when we move the destiation of a link,
though we don't do that very often.

My debug patch cleared every bit in the ELCR even if no PCI interrupt
link device pointed to that entry.  Yes, this assumes that ACPI knows
about every level triggered interrupt in the system.

I think that is a valid assumption on an ACPI-compliant system.

But if you're more comfortable with disabling the associated ELCR bit
only when we disable links directed at that entry, we can do that too. 
The complication with that approach is that links are many to one, so
clearing the bit without disabling all links directed to that entry
would result in a failure.  Also, the SCI uses the ELCR too, and it
isn't described by links at all.

-Len


