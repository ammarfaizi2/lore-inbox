Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263937AbUEMIWX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263937AbUEMIWX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 04:22:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263944AbUEMIWX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 04:22:23 -0400
Received: from shosh.galileo.co.il ([199.203.130.250]:47015 "EHLO
	il.marvell.com") by vger.kernel.org with ESMTP id S263970AbUEMIWP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 04:22:15 -0400
Message-ID: <40A33016.7010805@il.marvell.com>
Date: Thu, 13 May 2004 11:21:42 +0300
From: Mark Mokryn <markm@il.marvell.com>
Organization: Marvell Semiconductor
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.4) Gecko/20030624 Netscape/7.1 (ax)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-scsi@vger.kernel.org
CC: linux-kernel@vger.kernel.org, andmike@us.ibm.com,
       Jeff Garzik <jgarzik@pobox.com>
Subject: Problem in SCSI error handling 2.4/2.6
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

According to the SCSI spec, a LUN may abort all outstanding commands in 
case of an error (bit QERR set in the control mode page).
This may occur on many SCSI/FC drives or storage systems, and will 
certainly the case for SATA (libata) when dealing with NCQ or TCQ drives.

The problem is that the Linux SCSI error handler (2.4 & 2.6) identically 
handles commands failed due to MEDIUM_ERROR and ABORTED_COMMAND by 
marking both types as NEEDS_RETRY.

What we have seen in such a case is that the error handler will simply 
requeue these commands, and in most cases, the exact scenario (several 
commands requeued and then aborted due to a single medium error) will be 
repeated ad nauseum until the retry limit. The result is often that all 
of the aborted commands are needlessly failed.

The correct fix is to never retry commands failed due to medium error. 
Rest assured that when a drive returns this status, exhaustive retries 
and error correction algorithms have been applied at the drive level. No 
storage system has the incentive of returning medium error if the error 
is recoverable.

If the error handler insists on retrying such commands, then at least 
set a lower retry limit on medium errors (though I believe this is 
pointless, and may just cause more aborted commands).

In any case - setting the same retry limit on medium errors and aborted 
commands is a bug.

-Mark



