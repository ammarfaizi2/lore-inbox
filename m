Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266507AbUHSPgi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266507AbUHSPgi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 11:36:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266565AbUHSPgR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 11:36:17 -0400
Received: from aun.it.uu.se ([130.238.12.36]:58287 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S266550AbUHSP3r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 11:29:47 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16676.51035.924323.992044@alkaid.it.uu.se>
Date: Thu, 19 Aug 2004 17:29:31 +0200
From: Mikael Pettersson <mikpe@csd.uu.se>
To: Corey Minyard <minyard@acm.org>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Patch to 2.6.8.1-mm2 to allow multiple NMI handlers to be registered
In-Reply-To: <4124BACB.30100@acm.org>
References: <4124BACB.30100@acm.org>
X-Mailer: VM 7.17 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Corey Minyard writes:
 > +static int k7_watchdog_reset(int handled)
 > +{
 > +	unsigned int low, high;
 > +	int          source;
 > +
 > +	rdmsr(MSR_K7_PERFCTR0, low, high);

Please use rdpmc() instead of rdmsr() when reading counter registers.
Ditto in the other places.
(I know oprofile doesn't, but that's no excuse.)

 > +	/* 
 > +	 * If the timer has overflowed, this is certainly a watchdog
 > +	 * source
 > +	 */
 > +	source = (low & (1 << 31)) == 0;
 > +	if (source)

Why not "if ((int)low >= 0)"?

 > +	/*
 > +	 * The only thing that SHOULD be before us is the oprofile
 > +	 * code.  If it has handled an NMI, then we shouldn't.  This
 > +	 * is a rather unnatural relationship, it would much better to
 > +	 * build a perf-counter handler and then tie both the
 > +	 * watchdog and oprofile code to it.  Then this ugliness
 > +	 * could go away.
 > +	 */

Depending on the value of nmi_watchdog and how oprofile was
set up, neither, just one, or both of them can cause NMIs.
Only one of them can do it via the performance counters, however.

How do you handle multiple simultaneous NMIs from different sources?
