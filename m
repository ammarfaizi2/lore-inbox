Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030219AbWGZVet@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030219AbWGZVet (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 17:34:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030291AbWGZVet
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 17:34:49 -0400
Received: from smtp.osdl.org ([65.172.181.4]:46303 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030219AbWGZVer (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 17:34:47 -0400
Date: Wed, 26 Jul 2006 14:33:57 -0700
From: Andrew Morton <akpm@osdl.org>
To: Arjan van de Ven <arjan@linux.intel.com>
Cc: vatsa@in.ibm.com, torvalds@osdl.org, davej@redhat.com, mingo@elte.hu,
       76306.1226@compuserve.com, ashok.raj@intel.com,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] Reorganize the cpufreq cpu hotplug locking to not be
 totally bizare
Message-Id: <20060726143357.2f0787e7.akpm@osdl.org>
In-Reply-To: <1153947786.3381.58.camel@laptopd505.fenrus.org>
References: <200607242023_MC3-1-C5FE-CADB@compuserve.com>
	<Pine.LNX.4.64.0607241752290.29649@g5.osdl.org>
	<20060725185449.GA8074@elte.hu>
	<1153855844.8932.56.camel@laptopd505.fenrus.org>
	<Pine.LNX.4.64.0607251355080.29649@g5.osdl.org>
	<1153921207.3381.21.camel@laptopd505.fenrus.org>
	<20060726155114.GA28945@redhat.com>
	<Pine.LNX.4.64.0607261007530.29649@g5.osdl.org>
	<1153942954.3381.50.camel@laptopd505.fenrus.org>
	<20060726204233.GA23488@in.ibm.com>
	<1153947786.3381.58.camel@laptopd505.fenrus.org>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Jul 2006 23:03:06 +0200
Arjan van de Ven <arjan@linux.intel.com> wrote:

> I'm really starting to feel that the hotplug lock would have been better
> of being a refcount (with a waitqueue for zero) than a lock. While
> "refcount+waitqueue" sort of IS a lock, the semantics make more sense
> imo...

The mistake in the above paragraph is its use of the term "the hotplug
lock".

Think.  We don't want to lock CPUs.  We don't want to block plug/unplug
events.

What we _do_ want is for subsystems to be able to guarantee the stability
of their per-cpu data and the coherency of that data with cpu_online_map
and cpu_present_map.

We should delete lock_cpu_hotplug() and start again.  Perhaps we can do
that post-2.6.18 if we can cobble the current stuff into some semi-working
state.  But I doubt if it's very important really - we have heaps of code
in there which is already racy wrt hotplug and adding a little more isn't
likely to hurt.

I count 187 instances of for_each_online_cpu(), and most of them are racy. 
There's just no way we can fix all these with lock_cpu_hotplug().  It
simply doesn't have a future.
