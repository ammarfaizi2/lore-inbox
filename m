Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267656AbTBVFdD>; Sat, 22 Feb 2003 00:33:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267740AbTBVFdD>; Sat, 22 Feb 2003 00:33:03 -0500
Received: from ns.suse.de ([213.95.15.193]:50704 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S267656AbTBVFdC>;
	Sat, 22 Feb 2003 00:33:02 -0500
Date: Sat, 22 Feb 2003 06:43:07 +0100
From: Andi Kleen <ak@suse.de>
To: linux-kernel@vger.kernel.org
Cc: akpm@digeo.com, andrea@suse.de
Subject: [ak@suse.de: Re: iosched: impact of streaming read on read-many-files]
Message-ID: <20030222054307.GA22074@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry typoed the linux kernel address on the first try.

----- Forwarded message from Andi Kleen <ak@suse.de> -----

To: Andrew Morton <akpm@digeo.com>
Cc: andrea@suse.de, linux-kerel@vger.kernel.org
Subject: Re: iosched: impact of streaming read on read-many-files
From: Andi Kleen <ak@suse.de>
Date: 22 Feb 2003 06:40:41 +0100
In-Reply-To: Andrew Morton's message of "21 Feb 2003 22:21:19 +0100"

Andrew Morton <akpm@digeo.com> writes:
> 
> The correct way to design such an application is to use an RT thread to
> perform the display/audio device I/O and a non-RT thread to perform the disk
> I/O.  The disk IO thread keeps the shared 8 megabyte buffer full.  The RT
> thread mlocks that buffer.

This requires making xmms suid root. Do you really want to do that?

Also who takes care about all the security holes that would cause?

If you require applications doing such things to work around VM/scheduler
breakage you would first need to make RT and mlock available in a controlled
way to non-root applications (and no capabilities are not enough - 
linux capabilities are designed in a way that when you have one
capability you can usually get all soon). 

I thought a long time  about making some limited mlock available to 
user processes, e.g. subject to ulimit. bash seems to already have
an ulimit setting for mlock memory, but the kernel doesn't support it.
Of course it would need to be per user id, not per process, but the
kernel already keeps a per user id structure, so that won't be a big
issue. This would be useful for cryptographic applications like gpg
who don't want their secret key data to hit swap space.

Still mlock'ing 8MB in a controlled way would be still too nasty.

For RT it is more difficult. One way I can think of to make 
it available controlled is to define subgroups of threads or processes
(perhaps per user id again) and have RT properties inside these groups.
Another possible way would be to define RT with minimum CPU time, 
so e.g. that users' A processes with local rt priority could take upto
5% of the cpu time of the box or similar. Still mating that with latency
guarantees would be rather hard (such fair schedulers tend to be good
at evening out CPU time shares over a longer time, but not good at guaranteeing
short latencies after a given event). And xmms just cares about
latencies, not not long term CPU share.

But both is quite a bit of work, especially the later and may impact
other loads. Fixing the IO scheduler for them is probably easier.

-Andi 

----- End forwarded message -----
