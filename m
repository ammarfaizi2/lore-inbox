Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261748AbVBXCEF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261748AbVBXCEF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 21:04:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261751AbVBXCEE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 21:04:04 -0500
Received: from wproxy.gmail.com ([64.233.184.201]:23510 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261748AbVBXCDg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 21:03:36 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=fuh5et3ka4opbCDI+RkVGDH6wq9hUGRp/10LYx49QPUnf9fiHbFnXAWYTiEuxhnT12e9xl+DTQJKvFM7iRiW7MRC92b+Z0GMmhW3Y+y4vjfgJmHwuAaq/hxz3PsoK0TiwNLdDNjI0rfsfMYuTgh+kqLhNBokYSomE1Jt8ExZ1g4=
Message-ID: <40f323d005022318032d737779@mail.gmail.com>
Date: Thu, 24 Feb 2005 03:03:33 +0100
From: Benoit Boissinot <bboissin@gmail.com>
Reply-To: Benoit Boissinot <bboissin@gmail.com>
To: Matt Mackall <mpm@selenic.com>
Subject: Re: 2.6.11-rc4-mm1 (VFS: Cannot open root device "301")
Cc: Andrew Morton <akpm@osdl.org>, Steven Cole <elenstev@mesatop.com>,
       linux-kernel@vger.kernel.org,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
In-Reply-To: <20050224004159.GH3163@waste.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_1321_10204631.1109210613180"
References: <20050223014233.6710fd73.akpm@osdl.org>
	 <421CB161.7060900@mesatop.com> <20050223121759.5cb270ee.akpm@osdl.org>
	 <421CFF5E.4030402@mesatop.com> <421D09AE.4090100@mesatop.com>
	 <20050223161653.7cb966c3.akpm@osdl.org>
	 <20050224004159.GH3163@waste.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_1321_10204631.1109210613180
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Wed, 23 Feb 2005 16:41:59 -0800, Matt Mackall <mpm@selenic.com> wrote:
> On Wed, Feb 23, 2005 at 04:16:53PM -0800, Andrew Morton wrote:
> > Steven Cole <elenstev@mesatop.com> wrote:
> > >
> > > > Yes, that worked.  2.6.11-rc4-mm1 now boots OK, but hdb1 seems to be
> > > > missing.
> >
> > Looking at the IDE update in rc4-mm1:
> >
> > +void ide_init_disk(struct gendisk *disk, ide_drive_t *drive)
> > +{
> > +     ide_hwif_t *hwif = drive->hwif;
> > +     unsigned int unit = drive->select.all & (1 << 4);
> > +

If i grep in the tree, for select.all, it looks like from the initialization
that you can not recover the unit from select.all (ide.c line 235 and 1882)
since the function used is not invertible.

> >
> > Could someone try this?
> >
> > -     unsigned int unit = drive->select.all & (1 << 4);
> > +     unsigned int unit = (drive->select.all >> 4) & 1;
> 
> Apparently there's already an 'hdb' sitting in drive->name, perhaps we
> ought to do disk->disk_name = drive->name for the non-devfs case.
>
init_hwif_default initialized it right.

Could something like this work ?

regards,

Benoit

------=_Part_1321_10204631.1109210613180
Content-Type: text/x-patch; name="ide-patch.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="ide-patch.diff"

--- linux/drivers/ide/ide-probe.c=092005-02-23 12:16:32.000000000 +0100
+++ linux-test/drivers/ide/ide-probe.c=092005-02-24 03:02:06.000000000 +010=
0
@@ -1269,11 +1269,11 @@ EXPORT_SYMBOL_GPL(ide_unregister_region)
 void ide_init_disk(struct gendisk *disk, ide_drive_t *drive)
 {
 =09ide_hwif_t *hwif =3D drive->hwif;
-=09unsigned int unit =3D drive->select.all & (1 << 4);
+=09unsigned int unit =3D drive->name[2] - 'a' - hwif->index * MAX_DRIVES;
=20
 =09disk->major =3D hwif->major;
 =09disk->first_minor =3D unit << PARTN_BITS;
-=09sprintf(disk->disk_name, "hd%c", 'a' + hwif->index * MAX_DRIVES + unit)=
;
+=09disk->disk_name =3D drive->name;
 =09disk->queue =3D drive->queue;
 }
=20

------=_Part_1321_10204631.1109210613180--
