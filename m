Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751178AbWIZNRg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751178AbWIZNRg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 09:17:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751206AbWIZNRg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 09:17:36 -0400
Received: from pool-71-254-65-206.ronkva.east.verizon.net ([71.254.65.206]:1220
	"EHLO turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S1751178AbWIZNRf (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 09:17:35 -0400
Message-Id: <200609261317.k8QDHRVG013833@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: Eric Sesterhenn <snakebyte@gmx.de>
Cc: linux-kernel@vger.kernel.org, chuck.lever@oracle.com
Subject: Re: [Patch] Possible dereference in fs/nfsd/nfs4callback.c
In-Reply-To: Your message of "Tue, 26 Sep 2006 12:30:59 +0200."
             <1159266659.5413.3.camel@alice>
From: Valdis.Kletnieks@vt.edu
References: <1159266659.5413.3.camel@alice>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1159276646_16795P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 26 Sep 2006 09:17:26 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1159276646_16795P
Content-Type: text/plain; charset=us-ascii

On Tue, 26 Sep 2006 12:30:59 +0200, Eric Sesterhenn said:

> we set cb->cb_client to NULL and pass it to rpc_shutdown_client() which dereferences it.
> The easy fix below.

>  out_clnt:
> -	rpc_shutdown_client(cb->cb_client);
> +	if (cb->cb_client)
> +		rpc_shutdown_client(cb->cb_client);

OK, I admit not knowing the NFS code well, but this one looks suspiciously
like "easy paper-over" rather than "easy fix".  Is there other cod elsewhere
that guards this case from ever actually happening?  If it *does* happen,
is it indicative of major borkage and we really should do something like:

	if (cb->cb_client)
		rpm_shutdown_client(cb->cb_client)
	else
		printk(KERN_ERR "Yowza - trashed NFS control structures...");

or even maybe a more drastic action (oops/panic)?

--==_Exmh_1159276646_16795P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFFGShmcC3lWbTT17ARAiKNAJ9Y9tT0XNeI9s41lyGMH+e3M7FKIACeKwCC
hBb1RN5bsptbko2Cl7AQcKE=
=wZWs
-----END PGP SIGNATURE-----

--==_Exmh_1159276646_16795P--
