Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965115AbVHPFgf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965115AbVHPFgf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 01:36:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965118AbVHPFgf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 01:36:35 -0400
Received: from h80ad2575.async.vt.edu ([128.173.37.117]:7401 "EHLO
	h80ad2575.async.vt.edu") by vger.kernel.org with ESMTP
	id S965116AbVHPFge (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 01:36:34 -0400
Message-Id: <200508160536.j7G5aKox017930@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Michael E Brown <Michael_E_Brown@dell.com>
Cc: Kyle Moffett <mrmacman_g4@mac.com>,
       Doug Warzecha <Douglas_Warzecha@dell.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 2.6.13-rc6] add Dell Systems Management Base Driver (dcdbas) with sysfs support 
In-Reply-To: Your message of "Mon, 15 Aug 2005 23:58:43 CDT."
             <1124168323.10755.179.camel@soltek.michaels-house.net> 
From: Valdis.Kletnieks@vt.edu
References: <1124168323.10755.179.camel@soltek.michaels-house.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1124170579_3269P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 16 Aug 2005 01:36:19 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1124170579_3269P
Content-Type: text/plain; charset=us-ascii

On Mon, 15 Aug 2005 23:58:43 CDT, Michael E Brown said:

> No, this is an _EXCELLENT_ reason why _LESS_ of this should be in the
> kernel. Why should we have to duplicate a _TON_ of code inside the
> kernel to figure out which platform we are on, and then look up in a
> table which method to use for that platform? We have a _MUCH_ nicer
> programming environment available to us in userspace where we can use
> things like libsmbios to look up the platform type, then look in an
> easily-updateable text file which smi type to use. In general, plugging
> the wrong value here is a no-op.

You'll still need to do some *very* basic checking - there's fairly
scary-looking 'outb' call in  callintf_smi()  and host_control_smi() that seems to
be totally too trusting that The Right Thing is located at address CMOS_BASE_PORT:

+		for (index = PE1300_CMOS_CMD_STRUCT_PTR;
+		     index < (PE1300_CMOS_CMD_STRUCT_PTR + 4);
+		     index++) {
+			outb(index,
+			     (CMOS_BASE_PORT + CMOS_PAGE2_INDEX_PORT_PIIX4));
+			outb(*data++,
+			     (CMOS_BASE_PORT + CMOS_PAGE2_DATA_PORT_PIIX4));
+		}

This Dell C840 has an 845, not a PIIX.  What just got toasted if this driver
gets called?

Can we have a check that the machine is (a) a Dell and (b) has a PIIX and (c) the
PIIX has a functional SMI behind it, before we start doing outb() calls?



--==_Exmh_1124170579_3269P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFDAXtScC3lWbTT17ARAkH9AJwNuiQIhgPK6YvfDsMYaXEUwtXFNwCeNEu3
jIzwUVhDfRaIB5Z7px1NXZQ=
=oqFp
-----END PGP SIGNATURE-----

--==_Exmh_1124170579_3269P--
