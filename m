Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264438AbTLKIZ3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 03:25:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264446AbTLKIZ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 03:25:29 -0500
Received: from smtp1.Stanford.EDU ([171.67.16.120]:19930 "EHLO
	smtp1.Stanford.EDU") by vger.kernel.org with ESMTP id S264438AbTLKIZ0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 03:25:26 -0500
Message-ID: <3FD829FE.7070400@myrealbox.com>
Date: Thu, 11 Dec 2003 00:25:34 -0800
From: Andy Lutomirski <luto@myrealbox.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: stuck in D state on smbfs (2.6.0-test11)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi-

I backed up my Subversion repository to an SMB mount (attached to 
Windows XP), then did 'svnadmin dump .' on the backup.  svnadmin is now 
stuck in the D state.  It does not respond to signals.  umount and 
umount -f on the mount both fail with "Device is busy".  Kernel is 
2.6.0-test11 + Nick Piggin's v19 scheduler policy + Jeff Garzik's exp2 
net patches.

Relevant sysrq-t output:

smbiod        S C051DEE0     0  5096      1          5092  4765 (L-TLB)
ccc7ff9c 00000046 c7aad8c0 c051dee0 00000007 ccc7ff84 d0add300 c4284840
        0003148a 00000000 00000000 0007a11e 00000002 0007a114 0000000c 
99127e37
        ccc7e000 ccc7ffc0 ccc7e000 ccc7ffec d0adfb3b cff95680 00000077 
ccc7e000
Call Trace:
  [<d0add300>] smb_recv_available+0x40/0x60 [smbfs]
  [<d0adfb3b>] smbiod+0x8b/0x1af [smbfs]
  [<c011afb0>] default_wake_function+0x0/0x20
  [<d0adfab0>] smbiod+0x0/0x1af [smbfs]
  [<c01082c9>] kernel_thread_helper+0x5/0xc

svnadmin      D C051DEE0   604  5188   4842                4980 (L-TLB)
cb5dfcec 00000046 c7aac660 c051dee0 c051dee0 998dd2ec 00000009 00000000
        00000000 00000000 c8e366e0 0007a011 0000010f 0007a11a 00000006 
9ec7303b
        00000000 c10bcb60 c1280750 cb5dfcf4 c011bf2e cb5dfd4c c0139b08 
c10bcb60
Call Trace:
  [<c011bf2e>] io_schedule+0xe/0x20
  [<c0139b08>] __lock_page+0xa8/0xd0
  [<c011c840>] autoremove_wake_function+0x0/0x50
  [<c011c840>] autoremove_wake_function+0x0/0x50
  [<c0177bb4>] mpage_writepages+0x2d4/0x320
  [<d0aded10>] smb_writepage+0x0/0xd0 [smbfs]
  [<c013f0a5>] do_writepages+0x35/0x40
  [<c013954c>] __filemap_fdatawrite+0xdc/0xf0
  [<c0139579>] filemap_fdatawrite+0x19/0x20
  [<d0adf114>] smb_file_release+0x74/0x90 [smbfs]
  [<c01564a6>] __fput+0x116/0x130
  [<c014a294>] exit_mmap+0x164/0x190
  [<c011caf6>] mmput+0x66/0xc0
  [<c0120b10>] do_exit+0x140/0x3d0
  [<c0120e8b>] do_group_exit+0x7b/0xb0
  [<c012a2cd>] get_signal_to_deliver+0x1ed/0x380
  [<c010a234>] do_signal+0xb4/0xf0
  [<c0149243>] do_mmap_pgoff+0x3d3/0x6a0
  [<c011afb0>] default_wake_function+0x0/0x20
  [<c013295b>] do_futex+0x6b/0x80
  [<c0132a85>] sys_futex+0x115/0x130
  [<c010a2c9>] do_notify_resume+0x59/0x5c
  [<c010a4a6>] work_notifysig+0x13/0x15

Killing smbiod and smbmount had no effect (although both processes died 
successfully).  Resetting the smb connection from the windows side was 
noticed by the kernel (netstat stopped showing the connection), but also 
had no effect on svnadmin.

After killing processes and the connection, 'ls /mnt/win' fails 
gracefully with an i/o error.


Is there anything else I can do to help troubleshoot this?

Thanks,
Andy

Please CC me in replies.
