Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422824AbWA1Dms@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422824AbWA1Dms (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 22:42:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422819AbWA1Dms
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 22:42:48 -0500
Received: from proof.pobox.com ([207.106.133.28]:940 "EHLO proof.pobox.com")
	by vger.kernel.org with ESMTP id S1422824AbWA1Dmr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 22:42:47 -0500
Date: Fri, 27 Jan 2006 21:42:41 -0600
From: Nathan Lynch <ntl@pobox.com>
To: Paul Jackson <pj@sgi.com>
Cc: Jack Steiner <steiner@sgi.com>, mingo@elte.hu,
       linux-kernel@vger.kernel.org, Robert Love <rml@novell.com>
Subject: Re: 2.6.16 - sys_sched_getaffinity & hotplug
Message-ID: <20060128034241.GB18730@localhost.localdomain>
References: <20060127230659.GA4752@sgi.com> <20060127191400.aacb8539.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060127191400.aacb8539.pj@sgi.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson wrote:
> Jack wrote:
> > Should the following change be made to sched_getaffinity(). 
> > 
> > Index: linux/kernel/sched.c
> > ===================================================================
> > --- linux.orig/kernel/sched.c	2006-01-25 08:50:21.401747695 -0600
> > +++ linux/kernel/sched.c	2006-01-27 16:57:24.504871895 -0600
> > @@ -4031,7 +4031,7 @@ long sched_getaffinity(pid_t pid, cpumas
> >  		goto out_unlock;
> >  
> >  	retval = 0;
> > -	cpus_and(*mask, p->cpus_allowed, cpu_possible_map);
> > +	cpus_and(*mask, p->cpus_allowed, cpu_online_map);
> 
> Adding Robert Love to the cc list, as he is Mr. sched_getaffinity,
> I believe.
> 
> I ended up doing a similar change, to the cpus (and mems) masks
> in the root (all encompassing) cpuset.

Which is problematic, because cpuset_cpus_allowed ->
guarantee_online_cpus restricts the task->cpus_allowed mask to cpus
which happen to be online at the time of the call to
sched_setaffinity.  If more cpus come online later, that task can't be
migrated to them.

> These now show the values
> of cpu_online_map and node_online_map, not *_MASK_ALL.
> 
> My hunches are:
>  * This change to cpu_online_map is a good one.

It's not.

>  * The man page sentence "Usually, all bits in the mask are set."
>    might have meant something when it was written, but it is not
>    now clear what.

I think it could reasonably be interpreted as all bits in the mask are
set unless the task's affinity has been modified.
