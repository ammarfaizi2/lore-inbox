Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932344AbVHKSRi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932344AbVHKSRi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 14:17:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932346AbVHKSRi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 14:17:38 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:20664 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932344AbVHKSRh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 14:17:37 -0400
Subject: Re: Need help in understanding x86 syscall
From: Steven Rostedt <rostedt@goodmis.org>
To: Zachary Amsden <zach@vmware.com>
Cc: "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       Coywolf Qi Hunt <coywolf@gmail.com>, 7eggert@gmx.de,
       Ukil a <ukil_a@yahoo.com>, linux-kernel@vger.kernel.org
In-Reply-To: <42FB91FA.7070104@vmware.com>
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
	 <1123781187.17269.77.camel@localhost.localdomain>
	 <1123781639.17269.83.camel@localhost.localdomain>
	 <42FB91FA.7070104@vmware.com>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Thu, 11 Aug 2005 14:17:28 -0400
Message-Id: <1123784248.17269.93.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-08-11 at 10:59 -0700, Zachary Amsden wrote:
> 
> zach-dev2:~ $ ldd /bin/ls
>         linux-gate.so.1 =>  (0xffffe000)

OHHH! So THAT is what linux-gate is used for! Thanks, I've been really
confused by that.

> 
> This is the vsyscall entry point, which gets linked by ld into all 
> processes.  It is a kernel page which is visible to user space, and is 
> rewritten to support sysenter if indeed that instruction is available.  
> Glibc has fixed entry points to this page.  Here is a view of the system 
> call entry point on a machine which supports sysenter:
> 
> (gdb) break _init
> Breakpoint 1 at 0x8049522
> (gdb) run
> Starting program: /bin/ls
> (no debugging symbols found)...[Thread debugging using libthread_db enabled]
> [New Thread 1075283616 (LWP 5328)]
> [Switching to Thread 1075283616 (LWP 5328)]
> 
> Breakpoint 1, 0x08049522 in _init ()
> (gdb) x/10i 0xffffe400
> 0xffffe400:     push   %ecx
> 0xffffe401:     push   %edx
> 0xffffe402:     push   %ebp
> 0xffffe403:     mov    %esp,%ebp
> 0xffffe405:     sysenter
> 0xffffe407:     nop   
> 0xffffe408:     nop   
> 0xffffe409:     nop   
> 0xffffe40a:     nop   
> 0xffffe40b:     nop   
> 

OK, I get the same on my machine.

> On a machine that does not support sysenter, this will give you:
> 
> int $0x80
> ret
> 
> The int $0x80 system calls are still fully supported by a sysenter 
> capable kernel, since it must run older binaries and potentially support 
> syscalls during early boot up before it is known that sysenter is supported.

Now is the latest glibc using this.  Since I put in a ud2 op in my
sysenter_entry code, which is not triggered, as well as an objdump of
libc.so shows a bunch of int 0x80 calls.

-- Steve


