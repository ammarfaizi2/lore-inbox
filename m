Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262276AbSJJKEK>; Thu, 10 Oct 2002 06:04:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262277AbSJJKEK>; Thu, 10 Oct 2002 06:04:10 -0400
Received: from mta03bw.bigpond.com ([139.134.6.86]:44505 "EHLO
	mta03bw.bigpond.com") by vger.kernel.org with ESMTP
	id <S262276AbSJJKEG> convert rfc822-to-8bit; Thu, 10 Oct 2002 06:04:06 -0400
Content-Type: text/plain; charset=US-ASCII
From: Srihari Vijayaraghavan <harisri@bigpond.com>
To: Andrea Arcangeli <andrea@suse.de>
Subject: Re: Linux-2.4.20-pre8-aa2 oops report. [solved]
Date: Thu, 10 Oct 2002 20:17:03 +1000
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org
References: <200210051247.14368.harisri@bigpond.com> <200210051755.01256.harisri@bigpond.com> <20021010012626.GW2958@dualathlon.random>
In-Reply-To: <20021010012626.GW2958@dualathlon.random>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210102017.04048.harisri@bigpond.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andrea,

> thanks for your detailed reports, please try to reproduce any problem
> you had with this incremental fix applied on top of 2.4.20pre8aa2:
>
> --- ul-20021007/kernel/sched.c.~1~	Tue Oct  8 07:14:19 2002
> +++ ul-20021007/kernel/sched.c	Thu Oct 10 02:29:58 2002
> @@ -380,6 +387,7 @@ void wake_up_forked_process(task_t * p)
>  		parent = NULL;
>  	}
>
> +	p->cpu = smp_processor_id();
>  	__activate_task(p, rq, parent);
>  	spin_unlock_irq(&rq->lock);
>  }
>

Thanks. Unfortunately that did not fix the problem.

I was able to reproduce 4 more oops. (all happened one after other)

ksymoops 2.4.5 on i686 2.4.20-pre8aa2-p1.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.20-pre8aa2-p1/ (default)
     -m /boot/System.map-2.4.20-pre8aa2-p1 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Oct 10 19:26:36 localhost kernel: Unable to handle kernel NULL pointer 
