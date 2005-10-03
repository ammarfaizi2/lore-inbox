Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932125AbVJCCIj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932125AbVJCCIj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Oct 2005 22:08:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932126AbVJCCIj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Oct 2005 22:08:39 -0400
Received: from zproxy.gmail.com ([64.233.162.199]:10357 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932125AbVJCCIi convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Oct 2005 22:08:38 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=dcb/Pxc4Ydsrr73Tn/vzx66RyFikhETOu0qxsqwm0XYZzkvvI4IjWYEJ9orufs7RLoLff7Ks0Ti/+97Zi4aA0wOVnpKX1sVgNMygLxvZLlD4M8b/o1z+zQdCEyATvnkzQ9UqbTM1bPeqDupJuf9VURZ844Xm1HyIyMk8I7i7B2M=
Message-ID: <aec7e5c30510021908la86daf9je0584fb0107f833a@mail.gmail.com>
Date: Mon, 3 Oct 2005 11:08:37 +0900
From: Magnus Damm <magnus.damm@gmail.com>
Reply-To: Magnus Damm <magnus.damm@gmail.com>
To: Dave Hansen <haveblue@us.ibm.com>
Subject: Re: [PATCH 00/07][RFC] i386: NUMA emulation
Cc: Magnus Damm <magnus@valinux.co.jp>, linux-mm <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1128093825.6145.26.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050930073232.10631.63786.sendpatchset@cherry.local>
	 <1128093825.6145.26.camel@localhost>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/1/05, Dave Hansen <haveblue@us.ibm.com> wrote:
> On Fri, 2005-09-30 at 16:33 +0900, Magnus Damm wrote:
> > These patches implement NUMA memory node emulation for regular i386 PC:s.
> >
> > NUMA emulation could be used to provide coarse-grained memory resource control
> > using CPUSETS. Another use is as a test environment for NUMA memory code or
> > CPUSETS using an i386 emulator such as QEMU.
>
> This patch set basically allows the "NUMA depends on SMP" dependency to
> be removed.  I'm not sure this is the right approach.  There will likely
> never be a real-world NUMA system without SMP.  So, this set would seem
> to include some increased (#ifdef) complexity for supporting SMP && !
> NUMA, which will likely never happen in the real world.

Yes, this patch set removes "NUMA depends on SMP". It also adds some
simple NUMA emulation code too, but I am sure you are aware of that!
=)

I agree that it is very unlikely to find a single-processor NUMA
system in the real world. So yes, "[PATCH 02/07] i386: numa on
non-smp" adds _some_ extra complexity. But because SMP is set when
supporting more than one cpu, and NUMA is set when supporting more
than one memory node, I see no reason why they should be dependent on
each other. Except that they depend on each other today and breaking
them loose will increase complexity a bit.

> Also, I worry that simply #ifdef'ing things out like CPUsets' update
> means that CPUsets lacks some kind of abstraction that it should have
> been using in the first place.  An #ifdef just papers over the real
> problem.

Maybe. CPUSETS has two bitmaps, one for cpus and one for mems. So
depending on SMP or NUMA seems logical to me. Regarding the #ifdef, it
was added because partition_sched_domain() is only implemented for
SMP. That symbol has no prototype or implementation when CONFIG_SMP is
not set. Maybe it is better to add an empty inline function in
linux/sched.h for !SMP?

> I think it would likely be cleaner if the approach was to emulate an SMP
> NUMA system where each NUMA node simply doesn't have all of its CPUs
> online.

Absolutely. And that removes the need for some of my patches. QEMU
runs SMP kernels. It is possible to run SMP kernels on UP hardware.
But there is of course a certain performance loss introduced by all
the SMP locks. I'd rather not force !SMP users to run SMP kernels if
they want coarse-grained memory resource control.

Thanks for your input!

/ magnus
