Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267032AbRGTPhS>; Fri, 20 Jul 2001 11:37:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267023AbRGTPhJ>; Fri, 20 Jul 2001 11:37:09 -0400
Received: from [194.77.109.75] ([194.77.109.75]:38920 "EHLO warp.zuto.de")
	by vger.kernel.org with ESMTP id <S267018AbRGTPgy>;
	Fri, 20 Jul 2001 11:36:54 -0400
From: Rainer Clasen <bj@zuto.de>
Date: Fri, 20 Jul 2001 17:36:55 +0200
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Subject: Re: [PATCH] PPPOE can kfree SKB twice (was Re: kernel panic problem. (smp, iptables?))
Message-ID: <20010720173655.F23559@zuto.de>
Reply-To: bj@zuto.de
Mail-Followup-To: "David S. Miller" <davem@redhat.com>,
	linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
In-Reply-To: <005f01c10e69$28273e60$0200a8c0@loki> <15189.2408.59953.395204@pizda.ninka.net> <20010720091329.B16207@zuto.de> <15191.56739.635100.533146@pizda.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <15191.56739.635100.533146@pizda.ninka.net>; from davem@redhat.com on Fri, Jul 20, 2001 at 12:28:35AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Fri, Jul 20, 2001 at 12:28:35AM -0700, David S. Miller wrote:
> 
> Rainer Clasen writes:
>  > I am using tulip, dummy, Ben Grear's dot1q VLAN devices and some ISDN
>  > syncppp and ISDN rawip devices are configured (but not actively used),
>  > too.
> 
> Can you test without dummy and VLAN?  Man, I now have to audit that
> friggin' code too :-(

As first step I've removed dummy. Eliminating Vlan is difficult and will take
me some more time. 

I could easily reproduce the oops with several nmap -sS through this router.

# ksymoops -K -L -o /lib/modules/2.4.6/ -m /boot/System.map-2.4.6-obs.1.1  < blurb 
ksymoops 2.4.1 on i586 2.4.1.  Options used
     -V (default)
     -K (specified)
     -L (specified)
     -o /lib/modules/2.4.6/ (specified)
     -m /boot/System.map-2.4.6-obs.1.1 (specified)

No modules in ksyms, skipping objects
Unable to handle kernel paging request at virtual address 67720a25 printing eip:
c012612a
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c012612a>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 67720a0d   ebx: 00000000   ecx: 67720a0d   edx: 00000000
esi: c165d800   edi: c12d2680   ebp: 00000060   esp: c0209dd8
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 0, stackpage=c0209000)
Stack: c0181e4d fffff800 c165d800 c0182443 c165d800 c165d800 c12f3000 c12c10a0
       c12f3000 ffffffee c01853bd c165d800 00000020 c165d800 00000000 c12c10a0
       c0188935 c165d800 c165d800 00000000 00000004 c01961cc c019625d c165d800
Call Trace: [<c0181e4d>] [<c0182443>] [<c01853bd>] [<c0188935>] [<c01961cc>] [<c019625d>] [<c018aa56>] 
       [<c01938b0>] [<c01961b2>] [<c01961cc>] [<c01938fa>] [<c018aa56>] [<c019385b>] [<c01938b0>] [<c0192c69>]
       [<c0192aa8>] [<c018aa56>] [<c01928f6>] [<c0192aa8>] [<c0185a8d>] [<c0113aff>] [<c0107e5d>] [<c0105120>]
       [<c0106b60>] [<c0105120>] [<c0105143>] [<c01051a7>] [<c0105000>]
Code: 8b 41 18 85 c0 7c 11 ff 49 14 0f 94 c0 84 c0 74 07 89 c8 e8

>>EIP; c012612a <__free_pages+2/1c>   <=====
Trace; c0181e4d <skb_release_data+41/74>
Trace; c0182443 <skb_linearize+cf/130>
Trace; c01853bd <dev_queue_xmit+6d/244>
Trace; c0188935 <neigh_connected_output+95/c8>
Trace; c01961cc <ip_finish_output2+0/c8>
Trace; c019625d <ip_finish_output2+91/c8>
Trace; c018aa56 <nf_hook_slow+ee/144>
Trace; c01938b0 <ip_forward_finish+0/50>
Trace; c01961b2 <ip_finish_output+ee/f4>
Trace; c01961cc <ip_finish_output2+0/c8>
Trace; c01938fa <ip_forward_finish+4a/50>
Trace; c018aa56 <nf_hook_slow+ee/144>
Trace; c019385b <ip_forward+1eb/240>
Trace; c01938b0 <ip_forward_finish+0/50>
Trace; c0192c69 <ip_rcv_finish+1c1/1f8>
Trace; c0192aa8 <ip_rcv_finish+0/1f8>
Trace; c018aa56 <nf_hook_slow+ee/144>
Trace; c01928f6 <ip_rcv+376/3b0>
Trace; c0192aa8 <ip_rcv_finish+0/1f8>
Trace; c0185a8d <net_rx_action+135/258>
Trace; c0113aff <do_softirq+3f/68>
Trace; c0107e5d <do_IRQ+9d/b0>
Trace; c0105120 <default_idle+0/28>
Trace; c0106b60 <ret_from_intr+0/7>
Trace; c0105120 <default_idle+0/28>
Trace; c0105143 <default_idle+23/28>
Trace; c01051a7 <cpu_idle+3f/54>
Trace; c0105000 <_stext+0/0>
Code;  c012612a <__free_pages+2/1c>
00000000 <_EIP>:
Code;  c012612a <__free_pages+2/1c>   <=====
   0:   8b 41 18                  mov    0x18(%ecx),%eax   <=====
Code;  c012612d <__free_pages+5/1c>
   3:   85 c0                     test   %eax,%eax
Code;  c012612f <__free_pages+7/1c>
   5:   7c 11                     jl     18 <_EIP+0x18> c0126142 <__free_pages+1a/1c>
Code;  c0126131 <__free_pages+9/1c>
   7:   ff 49 14                  decl   0x14(%ecx)
Code;  c0126134 <__free_pages+c/1c>
   a:   0f 94 c0                  sete   %al
Code;  c0126137 <__free_pages+f/1c>
   d:   84 c0                     test   %al,%al
Code;  c0126139 <__free_pages+11/1c>
   f:   74 07                     je     18 <_EIP+0x18> c0126142 <__free_pages+1a/1c>
Code;  c012613b <__free_pages+13/1c>
  11:   89 c8                     mov    %ecx,%eax
Code;  c012613d <__free_pages+15/1c>
  13:   e8 00 00 00 00            call   18 <_EIP+0x18> c0126142 <__free_pages+1a/1c>

Kernel panic: Aiee, killing interrupt handler!

Rainer

-- 
KeyID=759975BD fingerprint=887A 4BE3 6AB7 EE3C 4AE0  B0E1 0556 E25A 7599 75BD
