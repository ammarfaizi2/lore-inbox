Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311710AbSFFXPU>; Thu, 6 Jun 2002 19:15:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311871AbSFFXPT>; Thu, 6 Jun 2002 19:15:19 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:28251 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S311710AbSFFXPS>; Thu, 6 Jun 2002 19:15:18 -0400
Date: Fri, 7 Jun 2002 01:15:21 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Jan Hubicka <jh@suse.cz>,
        Keith Owens <kaos@ocs.com.au>
Subject: Re: Panic from 2.4.19-pre9-aa2
Message-ID: <20020606231521.GB1004@dualathlon.random>
In-Reply-To: <80230000.1023396285@flay> <20020606212028.GA1004@dualathlon.random> <83910000.1023400420@flay>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 06, 2002 at 02:53:40PM -0700, Martin J. Bligh wrote:
> >> Unable to handle kernel paging request at virtual address fffff85e
> >> c648ff38
> >> *pde = 00005063
> >> Oops: 0000
> >> CPU:    3
> >> EIP:    0060:[<c648ff38>]    Not tainted
> >> Using defaults from ksymoops -t elf32-i386 -a i386
> >> EFLAGS: c648e000
> >> eax: 00000000   ebx: c623a000   ecx: fffff83e   edx: c623a380
> >> esi: 00000001   edi: c0297520   ebp: c0117bf6   esp: c648ff00
> >> ds: 0018   es: 0018   ss: 0018
> >> Process cpp (pid: 21583, stackpage=c648f000)
> >> Stack: c648e000 c63473a0 c634740c 00000000 c01163f8 bfffeed4 c649e000 c648e000 
> >>        00000040 c648e000 00000002 c62b75e0 c4ad2f20 c648e000 c648ff60 c0147dad 
> >>        00001000 c4ba54e0 c63473a0 000415b4 00000000 c648e000 00000000 00000000 
> >> Call Trace: [<c01163f8>] [<c0147dad>] [<c0148180>] [<c013e308>] [<c013e937>] 
			        ^^^^^^^^
> >>    [<c0108a7b>] 
> >> Code: 60 ff 48 c6 ad 7d 14 c0 00 10 00 00 e0 54 ba c4 a0 73 34 c6 
> >> 
> >> >> EIP; c648ff38 <END_OF_CODE+6196040/????>   <=====
> >> Trace; c01163f8 <do_page_fault+0/670>
> >> Trace; c0147dac <pipe_wait+7c/a4>
            ^^^^^^^^
> > 
> > ok, so the crash is at pipe_wait+7c. Can you disassemble pipe_wait?
> > (shouldn't be very big) (i use gcc 3.1.1 so my assembly wouldn't match)
> > apparently a part of the inode got corrupted, and somebody is reading at
> > offset 0x20 of a structure inside the inode.
> 
> (gdb) disassemble pipe_wait
> Dump of assembler code for function pipe_wait:
> 0xc0147d30 <pipe_wait>: sub    $0x20,%esp
				 ^^^^^ this should be 0x30!!!!!! not 0x20
