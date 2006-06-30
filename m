Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932223AbWF3VEN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932223AbWF3VEN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 17:04:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932399AbWF3VEN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 17:04:13 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:61099 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S932223AbWF3VEM (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 17:04:12 -0400
Message-Id: <200606302104.k5UL41vs004400@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: john stultz <johnstul@us.ibm.com>
Cc: Roman Zippel <zippel@linux-m68k.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-mm2 hrtimer code wedges at boot?
In-Reply-To: Your message of "Fri, 30 Jun 2006 12:26:09 PDT."
             <1151695569.5375.22.camel@localhost.localdomain>
From: Valdis.Kletnieks@vt.edu
References: <20060624061914.202fbfb5.akpm@osdl.org> <200606262141.k5QLf7wi004164@turing-police.cc.vt.edu> <Pine.LNX.4.64.0606271212150.17704@scrub.home> <200606271643.k5RGh9ZQ004498@turing-police.cc.vt.edu> <Pine.LNX.4.64.0606271903320.12900@scrub.home> <Pine.LNX.4.64.0606271919450.17704@scrub.home> <200606271907.k5RJ7kdg003953@turing-police.cc.vt.edu> <1151453231.24656.49.camel@cog.beaverton.ibm.com> <Pine.LNX.4.64.0606281218130.12900@scrub.home> <Pine.LNX.4.64.0606281335380.17704@scrub.home> <200606292307.k5TN7MGD011615@turing-police.cc.vt.edu>
            <1151695569.5375.22.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1151701441_3089P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Fri, 30 Jun 2006 17:04:01 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1151701441_3089P
Content-Type: text/plain; charset=us-ascii

On Fri, 30 Jun 2006 12:26:09 PDT, john stultz said:

> Its a little after the fact (since things have already gone awry), but
> it does show the multiplier is way out of bound.
> 
> I suspect the following patch will resolve it. The update callback
> hasn't kept up with the changes from Roman, and is a bit useless anyway.
> If the TSC is changing frequency, its unstable and we don't want to use
> it, so lets just mark it as such and move along.
> 
> I'll work on a patch to cleanup the update_callback code, but if this
> resolves the issue, it should be the safe short term fix for 2.6.18.

*AHA* I *found* the bugger, I think.

In kernel/timer.c, we have:

static void clocksource_adjust(struct clocksource *clock, s64 offset)
(s64 used for offset in multiple places).

However, in other places, offset is a 'cycle_t', which is:

include/linux/clocksource.h:typedef u64 cycle_t;

So it looks like a signed/unsigned screwage.

--==_Exmh_1151701441_3089P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFEpZHBcC3lWbTT17ARAqVfAJ49Wmwd5Nj24AnisW8NaiTvB+w9SwCfWJ7e
zGtOKVygV7eaKHFsxvSJV6M=
=RKWZ
-----END PGP SIGNATURE-----

--==_Exmh_1151701441_3089P--
