Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759247AbWK3LWl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759247AbWK3LWl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 06:22:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759249AbWK3LWk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 06:22:40 -0500
Received: from smtp.osdl.org ([65.172.181.25]:18661 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1759247AbWK3LWk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 06:22:40 -0500
Date: Thu, 30 Nov 2006 03:19:33 -0800
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Gautham R Shenoy <ego@in.ibm.com>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org, davej@redhat.com, dipankar@in.ibm.com,
       vatsa@in.ibm.com
Subject: Re: CPUFREQ-CPUHOTPLUG: Possible circular locking dependency
Message-Id: <20061130031933.5d30ec09.akpm@osdl.org>
In-Reply-To: <20061130110315.GA30460@elte.hu>
References: <20061129152404.GA7082@in.ibm.com>
	<20061130083144.GC29609@elte.hu>
	<20061130102410.GB23354@in.ibm.com>
	<20061130110315.GA30460@elte.hu>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Nov 2006 12:03:15 +0100
Ingo Molnar <mingo@elte.hu> wrote:

> 
> * Gautham R Shenoy <ego@in.ibm.com> wrote:
> 
> > a) cpufreq maintain's it's own cpumask in the variable 
> > policy->affected_cpus and says : If a frequency change is issued to 
> > any one of the cpu's in the affected_cpus mask, you change frequency 
> > on all cpus in the mask. So this needs to be consistent with 
> > cpu_online map and hence cpu hotplug aware. Furthermore, we don't want 
> > cpus in this mask to go down when we are trying to change frequencies 
> > on them. The function which drives the frequency change in 
> > cpufreq-core is cpufreq_driver_target and it needs cpu-hotplug 
> > protection.
> 
> couldnt this complexity be radically simplified by having new kernel 
> infrastructure that does something like:
> 
>   " 'gather' all CPUs mentioned in <mask> via scheduling a separate 
>     helper-kthread on every CPU that <mask> specifies, disable all
>    interrupts, and execute function <fn> once all CPUs have been 
>    'gathered' - and release all CPUs once <fn> has executed on each of
>    them."
> 
> ?

How does this differ from stop_machine_run(), which hot-unplug presently uses?

> This would be done totally serialized and while holding the hotplug 
> lock, so no CPU could go away or arrive while this operation is going 
> on.

You said "the hotplug lock".  That is the problem.
