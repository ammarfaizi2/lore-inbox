Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264638AbTF0SEq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jun 2003 14:04:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264647AbTF0SEq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jun 2003 14:04:46 -0400
Received: from rj.sgi.com ([192.82.208.96]:22951 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id S264638AbTF0SEm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jun 2003 14:04:42 -0400
Message-ID: <3EFC8AA8.7000501@sgi.com>
Date: Fri, 27 Jun 2003 13:19:20 -0500
From: Ray Bryant <raybry@sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Andrew Morton <akpm@digeo.com>, Manfred Spraul <manfred@colorfullife.com>,
       Andi Kleen <ak@suse.de>, trivial@rustcorp.com.au,
       alan@lxorguk.ukuu.org.uk
Subject: PROBLEM: Bug in __pollwait() can cause select() and poll() to hang
 in  2.4.22-pre2 -- second try
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] One line summary of the problem:

      In low memory situations, a process that issues a call to select()
or poll() can sleep forever in the kernel.

[2.] Full description of the problem/report:

      select() and poll() call a common routine: __pollwait().  On the
first call to __pollwait(), it calls __get_free_page(GFP_KERNEL) to
allocate a table to hold wait queues.  In the natural course of things,
this calls into __alloc_pages().  In low memory situations, the process
can then end up in the rebalance code at the bottom of __alloc_pages()
where there is a call to yield().  If the process makes this call, this
is a bad thing [tm], since the process state at that point is
TASK_INTERRUPTIBLE.  There is no wait queue yet for the process (that is
done later in __pollwait()) and no schedule timeout event has yet been
created (that is done later in select()) so the process will never
return from the call to yield().

[3.] Keywords (i.e., modules, networking, kernel):

      Kernel

[4.] Kernel version (from /proc/version):

      This bug appears to be present in every 2.4 kernel from (at least)
2.4.13 thru 2.4.22-pre2.  It is not present in 2.5.70, since a different
method of waiting for memory to free up is used there (in
__alloc_pages()).

[5.] Output of Oops.. message (if applicable) with symbolic information
      resolved (see Documentation/oops-tracing.txt)

      N/A.

[6.] A small shell script or example program which triggers the
      problem (if possible)

      We ecountered this whilst running batch queue tests that are too
complex to include here.

[7.] Environment

[7.1.] Software (add the output of the ver_linux script here)

[7.2.] Processor information (from /proc/cpuinfo):

       We encountered this on ia64, however, this is in machine
independent code and we believe the bug is present on all 2.4.21
platforms.

[7.3.] Module information (from /proc/modules):

[7.4.] Loaded driver and hardware information (/proc/ioports,
/proc/iomem)

[7.5.] PCI information ('lspci -vvv' as root)

[7.6.] SCSI information (from /proc/scsi/scsi)

[7.7.] Other information that might be relevant to the problem
        (please look in /proc and include all information that you
        think to be relevant):

[X.] Other notes, patches, fixes, workarounds:

      The simplest fix (as suggested by Manfred Spraul) is to set
current=>state to TASK_RUNNING just before the call to yield() in
__alloc_pages().  I have tested this sufficiently that I believe
this does not change the user level semantics of select() (my
concern was that if state got set to TASK_RUNNING that the syscall
could return before any fd's are ready or the select() timeout has
expired, but this does not appear to be the case).

Here is a trivial patch against 2.4.22-pre2:

--- linux-2.4.22-pre2.orig/mm/page_alloc.c      Thu Nov 28 17:53:15 2002
+++ linux-2.4.22-pre2/mm/page_alloc.c   Fri Jun 27 13:47:49 2003
@@ -418,6 +418,7 @@
                 return NULL;

         /* Yield for kswapd, and try again */
+        set_current_state(TASK_RUNNING);
         yield();
         goto rebalance;
  }

-- 
Best Regards,
Ray
-----------------------------------------------
                   Ray Bryant
512-453-9679 (work)         512-507-7807 (cell)
Jun 23-Jul 18 I will be at: 970-513-4743
raybry@sgi.com             raybry@austin.rr.com
The box said: "Requires Windows 98 or better",
            so I installed Linux.
-----------------------------------------------

