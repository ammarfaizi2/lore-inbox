Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132620AbQLNUXT>; Thu, 14 Dec 2000 15:23:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132807AbQLNUXA>; Thu, 14 Dec 2000 15:23:00 -0500
Received: from cs.columbia.edu ([128.59.16.20]:13044 "EHLO cs.columbia.edu")
	by vger.kernel.org with ESMTP id <S132620AbQLNUW6>;
	Thu, 14 Dec 2000 15:22:58 -0500
Date: Thu, 14 Dec 2000 11:52:29 -0800 (PST)
From: Ion Badulescu <ionut@cs.columbia.edu>
To: "David S. Miller" <davem@redhat.com>
cc: <mhaque@haque.net>, <linux-kernel@vger.kernel.org>
Subject: Re: ip_defrag is broken (was: Re: test12 lockups -- need feedback)
In-Reply-To: <200012141927.LAA05847@pizda.ninka.net>
Message-ID: <Pine.LNX.4.30.0012141146320.27848-100000@age.cs.columbia.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Dec 2000, David S. Miller wrote:

>    Date: 	Thu, 14 Dec 2000 10:38:01 -0800
>    From: Ion Badulescu <ionut@moisil.cs.columbia.edu>
>
>    I won't venture a fix, as I don't know the networking code well
>    enough. So far, no networking maintainer has had anything to say
>    about this bug on the list...
>
> Because this is the first most of us have heard of the issue, much
> less seen any ksymoops processed OOPS logs of the bug so we can even
> start thinking about what might be wrong.

Oh, there have been at least two ksymoops'ed traces posted on the list, I
thought you'd seen them already.. But never mind, the problem is that
skb->dev can be NULL and the code changed in test12 dereferences it to get
skb->dev->iif.

The oops looks something like this. It was caught on serial console, and
decoded on test11, so it doesn't have translation for module symbols. It
if helps, this box is running ip_conntrack and the oops occurred basically
as soon as an NFS request came in.

Unable to handle kernel NULL pointer dereference at virtual address 0000003c
c01917a6
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c01917a6>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 00000000   ebx: 00000000   ecx: c21d8f20   edx: 000003a0
esi: c3e73760   edi: 00000000   ebp: 00001ce8   esp: c16e9c80
ds: 0018   es: 0018   ss: 0018
Process nfsd (pid: 670, stackpage=c16e9000)
Stack: c21d8f20 00000000 c01912cf 01011eac 00002088 c21d8f20 005aac10 c0191b43
       c21d8f20 c3e73760 c1786680 c3e73760 c0194718 c16e9d9c 030011cf 1121e260
       00000000 c48c02d0 c3e73760 c16e9d8c c02358f8 c48bfb4e c3e73760 c16e9d8c
Call Trace: [<c01912cf>] [<c0191b43>] [<c0194718>] [<c48c02d0>] [<c48bfb4e>] [<c0194718>] [<c017b0f8>]
       [<c017f6f4>] [<c017f717>] [<c48c1082>] [<c0194718>] [<c0184388>] [<c0194718>] [<c0194718>] [<c0184597>]
       [<c0194718>] [<c48c2188>] [<c0193cea>] [<c0194718>] [<c0140e85>] [<c0193e0a>] [<c01a834c>] [<c01a878d>]
       [<c01a834c>] [<c01ad918>] [<c01ad956>] [<c0182aed>] [<c01ad918>] [<c487f346>] [<c487f7d5>] [<c4880516>]
       [<c48a7c00>] [<c487ef44>] [<c48a7ae0>] [<c48a75f8>] [<c4897331>] [<c48a75e0>] [<c0107457>]
Code: 8b 40 3c 89 41 3c 8b 46 5c c7 46 18 00 00 00 00 01 41 18 8b

>>EIP; c01917a6 <ip_frag_queue+242/298>   <=====
Trace; c01912cf <ip_frag_destroy+2f/8c>
Trace; c0191b43 <ip_defrag+c3/140>
Trace; c0194718 <output_maybe_reroute+0/14>
Trace; c48c02d0 <END_OF_CODE+4689b60/????>
Trace; c48bfb4e <END_OF_CODE+46893de/????>
Trace; c0194718 <output_maybe_reroute+0/14>
Trace; c017b0f8 <dma_timer_expiry+0/70>
Trace; c017f6f4 <via82cxxx_dmaproc+0/2c>
Trace; c017f717 <via82cxxx_dmaproc+23/2c>
Trace; c48c1082 <END_OF_CODE+468a912/????>
Trace; c0194718 <output_maybe_reroute+0/14>
Trace; c0184388 <nf_iterate+34/88>
Trace; c0194718 <output_maybe_reroute+0/14>
Trace; c0194718 <output_maybe_reroute+0/14>
Trace; c0184597 <nf_hook_slow+3f/b4>
Trace; c0194718 <output_maybe_reroute+0/14>
Trace; c48c2188 <END_OF_CODE+468ba18/????>
Trace; c0193cea <ip_build_xmit_slow+3c6/498>
Trace; c0194718 <output_maybe_reroute+0/14>
Trace; c0140e85 <update_atime+4d/54>
Trace; c0193e0a <ip_build_xmit+4e/31c>
Trace; c01a834c <udp_getfrag+0/c4>
Trace; c01a878d <udp_sendmsg+339/3b4>
Trace; c01a834c <udp_getfrag+0/c4>
Trace; c01ad918 <inet_sendmsg+0/44>
Trace; c01ad956 <inet_sendmsg+3e/44>
Trace; c0182aed <sock_sendmsg+81/a4>
Trace; c01ad918 <inet_sendmsg+0/44>
Trace; c487f346 <END_OF_CODE+4648bd6/????>
Trace; c487f7d5 <END_OF_CODE+4649065/????>
Trace; c4880516 <END_OF_CODE+4649da6/????>
Trace; c48a7c00 <END_OF_CODE+4671490/????>
Trace; c487ef44 <END_OF_CODE+46487d4/????>
Trace; c48a7ae0 <END_OF_CODE+4671370/????>
Trace; c48a75f8 <END_OF_CODE+4670e88/????>
Trace; c4897331 <END_OF_CODE+4660bc1/????>
Trace; c48a75e0 <END_OF_CODE+4670e70/????>
Trace; c0107457 <kernel_thread+23/30>
Code;  c01917a6 <ip_frag_queue+242/298>
00000000 <_EIP>:
Code;  c01917a6 <ip_frag_queue+242/298>   <=====
   0:   8b 40 3c                  mov    0x3c(%eax),%eax   <=====
Code;  c01917a9 <ip_frag_queue+245/298>
   3:   89 41 3c                  mov    %eax,0x3c(%ecx)
Code;  c01917ac <ip_frag_queue+248/298>
   6:   8b 46 5c                  mov    0x5c(%esi),%eax
Code;  c01917af <ip_frag_queue+24b/298>
   9:   c7 46 18 00 00 00 00      movl   $0x0,0x18(%esi)
Code;  c01917b6 <ip_frag_queue+252/298>
  10:   01 41 18                  add    %eax,0x18(%ecx)
Code;  c01917b9 <ip_frag_queue+255/298>
  13:   8b 00                     mov    (%eax),%eax


Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
