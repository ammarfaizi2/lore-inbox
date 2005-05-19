Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262454AbVESCuV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262454AbVESCuV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 22:50:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262453AbVESCuV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 22:50:21 -0400
Received: from szxga03-in.huawei.com ([61.144.161.55]:4516 "EHLO huawei.com")
	by vger.kernel.org with ESMTP id S262454AbVESCuN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 22:50:13 -0400
Date: Thu, 19 May 2005 10:46:53 +0800
From: steve <lingxiang@huawei.com>
Subject: why nfs server delay 10ms in nfsd_write()?
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "zhangtiger@huawei.com" <zhangtiger@huawei.com>,
       "lingxiang@huawei.com" <lingxiang@huawei.com>
Message-id: <0IGP00IZRULADZ@szxml02-in.huawei.com>
MIME-version: 1.0
X-Mailer: Foxmail 4.2 [cn]
Content-type: text/plain; charset=GB2312
Content-transfer-encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all£¬
when i build nfs server with linux 2.6.9, i found nfs write performance is very low, and with 
tcpdump, i found the time to process write is very long, please refer as follows:

14:59:22.844977 IP  192.168.0.1.3376789825 >  linux.site.nfs: 660 write [|nfs]
14:59:22.855134 IP  linux.site.nfs >  192.168.0.1.3376789825: reply ok 136 write POST: [|nfs]

the write operation cost nearly 10ms, so i look up the source code and find the following code 
in nfsd_write():

{
..
if (atomic_read(&inode-> i_writecount) >  1
    || (last_ino == inode-> i_ino && last_dev == inode-> i_sb-> s_dev)) {
dprintk("nfsd: write defer %d\n", current-> pid);
set_current_state(TASK_UNINTERRUPTIBLE);
schedule_timeout((HZ+99)/100);
dprintk("nfsd: write resume %d\n", current-> pid);
}
..
}

so it will sleep for 10ms if the condition matches.

i have 2 questions:
1.i don't know why do we have to sleep for 10 ms, why not do sync immediately?
2.what will happen if we don't sleep for 10ms?
when i delete these codes, i get a good result, and the write performace improved from 300KB/s to 18MB/s

Regards!  
Steve
2005-05-19


