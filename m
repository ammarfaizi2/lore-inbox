Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261921AbVBUIia@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261921AbVBUIia (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Feb 2005 03:38:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261924AbVBUIi3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Feb 2005 03:38:29 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:19847 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261921AbVBUIhx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Feb 2005 03:37:53 -0500
Message-ID: <42199EE8.9090101@sgi.com>
Date: Mon, 21 Feb 2005 02:42:16 -0600
From: Ray Bryant <raybry@sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>, Paul Jackson <pj@sgi.com>
CC: ak@muc.de, raybry@austin.rr.com, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, Dave Hansen <haveblue@us.ibm.com>
Subject: Re: [RFC 2.6.11-rc2-mm2 0/7] mm: manual page migration -- overview
 II
References: <20050215121404.GB25815@muc.de> <421241A2.8040407@sgi.com> <20050215214831.GC7345@wotan.suse.de> <4212C1A9.1050903@sgi.com> <20050217235437.GA31591@wotan.suse.de> <4215A992.80400@sgi.com> <20050218130232.GB13953@wotan.suse.de> <42168FF0.30700@sgi.com> <20050220214922.GA14486@wotan.suse.de> <20050220143023.3d64252b.pj@sgi.com> <20050220223510.GB14486@wotan.suse.de>
In-Reply-To: <20050220223510.GB14486@wotan.suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All,

Just an update on the idea of migrating a process without suspending
it.

The hard part of the problem here is to make sure that the page_migrate()
system call sees all of the pages to migrate.  If the process that is
being migrated can still allocate pages, then the page_migrate() call
may miss some of the pages.

One way to solve this problem is to force the process to start allocating
pages on the new nodes before calling page_migrate().  There are a couple
of subcases:

(1)  For memory mapped files with a non-DEFAULT associated memory policy,
      one can use mbind() to fixup the memory policy.  (This assumes the
      Steve Longerbeam patches are applied, as I understand things).

(2)  For anonymous pages and memory mapped files with DEFAULT policy,
      the allocation depends on which node the process is running.  So
      after doing the above, you need to migrate the task to a cpu
      associated with one of the nodes.

The problem with (1) is that it is racy, there is no guarenteed way to get the
list of mapped files for the process while it is still running.  A process
can do it for itself, so one way to do this would be to write the set of
new nodes to a /proc/pid file, then send the process a SIG_MIGRATE
signal.  Ugly....  (For multithreaded programs, all of the threads have
to be signalled to keep them from mmap()ing new files during the migration.)

(1) could be handled as part of the page_migrate() system call --
make one pass through the address space searching for mempolicy()
data structures, and updating them as necessary.  Then make a second
pass through and do the migrations.  Any new allocations will then
be done under the new mempolicy, so they won't be missed.  But this
still gets us into trouble if the old and new node lists are not
disjoint.

This doesn't handle anonymous memory or mapped files associated with
the DEFAULT policy.  A way around that would be to add a target cpu_id
to the page_migrate() system call.  Then before doing the first pass
described above, one would do the equivalenet of set_sched_affinity()
for the target pid, moving it to the indicated cpu.  Once it is known
the pid has moved (how to do that?), we now know anonymous memory and
DEFAULT mempolicy mapped files will be allocated on the nodes associated
with the new cpu.  Then we can proceed as discussed in the last paragraph.
Also ugly, due to the extra parameter.

Alternatively, we can just require, for correct execution, the invoking
code to do the set_sched_affinity() first, in those cases where
migrating a running task is important.

Anyway, how important is this, really for acceptance of a page_migrate()
system call in the community?  (that is, how important is it to be
able to migrate a process without suspending it?)
-- 
Best Regards,
Ray
-----------------------------------------------
                   Ray Bryant
512-453-9679 (work)         512-507-7807 (cell)
raybry@sgi.com             raybry@austin.rr.com
The box said: "Requires Windows 98 or better",
            so I installed Linux.
-----------------------------------------------
