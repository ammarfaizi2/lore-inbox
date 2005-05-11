Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261280AbVEKU1A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261280AbVEKU1A (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 16:27:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261284AbVEKU1A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 16:27:00 -0400
Received: from orb.pobox.com ([207.8.226.5]:65199 "EHLO orb.pobox.com")
	by vger.kernel.org with ESMTP id S261280AbVEKU06 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 16:26:58 -0400
Date: Wed, 11 May 2005 15:26:48 -0500
From: Nathan Lynch <ntl@pobox.com>
To: Paul Jackson <pj@sgi.com>
Cc: dino@in.ibm.com, Simon.Derr@bull.net, lse-tech@lists.sourceforge.net,
       akpm@osdl.org, nickpiggin@yahoo.com.au, vatsa@in.ibm.com,
       linux-kernel@vger.kernel.org
Subject: Re: [Lse-tech] [PATCH] cpusets+hotplug+preepmt broken
Message-ID: <20050511202648.GF3614@otto>
References: <20050511191654.GA3916@in.ibm.com> <20050511122543.6e9f6097.pj@sgi.com> <20050511125508.20bf44ec.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050511125508.20bf44ec.pj@sgi.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2005 at 12:55:08PM -0700, Paul Jackson wrote:
> pj wrote:
> > Could you explain why this is -- what is the deadlock?
> 
> On further reading, I see it.  You're right.
> 
> Deep in the bowels of the hotplug code, when removing a dead cpu, while
> holding the runqueue lock (task_rq_lock), the hotplug code might need to
> walk up the cpuset hierarchy, to find the nearest enclosing cpuset that
> still has online cpus, as part of figuring where to run a task that is
> being kicked off the dead cpu.  The runqueue lock is atomic, but getting
> the cpuset_sem (needed to walk up the cpuset hierarchy) can sleep.  So
> you need to get the cpuset_sem before calling task_rq_lock, so as to
> avoid the "scheduling while atomic" oops that you reported.  Therefore
> the hotplug code, and anyone else calling cpuset_cpus_allowed(), which
> means sched_setaffinity(), needs to first grab cpuset_sem, so that they
> can grab any atomic locks needed, after getting cpuset_sem, not before.

Won't holding cpuset_sem while calling cpuset_cpus_allowed cause a
deadlock?

Nathan
