Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262035AbVEKTze@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262035AbVEKTze (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 15:55:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262037AbVEKTze
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 15:55:34 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:22742 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S262035AbVEKTzZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 15:55:25 -0400
Date: Wed, 11 May 2005 12:55:08 -0700
From: Paul Jackson <pj@sgi.com>
To: Paul Jackson <pj@sgi.com>
Cc: dino@in.ibm.com, Simon.Derr@bull.net, lse-tech@lists.sourceforge.net,
       akpm@osdl.org, nickpiggin@yahoo.com.au, vatsa@in.ibm.com,
       linux-kernel@vger.kernel.org
Subject: Re: [Lse-tech] [PATCH] cpusets+hotplug+preepmt broken
Message-Id: <20050511125508.20bf44ec.pj@sgi.com>
In-Reply-To: <20050511122543.6e9f6097.pj@sgi.com>
References: <20050511191654.GA3916@in.ibm.com>
	<20050511122543.6e9f6097.pj@sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

pj wrote:
> Could you explain why this is -- what is the deadlock?

On further reading, I see it.  You're right.

Deep in the bowels of the hotplug code, when removing a dead cpu, while
holding the runqueue lock (task_rq_lock), the hotplug code might need to
walk up the cpuset hierarchy, to find the nearest enclosing cpuset that
still has online cpus, as part of figuring where to run a task that is
being kicked off the dead cpu.  The runqueue lock is atomic, but getting
the cpuset_sem (needed to walk up the cpuset hierarchy) can sleep.  So
you need to get the cpuset_sem before calling task_rq_lock, so as to
avoid the "scheduling while atomic" oops that you reported.  Therefore
the hotplug code, and anyone else calling cpuset_cpus_allowed(), which
means sched_setaffinity(), needs to first grab cpuset_sem, so that they
can grab any atomic locks needed, after getting cpuset_sem, not before.

Acked-by: Paul Jackson <pj@sgi.com>

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401
