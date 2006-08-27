Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751345AbWH0IAU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751345AbWH0IAU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Aug 2006 04:00:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751339AbWH0IAU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Aug 2006 04:00:20 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:36999 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751345AbWH0IAT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Aug 2006 04:00:19 -0400
Date: Sun, 27 Aug 2006 00:59:44 -0700
From: Paul Jackson <pj@sgi.com>
To: ego@in.ibm.com
Cc: mingo@elte.hu, nickpiggin@yahoo.com.au, arjan@infradead.org,
       rusty@rustcorp.com.au, torvalds@osdl.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org, arjan@intel.linux.com, davej@redhat.com,
       dipankar@in.ibm.com, vatsa@in.ibm.com, ashok.raj@intel.com
Subject: Re: [RFC][PATCH 4/4] Rename lock_cpu_hotplug/unlock_cpu_hotplug
Message-Id: <20060827005944.67f51e92.pj@sgi.com>
In-Reply-To: <20060825035328.GA6322@in.ibm.com>
References: <20060824103417.GE2395@in.ibm.com>
	<1156417200.3014.54.camel@laptopd505.fenrus.org>
	<20060824140342.GI2395@in.ibm.com>
	<1156429015.3014.68.camel@laptopd505.fenrus.org>
	<44EDBDDE.7070203@yahoo.com.au>
	<20060824150026.GA14853@elte.hu>
	<20060825035328.GA6322@in.ibm.com>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gautham wrote:
> Which is why I did not expose the locking(at least the write side of it)
> outside. We don't want too many lazy programmers anyway! 

Good thing you did that ;).  This lazy programmer was already
having fantasies of changing the cpuset locks (in kernel/cpuset.c)
manage_mutex and callback_mutex to these writer and reader "unfair
rwsem" locks, respectively.

Essentially these cpuset locks need to guard the cpuset hierarchy, just
as your locks need to guard cpu_online_map.

The change agents (such as a system admin changing something in
the /dev/cpuset hierarchy) are big slow mammoths that appear rarely,
and need to single thread their entire operation, preventing anyone
else from changing the cpuset hierarchy for an extended period of time,
while they validate the request and setup to make the requested change
or changes.

The inhibitors are a swarm of locusts, that change nothing, and need
quick, safe access, free of change during a brief critical section.

Finally the mammoths must not trample the locusts (change what the
locusts see during their critical sections.)

The cpuset change agents (mammoths) take manage_mutex for their entire
operation, locking each other out.  They also take callback_mutex when
making the actual changes that might momentarilly make the cpuset
structures inconsistent.

The cpuset readers (locusts) take callback_mutex for the brief critical
section during which they read out a value or two from the cpuset
structures.

If I understand your unfair rwsem proposal, the cpuset locks differ
from your proposal in these ways:
 1) The cpuset locks are crafted from existing mutex mechanisms.
 2) The 'reader' (change inhibitor) side, aka the callback_mutex,
    is single threaded.  No nesting or sharing of that lock allowed.
    This is ok for inhibiting changes to the cpuset structures, as
    that is not done on any kernel hot code paths (the cpuset
    'locusts' are actually few in number, with tricks such as
    the cpuset generation number used to suppress the locust
    population.)  It would obviously not be ok to single thread
    reading cpu_online_map.
 3) The 'writer' side (the mammoths), after taking the big
    manage_mutex for its entire operation, *also* has to take the
    small callback_mutex briefly around any actual changes, to lock
    out readers.
 4) Frequently accessed cpuset data, such as the cpus and memory
    nodes allowed to a task, are cached in the task struct, to
    keep from accessing the tasks cpuset frequently (more locust
    population suppression.)

Differences (2) and (4) are compromises, imposed by difference (1).

The day might come when there are too many cpuset locusts -- too many
tasks taking the cpuset callback_mutex, and then something like your
unfair rwsem's could become enticing.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
