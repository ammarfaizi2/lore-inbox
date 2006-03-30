Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751300AbWC3Act@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751300AbWC3Act (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 19:32:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751301AbWC3Acs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 19:32:48 -0500
Received: from mtagate3.uk.ibm.com ([195.212.29.136]:50713 "EHLO
	mtagate3.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1751300AbWC3Acr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 19:32:47 -0500
Message-ID: <442B271D.10208@watson.ibm.com>
Date: Wed, 29 Mar 2006 19:32:29 -0500
From: Shailabh Nagar <nagar@watson.ibm.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20051002)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Greg KH <greg@kroah.com>, Arjan van de Ven <arjan@infradead.org>,
       Jamal <hadi@cyberus.ca>, Andi Kleen <ak@suse.de>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Patch 0/8] per-task delay accounting 
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

Could you please include the following delay accounting patches
in -mm ?

The patches have gone through several iterations on lkml and
numerous comments raised by reviewers have been addressed

- several netlink interface comments (Jamal)
- block I/O collection method (Arjan)
- block I/O delays export through /proc (Andi)
- performance issues (Greg) (just addressed, see below)
- GPL headers (Arjan)

Most of the descriptions of the patches are either in the
patch itself or in the documentation patch at the end.

Thanks
--Shailabh


Patch series

delayacct-setup.patch
delayacct-blkio-swapin.patch
delayacct-schedstats.patch
genetlink-utils.patch
delayacct-genetlink.patch
delayacct-virtcpu.patch
delayacct-procfs.patch
delayacct-doc.patch



Results highlights

- No statistically significant performance degradation is seen in
  kernbench, hackbench and large OLTP benchmark when delay
  accounting is configured.

  The overheads of configuring delay accounting,
  without enabling at boot time, are statistically negligible
  for hackbench and a large OLTP benchmark and negative
  (i.e. performance improves) in kernbench.

- Similar lack of degradation is seen in kernbench and hackbench
  even when delay accounting is enabled at boot.

  No data could be collected for the large OLTP benchmark (efforts
  ongoing).

Legend

Base
	Vanilla 2.6.16 kernel
	without any patches applied
+patch	
	Delay accounting configured
	but not enabled at boot
+patch+enable
	Delay accounting enabled at boot
	but no stats read



Time	Elapsed time, averaged over 10 runs
Stddev	Standard deviation of elapsed times
Ovhd	% difference of elapsed time with respect to base kernel
t-value	Used to measure statistical significance
	of difference of two mean values (in this
	case mean elapsed time). Low t-values indicate
	insignificant difference. The t-values here were
	calculated at 95% confidence interval using the tool at
	http://www.polarismr.com/education/tools_stat_diff_means.html


Hackbench
---------
200 groups, using pipes
Elapsed time, in seconds, lower better

		Ovhd	Time 	Stddev	Ovhd significant (t-value)
Base		0%	43.483	0.178	na
+patch		0.1%	43.517	0.265	No (0.337)
+patch+enable	0.3%	43.629	0.167	No (1.892)

Kernbench
---------
Average of 10 iterations
Elapsed time, in seconds, lower better

		Ovhd	Time 	Stddev	Ovhd significant (t-value)
Base		0%	196.704	0.459	na
+patch		-0.5%	195.812	0.477	Yes (4.261)
+patch+enable	0.02%	196.752 0.356	No (0.261)


Large OLTP benchmark
--------------------
An industry standard large database online transaction processing
workload was run with delay accounting patches configured
ON and OFF.

The performance degradation of delay accounting was about 0.2%,
which was well within the normal range of variation between
similar runs.

No runs were taken with delay accounting enabled at boot time.
