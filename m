Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751070AbWIKCjL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751070AbWIKCjL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Sep 2006 22:39:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751075AbWIKCjL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Sep 2006 22:39:11 -0400
Received: from liaag1af.mx.compuserve.com ([149.174.40.32]:19155 "EHLO
	liaag1af.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1751059AbWIKCjK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Sep 2006 22:39:10 -0400
Date: Sun, 10 Sep 2006 22:34:33 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: 2.6.18-rc6-mm1
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200609102237_MC3-1-CAD6-7C3@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <20060908011317.6cb0495a.akpm@osdl.org>

On Fri, 8 Sep 2006 01:13:17 -0700, Andrew Morton wrote:

> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc6/2.6.18-rc6-mm1/

$ cd 2.6.18-rc6-mm1
$ tar xjf 2.6.18-rc6-mm1-broken-out.tar.bz2
$ mv broken-out patches
$ quilt push -a
...
Applying patch gregkh-driver-pm-pci-and-ide-handle-pm_event_prethaw.patch
patching file drivers/ide/ide.c
Hunk #2 FAILED at 1221.
1 out of 2 hunks FAILED -- rejects in file drivers/ide/ide.c
patching file drivers/pci/pci.c
Patch gregkh-driver-pm-pci-and-ide-handle-pm_event_prethaw.patch does not apply (enforce with -f)


git-block.patch (applied earlier) has this:

--- a/drivers/ide/ide.c
+++ b/drivers/ide/ide.c
@@ -1217,9 +1217,9 @@ static int generic_ide_suspend(struct de
        memset(&rq, 0, sizeof(rq));
        memset(&rqpm, 0, sizeof(rqpm));
        memset(&args, 0, sizeof(args));
-       rq.flags = REQ_PM_SUSPEND;
+       rq.cmd_type = REQ_TYPE_PM_SUSPEND;
        rq.special = &args;
-       rq.end_io_data = &rqpm;                       <=================
+       rq.data = &rqpm;                              <=================
        rqpm.pm_step = ide_pm_state_start_suspend;
        rqpm.pm_state = state.event;


which conflicts with this chunk in the failing patch:

@@ -1221,7 +1221,9 @@ static int generic_ide_suspend(struct de
        rq.special = &args;
        rq.end_io_data = &rqpm;                       <=================
        rqpm.pm_step = ide_pm_state_start_suspend;
-       rqpm.pm_state = state.event;
+       if (mesg.event == PM_EVENT_PRETHAW)
+               mesg.event = PM_EVENT_FREEZE;
+       rqpm.pm_state = mesg.event;

        return ide_do_drive_cmd(drive, &rq, ide_wait);
 }


I fixed that, but then...

Applying patch git-gfs2.patch
patching file CREDITS
patching file Documentation/filesystems/gfs2.txt
patching file MAINTAINERS
patching file fs/Kconfig
Hunk #1 succeeded at 325 (offset 2 lines).
Hunk #2 FAILED at 1933.
1 out of 2 hunks FAILED -- rejects in file fs/Kconfig

-- 
Chuck

