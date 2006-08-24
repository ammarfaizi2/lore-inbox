Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751227AbWHXM6y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751227AbWHXM6y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 08:58:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751268AbWHXM6y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 08:58:54 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:30083 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751227AbWHXM6x
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 08:58:53 -0400
Date: Thu, 24 Aug 2006 18:28:14 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Gautham R Shenoy <ego@in.ibm.com>, rusty@rustcorp.com.au,
       torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       arjan@linux.intel.com, davej@redhat.com, dipankar@in.ibm.com,
       ashok.raj@intel.com
Subject: Re: [RFC][PATCH 3/4] (Refcount + Waitqueue) implementation for cpu_hotplug "locking"
Message-ID: <20060824125813.GE25452@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20060824103233.GD2395@in.ibm.com> <20060824111440.GA19248@elte.hu> <20060824122808.GH2395@in.ibm.com> <20060824122527.GA28275@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060824122527.GA28275@elte.hu>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2006 at 02:25:27PM +0200, Ingo Molnar wrote:
> no. The writer first sets the global write_active flag, and _then_ goes 
> on to wait for all readers (if any) to get out of their critical 
> sections. (That's the purpose of the per-cpu waitqueue that readers use 
> to wake up a writer waiting for the refcount to go to 0.)
> 
> can you still see problems with this scheme?

This can cause a deadlock sometimes, when a thread tries to take the
read_lock() recursively, with a writer having come in between the two
recursive reads:

	Reader1 on CPU0			Writer1 on CPU1

	read_lock() - success

					write_lock() - blocks on Reader1
						  (writer_active = 1)


	read_lock() - blocks on Writer1

The only way to avoid this deadlock is to either keep track of
cpu_hp_lock_count per-task (like the preemption count kept per-task)
or allow read_lock() to succeed if reader_count > 1 (even if
writer_active = 1). The later makes the lock unduely biased towards
readers.


-- 
Regards,
vatsa
