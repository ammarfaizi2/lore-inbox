Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263760AbSLMNih>; Fri, 13 Dec 2002 08:38:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264622AbSLMNih>; Fri, 13 Dec 2002 08:38:37 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:10880 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id <S263760AbSLMNid>; Fri, 13 Dec 2002 08:38:33 -0500
Message-Id: <200212131345.gBDDjw27002677@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.5 07/13/2001 with nmh-1.0.4+dev
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Alessandro Suardi <alessandro.suardi@oracle.com>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.5.5[01]]: Xircom Cardbus broken (PCI resource collisions) 
In-Reply-To: Your message of "Fri, 13 Dec 2002 11:10:24 +0100."
             <1039774224.1449.0.camel@laptop.fenrus.com> 
From: Valdis.Kletnieks@vt.edu
References: <200212122247.gBCMlHgY011021@turing-police.cc.vt.edu>
            <1039774224.1449.0.camel@laptop.fenrus.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1861548008P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Fri, 13 Dec 2002 08:45:58 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1861548008P
Content-Type: text/plain; charset=us-ascii

On Fri, 13 Dec 2002 11:10:24 +0100, Arjan van de Ven said:
> On Thu, 2002-12-12 at 23:47, Valdis.Kletnieks@vt.edu wrote:
> > --- drivers/pcmcia/cardbus.c.dist	2002-12-03 01:49:29.000000000 -0500
> > +++ drivers/pcmcia/cardbus.c	2002-12-03 01:50:23.000000000 -0500
> > @@ -283,8 +283,6 @@
> >  		dev->hdr_type = hdr & 0x7f;
> >  
> >  		pci_setup_device(dev);
> > -		if (pci_enable_device(dev))
> > -			continue;
> >  
> >  		strcpy(dev->dev.bus_id, dev->slot_name);
> >  
> > @@ -302,6 +300,8 @@
> >  			pci_writeb(dev, PCI_INTERRUPT_LINE, irq);
> >  		}
> >  
> > +		if (pci_enable_device(dev))
> > +			continue;
> >  		device_register(&dev->dev);
> >  		pci_insert_device(dev, bus);
> >  	}
> 
> interesting. BUT aren't we writing to the device 3 lines before where
> you add the pci_enable_device()? That sounds like a bad plan to me ;(

That's where pci_enable_device() *USED* to be - this is backing out a change
made in 2.5.50 - it added the if/continue wrapper and moved it up about 15
lines in the code. The problem seems to be that for many devices,
pci_enable_device() fails unless we do the pci_writeb() magic first.  Or
perhaps it's the call to pci_assign_resource() - I don't know. ;) The 2.4.18
tree has the pci_enable_device() at the same place - just without the if/
continue around it.  It can't be THAT evil, as that's the way 2.4.0 to 2.4.18
and 2.5.0 to 2.5.49 did it.. ;)

I see why the if/continue was added - you don't want to be calling
device_register()/pci_insert_device() if pci_enable_device() loses.  I don't
see why 2.5.50 moved the code up after pci_setup_device(). There's an outside
chance that the concept of moving the call was correct, but that it should have
been moved to between the calls to pci_assign_resource() and pci_readb().
If that's the case, then you're correct as well....

/Valdis (who shouldn't be trying to think before caffeine.. ;)


--==_Exmh_1861548008P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE9+eSVcC3lWbTT17ARArjGAJ9LBFpak9gOAPcIOg5epTJt5AN5BwCgkcKh
awGdE3doCRRK91rx8LOpXYk=
=hZVf
-----END PGP SIGNATURE-----

--==_Exmh_1861548008P--