dereference at virtual address 0000011b
Oct 10 19:26:36 localhost kernel: c01a96b2
Oct 10 19:26:36 localhost kernel: *pde = 00000000
Oct 10 19:26:36 localhost kernel: Oops: 0000 2.4.20-pre8aa2-p1 #4 Thu Oct 10 
19:12:17 EST 2002
Oct 10 19:26:36 localhost kernel: CPU:    0
Oct 10 19:26:36 localhost kernel: EIP:    0010:[<c01a96b2>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Oct 10 19:26:36 localhost kernel: EFLAGS: 00010213
Oct 10 19:26:36 localhost kernel: eax: 00000113   ebx: 00000145   ecx: 
c37eff64   edx: c69aedc0
Oct 10 19:26:36 localhost kernel: esi: c5bd4000   edi: c69aedc0   ebp: 
00000000   esp: c37eff1c
Oct 10 19:26:36 localhost kernel: ds: 0018   es: 0018   ss: 0018
Oct 10 19:26:36 localhost kernel: Process bonobo-activati (pid: 988, 
stackpage=c37ef000)
Oct 10 19:26:36 localhost kernel: Stack: c5bd4020 c51daa40 00000004 c014a279 
c69aedc0 00000000 00000000 7fffffff 
Oct 10 19:26:36 localhost kernel:        00000000 00000000 c014a37f 00000005 
c5bd4000 c37eff64 c37eff60 c37ee000 
Oct 10 19:26:36 localhost kernel:        c37ee000 00000000 00000000 c37effa8 
08082fe0 00000000 00000005 c014a4fc 
Oct 10 19:26:36 localhost kernel: Call Trace:    [<c014a279>] [<c014a37f>] 
[<c014a4fc>] [<c0108eff>]
Oct 10 19:26:36 localhost kernel: Code: 8b 48 08 89 44 24 04 89 14 24 8b 44 24 
14 89 44 24 08 ff 51 


>>EIP; c01a96b2 <sock_poll+12/30>   <=====

>>ecx; c37eff64 <[iptable_filter].data.end+12065d9/182e6f5>
>>edx; c69aedc0 <END_OF_CODE+2af69/????>
>>esi; c5bd4000 <[soundcore].bss.end+1d289d/3ae91d>
>>edi; c69aedc0 <END_OF_CODE+2af69/????>
>>esp; c37eff1c <[iptable_filter].data.end+1206591/182e6f5>

Trace; c014a279 <do_pollfd+89/90>
Trace; c014a37f <do_poll+ff/110>
Trace; c014a4fc <sys_poll+16c/2f0>
Trace; c0108eff <system_call+33/38>

Code;  c01a96b2 <sock_poll+12/30>
00000000 <_EIP>:
Code;  c01a96b2 <sock_poll+12/30>   <=====
   0:   8b 48 08                  mov    0x8(%eax),%ecx   <=====
Code;  c01a96b5 <sock_poll+15/30>
   3:   89 44 24 04               mov    %eax,0x4(%esp,1)
Code;  c01a96b9 <sock_poll+19/30>
   7:   89 14 24                  mov    %edx,(%esp,1)
Code;  c01a96bc <sock_poll+1c/30>
   a:   8b 44 24 14               mov    0x14(%esp,1),%eax
Code;  c01a96c0 <sock_poll+20/30>
   e:   89 44 24 08               mov    %eax,0x8(%esp,1)
Code;  c01a96c4 <sock_poll+24/30>
  12:   ff 51 00                  call   *0x0(%ecx)

Oct 10 19:26:36 localhost kernel: CPU:    0
Oct 10 19:26:36 localhost kernel: EIP:    0010:[<c0132998>]    Not tainted
Oct 10 19:26:36 localhost kernel: EFLAGS: 00010057
Oct 10 19:26:36 localhost kernel: eax: ffffffff   ebx: ffffffbf   ecx: 
c4973000   edx: ffffffff
Oct 10 19:26:37 localhost kernel: esi: c15870c0   edi: 00000246   ebp: 
000001f0   esp: c7635f60
Oct 10 19:26:37 localhost kernel: ds: 0018   es: 0018   ss: 0018
Oct 10 19:26:37 localhost kernel: Process gnome-settings- (pid: 992, 
stackpage=c7635000)
Oct 10 19:26:37 localhost kernel: Stack: 00000000 00000000 c7634000 080bdcc8 
080bdcc8 bffff618 c014a657 c15870c0 
Oct 10 19:26:37 localhost kernel:        000001f0 c31a99c0 c3474000 c7634000 
c01150eb c51daac0 c7635fa8 00000000 
Oct 10 19:26:37 localhost kernel:        fffffff4 c013a8f9 00000000 00000000 
c7634000 420d2220 080bdcc8 bffff618 
Oct 10 19:26:37 localhost kernel: Call Trace:    [<c014a657>] [<c01150eb>] 
[<c013a8f9>] [<c0108eff>]
Oct 10 19:26:37 localhost kernel: Code: 89 10 89 42 04 c7 01 00 00 00 00 8b 06 
89 48 04 89 01 89 71 


>>EIP; c0132998 <__kmem_cache_alloc+78/f0>   <=====

>>eax; ffffffff <END_OF_CODE+3967c1a8/????>
>>ebx; ffffffbf <END_OF_CODE+3967c168/????>
>>ecx; c4973000 <[radeon].bss.end+7dda89/186ab09>
>>edx; ffffffff <END_OF_CODE+3967c1a8/????>
>>esi; c15870c0 <_end+12ff710/15786d0>
>>esp; c7635f60 <END_OF_CODE+cb2109/????>

Trace; c014a657 <sys_poll+2c7/2f0>
Trace; c01150eb <do_schedule+15b/240>
Trace; c013a8f9 <sys_writev+69/80>
Trace; c0108eff <system_call+33/38>

Code;  c0132998 <__kmem_cache_alloc+78/f0>
00000000 <_EIP>:
Code;  c0132998 <__kmem_cache_alloc+78/f0>   <=====
   0:   89 10                     mov    %edx,(%eax)   <=====
Code;  c013299a <__kmem_cache_alloc+7a/f0>
   2:   89 42 04                  mov    %eax,0x4(%edx)
Code;  c013299d <__kmem_cache_alloc+7d/f0>
   5:   c7 01 00 00 00 00         movl   $0x0,(%ecx)
Code;  c01329a3 <__kmem_cache_alloc+83/f0>
   b:   8b 06                     mov    (%esi),%eax
Code;  c01329a5 <__kmem_cache_alloc+85/f0>
   d:   89 48 04                  mov    %ecx,0x4(%eax)
Code;  c01329a8 <__kmem_cache_alloc+88/f0>
  10:   89 01                     mov    %eax,(%ecx)
Code;  c01329aa <__kmem_cache_alloc+8a/f0>
  12:   89 71 00                  mov    %esi,0x0(%ecx)

Oct 10 19:26:37 localhost kernel:  <1>Unable to handle kernel NULL pointer 
dereference at virtual address 00000003
Oct 10 19:26:38 localhost kernel: c0131412
Oct 10 19:26:38 localhost kernel: *pde = 00000000
Oct 10 19:26:38 localhost kernel: Oops: 0000 2.4.20-pre8aa2-p1 #4 Thu Oct 10 
19:12:17 EST 2002
Oct 10 19:26:38 localhost kernel: CPU:    0
Oct 10 19:26:38 localhost kernel: EIP:    0010:[<c0131412>]    Not tainted
Oct 10 19:26:38 localhost kernel: EFLAGS: 00010286
Oct 10 19:26:38 localhost kernel: eax: e4cb0000   ebx: ffffffff   ecx: 
c020d768   edx: c497378c
Oct 10 19:26:38 localhost kernel: esi: c7634000   edi: c31a99c0   ebp: 
0000000b   esp: c7635e98
Oct 10 19:26:38 localhost kernel: ds: 0018   es: 0018   ss: 0018
Oct 10 19:26:38 localhost kernel: Process gnome-settings- (pid: 992, 
stackpage=c7635000)
Oct 10 19:26:38 localhost kernel: Stack: c020e600 00000005 c31a99c0 c012a513 
e4cb0000 00000046 00000001 000001f0 
Oct 10 19:26:38 localhost kernel:        c31a99c0 c7634000 c0109a10 0000000b 
c0116a36 c31a99c0 00000202 c31a99c0 
Oct 10 19:26:38 localhost kernel:        c011b807 c31a99c0 00000000 c7635f2c 
00000000 c0109a10 000001f0 c01095ef 
Oct 10 19:26:38 localhost kernel: Call Trace:    [<c012a513>] [<c0109a10>] 
[<c0116a36>] [<c011b807>] [<c0109a10>]
Oct 10 19:26:38 localhost kernel:   [<c01095ef>] [<c0109a61>] [<c0108ff0>] 
[<c0132998>] [<c014a657>] [<c01150eb>]
Oct 10 19:26:38 localhost kernel:   [<c013a8f9>] [<c0108eff>]
Oct 10 19:26:38 localhost kernel: Code: 39 43 04 74 1f 8d 53 0c 8b 5b 0c 85 db 
75 f1 c7 04 24 80 51 


>>EIP; c0131412 <vfree+22/80>   <=====

>>eax; e4cb0000 <END_OF_CODE+1e32c1a9/????>
>>ebx; ffffffff <END_OF_CODE+3967c1a8/????>
>>ecx; c020d768 <gdt_table+68/e0>
>>edx; c497378c <[radeon].bss.end+7de215/186ab09>
>>esi; c7634000 <END_OF_CODE+cb01a9/????>
>>edi; c31a99c0 <[iptable_filter].data.end+bc0035/182e6f5>
>>esp; c7635e98 <END_OF_CODE+cb2041/????>

Trace; c012a513 <exit_mmap+13/130>
Trace; c0109a10 <do_general_protection+0/a0>
Trace; c0116a36 <mmput+56/d0>
Trace; c011b807 <do_exit+87/260>
Trace; c0109a10 <do_general_protection+0/a0>
Trace; c01095ef <die+7f/80>
Trace; c0109a61 <do_general_protection+51/a0>
Trace; c0108ff0 <error_code+34/3c>
Trace; c0132998 <__kmem_cache_alloc+78/f0>
Trace; c014a657 <sys_poll+2c7/2f0>
Trace; c01150eb <do_schedule+15b/240>
Trace; c013a8f9 <sys_writev+69/80>
Trace; c0108eff <system_call+33/38>

Code;  c0131412 <vfree+22/80>
00000000 <_EIP>:
Code;  c0131412 <vfree+22/80>   <=====
   0:   39 43 04                  cmp    %eax,0x4(%ebx)   <=====
Code;  c0131415 <vfree+25/80>
   3:   74 1f                     je     24 <_EIP+0x24>
Code;  c0131417 <vfree+27/80>
   5:   8d 53 0c                  lea    0xc(%ebx),%edx
Code;  c013141a <vfree+2a/80>
   8:   8b 5b 0c                  mov    0xc(%ebx),%ebx
Code;  c013141d <vfree+2d/80>
   b:   85 db                     test   %ebx,%ebx
Code;  c013141f <vfree+2f/80>
   d:   75 f1                     jne    0 <_EIP>
Code;  c0131421 <vfree+31/80>
   f:   c7 04 24 80 51 00 00      movl   $0x5180,(%esp,1)

Oct 10 19:26:38 localhost kernel: CPU:    0
Oct 10 19:26:38 localhost kernel: EIP:    0010:[<c0132998>]    Not tainted
Oct 10 19:26:38 localhost kernel: EFLAGS: 00010057
Oct 10 19:26:38 localhost kernel: eax: ffffffff   ebx: ffffffbf   ecx: 
c4973000   edx: ffffffff
Oct 10 19:26:38 localhost kernel: esi: c15870c0   edi: 00000246   ebp: 
000001f0   esp: c6721f3c
Oct 10 19:26:38 localhost kernel: ds: 0018   es: 0018   ss: 0018
Oct 10 19:26:38 localhost kernel: Process esd (pid: 998, stackpage=c6721000)
Oct 10 19:26:38 localhost kernel: Stack: 7fffffff 00000017 fffffff4 00000001 
c6720000 bffff848 c0149d2c c15870c0 
Oct 10 19:26:38 localhost kernel:        000001f0 c0149e39 00000004 00000004 
c6721f8c 00000005 08054450 bffff8bc 
Oct 10 19:26:38 localhost kernel:        bffff8e8 00000004 00000031 bffff8c0 
00000000 c4973440 c4973444 c4973448 
Oct 10 19:26:38 localhost kernel: Call Trace:    [<c0149d2c>] [<c0149e39>] 
[<c0108eff>]
Oct 10 19:26:38 localhost kernel: Code: 89 10 89 42 04 c7 01 00 00 00 00 8b 06 
89 48 04 89 01 89 71 


>>EIP; c0132998 <__kmem_cache_alloc+78/f0>   <=====

>>eax; ffffffff <END_OF_CODE+3967c1a8/????>
>>ebx; ffffffbf <END_OF_CODE+3967c168/????>
>>ecx; c4973000 <[radeon].bss.end+7dda89/186ab09>
>>edx; ffffffff <END_OF_CODE+3967c1a8/????>
>>esi; c15870c0 <_end+12ff710/15786d0>
>>esp; c6721f3c <[ac97_codec].data.end+92ab35/b88c79>

Trace; c0149d2c <select_bits_alloc+1c/20>
Trace; c0149e39 <sys_select+f9/4b0>
Trace; c0108eff <system_call+33/38>

Code;  c0132998 <__kmem_cache_alloc+78/f0>
00000000 <_EIP>:
Code;  c0132998 <__kmem_cache_alloc+78/f0>   <=====
   0:   89 10                     mov    %edx,(%eax)   <=====
Code;  c013299a <__kmem_cache_alloc+7a/f0>
   2:   89 42 04                  mov    %eax,0x4(%edx)
Code;  c013299d <__kmem_cache_alloc+7d/f0>
   5:   c7 01 00 00 00 00         movl   $0x0,(%ecx)
Code;  c01329a3 <__kmem_cache_alloc+83/f0>
   b:   8b 06                     mov    (%esi),%eax
Code;  c01329a5 <__kmem_cache_alloc+85/f0>
   d:   89 48 04                  mov    %ecx,0x4(%eax)
Code;  c01329a8 <__kmem_cache_alloc+88/f0>
  10:   89 01                     mov    %eax,(%ecx)
Code;  c01329aa <__kmem_cache_alloc+8a/f0>
  12:   89 71 00                  mov    %esi,0x0(%ecx)


1 warning issued.  Results may not be reliable.

I am able to easily reproduce the issue by doing:
1. Login to XFree86/Gnome or KDE
2. Run Mozilla, Open Office Writer/Impress/Calc and exit all of them
3. mke2fs -j /dev/hda9 (that is a blank 2.5 GB partition)
4. mount /dev/hda9 /test
5. cd /test; dd if=/dev/zero of=zero bs=1024 count=1048576
6. Log out and Log in XFree86
7. Oops appears in the System logs

-- 
Hari
harisri@bigpond.com

