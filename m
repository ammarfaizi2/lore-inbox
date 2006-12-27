Return-Path: <linux-kernel-owner+w=401wt.eu-S932782AbWL0Mew@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932782AbWL0Mew (ORCPT <rfc822;w@1wt.eu>);
	Wed, 27 Dec 2006 07:34:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932795AbWL0Mew
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Dec 2006 07:34:52 -0500
Received: from mcr-smtp-002.bulldogdsl.com ([212.158.248.8]:1147 "EHLO
	mcr-smtp-002.bulldogdsl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932782AbWL0Mev (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Dec 2006 07:34:51 -0500
X-Spam-Abuse: Please report all spam/abuse matters to abuse@bulldogdsl.com
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: "Zhang, Yanmin" <yanmin_zhang@linux.intel.com>
Subject: Re: Oops in 2.6.19.1
Date: Wed, 27 Dec 2006 12:35:08 +0000
User-Agent: KMail/1.9.5
Cc: LKML <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>,
       Chuck Ebbert <76306.1226@compuserve.com>
References: <200612201421.03514.s0348365@sms.ed.ac.uk> <200612231540.47176.s0348365@sms.ed.ac.uk> <1167185232.15989.129.camel@ymzhang>
In-Reply-To: <1167185232.15989.129.camel@ymzhang>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612271235.08845.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 27 December 2006 02:07, Zhang, Yanmin wrote:
[snip]
> > 00000000 Call Trace:
> >  [<c015d7f3>] do_sys_poll+0x253/0x480
> >  [<c015da53>] sys_poll+0x33/0x50
> >  [<c0102c97>] syscall_call+0x7/0xb
> >  [<b7f26402>] 0xb7f26402
> >  =======================
> > Code: 58 01 00 00 0f 4f c2 09 c1 89 c8 83 c8 08 85 db 0f 44 c8 8b 5d f4
> > 89 c8 8b 75
> > f8 8b 7d fc 89 ec 5d c3 89 ca 8b 46 6c 83 ca 10 3b <87> 68 01 00 00 0f 45
> > ca eb b6 8d b6 00 00 00 00 55 b8 01 00 00
>
> Above codes look weird. Could you disassemble kernel image and post
> the part around address 0xc0156f60?
>
> "87 68 01 00 00" is instruction xchg, but if I disassemble from the
> begining, I couldn't see instruct xchg.
>
> > EIP: [<c0156f60>] pipe_poll+0xa0/0xb0 SS:ESP 0068:ee1b9c0c

Unfortunately, after suspecting the toolchain, I did a manual rebuild of 
binutils, gcc and glibc from the official sites, and then rebuilt 2.6.19.1. 
This might upset the decompile below, versus the original report.

Assuming it's NOT a bug in my distro's toolchain (because I am now running the 
GNU stuff), it'll crash again, so this is still useful.

Here's a current decompilation of vmlinux/pipe_poll() from the running kernel, 
the addresses have changed slightly. There's no xchg there either:

c0156ec0 <pipe_poll>:
c0156ec0:       55                      push   %ebp
c0156ec1:       89 e5                   mov    %esp,%ebp
c0156ec3:       83 ec 10                sub    $0x10,%esp
c0156ec6:       89 5d f4                mov    %ebx,0xfffffff4(%ebp)
c0156ec9:       85 d2                   test   %edx,%edx
c0156ecb:       89 d3                   mov    %edx,%ebx
c0156ecd:       89 75 f8                mov    %esi,0xfffffff8(%ebp)
c0156ed0:       89 c6                   mov    %eax,%esi
c0156ed2:       89 7d fc                mov    %edi,0xfffffffc(%ebp)
c0156ed5:       8b 40 08                mov    0x8(%eax),%eax
c0156ed8:       8b 40 08                mov    0x8(%eax),%eax
c0156edb:       8b b8 f0 00 00 00       mov    0xf0(%eax),%edi
c0156ee1:       74 0c                   je     c0156eef <pipe_poll+0x2f>
c0156ee3:       85 ff                   test   %edi,%edi
c0156ee5:       74 08                   je     c0156eef <pipe_poll+0x2f>
c0156ee7:       89 d1                   mov    %edx,%ecx
c0156ee9:       89 f0                   mov    %esi,%eax
c0156eeb:       89 fa                   mov    %edi,%edx
c0156eed:       ff 13                   call   *(%ebx)
c0156eef:       0f b7 5e 1c             movzwl 0x1c(%esi),%ebx
c0156ef3:       31 c9                   xor    %ecx,%ecx
c0156ef5:       8b 47 08                mov    0x8(%edi),%eax
c0156ef8:       f6 c3 01                test   $0x1,%bl
c0156efb:       89 45 f0                mov    %eax,0xfffffff0(%ebp)
c0156efe:       74 20                   je     c0156f20 <pipe_poll+0x60>
c0156f00:       85 c0                   test   %eax,%eax
c0156f02:       b8 41 00 00 00          mov    $0x41,%eax
c0156f07:       0f 4f c8                cmovg  %eax,%ecx
c0156f0a:       8b 87 5c 01 00 00       mov    0x15c(%edi),%eax
c0156f10:       85 c0                   test   %eax,%eax
c0156f12:       74 43                   je     c0156f57 <pipe_poll+0x97>
c0156f14:       8d b6 00 00 00 00       lea    0x0(%esi),%esi
c0156f1a:       8d bf 00 00 00 00       lea    0x0(%edi),%edi
c0156f20:       f6 c3 02                test   $0x2,%bl
c0156f23:       74 23                   je     c0156f48 <pipe_poll+0x88>
c0156f25:       83 7d f0 0f             cmpl   $0xf,0xfffffff0(%ebp)
c0156f29:       b8 04 01 00 00          mov    $0x104,%eax
c0156f2e:       ba 00 00 00 00          mov    $0x0,%edx
c0156f33:       8b 9f 58 01 00 00       mov    0x158(%edi),%ebx
c0156f39:       0f 4f c2                cmovg  %edx,%eax
c0156f3c:       09 c1                   or     %eax,%ecx
c0156f3e:       89 c8                   mov    %ecx,%eax
c0156f40:       83 c8 08                or     $0x8,%eax
c0156f43:       85 db                   test   %ebx,%ebx
c0156f45:       0f 44 c8                cmove  %eax,%ecx
c0156f48:       8b 5d f4                mov    0xfffffff4(%ebp),%ebx
c0156f4b:       89 c8                   mov    %ecx,%eax
c0156f4d:       8b 75 f8                mov    0xfffffff8(%ebp),%esi
c0156f50:       8b 7d fc                mov    0xfffffffc(%ebp),%edi
c0156f53:       89 ec                   mov    %ebp,%esp
c0156f55:       5d                      pop    %ebp
c0156f56:       c3                      ret
c0156f57:       89 ca                   mov    %ecx,%edx
c0156f59:       8b 46 6c                mov    0x6c(%esi),%eax
c0156f5c:       83 ca 10                or     $0x10,%edx
c0156f5f:       3b 87 68 01 00 00       cmp    0x168(%edi),%eax
c0156f65:       0f 45 ca                cmovne %edx,%ecx
c0156f68:       eb b6                   jmp    c0156f20 <pipe_poll+0x60>
c0156f6a:       8d b6 00 00 00 00       lea    0x0(%esi),%esi

-- 
Cheers,
Alistair.

Final year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
