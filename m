Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266086AbUAFEMf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 23:12:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266087AbUAFEMf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 23:12:35 -0500
Received: from h80ad2537.async.vt.edu ([128.173.37.55]:13185 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S266086AbUAFEMc (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 23:12:32 -0500
Message-Id: <200401060412.i064CJtK004302@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Libor Vanek <libor@conet.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-mm1 - kernel panic (VFS bug?) 
In-Reply-To: Your message of "Tue, 06 Jan 2004 04:52:26 +0100."
             <3FFA30FA.1040602@conet.cz> 
From: Valdis.Kletnieks@vt.edu
References: <3FFA30FA.1040602@conet.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_329293803P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 05 Jan 2004 23:12:19 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_329293803P
Content-Type: text/plain; charset=us-ascii

On Tue, 06 Jan 2004 04:52:26 +0100, Libor Vanek <libor@conet.cz>  said:

>         tmp = getname(filename);
> 	printk (KERN_INFO "sys_open: %s\n",tmp);

> Unable to handle kernel paging request at virtual address fffffff2

Hmm.. a -14. ;)


You did know that getname can return an error, right?  Try this:

	tmp = getname(filename);
	if ((int) tmp < 0) {
		printk (KERN_INFO "sys_open: getname returned error %d\n",tmp);
	} else {
		printk (KERN_INFO "sys_open: %s\n",tmp);
	}

Poking around in fs/namei.c shows that -14 is 'EFAULT' - most likely
some bozo did "fd = open(pointer_to_nowhere,....);".  Notice the use
of IS_ERR(tmp) in sys_open() to guard against this....


--==_Exmh_329293803P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/+jWicC3lWbTT17ARAiaLAKCRhZgnw8la0ENO4DfIZM0MwOOfxACeOS0I
UF1jI9MVJiY5wuh00oIIWbA=
=9lgh
-----END PGP SIGNATURE-----

--==_Exmh_329293803P--
