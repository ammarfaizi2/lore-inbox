Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261990AbVDAGez@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261990AbVDAGez (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 01:34:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262110AbVDAGe3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 01:34:29 -0500
Received: from smtp209.mail.sc5.yahoo.com ([216.136.130.117]:53623 "HELO
	smtp209.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261990AbVDAGeP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 01:34:15 -0500
Subject: Re: Industry db benchmark result on recent 2.6 kernels
From: Nick Piggin <nickpiggin@yahoo.com.au>
To: Paul Jackson <pj@engr.sgi.com>
Cc: kenneth.w.chen@intel.com, torvalds@osdl.org, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20050331220526.3719ed7f.pj@engr.sgi.com>
References: <200503312214.j2VMEag23175@unix-os.sc.intel.com>
	 <424C8956.7070108@yahoo.com.au>  <20050331220526.3719ed7f.pj@engr.sgi.com>
Content-Type: text/plain
Date: Fri, 01 Apr 2005 16:34:04 +1000
Message-Id: <1112337244.7081.8.camel@npiggin-nld.site>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-03-31 at 22:05 -0800, Paul Jackson wrote:
> 
> Then us poor slobs with big honkin numa iron could code up a real
> pseudo_distance() routine, to avoid the actual pain of doing real work
> for cpus^2 iterations for large cpu counts.
> 
> Our big boxes have regular geometries with much symmetry, so would
> provide significant opportunity to exploit equal pseudo-distances.
> 

Couple of observations:

This doesn't actually need to be an O(n^2) operation. The result
of it is only going to be used in the sched domains code, so what
is really wanted is "how far away is one sched_group from another",
although we may also scale that based on the *amount* of cache
in the path between 2 cpus, that is often just a property of the
CPUs themselves in smaller systems, so also not O(n^2).

Secondly, we could use Ingo's O(n^2) code for the *SMP* domain on
all architectures (so in your case of only 2 CPUs per node, it is
obviously much cheaper, even over 256 nodes).

Then the NUMA domain could just inherit this SMP value as a default,
and allow architectures to override it individually.

This may allow us to set up decent baseline numbers, properly scaled
by cache size vs memory bandwidth without going overboard in
complexity (while still allowing arch code to do more fancy stuff).



