Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265658AbUBBJNW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 04:13:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265659AbUBBJNW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 04:13:22 -0500
Received: from mx1.redhat.com ([66.187.233.31]:9679 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265658AbUBBJNV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 04:13:21 -0500
Date: Mon, 2 Feb 2004 04:12:34 -0500 (EST)
From: Ingo Molnar <mingo@redhat.com>
X-X-Sender: mingo@devserv.devel.redhat.com
To: Rusty Russell <rusty@rustcorp.com.au>
cc: akpm@osdl.org, linux-kernel@vger.kernel.org,
       Nick Piggin <piggin@cyberone.com.au>, dipankar@in.ibm.com,
       vatsa@in.ibm.com
Subject: Re: [PATCH 3/4] 2.6.2-rc2-mm2 CPU Hotplug: The Core
In-Reply-To: <20040131141937.E58852C082@lists.samba.org>
Message-ID: <Pine.LNX.4.58.0402020353240.25194@devserv.devel.redhat.com>
References: <20040131141937.E58852C082@lists.samba.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 1 Feb 2004, Rusty Russell wrote:

> D: - kernel/sched.c: Add wake_idle_cpu() for i386 hotplug.
> D:      
> D:      Check everywhere to make sure we never move tasks onto an
> D:      offline cpu: we'll just be fighting migrate_all_tasks().
> D: 
> D:      Change sched_migrate_task() to migrate_to_cpu and expose it
> D:      for hotplug cpu.
> D: 
> D:      Take hotplug lock in sys_sched_setaffinity.
> D:      
> D:      Return cpus_allowed masked by cpu_possible_map, not
> D:      cpu_online_map in sys_sched_getaffinity, otherwise tasks can't
> D:      know about whether they can run on currently-offline cpus.
> D: 
> D:      Implement migrate_all_tasks() to push tasks off the dying cpu.
> D:      
> D:      Add callbacks to stop migration thread.

the sched.c bits look good. A question: why is the migrate_all_tasks()
code nonatomic? If you run this code in the context of the migration
thread of the downed CPU then all of the migration can be done in one big
atomic locked section which holds all runqueue locks and just moves all
tasks off the current CPU. If it were done this way then eg. the
__migrate_task() race-avoidance check (cpu_is_offline()) could go away and
the whole thing would be more robust i believe.

	Ingo
