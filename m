Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263413AbUDGFAd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 01:00:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264097AbUDGFAc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 01:00:32 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:4793 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263413AbUDGFAb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 01:00:31 -0400
Date: Wed, 7 Apr 2004 10:31:11 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, rusty@au1.ibm.com,
       Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       LHCS list <lhcs-devel@lists.sourceforge.net>
Subject: Re: [Experimental CPU Hotplug PATCH] - Move migrate_all_tasks to CPU_DEAD handling
Message-ID: <20040407050111.GA10256@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20040405121824.GA8497@in.ibm.com> <4071F9C5.2030002@yahoo.com.au> <20040406083713.GB7362@in.ibm.com> <407277AE.2050403@yahoo.com.au> <1081310073.5922.86.camel@bach>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1081310073.5922.86.camel@bach>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 07, 2004 at 01:54:34PM +1000, Rusty Russell wrote:
> No, it really is required.
> 
> The stop_machine thread runs on the cpu, then kicks everyone else off,
> then does a complete() (in stop_machine.c:do_stop()).  Without this
> check, the complete() drags the sleeping process (which called
> stop_machine) onto the dying CPU.

Precisely. That's why I ended up adding this in cpu_down!!


+	/* Ensure that we are not runnable on dying cpu */
+	old_allowed = current->cpus_allowed;
+	tmp = CPU_MASK_ALL;
+	cpu_clear(cpu, tmp);
+	set_cpus_allowed(current, tmp);

I restore the mask though (under covers of lock_cpu_hotplug) before
returning from cpu_down. Task should never see this violated affinity.

Rusty,
	What do you think abt the whole patch? It has withstood 
my stress-test harness :-)


-- 


Thanks and Regards,
Srivatsa Vaddagiri,
Linux Technology Center,
IBM Software Labs,
Bangalore, INDIA - 560017
