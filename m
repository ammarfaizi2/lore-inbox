Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263001AbUFXADQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263001AbUFXADQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 20:03:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263041AbUFXADQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 20:03:16 -0400
Received: from holomorphy.com ([207.189.100.168]:20614 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S263001AbUFXADM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 20:03:12 -0400
Date: Wed, 23 Jun 2004 17:03:08 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [oom]: [0/4] fix OOM deadlock running OAST
Message-ID: <20040624000308.GK1552@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <0406231407.HbLbJbXaHbKbWa5aJb1a4aKb0a3aKb1a0a2aMbMbYa3aLbMb3aJbWaJbXaMbLb1a342@holomorphy.com> <20040623151659.70333c6d.akpm@osdl.org> <20040623223146.GG1552@holomorphy.com> <20040623153758.40e3a865.akpm@osdl.org> <20040623230730.GJ1552@holomorphy.com> <20040623163819.013c8585.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040623163819.013c8585.akpm@osdl.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> wrote:
>> It's unclear which zones must be checked for this to be of use. In
>> general, suppose one determines all possible zones from which a given
>> allocation may be satisfied (this still assumes out_of_memory() is
>> passed a gfp_mask, and then discovers ->all_unreclaimable. It is still
>> not possible to determine whether nr_swap_pages is relevant.

On Wed, Jun 23, 2004 at 04:38:19PM -0700, Andrew Morton wrote:
> I don't think it _is_ relevant.  Wev'e scanned the crap out of all the
> eligible zones, found nothing swappable outable or otherwise reclaimable. 
> That's as good a definition of oom as you're likely to get.  It takes care
> of mlocked user memory too.

The actual net effect of all this is blowing away if (nr_swap_pages > 0)
for __GFP_WIRED allocations. Removing those 2 lines (and the one line of
whitespace next to it) will pass the test I observed failure in. It's a
judgment call as to whether it's beneficial in general, as it does
insulate userspace somewhat from needing to wait for slow IO being the
ostensible cause of the allocation failure. RedHat vendor kernels have
removed the check entirely, which may be considered to be evidence of
the approach's viability.


William Lee Irwin III <wli@holomorphy.com> wrote:
>> There are larger semantic questions also. For instance, the runs that
>> deadlocked were with non-overcommit enabled (that is, I left the sysctl
>> /proc/sys/vm/overcommit_memory == 0 after boot). The intention was to
>> provide best effort unfailability to userspace allocations by detecting
>> insufficient resources up-front and returning MAP_FAILED from mmap() and
>> so on. There is a current hole in this, which is that pinned kernel
>> memory allocations aren't subtracted from the pool of memory considered
>> to be available to userspace.

On Wed, Jun 23, 2004 at 04:38:19PM -0700, Andrew Morton wrote:
> The overcommit logic doesn't need to care about pinned kernel allocations. 
> All it cares about is reclaimable and free pages.  Its calculation of what
> is reclaimable is a bit wonky because of ramfs/sysfs/ramdisk pages and
> metadata, and because of mlock.

Hmm. That sort of thing is what I had in mind by saying "pinned kernel
allocations". What did it sound like I had in mind?


On Wed, Jun 23, 2004 at 04:38:19PM -0700, Andrew Morton wrote:
> But for this problem, I do suspect that going oom if all the eligible zones
> are pegged out should suffice.  It is certainly accurate.
> It could be that the ->all_unreclaimable logic has rotted over the ages and
> may ned some attention - I haven't explicitly checked it in a year or more.
> Also there's some problem at present wherein the oomkiller takes 30 or
> more seconds to kick in and do its thing, which I need to look at.  This
> happens when there's no swap online.  It might also happen when swapspace
> is full - I didn't check.

The timeout semantics are crusty. 10 failures 1s or more apart must be
seen, but with no delay of more than 5s between failures. If the average
delay between attempts more than 1s from the last successful attempt
that incremented the counter was 3s, that would make for a 30s delay
before OOM killing. In the presence of e.g. delays waiting for IO and
so on preventing retries from happening rapidly, 30s is plausible. Also,
it's rather likely that the tasks targeted by the OOM killer are in
state TASK_UNINTERRUPTIBLE and so will never respond to the OOM kill
until whatever they were waiting for happens, which may require (you
guessed it) memory to occur.

I would prefer to migrate away from timeout-based semantics and eliminate
indefinite retry logic and out-of-context reclamation (which is the source
of reclamation failures having no context to which to return errors).
However, this also requires some method of recovering from or insulating
administrators from indefinite retry loops originating from userspace, and
better contexts to which to return failure than syslog daemons.


-- wli
