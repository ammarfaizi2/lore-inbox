Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751876AbWCDRGs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751876AbWCDRGs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Mar 2006 12:06:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751877AbWCDRGs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Mar 2006 12:06:48 -0500
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:27094 "EHLO
	out4.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S1751876AbWCDRGr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Mar 2006 12:06:47 -0500
X-Sasl-enc: zQX+Q8kkxaVbvqZBNuR065WalUDn9HuzFFAVERrn+Ocr 1141492005
Date: Sat, 4 Mar 2006 14:06:42 -0300
From: Henrique de Moraes Holschuh <hmh@debian.org>
To: bluesmoke-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/15] EDAC: i82875p cleanup
Message-ID: <20060304170642.GA19998@khazad-dum.debian.net>
References: <200603021748.01132.dsp@llnl.gov> <20060302183044.459ddb13.akpm@osdl.org> <200603031047.01445.dsp@llnl.gov> <1141436608.14012.23.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1141436608.14012.23.camel@localhost.localdomain>
X-GPG-Fingerprint: 1024D/1CDB0FE3 5422 5C61 F6B7 06FB 7E04  3738 EE25 DE3F 1CDB 0FE3
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 03 Mar 2006, Thayne Harbaugh wrote:
> On Fri, 2006-03-03 at 10:47 -0800, Dave Peterson wrote:
> > On Thursday 02 March 2006 18:30, Andrew Morton wrote:
> > > Dave Peterson <dsp@llnl.gov> wrote:
> > > >  +#ifdef CORRECT_BIOS
> > > >  +fail0:
> > > >  +#endif
> > >
> > > What is CORRECT_BIOS?  Is the fact that it's never defined some sort of
> > > commentary?  ;)
> > 
> > I'm not sure about this.  I'm cc'ing Thayne Harbaugh and Wang Zhenyu since
> > their names are in the credits for the i82875p module.  Maybe they can
> > provide some info.
[cut]
> 
> I haven't looked through the code yet so I can't remember if it's
> something I left and if it is, what it does.
> 
> I just looked, and I don't recognize it - "cvs annotate" lists it ass
> being last touched by dsp_llnl ;^).

Maybe it is a left-over of that bogus warning about the BIOS reserving the
region used by the hidden pci device (device 0:0:06.0)?  Consensus was that
if the BIOS hides the device, it is supposed to reserve that area since it
is indeed in use by the hidden, but still active, 82875P configuration-space
overflow PCI device, so no warnings were required.

The current code still spills useless warnings, but that's because it tries
to reserve the pci resources and the pci code itself outputs warnings.
Maybe it should query if that resource is already reserved, and not try to
reserve it in that case (to avoid the warning).

Also, last time I checked (latest bluesmoke code, didn't try EDAC yet), the
code unhides the PCI 0:0:06.0 device so as to do the required EDAC setup and
pooling, but does not do whatever is needed to add that device to the
regular pci device list used by lspci.

Here's the device I am talking about (lspci -H1 finds it):
0000:00:06.0 System peripheral: Intel Corporation 82875P/E7210 Processor to
I/O Memory Interface (rev 02)
        Flags: fast devsel
	Memory at fecf0000 (32-bit, non-prefetchable)

Just plain lspci (even as root) won't list it.  If EDAC/bluesmoke is not
loaded, the device is kept hidden and not even lspci -H1 can find it.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
