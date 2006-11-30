Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935885AbWK3LD5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935885AbWK3LD5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 06:03:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935939AbWK3LD4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 06:03:56 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:34235 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S935885AbWK3LD4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 06:03:56 -0500
Date: Thu, 30 Nov 2006 12:03:15 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Gautham R Shenoy <ego@in.ibm.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, torvalds@osdl.org,
       davej@redhat.com, dipankar@in.ibm.com, vatsa@in.ibm.com
Subject: Re: CPUFREQ-CPUHOTPLUG: Possible circular locking dependency
Message-ID: <20061130110315.GA30460@elte.hu>
References: <20061129152404.GA7082@in.ibm.com> <20061130083144.GC29609@elte.hu> <20061130102410.GB23354@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061130102410.GB23354@in.ibm.com>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=none autolearn=no SpamAssassin version=3.0.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Gautham R Shenoy <ego@in.ibm.com> wrote:

> a) cpufreq maintain's it's own cpumask in the variable 
> policy->affected_cpus and says : If a frequency change is issued to 
> any one of the cpu's in the affected_cpus mask, you change frequency 
> on all cpus in the mask. So this needs to be consistent with 
> cpu_online map and hence cpu hotplug aware. Furthermore, we don't want 
> cpus in this mask to go down when we are trying to change frequencies 
> on them. The function which drives the frequency change in 
> cpufreq-core is cpufreq_driver_target and it needs cpu-hotplug 
> protection.

couldnt this complexity be radically simplified by having new kernel 
infrastructure that does something like:

  " 'gather' all CPUs mentioned in <mask> via scheduling a separate 
    helper-kthread on every CPU that <mask> specifies, disable all
   interrupts, and execute function <fn> once all CPUs have been 
   'gathered' - and release all CPUs once <fn> has executed on each of
   them."

?

This would be done totally serialized and while holding the hotplug 
lock, so no CPU could go away or arrive while this operation is going 
on.

	Ingo
