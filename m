Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261245AbVDAGGT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261245AbVDAGGT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 01:06:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261592AbVDAGGT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 01:06:19 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:3543 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261245AbVDAGGM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 01:06:12 -0500
Date: Thu, 31 Mar 2005 22:05:26 -0800
From: Paul Jackson <pj@engr.sgi.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: kenneth.w.chen@intel.com, torvalds@osdl.org, mingo@elte.hu, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: Industry db benchmark result on recent 2.6 kernels
Message-Id: <20050331220526.3719ed7f.pj@engr.sgi.com>
In-Reply-To: <424C8956.7070108@yahoo.com.au>
References: <200503312214.j2VMEag23175@unix-os.sc.intel.com>
	<424C8956.7070108@yahoo.com.au>
Organization: SGI
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick wrote:
> Ingo had a cool patch to estimate dirty => dirty cacheline transfer latency
> ... Unfortunately ... and it is an O(cpus^2) operation.

Yes - a cool patch.

If we had an arch-specific bit of code, that for any two cpus, could
give a 'pseudo-distance' between them, where the only real requirements
were that (1) if two pairs of cpus had the same pseudo-distance, then
that meant they had the same size, layout, kind and speed of bus amd
cache hardware between them (*), and (2) it was cheap - hardly more than
a few lines of code and a subroutine call to obtain, then Ingo's code
could be:

	for each cpu c1:
	    for each cpu c2:
		psdist = pseudo_distance(c1, c2)
		if I've seen psdist before, use the latency computed for that psdist
		else compute a real latency number and remember it for that psdist

A generic form of pseudo_distance, which would work for all normal
sized systems, would be:

int pseudo_distance(int c1, int c2)
{
	static int x;
	return x++;
}

Then us poor slobs with big honkin numa iron could code up a real
pseudo_distance() routine, to avoid the actual pain of doing real work
for cpus^2 iterations for large cpu counts.

Our big boxes have regular geometries with much symmetry, so would
provide significant opportunity to exploit equal pseudo-distances.

And I would imagine that costs of K * NCPU * NCPU are tolerable in this
estimation routine. for sufficiently small K, and existing values of
NCPU.

(*) That is, if pseudo_distance(c1, c2) == pseudo_distance(d1, d2), then
    this meant that however c1 and c2 were connected to each other in the
    system (intervening buses and caches and such), cpus d1 and d2 were
    connected the same way, so could be presumed to have the same latency,
    close enough.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401
