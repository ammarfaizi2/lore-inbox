Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932068AbVKXSYv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932068AbVKXSYv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 13:24:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932407AbVKXSYv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 13:24:51 -0500
Received: from science.horizon.com ([192.35.100.1]:11320 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S932068AbVKXSYv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 13:24:51 -0500
Date: 24 Nov 2005 13:24:50 -0500
Message-ID: <20051124182450.3921.qmail@science.horizon.com>
From: colin@horizon.com
To: ak@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [patch] SMP alternatives
Cc: linux@horizon.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> For user space the primary trigger event would be "has any shared
> writable mappings or multiple threads". Even on a real MP systems it's 
> perfectly ok to run a program with no writable shared mappings with LOCK off.
                       ^ single-threaded

> Depending on the workload this transistion could happen quite often.
> Especially there is a worst case of an application allocating a few
> GB of memory and then starting a new thread.

One more thing, that may be to cute to be practical, but is worth mentioning:
shared address space or shared mappings only require LOCK if the memory
is ACTIVELY shared, i.e. used by DMA or by another task that is running
right now.

If you have a process with a helper thread that's asleep 99% of the time,
the savings of running with LOCK off might be worth the occasional
IPI to enable it on the main thread on the rare occasions that the
helper wakes up on a different processor.

For example, imagine a threaded async DNS resolver that tracks
TTL and times out cache entries.

If you have heavier-weight mutual exclusion, you don't need LOCK.
