Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283655AbRLJBHF>; Sun, 9 Dec 2001 20:07:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286131AbRLJBGz>; Sun, 9 Dec 2001 20:06:55 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:19972 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S286130AbRLJBGp>; Sun, 9 Dec 2001 20:06:45 -0500
Subject: Re: [RFC] Scheduler queue implementation ...
To: davidel@xmailserver.org (Davide Libenzi)
Date: Mon, 10 Dec 2001 01:16:07 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org (lkml),
        torvalds@transmeta.com (Linus Torvalds)
In-Reply-To: <Pine.LNX.4.40.0112091647360.996-100000@blue1.dev.mcafeelabs.com> from "Davide Libenzi" at Dec 09, 2001 04:57:29 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16DF39-00008w-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Alan, you're mixing switch mm costs with cache image reload ones.
> Note that equal mm does not mean matching cache image, at all.

They are often close to the same thing. Take a look at the constraints
on virtually cached processors like the ARM where they _are_ the same thing.

Equal mm for cpu sucking tasks often means equal cache image. On the other
hand unmatched mm pretty much definitively says "doesnt matter". The cost
of getting the equal mm/shared cache case wrong is too horrific to handwave
it out of existance using academic papers.

> By having only two queues maintain the implementation simple and solves
> 99% of common/extraordinary cases.
> The cost of a tlb flush become "meaningful" for I/O bound tasks where
> their short average run time is not sufficent to compensate the tlb flush
> cost, and this is handled correctly/like-usual inside the I/O bound queue.

You don't seem to solve either problem directly.

Without per cpu queues you spend all your time bouncing stuff between
processors which hurts. Without multiple queues for interactive tasks you
walk the interactive task list so you don't scale. Without some sensible 
handling of mm/cpu binding you spend all day wasting ram bandwidth with
cache writeback.

The single cpu sucker queue is easy, the cost of merging mm equivalent tasks
in that queue is almost nil. Priority ordering interactive stuff using 
several queues is easy and very cheap if you need it (I think you do hence
I have 7 priority bands and you have 1). In all these cases the hard bits
end up being

On a wake up which cpu do you give a task ?
When does an idle cpu steal a task, who from and which task ?
How do I define "imbalance" for cpu load balancing ?

