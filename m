Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263058AbUCSRXv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 12:23:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263041AbUCSRXv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 12:23:51 -0500
Received: from main.gmane.org ([80.91.224.249]:61354 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S263058AbUCSRXm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 12:23:42 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Sergey Vlasov <vsu@altlinux.ru>
Subject: Re: hpt366-0.37.patch.bz2 K.O.
Date: Fri, 19 Mar 2004 20:23:35 +0300
Message-ID: <20040319202335.4179737f.vsu@altlinux.ru>
References: <Pine.LNX.4.10.10403190449240.2569-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Fri__19_Mar_2004_20_23_35_+0300_fgfbCJ_cnoF=OObn"
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: mivlgu.ru
X-Newsreader: Sylpheed version 0.9.10 (GTK+ 1.2.10; i586-alt-linux-gnu)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Fri__19_Mar_2004_20_23_35_+0300_fgfbCJ_cnoF=OObn
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Fri, 19 Mar 2004 04:53:22 -0800 (PST) Andre Hedrick wrote:

> http://www.kernel.org/pub/linux/kernel/people/hedrick/ide-2.4.25/hpt366-0.37.patch.bz2
> 
> Fixes fifo dma data corruption on RocketRaid404
> Fixes native HPT372 detection/setup for HPT372/HPT372A/HPT372N
> 
> HPT372N's previous code seems kooky, but then again do not have specific
> hardware rev in question.

 static void __init init_setup_hpt37x (struct pci_dev *dev, ide_pci_device_t *d)
 {
+	if (d->device == PCI_DEVICE_ID_TTI_HPT372) {
+		unsigned int class_rev;
+		static char *chipset_names[] = {"HPT372", "HPT372A", "HPT372N"};
+
+		pci_read_config_dword(dev, PCI_CLASS_REVISION, &class_rev);
+		class_rev &= 0xff;
+		d->name = chipset_names[class_rev];
+	}
+
 	ide_setup_pci_device(dev, d);
 }

This will blow up if a chip with the same PCI ID and a revision larger
than 2 ever appears.

Also, hpt366_init_one() is __devinit, but it calls d->init_setup, and
all init_setup_*() functions are __init - does not look good.  Hmm,
this is present in many drivers, also in 2.6.x... apparently this is
safe because such devices cannot be hotplugged.

--Signature=_Fri__19_Mar_2004_20_23_35_+0300_fgfbCJ_cnoF=OObn
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAWyyaW82GfkQfsqIRAv4oAJ9IULjwIM6r7BCQ1sfteOyVJjYsWwCfbJMv
L1NKvzS89AErH0wm8QvT/hU=
=qUhl
-----END PGP SIGNATURE-----

--Signature=_Fri__19_Mar_2004_20_23_35_+0300_fgfbCJ_cnoF=OObn--

