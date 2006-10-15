Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752348AbWJODUE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752348AbWJODUE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Oct 2006 23:20:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752350AbWJODUE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Oct 2006 23:20:04 -0400
Received: from palinux.external.hp.com ([192.25.206.14]:42628 "EHLO
	mail.parisc-linux.org") by vger.kernel.org with ESMTP
	id S1752345AbWJODUC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Oct 2006 23:20:02 -0400
Date: Sat, 14 Oct 2006 21:20:01 -0600
From: Matthew Wilcox <matthew@wil.cx>
To: Andrew Morton <akpm@osdl.org>
Cc: Val Henson <val_henson@linux.intel.com>,
       Greg Kroah-Hartman <gregkh@suse.de>, netdev@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] [PCI] Check that MWI bit really did get set
Message-ID: <20061015032000.GP11633@parisc-linux.org>
References: <1160161519800-git-send-email-matthew@wil.cx> <20061013214135.8fbc9f04.akpm@osdl.org> <20061014140249.GL11633@parisc-linux.org> <20061014134855.b66d7e65.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061014134855.b66d7e65.akpm@osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 14, 2006 at 01:48:55PM -0700, Andrew Morton wrote:
> On Sat, 14 Oct 2006 08:02:49 -0600
> Matthew Wilcox <matthew@wil.cx> wrote:
> 
> > On Fri, Oct 13, 2006 at 09:41:35PM -0700, Andrew Morton wrote:
> > > Bisection shows that this patch
> > > (pci-check-that-mwi-bit-really-did-get-set.patch in Greg's PCI tree) breaks
> > > suspend-to-disk on my Vaio.  It writes the suspend image and gets to the
> > > point where it's supposed to power down, but doesn't.
> > 
> > How odd.  What driver is calling pci_set_mwi() on the suspend path?
> 
> ehci_pci_reinit().  I stuck a dump_stack() in there.  See
> http://userweb.kernel.org/~akpm/s5000342.jpg

Thanks for the picture; that's really helpful.

I see.  We hibernate all the devices then wake them all back up again.
No doubt there's a good reason for this.

Still doesn't make much sense, though.  As far as I can see, the only
consequence of this particular patch is that 1) we do an additional read
from PCI_COMMAND and 2) we can return -EINVAL in one additional case.
But the only effect of returning EINVAL is a printk (for this particular
driver):

        /* PCI Memory-Write-Invalidate cycle support is optional (uncommon) */
        retval = pci_set_mwi(pdev);
        if (!retval)
                ehci_dbg(ehci, "MWI active\n");

        ehci_port_power(ehci, 0);

        return 0;

So even if we return EINVAL ... big deal.

Is it possible reading PCI_COMMAND too quickly after writing it causes
a foul-up?  That would be weird ...

so I suppose there's a few things I can ask you to try:

1. Stop reading the register back altogether.  This should revert the behaviour to the prepatch state:

-       pci_read_config_word(dev, PCI_COMMAND, &cmd);
+//     pci_read_config_word(dev, PCI_COMMAND, &cmd);

2. Put an mdelay(1); before that line

3. Change the last line to just return 0.

-       return (cmd & PCI_COMMAND_INVALIDATE) ? 0 : -EINVAL;
+	return 0;

> > What drivers do you have loaded on the Vaio?
> 
> sony:/home/akpm> lsmod

I don't see any of the other drivers calling pci_set_mwi, so i guess we're
looking at the right suspect.


I feel rather guilty about the amount of time you're spending on this;
any bugs you want me to look at as penance?
