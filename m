Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263309AbUD2Ee6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263309AbUD2Ee6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 00:34:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263335AbUD2Ee5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 00:34:57 -0400
Received: from fw.osdl.org ([65.172.181.6]:138 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263309AbUD2Eey (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 00:34:54 -0400
Date: Wed, 28 Apr 2004 21:33:59 -0700
From: Andrew Morton <akpm@osdl.org>
To: Marc Singer <elf@buici.com>
Cc: riel@redhat.com, brettspamacct@fastclick.com, jgarzik@pobox.com,
       linux-kernel@vger.kernel.org
Subject: Re: ~500 megs cached yet 2.6.5 goes into swap hell
Message-Id: <20040428213359.77f9dfb5.akpm@osdl.org>
In-Reply-To: <20040429041302.GA26845@buici.com>
References: <20040428180038.73a38683.akpm@osdl.org>
	<Pine.LNX.4.44.0404282143360.19633-100000@chimarrao.boston.redhat.com>
	<20040428185720.07a3da4d.akpm@osdl.org>
	<20040429022944.GA24000@buici.com>
	<20040428193541.1e2cf489.akpm@osdl.org>
	<20040429031059.GA26060@buici.com>
	<20040428201924.719dfb68.akpm@osdl.org>
	<20040429041302.GA26845@buici.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marc Singer <elf@buici.com> wrote:
>
> It could work differently from that.  For example, if we had 500M
> total, we map 200M, then we do 400M of IO.  Perhaps we'd like to be
> able to say that a 400M page cache is too big.

Try it - you'll find that the system will leave all of your 200M of mapped
memory in place.  You'll be left with 300M of pagecache from that I/O
activity.  There may be a small amount of unmapping activity if the I/O is
a write, or if the system has a small highmem zone.  Maybe.

Beware that both ARM and NFS seem to be doing odd things, so try it on a
PC+disk first ;)

>  The problem isn't
> about reclaiming pagecache it's about the cost of swapping pages back
> in.  The page cache can tend to favor swapping mapped pages over
> reclaiming it's own pages that are less likely to be used.  Of course,
> it doesn't know that...which is the rub.

No, the system will only start to unmap pages if reclaim of unmapped
pagecache is getting into difficulty.  The threshold of "getting into
difficulty" is controlled by /proc/sys/vm/swappiness.

> The requirement is that we'd like to see pages aged more gracefully.
> A mapped page that is used continuously for ten minutes and then left
> to idle for 10 minutes is more valuable than an IO page that was read
> once and then not used for ten minutes.  As the mapped page ages, it's
> value decays.

yes, remembering aging info over that period of time is hard.  We only have
six levels of aging: referenced+active, unreferenced+active,
referenced+inactive,unreferenced+inactive, plus position-on-lru*2.

> I've read the source for where swappiness comes into play.  Yet I
> cannot make a statement about what it means.  Can you?

It controls the level of page reclaim distress at which we decide to start
reclaiming mapped pages.

We prefer to reclaim pagecache, but we have to start swapping at *some*
level of reclaim failure.  swappiness sets that level, in rather vague
units.

It might make sense to recast swappiness in terms of
pages_reclaimed/pages_scanned, which is the real metric of page reclaim
distress.  But that would only affect the meaning of the actual number - it
wouldn't change the tunable's effect on the system.

