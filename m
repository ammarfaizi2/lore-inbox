Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265243AbSLMSig>; Fri, 13 Dec 2002 13:38:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265247AbSLMSig>; Fri, 13 Dec 2002 13:38:36 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:60033 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id <S265243AbSLMSif>; Fri, 13 Dec 2002 13:38:35 -0500
Message-Id: <200212131846.gBDIk527008838@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.5 07/13/2001 with nmh-1.0.4+dev
To: Dave Jones <davej@codemonkey.org.uk>
Cc: Petr Konecny <pekon@informatics.muni.cz>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.5[01]]: Xircom Cardbus broken (PCI resource collisions) 
In-Reply-To: Your message of "Fri, 13 Dec 2002 17:36:56 GMT."
             <20021213173656.GC1633@suse.de> 
From: Valdis.Kletnieks@vt.edu
References: <200212131345.gBDDjw27002677@turing-police.cc.vt.edu> <200212131633.gBDGX0617899@anxur.fi.muni.cz> <200212131718.gBDHIw27008173@turing-police.cc.vt.edu>
            <20021213173656.GC1633@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1983665128P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Fri, 13 Dec 2002 13:46:05 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1983665128P
Content-Type: text/plain; charset=us-ascii

On Fri, 13 Dec 2002 17:36:56 GMT, Dave Jones said:

> It's my understanding that pci_enable_device() *must* be called
> before we fiddle with dev->resource, dev->irq and the like.

OK.. it looks like the problem only hits if it's a PCMCIA card *with an
onboard ROM*.

The immediate problem cause is in pcibios_enable_resources():

                if (!r->start && r->end) {
                        printk(KERN_ERR "PCI: Device %s not available because of resource collisions\n", dev->slot_name);

If there's an onboard ROM, this is set up in pcibios_assign_resources():

                if (pci_probe & PCI_ASSIGN_ROMS) {
                        r = &dev->resource[PCI_ROM_RESOURCE];
                        r->end -= r->start;
                        r->start = 0;
                        if (r->end)
                                pci_assign_resource(dev, PCI_ROM_RESOURCE);
                }               

but this hasn't happened yet in cb_alloc():

                /* FIXME: Do we need to enable the expansion ROM? */
                for (r = 0; r < 7; r++) {
                        struct resource *res = dev->resource + r;
                        if (res->flags)
                                pci_assign_resource(dev, r);
                }

So I think right *AFTER* this code is the right place for pci_enable_device()
because otherwise we won't have allocated the ROMs, so we'll get conflicts.

/Valdis (who went nuts looking at <6 and <7 all over the place.  Should I
volunteer to clean these up to #defines rather than inline magic numbers? ;)

--==_Exmh_1983665128P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE9+irtcC3lWbTT17ARAqyfAJ4kfG8JPpltC6aRvG9PJQxUi3RdmACfSJm7
7vJ9lt0SBfN8k++aHZnX97Y=
=6DRj
-----END PGP SIGNATURE-----

--==_Exmh_1983665128P--
