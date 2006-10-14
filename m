Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932099AbWJNFfx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932099AbWJNFfx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Oct 2006 01:35:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932100AbWJNFfx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Oct 2006 01:35:53 -0400
Received: from cantor2.suse.de ([195.135.220.15]:65465 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932099AbWJNFfw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Oct 2006 01:35:52 -0400
Date: Fri, 13 Oct 2006 22:35:24 -0700
From: Greg KH <gregkh@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Matthew Wilcox <matthew@wil.cx>, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [PCI] Prevent user config space access during power state transitions
Message-ID: <20061014053524.GA8118@suse.de>
References: <1160487497203-git-send-email-matthew@wil.cx> <20061013222608.660d9a96.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061013222608.660d9a96.akpm@osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 13, 2006 at 10:26:08PM -0700, Andrew Morton wrote:
> On Tue, 10 Oct 2006 07:38:17 -0600
> Matthew Wilcox <matthew@wil.cx> wrote:
> 
> > Section 5.3 of PCI Bus Power Management 1.2 states:
> > 
> >   There is a minimum recovery time requirement of 200 ?s between when
> >   a function is programmed from D2 to D0 and when the function can be
> >   next accessed as a target (including PCI configuration accesses). If
> >   an access is attempted in violation of the specified minimum recovery
> >   time, undefined system behavior may result.
> > 
> > We have to prevent the user running lspci during this time, and
> > fortunately we already have the pci_block_user_cfg_access() API to
> > do this.
> > 
> > Signed-off-by: Matthew Wilcox <matthew@wil.cx>
> > ---
> >  drivers/pci/pci.c |    8 ++++++++
> >  1 files changed, 8 insertions(+), 0 deletions(-)
> > 
> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > index a544997..1bb059a 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -366,6 +366,11 @@ pci_set_power_state(struct pci_dev *dev,
> >  		break;
> >  	}
> >  
> > +	/* We have to prevent accesses to config space while transitioning
> > +	 * between power states
> > +	 */
> > +	pci_block_user_cfg_access(dev);
> > +
> >  	/* enter specified state */
> >  	pci_write_config_word(dev, pm + PCI_PM_CTRL, pmcsr);
> >  
> > @@ -383,6 +388,9 @@ pci_set_power_state(struct pci_dev *dev,
> >  	if (platform_pci_set_power_state)
> >  		platform_pci_set_power_state(dev, state);
> >  
> > +	/* Should be safe to allow userspace access to the device again now */
> > +	pci_unblock_user_cfg_access(dev);
> > +
> >  	dev->current_state = state;
> >  
> >  	/* According to section 5.4.1 of the "PCI BUS POWER MANAGEMENT
> 
> This patch independently causes the same failure: the Vaio doesn't power
> off after suspend-to-disk and after a manual power cycle and resume,
> networking is dead.
> 
> The message `acpi_power_off called' never comes out, so something probably
> got stuck.
> 
> Or maybe something failed somewhere and the error code which would have
> helped us solve this bug was simply ignored.
> 
> 
> 
> Note that pci_block_user_cfg_access() calls pci_save_state(), which can
> fail.  But pci_block_user_cfg_access() discards that information and
> returns void.  If this happens, userspace config space reads will return...
> what?  

There is a thread right now on the linux-pm mailing list about how this
patch is wrong.  I'm going to drop it right now...

thanks,

greg k-h
