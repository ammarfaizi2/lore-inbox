Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268915AbUJKNUC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268915AbUJKNUC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 09:20:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268922AbUJKNUB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 09:20:01 -0400
Received: from p5089FA91.dip.t-dialin.net ([80.137.250.145]:1540 "EHLO
	timbaland.dnsalias.org") by vger.kernel.org with ESMTP
	id S268915AbUJKNSl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 09:18:41 -0400
From: Borislav Petkov <petkov@uni-muenster.de>
To: David Gibson <hermes@gibson.dropbear.id.au>
Subject: Re: [PATCH] Fix readw/writew warnings in drivers/net/wireless/hermes.h
Date: Mon, 11 Oct 2004 15:18:38 +0200
User-Agent: KMail/1.7
Cc: Ricky lloyd <ricky.lloyd@gmail.com>, Jan Dittmer <j.dittmer@portrix.net>,
       Cal Peake <cp@absolutedigital.net>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       NetDev Mailing List <netdev@oss.sgi.com>, proski@gnu.org
References: <Pine.LNX.4.61.0410110702590.7899@linaeum.absolutedigital.net> <1a50bd3704101105046e66538c@mail.gmail.com> <20041011123137.GB28100@zax>
In-Reply-To: <20041011123137.GB28100@zax>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410111518.39001.petkov@uni-muenster.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 11 October 2004 14:31, David Gibson wrote:
Hi all,
I'm having the same pointer casting warnings with my ymfpci soundchip...
> On Mon, Oct 11, 2004 at 05:34:20PM +0530, Ricky lloyd wrote:
> > > Isn't the correct fix to declare iobase as (void __iomem *) ?
> >
> > Earlier today i had posted a patch which mainly fixes this same
> > problem with lotsa scsi
> > drivers and tulip drivers. I wondered the same "shouldnt all the addrs
> > be declared as
> > void __iomem* ??".
>
> The trouble with that is that for some versions of the orinoco card,
> the iobase refers to a legacy ISA IO address, not a memory-mapped IO
> address (that's the inw()/outw() path in the macro).  That needs an
> integer, rather than a pointer.
however, 
I don't think there should be any casting of IO addresses for the simple reason that the void __iomem * 
is a part of an interface which does the right thing in both MMIO/PIO cases. The lkml 
thread "Being more anal about iospace accesses.." contains the answer to 
that in a great detail. As a result, the right thing to do here is, I think, to declare all addrs void __iomem*.
Which leaves a question: while compiling the following code fragment:

<sound/pci/ymfpci/ymfpci_main.c>
  static inline u8 snd_ymfpci_readb(ymfpci_t *chip, u32 offset)
  {
          return readb(chip->reg_area_virt + offset);
  }

gcc complains as so:

sound/pci/ymfpci/ymfpci_main.c: In function `snd_ymfpci_readb':
sound/pci/ymfpci/ymfpci_main.c:57: warning: passing arg 1 of `readb' makes pointer from integer without a cast

Do we have to cast here or use the new interface?

>
> It's not clear to me which way around the cast is less ugly.


Boris.
