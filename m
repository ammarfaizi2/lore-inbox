Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272432AbTHEEyn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 00:54:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272433AbTHEEym
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 00:54:42 -0400
Received: from h80ad25d0.async.vt.edu ([128.173.37.208]:24962 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S272432AbTHEEyj (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 00:54:39 -0400
Message-Id: <200308050454.h754sBqM004950@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Nick Piggin <piggin@cyberone.com.au>
Cc: William Lee Irwin III <wli@holomorphy.com>,
       Con Kolivas <kernel@kolivas.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] O11int for interactivity  
In-Reply-To: Your message of "Tue, 05 Aug 2003 13:38:34 +1000."
             <3F2F26BA.3060904@cyberone.com.au> 
From: Valdis.Kletnieks@vt.edu
References: <200307301038.49869.kernel@kolivas.org> <20030802225513.GE32488@holomorphy.com> <200308030119.47474.m.c.p@wolk-project.de> <200308042106.51676.m.c.p@wolk-project.de> <20030804195335.GK32488@holomorphy.com> <3F2F00B0.9050804@cyberone.com.au> <20030805024103.GM32488@holomorphy.com> <3F2F1F80.7060207@cyberone.com.au> <20030805031341.GN32488@holomorphy.com> <3F2F231C.3030901@cyberone.com.au> <20030805033119.GO32488@holomorphy.com>
            <3F2F26BA.3060904@cyberone.com.au>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1030787880P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 05 Aug 2003 00:54:10 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1030787880P
Content-Type: text/plain; charset=us-ascii

On Tue, 05 Aug 2003 13:38:34 +1000, Nick Piggin said:

> Of course some minimum read _latency_ would be required: this
> could actually be done easily with strace come to think of it.
> 
> Maybe some xmms mapped memory is being swapped out? But that
> would be more of a VM problem.

I was seeing some CPU-related pauses, but once Con's work got to O7 or so,
those disappeared.   I'm *quite* convinced that the remaining glitches
are VM related, mostly because every glitch seems to be associated with
an increase in the 'pswpout' field in /proc/vmstat (yes, I tested with stuff like
"for (;;)  do cat /proc/vmstat; sleep 1 done;".

The *odd* part is that the pgpgin, pgpgout, and pswpin numbers do *NOT*
seem to be correlated.  High I/O loads from read/write don't seem to cause
a problem - untarring the Linux distro won't do it, running badblocks won't do it.

But if somebody has to swap out, all hell breaks loose...

Hmm.. looking at mm/page_io.c, it seems swap_writepage() calls get_swap_bio
with GFP_NOIO, while readdpage() uses GFP_KERNEL. I wonder if that GFP_NOIO is
causing ugliness - that's really __GFP_WAIT, and the comments in bio_alloc() are
pretty clear that it can block.  And remember we're not getting into this code unless
we're already under memory pressure....

(And if somebody tells me how to instrument a -test2-mm4 kernel so I can tell if
I'm on crack or not, I'll happily do so....)

--==_Exmh_1030787880P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/LzhxcC3lWbTT17ARApVHAJ9pvuFj1QprPNdHiHWKG6HgZ4yaFACcDbQe
djxo/Qxkewbu40lb+pr7msc=
=JUc+
-----END PGP SIGNATURE-----

--==_Exmh_1030787880P--
