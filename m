Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964788AbWIKMp5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964788AbWIKMp5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 08:45:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964801AbWIKMp4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 08:45:56 -0400
Received: from liaag2aa.mx.compuserve.com ([149.174.40.154]:42431 "EHLO
	liaag2aa.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S964788AbWIKMpz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 08:45:55 -0400
Date: Mon, 11 Sep 2006 08:41:02 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: 2.6.18-rc6-mm1
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200609110842_MC3-1-CAD5-5E82@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <20060910221421.1aeac3c9.akpm@osdl.org>

On Sun, 10 Sep 2006 22:14:21 -0700, Andrew Morton wrote:

> > Patch gregkh-driver-pm-pci-and-ide-handle-pm_event_prethaw.patch does not apply (enforce with -f)
>
> It works for me - I expect your tree is out of sync.

Well something is out of sync but I don't think it's me.

Starting over with GPG-verified downloads from kernel.org I get:

$ tar xjf /mnt/t/lib/linux/2.6.17/linux-2.6.17.tar.bz2
$ cd linux-2.6.17
$ bzcat /mnt/t/lib/linux/2.6.18/rc6/patch-2.6.18-rc6.bz2 | patch -p1 -s
$ tar xjf /mnt/t/lib/linux/2.6.18/rc6/mm1/2.6.18-rc6-mm1-broken-out.tar.bz2
$ mv broken-out patches
$ quilt push -a
[...]
Applying patch gregkh-driver-pm-pci-and-ide-handle-pm_event_prethaw.patch
patching file drivers/ide/ide.c
Hunk #2 FAILED at 1221.
1 out of 2 hunks FAILED -- rejects in file drivers/ide/ide.c
patching file drivers/pci/pci.c
Patch gregkh-driver-pm-pci-and-ide-handle-pm_event_prethaw.patch does not apply
(enforce with -f)

And like I said, you can even see that git-block.patch, earlier in the series,
creates this problem:

$ quilt applied | fgrep block
git-block.patch
git-block-hack.patch

This is the failing hunk.  The highlighted context line is wrong because
git-block.patch changed it:

--- gregkh-2.6.orig/drivers/ide/ide.c
+++ gregkh-2.6/drivers/ide/ide.c
@@ -1207,7 +1207,7 @@ int system_bus_clock (void)

 EXPORT_SYMBOL(system_bus_clock);

-static int generic_ide_suspend(struct device *dev, pm_message_t state)
+static int generic_ide_suspend(struct device *dev, pm_message_t mesg)
 {
        ide_drive_t *drive = dev->driver_data;
        struct request rq;
@@ -1221,7 +1221,9 @@ static int generic_ide_suspend(struct de
        rq.special = &args;
        rq.end_io_data = &rqpm;                         <===================
        rqpm.pm_step = ide_pm_state_start_suspend;
-       rqpm.pm_state = state.event;
+       if (mesg.event == PM_EVENT_PRETHAW)
+               mesg.event = PM_EVENT_FREEZE;
+       rqpm.pm_state = mesg.event;

        return ide_do_drive_cmd(drive, &rq, ide_wait);
 }

And here is the piece of git-block.patch that changed it:

--- a/drivers/ide/ide.c
+++ b/drivers/ide/ide.c
@@ -1217,9 +1217,9 @@ static int generic_ide_suspend(struct de
        memset(&rq, 0, sizeof(rq));
        memset(&rqpm, 0, sizeof(rqpm));
        memset(&args, 0, sizeof(args));
-       rq.flags = REQ_PM_SUSPEND;
+       rq.cmd_type = REQ_TYPE_PM_SUSPEND;
        rq.special = &args;
-       rq.end_io_data = &rqpm;
+       rq.data = &rqpm;                                <===================
        rqpm.pm_step = ide_pm_state_start_suspend;
        rqpm.pm_state = state.event;

-- 
Chuck
