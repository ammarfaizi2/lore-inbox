Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030737AbWJDCfS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030737AbWJDCfS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 22:35:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030738AbWJDCfS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 22:35:18 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:19946 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S1030737AbWJDCfP (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 22:35:15 -0400
Message-Id: <200610040233.k942Xk1v004859@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: tglx@linutronix.de
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Jim Gettys <jg@laptop.org>,
       John Stultz <johnstul@us.ibm.com>,
       David Woodhouse <dwmw2@infradead.org>,
       Arjan van de Ven <arjan@infradead.org>, Dave Jones <davej@redhat.com>
Subject: Re: [patch] dynticks core: Fix idle time accounting
In-Reply-To: Your message of "Tue, 03 Oct 2006 22:02:30 +0200."
             <1159905750.1386.215.camel@localhost.localdomain>
From: Valdis.Kletnieks@vt.edu
References: <20061001225720.115967000@cruncher.tec.linutronix.de> <200610021302.k92D23W1003320@turing-police.cc.vt.edu> <1159796582.1386.9.camel@localhost.localdomain> <200610021825.k92IPSnd008215@turing-police.cc.vt.edu> <1159814606.1386.52.camel@localhost.localdomain> <200610022017.k92KH4Ch004773@turing-police.cc.vt.edu> <1159824158.1386.77.camel@localhost.localdomain> <200610022135.k92LZHCn008618@turing-police.cc.vt.edu>
            <1159905750.1386.215.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1159929225_3990P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 03 Oct 2006 22:33:46 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1159929225_3990P
Content-Type: text/plain; charset=us-ascii

On Tue, 03 Oct 2006 22:02:30 +0200, Thomas Gleixner said:

> I found a way to fix my thinkos. I put up a queue with all fixes to:
> 
> http://www.tglx.de/projects/hrtimers/2.6.18-mm3/patch-2.6.18-mm3-hrt-dyntick1.patches.tar.bz2
> 
> Can you please verify if it makes your problem go away ?

Was -dyntick3 by the time I got there.

The user/system/idle/wait numbers now look sane, with one caveat:

static const ktime_t nsec_per_hz = { .tv64 = NSEC_PER_SEC / HZ };
...
                if (unlikely(delta.tv64 >= nsec_per_hz.tv64)) {
                        s64 incr = ktime_to_ns(nsec_per_hz);
                        ticks = ktime_divns(delta, incr);

Even though I have CONFIG_HZ=1000, this ends up generating a synthetic
count that works out to 100 per second.  gkrellm and vmstat are happy with
that state of affairs, but I'm not sure why it came out to 100/sec rather
than 1000/sec.

% cat /proc/stat /proc/uptime
cpu  28224 4688 9159 168290 9143 283 256 0
cpu0 28224 4688 9159 168290 9143 283 256 0
intr 818891 627337 3466 0 4 4 6459 3 7 1 1 4 160328 115 0 21162 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
ctxt 971441
btime 1159926408
processes 4544
procs_running 1
procs_blocked 0
nohz total I:367986 S:302473 T:1737.640072 A:0.005744 E: 625327
2176.02 1775.11

Also, it still disagrees with speedstep - it isn't noticing the TSC has
gone slow and drop back to the PM timer.

All in all, we're making progress. ;)

--==_Exmh_1159929225_3990P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFFIx2JcC3lWbTT17ARAsNuAKC1yguHkX1Cc8/5xZNiLFRhYSxYZACbBlkj
ZWHNRZBX3H0p5vE4W+Sdm3A=
=N3Xv
-----END PGP SIGNATURE-----

--==_Exmh_1159929225_3990P--
