Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317185AbSFFVUQ>; Thu, 6 Jun 2002 17:20:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317189AbSFFVUP>; Thu, 6 Jun 2002 17:20:15 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:4174 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S317185AbSFFVUM>; Thu, 6 Jun 2002 17:20:12 -0400
Date: Thu, 6 Jun 2002 23:20:28 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Panic from 2.4.19-pre9-aa2
Message-ID: <20020606212028.GA1004@dualathlon.random>
In-Reply-To: <80230000.1023396285@flay>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 06, 2002 at 01:44:45PM -0700, Martin J. Bligh wrote:
> Panic below - crashed on third kernel compile since boot.
> Worked fine on -pre8-aa2
> 
> M.
> 
> -------------------------------------------------------
> 
> Unable to handle kernel paging request at virtual address fffff85e
> c648ff38
> *pde = 00005063
> Oops: 0000
> CPU:    3
> EIP:    0060:[<c648ff38>]    Not tainted
> Using defaults from ksymoops -t elf32-i386 -a i386
> EFLAGS: c648e000
> eax: 00000000   ebx: c623a000   ecx: fffff83e   edx: c623a380
> esi: 00000001   edi: c0297520   ebp: c0117bf6   esp: c648ff00
> ds: 0018   es: 0018   ss: 0018
> Process cpp (pid: 21583, stackpage=c648f000)
> Stack: c648e000 c63473a0 c634740c 00000000 c01163f8 bfffeed4 c649e000 c648e000 
>        00000040 c648e000 00000002 c62b75e0 c4ad2f20 c648e000 c648ff60 c0147dad 
>        00001000 c4ba54e0 c63473a0 000415b4 00000000 c648e000 00000000 00000000 
> Call Trace: [<c01163f8>] [<c0147dad>] [<c0148180>] [<c013e308>] [<c013e937>] 
>    [<c0108a7b>] 
> Code: 60 ff 48 c6 ad 7d 14 c0 00 10 00 00 e0 54 ba c4 a0 73 34 c6 
> 
> >>EIP; c648ff38 <END_OF_CODE+6196040/????>   <=====
> Trace; c01163f8 <do_page_fault+0/670>
> Trace; c0147dac <pipe_wait+7c/a4>

ok, so the crash is at pipe_wait+7c. Can you disassemble pipe_wait?
(shouldn't be very big) (i use gcc 3.1.1 so my assembly wouldn't match)
apparently a part of the inode got corrupted, and somebody is reading at
offset 0x20 of a structure inside the inode.

not really sure what could be the problem, it would be interesting to
see if you can reproduce it. Also if for example you enabled numa-q you
may want to try to disable it and see if w/o discontigmem the problem
goes away, if we could isolate it to a config option, it would help a lot.

> Trace; c0148180 <pipe_write+1cc/294>
> Trace; c013e308 <filp_close+9c/a8>
> Trace; c013e936 <sys_write+8e/100>
> Trace; c0108a7a <system_call+2e/34>
> Code;  c648ff38 <END_OF_CODE+6196040/????>
> 00000000 <_EIP>:
> Code;  c648ff38 <END_OF_CODE+6196040/????>
>    0:   60                        pusha  
> Code;  c648ff38 <END_OF_CODE+6196040/????>   <=====
>    1:   ff 48 c6                  decl   0xffffffc6(%eax)   <=====
> Code;  c648ff3c <END_OF_CODE+6196044/????>
>    4:   ad                        lods   %ds:(%esi),%eax
> Code;  c648ff3c <END_OF_CODE+6196044/????>
>    5:   7d 14                     jge    1b <_EIP+0x1b> c648ff52 <END_OF_CODE+61
> 9605a/????>
> Code;  c648ff3e <END_OF_CODE+6196046/????>
>    7:   c0 00 10                  rolb   $0x10,(%eax)
> Code;  c648ff42 <END_OF_CODE+619604a/????>
>    a:   00 00                     add    %al,(%eax)
> Code;  c648ff44 <END_OF_CODE+619604c/????>
>    c:   e0 54                     loopne 62 <_EIP+0x62> c648ff9a <END_OF_CODE+61
> 960a2/????>
> Code;  c648ff46 <END_OF_CODE+619604e/????>
>    e:   ba c4 a0 73 34            mov    $0x3473a0c4,%edx
> Code;  c648ff4a <END_OF_CODE+6196052/????>
>   13:   c6 00 00                  movb   $0x0,(%eax)
> 


Andrea
