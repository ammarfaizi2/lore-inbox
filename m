Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422791AbWBIDGH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422791AbWBIDGH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 22:06:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422792AbWBIDGH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 22:06:07 -0500
Received: from smtp.osdl.org ([65.172.181.4]:50887 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422791AbWBIDGG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 22:06:06 -0500
Date: Wed, 8 Feb 2006 19:05:12 -0800
From: Andrew Morton <akpm@osdl.org>
To: Rik van Riel <riel@redhat.com>
Cc: linux-kernel@vger.kernel.org, dada1@cosmosbay.com,
       Linus Torvalds <torvalds@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Andi Kleen <ak@muc.de>, Chuck Ebbert <76306.1226@compuserve.com>,
       Eric Dumazet <dada1@cosmosbay.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH] percpu data: only iterate over possible CPUs
Message-Id: <20060208190512.5ebcdfbe.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.63.0602081728590.31711@cuia.boston.redhat.com>
References: <200602051959.k15JxoHK001630@hera.kernel.org>
	<Pine.LNX.4.63.0602081728590.31711@cuia.boston.redhat.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel <riel@redhat.com> wrote:
>
> On Sun, 5 Feb 2006, Linux Kernel Mailing List wrote:
> 
>  > [PATCH] percpu data: only iterate over possible CPUs
> 
>  This sched.c bit breaks Xen, and probably also other architectures
>  that have CPU hotplug.  I suspect the reason is that during early 
>  bootup only the boot CPU is online, so nothing initialises the
>  runqueues for CPUs that are brought up afterwards.
> 
>  I suspect we can get rid of this problem quite easily by moving
>  runqueue initialisation to init_idle()...

We've hit this snag with a few architectures.  They're setting up
cpu_possible_map too late.  It's never been clearly defined.

sched_init() is called here:

asmlinkage void __init start_kernel(void)
{
	...
	printk(linux_banner);
	setup_arch(&command_line);
	setup_per_cpu_areas();
	smp_prepare_boot_cpu();
	sched_init();

Users of __GENERIC_PER_CPU definitely need cpu_possible_map to be initialised
by the time setup_per_cpu_areas() is called, so I think it makes sense to
say "thou shalt initialise cpu_possible_map in setup_arch()".

I guess Xen isn't doing that.  Can it be made to?
