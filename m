Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265797AbTFSPVV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 11:21:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265801AbTFSPVG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 11:21:06 -0400
Received: from rj.sgi.com ([192.82.208.96]:10470 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id S265797AbTFSPU6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 11:20:58 -0400
Message-ID: <3EF1D830.F12113D@sgi.com>
Date: Thu, 19 Jun 2003 10:35:12 -0500
From: Ray Bryant <raybry@sgi.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: PROBLEM: Bug in __pollwait() can cause select() and poll() to hang in 
 2.4.21
Content-Type: text/plain; charset=us-ascii
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
2.4.13 thru 2.4.21.  It is not present in 2.5.70, since a different
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

     The simplest fix is just to set current state back to TASK_RUNNING
for the duration of the call to __get_free_page(GFP_KERNEL) in
__pollwait():

--- /usr/tmp/TmpDir.14764-0/linux/linux/fs/select.c        Mon Jun  2
10:29:37 2003
 +++ linux/linux/fs/select.c     Mon Jun  2 08:02:45 2003
 @@ -79,7 +79,9 @@
         if (!table || POLL_TABLE_FULL(table)) {
                 struct poll_table_page *new_table;
  
 +               set_current_state(TASK_RUNNING);
                 new_table = (struct poll_table_page *)
__get_free_page(GFP_KERNEL);
 +               set_current_state(TASK_INTERRUPTIBLE);
                 if (!new_table) {
                         p->error = -ENOMEM;
                         __set_current_state(TASK_RUNNING);


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
