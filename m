Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754665AbWKIDjK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754665AbWKIDjK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 22:39:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754703AbWKIDjK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 22:39:10 -0500
Received: from mga07.intel.com ([143.182.124.22]:52106 "EHLO
	azsmga101.ch.intel.com") by vger.kernel.org with ESMTP
	id S1754665AbWKIDjJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 22:39:09 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,402,1157353200"; 
   d="scan'208"; a="143394293:sNHT24872554"
Subject: Re: 2.6.19-rc5: known regressions
From: Tim Chen <tim.c.chen@linux.intel.com>
Reply-To: tim.c.chen@linux.intel.com
To: Adrian Bunk <bunk@stusta.de>
Cc: Linus Torvalds <torvalds@osdl.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1163027494.10806.229.camel@localhost.localdomain>
References: <Pine.LNX.4.64.0611071829340.3667@g5.osdl.org>
	 <20061108085235.GT4729@stusta.de>
	 <m1y7qm425l.fsf@ebiederm.dsl.xmission.com>
	 <Pine.LNX.4.64.0611080745150.3667@g5.osdl.org>
	 <20061108162202.GA4729@stusta.de>
	 <1163027494.10806.229.camel@localhost.localdomain>
Content-Type: text/plain
Organization: Intel
Date: Wed, 08 Nov 2006 18:49:41 -0800
Message-Id: <1163040581.10806.266.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-8) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-11-08 at 15:11 -0800, Tim Chen wrote:
> On Wed, 2006-11-08 at 17:22 +0100, Adrian Bunk wrote:
> 
> > There's perhaps one thing that might help us to see whether it's just a 
> > benchmark effekt or a real problem:
> > 
> > With Tim's CONFIG_NR_CPUS=8, NR_IRQS only increases from 224 in 2.6.18 
> > to 512 in 2.6.19-rc.
> > 
> > With CONFIG_NR_CPUS=255, NR_IRQS increases from 224 in 2.6.18
> > to 8416 in 2.6.19-rc.
> > 
> > @Tim:
> > Can you try CONFIG_NR_CPUS=255 with both 2.6.18 and 2.6.19-rc5?
> > 
> 
> With CONFIG_NR_CPUS increased from 8 to 64:
> 2.6.18     see no change in fork time measured.
> 2.6.19-rc5 see a 138% increase in fork time.
> 

Lmbench is broken in its fork time measurement.
It includes overhead time when it is pinning processes onto
specific cpu. The actual fork time is not affected by NR_IRQS.

Lmbench calls the following C library function to determine the 
number of processors online before it pin the processes: 
	sysconf(_SC_NPROCESSORS_ONLN);

This function takes the same order of time to run as
fork itself.  In addition, runtime of this function 
increases with NR_IRQS.  This resulted in the change in
time measured.

After hardcoding the number of online processors in lmbench,
the fork time measured now does not change with CONFIG_NR_CPUS
for both 2.6.18 and 2.6.19-rc5.  So we can now conclude that
NR_IRQS does not affect fork.  We can remove this particular
issue from the known regression.

Tim