> 0xc0147d33 <pipe_wait+3>:       push   %ebp
> 0xc0147d34 <pipe_wait+4>:       push   %edi
> 0xc0147d35 <pipe_wait+5>:       push   %esi
> 0xc0147d36 <pipe_wait+6>:       push   %ebx
> 0xc0147d37 <pipe_wait+7>:       mov    $0xffffe000,%ebx
> 0xc0147d3c <pipe_wait+12>:      and    %esp,%ebx
> 0xc0147d3e <pipe_wait+14>:      lea    0x20(%esp,1),%ebp
> 0xc0147d42 <pipe_wait+18>:      mov    %ebp,%edx
> 0xc0147d44 <pipe_wait+20>:      mov    0x34(%esp,1),%esi
> 0xc0147d48 <pipe_wait+24>:      movl   $0x0,0x10(%esp,1)
> 0xc0147d50 <pipe_wait+32>:      movl   $0x0,0x14(%esp,1)
				  ^^^^^^^^^^^^^^^^^^^^^^^^ (what's this?)
> 0xc0147d58 <pipe_wait+40>:      movl   $0x0,0x18(%esp,1)
> 0xc0147d60 <pipe_wait+48>:      movl   $0x0,0x1c(%esp,1)
> 0xc0147d68 <pipe_wait+56>:      mov    %ebx,0x14(%esp,1)
				  ^^^^^^^^^^^^^^^^^^^^^^^^
> 0xc0147d6c <pipe_wait+60>:      movl   $0x0,0x20(%esp,1)
> 0xc0147d74 <pipe_wait+68>:      mov    %ebx,0x24(%esp,1)
> 0xc0147d78 <pipe_wait+72>:      movl   $0x0,0x28(%esp,1)
> 0xc0147d80 <pipe_wait+80>:      movl   $0x0,0x2c(%esp,1)
> 0xc0147d88 <pipe_wait+88>:      movl   $0x1,(%ebx)
> 0xc0147d8e <pipe_wait+94>:      mov    0xf8(%esi),%eax
> 0xc0147d94 <pipe_wait+100>:     call   0xc01199c0 <add_wait_queue>
> 0xc0147d99 <pipe_wait+105>:     lea    0x6c(%esi),%edi
> 0xc0147d9c <pipe_wait+108>:     mov    %edi,%ecx
> 0xc0147d9e <pipe_wait+110>:     lock incl 0x6c(%esi)
> 0xc0147da2 <pipe_wait+114>:     jle    0xc014891b <.text.lock.pipe>
> 0xc0147da8 <pipe_wait+120>:     call   0xc0117ae8 <schedule>
> 0xc0147dad <pipe_wait+125>:     mov    0xf8(%esi),%eax
  ^^^^^^^^^^

At first glance this seems a miscompilation, a compiler bug, not bug in
2.4.19pre9aa2 (this clearly explains why you're the only one reproducing
this weird oops). it even sounds like ksymoops is buggy, ksymoops had to
say c0147dad (+7d), not c0147dac and +7c (maybe you compiled ksymoops
with the same compiler of the kernel? If not Keith should have a look
here).

besides the stupid zeroing of 0x14(esp) (my compiler isn't doing that),
the initial sub seems wrong, pipe_wait has just one argument, and that's
at offset 0x34, so it should be sub 0x30, not sub 0x20, or we will
corrupt the underlying stack and we also won't read the
inode at all (hence the oops, it wasn't the inode to be corrupted as I
guessed in the previous email, it's at the previous setp, we use random
memory as a pointer to the inode structure so we oops while we try to
read the inode contents).

Of course the code reads the inode at offset 0x34, but at 0x34 there's
not the inode, there's something else random, because the prologue did
sub 0x20 so the inode was at 0x24, not 0x34! the prologue clearly had to
do sub 0x30 instead (that's the miscompilation).

What compiler are you using? Maybe 2.96?

3.1.1 20020530 works fine for me with the kernel, as well as previous
gcc 3.1, never had a single problem with the kernel in the whole
developement cycle of 3.0 and 3.1 and now with 3.1.1. If you need to go
safe with the kernel for x86 you should use only 2.95 or egcs 1.1.2,
however I can reassure people that gcc 3.1.1 seems rock solid even if
I wouldn't use it in mission critical yet.

I CC'ed Honza (x86-64/x86 gcc guru) and Keith, in case I misread something.

Honza, this is the pipe_wait C code:

void pipe_wait(struct inode * inode)
{
	DECLARE_WAITQUEUE(wait, current);
	current->state = TASK_INTERRUPTIBLE;
	add_wait_queue(PIPE_WAIT(*inode), &wait);
		       ^^^^^^^^^^^^^^^^^ we bug here while dereferencing inode->i_pipe
	up(PIPE_SEM(*inode));
	schedule();
	remove_wait_queue(PIPE_WAIT(*inode), &wait);
	current->state = TASK_RUNNING;
	down(PIPE_SEM(*inode));
}


note, wait is at offset 0 of i_pipe, and i_pipe is at offset 0xf8 of the
inode. So it is indeed doing inode->i_pipe when it oops, because the
inode address passed on the stack (first and only argument) was at 0x24 not 0x34.



> 0xc0147db3 <pipe_wait+131>:     mov    %ebp,%edx
> 0xc0147db5 <pipe_wait+133>:     call   0xc0119a28 <remove_wait_queue>
> 0xc0147dba <pipe_wait+138>:     movl   $0x0,(%ebx)
> 0xc0147dc0 <pipe_wait+144>:     mov    %edi,%ecx
> 0xc0147dc2 <pipe_wait+146>:     lock decl 0x6c(%esi)
> 0xc0147dc6 <pipe_wait+150>:     js     0xc0148925 <.text.lock.pipe+10>
> 0xc0147dcc <pipe_wait+156>:     pop    %ebx
> 0xc0147dcd <pipe_wait+157>:     pop    %esi
> 0xc0147dce <pipe_wait+158>:     pop    %edi
> 0xc0147dcf <pipe_wait+159>:     pop    %ebp
> 0xc0147dd0 <pipe_wait+160>:     add    $0x20,%esp
> 0xc0147dd3 <pipe_wait+163>:     ret    
> End of assembler dump.
> 
> > not really sure what could be the problem, it would be interesting to
> > see if you can reproduce it. Also if for example you enabled numa-q you
> > may want to try to disable it and see if w/o discontigmem the problem
> > goes away, if we could isolate it to a config option, it would help a lot.
> 
> OK, I'll play around some more and try to build up a pattern.
> 
> Not sure why ksymoops is printing c0147dac from the trace, whilst 
> the stack says c0147dad, which seems to be the schedule call - 
> would make sense, as that's what you just changed?

yes, that's wrong, but that is a ksymoops mistake not related to the
original oops (possibly due the same broken compiler but maybe not).

> 
> M.


Andrea
