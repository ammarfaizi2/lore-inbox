Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750700AbWA1T1p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750700AbWA1T1p (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jan 2006 14:27:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750701AbWA1T1p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jan 2006 14:27:45 -0500
Received: from proof.pobox.com ([207.106.133.28]:44686 "EHLO proof.pobox.com")
	by vger.kernel.org with ESMTP id S1750700AbWA1T1o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jan 2006 14:27:44 -0500
Date: Sat, 28 Jan 2006 13:27:36 -0600
From: Nathan Lynch <ntl@pobox.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Paul Jackson <pj@sgi.com>, Jack Steiner <steiner@sgi.com>,
       linux-kernel@vger.kernel.org, Robert Love <rml@novell.com>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.16 - sys_sched_getaffinity & hotplug
Message-ID: <20060128192736.GD18730@localhost.localdomain>
References: <20060127230659.GA4752@sgi.com> <20060127191400.aacb8539.pj@sgi.com> <20060128133244.GA22704@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060128133244.GA22704@elte.hu>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> 
> > Jack wrote:
> > > Should the following change be made to sched_getaffinity(). 
> > > 
> > > Index: linux/kernel/sched.c
> > > ===================================================================
> > > --- linux.orig/kernel/sched.c	2006-01-25 08:50:21.401747695 -0600
> > > +++ linux/kernel/sched.c	2006-01-27 16:57:24.504871895 -0600
> > > @@ -4031,7 +4031,7 @@ long sched_getaffinity(pid_t pid, cpumas
> > >  		goto out_unlock;
> > >  
> > >  	retval = 0;
> > > -	cpus_and(*mask, p->cpus_allowed, cpu_possible_map);
> > > +	cpus_and(*mask, p->cpus_allowed, cpu_online_map);
> > 
> In any case, Jack's change looks reasonable and obviously correct.

Are you sure?  Assuming this change is in effect, consider the
following:

Task starts with default affinity.

Task does sched_getaffinity, stashes the result in saved_mask.

Task pins itself to one cpu and does some work.

Meanwhile, more cpus are brought online.

Task finishes work and does sched_setaffinity(saved_mask).

Task will never run on the new cpus.


