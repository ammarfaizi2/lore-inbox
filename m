Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750994AbWBJL2e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750994AbWBJL2e (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 06:28:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750995AbWBJL2e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 06:28:34 -0500
Received: from smtp.osdl.org ([65.172.181.4]:63616 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750993AbWBJL2d convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 06:28:33 -0500
Date: Fri, 10 Feb 2006 03:23:32 -0800
From: Andrew Morton <akpm@osdl.org>
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: ak@muc.de, ashok.raj@intel.com, ntl@pobox.com, riel@redhat.com,
       linux-kernel@vger.kernel.org, torvalds@osdl.org, mingo@elte.hu,
       76306.1226@compuserve.com, wli@holomorphy.com,
       heiko.carstens@de.ibm.com, pj@sgi.com
Subject: Re: [PATCH] percpu data: only iterate over possible CPUs
Message-Id: <20060210032332.13ed3b67.akpm@osdl.org>
In-Reply-To: <43EC7473.20109@cosmosbay.com>
References: <20060209160808.GL18730@localhost.localdomain>
	<20060209090321.A9380@unix-os.sc.intel.com>
	<20060209100429.03f0b1c3.akpm@osdl.org>
	<200602101102.25437.ak@muc.de>
	<20060210024222.67db06f3.akpm@osdl.org>
	<43EC7473.20109@cosmosbay.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Dumazet <dada1@cosmosbay.com> wrote:
>
> Andrew Morton a écrit :
> > Andi Kleen <ak@muc.de> wrote:
> >> On Thursday 09 February 2006 19:04, Andrew Morton wrote:
> >>> Ashok Raj <ashok.raj@intel.com> wrote:
> >>>> The problem was with ACPI just simply looking at the namespace doesnt
> >>>>  exactly give us an idea of how many processors are possible in this platform.
> >>> We need to fix this asap - the performance penalty for HOTPLUG_CPU=y,
> >>> NR_CPUS=lots will be appreciable.
> >> What is this performance penalty exactly? 
> > 
> > All those for_each_cpu() loops will hit NR_CPUS cachelines instead of
> > hweight(cpu_possible_map) cachelines.
> 
> You mean NR_CPUS bits, mostly all included in a single cacheline, and even in 
> a single long word :) for most cases (NR_CPUS <= 32 or 64)
> 

No, I mean cachelines:

static void recalc_bh_state(void)
{
	int i;
	int tot = 0;

	if (__get_cpu_var(bh_accounting).ratelimit++ < 4096)
		return;
	__get_cpu_var(bh_accounting).ratelimit = 0;
	for_each_cpu(i)
		tot += per_cpu(bh_accounting, i).nr;

That's going to hit NR_CPUS cachelines even on a 2-way.

Or am I missing something really obvious here?

(Probably the most expensive ones will be get_page_state() and friends. 
And argh, they're still hardwired to CPU_MASK_ALL).

