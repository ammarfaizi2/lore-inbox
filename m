Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265334AbUBFDHL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 22:07:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265337AbUBFDHL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 22:07:11 -0500
Received: from fw.osdl.org ([65.172.181.6]:17852 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265334AbUBFDHJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 22:07:09 -0500
Date: Thu, 5 Feb 2004 19:09:04 -0800
From: Andrew Morton <akpm@osdl.org>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, kenneth.w.chen@intel.com
Subject: Re: Limit hash table size
Message-Id: <20040205190904.0cacd513.akpm@osdl.org>
In-Reply-To: <p73isilkm4x.fsf@verdi.suse.de>
References: <B05667366EE6204181EABE9C1B1C0EB5802441@scsmsx401.sc.intel.com.suse.lists.linux.kernel>
	<20040205155813.726041bd.akpm@osdl.org.suse.lists.linux.kernel>
	<p73isilkm4x.fsf@verdi.suse.de>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> wrote:
>
> Andrew Morton <akpm@osdl.org> writes:
> 
> > Ken, I remain unhappy with this patch.  If a big box has 500 million
> > dentries or inodes in cache (is possible), those hash chains will be more
> > than 200 entries long on average.  It will be very slow.
> 
> How about limiting the global size of the dcache in this case ? 

But to what size?

The thing is, any workload which touches a huge number of dentries/inodes
will, if it touches them again, touch them again in exactly the same order.
This triggers the worst-case LRU behaviour.

So if you limit dcache to 100MB and you happen to have a workload which
touches 101MB's worth, you get a 100% miss rate.  You suffer a 100000%
slowdown on the second pass, which is unhappy.  It doesn't seem worth
crippling such workloads just because of the updatedb thing.

> I cannot imagine a workload where it would make sense to ever cache 
> 500 million dentries. It just risks to keep the whole file system
> after an updatedb in memory on a big box, which is not necessarily
> good use of the memory.

A decent approach to the updatedb problem is an application hint which says
"reclaim i/dcache harder".  Just turn it on during the updatedb run -
crude, but it's a start.

But I've been telling poeple for a year that they should set
/proc/sys/vm/swappiness to zero during the updatedb run and afaik nobody has
bothered to try it...

