Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268776AbUHTWJY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268776AbUHTWJY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 18:09:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268775AbUHTWJY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 18:09:24 -0400
Received: from mail.oddpost.com ([64.147.164.83]:42632 "EHLO mail.oddpost.com")
	by vger.kernel.org with ESMTP id S268774AbUHTWJV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 18:09:21 -0400
Message-ID: <31600492.1093039749993.JavaMail.www-data@c006>
Date: Fri, 20 Aug 2004 15:09:09 -0700 (PDT)
From: pete@oddpost.com
Reply-To: pete@oddpost.com
To: linux-kernel@vger.kernel.org
Subject: kernel BUG at fs/jbd/checkpoint.c:613!
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Client-IP: 216.145.63.146
X-Mailer: Oddpost 1.3.218
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello list, 
  
I had a fileserver hang on me with the following call trace: 
  
Aug 20 11:04:18 c015 kernel: ------------[ cut here ]------------ 
Aug 20 11:04:18 c015 kernel: kernel BUG at fs/jbd/checkpoint.c:613! 
Aug 20 11:04:18 c015 kernel: invalid operand: 0000 [#1] 
Aug 20 11:04:18 c015 kernel: PREEMPT SMP 
Aug 20 11:04:18 c015 kernel: CPU:    0 
Aug 20 11:04:18 c015 kernel: EIP:    0060:[__crc_free_netdev+4141845/4627408]    Not tainted 
Aug 20 11:04:18 c015 kernel: EFLAGS: 00010246   (2.6.5-1-686-smp) 
Aug 20 11:04:18 c015 kernel: EIP is at __journal_drop_transaction+0x124/0x2bc [jbd] 
Aug 20 11:04:18 c015 kernel: eax: 00000071   ebx: cdd5eea0   ecx: c2430be0   edx: c02bb4a4 
Aug 20 11:04:18 c015 kernel: esi: c2790000   edi: c2790000   ebp: 00000011   esp: c263ddc4 
Aug 20 11:04:18 c015 kernel: ds: 007b   es: 007b   ss: 0068 
Aug 20 11:04:18 c015 kernel: Process kjournald (pid: 153, threadinfo=c263c000 task=c2590ca0) 
Aug 20 11:04:18 c015 kernel: Stack: f889d780 f889d944 f889d747 00000265 f889d9e5 cdd5eea0 00000000 f889801a 
Aug 20 11:04:18 c015 kernel:        c2790000 cdd5eea0 c263c000 c2790000 00000001 00000000 c2790014 c27900c0 
Aug 20 11:04:18 c015 kernel:        c2790078 cdd5eef4 c2790054 cdd5eef0 c279003c cdd5eed4 f70fc120 c263de60 
Aug 20 11:04:18 c015 kernel: Call Trace: 
Aug 20 11:04:18 c015 kernel:  [__crc_free_netdev+4136299/4627408] journal_commit_transaction+0x12ba/0x1340 [jbd] 
Aug 20 11:04:18 c015 kernel:  [autoremove_wake_function+0/64] autoremove_wake_function+0x0/0x40 
Aug 20 11:04:18 c015 kernel:  [autoremove_wake_function+0/64] autoremove_wake_function+0x0/0x40 
Aug 20 11:04:18 c015 kernel:  [load_balance+1040/1192] load_balance+0x410/0x4a8 
Aug 20 11:04:18 c015 kernel:  [schedule+1415/1648] schedule+0x587/0x670 
Aug 20 11:04:18 c015 kernel:  [__wake_up_common+51/76] __wake_up_common+0x33/0x4c 
Aug 20 11:04:18 c015 kernel:  [del_timer_sync+43/296] del_timer_sync+0x2b/0x128 
Aug 20 11:04:18 c015 kernel:  [__crc_free_netdev+4145214/4627408] kjournald+0xfd/0x320 [jbd] 
Aug 20 11:04:18 c015 kernel:  [__crc_free_netdev+4144961/4627408] kjournald+0x0/0x320 [jbd] 
Aug 20 11:04:18 c015 kernel:  [autoremove_wake_function+0/64] autoremove_wake_function+0x0/0x40 
Aug 20 11:04:18 c015 kernel:  [autoremove_wake_function+0/64] autoremove_wake_function+0x0/0x40 
Aug 20 11:04:18 c015 kernel:  [__crc_free_netdev+4144945/4627408] gcc2_compiled.+0x0/0xc [jbd] 
Aug 20 11:04:18 c015 kernel:  [kernel_thread_helper+5/12] kernel_thread_helper+0x5/0xc 
Aug 20 11:04:18 c015 kernel: 
Aug 20 11:04:18 c015 kernel: Code: 0f 0b 65 02 47 d7 89 f8 83 c4 14 90 83 7b 28 00 74 2a 68 20 
Aug 20 11:04:18 c015 kernel:  <6>note: kjournald[153] exited with preempt_count 1 

  
c015:~# uname -a 
Linux c015 2.6.5-1-686-smp #1 SMP Fri Apr 9 14:17:07 CEST 2004 i686 unknown 
  
The machine has a RAID 10 configuration. Upon restart it came up with a degraded array. 
  
3ware Storage Controller device driver for Linux v1.02.00.037. 
3w-xxxx: AEN: ERROR: Unit degraded: Unit #1. 
scsi0 : Found a 3ware Storage Controller at 0x3080, IRQ: 48, P-chip: 1.3 
scsi0 : 3ware Storage Controller 
Using anticipatory io scheduler 
  Vendor: 3ware     Model: Logical Disk 1    Rev: 1.0 
  Type:   Direct-Access                      ANSI SCSI revision: 00 
  
This server is a fileserver running nfs-kernel-server 1.0.6. 
  
Would a kernel upgrade help? Please let me know if I can provide any further information. 
  
TIA 
  
-Pete 
  
PS. Please cc: me, as I am not subscribed to the list. 
