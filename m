Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313628AbSFFXgl>; Thu, 6 Jun 2002 19:36:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314101AbSFFXgk>; Thu, 6 Jun 2002 19:36:40 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:15712 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S313628AbSFFXgj>; Thu, 6 Jun 2002 19:36:39 -0400
Date: Fri, 7 Jun 2002 01:36:53 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Panic from 2.4.19-pre9-aa2
Message-ID: <20020606233653.GD1004@dualathlon.random>
In-Reply-To: <80230000.1023396285@flay> <20020606212028.GA1004@dualathlon.random> <99570000.1023405481@flay>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 06, 2002 at 04:18:01PM -0700, Martin J. Bligh wrote:
> > not really sure what could be the problem, it would be interesting to
> > see if you can reproduce it. 
> 
> Yup, do 2 or 3 kernel compiles and it crashes again. Here's a slightly
> different oops:
> 
> Unable to handle kernel NULL pointer dereference at virtual address 00000282
> c0117feb
> *pde = 00000000
> Oops: 0000
> CPU:    6
> EIP:    0010:[<c0117feb>]    Not tainted
> Using defaults from ksymoops -t elf32-i386 -a i386
> EFLAGS: 00010046
> eax: c6369f6c   ebx: 00000282   ecx: c029a488   edx: c4ff5b24
> esi: c4ff5b20   edi: 00000282   ebp: c6227f70   esp: c6227f54
> ds: 0018   es: 0018   ss: 0018
> Process cpp (pid: 16679, stackpage=c6227000)
> Stack: 00001000 c4ff5b20 c5773180 00000001 c4ff5b24 00000282 00000001 000526a9 
>        c0148311 00000000 ffffffea c5eab160 000536a9 c6526000 c6226000 c57731ec 
>        00001000 00001000 c013ead7 c5eab160 4011000c 000536a9 c5eab180 c6226000 
> Call Trace: [<c0148311>] [<c013ead7>] [<c0108a7b>] 
> Code: 8b 3b 0f 18 07 3b 5d f4 75 d0 c6 06 01 ff 75 f8 9d 8d 74 26 
> 
> >>EIP; c0117fea <__wake_up+5a/7c>   <=====
> Trace; c0148310 <pipe_write+1bc/294>

no doubt it crashes again here, the pipe_write stack gets corrupted by
pipe_wait. Actually we had very good luck that previously it crashed in
the buggy place, so you showed me imemdiatly the buggy assembler, if it
crashed in __wake_up the first time, maybe __wake_up wasn't miscompiled
and it would been much harder to guess it was not a kernel mistake... :)

> Trace; c013ead6 <sys_write+8e/100>
> Trace; c0108a7a <system_call+2e/34>
> Code;  c0117fea <__wake_up+5a/7c>
> 00000000 <_EIP>:
> Code;  c0117fea <__wake_up+5a/7c>   <=====
>    0:   8b 3b                     mov    (%ebx),%edi   <=====
> Code;  c0117fec <__wake_up+5c/7c>
>    2:   0f 18 07                  prefetchnta (%edi)
> Code;  c0117fee <__wake_up+5e/7c>
>    5:   3b 5d f4                  cmp    0xfffffff4(%ebp),%ebx
> Code;  c0117ff2 <__wake_up+62/7c>
>    8:   75 d0                     jne    ffffffda <_EIP+0xffffffda> c0117fc4 <__
> wake_up+34/7c>
> Code;  c0117ff4 <__wake_up+64/7c>
>    a:   c6 06 01                  movb   $0x1,(%esi)
> Code;  c0117ff6 <__wake_up+66/7c>
>    d:   ff 75 f8                  pushl  0xfffffff8(%ebp)
> Code;  c0117ffa <__wake_up+6a/7c>
>   10:   9d                        popf   
> Code;  c0117ffa <__wake_up+6a/7c>
>   11:   8d 74 26 00               lea    0x0(%esi,1),%esi
> 
> > Also if for example you enabled numa-q you
> > may want to try to disable it and see if w/o discontigmem the problem
> > goes away, if we could isolate it to a config option, it would help a lot.
> 
> OK, will see if I can do that - I'm out for a few days, so it may be next
> Tuesday before I can do this
> 
> M.


Andrea
