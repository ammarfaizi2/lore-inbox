Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280474AbRJaUIa>; Wed, 31 Oct 2001 15:08:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280470AbRJaUIM>; Wed, 31 Oct 2001 15:08:12 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:8951 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S280468AbRJaUIB>; Wed, 31 Oct 2001 15:08:01 -0500
Message-ID: <3BE058CA.6B1F89BA@mvista.com>
Date: Wed, 31 Oct 2001 12:02:18 -0800
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: The Doctor What <docwhat@gerf.org>
CC: linux-kernel@vger.kernel.org, rgooch@atnf.csiro.au, rml@tech9.net
Subject: Re: [OOPS] 2.4.13+preemptive lp0/devfs
In-Reply-To: <20011031002549.A27188@gerf.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hm...  On the face of it, it looks like a read/write sem failed.  Is
this an SMP box or UP?

Oh, and is it repeatable?

George


The Doctor What wrote:
> 
> Good day!
> 
> Hit this oops and thought you all might like to look at it:
> Kernel version 2.4.13 vanilla with Robert Love's Premptive Patch.
> 
> ksymoops 2.4.3 on i686 2.4.13-p1.  Options used
>      -V (default)
>      -k /proc/ksyms (default)
>      -l /proc/modules (default)
>      -o /lib/modules/2.4.13-p1/ (default)
>      -m /boot/System.map-2.4.13-p1 (default)
> 
> Warning: You did not tell me where to find symbol information.  I will
> assume that the log matches the kernel and modules that are running
> right now and I'll use the default options above for symbol resolution.
> If the current kernel and/or modules do not match the log, you can get
> more accurate output by telling me the kernel version and where to find
> map, modules, ksyms etc.  ksymoops -h explains the options.
> 
> Unable to handle kernel NULL pointer dereference at virtual address 00000000
> c013effa
> *pde = 00000000
> Oops: 0000
> CPU:    0
> EIP:    0010:[<c013effa>]    Tainted: P
> Using defaults from ksymoops -t elf32-i386 -a i386
> EFLAGS: 00010217
> eax: c2e6ffa4   ebx: c2e6ffa4   ecx: c2a20240   edx: c0221188
> esi: 00000000   edi: 00000000   ebp: c2e6ffa4   esp: c2e6ff1c
> ds: 0018   es: 0018   ss: 0018
> Process checkpc (pid: 410, stackpage=c2e6f000)
> Stack: c0221188 c2e6e000 c25f9c00 c2e6ffa4 c015bb85 c2e6ffa4 00000000 c25f80c0
>        c013c344 c25f80c0 c2e6ffa4 c25f9c00 c7f89000 00000000 c2e6ffa4 00000009
>        00000001 00000009 c2e6ffa8 00000009 c7f89008 c25f80c0 c7f89005 00000003
> Call Trace: [<c015bb85>] [<c013c344>] [<c013c46a>] [<c013c8d1>] [<c0139415>]
>    [<c0106d5b>]
> Code: 80 3e 2f 0f 85 d5 00 00 00 53 e8 af c8 ff ff 83 c4 04 ba 00
> 
> >>EIP; c013effa <vfs_follow_link+1a/164>   <=====
> Trace; c015bb84 <devfs_follow_link+44/6c>
> Trace; c013c344 <link_path_walk+7b4/8c0>
> Trace; c013c46a <path_walk+1a/1c>
> Trace; c013c8d0 <__user_walk+34/50>
> Trace; c0139414 <sys_stat64+18/74>
> Trace; c0106d5a <system_call+32/38>
> Code;  c013effa <vfs_follow_link+1a/164>
> 00000000 <_EIP>:
> Code;  c013effa <vfs_follow_link+1a/164>   <=====
>    0:   80 3e 2f                  cmpb   $0x2f,(%esi)   <=====
> Code;  c013effc <vfs_follow_link+1c/164>
>    3:   0f 85 d5 00 00 00         jne    de <_EIP+0xde> c013f0d8 <vfs_follow_link+f8/164>
> Code;  c013f002 <vfs_follow_link+22/164>
>    9:   53                        push   %ebx
> Code;  c013f004 <vfs_follow_link+24/164>
>    a:   e8 af c8 ff ff            call   ffffc8be <_EIP+0xffffc8be> c013b8b8 <path_release+0/2c>
> Code;  c013f008 <vfs_follow_link+28/164>
>    f:   83 c4 04                  add    $0x4,%esp
> Code;  c013f00c <vfs_follow_link+2c/164>
>   12:   ba 00 00 00 00            mov    $0x0,%edx
> 
> 1 warning issued.  Results may not be reliable.
> 
> The above happened after doing a checkpc -f in my startup scripts.
> 
> lp, parport_pc and parport were all modules that weren't loaded till
> the checkpc ran.
> 
> I had just turned on devfs, and this happened.
> 
> Also: /dev/lp0 had incorrect (unwritable) permissions after being
> created.
> 
> Hope this is helpful.
> 
> Ciao!
> 
> --
> "So. let me get this straight. You want to fly on a magic carpet to see the
> King of the Potato People and plead with him for your freedom, and you're
> telling me you're completely sane?!"
>                 --Rimmer (Red Dwarf episode: Quarantine)
> 
> The Doctor What: Kaboom!                         http://docwhat.gerf.org/
> docwhat@gerf.org                                                   KF6VNC
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
