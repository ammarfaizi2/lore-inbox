Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131781AbRAJMaa>; Wed, 10 Jan 2001 07:30:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132210AbRAJMaK>; Wed, 10 Jan 2001 07:30:10 -0500
Received: from cs.columbia.edu ([128.59.16.20]:39663 "EHLO cs.columbia.edu")
	by vger.kernel.org with ESMTP id <S131781AbRAJM37>;
	Wed, 10 Jan 2001 07:29:59 -0500
Date: Wed, 10 Jan 2001 04:29:49 -0800 (PST)
From: Ion Badulescu <ionut@cs.columbia.edu>
To: <linux-kernel@vger.kernel.org>
Subject: Oops with 2.4.0: race in aic7xxx, faulty cpu or voodoo magic
Message-ID: <Pine.LNX.4.30.0101100415260.9847-100000@age.cs.columbia.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the 4th time I'm getting this oops with 2.4.0, and it always
happens when something (usually updatedb) is stressing my SCSI disk.

The ksymoops trace is correct, I also ran it against saved versions of
/proc/ksyms and /proc/modules:

ksymoops 0.7c on i586 2.4.0.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.0/ (default)
     -m /usr/src/linux/System.map (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Unable to handle kernel NULL pointer dereference at virtual address 00000001
c483a79e
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c483a79e>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010006
eax: c32e9ac0   ebx: c337e020   ecx: c11fb878   edx: 00000000
esi: c11fb8d8   edi: c11fb878   ebp: 00000004   esp: c01fde1c
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 0, stackpage=c01fd000)
Stack: c483b212 c11fb878 c32e9ac0 c337e000 c32e9ac0 c11fb878 00000009 00000000
       c01a959d c2305360 c11fb8c8 00000020 c0634500 c11fb8e8 c312feb4 c11fb878
       c48459a1 c485b087 c11fb8c8 c337e000 c4845dc1 c11fb878 c32e9ac0 c11fb878
Call Trace: [<c483b212>] [<c01a959d>] [<c48459a1>] [<c485b087>] [<c4845dc1>] [<c485b091>] [<c4845ebb>]
       [<c484612d>] [<c0109ffd>] [<c010a167>] [<c0108e90>] [<c48c6d92>] [<c0109ffd>] [<c010a167>] [<c0107180>]
       [<c0108e90>] [<c0107180>] [<c01071a3>] [<c01071fa>] [<c0105000>] [<c0100191>]
Code: c6 42 01 ff 8b 49 18 8b 11 89 50 08 89 01 8b 41 04 85 c0 75

>>EIP; c483a79e <[aic7xxx]aic7xxx_free_scb+32/50>   <=====
Trace; c483b212 <[aic7xxx]aic7xxx_done+a56/a70>
Trace; c01a959d <udp_queue_rcv_skb+ed/13c>
Trace; c48459a1 <[aic7xxx]aic7xxx_handle_command_completion_intr+49/48c>
Trace; c485b087 <[aic7xxx].bss.end+1848/3821>
Trace; c4845dc1 <[aic7xxx]aic7xxx_handle_command_completion_intr+469/48c>
Trace; c485b091 <[aic7xxx].bss.end+1852/3821>
Trace; c4845ebb <[aic7xxx]aic7xxx_isr+d7/318>
Trace; c484612d <[aic7xxx]do_aic7xxx_isr+31/8c>
Trace; c0109ffd <handle_IRQ_event+31/5c>
Trace; c010a167 <do_IRQ+6b/ac>
Trace; c0108e90 <ret_from_intr+0/20>
Trace; c48c6d92 <[wvlan_cs]wvlan_interrupt+f2/18c>
Trace; c0109ffd <handle_IRQ_event+31/5c>
Trace; c010a167 <do_IRQ+6b/ac>
Trace; c0107180 <default_idle+0/28>
Trace; c0108e90 <ret_from_intr+0/20>
Trace; c0107180 <default_idle+0/28>
Trace; c01071a3 <default_idle+23/28>
Trace; c01071fa <cpu_idle+32/48>
Trace; c0105000 <empty_bad_page+0/1000>
Trace; c0100191 <L6+0/2>
Code;  c483a79e <[aic7xxx]aic7xxx_free_scb+32/50>
00000000 <_EIP>:
Code;  c483a79e <[aic7xxx]aic7xxx_free_scb+32/50>   <=====
   0:   c6 42 01 ff               movb   $0xff,0x1(%edx)   <=====
