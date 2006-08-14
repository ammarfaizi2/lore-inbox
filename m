Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932376AbWHNQ7T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932376AbWHNQ7T (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 12:59:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932380AbWHNQ7S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 12:59:18 -0400
Received: from mxout.hispeed.ch ([62.2.95.247]:7577 "EHLO smtp.hispeed.ch")
	by vger.kernel.org with ESMTP id S932376AbWHNQ7R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 12:59:17 -0400
From: Daniel Ritz <daniel.ritz-ml@swissonline.ch>
To: Dave Hansen <haveblue@us.ibm.com>
Subject: Re: aic7xxx broken in 2.6.18-rc3-mm2
Date: Mon, 14 Aug 2006 18:58:35 +0200
User-Agent: KMail/1.7.2
Cc: Greg KH <greg@kroah.com>, Marcus Better <marcus@better.se>,
       Andrew Morton <akpm@osdl.org>,
       James Bottomley <James.Bottomley@steeleye.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux scsi <linux-scsi@vger.kernel.org>, ak@suse.de
References: <1155334308.7574.50.camel@localhost.localdomain> <200608130002.40223.daniel.ritz-ml@swissonline.ch> <1155571551.7574.143.camel@localhost.localdomain>
In-Reply-To: <1155571551.7574.143.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608141858.37465.daniel.ritz-ml@swissonline.ch>
X-DCC-spamcheck-01.tornado.cablecom.ch-Metrics: smtp-08.tornado.cablecom.ch 1377;
	Body=8 Fuz1=8 Fuz2=8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 14 August 2006 18.05, Dave Hansen wrote:
> On Sun, 2006-08-13 at 00:02 +0200, Daniel Ritz wrote:
> > On Saturday 12 August 2006 20.05, Daniel Ritz wrote:
> > > On Saturday 12 August 2006 03.03, Greg KH wrote:
> > > > On Fri, Aug 11, 2006 at 05:36:24PM -0700, Andrew Morton wrote:
> > > > > On Fri, 11 Aug 2006 17:17:15 -0700
> > > > > Dave Hansen <haveblue@us.ibm.com> wrote:
> > > > > 
> > > > > > Well, I have a new culprit of the hour:
> > > > > > 
> > > > > > 	gregkh-pci-pci-use-pci_bios-as-last-fallback
> > > > > 
> > > > > Thanks, I'll drop it.
> > > > > 
> > > > > > There was a previous patch that messed up a few of my machines and this
> > > > > > same driver a few months ago, which accounts for my sense of deja vu:
> > > > > > 
> > > > > > http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc6/2.6.16-rc6-mm1/broken-out/gregkh-pci-pci-give-pci-config-access-initialization-a-defined-ordering.patch
> > > > 
> > > > Ugh, this is a mess.  Daniel, why does your machine need this patch, yet
> > > > as per Dave's comments, it's wrong?
> > > 
> > > it's not my machines. they work fine :) but there where bug reports on linux-pcmcia
> > > for this problem...only shows up with kernel >= 2.6.17. see also bug 6801.
> > > 
> > > 2.6.16 shows this:
> > > 	  PCI: PCI BIOS revision 2.10 entry at 0xfb9a0, last bus=0
> > > 	  PCI: Using configuration type 1
> > > while 2.6.17+ shows only
> > > 	  PCI: PCI BIOS revision 2.10 entry at 0xfb9a0, last bus=0
> > > 
> > > so accessing the cardbus cards is not possible with PCI BIOS but works
> > > just fine with direct access...
> > > 
> > > > 
> > > > I think it might come down to the fact that the ordering before used to
> > > > not always happen in the same order (it depended on config options and
> > > > linker luck.)  Now it's "fixed" to be the same way all the time.
> > > > Daniel, can't you solve this with the proper pci boot option?
> > > 
> > > sure, but the point is: it used to work on those boxes, but broke with 2.6.17
> > > 
> > > ok, i had a look. the problem is not the patch itself. look at arch/i386/pci/legacy.c
> > > it's where those messages come from:
> > > 	PCI: Probing PCI hardware
> > > 	PCI: Discovered peer bus 02
> > > 	PCI: Discovered peer bus 05
> > > 
> > > now if pcibios probing never runs pcibios_last_bus is -1 and pcibios_fixup_peer_bridges()
> > > exits immediatley, the other busses are never found...but why legacy probing anyway?
> > > 
> > anyway, this alternative patch should help. it should be more like the <= 2.6.16
> > behavior.
> > 
> > [ CC'ing Marcus Better as the tester of the original patch. ]
> > 
> > Marcus, could you test this patch instead of the original one and see how your
> > cardbus cards behave?
> > 
> > Dave, your SCSI card should work with this as well :)
> 
> Sorry, it has the same behavior as without the patch.  If it matters,
> here is the relevant portion of my .config:

hmm..should be 2.6.16 behavior with this...
what kind of box is this? could you give me dmesg output of plain 2.6.18-rc4
and a 2.6.18-rc4 with the patch (not -mm if possible)?
oh...and a lspci -vvv please

> CONFIG_PCI=y
> # CONFIG_PCI_GOBIOS is not set
> # CONFIG_PCI_GOMMCONFIG is not set
> # CONFIG_PCI_GODIRECT is not set
> CONFIG_PCI_GOANY=y
> CONFIG_PCI_BIOS=y
> CONFIG_PCI_DIRECT=y
> # CONFIG_PCIEPORTBUS is not set
>

thanks,
-daniel
