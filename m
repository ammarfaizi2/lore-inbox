Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261638AbUEFGO6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261638AbUEFGO6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 02:14:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261693AbUEFGO6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 02:14:58 -0400
Received: from fw.osdl.org ([65.172.181.6]:26579 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261638AbUEFGO4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 02:14:56 -0400
Date: Wed, 5 May 2004 23:13:50 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ashok Raj <ashok.raj@intel.com>
Cc: ashok.raj@intel.com, davidm@hpl.hp.com, linux-kernel@vger.kernel.org,
       anil.s.keshavamurthy@intel.com, pj@sgi.com
Subject: Re: (resend-2) take3: Updated CPU Hotplug patches for IA64 (pj
 blessed) Patch [6/7]
Message-Id: <20040505231350.1d8a3ea6.akpm@osdl.org>
In-Reply-To: <20040505104739.A24549@unix-os.sc.intel.com>
References: <20040504211755.A13286@unix-os.sc.intel.com>
	<20040504225907.6c2fe459.akpm@osdl.org>
	<20040505104739.A24549@unix-os.sc.intel.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ashok Raj <ashok.raj@intel.com> wrote:
>
> Name: cpu_present_map.patch

Ho-hum.  Please at least compile-test non-trivial patches with
CONFIG_SMP=n, especially when they dink with bitmasks, bitmaps and
SMP-specific features.

init/main.c: In function `fixup_cpu_present_map':
init/main.c:636: warning: use of compound expressions as lvalues is deprecated
init/main.c:636: error: invalid lvalue in assignment

Due to:

			cpu_set(i, cpu_present_map);

It appears that cpu_set() is simply broken on UP:


#define	cpu_present_map			cpumask_of_cpu(0)

#define cpumask_of_cpu(cpu)		({ ((cpumask_t)1) << (cpu); })

#define cpu_set(cpu, map)		do { (void)(cpu); cpus_coerce(map) = 1UL; } while (0)

Put those things together and there's no way it can work.  It's not even
conceptually right: cpu_present_map is a "constant" on UP and we have no
business trying to modify it.  So perhaps a build error is the appropriate
response.

I'll stick a CONFIG_SMP in the caller, let the bitmap beavers worry about
the more general details.
