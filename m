Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291148AbSCDDVA>; Sun, 3 Mar 2002 22:21:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291162AbSCDDUu>; Sun, 3 Mar 2002 22:20:50 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:56081 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S291148AbSCDDUh>; Sun, 3 Mar 2002 22:20:37 -0500
Subject: Re: [RFC] Arch option to touch newly allocated pages
To: jdike@karaya.com (Jeff Dike)
Date: Mon, 4 Mar 2002 03:35:14 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <200203040316.WAA04739@ccure.karaya.com> from "Jeff Dike" at Mar 03, 2002 10:16:40 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16hjFq-0006OQ-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Does address space accounting enforce tmpfs limits (and other limits, like
> RSS, when it happens)?  Or is it enforcing a global limit?

It ensures that the total number of anonymous and/or tmpfs (eg anon shared)
pages that are mappable will fit in swap (or in mode 2 swap + 0.5*ram). You
never get a SIGBUS. Writes to tmpfs for new blocks will fail if that would
place the system in a potential overcommit situation.

> > Nothing of the sort. Sitting in a gnome desktop I'm showing a 41200Kb
> > worst case swap requirement, but it appears under half of that is
> > used. 
> 
> This I don't get.  I'm assuming that the vast majority of the time when a
> set of pages is returned by __alloc_pages, they all are going to be written
> pretty soon.  This being the case, how can it possibly affect anything to
> touch them at the end of __alloc_pages?

It isnt the alloc pages that is the problem.

You mmap - no pages are allocated. You use them , pages get allocated. If
you look at the actual maps you'll find a lot of people allocate an area
of address space but don't use it all. Without the address overcommit
management nothing guarantees that when you touch those pages you won't
fault. Furthermore unless you are very careful you may fault again on
the stack push for the SIGBUS and if that faults - SIGKILL->OOM time


Alan
