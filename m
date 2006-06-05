Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1751231AbWFERfp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751231AbWFERfp (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 13:35:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751240AbWFERfp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 13:35:45 -0400
Received: from peabody.ximian.com ([130.57.169.10]:65423 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S1751231AbWFERfo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 13:35:44 -0400
Subject: Re: [PATCH 9/9] PCI PM: generic suspend/resume fixes
From: Adam Belay <abelay@novell.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>,
        linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
In-Reply-To: <1149502891.30554.1.camel@localhost.localdomain>
References: <1149497178.7831.163.camel@localhost.localdomain>
	 <1149502891.30554.1.camel@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 05 Jun 2006 13:48:04 -0400
Message-Id: <1149529685.7831.177.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-06-05 at 11:21 +0100, Alan Cox wrote:
> Ar Llu, 2006-06-05 am 04:46 -0400, ysgrifennodd Adam Belay:
> > + * Default suspend method for devices that have no driver provided suspend,
> > + * or not even a driver at all.
> > + */
> > +static void pci_default_suspend(struct pci_dev *pci_dev)
> > +{
> > +	pci_save_state(pci_dev);
> > +	pci_disable_device(pci_dev);
> > +}
> 
> How much testing has this had ? When people starting doing
> disable_device on arbitary hardware various platforms broke horribly
> as a result.

Hi Alan,

I've only tested this on a few x86 boxes.  However, I think it's moving
in the right direction for correctly suspending devices.  It's worth
mentioning that the PCI PM specification requires the device to be
disabled before entering D3 (something that we fail to do before this
patchset), and the vast majority of devices would end up in this state
if we were using pci_set_power_state() in this function.

Unfortunately, far too many drivers still depend on this generic suspend
call, when they should all implement their own suspend function.  I
would except pci_disable_device() issues to the the exception, and as
such, device drivers should provide a ->suspend function that doesn't
call pci_disable_device() when they know their hardware can be
problematic.

With that in mind, any thoughts on giving this a little time in -mm and
seeing how it fares?  If any problems come up, we could revert to a more
conservative approach.

Thanks,
Adam


