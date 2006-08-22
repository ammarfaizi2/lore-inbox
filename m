Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750705AbWHVFEM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750705AbWHVFEM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 01:04:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750706AbWHVFEM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 01:04:12 -0400
Received: from rune.pobox.com ([208.210.124.79]:49885 "EHLO rune.pobox.com")
	by vger.kernel.org with ESMTP id S1750705AbWHVFEK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 01:04:10 -0400
Date: Tue, 22 Aug 2006 00:04:01 -0500
From: Nathan Lynch <ntl@pobox.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Paul Jackson <pj@sgi.com>, Anton Blanchard <anton@samba.org>,
       simon.derr@bull.net, nathanl@austin.ibm.com,
       linux-kernel@vger.kernel.org
Subject: Re: cpusets not cpu hotplug aware
Message-ID: <20060822050401.GB11309@localdomain>
References: <20060821132709.GB8499@krispykreme> <20060821104334.2faad899.pj@sgi.com> <20060821192133.GC8499@krispykreme> <20060821140148.435d15f3.pj@sgi.com> <20060821215120.244f1f6f.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060821215120.244f1f6f.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Mon, 21 Aug 2006 14:01:48 -0700
> Paul Jackson <pj@sgi.com> wrote:
> > Anton wrote:
> > > If cpuset_cpus_allowed doesnt return the current online mask and we want
> > > to schedule on a cpu that has been added since boot it looks like we
> > > will fail.
> > 
> > In general, on systems actually using cpusets, that -is- what should
> > happen.  Just because a cpu was brought online doesn't mean it was
> > intended to be allowed in any given tasks current cpuset.
> > 
> > Granted, I would guess users of systems not using cpusets (but
> > still have cpusets configured in their kernel, as is common in some
> > distro kernels), would expect the behaviour you expected - bringing
> > a cpu (or memory node) on or offline would make it available (or
> > not) for something like a sched_setaffinity (or mbind/set_mempolicy)
> > immediately, without having to invoke some magic cpuset voodoo.
> > 
> > Offhand, this sounds to me like a choice of two modes of operation.
> > 
> >     If you aren't actually using cpusets (so every task is in the
> >     original top_cpuset) then you'd expect that cpuset to "get out
> >     of the way", meaning top_cpuset (the only cpuset, in this case)
> >     tracked whatever cpus and nodes were online at the moment.
> > 
> >     If instead you start messing with cpusets (creating more than one
> >     of them and moving tasks between them) then you'd expect cpusets
> >     to be enforced, without automatically adding newly added cpus or
> >     memory nodes to existing cpusets.  Only the user knows which
> >     cpusets should get the added cpus or memory nodes in this case.
> > 
> > I don't jump for joy over yet another modal state flag.  But I don't see
> > a better alternative -- do you?
> > 
> 
> If the kernel provider (ie: distro) has enabled cpusets then it would be
> appropriate that they also provide a hotplug script which detects whether their
> user is actually using cpusets and if not, to take some sensible default action. 
> ie: add the newly-added CPU to the system's single cpuset, no?

I think it would be more sensible for the default (i.e. user hasn't
explicitly configured any cpusets) behavior on a CONFIG_CPUSETS=y
kernel to match the behavior with a CONFIG_CPUSETS=n kernel.  Right
now we don't have that.  Binding a task to a newly added cpu just
fails if CONFIG_CPUSETS=y, but it works if CONFIG_CPUSETS=n.

