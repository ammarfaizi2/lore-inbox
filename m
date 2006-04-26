Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750920AbWDZGtQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750920AbWDZGtQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 02:49:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750923AbWDZGtQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 02:49:16 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:63157 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750909AbWDZGtP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 02:49:15 -0400
Message-ID: <444F197A.5020907@in.ibm.com>
Date: Wed, 26 Apr 2006 12:25:54 +0530
From: Suzuki <suzuki@in.ibm.com>
Organization: IBM Software Labs
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
CC: akpm@osdl.org
Subject: [PATCH] drivers/scsi : Fix proc_scsi_write to return "length" on
 success with remove-single-device case
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


proc_scsi_write doesn't return the "length" upon successfully removing a 
device; instead it returns 0. This causes commands like "echo" to redo 
the write(), which ends up in something like,

$ echo "scsi remove-single-device 0 0 3 0" > /proc/scsi/scsi
"-bash: echo: write error: No such device or address"

, eventhough the device was removed.

Attached here is a patch to fix the issue.



* Fix proc_scsi_write to return "length" in remove-single-device case.


Signed-Off-by: Suzuki K P <suzuki@in.ibm.com>

--- linux-2.6.17-rc2-I/drivers/scsi/scsi_proc.c 2006-04-19 
07:59:36.000000000 -0700
+++ linux-2.6.17-rc2-I/drivers/scsi/scsi_proc.new.c     2006-04-26 
04:33:50.000000000 -0700
@@ -282,6 +282,8 @@ static ssize_t proc_scsi_write(struct fi
                 lun = simple_strtoul(p + 1, &p, 0);

                 err = scsi_remove_single_device(host, channel, id, lun);
+               if (!err)
+                       err = length;
         }

   out:







Thanks,

Suzuki K P
Linux Technology Centre,
IBM Software Labs.
