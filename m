Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270354AbTHBVnu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Aug 2003 17:43:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270365AbTHBVnu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Aug 2003 17:43:50 -0400
Received: from fw.osdl.org ([65.172.181.6]:10378 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S270354AbTHBVnt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Aug 2003 17:43:49 -0400
Date: Sat, 2 Aug 2003 14:44:22 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Scott L. Burson" <gyro@zeta-soft.com>
Cc: linux-kernel@vger.kernel.org, Mathieu.Malaterre@creatis.insa-lyon.fr
Subject: Re: SMP performance problem in 2.4 (was: Athlon spinlock
 performance)
Message-Id: <20030802144422.111d6893.akpm@osdl.org>
In-Reply-To: <16171.31418.271319.316382@kali.zeta-soft.com>
References: <16171.31418.271319.316382@kali.zeta-soft.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Scott L. Burson" <gyro@zeta-soft.com> wrote:
>
> The problem is in `try_to_free_pages' and its associated routines,

This is not unusual.

> In one approximately 60-second period with the problematic workload running, 

What is the problematic workload?  Please describe it in great detail.

> Clearly the kernel group has been aware of the problems with `shrink_cache',
> as I see that it has received quite a bit of attention in the course of 2.5
> development.  I am hopeful that the problem will be substantially
> ameliorated in 2.6.0.  (The comment at the top of `try_to_free_pages' --
> "This is a fairly lame algorithm - it can result in excessive CPU burning"
> -- suggests it won't be cured entirely.)

That comment has thus far proved to be wrong.

> However, it seems the kernel group may not have been aware of just how bad
> the problem can be in recent 2.4 kernels on dual-processor machines with
> lots of memory.  It's bad enough that running two `find' jobs at the same
> time on large filesystems can bring the machine pretty much to its knees.

oh, is that the workload?

Send a copy of /proc/meminfo, captured when the badness is happening.  Also
/proc/slabinfo.

Probably you will find that all of the low memory is consumed by inodes and
dentries.  ext2 is particularly prone to this because its directory pages
are placed in highmem, and those pages can pin down the dentries (and hence
the inodes).  

So sigh.  It is a problem which has been solved for a year at least.  Try
running one of Andrea's kernels, from

ftp://ftp.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4

The most important patch for you is 10_inode-highmem-2.


