Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932333AbVHKR7Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932333AbVHKR7Z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 13:59:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932328AbVHKR7Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 13:59:25 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:23058 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S932333AbVHKR7Y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 13:59:24 -0400
Message-ID: <42FB91FA.7070104@vmware.com>
Date: Thu, 11 Aug 2005 10:59:22 -0700
From: Zachary Amsden <zach@vmware.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       Coywolf Qi Hunt <coywolf@gmail.com>, 7eggert@gmx.de,
       Ukil a <ukil_a@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: Need help in understanding x86 syscall
References: <4Ae73-6Mm-5@gated-at.bofh.it> <E1E3DJm-0000jy-0B@be1.lrz>	 <Pine.LNX.4.61.0508110954360.14541@chaos.analogic.com>	 <1123770661.17269.59.camel@localhost.localdomain>	 <2cd57c90050811081374d7c4ef@mail.gmail.com>	 <Pine.LNX.4.61.0508111124530.14789@chaos.analogic.com>	 <1123775508.17269.64.camel@localhost.localdomain>	 <1123777184.17269.67.camel@localhost.localdomain>	 <2cd57c90050811093112a57982@mail.gmail.com>	 <2cd57c9005081109597b18cc54@mail.gmail.com>	 <Pine.LNX.4.61.0508111310180.15153@chaos.analogic.com>	 <1123781187.17269.77.camel@localhost.localdomain> <1123781639.17269.83.camel@localhost.localdomain>
In-Reply-To: <1123781639.17269.83.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 11 Aug 2005 17:59:19.0890 (UTC) FILETIME=[65BE0320:01C59E9E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt wrote:

>I expect that if I had a Gentoo system that I compiled for my machine,
>this would be different. But I suspect that Debian still wants to run on
>my old Pentium 75MHz laptop.  How would libc know to use sysenter
>instead of int 0x80.  It could do a test of the system, but would there
>be an if statement for every system call then?   I guess that libc needs
>to be compiled either to use it or not. Since there are still several
>machines out there that don't have this feature, it would be safer to
>not use it.
>  
>

zach-dev2:~ $ ldd /bin/ls
        linux-gate.so.1 =>  (0xffffe000)

This is the vsyscall entry point, which gets linked by ld into all 
processes.  It is a kernel page which is visible to user space, and is 
rewritten to support sysenter if indeed that instruction is available.  
Glibc has fixed entry points to this page.  Here is a view of the system 
call entry point on a machine which supports sysenter:

(gdb) break _init
Breakpoint 1 at 0x8049522
(gdb) run
Starting program: /bin/ls
(no debugging symbols found)...[Thread debugging using libthread_db enabled]
[New Thread 1075283616 (LWP 5328)]
[Switching to Thread 1075283616 (LWP 5328)]

Breakpoint 1, 0x08049522 in _init ()
(gdb) x/10i 0xffffe400
0xffffe400:     push   %ecx
0xffffe401:     push   %edx
0xffffe402:     push   %ebp
0xffffe403:     mov    %esp,%ebp
0xffffe405:     sysenter
0xffffe407:     nop   
0xffffe408:     nop   
0xffffe409:     nop   
0xffffe40a:     nop   
0xffffe40b:     nop   

On a machine that does not support sysenter, this will give you:

int $0x80
ret

The int $0x80 system calls are still fully supported by a sysenter 
capable kernel, since it must run older binaries and potentially support 
syscalls during early boot up before it is known that sysenter is supported.

Zach
