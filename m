Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261170AbVBFL04@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261170AbVBFL04 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 06:26:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261179AbVBFL04
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 06:26:56 -0500
Received: from [211.58.254.17] ([211.58.254.17]:57534 "EHLO hemosu.com")
	by vger.kernel.org with ESMTP id S261183AbVBFL0c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 06:26:32 -0500
Date: Sun, 6 Feb 2005 20:26:28 +0900
From: Tejun Heo <tj@home-tj.org>
To: bzolnier@gmail.com, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org
Subject: [PATCH 2.6.11-rc2] ide: driver updates, series 3
Message-ID: <20050206112628.GA31274@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Hello, Bartlomiej.

 Here are four patches which implement taskfile handling functions and
merge flagged_taskfile() into do_rw_taskfile().

 I didn't implement separate writing function for flagged taskfile,
rationale being...

 1. A single function which properly handles both unflagged and
    flagged cases has simpler semantics and, accordingly, less
    likely to cause bugs.

    If there were two separate functions ide_write_taskfile() and
    ide_write_flagged_taskfile(), when somebody tries to add custom
    in/out flags to a piece of code which uses unflagged taskfile and
    ide_write_taskfile(), it would be easy to set in/out flags but
    forget to call ide_write_flagged_taskfile() instead.

 2. There virtually is no overhead.


 In #03, I moved taskfile reading part of ide_end_drive_cmd() into a
separate function named ide_read_taskfile(), so that taskfile handling
codes can live side-by-side in ide-taskfile.c.

 Also, I didn't use any of HWIF, IDE_*_REG macros, as they should go
away.  Please tell me what you think about the new referencing style.


[ Start of patch descriptions ]

01_ide_write_taskfile.patch
	: ide_write_taskfile() implemented.

	ide_write_taskfile(), which writes the content of a ide_task_t
	into the IDE taskfile registers, is implemented, and
	do_rw_taskfile() and flagged_taskfile() are converted to use
	ide_write_taskfile().  Behavior changes are
	- flagged taskfile now honors HOB feature register.
	- No do_rw_taskfile() HIHI check on select register.  Except
	  for the DEV bit, all bits are honored.

02_ide_do_rw_disk_use_write_taskfile.patch
	: __ide_do_rw_disk() rewritten ide_write_taskfile().

	__ide_do_rw_disk() rewritten using ide_write_taskfile().

03_ide_read_taskfile.patch
	: ide_read_taskfile() implemented.

	Status reading part of ide_end_drive_cmd() is moved into
	a separate function ide_read_taskfile().

04_ide_merge_rw_and_flagged_taskfile.patch
	: merge flagged_taskfile() into do_rw_taskfile()

	Merged flagged_taskfile() into do_rw_taskfile().  During the
	merge, the following change took place.
	- Uses taskfile->data_phase to determine if dma trasfer is
	  requested.  (previously, do_rw_taskfile() directly switched
	  on taskfile->command for all dma commands)

[ End of patch descriptions ]


Thanks a lot.  :-)

--
tejun

