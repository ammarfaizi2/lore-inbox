Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422793AbWBIEqE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422793AbWBIEqE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 23:46:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422795AbWBIEqD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 23:46:03 -0500
Received: from smtp.osdl.org ([65.172.181.4]:53210 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422793AbWBIEqB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 23:46:01 -0500
Date: Wed, 8 Feb 2006 20:45:02 -0800
From: Andrew Morton <akpm@osdl.org>
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: riel@redhat.com, linux-kernel@vger.kernel.org, torvalds@osdl.org,
       mingo@elte.hu, ak@muc.de, 76306.1226@compuserve.com, wli@holomorphy.com,
       heiko.carstens@de.ibm.com, Paul Jackson <pj@sgi.com>
Subject: Re: [PATCH] percpu data: only iterate over possible CPUs
Message-Id: <20060208204502.12513ae5.akpm@osdl.org>
In-Reply-To: <43EAC6BE.2060807@cosmosbay.com>
References: <200602051959.k15JxoHK001630@hera.kernel.org>
	<Pine.LNX.4.63.0602081728590.31711@cuia.boston.redhat.com>
	<20060208190512.5ebcdfbe.akpm@osdl.org>
	<20060208190839.63c57a96.akpm@osdl.org>
	<43EAC6BE.2060807@cosmosbay.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Dumazet <dada1@cosmosbay.com> wrote:
>
> Andrew Morton a écrit :
> > Andrew Morton <akpm@osdl.org> wrote:
> >> Users of __GENERIC_PER_CPU definitely need cpu_possible_map to be initialised
> >>  by the time setup_per_cpu_areas() is called,
> > 
> > err, they'll need it once Eric's
> > dont-waste-percpu-memory-on-not-possible-CPUs patch is merged..
> > 
> >> so I think it makes sense to
> >>  say "thou shalt initialise cpu_possible_map in setup_arch()".
> >>
> >>  I guess Xen isn't doing that.  Can it be made to?
> > 
> > Lame fix:  cpu_possible_map = (1<<NR_CPUS)-1 in setup_arch().
> 
> I dont understand why this HOTPLUG stuff is problematic for Xen (or other 
> arch) : If CONFIG_HOTPLUG_CPU is configured, then the map should be preset to 
> CPU_MASK_ALL.

Presumably not all architectures are doing that.   And some of the problems
we've had are with CONFIG_HOTPLUG_CPU=n.

> Its even documented in line 332 of include/linux/cpumask.h
> 
>   *  #ifdef CONFIG_HOTPLUG_CPU
>   *     cpu_possible_map - all NR_CPUS bits set

That seems a quite bad idea.  If we know which CPUs are possible we should
populate cpu_possible_map correctly, whether or not CONFIG_HOTPLUG_CPU is
set.  Setting all the bits like that wastes memory and wastes CPU cycles.

<greps>

That comment came from the tender pinkies of pj@sgi.com, although I suspect
it was just a transliteration of then-current practice.

