Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277655AbRJIAPg>; Mon, 8 Oct 2001 20:15:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277658AbRJIAP1>; Mon, 8 Oct 2001 20:15:27 -0400
Received: from h55p103-2.delphi.afb.lu.se ([130.235.187.175]:12165 "EHLO gin")
	by vger.kernel.org with ESMTP id <S277655AbRJIAPM>;
	Mon, 8 Oct 2001 20:15:12 -0400
Date: Tue, 9 Oct 2001 02:15:41 +0200
To: linux-kernel@vger.kernel.org
Cc: magnusm@0x63.nu
Subject: kupdated oopsed in generic_make_request
Message-ID: <20011009021541.A2265@h55p111.delphi.afb.lu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22i
From: andersg@0x63.nu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I got this oops during boot (after root-fs check, before deamons started).

Running linux 2.4.10 on a dual PII-400 with reiserfs (no reiserfses mounted
at oops) and with lvm1.0.1rc4 (oops might have ocuored during vgscan)

Unable to handle kernel NULL pointer dereference at virtual address 00000000
00000000
*pde = 00000000
Oops: 0000
CPU:    1
EIP:    0010:[<00000000>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010286
eax: 00000000   ebx: 00000000   ecx: c02a97a0   edx: 00000001
esi: d83def60   edi: d83def60   ebp: 00000000   esp: dbf53ee8
ds: 0018   es: 0018   ss: 0018
Process kupdated (pid: 7, stackpage=dbf53000)
Stack: c01907fc c02a97a0 00000001 d83def60 00000000 00000001 d83def60 ffffffff 
       c019084c 00000001 d83def60 00000001 dbf53f58 c013470a 00000001 d83def60 
       d83def60 c021a537 c0134823 dbf53f54 00000001 dbf52000 c021a537 dbf52343 
Call Trace: [<c01907fc>] [<c019084c>] [<c013470a>] [<c0134823>] [<c0114703>] 
            [<c0134685>] [<c01142a0>] [<c0137aab>] [<c0137d85>] [<c010558c>] 
Code:  Bad EIP value.
>>EIP; 00000000 Before first symbol
Trace; c01907fc <generic_make_request+11c/12c>
Trace; c019084c <submit_bh+40/60>
Trace; c013470a <write_locked_buffers+1e/28>
Trace; c0134822 <write_some_buffers+10e/120>
Trace; c0114702 <schedule+3ba/5b8>
Trace; c0134684 <__wait_on_buffer+84/94>
Trace; c01142a0 <schedule_timeout+80/9c>
Trace; c0137aaa <sync_old_buffers+56/8c>
Trace; c0137d84 <kupdate+118/120>
Trace; c010558c <kernel_thread+28/38>


I added this patch to be able to see from which device the request came, but
i havn't been able to reproduce the oops again. would this patch help in
debugging at all? i'm a newbie in kernel-hacking.

--- linux-2.4.10/drivers/block/ll_rw_blk.c	Mon Oct  8 23:43:36 2001
+++ linux-2.4.10-lvm101rc4-gin/drivers/block/ll_rw_blk.c	Mon Oct  8 23:25:35 2001
@@ -885,6 +885,10 @@
 			buffer_IO_error(bh);
 			break;
 		}
+	        if(q->make_request_fn==NULL){
+		        printk(KERN_ERR "make_request_fn was NULL!?! rdev: %s\n",kdevname(bh->b_rdev));
+		        BUG();
+		}
 	} while (q->make_request_fn(q, rw, bh));
 }
 

-- 

//anders/g

