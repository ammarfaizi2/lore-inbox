Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965004AbVHYOF5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965004AbVHYOF5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 10:05:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965003AbVHYOF5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 10:05:57 -0400
Received: from rwcrmhc11.comcast.net ([216.148.227.117]:32141 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S964983AbVHYOF5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 10:05:57 -0400
From: kernel-stuff@comcast.net (Parag Warudkar)
To: Andi Kleen <ak@suse.de>, Ray Fucillo <fucillo@intersystems.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: process creation time increases linearly with shmem
Date: Thu, 25 Aug 2005 14:05:54 +0000
Message-Id: <082520051405.5272.430DD0420003F49F00001498220076139400009A9B9CD3040A029D0A05@comcast.net>
X-Mailer: AT&T Message Center Version 1 (Dec 17 2004)
X-Authenticated-Sender: a2VybmVsLXN0dWZmQGNvbWNhc3QubmV0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Ray Fucillo <fucillo@intersystems.com> writes:
> > 
> > The application is a database system called Caché.  We allocate a
> > large shared memory segment for database cache, which in a large
> > production environment may realistically be 1+GB on 32-bit platforms
> > and much larger on 64-bit.  At these sizes fork() is taking hundreds
> > of miliseconds, which can become a noticeable bottleneck for us.  This
> > performance characteristic seems to be unique to Linux vs other Unix
> > implementations.
> 
> You could set up hugetlbfs and use large pages for the SHM (with SHM_HUGETLB);
> then the overhead of walking the pages of it at fork would be much lower.
> 
> -Andi
> -

Why isn't the page walk for the Shared Memory done lazily though? It is better in that applications most likely may not want to page in all of the shared memory at once. Program logic/requirements should dictate this instead of fork making it compulsory. I think this is because we don't distinguish between shared libraries, program text and explicitly shared memory as the above application does - everything is MAP_SHARED.

As someone mentioned this causes unavoidable faults for reading in shared libraries and program text. But if there was a MAP_SHARED|MAP_LAZY - can fork() then be setup not to setup page tables for such mappings and still continue to map the MAP_SHARED ones so program text and libraries don't cause faults? Applications can then specify MAP_SHARED|MAP_LAZY and not incur the overhead of page table walk for the shared memory all at once.

Would it be worth trying to do something like this?

Parag



