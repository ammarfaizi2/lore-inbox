Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932215AbWH0SC4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932215AbWH0SC4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Aug 2006 14:02:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932216AbWH0SC4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Aug 2006 14:02:56 -0400
Received: from smtp.osdl.org ([65.172.181.4]:45477 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932215AbWH0SCz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Aug 2006 14:02:55 -0400
Date: Sun, 27 Aug 2006 11:01:43 -0700
From: Andrew Morton <akpm@osdl.org>
To: dipankar@in.ibm.com
Cc: Linus Torvalds <torvalds@osdl.org>, Dave Jones <davej@redhat.com>,
       ego@in.ibm.com, rusty@rustcorp.com.au, linux-kernel@vger.kernel.org,
       arjan@intel.linux.com, mingo@elte.hu, vatsa@in.ibm.com,
       ashok.raj@intel.com
Subject: Re: [RFC][PATCH 0/4] Redesign cpu_hotplug locking.
Message-Id: <20060827110143.663d8207.akpm@osdl.org>
In-Reply-To: <20060827174946.GB11710@in.ibm.com>
References: <20060824091704.cae2933c.akpm@osdl.org>
	<20060825095008.GC22293@redhat.com>
	<Pine.LNX.4.64.0608261404350.11811@g5.osdl.org>
	<20060826150422.a1d492a7.akpm@osdl.org>
	<20060827061155.GC22565@in.ibm.com>
	<20060826234618.b9b2535a.akpm@osdl.org>
	<20060827071116.GD22565@in.ibm.com>
	<20060827004213.4479e0df.akpm@osdl.org>
	<20060827110657.GF22565@in.ibm.com>
	<20060827102116.f9077bac.akpm@osdl.org>
	<20060827174946.GB11710@in.ibm.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 27 Aug 2006 23:19:46 +0530
Dipankar Sarma <dipankar@in.ibm.com> wrote:

> I don't see why this
> is needed - 
> 
> + break;
> +
> + case CPU_DOWN_PREPARE:
> + 	mutex_lock(&workqueue_mutex);
> + 	break;
> +
> + case CPU_DOWN_FAILED:
> + 	mutex_unlock(&workqueue_mutex);
> 	break;
> 
> This seems like some implicit code locking to me. Why is it not
> sufficient to hold the lock in the CPU_DEAD code while walking
> the workqueues ?

?

We need to hold workqueue_mutex to protect the per-cpu workqueue resources
while cpu_online_map is changing and while per-cpu memory is being
allocated or freed.

Look at cpu_down() and mentally replace the
blocking_notifier_call_chain(CPU_DOWN_PREPARE) with
mutex_lock(workqueue_mutex), etc.  The __stop_machine_run() in there
modifies the (ie: potentially frees) the workqueue code's per-cpu memory. 
So we take that resource's lock while doing so.
