Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932066AbVJTOHx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932066AbVJTOHx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Oct 2005 10:07:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932075AbVJTOHw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Oct 2005 10:07:52 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:48289 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932066AbVJTOHh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Oct 2005 10:07:37 -0400
Date: Thu, 20 Oct 2005 09:07:33 -0500
From: Dimitri Sivanich <sivanich@sgi.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: 2.6.14-rc4 latency issue with rcu_process_callbacks()/file_free_rcu()
Message-ID: <20051020140733.GA21149@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just bringing up a latency issue I've noticed recently.

In or around 2.6.14-rc4 some changes were made to have the call to
kmem_cache_free() from file_free() in the Linux kernel be deferred, running
as a tasklet via file_free_rcu(), rather than running kmem_cache_free()
right from file_free() directly.

I've noticed that rcu_process_callbacks() can take quite a while to run
now that it routinely calls file_free_rcu() to run kmem_cache_free().
This can make the cpu unavailable for 100's of usec on 1GHz machines, with
or without preemption configured on (much of this path is non-preemptible).

This can result in some unpredictable periods of fairly long cpu latency,
such as when a thread is waiting to be woken by an interrupt handler on a
'now quiet' cpu.  Changing file_free() to call kmem_cache_free() directly
completely eliminates this unexpected latency.

Here's the stack trace that illustrates what I'm talking about:

 [<a0000001001154a0>] kmem_cache_free+0x140/0x3c0
                                sp=e00000307bc27dc0 bsp=e00000307bc21070
 [<a000000100153950>] file_free_rcu+0x30/0x60
                                sp=e00000307bc27dd0 bsp=e00000307bc21050
 [<a0000001000d89c0>] __rcu_process_callbacks+0x2c0/0x5e0
                                sp=e00000307bc27dd0 bsp=e00000307bc21010
 [<a0000001000d8d40>] rcu_process_callbacks+0x60/0xc0
                                sp=e00000307bc27dd0 bsp=e00000307bc20fe8
 [<a0000001000baae0>] tasklet_action+0x2c0/0x320
                                sp=e00000307bc27dd0 bsp=e00000307bc20f98
 [<a0000001000ba0d0>] __do_softirq+0x130/0x240
                                sp=e00000307bc27dd0 bsp=e00000307bc20ef8
 [<a0000001000ba260>] do_softirq+0x80/0xe0
                                sp=e00000307bc27dd0 bsp=e00000307bc20e98
 [<a0000001000ba4a0>] ksoftirqd+0x140/0x1a0
                                sp=e00000307bc27dd0 bsp=e00000307bc20e68

Dimitri Sivanich
