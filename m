Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263947AbUDFSLf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 14:11:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263935AbUDFSLT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 14:11:19 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:12709 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S263928AbUDFSLL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 14:11:11 -0400
Message-ID: <4072F2B7.2070605@us.ibm.com>
Date: Tue, 06 Apr 2004 13:11:03 -0500
From: Brian King <brking@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020827
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: call_usermodehelper hang
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have been running into some kernel hangs due to call_usermodehelper. Looking
at the backtrace, it looks to me like there are deadlock issues with adding
devices from work queues. Attached is a sample backtrace from one of the
hangs I experienced. My question is why does call_usermodehelper do 2 different
things depending on whether or not it is called from the kevent task? It appears
that the simple way to fix the hang would be to never have call_usermodehelper
use a work_queue since it must be called from process context anyway, or
am I missing something?


0xc0000000017df300        1        0  0    0   D  0xc0000000017df7b0  swapper
            SP(esp)            PC(eip)      Function(args)
0xc00000003fc9f460  0x0000000000000000  NO_SYMBOL or Userspace
0xc00000003fc9f4f0  0xc000000000058c40  .schedule +0xb4
0xc00000003fc9f5c0  0xc00000000005a464  .wait_for_completion +0x138
0xc00000003fc9f6c0  0xc00000000007c594  .call_usermodehelper +0x104
0xc00000003fc9f810  0xc00000000022d3e8  .kobject_hotplug +0x3c4
0xc00000003fc9f900  0xc00000000022d67c  .kobject_add +0x134
0xc00000003fc9f9a0  0xc00000000012b3d8  .register_disk +0x70
0xc00000003fc9fa40  0xc00000000027dfe4  .add_disk +0x60
0xc00000003fc9fad0  0xc0000000002dc7dc  .sd_probe +0x290
0xc00000003fc9fb80  0xc00000000026fbe8  .bus_match +0x94
0xc00000003fc9fc10  0xc00000000026ff70  .driver_attach +0x8c
0xc00000003fc9fca0  0xc000000000270104  .bus_add_driver +0x110
0xc00000003fc9fd50  0xc000000000270a18  .driver_register +0x38
0xc00000003fc9fdd0  0xc0000000002cd8f8  .scsi_register_driver +0x28
0xc00000003fc9fe50  0xc0000000004941d8  .init_sd +0x8c
0xc00000003fc9fee0  0xc00000000000c720  .init +0x25c
0xc00000003fc9ff90  0xc0000000000183ec  .kernel_thread +0x4c

0xc00000003fab3380        4        1  0    0   D  0xc00000003fab3830  events/0
            SP(esp)            PC(eip)      Function(args)
0xc00000003faaf6e0  0x0000000000000000  NO_SYMBOL or Userspace
0xc00000003faaf770  0xc000000000058c40  .schedule +0xb4
0xc00000003faaf840  0xc00000000022fa20  .rwsem_down_write_failed +0x14c
0xc00000003faaf910  0xc00000000026fed0  .bus_add_device +0x11c
0xc00000003faaf9b0  0xc00000000026e288  .device_add +0xd0
0xc00000003faafa50  0xc0000000002cdb00  .scsi_sysfs_add_sdev +0x8c
0xc00000003faafb00  0xc0000000002cbff8  .scsi_probe_and_add_lun +0xb04
0xc00000003faafc00  0xc0000000002ccca0  .scsi_add_device +0x90
0xc00000003faafcb0  0xc0000000002d9458  .ipr_worker_thread +0xc60
0xc00000003faafdc0  0xc00000000007cd9c  .worker_thread +0x268
0xc00000003faafee0  0xc0000000000839cc  .kthread +0x160
0xc00000003faaff90  0xc0000000000183ec  .kernel_thread +0x4c



-- 
Brian King
eServer Storage I/O
IBM Linux Technology Center



-- 
Brian King
eServer Storage I/O
IBM Linux Technology Center

