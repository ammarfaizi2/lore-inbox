Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261390AbVB0OHt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261390AbVB0OHt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Feb 2005 09:07:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261377AbVB0OHt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Feb 2005 09:07:49 -0500
Received: from mxsf34.cluster1.charter.net ([209.225.28.159]:15755 "EHLO
	mxsf34.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S261390AbVB0OHg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Feb 2005 09:07:36 -0500
Message-Id: <3rr3e8$in75md@mxip10a.cluster1.charter.net>
X-Ironport-AV: i="3.90,119,1107752400"; 
   d="scan'208"; a="628332237:sNHT28118074"
From: "Laurence Oberman" <zaurus@photonlinux.com>
To: <linux-kernel@vger.kernel.org>
Subject: Understanding task_list pointers in a wait_queue_head_t
Date: Sun, 27 Feb 2005 09:07:31 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcUc1a1Hki2lvBKpSIqXxRRD1IDElA==
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
This is my first posting, so apologies if the answer to the question is
obvious to many of you. I have done a lot of investigation before I posted.

I have been attempting to isolate a hang in the Kernel which I suspect is
due to the HP insight manager daemon cmaidad. What I really need is a quick
explanation of the task_list pointers I see in the wait queues.

Here is an example of a task where I/O never returns for cmaidad. At the
bottom I get the data from the wait_queue structure and it does not make
sense to me.

crash-france> bt -t
PID: 3755   TASK: f1e5e000  CPU: 3   COMMAND: "cmaidad"
      START: context_switch at c0125ed4
  [f1e5fc44] __alloc_pages at c0158e60
  [f1e5fc58] schedule at c0123f14
  [f1e5fc9c] wait_for_completion at c0124621
  [f1e5fcdc] start_io at f886d346
  [f1e5fcf0] cciss_ioctl at f886b759
  [f1e5fd00] __journal_file_buffer at f887d64f
  [f1e5fd34] do_get_write_access at f887bcc8
  [f1e5fd88] do_get_write_access at f887bcc8
  [f1e5fdd8] journal_dirty_metadata at f887c72c
  [f1e5fe00] ext3_do_update_inode at f88931ff
  [f1e5fe48] journal_stop at f887cbbe
  [f1e5fe78] ext3_commit_write at f8890fdf
  [f1e5fe94] journal_dirty_sync_data at f8890d50
  [f1e5feb4] follow_page at c01401e7
  [f1e5ff34] futex_wake at c013c8b5
  [f1e5ff3c] sys_msgrcv at c01aabf4
  [f1e5ff50] blkdev_ioctl at c016d50e
  [f1e5ff64] sys_ioctl at c0177f26
  [f1e5ff90] Enf_ioctl at f8f542

>From bt -f
 #2 [f1e5fc9c] wait_for_completion at c012461c
    [RA: f886b759  SP: f1e5fca0  FP: f1e5fcf0  SIZE: 84]
    f1e5fca0: 00000000  f1e5e000  00000000  00000000
    f1e5fcb0: 00000000  e00b8000  00000000  00000030
    f1e5fcc0: 00000001  f1e5e000  f1e5ff28  f1e5ff28
    f1e5fcd0: 00000000  00000000  200b9000  f886d346
    f1e5fce0: f1e5ff20  00003207  f1e5fedc  e00b9000
    f1e5fcf0: f886b759 

crash-france> struct completion  f1e5ff20
struct completion {
  done = 0,
  wait = {
    lock = {
      lock = 1
    },
    task_list = {
      next = 0xf1e5fcc8,  >>>>>>>
      prev = 0xf1e5fcc8   >>>>>>>  ???
    }
  }
} 

Questions
-----------
The task_list next and previous are set the same, I assume this means there
is only one task on the wait queue.

Now the values:
I cannot find how to see the waiting task from the task list pointers. I
guess these are really the list_head pointers.

I cannot find these addresses in any of the task pointers, so how do I get
the task descriptors on the wait queues from these in the crash dump. 

Thanks for the help.

Laurence Oberman


