Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751316AbWI2CNI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751316AbWI2CNI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 22:13:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751360AbWI2CNI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 22:13:08 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:12496 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751316AbWI2CND
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 22:13:03 -0400
Message-Id: <20060929020232.756637000@us.ibm.com>
User-Agent: quilt/0.45-1
Date: Thu, 28 Sep 2006 19:02:32 -0700
From: Matt Helsley <matthltc@us.ibm.com>
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Cc: Jes Sorensen <jes@sgi.com>, LSE-Tech <lse-tech@lists.sourceforge.net>,
       Chandra S Seetharaman <sekharan@us.ibm.com>,
       John T Kohl <jtk@us.ibm.com>, Christoph Hellwig <hch@lst.de>,
       Al Viro <viro@zeniv.linux.org.uk>, Steve Grubb <sgrubb@redhat.com>,
       linux-audit@redhat.com, Paul Jackson <pj@sgi.com>
Subject: [RFC][PATCH 00/10] Task watchers v2 Introduction
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is version 2 of my Task Watchers patches.

Task watchers calls functions whenever a task forks, execs, changes its
[re][ug]id, or exits.

Task watchers is primarily useful to existing kernel code as a means making the
code in fork and exit more readable. Kernel code uses these paths by marking a
function as a task watcher much like modules mark their init functions with
module_init(). This reduces the code length and complexity of copy_process().

The first patch adds the basic infrastructure of task watchers: notification
function calls in the various paths and a table of function pointers to be
called. It uses an ELF section because parts of the table must be gathered
from all over the kernel code and using the linker is easier than resolving
and maintaining complex header interdependencies. An ELF table is also ideal
because its read-only nature means that no locking nor list traversal are
required.

Subsequent patches adapt existing parts of the kernel to use a task watcher
 -- typically in the fork, clone, and exit paths:
	audit
	semundo
	cpusets
	mempolicy
	trace irqflags
	lockdep
	keys (for processes -- not for thread groups)
	process events connector

I'm working on three more patches that add support for creating a task watcher
from within a module using an ELF section. I've not posted that work because it
hasn't successfully booted much less completed the small selection of smoke
tests I ran on these.

TODO:
	Mark the task watcher table ELF section read-only.  I've googled, read
	man pages, navigated the info pages, tried using PHDR, and according to
	the output of objdump, had no success. I'd really appreciate a pointer
	to an example showing what makes ld mark a kernel ELF section read-only.

Changes:
v2:
	Dropped use of notifier chains
	Dropped per-task watchers
		Can be implemented on top of this
		Still requires notifier chains
	Dropped taskstats conversion
		Parts of taskstats had to move away from the regions of
		copy_process() and do_exit() where task_watchers are notified
	Used linker script mechanism suggested by Al Viro
	Created one "list" of watchers per event as requested by Andrew Morton
		No need to multiplex a single function call
	Easier to static register/unregister watchers: 1 line of code
	val param now used for:
		WATCH_TASK_INIT:  clone_flags
		WATCH_TASK_CLONE: clone_flags
		WATCH_TASK_EXIT:  exit code
		WATCH_TASK_*:     <unused>
	Renamed notify_watchers() to notify_task_watchers()
	Replaced: if (err != 0) --> if (err)
	Added patches converting more "features" to use task watchers
	Added return code handling to WATCH_TASK_INIT
		Return code handling elsewhere didn't seem appropriate
		since there was generally no response necessary
	Fixed process keys free to handle failure in fork as originally coded
		in copy_process
	Added process keys code to watch for [er][ug]id changes

v1:
        Added ability to cause fork to fail with NOTIFY_STOP_MASK
        Added WARN_ON() when watchers cause WATCH_TASK_FREE to stop early
        Moved fork invocation
        Moved exec invocation
        Added current as argument to exec invocation
        Moved exit code assignment
        Added id change invocations
v0:
	Based on Jes Sorensen's Task Notifiers patches

Cheers,
	-Matt Helsley
--
