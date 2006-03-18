Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751118AbWCRXNb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751118AbWCRXNb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 18:13:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751124AbWCRXNb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 18:13:31 -0500
Received: from smtp.osdl.org ([65.172.181.4]:26037 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751118AbWCRXNa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 18:13:30 -0500
Date: Sat, 18 Mar 2006 15:12:59 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Parag Warudkar <kernel-stuff@comcast.net>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       alex-kernel@digriz.org.uk, jun.nakajima@intel.com,
       Dave Jones <davej@redhat.com>
Subject: Re: OOPS: 2.6.16-rc6 cpufreq_conservative
In-Reply-To: <200603181709.12175.kernel-stuff@comcast.net>
Message-ID: <Pine.LNX.4.64.0603181455110.3826@g5.osdl.org>
References: <200603181525.14127.kernel-stuff@comcast.net>
 <Pine.LNX.4.64.0603181321310.3826@g5.osdl.org> <200603181709.12175.kernel-stuff@comcast.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 18 Mar 2006, Parag Warudkar wrote:
>
> Here is the disassembly of cpufrequency_conservative.o:dbs_check_cpu() from my 
> setup, if it is of any help.

Yup. Just confirming that this seems to be what I was pointing to.

It's the first "for_each_online_cpu()" loop: the reason it's pretty far 
down in the function disassembly is that the early "init_flag == 0" test 
jumps off into the latter part of the thing, even though the code is 
early. That's just gcc re-ordering stuff.

> 000004b0 <dbs_check_cpu>:
>  4b0:   55                      push   %ebp
>  4b1:   bd 00 00 00 00          mov    $0x0,%ebp
>  4b6:   89 e8                   mov    %ebp,%eax
>  4b8:   57                      push   %edi
>  4b9:   56                      push   %esi
>  4ba:   53                      push   %ebx
>  4bb:   83 ec 10                sub    $0x10,%esp
>  4be:   8b 54 24 24             mov    0x24(%esp),%edx
>  4c2:   8b 0c 95 00 00 00 00    mov    0x0(,%edx,4),%ecx
>  4c9:   01 c8                   add    %ecx,%eax
>  4cb:   8b 50 0c                mov    0xc(%eax),%edx
>  4ce:   85 d2                   test   %edx,%edx
>  4d0:   0f 84 ba 01 00 00       je     690 <dbs_check_cpu+0x1e0>

This is the "init_flag == 0" test:

>  4d6:   66 83 3d 10 00 00 00    cmpw   $0x0,0x10
>  4dd:   00
>  4de:   8b 00                   mov    (%eax),%eax
>  4e0:   89 44 24 0c             mov    %eax,0xc(%esp)
>  4e4:   0f 84 ae 01 00 00       je     698 <dbs_check_cpu+0x1e8>
.......

This is

	for_each_online_cpu(j) {
>  698:   a1 00 00 00 00          mov    0x0,%eax
>  69d:   85 c0                   test   %eax,%eax
>  69f:   0f 84 e3 01 00 00       je     888 <dbs_check_cpu+0x3d8>
>  6a5:   0f bc c0                bsf    %eax,%eax
>  6a8:   83 f8 03                cmp    $0x3,%eax
>  6ab:   bb 02 00 00 00          mov    $0x2,%ebx
>  6b0:   0f 4c d8                cmovl  %eax,%ebx
>  6b3:   83 fb 01                cmp    $0x1,%ebx
>  6b6:   77 49                   ja     701 <dbs_check_cpu+0x251>
>  6b8:   89 ee                   mov    %ebp,%esi
>  6ba:   8d b6 00 00 00 00       lea    0x0(%esi),%esi


	dbs_info = &per_cpu(cpu_dbs_info, j);


>  6c0:   8b 04 9d 00 00 00 00    mov    0x0(,%ebx,4),%eax
>  6c7:   bf 02 00 00 00          mov    $0x2,%edi
>  6cc:   01 f0                   add    %esi,%eax
>  6ce:   8b 00                   mov    (%eax),%eax

And this is the oopsing instruction:

>  6d0:   8b 40 1c                mov    0x1c(%eax),%eax
>  6d3:   89 7c 24 04             mov    %edi,0x4(%esp)
>  6d7:   c7 04 24 00 00 00 00    movl   $0x0,(%esp)

And this is the "requested_freq[j]" assignment:

>  6de:   89 04 9d 08 00 00 00    mov    %eax,0x8(,%ebx,4)
>  6e5:   8d 43 01                lea    0x1(%ebx),%eax
>  6e8:   bb 02 00 00 00          mov    $0x2,%ebx
>  6ed:   89 44 24 08             mov    %eax,0x8(%esp)

This is really a "call find_next_bit"

>  6f1:   e8 fc ff ff ff          call   6f2 <dbs_check_cpu+0x242>
>  6f6:   83 f8 03                cmp    $0x3,%eax
>  6f9:   0f 4c d8                cmovl  %eax,%ebx
>  6fc:   83 fb 01                cmp    $0x1,%ebx
>  6ff:   76 bf                   jbe    6c0 <dbs_check_cpu+0x210>

And that wass the end of that loop:

>  701:   8b 4c 24 0c             mov    0xc(%esp),%ecx
>  705:   bb 01 00 00 00          mov    $0x1,%ebx
>  70a:   bf ff ff ff ff          mov    $0xffffffff,%edi
>  70f:   66 89 1d 10 00 00 00    mov    %bx,0x10

And that was setting "init_flag = 1"

Horrid, horrid assembly language from that simple "for_each_online_cpu(j)" 
loop. Oh, well.

		Linus
