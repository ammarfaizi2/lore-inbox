Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271702AbTHMIrT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 04:47:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271703AbTHMIrT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 04:47:19 -0400
Received: from fw.osdl.org ([65.172.181.6]:175 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S271702AbTHMIrR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 04:47:17 -0400
Date: Wed, 13 Aug 2003 01:47:46 -0700
From: Andrew Morton <akpm@osdl.org>
To: thunder7@xs4all.nl
Cc: linux-kernel@vger.kernel.org, Andi Kleen <ak@muc.de>,
       Zwane Mwaikambo <zwane@holomorphy.com>,
       Dave Jones <davej@codemonkey.org.uk>
Subject: Re: 2.6.0-test3-mm1: scheduling while atomic (ext3?)
Message-Id: <20030813014746.412660ae.akpm@osdl.org>
In-Reply-To: <20030813045638.GA9713@middle.of.nowhere>
References: <20030813045638.GA9713@middle.of.nowhere>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jurriaan <thunder7@xs4all.nl> wrote:
>
> Aug 13 06:47:48 middle -- MARK --
>  Aug 13 06:53:03 middle kernel:  printing eip:
>  Aug 13 06:53:03 middle kernel: c016c14a
>  Aug 13 06:53:03 middle kernel: Oops: 0000 [#1]
>  Aug 13 06:53:03 middle kernel: PREEMPT 
>  Aug 13 06:53:03 middle kernel: CPU:    0
>  Aug 13 06:53:03 middle kernel: EIP:    0060:[<c016c14a>]    Not tainted VLI
>  Aug 13 06:53:03 middle kernel: EFLAGS: 00010286
>  Aug 13 06:53:03 middle kernel: EIP is at find_inode_fast+0x1a/0x60
>  Aug 13 06:53:03 middle kernel: eax: f7b7e000   ebx: 000d5ff4   ecx: e68e9a48   edx: 00000000
>  Aug 13 06:53:03 middle kernel: esi: f7b7e000   edi: c1a50d80   ebp: f2f41e14   esp: f2f41e04
>  Aug 13 06:53:03 middle kernel: ds: 007b   es: 007b   ss: 0068
>  Aug 13 06:53:03 middle kernel: Process make (pid: 9500, threadinfo=f2f40000 task=eb0966a0)
>  Aug 13 06:53:03 middle kernel: Stack: f0c05cc0 f2f40000 f0271cc0 000d5ff4 f2f41e38 c016c7c0 f7b7e000 c1a50d80 
>  Aug 13 06:53:03 middle kernel:        000d5ff4 c1a50d80 000d5ff4 f0271cc0 f7b7e000 f2f41e58 c018fc92 f7b7e000 
>  Aug 13 06:53:03 middle kernel:        000d5ff4 c3600234 fffffff4 dddd2a74 dddd2a08 f2f41e7c c0160b10 dddd2a08 
>  Aug 13 06:53:03 middle kernel: Call Trace:
>  Aug 13 06:53:03 middle kernel:  [<c016c7c0>] iget_locked+0x50/0xc0
>  Aug 13 06:53:03 middle kernel:  [<c018fc92>] ext3_lookup+0x62/0xd0
>  Aug 13 06:53:03 middle kernel:  [<c0160b10>] real_lookup+0xc0/0xf0
>  Aug 13 06:53:03 middle kernel:  [<c0160d84>] do_lookup+0x84/0x90
>  Aug 13 06:53:03 middle kernel:  [<c0161211>] link_path_walk+0x481/0x870
>  Aug 13 06:53:03 middle kernel:  [<c0161abe>] __user_walk+0x3e/0x60
>  Aug 13 06:53:03 middle kernel:  [<c015cdce>] vfs_stat+0x1e/0x60
>  Aug 13 06:53:03 middle kernel:  [<c015d43b>] sys_stat64+0x1b/0x40
>  Aug 13 06:53:03 middle kernel:  [<c03ca78f>] syscall_call+0x7/0xb
>  Aug 13 06:53:03 middle kernel: 
>  Aug 13 06:53:03 middle kernel: Code: 75 ca eb c6 8d b6 00 00 00 00 8d bc 27 00 00 00 00 55 89 e5 57 56 53 83 ec 04 8b 5d 10 8b 7d 0c 8b 75 08 8b 0f 85 c9 74 13 8b 11 <0f> 18 02 90 39 59 18 89 c8 74 10 85 d2 89 d1 75 ed 31 c0 83 c4 

You oopsed here:

Code;  c016c144 No symbols available
  25:   85 c9                     test   %ecx,%ecx
Code;  c016c146 No symbols available
  27:   74 13                     je     3c <_EIP+0x3c>
Code;  c016c148 No symbols available
  29:   8b 11                     mov    (%ecx),%edx

This decode from eip onwards should be reliable

Code;  c016c14a No symbols available
00000000 <_EIP>:
Code;  c016c14a No symbols available   <=====
   0:   0f 18 02                  prefetchnta (%edx)   <=====
Code;  c016c14d No symbols available
   3:   90                        nop    
Code;  c016c14e No symbols available
   4:   39 59 18                  cmp    %ebx,0x18(%ecx)
Code;  c016c151 No symbols available



And indeed, your %edx is zero.

But if a prefetch of zero oopses then we should be oopsing in there all the
time.

hlist_for_each() is completely assuming that prefetch(0) is safe, and you
undoubtedly oopsed doing it.


Colour me confused, and let me Cc lots of x86 guys ;)

Exactly what sort of CPU are you using?
