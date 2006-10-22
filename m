Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932310AbWJVJQa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932310AbWJVJQa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 05:16:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932312AbWJVJQa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 05:16:30 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:29334 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932310AbWJVJQ3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 05:16:29 -0400
Date: Sun, 22 Oct 2006 02:16:19 -0700
From: Paul Jackson <pj@sgi.com>
To: dino@in.ibm.com
Cc: Simon.Derr@bull.net, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Cpuset: remove useless sched domain line
Message-Id: <20061022021619.189cc02f.pj@sgi.com>
In-Reply-To: <20061018172422.GA7885@in.ibm.com>
References: <20061014045517.22007.863.sendpatchset@v0>
	<20061018172422.GA7885@in.ibm.com>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >  	if (!is_cpu_exclusive(cur)) {
> > -		cpus_or(pspan, pspan, cur->cpus_allowed);
> >  		if (cpus_equal(pspan, cur->cpus_allowed))
> >  			return;
> >  		cspan = CPU_MASK_NONE;
> 
> 
> I dont think this is a valid optimization. What we are checking here
> is if a previously exclusive cpuset has been changed to a non-exclusive one
> (echo 0 > cpu_exclusive), we then OR all the cpus in the current cpuset
> to the parent cpuset. We then rebuild a sched domain to include all of the cpus
> in the current cpuset and those in the parent not part of exclusive children


Not that it matters, but I don't think you need to OR in the current cpuset
cpus to the parents cpus (pspan) here, because they are already in pspan.

Look at the surrounding code:

        pspan = par->cpus_allowed;
        list_for_each_entry(c, &par->children, sibling) {
                if (is_cpu_exclusive(c))
                        cpus_andnot(pspan, pspan, c->cpus_allowed);
        }
        if (!is_cpu_exclusive(cur)) {
		cpus_or(pspan, pspan, cur->cpus_allowed);
                if (cpus_equal(pspan, cur->cpus_allowed))
                        return;
                cspan = CPU_MASK_NONE;

'pspan' starts out with all the parents cpus, which must be a superset
of currents cpus (cur->cpus_allowed.)

Then we subtract (cpus_andnot) from pspan the cpus in the cpu_exclusive
siblings of current.  Since current is not cpu_exclusive, and since the
cpus of its cpu_exclusive sibling cpusets cannot overlap with currents
cpus, we could not have subtracted any current cpu from pspan.

So pspan is still a superset of currents cpus.

So OR'ing in currents cpus to pspan is a no-op.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
