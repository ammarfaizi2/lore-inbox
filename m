Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261444AbVEMUtJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261444AbVEMUtJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 16:49:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261527AbVEMUr6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 16:47:58 -0400
Received: from orb.pobox.com ([207.8.226.5]:14277 "EHLO orb.pobox.com")
	by vger.kernel.org with ESMTP id S261465AbVEMUrE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 16:47:04 -0400
Date: Fri, 13 May 2005 15:46:52 -0500
From: Nathan Lynch <ntl@pobox.com>
To: Dipankar Sarma <dipankar@in.ibm.com>
Cc: Paul Jackson <pj@sgi.com>, vatsa@in.ibm.com, dino@in.ibm.com,
       Simon.Derr@bull.net, lse-tech@lists.sourceforge.net, akpm@osdl.org,
       nickpiggin@yahoo.com.au, linux-kernel@vger.kernel.org,
       rusty@rustcorp.com.au
Subject: Re: [Lse-tech] Re: [PATCH] cpusets+hotplug+preepmt broken
Message-ID: <20050513204652.GI3614@otto>
References: <20050511191654.GA3916@in.ibm.com> <20050511195156.GE3614@otto> <20050513123216.GB3968@in.ibm.com> <20050513172540.GA28018@in.ibm.com> <20050513125953.66a59436.pj@sgi.com> <20050513202058.GE5044@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050513202058.GE5044@in.ibm.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > In particular, in my view, locks should guard data.  What data does
> > lock_cpu_hotplug() guard?  I propose that it guards cpu_online_map.
> > 
> > I recommend considering a different name for this lock.  Perhaps
> > 'cpu_online_sem', instead of 'cpucontrol'?   And perhaps the
> > lock_cpu_hotplug() should be renamed, to say 'lock_cpu_online'?
> 
> No. CPU hotplug uses two different locking - see both lock_cpu_hotplug()
> and __stop_machine_run(). Anyone reading cpu_online_map with
> preemption disabled is safe from cpu hotplug even without taking
> any lock.

More precisely (I think), reading cpu_online_map with preemption
disabled guarantees that none of the cpus in the map will go offline
-- it does not prevent an online operation in progress (but most code
only cares about the former case).  Also note that __stop_machine_run
is used only to offline a cpu.

The cpucontrol semaphore does not only protect cpu_online_map and
cpu_present_map, but also serializes cpu hotplug operations, so that
only one may be in progress at a time.

I've been mulling over submitting a Documentation/cpuhotplug.txt,
sounds like there's sufficient demand...

Nathan
