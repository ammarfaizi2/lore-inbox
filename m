Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932472AbVIHMCt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932472AbVIHMCt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 08:02:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932473AbVIHMCt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 08:02:49 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:21899 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932472AbVIHMCt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 08:02:49 -0400
Date: Thu, 8 Sep 2005 05:02:32 -0700
From: Paul Jackson <pj@sgi.com>
To: KUROSAWA Takahiro <kurosawa@valinux.co.jp>
Cc: dino@in.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] SUBCPUSETS: a resource control functionality using
 CPUSETS
Message-Id: <20050908050232.3681cf0c.pj@sgi.com>
In-Reply-To: <20050908081819.2EA4E70031@sv1.valinux.co.jp>
References: <20050908053912.1352770031@sv1.valinux.co.jp>
	<20050908002323.181fd7d5.pj@sgi.com>
	<20050908081819.2EA4E70031@sv1.valinux.co.jp>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Takahiro-san wrote, in reply to Paul:
> >  2) Would a structure similar to Dinakar's patches to connect
> >     cpusets and dynamic sched domains (posted to linux-mm)
> >     work here as well?
> 
> Yes, subcpusets could work with the dynamic sched domains.

Ah - I see I was quite unclear about what I was thinking.

I intended to ask not simply would Dinakar's patches work with
subcpusets, but something more radical.

These subcpusets, if I understand correctly, are a bit different
from ordinary cpusets.  For instance, it seems one cannot make child
cpusets of them, and one cannot change most of their properties,
such as cpus, mems, cpu_exclusive, mem_exclusive, or notify_on_release.

Also the mems and cpus of each subcpuset are required to be
exactly equal to the corresponding values of its parent.

One of my passions is to avoid special cases across API boundaries.

I am proposing that you don't do subcpusets like this.

Consider the following alternative I will call 'cpuset meters'.

For each resource named 'R' (cpu and mem, for instance):
 * Add a boolean flag 'meter_R' to each cpuset.  If set, that R is
   metered, for the tasks in that cpuset or any descendent cpuset.
 * If a cpuset is metered, then files named meter_R_guar, meter_R_lim
   and meter_R_cur appear in that cpuset to manage R's usage by tasks
   in that cpuset and descendents.
 * There are no additional rules that restrict the ability to change
   various other cpuset properties such as cpus, mems, cpu_exclusive,
   mem_exclusive, or notify_on_release, when a cpuset is metered.
 * It might be that some (or by design all) resource controllers do
   not allow nesting metered cpusets.  I don't know.  But one should
   (if one has permission) be able to make child cpusets of a metered
   cpuset, just like one can of any other cpuset.
 * A metered cpuset might well have cpus or mems that are not the
   same as its parent, just like an unmetered cpuset ordinarly does.

If I understand correctly, one could place a job that managed its
own child cpusets into a metered cpuset, but not into a subcpuset.
Even if you wanted to allow it, it seems jobs in subcpusets cannot
make child cpusets or modify the properties of their current cpuset.
Is that correct?

The above is just a fragment of an idea.  I do not know if it is
a good idea or not.  And I left off critical details such as just
what the resource guarantees and limits mean.

Most likely, the way I stated it, there is some good reason that is
very obvious to you why metered cpusets don't work.  Perhaps some
variation would work and be worthy of consideration as an alternative
to subcpusets.

I hope to reduce to a minimum the special limitations on these cpusets,
whether subcpusets or metered cpusets.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
