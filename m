Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317188AbSFFVxo>; Thu, 6 Jun 2002 17:53:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317202AbSFFVxo>; Thu, 6 Jun 2002 17:53:44 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:32225 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S317188AbSFFVxm>; Thu, 6 Jun 2002 17:53:42 -0400
Date: Thu, 06 Jun 2002 14:53:40 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Panic from 2.4.19-pre9-aa2
Message-ID: <83910000.1023400420@flay>
In-Reply-To: <20020606212028.GA1004@dualathlon.random>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Unable to handle kernel paging request at virtual address fffff85e
>> c648ff38
>> *pde = 00005063
>> Oops: 0000
>> CPU:    3
>> EIP:    0060:[<c648ff38>]    Not tainted
>> Using defaults from ksymoops -t elf32-i386 -a i386
>> EFLAGS: c648e000
>> eax: 00000000   ebx: c623a000   ecx: fffff83e   edx: c623a380
>> esi: 00000001   edi: c0297520   ebp: c0117bf6   esp: c648ff00
>> ds: 0018   es: 0018   ss: 0018
>> Process cpp (pid: 21583, stackpage=c648f000)
>> Stack: c648e000 c63473a0 c634740c 00000000 c01163f8 bfffeed4 c649e000 c648e000 
>>        00000040 c648e000 00000002 c62b75e0 c4ad2f20 c648e000 c648ff60 c0147dad 
>>        00001000 c4ba54e0 c63473a0 000415b4 00000000 c648e000 00000000 00000000 
>> Call Trace: [<c01163f8>] [<c0147dad>] [<c0148180>] [<c013e308>] [<c013e937>] 
>>    [<c0108a7b>] 
>> Code: 60 ff 48 c6 ad 7d 14 c0 00 10 00 00 e0 54 ba c4 a0 73 34 c6 
>> 
>> >> EIP; c648ff38 <END_OF_CODE+6196040/????>   <=====
>> Trace; c01163f8 <do_page_fault+0/670>
>> Trace; c0147dac <pipe_wait+7c/a4>
> 
> ok, so the crash is at pipe_wait+7c. Can you disassemble pipe_wait?
> (shouldn't be very big) (i use gcc 3.1.1 so my assembly wouldn't match)
> apparently a part of the inode got corrupted, and somebody is reading at
> offset 0x20 of a structure inside the inode.

(gdb) disassemble pipe_wait
Dump of assembler code for function pipe_wait:
0xc0147d30 <pipe_wait>: sub    $0x20,%esp
0xc0147d33 <pipe_wait+3>:       push   %ebp
0xc0147d34 <pipe_wait+4>:       push   %edi
0xc0147d35 <pipe_wait+5>:       push   %esi
0xc0147d36 <pipe_wait+6>:       push   %ebx
0xc0147d37 <pipe_wait+7>:       mov    $0xffffe000,%ebx
0xc0147d3c <pipe_wait+12>:      and    %esp,%ebx
0xc0147d3e <pipe_wait+14>:      lea    0x20(%esp,1),%ebp
0xc0147d42 <pipe_wait+18>:      mov    %ebp,%edx
0xc0147d44 <pipe_wait+20>:      mov    0x34(%esp,1),%esi
0xc0147d48 <pipe_wait+24>:      movl   $0x0,0x10(%esp,1)
0xc0147d50 <pipe_wait+32>:      movl   $0x0,0x14(%esp,1)
0xc0147d58 <pipe_wait+40>:      movl   $0x0,0x18(%esp,1)
0xc0147d60 <pipe_wait+48>:      movl   $0x0,0x1c(%esp,1)
0xc0147d68 <pipe_wait+56>:      mov    %ebx,0x14(%esp,1)
0xc0147d6c <pipe_wait+60>:      movl   $0x0,0x20(%esp,1)
0xc0147d74 <pipe_wait+68>:      mov    %ebx,0x24(%esp,1)
0xc0147d78 <pipe_wait+72>:      movl   $0x0,0x28(%esp,1)
0xc0147d80 <pipe_wait+80>:      movl   $0x0,0x2c(%esp,1)
0xc0147d88 <pipe_wait+88>:      movl   $0x1,(%ebx)
0xc0147d8e <pipe_wait+94>:      mov    0xf8(%esi),%eax
0xc0147d94 <pipe_wait+100>:     call   0xc01199c0 <add_wait_queue>
0xc0147d99 <pipe_wait+105>:     lea    0x6c(%esi),%edi
0xc0147d9c <pipe_wait+108>:     mov    %edi,%ecx
0xc0147d9e <pipe_wait+110>:     lock incl 0x6c(%esi)
0xc0147da2 <pipe_wait+114>:     jle    0xc014891b <.text.lock.pipe>
0xc0147da8 <pipe_wait+120>:     call   0xc0117ae8 <schedule>
0xc0147dad <pipe_wait+125>:     mov    0xf8(%esi),%eax
0xc0147db3 <pipe_wait+131>:     mov    %ebp,%edx
0xc0147db5 <pipe_wait+133>:     call   0xc0119a28 <remove_wait_queue>
0xc0147dba <pipe_wait+138>:     movl   $0x0,(%ebx)
0xc0147dc0 <pipe_wait+144>:     mov    %edi,%ecx
0xc0147dc2 <pipe_wait+146>:     lock decl 0x6c(%esi)
0xc0147dc6 <pipe_wait+150>:     js     0xc0148925 <.text.lock.pipe+10>
0xc0147dcc <pipe_wait+156>:     pop    %ebx
0xc0147dcd <pipe_wait+157>:     pop    %esi
0xc0147dce <pipe_wait+158>:     pop    %edi
0xc0147dcf <pipe_wait+159>:     pop    %ebp
0xc0147dd0 <pipe_wait+160>:     add    $0x20,%esp
0xc0147dd3 <pipe_wait+163>:     ret    
End of assembler dump.

> not really sure what could be the problem, it would be interesting to
> see if you can reproduce it. Also if for example you enabled numa-q you
> may want to try to disable it and see if w/o discontigmem the problem
> goes away, if we could isolate it to a config option, it would help a lot.

OK, I'll play around some more and try to build up a pattern.

Not sure why ksymoops is printing c0147dac from the trace, whilst 
the stack says c0147dad, which seems to be the schedule call - 
would make sense, as that's what you just changed?

M.

