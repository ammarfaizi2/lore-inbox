Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265059AbTFCPeT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 11:34:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265063AbTFCPeT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 11:34:19 -0400
Received: from mail.dsvr.co.uk ([212.69.192.9]:55264 "EHLO mail.dsvr.co.uk")
	by vger.kernel.org with ESMTP id S265059AbTFCPeM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 11:34:12 -0400
Message-ID: <3EDCC31C.4080207@dsvr.net>
Date: Tue, 03 Jun 2003 16:47:40 +0100
From: Nick Burrett <nick@dsvr.net>
Organization: Designer Servers Ltd
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4b) Gecko/20030508
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.4.20 /proc/partitions corruption with many partitions
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm finding it difficult to create more than, say 80, logical partitions 
on a server.  The symptoms are that lvcreate keeps segfaulting.  The 
reason is that /proc/partitions contains invalid data.

I initially wondered whether it might be the device naming convention 
since when we go above 26 logical paritions we start writing out lvm{, 
lvm}, lvm[ etc. so I added the following patch to write out the devices 
as digits but this didn't have any effect.

--- fs/partitions/check.c 2002-11-28 23:53:15.000000000 +0000
+++ fs/partitions/check.c  2003-06-03 14:43:19.000000000 +0100
@@ -148,6 +148,7 @@ char *disk_name (struct gendisk *hd, int
                         maj = "hd";
                         break;
                 case MD_MAJOR:
+               case LVM_BLK_MAJOR:
                         sprintf(buf, "%s%d", maj, unit);
                         return buf;
         }


This is quite easy to replicate, just create many logical volumes until 
lvcreate fails e.g.

$ lvcreate -L 10M -n foo01 vol01
etc.

The attached file is simply the output of:

$ cat /proc/partitions >/root/foo.txt

Any thoughts ?


Regards,


Nick.

