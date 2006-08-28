Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932397AbWH1GhR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932397AbWH1GhR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 02:37:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932398AbWH1GhQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 02:37:16 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:32455 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932397AbWH1GhO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 02:37:14 -0400
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1
From: Keith Owens <kaos@ocs.com.au>
To: Rusty Russell <rusty@rustcorp.com.au>
cc: linux-kernel@vger.kernel.org, mingo@elte.hu
Subject: Re: Is stopmachine() preempt safe? 
In-reply-to: Your message of "Mon, 28 Aug 2006 16:17:11 +1000."
             <1156745831.10467.44.camel@localhost.localdomain> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 28 Aug 2006 16:36:56 +1000
Message-ID: <10518.1156747016@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell (on Mon, 28 Aug 2006 16:17:11 +1000) wrote:
>On Mon, 2006-08-28 at 12:55 +1000, Keith Owens wrote:
>> Rusty Russell (on Mon, 28 Aug 2006 09:38:55 +1000) wrote:
>> >On Sun, 2006-08-27 at 19:42 +1000, Keith Owens wrote:
>> >> I cannot convince myself that stopmachine() is preempt safe.  What
>> >> prevents this race with CONFIG_PREEMPT=y?
>> >
>> >Nothing.  Read side is preempt_disable.  Write side is stopmachine.
>> 
>> That is very worrying.  The whole point of stopmachine is to get all
>> cpus to a known state with no locally cached global data, so the caller
>> of stopmachine can safely fiddle with some global data (like updating
>> the module lists).  But CONFIG_PREEMPT defeats this and turns any code
>> that relies on stopmachine into a race.
>
>Hi Keith,
>
>	Do not panic: this is not a bug, and was never how stop_machine was to
>be used.  try_module_get() disables preemption, and you are supposed to
>disable preemption

Disabling preemption only guarantees that the current task will not be
preempted.  It says nothing about the state of tasks that were already
running on the cpus when stopmachine was called.  It is these tasks
that were already running and were preempted by stopmachine that have
to be flushed before stopmachine can continue.  Remember that this is
the race:

cpu 0				cpu 1
stop_machine()
				Process <n> reads a global resource
do_stop()
kernel_thread(stopmachine, 1)
				Process <n> is preempted
				stopmachine() runs on cpu 1
				STOPMACHINE_PREPARE
				STOPMACHINE_DISABLE_IRQ
do_stop() calls smdata->fn
smdata->fn changes global data
restart_machine()
				STOPMACHINE_EXIT
				stopmachine() exits
				Scheduler resumes process <n>
				The global resource is out of sync

>(or take cpu_hotplug_lock) when relying on
>cpu_online_map.

There is a lot of code in the kernel that runs cpu_online_map without
taking any locks and without disabling preemption.  Obviously we do not
want all that code to lock or disable preemption, it will kill
scalability.  The lack of locking on the read side means that changes
to cpu_online_map have to be done under stopmachine, which brings in
the race again.

I will have a look at your scheduler patch and see if it fixes the
race.

