Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290713AbSCGC1D>; Wed, 6 Mar 2002 21:27:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290796AbSCGC05>; Wed, 6 Mar 2002 21:26:57 -0500
Received: from e21.nc.us.ibm.com ([32.97.136.227]:9164 "EHLO e21.nc.us.ibm.com")
	by vger.kernel.org with ESMTP id <S290713AbSCGC0T>;
	Wed, 6 Mar 2002 21:26:19 -0500
Message-ID: <3C86CFC4.6050800@us.ibm.com>
Date: Wed, 06 Mar 2002 18:26:12 -0800
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8+) Gecko/20020227
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Andrew Morton <akpm@zip.com.au>, Alexander Viro <viro@math.psu.edu>
Subject: Oops on 2.5.6-pre2 in ext2 code
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton was getting errors like this when running dbench:
__block_prepare_write: zeroing uptodate buffer!
http://www.uwsg.iu.edu/hypermail/linux/kernel/0202.2/1585.html

His problems were on a uniproc machine, running a "dbench 64" on a 
~120meg ext2 filesystem with 1k blocks.  When running the same test on 
my dual-proc machine, I always oops after a short period of time.  The 
presence of ext2_get_block in the trace seems to indicate that it could 
be related to the recent ext2 locking changes in 2.5.

I haven't been able to reproduce the same errors in 2.4, even with the 
ext2_get_block() BKL removal patch applied.  It is probably influenced 
by, but not caused exclusively by that patch from 2.5.

CPU:    0
EIP:    0010:[<c013b6c0>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010202
eax: d695c080   ebx: c13e1bec   ecx: d695c080   edx: 01010101
esi: c13e1bec   edi: 00000400   ebp: 01000000   esp: d96d1eac
ds: 0018   es: 0018   ss: 0018
Stack: 0000000a c013b999 c13e1bec 00000400 00000000 d695c000 d96d1ed4 
00000400
        d6781b60 c013b056 d6781b60 c013bcb3 00000282 00001000 0001595c 
00000282
        c13e1bec 00001000 d56ed3c0 c13e1bec c013c251 d1cc3cd0 c13e1bec 
00000000
Call Trace: [<c013b999>] [<c013b056>] [<c013bcb3>] [<c013c251>] 
[<c015fc10>]
    [<c012c6cb>] [<c015fc10>] [<c0138fa6>] [<c0114ac9>] [<c0108ce7>]
Code: c7 42 38 00 00 00 00 89 d1 8b 52 28 85 d2 75 f0 89 41 28 89

 >>EIP; c013b6c0 <create_empty_buffers+30/50>   <=====
Trace; c013b999 <__block_prepare_write+79/2e0>
Trace; c013b056 <balance_dirty+6/50>
Trace; c013bcb3 <__block_commit_write+b3/e0>
Trace; c013c251 <block_prepare_write+21/40>
Trace; c015fc10 <ext2_get_block+0/470>
Trace; c012c6cb <generic_file_write+4ab/710>
Trace; c015fc10 <ext2_get_block+0/470>
Trace; c0138fa6 <sys_write+96/110>
Trace; c0114ac9 <schedule+329/380>
Trace; c0108ce7 <syscall_call+7/b>

Code;  c013b6c0 <create_empty_buffers+30/50>
00000000 <_EIP>:
Code;  c013b6c0 <create_empty_buffers+30/50>   <=====
    0:   c7 42 38 00 00 00 00      movl   $0x0,0x38(%edx)   <=====
Code;  c013b6c7 <create_empty_buffers+37/50>
    7:   89 d1                     mov    %edx,%ecx
Code;  c013b6c9 <create_empty_buffers+39/50>
    9:   8b 52 28                  mov    0x28(%edx),%edx
Code;  c013b6cc <create_empty_buffers+3c/50>
    c:   85 d2                     test   %edx,%edx
Code;  c013b6ce <create_empty_buffers+3e/50>
    e:   75 f0                     jne    0 <_EIP>
Code;  c013b6d0 <create_empty_buffers+40/50>
   10:   89 41 28                  mov    %eax,0x28(%ecx)
Code;  c013b6d3 <create_empty_buffers+43/50>

-- 
Dave Hansen
haveblue@us.ibm.com

