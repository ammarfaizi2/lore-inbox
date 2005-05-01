Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261189AbVEAWV2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261189AbVEAWV2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 May 2005 18:21:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261186AbVEAWV2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 May 2005 18:21:28 -0400
Received: from HELIOUS.MIT.EDU ([18.248.3.87]:34482 "EHLO neo.rr.com")
	by vger.kernel.org with ESMTP id S261178AbVEAWVU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 May 2005 18:21:20 -0400
Date: Sun, 1 May 2005 18:16:37 -0400
From: Adam Belay <ambx1@neo.rr.com>
To: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>, greg@kroah.org
Cc: Andrew Morton <akpm@osdl.org>, Pavel Machek <pavel@ucw.cz>,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Re: [patch] properly stop devices before poweroff
Message-ID: <20050501221637.GE3951@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>, greg@kroah.org,
	Andrew Morton <akpm@osdl.org>, Pavel Machek <pavel@ucw.cz>,
	linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
References: <20050421111346.GA21421@elf.ucw.cz> <20050429061825.36f98cc0.akpm@osdl.org> <42752954.5050600@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42752954.5050600@jp.fujitsu.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 02, 2005 at 04:09:08AM +0900, Kenji Kaneshige wrote:
> Hi,
> 
> Andrew Morton wrote:
> >Pavel Machek <pavel@ucw.cz> wrote:
> >
> >>
> >>Without this patch, Linux provokes emergency disk shutdowns and
> >>similar nastiness. It was in SuSE kernels for some time, IIRC.
> >>
> >
> >
> >With this patch when running `halt -p' my ia64 Tiger (using
> >tiger_defconfig) gets a stream of badnesses in iosapic_unregister_intr()
> >and then hangs up.
> >
> >Unfortunately it all seems to happen after the serial port has been
> >disabled because nothing comes out.  I set the console to a squitty font
> >and took a piccy.  See
> >http://www.zip.com.au/~akpm/linux/patches/stuff/dsc02505.jpg
> >
> >I guess it's an ia64 problem.  I'll leave the patch in -mm for now.
> >
> 
> I guess the stream of badness was occured as follows:
> 
>    pcibios_disable_device() for ia64 assumes that pci_enable_device()
>    and pci_disable_device() are balanced. But with 'properly stop
>    devices before power off' patch, pci_disable_device() becomes to be
>    called twice for e1000 device at halt time, through reboot_notifier_list
>    callback and through device_suspend(). As a result, 
>    iosapic_unregister_intr()
>    was called for already unregistered gsi and then stream of badness
>    was displayed.
> 
> I think the following patch will remove this stream of badness. I'm
> sorry but I have not checked if the stream of badness is actually
> removed because I'm on vacation and I can't look at my display
> (I'm working via remote console). Could you try this patch?
> 
> By the way, I don't think this stream of badness is related to hang up,
> because the problem (hang up) was reproduced even on my test kernel that
> doesn't call pcibios_disable_device().
> 
> Thanks,
> Kenji Kaneshige
> ---
> 
> 
> There might be some cases that pci_disable_device() is called even if
> the device is already disabled. In this case, pcibios_disable_device()
> should not call acpi_pci_irq_disable() for the device.
> 
> Signed-off-by: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
> 

Although this would solve the problem, it may or may not be the right thing to
do.  The bug is not in pci_disable_device(), it's in the fact that we're
calling pci_disable_device() twice.  Whether pci_disable_device() should ignore
this or create an error is an implementation decision.  It might make sense to
have it print a warning. Greg, what are your thoughts?

What's important is that we don't want to suspend the device twice (in this
case suspend and reboot_notifier).

Thanks,
Adam
