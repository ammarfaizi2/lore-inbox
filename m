Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261556AbVASERT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261556AbVASERT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 23:17:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261557AbVASERT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 23:17:19 -0500
Received: from mail-in-07.arcor-online.net ([151.189.21.47]:25324 "EHLO
	mail-in-07.arcor-online.net") by vger.kernel.org with ESMTP
	id S261556AbVASERA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 23:17:00 -0500
Date: Wed, 19 Jan 2005 07:18:23 +0100 (CET)
From: Bodo Eggert <7eggert@gmx.de>
To: Edjard Souza Mota <edjard@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Ilias Biris <xyz.biris@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: User space out of memory approach
In-Reply-To: <4d6522b905011805154bf27b52@mail.gmail.com>
Message-ID: <Pine.LNX.4.58.0501190629490.5090@be1.lrz>
References: <fa.lcmt90h.1j1scpn@ifi.uio.no> <fa.ht4gei4.1g5odia@ifi.uio.no>
  <E1CqDGM-0000wi-00@be1.7eggert.dyndns.org> <4d6522b905011805154bf27b52@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Jan 2005, Edjard Souza Mota wrote:

> > If my system needs the OOM killer, it's usurally unresponsive to most
> > userspace applications. A normal daemon would be swapped out before the
> > runaway dhcpd grows larger than the web cache. It would have to be a mlocked
> > RT task started from early userspace. It would be difficult to set up (unless
> > you upgrade your distro), and almost nobody will feel like tweaking it to
> > take the benefit (OOM == -ECANNOTHAPPEN).
> 
> Please correct me if I got it wrong: as deamon in this case is not a normal one,
> since it never gets rate for its own safety,

That's it's own task, it must make sure not to commit suicide. I forgot
about that.

> then it needs an RT lock whenever
> system boots.

It may not be blocked by a random RT task iff the RT task is supposed to
be OOM-killed. Therefore it *MUST* run at the highest priority and be
locked into the RAM.

It *SHOULD* be run at boot time, too, just in case it's needed early.

> > What about creating a linked list of (stackable) algorhithms which can be
> > extended by loading modules and resorted using {proc,sys}fs? It will avoid
> > the extra process, the extra CPU time (and task switches) to frequently
> > update the list and I think it will decrease the typical amount of used
> > memory, too.
> 
> Wouldn't this bring the (set of ) ranking algorithm(s) back to the kernel? This
> is exactly what we're trying to avoid.

You're trying to avoid it in order to let admins try other ranking
algorhithms (at least that's what I read). The module approach seems to be
flexible enough to do that, and it avoids the mentioned issues. If you
really want a userspace daemon, it can be controled by a module.-)

I 'm thinking of something like that:

[X] support stacking of OOM killer ranking algorhythms
[X] Task blessing OOM filter
[X] Userspace OOM ranking daemon
[X] Default OOM killer ranking

-vs-

[ ] support stacking of OOM killer ranking algorhythms
( ) Userspace OOM ranking daemon
(o) Default OOM killer ranking

-- 
Exceptions prove the rule, and destroy the battle plan. 
