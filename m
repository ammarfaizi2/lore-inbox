Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261188AbVDSIre@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261188AbVDSIre (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Apr 2005 04:47:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261168AbVDSIre
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Apr 2005 04:47:34 -0400
Received: from dspnet.fr.eu.org ([213.186.44.138]:45574 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S261188AbVDSIrc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Apr 2005 04:47:32 -0400
Date: Tue, 19 Apr 2005 10:47:30 +0200
From: Olivier Galibert <galibert@pobox.com>
To: "Hack inc." <linux-kernel@vger.kernel.org>
Subject: Can a non-sg scsi write command be more than PAGE_SIZE length?
Message-ID: <20050419084730.GA96767@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	"Hack inc." <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

...or more importantly, is it allowed.  Kernel is FC3 2.6.10-1.766.

The latest iscsi driver[1] blows on a 32K-long request for a tape write
which followed this path:

 [<f8cef985>] iscsi_queuecommand+0x161/0x2f1 [iscsi_tcp]
 [<f883f724>] scsi_dispatch_cmd+0x1e9/0x24f [scsi_mod]
 [<f88440ff>] scsi_request_fn+0x29a/0x310 [scsi_mod]
 [<c0217487>] blk_insert_request+0x8b/0x9e
 [<f88430b8>] scsi_insert_special_req+0x20/0x26 [scsi_mod]
 [<f8cc043e>] st_do_scsi+0x111/0x147 [st]
 [<f8cc026c>] st_sleep_done+0x0/0xc1 [st]
 [<f8cc189b>] st_write+0x3eb/0x671 [st]
 [<c0152484>] vfs_write+0xb6/0xe2
 [<c015254e>] sys_write+0x3c/0x62
 [<c0103c97>] syscall_call+0x7/0xb

The command is not using scatter-gather (sc->use_sg is 0) but is more
than PAGE_SIZE, and the driver hates that.  So my question is whether
it's allowed (then I'll have to fix the driver, not sure many people
have virtual tapes over iscsi) or whether st_write has to be fixed.

  OG.

[1] 5.0.0.2.
