Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261976AbTH0TNN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 15:13:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262023AbTH0TNM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 15:13:12 -0400
Received: from fw.osdl.org ([65.172.181.6]:6279 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261976AbTH0TNJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 15:13:09 -0400
Date: Wed, 27 Aug 2003 11:57:18 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Enrico Demarin" <enricod@videotron.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: SMP oops on Xseries235
Message-Id: <20030827115718.6eb48d60.akpm@osdl.org>
In-Reply-To: <!~!AAAAAKDREUy8bkNHgAPBLyrKszdk8SkA@videotron.ca>
References: <20030819182738.65296132.akpm@osdl.org>
	<!~!AAAAAKDREUy8bkNHgAPBLyrKszdk8SkA@videotron.ca>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Enrico Demarin" <enricod@videotron.ca> wrote:
>
> I upgraded to 2.4.22 , with one CPU the kernel looks stable . On SMP I got
> an OOPS message just after a few
> 
> hours of uptime  . Being a system with over 100 users relying on it, I'm
> getting mud from all over the place ;/
> 
> Anyway: this time the process was squid , and the machine did not lock up so
> I could decode the OOPS
> ...
> Unable to handle kernel NULL pointer dereference at virtual address 00000004
> c014650d
> *pde = 00000000
> Oops: 0002
> CPU:    1
> EIP:    0010:[<c014650d>]    Tainted: PF
> Using defaults from ksymoops -t elf32-i386 -a i386

What caused the taint?  (What modules are loaded?)

It oopsed because current->fs is NULL in sys_open().  Totally bizarre,
never seen that before.

Which kernel were you running before 2.4.22?

> EFLAGS: 00010202
> eax: 00000004   ebx: f6d81f84   ecx: f6d81f84   edx: f6d80000
> esi: f6d81f84   edi: da812000   ebp: f6d81f84   esp: f6d81ea4
> ds: 0018   es: 0018   ss: 0018
> Process squid (pid: 1354, stackpage=f6d81000)
> Stack: f6d81ee8 00015554 f6d81efc c01fed81 d9c7a614 f6d81f34 00015554
> 00000040
>        f6d81ee8 00000246 dc81eea0 daa0b8c0 dc81ef78 c0231efe daa0b8c0
> f5a54250
>        f6d81f84 da812000 00000000 c01464be da812000 da812000 00000e42
> c014696e
> Call Trace:    [<c01fed81>] [<c0231efe>] [<c01464be>] [<c014696e>]
> [<c01fee88>]
>   [<c013a656>] [<c01453ce>] [<c013a9a4>] [<c0108c43>]
> Code: f0 83 28 01 0f 88 2c 28 00 00 8b 82 50 06 00 00 8b 58 14 85
> 
> 
> >>EIP; c014650d <path_init+2d/180>   <=====
> 
> >>ebx; f6d81f84 <_end+36a0c370/3858f3ec>
> >>ecx; f6d81f84 <_end+36a0c370/3858f3ec>
> >>edx; f6d80000 <_end+36a0a3ec/3858f3ec>
> >>esi; f6d81f84 <_end+36a0c370/3858f3ec>
> >>edi; da812000 <_end+1a49c3ec/3858f3ec>
> >>ebp; f6d81f84 <_end+36a0c370/3858f3ec>
> >>esp; f6d81ea4 <_end+36a0c290/3858f3ec>
> 
> Trace; c01fed81 <sock_recvmsg+31/b0>
> Trace; c0231efe <tcp_poll+2e/150>
> Trace; c01464be <path_lookup+e/30>
> Trace; c014696e <open_namei+8e/530>
> Trace; c01fee88 <sock_read+88/a0>
> Trace; c013a656 <filp_open+36/60>
> Trace; c01453ce <getname+5e/a0>
> Trace; c013a9a4 <sys_open+34/a0>
> Trace; c0108c43 <system_call+33/38>
> 
> Code;  c014650d <path_init+2d/180>
> 00000000 <_EIP>:
> Code;  c014650d <path_init+2d/180>   <=====
>    0:   f0 83 28 01               lock subl $0x1,(%eax)   <=====
> Code;  c0146511 <path_init+31/180>
>    4:   0f 88 2c 28 00 00         js     2836 <_EIP+0x2836> c0148d43
> <.text.lock.namei+106/403>
> Code;  c0146517 <path_init+37/180>
>    a:   8b 82 50 06 00 00         mov    0x650(%edx),%eax
> Code;  c014651d <path_init+3d/180>
>   10:   8b 58 14                  mov    0x14(%eax),%ebx
> Code;  c0146520 <path_init+40/180>
>   13:   85 00                     test   %eax,(%eax)
> 


