Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932440AbWE3Tnm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932440AbWE3Tnm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 15:43:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932441AbWE3Tnm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 15:43:42 -0400
Received: from sj-iport-2-in.cisco.com ([171.71.176.71]:15501 "EHLO
	sj-iport-2.cisco.com") by vger.kernel.org with ESMTP
	id S932440AbWE3Tnl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 15:43:41 -0400
X-IronPort-AV: i="4.05,190,1146466800"; 
   d="scan'208"; a="323814411:sNHT31136794"
To: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-rc5-mm1
X-Message-Flag: Warning: May contain useful information
References: <20060530022925.8a67b613.akpm@osdl.org>
From: Roland Dreier <rdreier@cisco.com>
Date: Tue, 30 May 2006 12:43:39 -0700
In-Reply-To: <20060530022925.8a67b613.akpm@osdl.org> (Andrew Morton's message of "Tue, 30 May 2006 02:29:25 -0700")
Message-ID: <adaac8z70yc.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 30 May 2006 19:43:40.0679 (UTC) FILETIME=[5A159970:01C68421]
Authentication-Results: sj-dkim-3.cisco.com; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Building 2.6.17-rc5-mm1, I get this:

	net/built-in.o: In function `ip_rt_init':
	(.init.text+0xb04): undefined reference to `__you_cannot_kmalloc_that_much'

This seems to be coming from:

	rt_hash_locks = kmalloc(sizeof(spinlock_t) * RT_HASH_LOCK_SZ, GFP_KERNEL);

I have CONFIG_NR_CPUS=32, so RT_HASH_LOCK_SZ ends up as 2048.  Also, I
have both CONFIG_DEBUG_SPINLOCK=y and CONFIG_PROVE_SPIN_LOCKING=y so
spinlock_t is bloated up quite big:

	typedef struct {
		raw_spinlock_t raw_lock;
	#if defined(CONFIG_PREEMPT) && defined(CONFIG_SMP)
		unsigned int break_lock;
	#endif
	#ifdef CONFIG_DEBUG_SPINLOCK
		unsigned int magic, owner_cpu;
		void *owner;
	#endif
	#ifdef CONFIG_PROVE_SPIN_LOCKING
		struct lockdep_map dep_map;
	#endif
	} spinlock_t;

I only have 8 CPUs in the box, so updating my config from the x86_64
defconfig fixes things for me.

No patch because I don't really know how to fix this properly...

 - R.
