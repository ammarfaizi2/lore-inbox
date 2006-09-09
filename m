Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932147AbWIIFXn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932147AbWIIFXn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Sep 2006 01:23:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932148AbWIIFXm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Sep 2006 01:23:42 -0400
Received: from 1wt.eu ([62.212.114.60]:24082 "EHLO 1wt.eu")
	by vger.kernel.org with ESMTP id S932147AbWIIFXl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Sep 2006 01:23:41 -0400
Date: Sat, 9 Sep 2006 07:20:36 +0200
From: Willy Tarreau <w@1wt.eu>
To: Ondrej Zary <linux@rainbow-software.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, kaber@trash.net
Subject: Re: Oops after 30 days of uptime
Message-ID: <20060909052036.GD541@1wt.eu>
References: <200609011852.39572.linux@rainbow-software.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200609011852.39572.linux@rainbow-software.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 01, 2006 at 06:52:39PM +0200, Ondrej Zary wrote:
> Hello,
> my home router crashed after about a month. It does this sometimes but this 
> time I was able to capture the oops. Here is the result of running ksymoops 
> on it (took a photo of the screen and then manually converted to plain-text). 
> Does it look like a bug or something other?

I have another problem with your oops. It looks like you used a /proc/ksyms
from another running kernel. The symbol decoding does not match the code.
For instance, in the disassembled code, you'll see that two functions are
indicated for the same sequence of instructions (init_or_cleanup then
ip_conntrack_protocol_register). And the difference does not look like a
small offset, since neither of those functions seem to produce comparable
code here.

You should backup the /proc/ksyms from your currently running kernel, and
reuse it to decode the next oops when it occurs. BTW, could you provide
the full config file and tell us what version of GCC you're using ? Maybe
we can try to find the same code sequence in a module and identify it
without waiting for further oops.

