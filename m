Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263788AbTL2R1T (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 12:27:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263796AbTL2R1T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 12:27:19 -0500
Received: from as1-6-4.ld.bonet.se ([194.236.130.199]:4480 "HELO mail.nicke.nu")
	by vger.kernel.org with SMTP id S263788AbTL2R1I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 12:27:08 -0500
From: "Nicklas Bondesson" <nicke@nicke.nu>
To: "'Christophe Saout'" <christophe@saout.de>, <arjanv@redhat.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: ataraid in 2.6.?
Date: Mon, 29 Dec 2003 18:27:08 +0100
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_00C8_01C3CE39.5E0E5080"
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
In-Reply-To: <1072717701.5152.123.camel@leto.cs.pocnet.net>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Thread-Index: AcPOLmG7GzmlyIxMRPuwAv+iItYlowAAfZLg
Message-Id: <S263788AbTL2R1I/20031229172708Z+17778@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_00C8_01C3CE39.5E0E5080
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit

How do you set this (device mapping) up using the 2.6 kernel. I like the
ease of using ataraid in 2.4.x. Why not have both alternatives as options
(both ataraid and devicemapper)? Also have anyone of you looked at the patch
from Walt H that he sent in yesterday? I have to use this after replacing my
old hard drives (Maxtor 30GB) with WDC 80GB. The patch is attached. 

/Nicke

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Christophe Saout
Sent: den 29 december 2003 18:08
To: arjanv@redhat.com
Cc: Nicklas Bondesson; linux-kernel@vger.kernel.org
Subject: Re: ataraid in 2.6.?

Am Mo, den 29.12.2003 schrieb Arjan van de Ven um 10:49:
>
> the plan is to have a userspace device mapper app take it's place.
> As for the timeframe; I'm looking at it but the userspace device 
> mapper code is still a bit of a mystory to me right now.

It is? I think it's kind of simple (probably, if you know what's going on
;)). Which interface are you looking it?

I'm just looking at the ataraid code. Is my assumption correct, that it
simply interleaves sectors between two harddisks? Even sector number -> hd1,
odd number -> hd2?

Using the simple dmsetup tool one could try something like:

echo 0 $(expr $(blockdev --getsize /dev/<HD1>) \* 2) stripe 2 1 /dev/<HD1> 0
/dev/<HD2> 0 | dmsetup create ataraid

Where <HD1> and <HD2> should of course be replaced by the raw disks.

If everything is correct a device /dev/mapper/ataraid should be created.

Using libdevmapper something like:
dm_task_create(DM_DEVICE_CREATE)
dm_task_task_set_name (required)
dm_task_set_uuid (optional)
dm_task_add_target (only once in this case, contains the stripe target)
dm_task_set_ro (if readonly) dm_task_set_major / _minor (if you don't want a
dynamically allocated) dm_task_run

--
Christophe Saout <christophe@saout.de>
Please avoid sending me Word or PowerPoint attachments.
See http://www.fsf.org/philosophy/no-word-attachments.html

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org More majordomo info at
http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

------=_NextPart_000_00C8_01C3CE39.5E0E5080
Content-Type: application/octet-stream;
	name="pdcraid.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="pdcraid.patch"

--- /usr/src/temp/linux-2.4.21-xfs/linux/drivers/ide/raid/pdcraid.c	=
2003-12-22 17:59:09.653139067 -0800
+++ linux/drivers/ide/raid/pdcraid.c	2003-07-21 20:47:14.000000000 -0700
@@ -361,7 +361,11 @@
 	if (ideinfo->sect=3D=3D0)
 		return 0;
-	lba =3D (ideinfo->capacity / (ideinfo->head*ideinfo->sect));
-	lba =3D lba * (ideinfo->head*ideinfo->sect);
-	lba =3D lba - ideinfo->sect;
+	if (ideinfo->head!=3D255) {
+		lba =3D (ideinfo->capacity / (ideinfo->head*ideinfo->sect));
+		lba =3D lba * (ideinfo->head*ideinfo->sect);
+		lba =3D lba - ideinfo->sect; }
+	else {
+		lba =3D ideinfo->capacity - ideinfo->sect;
+	}
=20
 	return lba;


------=_NextPart_000_00C8_01C3CE39.5E0E5080--

