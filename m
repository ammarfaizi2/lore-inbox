Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261929AbTKQXSC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Nov 2003 18:18:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261947AbTKQXSC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Nov 2003 18:18:02 -0500
Received: from modemcable137.219-201-24.mc.videotron.ca ([24.201.219.137]:6784
	"EHLO montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S261929AbTKQXR5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Nov 2003 18:17:57 -0500
Date: Mon, 17 Nov 2003 18:14:59 -0500 (EST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
cc: Ingo Molnar <mingo@elte.hu>, "Martin J. Bligh" <mbligh@aracnet.com>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
       Hugh Dickins <hugh@veritas.com>
Subject: Re: [PATCH][2.6-mm] Fix 4G/4G X11/vm86 oops
In-Reply-To: <Pine.LNX.4.53.0311171749590.30079@montezuma.fsmlabs.com>
Message-ID: <Pine.LNX.4.53.0311171813410.30079@montezuma.fsmlabs.com>
References: <Pine.LNX.4.44.0311171441380.8840-100000@home.osdl.org>
 <Pine.LNX.4.53.0311171749590.30079@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Nov 2003, Zwane Mwaikambo wrote:

> On Mon, 17 Nov 2003, Linus Torvalds wrote:
> 
> > What's the generated assembly language for this function with and without 
> > the "fix"?
> > 
> > If adding that printk fixes a triple fault, the issue is not likely to be 
> > the printk itself as much as the difference in code that the compiler 
> > generates - stack frame, memory re-ordering etc...
> 
> This would be my 'trusty' gcc 3.2.2 from RedHat 9
> (gcc version 3.2.2 20030222 (Red Hat Linux 3.2.2-5)

A little bird told me to send diffs... But there is a lot of noise due to 
offsets i'm afraid.

--- buggy	2003-11-17 18:09:35.302964248 -0500
+++ works	2003-11-17 18:09:47.744072912 -0500
@@ -21,11 +21,11 @@
 0x0210e8aa <do_sys_vm86+74>:    or     $0x20000,%edx
 0x0210e8b0 <do_sys_vm86+80>:    cmp    $0x3,%eax
 0x0210e8b3 <do_sys_vm86+83>:    mov    %edx,0x30(%edi)
-0x0210e8b6 <do_sys_vm86+86>:    je     0x210e9e0 <do_sys_vm86+384>
+0x0210e8b6 <do_sys_vm86+86>:    je     0x210e9f0 <do_sys_vm86+400>
 0x0210e8bc <do_sys_vm86+92>:    cmp    $0x3,%eax
-0x0210e8bf <do_sys_vm86+95>:    ja     0x210e9c5 <do_sys_vm86+357>
+0x0210e8bf <do_sys_vm86+95>:    ja     0x210e9d5 <do_sys_vm86+373>
 0x0210e8c5 <do_sys_vm86+101>:   cmp    $0x2,%eax
-0x0210e8c8 <do_sys_vm86+104>:   je     0x210e9b6 <do_sys_vm86+342>
+0x0210e8c8 <do_sys_vm86+104>:   je     0x210e9c6 <do_sys_vm86+358>
 0x0210e8ce <do_sys_vm86+110>:   movl   $0x247000,0x5bc(%esi)
 0x0210e8d8 <do_sys_vm86+120>:   mov    0xbc(%edi),%eax
 0x0210e8de <do_sys_vm86+126>:   movl   $0x0,0x18(%eax)
@@ -57,47 +57,52 @@
 0x0210e94e <do_sys_vm86+238>:   mov    0x10(%ecx),%ax
 0x0210e952 <do_sys_vm86+242>:   and    $0xffff,%eax
 0x0210e957 <do_sys_vm86+247>:   cmp    0x24(%edx),%eax
-0x0210e95a <do_sys_vm86+250>:   jne    0x210e9a0 <do_sys_vm86+320>
+0x0210e95a <do_sys_vm86+250>:   jne    0x210e9b0 <do_sys_vm86+336>
 0x0210e95c <do_sys_vm86+252>:   mov    0x14(%ebx),%eax
 0x0210e95f <do_sys_vm86+255>:   dec    %eax
 0x0210e960 <do_sys_vm86+256>:   mov    %eax,0x14(%ebx)
 0x0210e963 <do_sys_vm86+259>:   mov    0x8(%ebx),%eax
 0x0210e966 <do_sys_vm86+262>:   and    $0x8,%eax
-0x0210e969 <do_sys_vm86+265>:   jne    0x210e999 <do_sys_vm86+313>
-0x0210e96b <do_sys_vm86+267>:   mov    0x50(%edi),%eax
-0x0210e96e <do_sys_vm86+270>:   mov    %eax,0x5b4(%esi)
-0x0210e974 <do_sys_vm86+276>:   testb  $0x1,0x4c(%edi)
-0x0210e978 <do_sys_vm86+280>:   jne    0x210e990 <do_sys_vm86+304>
-0x0210e97a <do_sys_vm86+282>:   mov    0x4(%esi),%edx
-0x0210e97d <do_sys_vm86+285>:   xor    %eax,%eax
-0x0210e97f <do_sys_vm86+287>:   mov    %eax,%fs
-0x0210e981 <do_sys_vm86+289>:   mov    %eax,%gs
-0x0210e983 <do_sys_vm86+291>:   mov    %edi,%esp
-0x0210e985 <do_sys_vm86+293>:   mov    %edx,%ebp
-0x0210e987 <do_sys_vm86+295>:   jmp    0xfffeb100 <resume_userspace>
-0x0210e98c <do_sys_vm86+300>:   pop    %ebx
-0x0210e98d <do_sys_vm86+301>:   pop    %esi
-0x0210e98e <do_sys_vm86+302>:   pop    %edi
-0x0210e98f <do_sys_vm86+303>:   ret
-0x0210e990 <do_sys_vm86+304>:   push   %esi
-0x0210e991 <do_sys_vm86+305>:   call   0x210e5b0 <mark_screen_rdonly>
-0x0210e996 <do_sys_vm86+310>:   pop    %eax
-0x0210e997 <do_sys_vm86+311>:   jmp    0x210e97a <do_sys_vm86+282>
-0x0210e999 <do_sys_vm86+313>:   call   0x21222c0 <preempt_schedule>
-0x0210e99e <do_sys_vm86+318>:   jmp    0x210e96b <do_sys_vm86+267>
-0x0210e9a0 <do_sys_vm86+320>:   mov    0x24(%edx),%ax
-0x0210e9a4 <do_sys_vm86+324>:   mov    %ax,0x10(%ecx)
-0x0210e9a8 <do_sys_vm86+328>:   mov    $0x174,%ecx
-0x0210e9ad <do_sys_vm86+333>:   mov    0x24(%edx),%eax
-0x0210e9b0 <do_sys_vm86+336>:   xor    %edx,%edx
-0x0210e9b2 <do_sys_vm86+338>:   wrmsr
-0x0210e9b4 <do_sys_vm86+340>:   jmp    0x210e95c <do_sys_vm86+252>
-0x0210e9b6 <do_sys_vm86+342>:   movl   $0x0,0x5bc(%esi)
-0x0210e9c0 <do_sys_vm86+352>:   jmp    0x210e8d8 <do_sys_vm86+120>
-0x0210e9c5 <do_sys_vm86+357>:   cmp    $0x4,%eax
-0x0210e9c8 <do_sys_vm86+360>:   jne    0x210e8ce <do_sys_vm86+110>
-0x0210e9ce <do_sys_vm86+366>:   movl   $0x47000,0x5bc(%esi)
-0x0210e9d8 <do_sys_vm86+376>:   jmp    0x210e8d8 <do_sys_vm86+120>
-0x0210e9dd <do_sys_vm86+381>:   lea    0x0(%esi),%esi
-0x0210e9e0 <do_sys_vm86+384>:   movl   $0x7000,0x5bc(%esi)
-0x0210e9ea <do_sys_vm86+394>:   jmp    0x210e8d8 <do_sys_vm86+120>
+0x0210e969 <do_sys_vm86+265>:   jne    0x210e9a9 <do_sys_vm86+329>
+0x0210e96b <do_sys_vm86+267>:   push   $0x255f121
+0x0210e970 <do_sys_vm86+272>:   call   0x21285a0 <printk>
+0x0210e975 <do_sys_vm86+277>:   mov    0x50(%edi),%eax
+0x0210e978 <do_sys_vm86+280>:   mov    %eax,0x5b4(%esi)
+0x0210e97e <do_sys_vm86+286>:   pop    %eax
+0x0210e97f <do_sys_vm86+287>:   testb  $0x1,0x4c(%edi)
+0x0210e983 <do_sys_vm86+291>:   jne    0x210e9a0 <do_sys_vm86+320>
+0x0210e985 <do_sys_vm86+293>:   mov    0x4(%esi),%edx
+0x0210e988 <do_sys_vm86+296>:   xor    %eax,%eax
+0x0210e98a <do_sys_vm86+298>:   mov    %eax,%fs
+0x0210e98c <do_sys_vm86+300>:   mov    %eax,%gs
+0x0210e98e <do_sys_vm86+302>:   mov    %edi,%esp
+0x0210e990 <do_sys_vm86+304>:   mov    %edx,%ebp
+0x0210e992 <do_sys_vm86+306>:   jmp    0xfffeb100 <resume_userspace>
+0x0210e997 <do_sys_vm86+311>:   pop    %ebx
+0x0210e998 <do_sys_vm86+312>:   pop    %esi
+0x0210e999 <do_sys_vm86+313>:   pop    %edi
+0x0210e99a <do_sys_vm86+314>:   ret
+0x0210e99b <do_sys_vm86+315>:   nop
+0x0210e99c <do_sys_vm86+316>:   lea    0x0(%esi,1),%esi
+0x0210e9a0 <do_sys_vm86+320>:   push   %esi
+0x0210e9a1 <do_sys_vm86+321>:   call   0x210e5b0 <mark_screen_rdonly>
+0x0210e9a6 <do_sys_vm86+326>:   pop    %eax
+0x0210e9a7 <do_sys_vm86+327>:   jmp    0x210e985 <do_sys_vm86+293>
+0x0210e9a9 <do_sys_vm86+329>:   call   0x21222d0 <preempt_schedule>
+0x0210e9ae <do_sys_vm86+334>:   jmp    0x210e96b <do_sys_vm86+267>
+0x0210e9b0 <do_sys_vm86+336>:   mov    0x24(%edx),%ax
+0x0210e9b4 <do_sys_vm86+340>:   mov    %ax,0x10(%ecx)
+0x0210e9b8 <do_sys_vm86+344>:   mov    $0x174,%ecx
+0x0210e9bd <do_sys_vm86+349>:   mov    0x24(%edx),%eax
+0x0210e9c0 <do_sys_vm86+352>:   xor    %edx,%edx
+0x0210e9c2 <do_sys_vm86+354>:   wrmsr
+0x0210e9c4 <do_sys_vm86+356>:   jmp    0x210e95c <do_sys_vm86+252>
+0x0210e9c6 <do_sys_vm86+358>:   movl   $0x0,0x5bc(%esi)
+0x0210e9d0 <do_sys_vm86+368>:   jmp    0x210e8d8 <do_sys_vm86+120>
+0x0210e9d5 <do_sys_vm86+373>:   cmp    $0x4,%eax
+0x0210e9d8 <do_sys_vm86+376>:   jne    0x210e8ce <do_sys_vm86+110>
+0x0210e9de <do_sys_vm86+382>:   movl   $0x47000,0x5bc(%esi)
+0x0210e9e8 <do_sys_vm86+392>:   jmp    0x210e8d8 <do_sys_vm86+120>
+0x0210e9ed <do_sys_vm86+397>:   lea    0x0(%esi),%esi
+0x0210e9f0 <do_sys_vm86+400>:   movl   $0x7000,0x5bc(%esi)
+0x0210e9fa <do_sys_vm86+410>:   jmp    0x210e8d8 <do_sys_vm86+120>
