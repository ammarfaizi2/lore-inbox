Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161162AbVIPPlz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161162AbVIPPlz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 11:41:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161164AbVIPPly
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 11:41:54 -0400
Received: from mail.portrix.net ([212.202.157.208]:54187 "EHLO
	zoidberg.portrix.net") by vger.kernel.org with ESMTP
	id S1161162AbVIPPly (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 11:41:54 -0400
Message-ID: <432AE79B.80208@ppp0.net>
Date: Fri, 16 Sep 2005 17:41:15 +0200
From: Jan Dittmer <jdittmer@ppp0.net>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050817)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Stern <stern@rowland.harvard.edu>
CC: Pavel Machek <pavel@suse.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>, linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] Re: 2.6.14-rc1 load average calculation broken?
References: <Pine.LNX.4.44L0.0509161104420.4972-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.0509161104420.4972-100000@iolanthe.rowland.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Stern wrote:
> On Fri, 16 Sep 2005, Jan Dittmer wrote:
> 
> 
>>Okay, it happened again. Turns out to be the usb-storage kernel threads:
>>
>>root      3308  0.0  0.0      0     0 ?        D    08:40   0:00 [usb-storage]
>>root      4671  0.0  0.0      0     0 ?        D    08:40   0:00 [usb-storage]
>>
>>I've an USB card reader in my monitor which turns off, when the monitor goes
>>to standby/is shut off. I think I can reproduce it that way, but I'm currently
>>not physically near the machine to check.
>>
>>Any debug info that can help? Last known good kernel was 2.6.13-git6.
>>I don't update that machine that much. ;-)
>>
>>Current kernel is 2.6.14-rc1-git1.
> 
> 
> Can you post a stack dump for those two threads?  Normally they are idle,
> in an interruptible wait, so they shouldn't be in D state.  Since they
> are, maybe there's some sort of error recovery attempt going on.  Like
> hald doing its periodic checking of hotpluggable storage devices while
> your monitor is off.

They don't appear in lsusb or /proc/scsi/scsi anymore, so I don't know what
you mean.

[4327082.342000] usb-storage   D 000F4261     0  3308      1          4671
2487 (L-TLB)
[4327082.342000] ded95f0c c9185a70 c04ae888 000f4261 00000010 ded94000
00000000 cd393840
[4327082.342000]        000f4261 dfabcb98 dfabca70 ce5b2300 000f4261 ded94000
09c67100 00000000
[4327082.342000]        c0410b24 00000286 c0410b2c dfabca70 c03adb5d 00000001
dfabca70 c011a2f0
[4327082.342000] Call Trace:
[4327082.342000]  [<c03adb5d>] __down+0xdd/0x140
[4327082.342000]  [<c011a2f0>] default_wake_function+0x0/0x20
[4327082.342000]  [<c03ac35f>] __down_failed+0x7/0xc
[4327082.342000]  [<c02c5050>] scsi_host_dev_release+0x0/0x90
[4327082.342000]  [<c0134dd4>] .text.lock.kthread+0xb/0x27
[4327082.342000]  [<c02c5087>] scsi_host_dev_release+0x37/0x90
[4327082.342000]  [<c020a4be>] kobject_cleanup+0x4e/0xa0
[4327082.342000]  [<c020a510>] kobject_release+0x0/0x10
[4327082.342000]  [<c020af3f>] kref_put+0x2f/0x80
[4327082.342000]  [<c020a53e>] kobject_put+0x1e/0x30
[4327082.342000]  [<c020a510>] kobject_release+0x0/0x10
[4327082.342000]  [<e0869288>] usb_stor_control_thread+0x68/0x240 [usb_storage]
[4327082.342000]  [<c010322e>] ret_from_fork+0x6/0x14
[4327082.342000]  [<e0869220>] usb_stor_control_thread+0x0/0x240 [usb_storage]
[4327082.342000]  [<e0869220>] usb_stor_control_thread+0x0/0x240 [usb_storage]
[4327082.342000]  [<c01013ad>] kernel_thread_helper+0x5/0x18


[4327082.342000] usb-storage   D 000F4261     0  4671      1          5537
3308 (L-TLB)
[4327082.342000] de5d9f1c ce3f6550 c04ae888 000f4261 00000000 de5d8000
00000000 ce5b2300
[4327082.342000]        000f4261 dfbd36b8 dfbd3590 ce5b2300 000f4261 de5d8000
0717cbc0 00000000
[4327082.342000]        de5d8000 c04c156c c0420dc0 de5d9f40 c03acb51 00000001
dfbd3590 c011a2f0
[4327082.342000] Call Trace:
[4327082.342000]  [<c03acb51>] wait_for_completion+0x91/0x100
[4327082.342000]  [<c011a2f0>] default_wake_function+0x0/0x20
[4327082.342000]  [<c0134daa>] kthread_stop+0x5a/0x79
[4327082.342000]  [<c02c5087>] scsi_host_dev_release+0x37/0x90
[4327082.342000]  [<c020a4be>] kobject_cleanup+0x4e/0xa0
[4327082.342000]  [<c020a510>] kobject_release+0x0/0x10
[4327082.342000]  [<c020af3f>] kref_put+0x2f/0x80
[4327082.342000]  [<c020a53e>] kobject_put+0x1e/0x30
[4327082.342000]  [<c020a510>] kobject_release+0x0/0x10
[4327082.342000]  [<e0869288>] usb_stor_control_thread+0x68/0x240 [usb_storage]
[4327082.342000]  [<c010322e>] ret_from_fork+0x6/0x14
[4327082.342000]  [<e0869220>] usb_stor_control_thread+0x0/0x240 [usb_storage]
[4327082.342000]  [<e0869220>] usb_stor_control_thread+0x0/0x240 [usb_storage]
[4327082.342000]  [<c01013ad>] kernel_thread_helper+0x5/0x18


-- 
Jan
