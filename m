Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264961AbUATGAw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 01:00:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265080AbUATGAw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 01:00:52 -0500
Received: from ausmtp01.au.ibm.com ([202.81.18.186]:1186 "EHLO
	ausmtp01.au.ibm.com") by vger.kernel.org with ESMTP id S264961AbUATGAv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 01:00:51 -0500
From: Rusty Russell <rusty@au1.ibm.com>
To: vatsa@in.ibm.com
Cc: lhcs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       torvalds@osdl.org, akpm@osdl.org, rml@tech9.net
Subject: CPU Hotplug: Hotplug Script And SIGPWR
In-reply-to: Your message of "Fri, 16 Jan 2004 17:44:46 +0530."
             <20040116174446.A2820@in.ibm.com> 
Date: Tue, 20 Jan 2004 16:44:45 +1100
Message-Id: <20040120060027.91CC717DE5@ozlabs.au.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20040116174446.A2820@in.ibm.com> you write:
> Would it make sense if we defer invoking hotplug script _after_
> the CPU is completely dead (i.e after issuing the CPU_DEAD
> notification)?

The original code wanted to block until the hotplug script
acknowledged the removal before completing it.  Greg KH says hotplug
doesn't work this way, so now it could well be delivered after
everything is over.  If it's simpler, we can just do it after.

The other issue I wanted to revisit: we currently send SIGPWR to all
processes which we have to undo the CPU affinity for (with a new
si_info field containing the cpu going down).

The main problem is that a process can call sched_setaffinity on
another (unrelated) task, which might not know about it.  One option
would be to only deliver the signal if it's not SIG_DFL for that
process.  Another would be not to signal, and expect hotplug scripts
to clean up.

Thoughts?
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
