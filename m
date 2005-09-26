Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932421AbVIZHOX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932421AbVIZHOX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 03:14:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932423AbVIZHOX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 03:14:23 -0400
Received: from gockel.physik3.uni-rostock.de ([139.30.44.16]:9871 "EHLO
	gockel.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id S932421AbVIZHOW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 03:14:22 -0400
Date: Mon, 26 Sep 2005 09:14:02 +0200 (CEST)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Paul Blazejowski <paulb@blazebox.homeip.net>
cc: LKML <linux-kernel@vger.kernel.org>, Carlo Calica <ccalica@gmail.com>,
       xorg@lists.freedesktop.org
Subject: Re: 2.6.14-rc2-mm1
In-Reply-To: <20050925220037.GA8776@blazebox.homeip.net>
Message-ID: <Pine.LNX.4.53.0509260911540.29885@gockel.physik3.uni-rostock.de>
References: <20050925220037.GA8776@blazebox.homeip.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 25 Sep 2005, Paul Blazejowski wrote:

> Upon quick testing the latest mm kernel it appears there's some kind of
> race condition when using dual core cpu esp when using XORG and USB
> (although PS2 has same issue) kebyboard rate being too fast.

Does the following patch by John Stultz fix the problem?

Tim


>From johnstul@us.ibm.com Mon Sep 26 09:04:08 2005
Date: Mon, 19 Sep 2005 12:16:43 -0700
From: john stultz <johnstul@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>
Subject: [PATCH] x86-64: Fix bad assumption that dualcore cpus have synced
    TSCs

Andrew,
	This patch should resolve the issue seen in bugme bug #5105, where it
is assumed that dualcore x86_64 systems have synced TSCs. This is not
the case, and alternate timesources should be used instead.

For more details, see:
http://bugzilla.kernel.org/show_bug.cgi?id=5105


Please consider for inclusion in your tree.

thanks
-john

diff --git a/arch/x86_64/kernel/time.c b/arch/x86_64/kernel/time.c
--- a/arch/x86_64/kernel/time.c
+++ b/arch/x86_64/kernel/time.c
@@ -959,9 +959,6 @@ static __init int unsynchronized_tsc(voi
  	   are handled in the OEM check above. */
  	if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL)
  		return 0;
- 	/* All in a single socket - should be synchronized */
- 	if (cpus_weight(cpu_core_map[0]) == num_online_cpus())
- 		return 0;
 #endif
  	/* Assume multi socket systems are not synchronized */
  	return num_online_cpus() > 1;


