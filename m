Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932142AbWBKSFH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932142AbWBKSFH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Feb 2006 13:05:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932314AbWBKSFH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Feb 2006 13:05:07 -0500
Received: from colin.muc.de ([193.149.48.1]:28421 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S932142AbWBKSFF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Feb 2006 13:05:05 -0500
Date: 11 Feb 2006 19:04:59 +0100
Date: Sat, 11 Feb 2006 19:04:59 +0100
From: Andi Kleen <ak@muc.de>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Nathan Lynch <ntl@pobox.com>, Andrew Morton <akpm@osdl.org>,
       Eric Dumazet <dada1@cosmosbay.com>, riel@redhat.com,
       linux-kernel@vger.kernel.org, torvalds@osdl.org, mingo@elte.hu,
       76306.1226@compuserve.com, wli@holomorphy.com,
       Paul Jackson <pj@sgi.com>, jbeulich@novell.com,
       Keir Fraser <Keir.Fraser@cl.cam.ac.uk>
Subject: Re: [PATCH] percpu data: only iterate over possible CPUs
Message-ID: <20060211180459.GA97137@muc.de>
References: <200602051959.k15JxoHK001630@hera.kernel.org> <20060209173726.GA39278@muc.de> <20060210100521.GA9307@osiris.boeblingen.de.ibm.com> <200602101113.13632.ak@muc.de> <20060211144929.GA4334@osiris.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060211144929.GA4334@osiris.boeblingen.de.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 11, 2006 at 03:49:29PM +0100, Heiko Carstens wrote:
> > > > x86-64 had the same problem, but we now require that you 
> > > > boot with additional_cpus=... for how many you want. Default is 0
> > > > (used to be half available CPUs but that lead to confusion)
> > > 
> > > So introducing the additional_cpus kernel parameter seems to be the way
> > > to go (for XEN probably too). Even though it seems to be a bit odd if the
> > > user specifies both maxcpus=... and additional_cpus=...
> > 
> > With additional_cpus you don't need maxcpus. They are added together.
> 
> How does x86_64 manage to get 'additional_cpus' parsed early enough? As far
> as I can see this is done when parse_args() in start_kernel() gets called,
> but that's after you need the parameter in prefill_possible_map().
> IMHO that should be an early_param and you would need to call
> parse_early_param() from setup_arch(). But then again, maybe I got it all
> wrong.

Yes, you're right - it's added too late to the map right now.
I will fix that. There are no earlyparams unfortunately, except for a 
big hack in setup.c

> But the more interesting question is: what do you do if the command line
> contains both additional_cpus and maxcpus. I was just trying to make some
> sense of this, but the result is questionable.
> I ended up with a cpu_possible_map that has 'present cpus' +
> 'additional_cpus' bits set. And in smp_prepare_cpus I make sure that
> cpu_present_map has not more than max_cpus bits set.
> 
> At least that doesn't break the current semantics of the maxcpus parameter.
> But we're still wasting memory, since it would make sense that the
> cpu_possible_map shouldn't have more than max_cpus bits set.

Yes, maybe it should be a early parameter too. But frankly I see
maxcpus more as a debugging hack or workarouno. I don't think it matters
much  if it's not as efficient as it could be.

-Andi
