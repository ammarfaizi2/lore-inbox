Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932514AbWA1E7B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932514AbWA1E7B (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 23:59:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932517AbWA1E7B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 23:59:01 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:24254 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932514AbWA1E7A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 23:59:00 -0500
Date: Fri, 27 Jan 2006 20:58:34 -0800
From: Paul Jackson <pj@sgi.com>
To: Nathan Lynch <ntl@pobox.com>
Cc: steiner@sgi.com, mingo@elte.hu, linux-kernel@vger.kernel.org,
       rml@novell.com
Subject: Re: 2.6.16 - sys_sched_getaffinity & hotplug
Message-Id: <20060127205834.b5821a02.pj@sgi.com>
In-Reply-To: <20060128034241.GB18730@localhost.localdomain>
References: <20060127230659.GA4752@sgi.com>
	<20060127191400.aacb8539.pj@sgi.com>
	<20060128034241.GB18730@localhost.localdomain>
Organization: SGI
X-Mailer: Sylpheed version 2.1.7 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nathan wrote:
> Which is problematic, because cpuset_cpus_allowed ->
> guarantee_online_cpus restricts the task->cpus_allowed mask to cpus
> which happen to be online at the time of the call to
> sched_setaffinity.  If more cpus come online later, that task can't be
> migrated to them.

Well, sort of.

A task could always migrate - just because a sched_getaffinity
the task did in the past doesn't show a CPU as valid, doesn't stop
the task from asking to pin to that CPU now.

One of three lessons could be taken from your example:
 1) return all possible CPUS (CPU_MASK_ALL, likely), as you recommend
 2) tell the task to not stash possibly stale returns from sched_getaffinity
 3) virtualize app CPU numbers relative to their containing cpuset,
      using an additional layer of user code.

I don't think we (or at least I ;) have an adequate understanding yet
of how hotplug will interact with the CPU affinity and Memory Node
mempolicy system calls, both of which are easier to use if things
don't come and go.  These calls are still, of course, usable, but
the possibilities for the task confusing itself with stale data
increase, and the simple system numbering of CPUs and Nodes by these
system calls makes (properly so) no effort to hide^Wvirtualize
these changes.

I tend to prefer lesson (3) above, but haven't yet delivered the
libraries or tools needed to support this as Open Source, so can't
really expect that preference to be very persuasive to others.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
