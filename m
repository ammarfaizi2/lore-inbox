Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932290AbWE3OKf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932290AbWE3OKf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 10:10:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932286AbWE3OKf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 10:10:35 -0400
Received: from mx1.redhat.com ([66.187.233.31]:3280 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932300AbWE3OKe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 10:10:34 -0400
Date: Tue, 30 May 2006 10:10:06 -0400
From: Dave Jones <davej@redhat.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch 00/61] ANNOUNCE: lock validator -V1
Message-ID: <20060530141006.GG14721@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Arjan van de Ven <arjan@infradead.org>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
	Ingo Molnar <mingo@elte.hu>
References: <20060529212109.GA2058@elte.hu> <6bffcb0e0605291528qe24a0a3r3841c37c5323de6a@mail.gmail.com> <20060529224107.GA6037@elte.hu> <20060529230908.GC333@redhat.com> <1148967947.3636.4.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1148967947.3636.4.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30, 2006 at 07:45:47AM +0200, Arjan van de Ven wrote:

 > One
 > ---
 > store_scaling_governor takes policy->lock and then calls __cpufreq_set_policy
 > __cpufreq_set_policy calls __cpufreq_governor
 > __cpufreq_governor  calls __cpufreq_driver_target via cpufreq_governor_performance
 > __cpufreq_driver_target calls lock_cpu_hotplug() (which takes the hotplug lock)
 > 
 > 
 > Two
 > ---
 > cpufreq_stats_init lock_cpu_hotplug() and then calls cpufreq_stat_cpu_callback
 > cpufreq_stat_cpu_callback calls cpufreq_update_policy
 > cpufreq_update_policy takes the policy->lock
 > 
 > 
 > so this looks like a real honest AB-BA deadlock to me...

This looks a little clearer this morning.  I missed the fact that sys_init_module
isn't completely serialised, only the loading part. ->init routines can and will be
called in parallel.

I don't see where cpufreq_update_policy takes policy->lock though.
In my tree it just takes the per-cpu data->lock.

Time for more wake-up juice? or am I missing something obvious again?

		Dave

-- 
http://www.codemonkey.org.uk
