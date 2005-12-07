Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030264AbVLGDNu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030264AbVLGDNu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 22:13:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750981AbVLGDNu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 22:13:50 -0500
Received: from mexforward.lss.emc.com ([168.159.213.200]:65425 "EHLO
	mexforward.lss.emc.com") by vger.kernel.org with ESMTP
	id S1750947AbVLGDNt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 22:13:49 -0500
Message-ID: <C2EEB4E538D3DC48BF57F391F422779321AE8D@srmanning.eng.emc.com>
From: "goggin, edward" <egoggin@emc.com>
To: James Bottomley <James.Bottomley@SteelEye.com>,
       "goggin, edward" <egoggin@emc.com>
Cc: "'Andrew Morton'" <akpm@osdl.org>, Wu Fengguang <wfg@mail.ustc.edu.cn>,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: RE: [SCSI BUG 2.6.15-rc3-mm1] scheduling while atomic on boot tim
	 e
Date: Tue, 6 Dec 2005 22:13:13 -0500 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
X-PMX-Version: 4.7.1.128075, Antispam-Engine: 2.1.0.0, Antispam-Data: 2005.12.6.35
X-PerlMx-Spam: Gauge=, SPAM=1%, Reasons='EMC_FROM_00+ -3, __CT 0, __CT_TEXT_PLAIN 0, __HAS_MSGID 0, __HAS_X_MAILER 0, __IMS_MSGID 0, __IMS_MUA 0, __MIME_TEXT_ONLY 0, __MIME_VERSION 0, __SANE_MSGID 0'
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 

> -----Original Message-----
> From: James Bottomley [mailto:James.Bottomley@SteelEye.com] 
> Sent: Monday, December 05, 2005 3:32 PM
> To: goggin, edward
> Cc: 'Andrew Morton'; Wu Fengguang; 
> linux-kernel@vger.kernel.org; linux-scsi@vger.kernel.org
> Subject: RE: [SCSI BUG 2.6.15-rc3-mm1] scheduling while 
> atomic on boot tim e
> 
> On Fri, 2005-12-02 at 15:35 -0500, goggin, edward wrote:
> > I think this is caused by my patch to scsi_next_command()
> > (on or about 11/11) causing it to call put_device() and
> > invoke the kobject's release() function while in soft
> > interrupt.  My patch should be removed ... although I
> > don't have an alternate solution in mind for the original
> > problem which was an "oops with USB Storage on 2.6.14".
> 
> Yes and no.
> 
> Reverting your patch won't fix the problem because scsi_put_command()
> will then relinquish the last reference to the device and trigger the
> same warning.  Additionally, blk_run_queue now stands a good chance of
> running on a freed queue which could trigger a panic.
> 
> The problem seems to be that device_del() is apparently requiring user
> context, if that's true, this will bite us not only here, but all over
> the place ... in fact the fix might have to be to do the target reap
> through a workqueue.

How about extending kobject_cleanup() to queue to a workqueue if
requested to do so?  Doing so would provide an easy mechanism for
other cases to utilize and they could all share the same workqueue.
Scsi would request certainly request this feature for calls to
scsi_device_dev_release() for its device kobjects.
 
> 
> Regardless, your patch isn't the culprit here, it's just the 
> thing which
> is doing the last put.
> 
> James
> 
> 
> 
