Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262739AbTCVMPE>; Sat, 22 Mar 2003 07:15:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262741AbTCVMPE>; Sat, 22 Mar 2003 07:15:04 -0500
Received: from csl.Stanford.EDU ([171.64.73.43]:59840 "EHLO csl.stanford.edu")
	by vger.kernel.org with ESMTP id <S262739AbTCVMPD>;
	Sat, 22 Mar 2003 07:15:03 -0500
From: Dawson Engler <engler@csl.stanford.edu>
Message-Id: <200303221226.h2MCQ4110972@csl.stanford.edu>
Subject: [CHECKER] race in 2.5.62/drivers/isdn/i4l/isdn_common.c?
To: linux-kernel@vger.kernel.org
Date: Sat, 22 Mar 2003 04:26:04 -0800 (PST)
Cc: engler@csl.stanford.edu (Dawson Engler)
X-Mailer: ELM [version 2.5 PL0pre8]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Enclosed is a potential race in drv_stat_unload.  It seems suspicious:
	- potentially a use-after-free (if put_drv deallocs)

	- potentially a race where the global var drv->channels is used without
	protection (or is this routine called with drivers_lock held?)

Dawson

/u2/engler/mc/oses/linux/linux-2.5.62/drivers/isdn/i4l/isdn_common.c:636:drv_stat_unload:ERROR:RACE:636:636:unprotected access to variable (*dev).channels,isdn_dev.channels,1[nvars=2] [vars=(*dev).channels,isdn_dev.channels,1:636 (*dev).channels,isdn_dev.channels,1:636 ][non_csect_reads=1] [non_csect_writes=1][modified=1] [locked_uses=1] [unlocked_uses=1] [n_writes=2] [n_reads=3] [n_root=2] [n_file_write=1] [n_file_read=1] [n_unlocked=1][has_locked=1] [depth=1] [path=/u2/engler/mc/oses/linux/linux-2.5.62/drivers/isdn/i4l/isdn_common.c:drv_stat_unload:634->end=/u2/engler/mc/oses/linux/linux-2.5.62/drivers/isdn/i4l/isdn_common.c:drv_stat_unload:636] [score=5] [z=-0.62] [rank=easy]

        spin_lock_irqsave(&drivers_lock, flags);
        drivers[drv->di] = NULL;
        spin_unlock_irqrestore(&drivers_lock, flags);
        put_drv(drv);


Error --->
        dev->channels -= drv->channels;

        isdn_info_update();
        return 0;

