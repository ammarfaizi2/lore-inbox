Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268520AbUI2O1u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268520AbUI2O1u (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 10:27:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268527AbUI2O1k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 10:27:40 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:8330 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S268501AbUI2O0g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 10:26:36 -0400
Subject: Re: Core scsi layer crashes in 2.6.8.1
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
In-Reply-To: <1096467125.2028.11.camel@mulgrave>
References: <1096401785.13936.5.camel@localhost.localdomain>
	 <1096467125.2028.11.camel@mulgrave>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1096464245.15907.27.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 29 Sep 2004 14:24:10 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2004-09-29 at 15:11, James Bottomley wrote:
> What was the oops?
> 
> I have a theory that we should be taking a device reference before
> waking up the error handler, otherwise host removal can race with error
> handling.

The sequence I scribbled down from the console was

        Illegal state transition Cancel->Offline
        Badness in scsi_device_set_state
                scsi_device_set_state
                scsi_unjam_host
                scsi_error_handler
 
        badness in kref_get
                kobject_get, get_device, scsi_request_fn
                blk_insert_request, scsi_queue_insert
                scsi_eh_flush_done_q, scsi_unjam_host
                scsi_error_handler
 
        OOPS scsi_device_dev_release
                device_release
                kobject_cleanup
                kobject_release
                kref_put
                scsi_request_fn

Alan

