Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261489AbSIWVrh>; Mon, 23 Sep 2002 17:47:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261491AbSIWVrh>; Mon, 23 Sep 2002 17:47:37 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:31893 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S261489AbSIWVrf>;
	Mon, 23 Sep 2002 17:47:35 -0400
Subject: Bug in last night's bk test
From: Paul Larson <plars@linuxtestproject.org>
To: lkml <linux-kernel@vger.kernel.org>, akpm@digeo.com,
       lse-tech@lists.sourceforge.net
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 23 Sep 2002 16:36:41 -0500
Message-Id: <1032817002.24372.138.camel@plars.austin.ibm.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The automated nightly testing turned up a bug on one of the test
machines last night.  The system that had the problem was running ltp
and was a 2-way PII-550, 2GB ram, ext2.  Here is the ksymoops dump:

ksymoops 2.4.5 on i686 2.4.18.  Options used
     -V (default)
     -K (specified)
     -L (specified)
     -O (specified)
     -m System.map (specified)

kernel BUG at ll_rw_blk.c:1802!
invalid operand: 0000
CPU:    0
EIP:    0060:[<c0215971>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010202
eax: 00000080   ebx: f7e3a418   ecx: f7dc8f60   edx: 000000a0
esi: f71f3960   edi: 000000a0   ebp: 00008cd8   esp: ef18bbf0
ds: 0068   es: 0068   ss: 0068
Stack: 00000000 00000000 00000000 0000000c c02159fd f71f3960 ef18bc4c c015b4b1 
       00000000 f71f3960 ef18bc4c c015b683 ef18bc4c 0809d000 ef18bc4c c015bd52 
       ef18bc4c 00000fff f7295a54 00000000 f71db900 ef18bc4c 00014000 f71f3960 
Call Trace: [<c02159fd>] [<c015b4b1>] [<c015b683>] [<c015bd52>] [<c017decc>] 
   [<c0266b05>] [<c02674a3>] [<c0265c78>] [<c0248d20>] [<c0263a16>] [<c024889c>] 
   [<c01157f6>] [<c0214ba0>] [<c012d689>] [<c015be13>] [<c017decc>] [<c017df2e>] 
   [<c017decc>] [<c015be4f>] [<c012e0dd>] [<c012f502>] [<c012f54e>] [<c013f95a>] 
   [<c012e1c0>] [<c012c4c9>] [<c012123b>] [<c013efb0>] [<c013f2af>] [<c013faa6>] 
   [<c0107073>] 
Code: 0f 0b 0a 07 ac a1 36 c0 8d b4 26 00 00 00 00 3b 49 44 74 0b


>>EIP; c0215971 <generic_make_request+e1/118>   <=====

>>ebx; f7e3a418 <END_OF_CODE+3795a15c/????>
>>ecx; f7dc8f60 <END_OF_CODE+378e8ca4/????>
>>esi; f71f3960 <END_OF_CODE+36d136a4/????>
>>ebp; 00008cd8 Before first symbol
>>esp; ef18bbf0 <END_OF_CODE+2ecab934/????>

Trace; c02159fd <submit_bio+55/60>
Trace; c015b4b1 <dio_bio_submit+29/44>
Trace; c015b683 <dio_await_completion+13/44>
Trace; c015bd52 <direct_io_worker+1ce/1f4>
Trace; c017decc <ext2_get_blocks+0/38>
Trace; c0266b05 <ips_send_cmd+685/690>
Trace; c02674a3 <ips_getscb+3f/60>
Trace; c0265c78 <ips_next+718/7d8>
Trace; c0248d20 <scsi_done+0/90>
Trace; c0263a16 <ips_queue+246/2a4>
Trace; c024889c <scsi_dispatch_cmd+ec/17c>
Trace; c01157f6 <schedule+35e/3b0>
Trace; c0214ba0 <blk_run_queues+8c/9c>
Trace; c012d689 <wait_on_page_bit+c1/cc>
Trace; c015be13 <generic_direct_IO+9b/a8>
Trace; c017decc <ext2_get_blocks+0/38>
Trace; c017df2e <ext2_direct_IO+2a/30>
Trace; c017decc <ext2_get_blocks+0/38>
Trace; c015be4f <generic_file_direct_IO+2f/4f>
Trace; c012e0dd <__generic_file_aio_read+f1/1a4>
Trace; c012f502 <generic_file_readv+5e/78>
Trace; c012f54e <generic_file_writev+32/48>
Trace; c013f95a <do_readv_writev+186/278>
Trace; c012e1c0 <generic_file_read+0/88>
Trace; c012c4c9 <do_brk+109/1e4>
Trace; c012123b <update_process_times+27/30>
Trace; c013efb0 <generic_file_llseek+0/d8>
Trace; c013f2af <sys_lseek+6f/98>
Trace; c013faa6 <sys_readv+5a/6c>
Trace; c0107073 <syscall_call+7/b>

Code;  c0215971 <generic_make_request+e1/118>
00000000 <_EIP>:
Code;  c0215971 <generic_make_request+e1/118>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c0215973 <generic_make_request+e3/118>
   2:   0a 07                     or     (%edi),%al
Code;  c0215975 <generic_make_request+e5/118>
   4:   ac                        lods   %ds:(%esi),%al
Code;  c0215976 <generic_make_request+e6/118>
   5:   a1 36 c0 8d b4            mov    0xb48dc036,%eax
Code;  c021597b <generic_make_request+eb/118>
   a:   26 00 00                  add    %al,%es:(%eax)
Code;  c021597e <generic_make_request+ee/118>
   d:   00 00                     add    %al,(%eax)
Code;  c0215980 <generic_make_request+f0/118>
   f:   3b 49 44                  cmp    0x44(%ecx),%ecx
Code;  c0215983 <generic_make_request+f3/118>
  12:   74 0b                     je     1f <_EIP+0x1f> c0215990 <generic_make_request+100/118>


It didn't hang the machine, or crash it.  Just showed up in the logs. 
This error did not show up in the previous night's test.  Please let me
know if any other information would be helpful.

Thanks,
Paul Larson

