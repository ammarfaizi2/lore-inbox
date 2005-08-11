Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751144AbVHKR0o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751144AbVHKR0o (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 13:26:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751145AbVHKR0n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 13:26:43 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:54413 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751144AbVHKR0n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 13:26:43 -0400
Subject: Re: Need help in understanding x86 syscall
From: Steven Rostedt <rostedt@goodmis.org>
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
Cc: Coywolf Qi Hunt <coywolf@gmail.com>, 7eggert@gmx.de,
       Ukil a <ukil_a@yahoo.com>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0508111310180.15153@chaos.analogic.com>
References: <4Ae73-6Mm-5@gated-at.bofh.it> <E1E3DJm-0000jy-0B@be1.lrz>
	 <Pine.LNX.4.61.0508110954360.14541@chaos.analogic.com>
	 <1123770661.17269.59.camel@localhost.localdomain>
	 <2cd57c90050811081374d7c4ef@mail.gmail.com>
	 <Pine.LNX.4.61.0508111124530.14789@chaos.analogic.com>
	 <1123775508.17269.64.camel@localhost.localdomain>
	 <1123777184.17269.67.camel@localhost.localdomain>
	 <2cd57c90050811093112a57982@mail.gmail.com>
	 <2cd57c9005081109597b18cc54@mail.gmail.com>
	 <Pine.LNX.4.61.0508111310180.15153@chaos.analogic.com>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Thu, 11 Aug 2005 13:26:27 -0400
Message-Id: <1123781187.17269.77.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-08-11 at 13:10 -0400, linux-os (Dick Johnson) wrote:
> On Thu, 11 Aug 2005, Coywolf Qi Hunt wrote:

> >>
> >
> > Also glibc support.
> >
> > --
> > Coywolf Qi Hunt
> > http://ahbl.org/~coywolf/
> 
> Probably doesn't use int 0x80 at all.

$ objdump -Dhalpr /lib/libc.so.6 | egrep 'int *\$0x80' | wc 
   448    2240   20160

And a little snapshot:

000288d0 <__libc_sigsuspend>:
   288d0:       55                      push   %ebp
   288d1:       89 e5                   mov    %esp,%ebp
   288d3:       57                      push   %edi
   288d4:       56                      push   %esi
   288d5:       53                      push   %ebx
   288d6:       e8 00 00 00 00          call   288db <__libc_sigsuspend+0xb>
   288db:       5b                      pop    %ebx
   288dc:       81 c3 19 c7 0e 00       add    $0xec719,%ebx
   288e2:       8b 83 b4 32 00 00       mov    0x32b4(%ebx),%eax
   288e8:       85 c0                   test   %eax,%eax
   288ea:       75 23                   jne    2890f <__libc_sigsuspend+0x3f>
   288ec:       b9 08 00 00 00          mov    $0x8,%ecx
   288f1:       8b 55 08                mov    0x8(%ebp),%edx
   288f4:       87 d3                   xchg   %edx,%ebx
   288f6:       b8 b3 00 00 00          mov    $0xb3,%eax
   288fb:       cd 80                   int    $0x80
   288fd:       87 d3                   xchg   %edx,%ebx
   288ff:       89 c6                   mov    %eax,%esi
   28901:       3d 00 f0 ff ff          cmp    $0xfffff000,%eax
   28906:       77 33                   ja     2893b <__libc_sigsuspend+0x6b>
   28908:       89 f0                   mov    %esi,%eax
   2890a:       5b                      pop    %ebx
   2890b:       5e                      pop    %esi
   2890c:       5f                      pop    %edi
   2890d:       5d                      pop    %ebp
   2890e:       c3                      ret

288fb seems to use "int 0x80"  and so do all the other system calls that
I inspected.

$ ls -l /lib/libc.so.6
lrwxrwxrwx  1 root root 13 2005-08-09 22:28 /lib/libc.so.6 -> libc-2.3.5.so


-- Steve