Code;  c483a7a2 <[aic7xxx]aic7xxx_free_scb+36/50>
   4:   8b 49 18                  mov    0x18(%ecx),%ecx
Code;  c483a7a5 <[aic7xxx]aic7xxx_free_scb+39/50>
   7:   8b 11                     mov    (%ecx),%edx
Code;  c483a7a7 <[aic7xxx]aic7xxx_free_scb+3b/50>
   9:   89 50 08                  mov    %edx,0x8(%eax)
Code;  c483a7aa <[aic7xxx]aic7xxx_free_scb+3e/50>
   c:   89 01                     mov    %eax,(%ecx)
Code;  c483a7ac <[aic7xxx]aic7xxx_free_scb+40/50>
   e:   8b 41 04                  mov    0x4(%ecx),%eax
Code;  c483a7af <[aic7xxx]aic7xxx_free_scb+43/50>
  11:   85 c0                     test   %eax,%eax
Code;  c483a7b1 <[aic7xxx]aic7xxx_free_scb+45/50>
  13:   75 00                     jne    15 <_EIP+0x15> c483a7b3 <[aic7xxx]aic7xxx_free_scb+47/50>


1 warning issued.  Results may not be reliable.

Clear NULL pointer oops, it seems, right? Well, not quite.
aic7xxx_free_scb looks like this (compiled with egcs-1.1.2):

0000270c <aic7xxx_free_scb>:
    270c:       8b 44 24 08             mov    0x8(%esp,1),%eax
    2710:       8b 4c 24 04             mov    0x4(%esp,1),%ecx
    2714:       c7 40 0c 00 00 00 00    movl   $0x0,0xc(%eax)
    271b:       c7 40 04 00 00 00 00    movl   $0x0,0x4(%eax)
    2722:       c6 40 15 00             movb   $0x0,0x15(%eax)
    2726:       c7 40 20 00 00 00 00    movl   $0x0,0x20(%eax)
    272d:       8b 10                   mov    (%eax),%edx
    272f:       c6 40 14 00             movb   $0x0,0x14(%eax)
    2733:       c6 02 00                movb   $0x0,(%edx)
    2736:       8b 10                   mov    (%eax),%edx
    2738:       c6 42 02 00             movb   $0x0,0x2(%edx)
    273c:       8b 10                   mov    (%eax),%edx
    273e:       c6 42 01 ff             movb   $0xff,0x1(%edx)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
    2742:       8b 49 18                mov    0x18(%ecx),%ecx
    2745:       8b 11                   mov    (%ecx),%edx
    2747:       89 50 08                mov    %edx,0x8(%eax)
    274a:       89 01                   mov    %eax,(%ecx)
    274c:       8b 41 04                mov    0x4(%ecx),%eax
    274f:       85 c0                   test   %eax,%eax
    2751:       75 05                   jne    2758 <aic7xxx_free_scb+0x4c>
    2753:       8b 01                   mov    (%ecx),%eax
    2755:       89 41 04                mov    %eax,0x4(%ecx)
    2758:       c3                      ret

The underlined row has the faulting instruction. But, %eax doesn't
change, (%eax) doesn't change either... what could cause %edx to become 0
*so late*? We are in an ISR, so an interrupt couldn't do it, and the
system is UP so SMP locking isn't an issue either.

And what's causing all those %edx reloads, I can't find any volatiles in
the structure pointed to by %eax (struct aic7xxx_scb)?

I'm truly confused..

Thanks,
Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
