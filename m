Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751561AbVIYXqM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751561AbVIYXqM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Sep 2005 19:46:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751560AbVIYXqM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Sep 2005 19:46:12 -0400
Received: from thorn.pobox.com ([208.210.124.75]:5292 "EHLO thorn.pobox.com")
	by vger.kernel.org with ESMTP id S1751513AbVIYXqL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Sep 2005 19:46:11 -0400
Date: Sun, 25 Sep 2005 18:46:03 -0500
From: Nathan Lynch <ntl@pobox.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Tejun Heo <htejun@gmail.com>, zwane@linuxpower.ca, viro@zeniv.linux.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH linux-2.6 04/04] brsem: convert cpucontrol to brsem
Message-ID: <20050925234603.GA3577@otto>
References: <20050925064218.E7558977@htj.dyndns.org> <20050925064218.642A9DFD@htj.dyndns.org> <4336542D.4000102@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4336542D.4000102@yahoo.com.au>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:
> Tejun Heo wrote:
> 
> >+/*
> >+ * cpucontrol is a brsem used to synchronize cpu hotplug events.
> >+ * Invoking lock_cpu_hotplug() read-locks cpucontrol and no
> >+ * hotplugging events will occur until it's released.
> >+ *
> >+ * Unfortunately, brsem itself makes use of lock_cpu_hotplug() and
> >+ * performing brsem write-lock operations on cpucontrol deadlocks.
> >+ * This is avoided by...
> >+ *
> >+ * a. guaranteeing that cpu hotplug events won't occur during the
> >+ *    write-lock operations, and
> >+ *
> >+ * b. skipping lock_cpu_hotplug() inside brsem.
> >+ *
> >+ * #a is achieved by acquiring and releasing cpucontrol_mutex outside
> >+ * cpucontrol write-lock.  #b is achieved by skipping
> >+ * lock_cpu_hotplug() inside brsem if the current task is
> >+ * cpucontrol_mutex holder (is_cpu_hotplug_holder() test).
> >+ *
> >+ * Also, note that cpucontrol is first initialized with
> >+ * BRSEM_BYPASS_INITIALIZER and then initialized again with
> >+ * __create_brsem() instead of simply using create_brsem().  This is
> >+ * necessary as cpucontrol brsem gets used way before brsem subsystem
> >+ * becomes up and running.
> >+ *
> >+ * Until brsem is properly initialized, all brsem ops succeed
> >+ * unconditionally.  cpucontrol becomes operational only after
> >+ * cpucontrol_init() is finished, which should be called after
> >+ * brsem_init_early().
> >+ */
> 
> Mmm, this is just insane IMO.
> 
> Note that I happen to also think the idea (brsems) have merit, and
> that cpucontrol may be one of the places where a sane implementation
> would actually be useful... but at least when you're introducing
> this kind of complexity anywhere, you *really* need to be able to
> back it up with numbers.

The only performance-related complaint with cpu hotplug of which I'm
aware -- that taking a cpu down on a large system can be painfully
slow -- resides in the "write side" of the code, which is not the case
that the brsem implementation optimizes.  I think this patch would
make that case even worse.  So I don't think it's appropriate to use a
brsem for cpu hotplug, especially without trying rwsem first.


Nathan
