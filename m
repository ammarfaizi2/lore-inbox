Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278205AbRJRX3P>; Thu, 18 Oct 2001 19:29:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278206AbRJRX24>; Thu, 18 Oct 2001 19:28:56 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:61708 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S278203AbRJRX2k>; Thu, 18 Oct 2001 19:28:40 -0400
Date: Fri, 19 Oct 2001 01:27:21 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: bill davidsen <davidsen@tmr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: VM test on 2.4.13-pre3aa1 (compared to 2.4.12-aa1 and 2.4.13-pre2aa1)
Message-ID: <20011019012720.U12055@athlon.random>
In-Reply-To: <20011017040907.A2380@athlon.random> <200110181936.f9IJaLF06832@deathstar.prodigy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <200110181936.f9IJaLF06832@deathstar.prodigy.com>; from davidsen@tmr.com on Thu, Oct 18, 2001 at 03:36:21PM -0400
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 18, 2001 at 03:36:21PM -0400, bill davidsen wrote:
> In article <20011017040907.A2380@athlon.random> andrea@suse.de wrote:
> >On Wed, Oct 17, 2001 at 09:32:12AM +0800, Beau Kuiper wrote:
> 
> >> Swapping too much probably has a lot to do with a particular hard drive
> >> and its performace. Is there any way of adding a configurable option (via
> >> sysctl) to allow the adminstrators to tune how aggressively the kernel
> >> swaps out data/vs throwing out the disk cache (so if it is set to
> >> agressive, the kernel will try hard to make sure to use swap to free up
> >> memory, or if it is set to conservative it will try to free disk cache (to
> >> a limit) instead of swapping stuff out to free memory)
> >
> >I could add a sysctl to control that. In short the change consists of
> >making the DEF_PRIORITY in mm/vmscan.c a variable rather than a
> >preprocessor #define. That's the "ratio" number I was talking about in
> >the last email to Rik, and if you read ac/mm/vmscan.c you'll find it
> >there too indeed.
> 
> I think that would give people a sense of control.

ok, I added three sysctl:

andrea@laser:/misc/andrea-athlon > ls /proc/sys/vm/vm_*             
/proc/sys/vm/vm_balance_ratio  /proc/sys/vm/vm_mapped_ratio /proc/sys/vm/vm_scan_ratio
andrea@laser:/misc/andrea-athlon > 

with some commentary in the sourcecode:

/*
 * The "vm_scan_ratio" is how much of the queues we will scan
 * in one go. A value of 6 for vm_scan_ratio implies that we'll
 * scan 1/6 of the inactive list during a normal aging round.
 */
int vm_scan_ratio = 8;

/*
 * The "vm_mapped_ratio" controls when to start early-paging, we probe
 * the inactive list during shrink_cache() and if there are too many
 * mapped unfreeable pages we have an indication that we'd better
 * start paging. The bigger vm_mapped_ratio is, the eaerlier the
 * machine will run into swapping activities.
 */
int vm_mapped_ratio = 32;

/*
 * The "vm_balance_ratio" controls the balance between active and
 * inactive cache. The bigger vm_balance_ratio is, the easier the
 * active cache will grow, because we'll rotate the active list
 * slowly. A value of 4 means we'll go towards a balance of
 * 1/5 of the cache being inactive.
 */
int vm_balance_ratio = 16;

I'm still testing though, so it's not guaranteed that the above will
remain the same :).

>   If it can work well in common cases for average users, and still allow
> tuning by people who have special needs, I'm all for it. I'm sure you
> understand the problems with self-tuning VM as well as anyone, I just
> want to suggest that for uncommon situations you provide a way for
> knowledgable users to handle special situations which need info not
> available to the VM otherwise.

ok. Another argument is that by making those sysctl tunable people can
test and report the best numbers for them in their workloads.
Those would be fixed numbers anyways, they're magics, they're not
perfect, they tend to do the right thing, and changing them slightly
isn't going to make a big difference if the machine has enough ram for
doing its work.

Andrea
