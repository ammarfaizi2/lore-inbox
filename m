Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264756AbTBOSK3>; Sat, 15 Feb 2003 13:10:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264788AbTBOSK3>; Sat, 15 Feb 2003 13:10:29 -0500
Received: from franka.aracnet.com ([216.99.193.44]:24469 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S264756AbTBOSK1>; Sat, 15 Feb 2003 13:10:27 -0500
Date: Sat, 15 Feb 2003 10:20:04 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Dave Hansen <haveblue@us.ibm.com>, Andrew Morton <akpm@digeo.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: problems with 2.5.61-mm1
Message-ID: <92090000.1045333203@[10.10.2.4]>
In-Reply-To: <3E4E0153.3000008@us.ibm.com>
References: <3E4E0153.3000008@us.ibm.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

No, that's a kirq broke no_irq_balance thing (I presume this is NUMA-Q?).
There's a bootflag option to disable it as well, but that's broken too. I
can't fix do it right now, but someone needs to go through and fix all the
disable bits so they work.

--On Saturday, February 15, 2003 00:58:59 -0800 Dave Hansen
<haveblue@us.ibm.com> wrote:

> I've been beating on various versions of 2.5.59 all day long with no
> problems that I didn't cause.  I started testing 2.5.61-mm1 and rand
> into a couple problems right away.
> 
> The first I really doubt is -mm specific.  I gets _loads_ of these, and
> the e1000 isn't working:
> NETDEV WATCHDOG: eth0: transmit timed out
> e1000: eth0 NIC Link is Up 1000 Mbps Full Duplex
> 
> The e1000 driver hasn't been touched in weeks.  Here's my
> /proc/interrupts: http://www.sr71.net/linux/interrupts
> I'm pretty sure we can see the problem here.  Almost all interrupts are
> going to CPU0.  Is this a summit thing?
> 
> The other looks a bit more insidious.
> 
> Unable to handle kernel NULL pointer dereference at virtual address
> 0000003d c011af77
> *pde = 1cf93001
> Oops: 0002
> CPU:    1
> EIP:    0060:[<c011af77>]    Not tainted
> Using defaults from ksymoops -t elf32-i386 -a i386
> EFLAGS: 00010202
> eax: 00000029   ebx: de562870   ecx: dfa85074   edx: 000000e4
> esi: deefc140   edi: cf5227c0   ebp: cf522780   esp: dcad7f08
> ds: 007b   es: 007b   ss: 0068
> Stack: cf522780 000000ff df734c80 00000008 00000000 cc266680 00000100
> dfa85074
>        deefc100 c6ac3900 c6ac39a4 00000011 00000000 c011b46c 00000011
> c6ac3900
>        00000004 00000286 00001000 cc266680 fffffff4 bffff7a0 00000011
> 00000000
>  [<c011b46c>] copy_process+0x3a4/0x902
>  [<c011ba1a>] do_fork+0x50/0x166
>  [<c0126cca>] sys_rt_sigprocmask+0xdc/0x150
>  [<c010792b>] sys_fork+0x37/0x4a
>  [<c0109347>] syscall_call+0x7/0xb
> Code: f0 ff 40 14 89 03 83 c3 04 83 ea 01 75 e1 8b 44 24 20 f0 ff
> 
> 
>>> EIP; c011af77 <copy_files+18f/2c6>   <=====
> 
>>> ebx; de562870 <END_OF_CODE+1e0f3f2c/????>
>>> ecx; dfa85074 <END_OF_CODE+1f616730/????>
>>> esi; deefc140 <END_OF_CODE+1ea8d7fc/????>
>>> edi; cf5227c0 <END_OF_CODE+f0b3e7c/????>
>>> ebp; cf522780 <END_OF_CODE+f0b3e3c/????>
>>> esp; dcad7f08 <END_OF_CODE+1c6695c4/????>
> 
> Code;  c011af77 <copy_files+18f/2c6>
> 00000000 <_EIP>:
> Code;  c011af77 <copy_files+18f/2c6>   <=====
>    0:   f0 ff 40 14               lock incl 0x14(%eax)   <=====
> Code;  c011af7b <copy_files+193/2c6>
>    4:   89 03                     mov    %eax,(%ebx)
> Code;  c011af7d <copy_files+195/2c6>
>    6:   83 c3 04                  add    $0x4,%ebx
> Code;  c011af80 <copy_files+198/2c6>
>    9:   83 ea 01                  sub    $0x1,%edx
> Code;  c011af83 <copy_files+19b/2c6>
>    c:   75 e1                     jne    ffffffef <_EIP+0xffffffef>
> Code;  c011af85 <copy_files+19d/2c6>
>    e:   8b 44 24 20               mov    0x20(%esp,1),%eax
> Code;  c011af89 <copy_files+1a1/2c6>
>   12:   f0 ff 00                  lock incl (%eax)
> 
> more disassembly
> c011af64:       74 1f                   je     c011af85 <copy_files+0x19d>
> c011af66:       8b 4c 24 1c             mov    0x1c(%esp,1),%ecx
> c011af6a:       8b 01                   mov    (%ecx),%eax
> c011af6c:       83 c1 04                add    $0x4,%ecx
> c011af6f:       85 c0                   test   %eax,%eax
> c011af71:       89 4c 24 1c             mov    %ecx,0x1c(%esp,1)
> c011af75:       74 04                   je     c011af7b <copy_files+0x193>
> c011af77:       f0 ff 40 14             lock incl 0x14(%eax) <========
> c011af7b:       89 03                   mov    %eax,(%ebx)
> c011af7d:       83 c3 04                add    $0x4,%ebx
> c011af80:       83 ea 01                sub    $0x1,%edx
> c011af83:       75 e1                   jne    c011af66 <copy_files+0x17e>
> c011af85:       8b 44 24 20             mov    0x20(%esp,1),%eax
> c011af89:       f0 ff 40 04             lock incl 0x4(%eax)
> c011af8d:       8b 45 08                mov    0x8(%ebp),%eax
> c011af90:       89 df                   mov    %ebx,%edi
> c011af92:       2b 44 24 18             sub    0x18(%esp,1),%eax
> c011af96:       8d 34 85 00 00 00 00    lea    0x0(,%eax,4),%esi
> 
> I didn't compile with -g, but I have a hunch it is this:
>         for (i = open_files; i != 0; i--) {
>                 struct file *f = *old_fds++;
>                 if (f)
>                         get_file(f); <=============
>                 *new_fds++ = f;
>         }
> 
> The offset of f_count in struct file is 0x14.  The "test   %eax,%eax" is
> probably the "if (f)"
> -- 
> Dave Hansen
> haveblue@us.ibm.com
> 
> 
> 


