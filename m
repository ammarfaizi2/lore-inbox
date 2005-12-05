Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751442AbVLEUcQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751442AbVLEUcQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 15:32:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751438AbVLEUcQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 15:32:16 -0500
Received: from stat9.steeleye.com ([209.192.50.41]:19626 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S1751349AbVLEUcP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 15:32:15 -0500
Subject: RE: [SCSI BUG 2.6.15-rc3-mm1] scheduling while atomic on boot tim e
From: James Bottomley <James.Bottomley@SteelEye.com>
To: "goggin, edward" <egoggin@emc.com>
Cc: "'Andrew Morton'" <akpm@osdl.org>, Wu Fengguang <wfg@mail.ustc.edu.cn>,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
In-Reply-To: <C2EEB4E538D3DC48BF57F391F422779321AE79@srmanning.eng.emc.com>
References: <C2EEB4E538D3DC48BF57F391F422779321AE79@srmanning.eng.emc.com>
Content-Type: text/plain
Date: Mon, 05 Dec 2005 15:31:46 -0500
Message-Id: <1133814706.3395.5.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-12-02 at 15:35 -0500, goggin, edward wrote:
> I think this is caused by my patch to scsi_next_command()
> (on or about 11/11) causing it to call put_device() and
> invoke the kobject's release() function while in soft
> interrupt.  My patch should be removed ... although I
> don't have an alternate solution in mind for the original
> problem which was an "oops with USB Storage on 2.6.14".

Yes and no.

Reverting your patch won't fix the problem because scsi_put_command()
will then relinquish the last reference to the device and trigger the
same warning.  Additionally, blk_run_queue now stands a good chance of
running on a freed queue which could trigger a panic.

The problem seems to be that device_del() is apparently requiring user
context, if that's true, this will bite us not only here, but all over
the place ... in fact the fix might have to be to do the target reap
through a workqueue.

Regardless, your patch isn't the culprit here, it's just the thing which
is doing the last put.

James



