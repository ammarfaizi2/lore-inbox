Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264929AbVBEK0F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264929AbVBEK0F (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Feb 2005 05:26:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265938AbVBEK0F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Feb 2005 05:26:05 -0500
Received: from [211.58.254.17] ([211.58.254.17]:25489 "EHLO hemosu.com")
	by vger.kernel.org with ESMTP id S265862AbVBEKZk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Feb 2005 05:25:40 -0500
Message-ID: <42049F20.7020706@home-tj.org>
Date: Sat, 05 Feb 2005 19:25:36 +0900
From: Tejun Heo <tj@home-tj.org>
User-Agent: Debian Thunderbird 1.0 (X11/20050118)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org,
       lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH REPOST 2.6.11-rc2] ide: driver updates (phase 2)
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 This thread is repost of phase 2 ide driver updates.  Sorry again.

 Hello, Bartlomiej.

 These are reordered/modified/(hopefully)appliable nine patches from
the previous series of patches.  #01 is the only new one.  It kills
the unused pkt_task_t in ide.h.  #02/#03 are moved upward and #04 is
modified as you've requested.  #05/#08 now directly use taskfile
transport instead of calling ide_taskfile_ioctl().  #08 now also
properly handles WIN_SMART case.

 If these patches go in, I have eight patches left.  One of them is
ide_explicit_TASKFILE_NO_DATA.  As we've discussed, I'm going to add
default initialization of task->[pre]handler.  That patch wasn't
included in this series because I didn't know if do_rw_taskfile() and
flagged_taskfile() are going to be merged or not.  So, please tell
me what you think. :-)

 I'll talk about other patches in their reply threads.

[ Start of patch descriptions ]

01_ide_kill_pkt_task_t.patch
	: kill unused pkt_task_t

	Remove unused pkt_task_t definition from ide.h.

02_ide_taskfile_init_drive_cmd.patch
	: ide_init_drive_cmd() now defaults to REQ_DRIVE_TASKFILE

	ide_init_drive_cmd() now initializes rq->flags to
	REQ_DRIVE_TASKFILE.

03_ide_diag_taskfile_use_init_drive_cmd.patch
	: ide_diag_taskfile() rq initialization fix

	In ide_diag_taskfile(), when initializing taskfile rq,
	ref_count wasn't initialized properly.  Modified to use
	ide_init_drive_cmd().  This doesn't really change any behavior
	as the request isn't managed via the block layer.

04_ide_taskfile_flush.patch
	: convert REQ_DRIVE_TASK to REQ_DRIVE_TASKFILE

	All REQ_DRIVE_TASK users except ide_task_ioctl() converted
	to use REQ_DRIVE_TASKFILE.
	1. idedisk_issue_flush() converted to use REQ_DRIVE_TASKFILE.
	   This and the changes in ide_get_error_location() remove a
	   possible race condition between ide_get_error_location()
	   and other requests.
	2. ide_queue_flush_cmd() converted to use REQ_DRIVE_TASKFILE.

05_ide_taskfile_task_ioctl.patch
	: map ide_task_ioctl() to ide_taskfile_ioctl()

	ide_task_ioctl() modified to map to ide_taskfile_ioctl().
	This is the last user of REQ_DRIVE_TASK.

06_ide_remove_task.patch
	: remove REQ_DRIVE_TASK handling

	Unused REQ_DRIVE_TASK handling removed.

07_ide_taskfile_cmd.patch
	: convert REQ_DRIVE_CMD to REQ_DRIVE_TASKFILE

	All in-kernel REQ_DRIVE_CMD users except for ide_cmd_ioctl()
	converted to use REQ_DRIVE_TASKFILE.

08_ide_taskfile_cmd_ioctl.patch
	: map ide_cmd_ioctl() to ide_taskfile_ioctl()

	ide_cmd_ioctl() converted to use ide_taskfile_ioctl().  This
	is the last user of REQ_DRIVE_CMD.

09_ide_remove_cmd.patch
	: remove REQ_DRIVE_CMD handling

	Removed unused REQ_DRIVE_CMD handling.

[ End of patch descriptions ]

Thanks.

-- 
tejun

