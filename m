Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131245AbQKIVfc>; Thu, 9 Nov 2000 16:35:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131299AbQKIVfX>; Thu, 9 Nov 2000 16:35:23 -0500
Received: from BAdial25.eurotel.sk ([194.154.226.88]:13060 "EHLO
	trillian.eunet.sk") by vger.kernel.org with ESMTP
	id <S131262AbQKIVfN>; Thu, 9 Nov 2000 16:35:13 -0500
Date: Thu, 9 Nov 2000 22:32:16 +0100
From: Stanislav Meduna <stano@trillian.eunet.sk>
To: linux-kernel@vger.kernel.org
Subject: Lockup in fdatasync
Message-ID: <20001109223216.A1863@trillian.eunet.sk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

just installed 2.4.0-test10 on a SMP Intel machine and got
following:

NMI Watchdog detected LOCKUP on CPU1, registers:
CPU:    1
EIP:    0010:[<c01c7162>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00000086
eax: 00000307   ebx: 00000206   ecx: 00000007   edx: 003f03af
esi: 00000307   edi: 0000000c   ebp: 0001178e   esp: c77efed8
ds: 0018   es: 0018   ss: 0018
Process syslogd (pid: 408, stackpage=c77ef000)
Stack: c7330ae0 00000002 c015fb01 00000307 c7330ae0 00000000 00000001 c7330ae0 
       00000007 c015fcc3 00000001 c7330ae0 c7330a20 c11f3a0c 00000000 c777b2fc 
       00000400 c0124a25 00000001 00000001 c77eff30 c11e8b00 c7330ae0 c0124ade 
Call Trace: [<c015fb01>] [<c015fcc3>] [<c0124a25>] [<c0124ade>] [<c0124b4d>] [<c01249ec>] [<c015117d>] 
       [<c0132c9e>] [<c010a7db>] 
Code: 80 3d a4 50 20 c0 00 f3 90 7e f5 e9 b7 7c f9 ff 80 3d 84 13 

>>EIP; c01c7162 <stext_lock+347e/7d7c>   <=====
Trace; c015fb01 <generic_make_request+c5/118>
Trace; c015fcc3 <ll_rw_block+16f/1e4>
Trace; c0124a25 <writeout_one_page+39/50>
Trace; c0124ade <do_buffer_fdatasync+62/b4>
Trace; c0124b4d <generic_buffer_fdatasync+1d/38>
Trace; c01249ec <writeout_one_page+0/50>
Trace; c015117d <ext2_sync_file+55/108>
Trace; c0132c9e <sys_fsync+4a/68>
Trace; c010a7db <system_call+33/38>
Code;  c01c7162 <stext_lock+347e/7d7c>
00000000 <_EIP>:
Code;  c01c7162 <stext_lock+347e/7d7c>   <=====
   0:   80 3d a4 50 20 c0 00      cmpb   $0x0,0xc02050a4   <=====
Code;  c01c7169 <stext_lock+3485/7d7c>
   7:   f3 90                     repz nop 
Code;  c01c716b <stext_lock+3487/7d7c>
   9:   7e f5                     jle    0 <_EIP>
Code;  c01c716d <stext_lock+3489/7d7c>
   b:   e9 b7 7c f9 ff            jmp    fff97cc7 <_EIP+0xfff97cc7> c015ee29 <blk_get_queue+9/54>
Code;  c01c7172 <stext_lock+348e/7d7c>
  10:   80 3d 84 13 00 00 00      cmpb   $0x0,0x1384


After this the sync hangs on wait_on_buffer and any access
to /var/log/messages hangs on lock_page. The system is
otherwise living (hope to see it living after a reboot
too... :-().

What I was doing at the time is difficult to say exactly,
but I was playing with modules, loading and unloading
them (I wanted to make sure that I have compiled all
I needed and I was also testing modules.conf configuration) -
mainly ppa, iso9660 and such. The ppa driver need quite
long to attach to the parport ZIP drive - after what
time the lockup detector kicks in?

There was no such problem prior and including -test8,
so it happened somewhere in test9 or 10. I vaguely remember
some discussion regarding datasync in the l-k - maybe this
is related?

Regards
-- 
                                 Stano

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
