Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262381AbUFWXfk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262381AbUFWXfk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 19:35:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262391AbUFWXfk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 19:35:40 -0400
Received: from fw.osdl.org ([65.172.181.6]:21151 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262381AbUFWXfb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 19:35:31 -0400
Date: Wed, 23 Jun 2004 16:38:19 -0700
From: Andrew Morton <akpm@osdl.org>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [oom]: [0/4] fix OOM deadlock running OAST
Message-Id: <20040623163819.013c8585.akpm@osdl.org>
In-Reply-To: <20040623230730.GJ1552@holomorphy.com>
References: <0406231407.HbLbJbXaHbKbWa5aJb1a4aKb0a3aKb1a0a2aMbMbYa3aLbMb3aJbWaJbXaMbLb1a342@holomorphy.com>
	<20040623151659.70333c6d.akpm@osdl.org>
	<20040623223146.GG1552@holomorphy.com>
	<20040623153758.40e3a865.akpm@osdl.org>
	<20040623230730.GJ1552@holomorphy.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> wrote:
>
> On Wed, Jun 23, 2004 at 03:37:58PM -0700, Andrew Morton wrote:
> > What about zone->all_unreclaimable?
> 
> It's unclear which zones must be checked for this to be of use. In
> general, suppose one determines all possible zones from which a given
> allocation may be satisfied (this still assumes out_of_memory() is
> passed a gfp_mask, and then discovers ->all_unreclaimable. It is still
> not possible to determine whether nr_swap_pages is relevant.

I don't think it _is_ relevant.  Wev'e scanned the crap out of all the
eligible zones, found nothing swappable outable or otherwise reclaimable. 
That's as good a definition of oom as you're likely to get.  It takes care
of mlocked user memory too.

> ...
> There are larger semantic questions also. For instance, the runs that
> deadlocked were with non-overcommit enabled (that is, I left the sysctl
> /proc/sys/vm/overcommit_memory == 0 after boot). The intention was to
> provide best effort unfailability to userspace allocations by detecting
> insufficient resources up-front and returning MAP_FAILED from mmap() and
> so on. There is a current hole in this, which is that pinned kernel
> memory allocations aren't subtracted from the pool of memory considered
> to be available to userspace.

The overcommit logic doesn't need to care about pinned kernel allocations. 
All it cares about is reclaimable and free pages.  Its calculation of what
is reclaimable is a bit wonky because of ramfs/sysfs/ramdisk pages and
metadata, and because of mlock.


But for this problem, I do suspect that going oom if all the eligible zones
are pegged out should suffice.  It is certainly accurate.

It could be that the ->all_unreclaimable logic has rotted over the ages and
may ned some attention - I haven't explicitly checked it in a year or more.
Also there's some problem at present wherein the oomkiller takes 30 or
more seconds to kick in and do its thing, which I need to look at.  This
happens when there's no swap online.  It might also happen when swapspace
is full - I didn't check.
