Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267301AbUIJKqP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267301AbUIJKqP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 06:46:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267350AbUIJKqD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 06:46:03 -0400
Received: from wip-ec-wd.wipro.com ([203.101.113.39]:4995 "EHLO
	wip-ec-wd.wipro.com") by vger.kernel.org with ESMTP id S267301AbUIJKp4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 06:45:56 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6603.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: question on fs/read_write.c modification from 2.6.7 to 2.6.8.1
Date: Fri, 10 Sep 2004 16:15:43 +0530
Message-ID: <93AC2F9171509C4C9CFC01009A820FA00177D7D9@blr-ec-msg05.wipro.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: question on fs/read_write.c modification from 2.6.7 to 2.6.8.1
Thread-Index: AcSXJBgofgIGH2rISMSCtqDLPz9GBw==
From: <manjunathg.kondaiah@wipro.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 10 Sep 2004 10:45:44.0633 (UTC) FILETIME=[530E9290:01C49723]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

As per the patch provided to the Bit
keeper(http://linux.bkbits.net:8080/linux-2.6/hist/fs/read_write.c?nav=i
ndex.html|src/|src/fs), the fs/read_write.c has been modified, to quote
"so that the VFS layer is responsible for updating that offset rather
than individual drivers." I am having trouble to understand the logic
for this change.

Firstly, till 2.6.7 any driver implementation of a read or write would
have been :

int driver_read(struct file *file, char *buffer, size_t count, loff_t *
ppos){...}

and In the implementation, the driver would be interested in checking
the sanity of pointers by doing a check like if (ppos !=  &(file->fpos)
{ printk( KERN_ERR "Pointers not matching\n");return -EPERM;}

This is no longer possible. But I am unable to understand the rationale
behind this decision. Some of the possible reasons I discarded are:

1.  "so that the VFS layer is responsible for updating that offset
rather than individual drivers." By not passing ppos as file->fops, the
drivers should not try and do a (*ppos)++ anymore. Well the determined
rogue driver can still do a file->fpos++ coz the file structure is still
being exposed by the kernel to the driver (verified with printks). So
this option does not sound logical!

2.  Is some sort of optimization taking place by doing this? From the
patch:

-               ret = vfs_read(file, buf, count, &file->f_pos);
+               loff_t pos = file_pos_read(file);
+               ret = vfs_read(file, buf, count, &pos);
+               file_pos_write(file, pos);

For this specific example, the machine instructions would not get
reduced in any way. Arm code wise (objdump), well the function sys_read
increased in size from 54 bytes(2.6.7) to 70 bytes(2.6.8.1)! So I guess
the logic of optimizing the code does not hold good here.

I am unable to think of any other reasons. Could some one guide me in
this regards?

Regards,
Manjunath
