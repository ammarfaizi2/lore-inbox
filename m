Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261466AbVAGPiI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261466AbVAGPiI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 10:38:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261464AbVAGPhn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 10:37:43 -0500
Received: from wproxy.gmail.com ([64.233.184.205]:22037 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261462AbVAGPe5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 10:34:57 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=AbXgdP7EJqKROA2jslbAu/AG1jsgHNdqnGxlS4o3oEMeRq/Z2EkN7z4kw4vQvpVpc5XNez4TIVr7Xf20wyD4xnGwHcVKxSza4m+vTHUN48Xg7aZn3Zddn5aT0Nxr5XgLNzkwwLt+dLAD1ZcoL/bijBZSriJ0T3LAhNKldUyweqs=
Message-ID: <58cb370e05010707344347f84@mail.gmail.com>
Date: Fri, 7 Jan 2005 16:34:56 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: "Prakash K. Cheemplavam" <prakashkc@gmx.de>
Subject: Re: [PATCH] Re: APIC/LAPIC hanging problems on nForce2 system.
Cc: Andrew Morton <akpm@osdl.org>, drab@kepler.fjfi.cvut.cz,
       linux-kernel@vger.kernel.org
In-Reply-To: <41DE9466.50006@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <Pine.LNX.4.60.0501051604200.24191@kepler.fjfi.cvut.cz>
	 <41DC2353.7010206@gmx.de>
	 <Pine.LNX.4.60.0501060046450.26952@kepler.fjfi.cvut.cz>
	 <41DCFEF0.5050105@gmx.de> <58cb370e05010605527f87297e@mail.gmail.com>
	 <41DD537B.9030304@gmx.de> <20050106154650.33c3b11c.akpm@osdl.org>
	 <41DDD7C3.8040406@gmx.de> <20050106164952.0a46df7e.akpm@osdl.org>
	 <41DE9466.50006@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 07 Jan 2005 14:53:42 +0100, Prakash K. Cheemplavam
<prakashkc@gmx.de> wrote:
> Andrew Morton schrieb:
> > "Prakash K. Cheemplavam" <prakashkc@gmx.de> wrote:
> >
> >>Perhaps firfox fscked up the inlined patch, so please
> >>try the attached version. If it goes alright, I'll resubmit it,
> >>inlcuding more detailed description.
> >
> >
> > There was no attachment.
> 
> *sigh* Not in my last email, but when I submitted the patch...
> 
> > Please go ahead and prepare a final patch against Linus's latest tree.  The
> > simplest way to obtain that is via the topmost link at
> > http://www.kernel.org/pub/linux/kernel/v2.5/testing/cset/.
> 
> It applies cleanly there. Nevertheless, once again, with more details.
> If inlined version doesn't patch, please try attached!
> 
> current state:
> Systems with Nforce2 could freeze on high disk i/o activity in APIC mode
> when CPU Disconnect is enabled. If bios doesn't fix this, current kernel
> fix changes the registers according to follwing table:
> 
>       * Chip  Old value   New value
>       * C17   0x1F0FFF01  0x1F01FF01
>       * C18D  0x9F0FFF01  0x9F01FF01
> 
> But this is only done, if cpu disconnect has been enabled in bios.
> 
> why change this:
> If CPU disconnect is not enabled in bios, and bios is broken (some
> manufacturers like Abit don't care about their customers and even the
> latest bios doesn't fix this; I have an Abit mainboard), the kernel
> doesn't apply the fix, so if cpu disconnect is enabled at a later stage
> (in userspace), the system will be unstable and most likely freeze.
> 
> new behaviour:
> The fix is now applied regardless of cpu disconnect being enabled at
> boot time, or not. As you only have to change byte 3 to 0x01, reading
> out chipset version isn't needed, so the patch simplifies the fix. Now
> turning cpu disconnect on, at later stage won't break the system, and if
> it was already enabled, it gets fixed, as the old version did.
> 
> 
> Signed-off-by: Prakash Punnoor <prakashp@arcor.de>

Patch looks fine (thanks!) and since I added the original quirk...

Acked-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

> --- arch/i386/pci/fixup.c.o     2005-01-06 15:43:40.535842320 +0100
> +++ arch/i386/pci/fixup.c       2005-01-06 16:00:50.174313480 +0100
> @@ -227,10 +227,7 @@
>    */
>   static void __init pci_fixup_nforce2(struct pci_dev *dev)
>   {
> -       u32 val, fixed_val;
> -       u8 rev;
> -
> -       pci_read_config_byte(dev, PCI_REVISION_ID, &rev);
> +       u32 val;
> 
>         /*
>          * Chip  Old value   New value
> @@ -240,17 +237,14 @@
>          * Northbridge chip version may be determined by
>          * reading the PCI revision ID (0xC1 or greater is C18D).
>          */
> -       fixed_val = rev < 0xC1 ? 0x1F01FF01 : 0x9F01FF01;
> -
>         pci_read_config_dword(dev, 0x6c, &val);
> 
>         /*
> -        * Apply fixup only if C1 Halt Disconnect is enabled
> -        * (bit28) because it is not supported on some boards.
> +        * Apply fixup if needed, but don't touch disconnect state
>          */
> -       if ((val & (1 << 28)) && val != fixed_val) {
> +       if ((val & 0x00FF0000) != 0x00010000) {
>                 printk(KERN_WARNING "PCI: nForce2 C1 Halt Disconnect fixup\n");
> -               pci_write_config_dword(dev, 0x6c, fixed_val);
> +               pci_write_config_dword(dev, 0x6c, (val & 0xFF00FFFF) | 0x00010000);
>         }
>   }
>   DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_NVIDIA,
> PCI_DEVICE_ID_NVIDIA_NFORCE2, pci_fixup_nforce2);
