Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261219AbUJ3Rr2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261219AbUJ3Rr2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 13:47:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261220AbUJ3Rr1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 13:47:27 -0400
Received: from ylpvm29-ext.prodigy.net ([207.115.57.60]:26264 "EHLO
	ylpvm29.prodigy.net") by vger.kernel.org with ESMTP id S261219AbUJ3RrV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 13:47:21 -0400
From: David Brownell <david-b@pacbell.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: PCI changes kill USB PM
Date: Sat, 30 Oct 2004 10:44:25 -0700
User-Agent: KMail/1.6.2
Cc: Greg KH <greg@kroah.com>, Linux Kernel list <linux-kernel@vger.kernel.org>,
       Paul Mackerras <paulus@samba.org>, Andrew Morton <akpm@osdl.org>
References: <1099095245.29689.191.camel@gaston>
In-Reply-To: <1099095245.29689.191.camel@gaston>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200410301044.25476.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, you just saved me more headscratching ... :)


On Friday 29 October 2004 17:14, Benjamin Herrenschmidt wrote:
> 
> The recent PCI changes are killing USB Power Management, and maybe more.
> The problem is that the common PCI code will now always call
> pci_save_state() after calling the pci_driver->suspend().

Where "now" is "after a change from Arjan in May";
recent changes made it a more significant problem.

I agree with the guts of your patch -- adding the
missing "else" in:

	if (pci_driver && pci_driver->suspend)
		pci_driver->suspend(pdev, state);
	else
		pci_save_state(pdev);

That makes Arjan's patch only affect PCI drivers
which don't know how to suspend/resume themselves;
that's all his patch was supposed to affect.



> On wakeup, USB does pci_set_mater() then pci_restore_state().
> happen is that the later "undos" the work done by pci_set_master(),
> restoring a command register with PCI_COMMAND_MASTER clear. Bad bad bad.

That explains a problem I've been seeing with root hub lossage
after resume.  I was about to start digging deeper into this,
now that I've addressed EHCI and OHCI problems that show up
earlier for me (and some other PCI suspend/resume issues that
complicated them on different systems!), but this solves a
"DMA not working" symptom that I noticed after merging those
updates with RC1.

The relevant PCI PM code has changed semantics at least four
times since that bit of usbcore was written, but I'd only
noticed two of the changes ... :(


> There are 2 issues here. One is that USB should definitely call
> pci_set_master() _after_ pci_resume_state(), though it shouldn't need to
> call it at all ...

It shouldn't actually have mattered ... which
means it's safe to delete.  (I forget where that
sequence was copied from; too bad.)


> This patch takes cares of both, Andrew, do not apply before Ack from
> Greg since the change in the PCI code may affect some other things (I
> hope you didn't start removing calls to pci_save_state() from
> drivers ? :)

The PCI part looks essential to me, and just restores
previous (and long-documented!!) behavior ... if it
affects anything, it should be to make it work again.

The USB part is OK, but shouldn't be merged before
some more essential patches(*) to that file.

What I've done with your patch is updated it to apply
against a conflicting USB patch, and forwarded the
result to Greg (CC you and linux-usb-devel).  Or,
this could be handled as two separate one-liners.

- Dave

(*) http://marc.theaimsgroup.com/?l=linux-usb-devel&m=109881500807667&w=2


> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> 
> --- linux-work.orig/drivers/pci/pci-driver.c	2004-10-20 13:01:02.000000000 
+1000
> +++ linux-work/drivers/pci/pci-driver.c	2004-10-29 17:57:44.202118768 +1000
> @@ -308,8 +308,8 @@
>  	dev_state = state_conversion[state];
>  	if (drv && drv->suspend)
>  		i = drv->suspend(pci_dev, dev_state);
> -		
> -	pci_save_state(pci_dev);
> +	else
> +		pci_save_state(pci_dev);
>  	return i;
>  }
>  
> 
