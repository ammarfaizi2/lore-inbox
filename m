Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262120AbULaR0C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262120AbULaR0C (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Dec 2004 12:26:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262121AbULaR0C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Dec 2004 12:26:02 -0500
Received: from smtp3.pp.htv.fi ([213.243.153.36]:40343 "EHLO smtp3.pp.htv.fi")
	by vger.kernel.org with ESMTP id S262120AbULaRZw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Dec 2004 12:25:52 -0500
Date: Fri, 31 Dec 2004 19:25:50 +0200
From: Paul Mundt <lethal@linux-sh.org>
To: linux-kernel@vger.kernel.org
Cc: kaos@ocs.com.au, sam@ravnborg.org
Subject: sh: inconsistent kallsyms data
Message-ID: <20041231172549.GA18211@linux-sh.org>
Mail-Followup-To: Paul Mundt <lethal@linux-sh.org>,
	linux-kernel@vger.kernel.org, kaos@ocs.com.au, sam@ravnborg.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FL5UXtIhxfXey3p5"
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Building 2.6.10 for sh results in inconsistent kallsyms data. Turning on
CONFIG_KALLSYMS_ALL fixes it, as does CONFIG_KALLSYMS_EXTRA_PASS.

The symbols that seem to be problematic between the second and third
pass are all kallsyms special symbols. With only CONFIG_KALLSYMS set we
see:

--- System.map  2004-12-31 10:53:10.278567522 -0600
+++ .tmp_System.map     2004-12-31 10:53:10.347558024 -0600
@@ -6868,9 +6868,9 @@
 8817c4d0 D kallsyms_addresses
 88182660 D kallsyms_num_syms
 88182670 D kallsyms_names
-88190630 D kallsyms_markers
-881906a0 D kallsyms_token_table
-88190b50 D kallsyms_token_index
+881906a0 D kallsyms_markers
+88190710 D kallsyms_token_table
+88190bc0 D kallsyms_token_index
 88191000 D irq_desc
 88191000 A __per_cpu_end
 88191000 A __per_cpu_start

So for some reason we have a 0x70 variance between these, and only
these. Running with --all-symbols this seems to work fine.

Looking at scripts/kallsyms.c:symbol_valid, we see:

/* Symbols which vary between passes.  Passes 1 and 2 must have
 * identical symbol lists.  The kallsyms_* symbols below are only added
 * after pass 1, they would be included in pass 2 when --all-symbols is
 * specified so exclude them to get a stable symbol list.
 */

Going by this it's not entirely clear if there is a problem or not. If
these symbols are supposed to be excluded due to being "special", then
it doesn't seem like verify_kallsyms in the top-level Makefile is doing
the right thing by just doing a blind cmp -s. This comment also seems to
be a bit outdated or just generally inaccurate, as --all-symbols isn't
the default behaviour unless CONFIG_KALLSYMS_ALL is set.

--FL5UXtIhxfXey3p5
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFB1Yud1K+teJFxZ9wRAisdAJ9opJnIvQ4a+tpZCV/s+nPNULrnCACdFwoA
33hmthN3Mk2n7BnCOOEFiWM=
=XZWS
-----END PGP SIGNATURE-----

--FL5UXtIhxfXey3p5--
