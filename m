Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262929AbUJ0WYe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262929AbUJ0WYe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 18:24:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262954AbUJ0WWK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 18:22:10 -0400
Received: from smtp09.auna.com ([62.81.186.19]:61062 "EHLO smtp09.retemail.es")
	by vger.kernel.org with ESMTP id S262917AbUJ0WT6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 18:19:58 -0400
Date: Wed, 27 Oct 2004 22:19:52 +0000
From: "J.A. Magallon" <jamagallon@able.es>
Subject: [PATCH] Re: pdc202xx_old broke boot [was Re: 2.6.9-mm1]
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Greg KH <greg@kroah.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>
References: <20041022032039.730eb226.akpm@osdl.org>
	<1098490330l.28166l.0l@werewolf.able.es>
	<20041022172100.183f9fe1.akpm@osdl.org>
	<58cb370e041022173465c22894@mail.gmail.com>
In-Reply-To: <58cb370e041022173465c22894@mail.gmail.com> (from
	bzolnier@gmail.com on Sat Oct 23 02:34:28 2004)
X-Mailer: Balsa 2.2.5
Message-Id: <1098915592l.20613l.0l@werewolf.able.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2004.10.23, Bartlomiej Zolnierkiewicz wrote:
> On Fri, 22 Oct 2004 17:21:00 -0700, Andrew Morton <akpm@osdl.org> wrote:
> > "J.A. Magallon" <jamagallon@able.es> wrote:
> > >
> > > Hi all...
> > >
> > > On 2004.10.22, Andrew Morton wrote:
> > > >
> > > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9/2.6.9-mm1/
> > > >
> > >
> > > I upgraded from 2.6.9-rc3-mm3 to 2.6.9-mm1 and the system coould not boot.
> > > What was before hde now was hda (guess ? root is on hde1...)
> > 
> > yikes.  Perhaps the PCI scanning order was changed?
> 
> Fortunately, not. :)
> 
> What happened is that ide-dev-2.6 tree contains a patch which ignores
> BIOS settings for Promise controllers but ide-dev-2.6 tree is not in
> 2.6.9-mm1 (due to syncing with -linus -> temporary breakage).
> 
> > > How can I restore the old behaviour ? Plain 2.6.9 booted. So reconfiguring
> > > fstab to say / == hda1 will make impossible switch between kernels ...
> 
> In 2.6.9-mm1 CONFIG_PDC202XX_FORCE option can also be used
> for pdc202xx_old but pdc202xx_new must be enabled (yes it a bug).
> 

Is this patch OK ? (against 2.6.9-mm1)

--- linux/drivers/ide/Kconfig.orig	2004-10-26 01:26:09.000000000 +0200
+++ linux/drivers/ide/Kconfig	2004-10-28 00:15:27.936420036 +0200
@@ -624,6 +624,8 @@
 
 	  Please read the comments at the top of <file:drivers/ide/pci/ns87415.c>.
 
+menu "Promise PDC support"
+
 config BLK_DEV_PDC202XX_OLD
 	tristate "PROMISE PDC202{46|62|65|67} support"
 	help
@@ -648,9 +650,15 @@
 
 	  If unsure, say N.
 
+config BLK_DEV_PDC202XX_NEW
+	tristate "PROMISE PDC202{68|69|70|71|75|76|77} support"
+
+config PDC202XX_DUMMY
+	bool
+
 config PDC202XX_BURST
 	bool "Special UDMA Feature"
-	depends on BLK_DEV_PDC202XX_OLD
+	depends on BLK_DEV_PDC202XX_OLD || BLK_DEV_PDC202XX_NEW
 	help
 	  This option causes the pdc202xx driver to enable UDMA modes on the
 	  PDC202xx even when the PDC202xx BIOS has not done so.
@@ -665,15 +673,20 @@
 
 	  If unsure, say N.
 
-config BLK_DEV_PDC202XX_NEW
-	tristate "PROMISE PDC202{68|69|70|71|75|76|77} support"
-
-# FIXME - probably wants to be one for old and for new
 config PDC202XX_FORCE
 	bool "Enable controller even if disabled by BIOS"
-	depends on BLK_DEV_PDC202XX_NEW
+	depends on BLK_DEV_PDC202XX_OLD || BLK_DEV_PDC202XX_NEW
 	help
-	  Enable the PDC202xx controller even if it has been disabled in the BIOS setup.
+	  Enable the PDC202xx controller even if it has been disabled, both
+	  manually in the BIOS setup, or because it has no drive connected.
+	  If you do not force the detection and have other IDE busses
+	  in the box, the device names for your other busses (/dev/hdX)
+	  can change depending on drives being connected to the Promise or not.
+
+	  If unsure, say Y. This will keep your IDE drive device names
+	  consistent with or without drives connected to the PDC.
+
+endmenu
 
 config BLK_DEV_SVWKS
 	tristate "ServerWorks OSB4/CSB5/CSB6 chipsets support"


--
J.A. Magallon <jamagallon()able!es>     \               Software is like sex:
werewolf!able!es                         \         It's better when it's free
Mandrakelinux release 10.1 (Community) for i586
Linux 2.6.9-jam1 (gcc 3.4.1 (Mandrakelinux 10.1 3.4.1-4mdk)) #6


