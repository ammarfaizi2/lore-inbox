Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261485AbVEPIkx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261485AbVEPIkx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 04:40:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261234AbVEPIeI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 04:34:08 -0400
Received: from fire.osdl.org ([65.172.181.4]:1457 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261467AbVEPH51 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 03:57:27 -0400
Date: Mon, 16 May 2005 00:56:39 -0700
From: Andrew Morton <akpm@osdl.org>
To: Adam Belay <ambx1@neo.rr.com>
Cc: kaneshige.kenji@jp.fujitsu.com, greg@kroah.org, pavel@ucw.cz,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Re: [patch] properly stop devices before poweroff
Message-Id: <20050516005639.274d13d1.akpm@osdl.org>
In-Reply-To: <20050501221637.GE3951@neo.rr.com>
References: <20050421111346.GA21421@elf.ucw.cz>
	<20050429061825.36f98cc0.akpm@osdl.org>
	<42752954.5050600@jp.fujitsu.com>
	<20050501221637.GE3951@neo.rr.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adam Belay <ambx1@neo.rr.com> wrote:
>
> On Mon, May 02, 2005 at 04:09:08AM +0900, Kenji Kaneshige wrote:
> > Hi,
> > 
> > Andrew Morton wrote:
> > >Pavel Machek <pavel@ucw.cz> wrote:
> > >
> > >>
> > >>Without this patch, Linux provokes emergency disk shutdowns and
> > >>similar nastiness. It was in SuSE kernels for some time, IIRC.
> > >>
> > >
> > >
> > >With this patch when running `halt -p' my ia64 Tiger (using
> > >tiger_defconfig) gets a stream of badnesses in iosapic_unregister_intr()
> > >and then hangs up.

A little reminder that this bug remains unfixed...

> > >Unfortunately it all seems to happen after the serial port has been
> > >disabled because nothing comes out.  I set the console to a squitty font
> > >and took a piccy.  See
> > >http://www.zip.com.au/~akpm/linux/patches/stuff/dsc02505.jpg
> > >
> > >I guess it's an ia64 problem.  I'll leave the patch in -mm for now.
> > >
> > 
> > I guess the stream of badness was occured as follows:
> > 
> >    pcibios_disable_device() for ia64 assumes that pci_enable_device()
> >    and pci_disable_device() are balanced. But with 'properly stop
> >    devices before power off' patch, pci_disable_device() becomes to be
> >    called twice for e1000 device at halt time, through reboot_notifier_list
> >    callback and through device_suspend(). As a result, 
> >    iosapic_unregister_intr()
> >    was called for already unregistered gsi and then stream of badness
> >    was displayed.
> > 
> > I think the following patch will remove this stream of badness. I'm
> > sorry but I have not checked if the stream of badness is actually
> > removed because I'm on vacation and I can't look at my display
> > (I'm working via remote console). Could you try this patch?
> > 
> > By the way, I don't think this stream of badness is related to hang up,
> > because the problem (hang up) was reproduced even on my test kernel that
> > doesn't call pcibios_disable_device().
> > 
> > Thanks,
> > Kenji Kaneshige
> > ---
> > 
> > 
> > There might be some cases that pci_disable_device() is called even if
> > the device is already disabled. In this case, pcibios_disable_device()
> > should not call acpi_pci_irq_disable() for the device.
> > 
> > Signed-off-by: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
> > 
> 
> Although this would solve the problem, it may or may not be the right thing to
> do.  The bug is not in pci_disable_device(), it's in the fact that we're
> calling pci_disable_device() twice.  Whether pci_disable_device() should ignore
> this or create an error is an implementation decision.  It might make sense to
> have it print a warning. Greg, what are your thoughts?
> 
> What's important is that we don't want to suspend the device twice (in this
> case suspend and reboot_notifier).
> 
> Thanks,
> Adam
> -
> To unsubscribe from this list: send the line "unsubscribe linux-ia64" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
