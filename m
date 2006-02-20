Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932435AbWBTKDB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932435AbWBTKDB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 05:03:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932477AbWBTKDA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 05:03:00 -0500
Received: from mail10.syd.optusnet.com.au ([211.29.132.191]:459 "EHLO
	mail10.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S932435AbWBTKC6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 05:02:58 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Peter Williams <pwil3058@bigpond.net.au>
Subject: Re: [PATCH] sched: Consolidated and improved smpnice patch
Date: Mon, 20 Feb 2006 21:02:11 +1100
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Ingo Molnar <mingo@elte.hu>, npiggin@suse.de,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <43F94D71.1040109@bigpond.net.au>
In-Reply-To: <43F94D71.1040109@bigpond.net.au>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart6636442.AOlyCEIZkl";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200602202102.14003.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart6636442.AOlyCEIZkl
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Monday 20 February 2006 16:02, Peter Williams wrote:
[snip description]

Hi peter, I've had a good look and have just a couple of comments:

=2D--
 #endif
        int prio, static_prio;
+#ifdef CONFIG_SMP
+       int load_weight;        /* for load balancing purposes */
+#endif
=2D--

Can this be moved up to be part of the other ifdef CONFIG_SMP? Not highly=20
significant since it's in a .h file but looks a tiny bit nicer.

=2D--
+/*
+ * Priority weight for load balancing ranges from 1/20 (nice=3D=3D19) to 4=
59/20=20
(RT
+ * priority of 100).
+ */
+#define NICE_TO_LOAD_PRIO(nice) \
+       ((nice >=3D 0) ? (20 - (nice)) : (20 + (nice) * (nice)))
+#define LOAD_WEIGHT(lp) \
+       (((lp) * SCHED_LOAD_SCALE) / NICE_TO_LOAD_PRIO(0))
+#define NICE_TO_LOAD_WEIGHT(nice)      LOAD_WEIGHT(NICE_TO_LOAD_PRIO(nice))
+#define PRIO_TO_LOAD_WEIGHT(prio)     =20
NICE_TO_LOAD_WEIGHT(PRIO_TO_NICE(prio))
+#define RTPRIO_TO_LOAD_WEIGHT(rp) \
+       LOAD_WEIGHT(NICE_TO_LOAD_PRIO(-20) + (rp))
=2D--

The weighting seems not related to anything in particular apart from saying=
=20
that -nice values are more heavily weighted. Since you only do this when=20
setting the priority of tasks can you link it to the scale of (SCHED_NORMAL=
)=20
tasks' timeslice instead even though that will take a fraction more=20
calculation? RTPRIO_TO_LOAD_WEIGHT is fine since there isn't any obvious cp=
u=20
proportion relationship to rt_prio level.

Otherwise, good work, thanks!

> Signed-off-by: Peter Williams <pwil3058@bigpond.com.au>
Signed-off-by: Con Kolivas <kernel@kolivas.org>

Cheers,
Con

--nextPart6636442.AOlyCEIZkl
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBD+ZOlZUg7+tp6mRURArXXAKCCQhvji9YzAfWVRiUJQEZXGqDShQCeOqEw
O6hDJ5b5IHUb6zqGsCPRxM8=
=CF96
-----END PGP SIGNATURE-----

--nextPart6636442.AOlyCEIZkl--
