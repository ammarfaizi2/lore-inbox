Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265060AbUGHWPY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265060AbUGHWPY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 18:15:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265037AbUGHWPX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 18:15:23 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:53680 "EHLO
	out2.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S265060AbUGHWPL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 18:15:11 -0400
X-Sasl-enc: tHgosqDxsaB0PMm3lCZ9uA 1089324909
Message-ID: <00f601c46539$0bdf47a0$e6afc742@ROBMHP>
From: "Rob Mueller" <robm@fastmail.fm>
To: <linux-kernel@vger.kernel.org>
Cc: "Chris Mason" <mason@suse.com>
Subject: Processes stuck in unkillable D state (now seen in 2.6.7-mm6)
Date: Thu, 8 Jul 2004 15:15:12 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2149
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2149
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an update to a thread I started last week about processes getting 
stuck in D state.

About 2 days ago, we upgraded to 2.6.7-mm6. Things have generally been 
running fine, but today again, some processes got stuck in an unkillable D 
state. This time, rather than 1 process getting stuck however, about 20 got 
stuck in a relatively short period of time (seems to have been over about 
half an hour). All of processes are cyrus imapd processes.

I've tried to get sysreq-t output, but as this machine is still up and 
running, it has about 2500 processes on it, and I can't seem to get 
consistent sysreq-t output. I set the kernel log buffer size to 17 (128k) 
but that definitely doesn't seem to be enough. I notice that it also seems 
to dump to /var/log/messages, and I get more output there, but it still 
doesn't seem to be a complete process list, and each time I do a sysreq-t, I 
get a different number of procs (though always incomplete) in the output. 
Anyway, I've done sysreq-t twice, and got the output from dmesg -s 1000000 
and /var/log/messages. Since the output is so big, I've put them, and the 
kernel config here:

http://robm.fastmail.fm/kernel/t1/

Process ID's that are definitely stuck are:

1013, 13389, 13469, 16056, 17340, 18489, 21341, 22661, 23976, 29138, 29752, 
30330, 31106, 31956, 32559, 32575, 3753, 5926, 6052, 8857, 9914

But as mentioned above, you won't find most of these in the sysreq-t output, 
I presume because the buffer isn't big enough. Still, hopefully the ones you 
can see there will be some useful information. (FYI, searching for imapd\s+D 
in the sysreq-t output rather than the individual pids seems to be a quicker 
way of finding the problem procs)

Having a quick look myself, there are some odd things there though. For 
instance, from sysreqmsglog1.txt

   imapd         D F1778660     0  3753   1906          3754   809 (NOTLB)
   eb15adb8 00000086 00000020 f1778660 c0310318 c43fc600 08155888 0000002d
          f567d380 f7b97480 c42c3d20 00000000 0001ece6 6051d45f 00007c67 
c42c3d20
          c03d8180 f1778660 f1778810 f78ad9cc 00000003 f78ad9cc f78ad9cc 
c025d40c
   Call Trace:
    [<c0310318>] memcpy_fromiovec+0x38/0x60
    [<c025d40c>] generic_unplug_device+0x2c/0x40
    [<c037a288>] io_schedule+0x28/0x40
    [<c012e17c>] __lock_page+0xbc/0xe0
    [<c012deb0>] page_wake_function+0x0/0x50
    [<c012deb0>] page_wake_function+0x0/0x50
    [<c012f1a1>] filemap_nopage+0x231/0x360
    [<c013dd58>] do_no_page+0xb8/0x3a0
    [<c013bbbb>] pte_alloc_map+0xdb/0xf0
    [<c013e1ee>] handle_mm_fault+0xbe/0x1a0
    [<c0112c62>] do_page_fault+0x172/0x5ec
    [<c012435b>] do_sigaction+0x19b/0x210
    [<c0120dac>] update_process_times+0x2c/0x40
    [<c0110230>] smp_apic_timer_interrupt+0x140/0x150
    [<c0112af0>] do_page_fault+0x0/0x5ec
    [<c0104b19>] error_code+0x2d/0x38

   imapd         D E59812C0     0 22661   1906         23248 22592 (NOTLB)
   d54f5db8 00000086 f7b7de18 e59812c0 d54f5d94 c04b0dc0 00000020 00000000
          c42c3060 f71696f0 c42c3d20 00000000 0002cda6 891b682d 00007b15 
c42c3d20
          f71696f0 e59812c0 e5981470 00000003 c025d3bb f78ad9cc f78ad9cc 
c025d40c
   Call Trace:
    [<c025d3bb>] __generic_unplug_device+0x1b/0x40
    [<c025d40c>] generic_unplug_device+0x2c/0x40
    [<c037a288>] io_schedule+0x28/0x40
    [<c012e17c>] __lock_page+0xbc/0xe0
    [<c012deb0>] page_wake_function+0x0/0x50
    [<c012deb0>] page_wake_function+0x0/0x50
    [<c012f1a1>] filemap_nopage+0x231/0x360
    [<c013dd58>] do_no_page+0xb8/0x3a0
    [<c013bbbb>] pte_alloc_map+0xdb/0xf0
    [<c013e1ee>] handle_mm_fault+0xbe/0x1a0
    [<c0112af0>] do_page_fault+0x0/0x5ec
    [<c0104a5a>] apic_timer_interrupt+0x1a/0x20
    [<c0112c62>] do_page_fault+0x172/0x5ec
    [<c012435b>] do_sigaction+0x19b/0x210
    [<c0124693>] sys_rt_sigaction+0x53/0x90
    [<c030c631>] sys_socketcall+0x111/0x200
    [<c0112af0>] do_page_fault+0x0/0x5ec
    [<c0104b19>] error_code+0x2d/0x38

Those calls into "generic_unplug_device" look really strange to me...

Rob

