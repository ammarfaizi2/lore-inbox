Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261779AbTKQXCW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Nov 2003 18:02:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261817AbTKQXCW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Nov 2003 18:02:22 -0500
Received: from modemcable137.219-201-24.mc.videotron.ca ([24.201.219.137]:32387
	"EHLO montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S261779AbTKQXCO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Nov 2003 18:02:14 -0500
Date: Mon, 17 Nov 2003 18:01:07 -0500 (EST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
cc: Ingo Molnar <mingo@elte.hu>, "Martin J. Bligh" <mbligh@aracnet.com>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
       Hugh Dickins <hugh@veritas.com>
Subject: Re: [PATCH][2.6-mm] Fix 4G/4G X11/vm86 oops
In-Reply-To: <Pine.LNX.4.44.0311171441380.8840-100000@home.osdl.org>
Message-ID: <Pine.LNX.4.53.0311171749590.30079@montezuma.fsmlabs.com>
References: <Pine.LNX.4.44.0311171441380.8840-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Nov 2003, Linus Torvalds wrote:

> What's the generated assembly language for this function with and without 
> the "fix"?
> 
> If adding that printk fixes a triple fault, the issue is not likely to be 
> the printk itself as much as the difference in code that the compiler 
> generates - stack frame, memory re-ordering etc...

This would be my 'trusty' gcc 3.2.2 from RedHat 9
(gcc version 3.2.2 20030222 (Red Hat Linux 3.2.2-5)

With the fix:
0x0210e860 <do_sys_vm86+0>:     push   %edi
0x0210e861 <do_sys_vm86+1>:     mov    $0xffffe000,%eax
0x0210e866 <do_sys_vm86+6>:     push   %esi
0x0210e867 <do_sys_vm86+7>:     and    %esp,%eax
0x0210e869 <do_sys_vm86+9>:     push   %ebx
0x0210e86a <do_sys_vm86+10>:    mov    0x10(%esp,1),%edi
0x0210e86e <do_sys_vm86+14>:    mov    0x14(%esp,1),%esi
0x0210e872 <do_sys_vm86+18>:    movl   $0x0,0x1c(%edi)
0x0210e879 <do_sys_vm86+25>:    movl   $0x0,0x20(%edi)
0x0210e880 <do_sys_vm86+32>:    mov    (%eax),%edx
0x0210e882 <do_sys_vm86+34>:    mov    0x30(%edi),%eax
0x0210e885 <do_sys_vm86+37>:    mov    %eax,0x5b8(%edx)
0x0210e88b <do_sys_vm86+43>:    mov    0x30(%edi),%edx
0x0210e88e <do_sys_vm86+46>:    mov    0xbc(%edi),%eax
0x0210e894 <do_sys_vm86+52>:    and    $0xdd5,%edx
0x0210e89a <do_sys_vm86+58>:    mov    %edx,0x30(%edi)
0x0210e89d <do_sys_vm86+61>:    mov    0x30(%eax),%eax
0x0210e8a0 <do_sys_vm86+64>:    and    $0xfffff22a,%eax
0x0210e8a5 <do_sys_vm86+69>:    or     %eax,%edx
0x0210e8a7 <do_sys_vm86+71>:    mov    0x54(%edi),%eax
0x0210e8aa <do_sys_vm86+74>:    or     $0x20000,%edx
0x0210e8b0 <do_sys_vm86+80>:    cmp    $0x3,%eax
0x0210e8b3 <do_sys_vm86+83>:    mov    %edx,0x30(%edi)
0x0210e8b6 <do_sys_vm86+86>:    je     0x210e9f0 <do_sys_vm86+400>
0x0210e8bc <do_sys_vm86+92>:    cmp    $0x3,%eax
0x0210e8bf <do_sys_vm86+95>:    ja     0x210e9d5 <do_sys_vm86+373>
0x0210e8c5 <do_sys_vm86+101>:   cmp    $0x2,%eax
0x0210e8c8 <do_sys_vm86+104>:   je     0x210e9c6 <do_sys_vm86+358>
0x0210e8ce <do_sys_vm86+110>:   movl   $0x247000,0x5bc(%esi)
0x0210e8d8 <do_sys_vm86+120>:   mov    0xbc(%edi),%eax
0x0210e8de <do_sys_vm86+126>:   movl   $0x0,0x18(%eax)
0x0210e8e5 <do_sys_vm86+133>:   mov    0x360(%esi),%eax
0x0210e8eb <do_sys_vm86+139>:   mov    %eax,0x5c0(%esi)
0x0210e8f1 <do_sys_vm86+145>:   movl   %fs,0x5c4(%esi)
0x0210e8f7 <do_sys_vm86+151>:   movl   %gs,0x5c8(%esi)
0x0210e8fd <do_sys_vm86+157>:   mov    $0xffffe000,%ebx
0x0210e902 <do_sys_vm86+162>:   and    %esp,%ebx
0x0210e904 <do_sys_vm86+164>:   mov    0x14(%ebx),%eax
0x0210e907 <do_sys_vm86+167>:   inc    %eax
0x0210e908 <do_sys_vm86+168>:   mov    %eax,0x14(%ebx)
0x0210e90b <do_sys_vm86+171>:   mov    0x10(%ebx),%eax
0x0210e90e <do_sys_vm86+174>:   mov    0x4(%esi),%edx
0x0210e911 <do_sys_vm86+177>:   shl    $0x9,%eax
0x0210e914 <do_sys_vm86+180>:   lea    0x26ff000(%eax),%ecx
0x0210e91a <do_sys_vm86+186>:   lea    0x4c(%edi),%eax
0x0210e91d <do_sys_vm86+189>:   mov    %eax,0x360(%esi)
0x0210e923 <do_sys_vm86+195>:   sub    0x1c(%edx),%eax
0x0210e926 <do_sys_vm86+198>:   add    0x20(%edx),%eax
0x0210e929 <do_sys_vm86+201>:   mov    %eax,0x4(%ecx)
0x0210e92c <do_sys_vm86+204>:   mov    0x25fe52c,%eax
0x0210e931 <do_sys_vm86+209>:   test   $0x800,%eax
0x0210e936 <do_sys_vm86+214>:   je     0x210e942 <do_sys_vm86+226>
0x0210e938 <do_sys_vm86+216>:   movl   $0x0,0x364(%esi)
0x0210e942 <do_sys_vm86+226>:   lea    0x340(%esi),%edx
0x0210e948 <do_sys_vm86+232>:   mov    0x20(%edx),%eax
0x0210e94b <do_sys_vm86+235>:   mov    %eax,0x4(%ecx)
0x0210e94e <do_sys_vm86+238>:   mov    0x10(%ecx),%ax
0x0210e952 <do_sys_vm86+242>:   and    $0xffff,%eax
0x0210e957 <do_sys_vm86+247>:   cmp    0x24(%edx),%eax
0x0210e95a <do_sys_vm86+250>:   jne    0x210e9b0 <do_sys_vm86+336>
0x0210e95c <do_sys_vm86+252>:   mov    0x14(%ebx),%eax
0x0210e95f <do_sys_vm86+255>:   dec    %eax
0x0210e960 <do_sys_vm86+256>:   mov    %eax,0x14(%ebx)
0x0210e963 <do_sys_vm86+259>:   mov    0x8(%ebx),%eax
0x0210e966 <do_sys_vm86+262>:   and    $0x8,%eax
0x0210e969 <do_sys_vm86+265>:   jne    0x210e9a9 <do_sys_vm86+329>
0x0210e96b <do_sys_vm86+267>:   push   $0x255f121
0x0210e970 <do_sys_vm86+272>:   call   0x21285a0 <printk>
0x0210e975 <do_sys_vm86+277>:   mov    0x50(%edi),%eax
0x0210e978 <do_sys_vm86+280>:   mov    %eax,0x5b4(%esi)
0x0210e97e <do_sys_vm86+286>:   pop    %eax
0x0210e97f <do_sys_vm86+287>:   testb  $0x1,0x4c(%edi)
0x0210e983 <do_sys_vm86+291>:   jne    0x210e9a0 <do_sys_vm86+320>
0x0210e985 <do_sys_vm86+293>:   mov    0x4(%esi),%edx
0x0210e988 <do_sys_vm86+296>:   xor    %eax,%eax
0x0210e98a <do_sys_vm86+298>:   mov    %eax,%fs
0x0210e98c <do_sys_vm86+300>:   mov    %eax,%gs
0x0210e98e <do_sys_vm86+302>:   mov    %edi,%esp
0x0210e990 <do_sys_vm86+304>:   mov    %edx,%ebp
0x0210e992 <do_sys_vm86+306>:   jmp    0xfffeb100 <resume_userspace>
0x0210e997 <do_sys_vm86+311>:   pop    %ebx
0x0210e998 <do_sys_vm86+312>:   pop    %esi
0x0210e999 <do_sys_vm86+313>:   pop    %edi
0x0210e99a <do_sys_vm86+314>:   ret
0x0210e99b <do_sys_vm86+315>:   nop
0x0210e99c <do_sys_vm86+316>:   lea    0x0(%esi,1),%esi
0x0210e9a0 <do_sys_vm86+320>:   push   %esi
0x0210e9a1 <do_sys_vm86+321>:   call   0x210e5b0 <mark_screen_rdonly>
0x0210e9a6 <do_sys_vm86+326>:   pop    %eax
0x0210e9a7 <do_sys_vm86+327>:   jmp    0x210e985 <do_sys_vm86+293>
0x0210e9a9 <do_sys_vm86+329>:   call   0x21222d0 <preempt_schedule>
0x0210e9ae <do_sys_vm86+334>:   jmp    0x210e96b <do_sys_vm86+267>
0x0210e9b0 <do_sys_vm86+336>:   mov    0x24(%edx),%ax
0x0210e9b4 <do_sys_vm86+340>:   mov    %ax,0x10(%ecx)
0x0210e9b8 <do_sys_vm86+344>:   mov    $0x174,%ecx
0x0210e9bd <do_sys_vm86+349>:   mov    0x24(%edx),%eax
0x0210e9c0 <do_sys_vm86+352>:   xor    %edx,%edx
0x0210e9c2 <do_sys_vm86+354>:   wrmsr
0x0210e9c4 <do_sys_vm86+356>:   jmp    0x210e95c <do_sys_vm86+252>
0x0210e9c6 <do_sys_vm86+358>:   movl   $0x0,0x5bc(%esi)
0x0210e9d0 <do_sys_vm86+368>:   jmp    0x210e8d8 <do_sys_vm86+120>
0x0210e9d5 <do_sys_vm86+373>:   cmp    $0x4,%eax
0x0210e9d8 <do_sys_vm86+376>:   jne    0x210e8ce <do_sys_vm86+110>
0x0210e9de <do_sys_vm86+382>:   movl   $0x47000,0x5bc(%esi)
0x0210e9e8 <do_sys_vm86+392>:   jmp    0x210e8d8 <do_sys_vm86+120>
0x0210e9ed <do_sys_vm86+397>:   lea    0x0(%esi),%esi
0x0210e9f0 <do_sys_vm86+400>:   movl   $0x7000,0x5bc(%esi)
0x0210e9fa <do_sys_vm86+410>:   jmp    0x210e8d8 <do_sys_vm86+120>

Without the fix:
0x0210e860 <do_sys_vm86+0>:     push   %edi
0x0210e861 <do_sys_vm86+1>:     mov    $0xffffe000,%eax
0x0210e866 <do_sys_vm86+6>:     push   %esi
0x0210e867 <do_sys_vm86+7>:     and    %esp,%eax
0x0210e869 <do_sys_vm86+9>:     push   %ebx
0x0210e86a <do_sys_vm86+10>:    mov    0x10(%esp,1),%edi
0x0210e86e <do_sys_vm86+14>:    mov    0x14(%esp,1),%esi
0x0210e872 <do_sys_vm86+18>:    movl   $0x0,0x1c(%edi)
0x0210e879 <do_sys_vm86+25>:    movl   $0x0,0x20(%edi)
0x0210e880 <do_sys_vm86+32>:    mov    (%eax),%edx
0x0210e882 <do_sys_vm86+34>:    mov    0x30(%edi),%eax
0x0210e885 <do_sys_vm86+37>:    mov    %eax,0x5b8(%edx)
0x0210e88b <do_sys_vm86+43>:    mov    0x30(%edi),%edx
0x0210e88e <do_sys_vm86+46>:    mov    0xbc(%edi),%eax
0x0210e894 <do_sys_vm86+52>:    and    $0xdd5,%edx
0x0210e89a <do_sys_vm86+58>:    mov    %edx,0x30(%edi)
0x0210e89d <do_sys_vm86+61>:    mov    0x30(%eax),%eax
0x0210e8a0 <do_sys_vm86+64>:    and    $0xfffff22a,%eax
0x0210e8a5 <do_sys_vm86+69>:    or     %eax,%edx
0x0210e8a7 <do_sys_vm86+71>:    mov    0x54(%edi),%eax
0x0210e8aa <do_sys_vm86+74>:    or     $0x20000,%edx
0x0210e8b0 <do_sys_vm86+80>:    cmp    $0x3,%eax
0x0210e8b3 <do_sys_vm86+83>:    mov    %edx,0x30(%edi)
0x0210e8b6 <do_sys_vm86+86>:    je     0x210e9e0 <do_sys_vm86+384>
0x0210e8bc <do_sys_vm86+92>:    cmp    $0x3,%eax
0x0210e8bf <do_sys_vm86+95>:    ja     0x210e9c5 <do_sys_vm86+357>
0x0210e8c5 <do_sys_vm86+101>:   cmp    $0x2,%eax
0x0210e8c8 <do_sys_vm86+104>:   je     0x210e9b6 <do_sys_vm86+342>
0x0210e8ce <do_sys_vm86+110>:   movl   $0x247000,0x5bc(%esi)
0x0210e8d8 <do_sys_vm86+120>:   mov    0xbc(%edi),%eax
0x0210e8de <do_sys_vm86+126>:   movl   $0x0,0x18(%eax)
0x0210e8e5 <do_sys_vm86+133>:   mov    0x360(%esi),%eax
0x0210e8eb <do_sys_vm86+139>:   mov    %eax,0x5c0(%esi)
0x0210e8f1 <do_sys_vm86+145>:   movl   %fs,0x5c4(%esi)
0x0210e8f7 <do_sys_vm86+151>:   movl   %gs,0x5c8(%esi)
0x0210e8fd <do_sys_vm86+157>:   mov    $0xffffe000,%ebx
0x0210e902 <do_sys_vm86+162>:   and    %esp,%ebx
0x0210e904 <do_sys_vm86+164>:   mov    0x14(%ebx),%eax
0x0210e907 <do_sys_vm86+167>:   inc    %eax
0x0210e908 <do_sys_vm86+168>:   mov    %eax,0x14(%ebx)
0x0210e90b <do_sys_vm86+171>:   mov    0x10(%ebx),%eax
0x0210e90e <do_sys_vm86+174>:   mov    0x4(%esi),%edx
0x0210e911 <do_sys_vm86+177>:   shl    $0x9,%eax
0x0210e914 <do_sys_vm86+180>:   lea    0x26ff000(%eax),%ecx
0x0210e91a <do_sys_vm86+186>:   lea    0x4c(%edi),%eax
0x0210e91d <do_sys_vm86+189>:   mov    %eax,0x360(%esi)
0x0210e923 <do_sys_vm86+195>:   sub    0x1c(%edx),%eax
0x0210e926 <do_sys_vm86+198>:   add    0x20(%edx),%eax
0x0210e929 <do_sys_vm86+201>:   mov    %eax,0x4(%ecx)
0x0210e92c <do_sys_vm86+204>:   mov    0x25fe52c,%eax
0x0210e931 <do_sys_vm86+209>:   test   $0x800,%eax
0x0210e936 <do_sys_vm86+214>:   je     0x210e942 <do_sys_vm86+226>
0x0210e938 <do_sys_vm86+216>:   movl   $0x0,0x364(%esi)
0x0210e942 <do_sys_vm86+226>:   lea    0x340(%esi),%edx
0x0210e948 <do_sys_vm86+232>:   mov    0x20(%edx),%eax
0x0210e94b <do_sys_vm86+235>:   mov    %eax,0x4(%ecx)
0x0210e94e <do_sys_vm86+238>:   mov    0x10(%ecx),%ax
0x0210e952 <do_sys_vm86+242>:   and    $0xffff,%eax
0x0210e957 <do_sys_vm86+247>:   cmp    0x24(%edx),%eax
0x0210e95a <do_sys_vm86+250>:   jne    0x210e9a0 <do_sys_vm86+320>
0x0210e95c <do_sys_vm86+252>:   mov    0x14(%ebx),%eax
0x0210e95f <do_sys_vm86+255>:   dec    %eax
0x0210e960 <do_sys_vm86+256>:   mov    %eax,0x14(%ebx)
0x0210e963 <do_sys_vm86+259>:   mov    0x8(%ebx),%eax
0x0210e966 <do_sys_vm86+262>:   and    $0x8,%eax
0x0210e969 <do_sys_vm86+265>:   jne    0x210e999 <do_sys_vm86+313>
0x0210e96b <do_sys_vm86+267>:   mov    0x50(%edi),%eax
0x0210e96e <do_sys_vm86+270>:   mov    %eax,0x5b4(%esi)
0x0210e974 <do_sys_vm86+276>:   testb  $0x1,0x4c(%edi)
0x0210e978 <do_sys_vm86+280>:   jne    0x210e990 <do_sys_vm86+304>
0x0210e97a <do_sys_vm86+282>:   mov    0x4(%esi),%edx
0x0210e97d <do_sys_vm86+285>:   xor    %eax,%eax
0x0210e97f <do_sys_vm86+287>:   mov    %eax,%fs
0x0210e981 <do_sys_vm86+289>:   mov    %eax,%gs
0x0210e983 <do_sys_vm86+291>:   mov    %edi,%esp
0x0210e985 <do_sys_vm86+293>:   mov    %edx,%ebp
0x0210e987 <do_sys_vm86+295>:   jmp    0xfffeb100 <resume_userspace>
0x0210e98c <do_sys_vm86+300>:   pop    %ebx
0x0210e98d <do_sys_vm86+301>:   pop    %esi
0x0210e98e <do_sys_vm86+302>:   pop    %edi
0x0210e98f <do_sys_vm86+303>:   ret
0x0210e990 <do_sys_vm86+304>:   push   %esi
0x0210e991 <do_sys_vm86+305>:   call   0x210e5b0 <mark_screen_rdonly>
0x0210e996 <do_sys_vm86+310>:   pop    %eax
0x0210e997 <do_sys_vm86+311>:   jmp    0x210e97a <do_sys_vm86+282>
0x0210e999 <do_sys_vm86+313>:   call   0x21222c0 <preempt_schedule>
0x0210e99e <do_sys_vm86+318>:   jmp    0x210e96b <do_sys_vm86+267>
0x0210e9a0 <do_sys_vm86+320>:   mov    0x24(%edx),%ax
0x0210e9a4 <do_sys_vm86+324>:   mov    %ax,0x10(%ecx)
0x0210e9a8 <do_sys_vm86+328>:   mov    $0x174,%ecx
0x0210e9ad <do_sys_vm86+333>:   mov    0x24(%edx),%eax
0x0210e9b0 <do_sys_vm86+336>:   xor    %edx,%edx
0x0210e9b2 <do_sys_vm86+338>:   wrmsr
0x0210e9b4 <do_sys_vm86+340>:   jmp    0x210e95c <do_sys_vm86+252>
0x0210e9b6 <do_sys_vm86+342>:   movl   $0x0,0x5bc(%esi)
0x0210e9c0 <do_sys_vm86+352>:   jmp    0x210e8d8 <do_sys_vm86+120>
0x0210e9c5 <do_sys_vm86+357>:   cmp    $0x4,%eax
0x0210e9c8 <do_sys_vm86+360>:   jne    0x210e8ce <do_sys_vm86+110>
0x0210e9ce <do_sys_vm86+366>:   movl   $0x47000,0x5bc(%esi)
0x0210e9d8 <do_sys_vm86+376>:   jmp    0x210e8d8 <do_sys_vm86+120>
0x0210e9dd <do_sys_vm86+381>:   lea    0x0(%esi),%esi
0x0210e9e0 <do_sys_vm86+384>:   movl   $0x7000,0x5bc(%esi)
0x0210e9ea <do_sys_vm86+394>:   jmp    0x210e8d8 <do_sys_vm86+120>
