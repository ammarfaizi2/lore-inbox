Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262848AbVA2CzS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262848AbVA2CzS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 21:55:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262846AbVA2CzS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 21:55:18 -0500
Received: from web30207.mail.mud.yahoo.com ([68.142.200.90]:20883 "HELO
	web30207.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S262850AbVA2Cyp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 21:54:45 -0500
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=J2Oip9vGb0tKYjqdSWU7zY78GstERnIwrHAy9b/+L+cnk7WywtYFJbSklmmZkghpsw8MNeKQb7jdW0MEiAIEmNnba5C4byVx215uTecftXow051OonovGXtpOCWj9NIbcXtn5w0lj+JmocGjfDvpZHXh2/slezQFEyeYBDMmYg4=  ;
Message-ID: <20050129025441.78952.qmail@web30207.mail.mud.yahoo.com>
Date: Fri, 28 Jan 2005 18:54:41 -0800 (PST)
From: Martins Krikis <mkrikis@yahoo.com>
Subject: Re: [RFC PATCH 2.4] ata_piix on ich6r in RAID mode
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <41FAE72C.1010905@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- Jeff Garzik <jgarzik@pobox.com> wrote:

> Martins Krikis wrote:
> > Without this patch, if the BIOS of an ICH6R box has IDE set to
> "RAID"
> > mode then ata_piix will not find any SATA disks because it
> incorrectly
> > tries the legacy mode. With the patch all 4 SATA drives become
> visible.
> > I don't think it would break any other vendor's SATA, but you can
> be
> > the judge of that. If so, perhaps we can restrict the test some
> more
> > by checking vendor/device IDs.
> 
> > --- linux-2.4.29/drivers/scsi/libata-core.c	2005-01-28
> 12:07:56.000000000 -0500
> > +++ linux-2.4.29-iswraid/drivers/scsi/libata-core.c	2005-01-28
> 12:14:43.000000000 -0500
> > @@ -3605,6 +3605,9 @@ int ata_pci_init_one (struct pci_dev *pd
> >  			legacy_mode = (1 << 3);
> >  	}
> >  
> > +	if ((pdev->class >> 8) == PCI_CLASS_STORAGE_RAID)
> > +		legacy_mode = 0;
> > +
> >  	/* FIXME... */
> >  	if ((!legacy_mode) && (n_ports > 1)) {
> >  		printk(KERN_ERR "ata: BUG: native mode, n_ports > 1\n");
> 
> 
> hmmmmmm.  Maybe "!= PCI_CLASS_STORAGE_IDE" instead?

Yes, that's much better. No need to even read the programming IF
byte unless the class code identifies it as an IDE controller.

> Overall, however, I am worried about your report of the driver's 
> behavior based on that BIOS's configuration.  The driver follows the
> PCI 
> IDE standard (previously SFF 8038i), where a register indicates
> whether 
> its in legacy or native mode.  As it see it, either
> a) the driver logic for reading that register is wrong, or
> b) BIOS incorrectly configuring the device, or
> c) that register is only applicable for PCI_CLASS_STORAGE_IDE
> devices.
> 
> Comments either way?

I'd say "c". I don't have the spec, but my PCI course-book
seems to imply so. I could send a new patch but I can't
verify it just yet---the board decided to stop booting...

  Martins



		
__________________________________ 
Do you Yahoo!? 
Yahoo! Mail - Easier than ever with enhanced search. Learn more.
http://info.mail.yahoo.com/mail_250
