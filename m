Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262511AbVA0GlA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262511AbVA0GlA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 01:41:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262521AbVA0Gk7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 01:40:59 -0500
Received: from h80ad2540.async.vt.edu ([128.173.37.64]:63501 "EHLO
	h80ad2540.async.vt.edu") by vger.kernel.org with ESMTP
	id S262511AbVA0Gki (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 01:40:38 -0500
Message-Id: <200501270640.j0R6eD7N000647@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: John Richard Moser <nigelenki@comcast.net>
Cc: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       "Randy.Dunlap" <rddunlap@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: /proc parent &proc_root == NULL? 
In-Reply-To: Your message of "Wed, 26 Jan 2005 22:35:18 EST."
             <41F86176.3010000@comcast.net> 
From: Valdis.Kletnieks@vt.edu
References: <41F82218.1080705@comcast.net> <41F84313.4030509@osdl.org> <41F8530C.6010305@comcast.net> <20050127031539.GK8859@parcelfarce.linux.theplanet.co.uk>
            <41F86176.3010000@comcast.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1106808012_17814P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 27 Jan 2005 01:40:12 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1106808012_17814P
Content-Type: text/plain; charset=us-ascii

On Wed, 26 Jan 2005 22:35:18 EST, John Richard Moser said:

> This particular problem pertains to proc_misc.c and trying to create a
> hook for some grsecurity protections that alter the modes on certain
> /proc entries.  The chunk of the patch I'm trying to immitate is:

> +#ifdef CONFIG_GRKERNSEC_PROC_ADD
> +       create_seq_entry("cpuinfo", gr_mode, &proc_cpuinfo_operations);
> +#else
>         create_seq_entry("cpuinfo", 0, &proc_cpuinfo_operations);
> +#endif

An alternate way to approach this - leave the permissions alone here.

And then use the security_ops->inode_permission() hook to do something like:

	if ((inode == cpuinfo) && (current->fsuid))
		 return -EPERM;

Writing the proper tests for whether it's the inode you want and whether to
give the request the kiss-of-death are left as an excersize for the programmer.. ;)

You may want to use a properly timed initcall() to create a callback that
happens after proc_misc_init() happens, but before userspace gets going, and
walk through the /proc tree at that time and cache info on the files you care
about, so you don't have to re-walk /proc every time permission() gets called....

--==_Exmh_1106808012_17814P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFB+IzMcC3lWbTT17ARAqLSAJkB/vxY+Ux4D4YOmIkr7ALyQncgXwCfTKIB
loefhymnh78mSAAOm7rENtM=
=tpWB
-----END PGP SIGNATURE-----

--==_Exmh_1106808012_17814P--
