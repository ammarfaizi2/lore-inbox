Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267835AbUHKAA1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267835AbUHKAA1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 20:00:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267832AbUHJX6z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 19:58:55 -0400
Received: from mta3.srv.hcvlny.cv.net ([167.206.5.69]:65330 "EHLO
	mta3.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S267831AbUHJX6D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 19:58:03 -0400
Date: Tue, 10 Aug 2004 19:56:51 -0400
From: Nathan Bryant <nbryant@optonline.net>
Subject: [PATCH] SCSI midlayer power management
To: "'James Bottomley'" <James.Bottomley@steeleye.com>
Cc: Linux SCSI Reflector <linux-scsi@vger.kernel.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Pavel Machek <pavel@ucw.cz>, jgarzik@pobox.com
Message-id: <411960C3.5090107@optonline.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

This proposed patch implements enough power-management support within 
the SCSI midlayer to get ACPI S3 working on my system. Changes as follows:

* Add generic_scsi_{suspend,resume} methods to scsi.c
* Add suspend and resume callbacks to the scsi_driver structure, and 
implement those callbacks in sd.c
* In sd.c, we call sd_shutdown on suspend, in order to synchronize the 
write-back cache.
* In sd.c, we call sd_rescan from sd_resume in order to ensure that 
drives have spun up and avoid passing not ready errors back to the block 
layer.
* In generic_scsi_suspend, we call scsi_device_quiesce before calling 
the scsi_driver suspend callback. We resume from quiesce state in 
reverse order in generic_scsi_resume.

ACPI S1 and S4/swsusp are untested, but I think there should be no 
regressions with S1. To do S1 properly, we probably need to tell the 
drive to spin down, and I don't know what the SCSI command is for 
that... For S4, the call to scsi_device_quiesce might pose a problem for 
the subsequent state dump to disk. But I'm not sure swsusp ever worked 
for SCSI.

This might help SATA drives, too, but I seem to remember that the SATA 
layer doesn't properly emulate the SYNCHRONIZE_CACHE command.

Comments, anybody? Can this be applied upstream? I think it's a step in 
the right direction.

Applies to scsi-misc-2.6

Nathan
