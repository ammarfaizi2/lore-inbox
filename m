Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289012AbSBDPL5>; Mon, 4 Feb 2002 10:11:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289014AbSBDPLr>; Mon, 4 Feb 2002 10:11:47 -0500
Received: from rtlab.med.cornell.edu ([140.251.145.175]:12416 "HELO
	openlab.rtlab.org") by vger.kernel.org with SMTP id <S289012AbSBDPLb>;
	Mon, 4 Feb 2002 10:11:31 -0500
Date: Mon, 4 Feb 2002 10:11:31 -0500 (EST)
From: "Calin A. Culianu" <calin@ajvar.org>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: Steven Walter <srwalter@hapablap.dyn.dhs.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: VIA Northing workaround /causing/ problems
In-Reply-To: <200202041247.g14ClUt12479@Port.imtp.ilyichevsk.odessa.ua>
Message-ID: <Pine.LNX.4.30.0202041009510.2423-100000@rtlab.med.cornell.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Feb 2002, Denis Vlasenko wrote:

> On 3 February 2002 02:40, Steven Walter wrote:
> > I recently upgraded my kernel from 2.4.10-pre6 to 2.4.18-pre2.  After
> > doing so, X acted extremely weird; whenever just about anything
> > happened, lines would appear across the screen, almost like static.
> >
> > After playing around with a few config options that I'd changed, with no
> > results, I noticed the message about the VIA northbridge bug in dmesg.
> > I commented out the line listing this chipset in pci-pc.c, recompiled,
> > and sure enough that fixed the problem!
> >
> > This board is based on the KT33 chipset.  If anyone would like more
> > information, email me.
>
> Can you play with it a bit more?
> Go to that file, uncomment it back, fiddle with
> pci_fixup_via_northbridge_bug(): try to clear only bit 7,
> then only 7 and 6 and see which cause it...
> Make it print reg#, old, new contents:

Yes, this is a good point.  The via 'specs' (really they may not even be
from via.. but that's a different story) say that bits 5,6,7 are for the
MWQ Timer, but some people have reported really good results just clearing
bit 5 and leaving 6 and 7 alone (actually this was the original MWQ timer
patch).  I would be interested to see what bits are on for this guy by
default from his bios and which one causes problems when touched...

-Calin

> ...
> printk("Trying to stomp on VIA Northbridge bug: [%02x] %02x->%02x\n", where, v, v & 0x1f);
> ...
> etc.
> Original function for your reference:
>
> static void __init pci_fixup_via_northbridge_bug(struct pci_dev *d)
> {
>         u8 v;
>         int where = 0x55;
>         if (d->device == PCI_DEVICE_ID_VIA_8367_0) {
>                 where = 0x95; /* the memory write queue timer register is
>                                  different for the kt266x's: 0x95 not 0x55 */
>         }
>         pci_read_config_byte(d, where, &v);
>         if (v & 0xe0) {
>                 printk("Trying to stomp on VIA Northbridge bug...\n");
>                 v &= 0x1f; /* clear bits 5, 6, 7 */
>                 pci_write_config_byte(d, where, v);
>         }
> }
> --
> vda
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

