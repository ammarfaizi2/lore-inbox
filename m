Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265661AbUG2VXN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265661AbUG2VXN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 17:23:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265256AbUG2VXM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 17:23:12 -0400
Received: from dsl092-074-132.bos1.dsl.speakeasy.net ([66.92.74.132]:31123
	"EHLO neurosis.jim.sh") by vger.kernel.org with ESMTP
	id S267269AbUG2VVt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 17:21:49 -0400
Date: Thu, 29 Jul 2004 17:20:46 -0400
From: Jim Paris <jim@jtan.com>
To: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: RAID-6 corruption
Message-ID: <20040729212046.GA27332@jim.sh>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="OgqxwSJOaUobr8KG"
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

(I've posted some messages about this to linux-raid, but haven't
gotten much of a response; this time I'm cc'ing to linux-kernel)

I am seeing reproducible corruption with software RAID-6 on an array
that has been created with missing disks.  The attached script
demonstrates this easily through loopback devices, but I see the
problem just the same on real drives.

I do not see the problem with full RAID-6 arrays (no missing disks),
nor do I see it on RAID-5 arrays on the same system.  I haven't seen
the corruption when writing directly to the md device, but I haven't
tested that very much.

Tested on 2.6.6, 2.6.7, 2.6.8-rc2, with mdadm 1.5.0 and 1.6.0.
See attached.

-jim

--OgqxwSJOaUobr8KG
Content-Type: application/x-sh
Content-Disposition: attachment; filename="r6test.sh"
Content-Transfer-Encoding: quoted-printable

#!/bin/bash=0A=0A# Needs 500 megs of space, plus /dev/loop[1-5] and /dev/md=
6 free=0A# Tested on Linux 2.6.6 & 2.6.8-rc2, mdadm 1.5.0 & 1.6.0=0A=0Aset =
-e=0A=0Aif [ `id -u` !=3D 0 ] ; then=0A    echo run this as root=0A    exit=
 1=0Afi=0A=0Aumount /dev/md6 || true=0Amdadm -S /dev/md6 || true=0Afor i in=
 `seq 1 5` ; do=0A    losetup -d /dev/loop$i || true=0A    dd if=3D/dev/zer=
o of=3Ddisk$i bs=3D1M count=3D100=0A    losetup /dev/loop$i disk$i=0Adone=
=0Amdadm -C /dev/md6 -l 6 -c 128 -n 6 missing /dev/loop[1-5]=0Amkreiserfs -=
ff /dev/md6=0Amkdir -p mnttmp/=0Amount /dev/md6 mnttmp/=0Add if=3D/dev/zero=
 of=3Dbigfile bs=3D1M count=3D300=0Acp bigfile mnttmp/=0Aumount mnttmp/=0Am=
ount /dev/md6 mnttmp/=0A=0Aecho The following md5sums should both equal=0Ae=
cho 0d97a9cd8bbd7ce75a2a76bb06258915:=0Amd5sum bigfile mnttmp/bigfile=0A=0A=
# uncomment to leave the setup in place=0A#exit 0=0A=0Aumount /dev/md6=0Amd=
adm -S /dev/md6=0Afor i in `seq 1 5` ; do=0A    losetup -d /dev/loop$i=0Ado=
ne=0Arm disk[1-5] bigfile=0Armdir mnttmp/ || true=0A
--OgqxwSJOaUobr8KG--
