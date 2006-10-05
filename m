Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932065AbWJEUcl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932065AbWJEUcl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 16:32:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932075AbWJEUck
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 16:32:40 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:46812 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S932065AbWJEUcj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 16:32:39 -0400
Message-ID: <45256BE2.5040702@in.ibm.com>
Date: Thu, 05 Oct 2006 13:32:34 -0700
From: Suzuki Kp <suzuki@in.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060413 Red Hat/1.7.13-1.4.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Erik Mouw <erik@harddisk-recovery.com>
CC: lkml <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, andmike@us.ibm.com
Subject: [RFC] PATCH to fix rescan_partitions to return errors properly  -
 take 2
References: <452307B4.3050006@in.ibm.com> <20061004130932.GC18800@harddisk-recovery.com> <4523E66B.5090604@in.ibm.com> <20061004170827.GE18800@harddisk-recovery.nl> <4523F16D.5060808@in.ibm.com> <20061005104018.GC7343@harddisk-recovery.nl>
In-Reply-To: <20061005104018.GC7343@harddisk-recovery.nl>
Content-Type: multipart/mixed;
 boundary="------------070409000905090203050101"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070409000905090203050101
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Erik,


Erik Mouw wrote:
> On Wed, Oct 04, 2006 at 10:37:49AM -0700, Suzuki Kp wrote:
> 
>>Erik Mouw wrote:
>>
>>>I disagree. It's perfectly valid for a disk not to have a partition
>>>table (for example: components of a RAID5 MD device) and we shouldn't
>>>scare users about that. Also an unrecognised partition table format
>>>(DEC VMS, Novell Netware, etc.) is not a reason to throw an error, it's
>>>just unrecognised and as far as the kernel knows it's unpartioned.
>>

[...]


Thank you very much for the inputs.

As per the discussion I have made the changes to the patch.

This change needs to be implemented in some of the partition checkers 
which doesn't do that already.

Btw, do you think it is a good idea to let the other partition checkers 
run, even if one of them has failed ?

Right now, the check_partition runs the partition checkers in a 
sequential manner, until it finds a success or an error.


Comments ?

Thanks,

Suzuki


--------------070409000905090203050101
Content-Type: text/x-patch;
 name="fix-rescan_partitions-take2.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fix-rescan_partitions-take2.diff"


* Fix rescan_partition to propagate the low level I/O error.



Signed Off by: Suzuki K P <suzuki@in.ibm.com>

Index: linux-2.6.18/fs/partitions/check.c
===================================================================
--- linux-2.6.18.orig/fs/partitions/check.c     2006-09-26 04:41:55.000000000 +0530
+++ linux-2.6.18/fs/partitions/check.c  2006-10-06 01:22:06.000000000 +0530
@@ -177,7 +177,7 @@
        else if (warn_no_part)
                printk(" unable to read partition table\n");
        kfree(state);
-       return NULL;
+       return ERR_PTR(res);
 }

 /*
@@ -460,6 +460,9 @@
                disk->fops->revalidate_disk(disk);
        if (!get_capacity(disk) || !(state = check_partition(disk, bdev)))
                return 0;
+       if (IS_ERR(state))
+       /* I/O error reading the partition table */
+               return -EIO;
        for (p = 1; p < state->limit; p++) {
                sector_t size = state->parts[p].size;
                sector_t from = state->parts[p].from;

--------------070409000905090203050101--
