Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262876AbSKTWPs>; Wed, 20 Nov 2002 17:15:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262877AbSKTWPr>; Wed, 20 Nov 2002 17:15:47 -0500
Received: from holomorphy.com ([66.224.33.161]:59371 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S262876AbSKTWPT>;
	Wed, 20 Nov 2002 17:15:19 -0500
Date: Wed, 20 Nov 2002 14:19:20 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Robert Love <rml@tech9.net>,
       riel@surriel.com, Andrew Morton <akpm@zip.com.au>
Subject: Re: unusual scheduling performance
Message-ID: <20021120221920.GC11776@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
	Robert Love <rml@tech9.net>, riel@surriel.com,
	Andrew Morton <akpm@zip.com.au>
References: <20021118081854.GJ23425@holomorphy.com> <Pine.LNX.4.44.0211201504480.2559-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0211201504480.2559-100000@localhost.localdomain>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Nov 2002, William Lee Irwin III wrote:
>> On 16x, 2.5.47 kernel compiles take about 26s when the machine is
>> otherwise idle.
>> On 32x, 2.5.47 kernel compiles take about 48s when the machine is
>> otherwise idle.

On Wed, Nov 20, 2002 at 03:12:57PM +0100, Ingo Molnar wrote:
> one thing to note is that the kernel's compilation is not something that
> parallelizes well to above 8 CPUs. Our make architecture creates many link
> points which serialize 'threads of compilation'.

Well, I was only -j64. Thats 2 processes per-cpu... something unusual
seems to happen with low process/cpu density. Some fiddling around with
prior kernels seemed to show that both -j64 and -j256 were previously
near-equivalent sweet spots for 32x.


On Wed, Nov 20, 2002 at 03:12:57PM +0100, Ingo Molnar wrote:
> i'd try two things:
>  1) try Erich Focht's NUMA enhancements to the load balancer.
>  2) remove the -pipe flag from arch/i386/Makefile
> the later thing will reduce the number of processes and makes compilation
> more localized to a single CPU - which might (or might not) help NUMA
> architectures.

The unusual bit that neither of those can really address was that
eating a single cpu with something completely unrelated sped the whole
process up from 48s to 36s on 32x (this is all nicely repeatable). No
good explanations for this have surfaced yet. I'll have to get a good
way of logging what processes are chewing how much cpu and what cpus
they're running on before I can send comprehensible traces of this.

OTOH Focht's fork() and/or exec() -time load balancing should
significantly help the low process/cpu density case by creating an
opportunity for load balancing before the lifetime of short-lived
processes expires, with the added bonus of keeping things within
nodes most of the time.


Thanks,
Bill