> ksymoops 2.4.11 on i486 2.4.31.  Options used
>      -V (default)
>      -k /proc/ksyms (default)
>      -l /proc/modules (default)
>      -o /lib/modules/2.4.31/ (default)
>      -m System.map (specified)
> 
> Error (regular_file): read_ksyms stat /proc/ksyms failed
> No modules in ksyms, skipping objects
> No ksyms, skipping lsmod
> Unable to handle kernel paging request at virtual address c2000000
> *pde = 00000000
> Oops: 0000
> CPU:    0
> EIP:    0010:[<c01eeb9e>]    Not tainted
> Using defaults from ksymoops -t elf32-i386 -a i386
> EFLAGS: 00010a96
> eax: db1cec0a   ebx: 7af4a90b   ecx: fff113e8   edx: 00000008
> esi: c1ffffe8   edi: c17835a4   ebp: c0b4b8b4   esp: c0227cd0
> ds: 0018   es: 0018   ss: 0018
> Process swapper (pid: 0, stackpage=c0227000)
> Stack: fd00a8c0 c17835a4 c01e6587 c0227ce8 00000008 0000a0c5 0000dff0 0000200f
>        c01e8757 0000dff0 0000200f 00005f3a 00000000 00000028 c1783590 c0b4b8b4
>        c01e7162 c1783590 00000028 c0b4b8b4 00000000 00000006 c0b4b810 00000000
> Call Trace:    [<c01e6587>] [<c01e8757>] [<c01e7162>] [<c01e72ea>] [<c017fda8>]
>   [<c01baca0>] [<c01e5ed4>] [<c01baca0>] [<c01e5fba>] [<c01baca0>] [<c01afe00>]
>   [<c01baca0>] [<c01baca0>] [<c01b00d0>] [<c01baca0>] [<c01b8270>] [<c01b9652>]
>   [<c01baca0>] [<c01b8270>] [<c01b82ba>] [<c01b0110>] [<c01b05dc>] [<c01b8214>]
>   [<c01b8270>] [<c01b7220>] [<c01b739b>] [<c01b7220>] [<c01b0110>] [<c01b70a6>]
>   [<c01b7220>] [<c01a87bb>] [<c01a885d>] [<c01a8970>] [<c011427a>] [<c01081cd>]
>   [<c0105250>] [<c010a3b8>] [<c0105250>] [<c0105273>] [<c01052d8>] [<c0105000>]
>   [<c0105027>]
> Code: 8b 5e 18 11 d8 8b 5e 1c 11 d8 8d 76 20 49 75 d3 83 d0 00 89
> 
> 
> >>EIP; c01eeb9e <init_or_cleanup+15e/160>   <=====
> 
> >>esp; c0227cd0 <bdf_prm+30/40>
> 
> Trace; c01e6587 <icmp_timestamp+47/f0>
> Trace; c01e8757 <inet_sock_release+57/80>
> Trace; c01e7162 <inet_rtm_newaddr+42/190>
> Trace; c01e72ea <devinet_ioctl+3a/680>
> Trace; c017fda8 <ei_start_xmit+248/260>
> Trace; c01baca0 <sfq_dequeue+e0/1c0>
> Trace; c01e5ed4 <icmp_send+84/350>
> Trace; c01baca0 <sfq_dequeue+e0/1c0>
> Trace; c01e5fba <icmp_send+16a/350>
> Trace; c01baca0 <sfq_dequeue+e0/1c0>
> Trace; c01afe00 <nf_iterate+0/80>
> Trace; c01baca0 <sfq_dequeue+e0/1c0>
> Trace; c01baca0 <sfq_dequeue+e0/1c0>
> Trace; c01b00d0 <nf_hook_slow+80/150>
> Trace; c01baca0 <sfq_dequeue+e0/1c0>
> Trace; c01b8270 <htb_timer+30/50>
> Trace; c01b9652 <htb_dump_class+22/260>
> Trace; c01baca0 <sfq_dequeue+e0/1c0>
> Trace; c01b8270 <htb_timer+30/50>
> Trace; c01b82ba <htb_rate_timer+2a/120>
> Trace; c01b0110 <nf_hook_slow+c0/150>
> Trace; c01b05dc <eth_header+2c/120>
> Trace; c01b8214 <htb_requeue+114/140>
> Trace; c01b8270 <htb_timer+30/50>
> Trace; c01b7220 <htb_classify+f0/110>
> Trace; c01b739b <htb_debug_dump+15b/300>
> Trace; c01b7220 <htb_classify+f0/110>
> Trace; c01b0110 <nf_hook_slow+c0/150>
> Trace; c01b70a6 <L2T+26/30>
> Trace; c01b7220 <htb_classify+f0/110>
> Trace; c01a87bb <netif_receive_skb+db/140>
> Trace; c01a885d <process_backlog+3d/110>
> Trace; c01a8970 <net_rx_action+40/110>
> Trace; c011427a <do_softirq+5a/b0>
> Trace; c01081cd <do_IRQ+9d/b0>
> Trace; c0105250 <default_idle+0/30>
> Trace; c010a3b8 <call_do_IRQ+5/d>
> Trace; c0105250 <default_idle+0/30>
> Trace; c0105273 <default_idle+23/30>
> Trace; c01052d8 <cpu_idle+38/50>
> Trace; c0105000 <_stext+0/0>
> Trace; c0105027 <rest_init+27/30>
> 
> Code;  c01eeb9e <init_or_cleanup+15e/160>
> 00000000 <_EIP>:
> Code;  c01eeb9e <init_or_cleanup+15e/160>   <=====
>    0:   8b 5e 18                  mov    0x18(%esi),%ebx   <=====
> Code;  c01eeba1 <ip_conntrack_protocol_register+1/70>
>    3:   11 d8                     adc    %ebx,%eax
> Code;  c01eeba3 <ip_conntrack_protocol_register+3/70>
>    5:   8b 5e 1c                  mov    0x1c(%esi),%ebx
> Code;  c01eeba6 <ip_conntrack_protocol_register+6/70>
>    8:   11 d8                     adc    %ebx,%eax
> Code;  c01eeba8 <ip_conntrack_protocol_register+8/70>
>    a:   8d 76 20                  lea    0x20(%esi),%esi
> Code;  c01eebab <ip_conntrack_protocol_register+b/70>
>    d:   49                        dec    %ecx
> Code;  c01eebac <ip_conntrack_protocol_register+c/70>
>    e:   75 d3                     jne    ffffffe3 <_EIP+0xffffffe3>
> Code;  c01eebae <ip_conntrack_protocol_register+e/70>
>   10:   83 d0 00                  adc    $0x0,%eax
> Code;  c01eebb1 <ip_conntrack_protocol_register+11/70>
>   13:   89 00                     mov    %eax,(%eax)
> 
>  <0>Kernel panic: Aiee, killing interrupt handler!
> 
> 1 error issued.  Results may not be reliable.
> 
> 
> -- 
> Ondrej Zary

Regards,
Willy

