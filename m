Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261969AbVEWVKf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261969AbVEWVKf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 May 2005 17:10:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261971AbVEWVKe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 May 2005 17:10:34 -0400
Received: from www.dubki.ru ([195.225.129.2]:22994 "EHLO mail.dubki.ru")
	by vger.kernel.org with ESMTP id S261969AbVEWVJd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 May 2005 17:09:33 -0400
From: "Nikita V. Youshchenko" <yoush@cs.msu.su>
To: linux-kernel@vger.kernel.org
Subject: Possible bug in device_find() or in bus_add_device()
Date: Tue, 24 May 2005 01:09:18 +0400
User-Agent: KMail/1.7.2
Cc: Alexander Kaliadin <akaliadin@libertesoft.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1973864.D5Ec1GrZh5";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200505240109.25710@sercond.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1973864.D5Ec1GrZh5
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

[2Alexander: the memory breakage I mentioned looks to be actually not a=20
memory breakage, but a bug in linux device model code. So I'm reporting it=
=20
to kernel mailing list]

Hello.

While developing a driver for an embedded system, I am getting crashes in=20
calls to device_find().

I tried to find out what is going on, and found the following.

Device seems to be added it's bus'es device list in bus_add_device() by the=
=20
following statement:

	list_add_tail(&dev->bus_list, &dev->bus->devices.list);

So struct device object gets linked to bus->devices.list using it's=20
bus_list field.
However, device_find() calls kset_find_obj(&bus->devices, name), which in=20
turn dereferences bus->devices in the following statement:

	list_for_each(entry,&kset->list) {
                struct kobject * k =3D to_kobj(entry);
		...

where kset->list is the above  bus->devices.list, and to_kobj is defined as=
=20
container_of(entry,struct kobject,entry)
So it assumes that objects are linked to  bus->devices.list using=20
kobject::entry field. But actually struct device objects are linked to =20
bus->devices.list using their bus_list field, not kobj.entry field!
So code in kset_find_obj() gets an invalid pointer to kobj, which leads to=
=20
a crash.

Looks like a bug.

The above code snippets all exist in (currently latest) 2.6.12-pre4 kernel=
=20
tree from kernel.org.

I'm not familiar with linux device model. Could someone please help to find=
=20
the best way to fix this (other than not using device_find() at all)?

Nikita Youshchenko

P.S.
Please CC replies to my e-mail address, yoush@cs.msu.su

--nextPart1973864.D5Ec1GrZh5
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBCkkaFv3x5OskTLdsRAn/tAJ9JDQkBCqUzfjuFqbNu4VT/P/yGVACfVyqo
PohSuaHxrbCfR7E3lBtPRpo=
=1odv
-----END PGP SIGNATURE-----

--nextPart1973864.D5Ec1GrZh5--
