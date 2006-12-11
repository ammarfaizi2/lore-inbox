Return-Path: <linux-kernel-owner+w=401wt.eu-S1763093AbWLKVce@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763093AbWLKVce (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 16:32:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762949AbWLKVce
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 16:32:34 -0500
Received: from mx1.suse.de ([195.135.220.2]:55280 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763111AbWLKVcd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 16:32:33 -0500
Date: Mon, 11 Dec 2006 22:32:36 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: dean gaudet <dean@arctic.org>
Cc: john stultz <johnstul@us.ibm.com>, ak@suse.de,
       linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@elte.hu,
       Suleiman Souhlal <ssouhlal@FreeBSD.org>
Subject: Re: rdtscp vgettimeofday
Message-ID: <20061211213235.GN5363@opteron.random>
References: <20061129025728.15379.50707.sendpatchset@localhost> <20061129025752.15379.14257.sendpatchset@localhost> <20061211003904.GB5366@opteron.random> <Pine.LNX.4.64.0612111302440.22490@twinlark.arctic.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0612111302440.22490@twinlark.arctic.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 11, 2006 at 01:17:25PM -0800, dean gaudet wrote:
> rdtscp doesn't solve anything extra [..]
> [..] lsl-based vgetcpu is relatively slow

Well, if you accept to run slow there's nothing to solve in the first
place indeed.

If nothing else rdtscp should avoid the mess of restarting a
vsyscalls, which is quite a difficult problem as it heavily depends on
the compiler/dwarf.

> even with rdtscp you have to deal with the definite possibility of being 
> scheduled away in the middle of the computation.  arguably you need
> to 

Isn't rdtscp atomic? all you need is to read atomically the current
contents of the tsc and the index to use in a per-cpu table exported
in readonly. This table will contain a per-cpu seqlock as well. Then a
math logic has to be built with per-cpu threads, so that those per-cpu
tables are updated by cpufreq and at regular intervals.

If this is all wrong and it's not feasible to implement a safe and
monothonic vgettimeofday that doesn't access the southbridge and that
doesn't require restarting the vsyscall manually by patching rip/rsp,
I've an hard time to see how rdtscp is useful at all. I hope somebody
thought about those issues before adding a new instruction to a
popular CPU ;).
