Return-Path: <linux-kernel-owner+w=401wt.eu-S932125AbXAIPEE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932125AbXAIPEE (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 10:04:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932130AbXAIPEE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 10:04:04 -0500
Received: from mtagate3.uk.ibm.com ([195.212.29.136]:63984 "EHLO
	mtagate3.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932125AbXAIPEB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 10:04:01 -0500
Date: Tue, 9 Jan 2007 16:03:51 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Srivatsa Vaddagiri <vatsa@in.ibm.com>
Cc: Benjamin Gilbert <bgilbert@cs.cmu.edu>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>, Gautham shenoy <ego@in.ibm.com>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: Failure to release lock after CPU hot-unplug canceled
Message-ID: <20070109150351.GD9563@osiris.boeblingen.de.ibm.com>
References: <20070108120719.16d4674e.bgilbert@cs.cmu.edu> <20070109121738.GC9563@osiris.boeblingen.de.ibm.com> <20070109122740.GC22080@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070109122740.GC22080@in.ibm.com>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 09, 2007 at 05:57:40PM +0530, Srivatsa Vaddagiri wrote:
> On Tue, Jan 09, 2007 at 01:17:38PM +0100, Heiko Carstens wrote:
> > missing in kernel cpu.c in _cpu_down() in case CPU_DOWN_PREPARE
> > returned with NOTIFY_BAD. However... this reveals that there is just a
> > more fundamental problem.
> >
> > The workqueue code grabs a lock on CPU_[UP|DOWN]_PREPARE and releases it
> > again on CPU_DOWN_FAILED/CPU_UP_CANCELED. If something in the callchain
> > returns NOTIFY_BAD the rest of the entries in the callchain won't be
> > called anymore. But DOWN_FAILED/UP_CANCELED will be called for every
> > entry.
> > So we might even end up with a mutex_unlock(&workqueue_mutex) even if
> > mutex_lock(&workqueue_mutex) hasn't been called...
> 
> This is a known problem. Gautham had sent out patches to address them
> 
> http://lkml.org/lkml/2006/11/14/93
> 
> Looks like they are in latest mm tree. Perhaps the testcase should be
> retried against latest mm.

Ah, nice! Wasn't aware of that. But I still think we should have a
CPU_DOWN_FAILED in case CPU_DOWN_PREPARED failed.
Also the slab cache code hasn't been changed to make use of the of the
new CPU_LOCK_[ACQUIRE|RELEASE] stuff. I'm going to send patches in reply
to this mail.
