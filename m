Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129849AbQLZMQI>; Tue, 26 Dec 2000 07:16:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130196AbQLZMP6>; Tue, 26 Dec 2000 07:15:58 -0500
Received: from 5dyn231.com21.casema.net ([212.64.96.231]:30481 "HELO
	home.ds9a.nl") by vger.kernel.org with SMTP id <S129849AbQLZMPl>;
	Tue, 26 Dec 2000 07:15:41 -0500
Date: Tue, 26 Dec 2000 12:45:12 +0100
From: Jasper Spaans <jasper@spaans.ds9a.nl>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org, "David S. Miller" <davem@redhat.com>
Subject: Re: [bug] test13-pre4 nfs/ip_defrag crash (smp)
Message-ID: <20001226124512.A888@spaans.ds9a.nl>
In-Reply-To: <20001225225925.A1276@spaans.ds9a.nl> <Pine.LNX.4.10.10012251632310.6546-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10012251632310.6546-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Mon, Dec 25, 2000 at 04:34:37PM -0800
Organization: http://www.insultant.nl/
X-Copyright: Copyright 2000 C. Jasper Spaans - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 25, 2000 at 04:34:37PM -0800, Linus Torvalds wrote:
> 
> 
> On Mon, 25 Dec 2000, Jasper Spaans wrote:
> > 
> > I am having some reproducible crashes with 2.4.0-test13-pre4, whenever I
> > do some 'heavy' nfs-ing.. decoded oops:
> 
> It looks like most of what you have is modules. Is netfilter enabled as a
> module too? Can you reproduce it without modules, in case it's a
> autounload race or similar?

Right, I've just recompiled with nfs, iptables and my nic driver (8139too)
in the kernel. Testing[*] with nfs v2 and v3 crashes it, first oops is with v2,
second with v3:

[*]: just copying a set of large files between two machines running
2.4.0-test13-pre4 [which are able to saturate the 10Mbps link between them],
when copying to a slower machine running 2.2.18, it doesn't crash.

ksymoops 2.3.4 on i686 2.4.0-test13-pre4.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.0-test13-pre4/ (default)
     -m /boot/System.map-2.4.0-test13-pre4 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Unable to handle kernel paging request at virtual address 6361636b
c020609e
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c020609e>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010202
eax: 6361632f   ebx: cf0b4f00   ecx: c91bc824   edx: c9e0bfa0
esi: 00000b90   edi: cf0af0c0   ebp: 000005c8   esp: c99bfc4c
ds: 0018   es: 0018   ss: 0018
Process rpciod (pid: 681, stackpage=c99bf000)
Stack: c9e0bfa0 00000000 00001906 0700000a 00000014 00000000 c020648d c9e0bfa0 
       cf0af0c0 c03219ac c99be000 c99d71c0 cf0af0c0 6361632f c91bc810 c0229262 
       cf0af0c0 c99bfd48 c0349b38 c0208efc c99bfd58 c02289c9 cf0af0c0 c99bfd48 
Call Trace: [<c020648d>] [<c0229262>] [<c0208efc>] [<c02289c9>] [<c0208efc>] [<c0208f10>] [<c0208f10>] 
       [<c0200517>] [<c0227c3a>] [<c0208efc>] [<c0200298>] [<c0208efc>] [<c0208efc>] [<c0200517>] [<c0208efc>] 
       [<c020849b>] [<c0208efc>] [<c021e058>] [<c02085c6>] [<c021e058>] [<ea00000a>] [<c01f8b0e>] [<c021e4ee>] 
       [<c021e058>] [<ea00000a>] [<ea00000a>] [<ea00000a>] [<c0223c96>] [<c01f5c45>] [<c023ae9a>] [<c011345d>] 
       [<c016a214>] [<c023dde9>] [<c023ad45>] [<c0239043>] [<c023c58b>] [<c023c989>] [<c023d26e>] [<c0107480>] 
Code: 8b 40 3c 8b 4c 24 1c 89 41 3c c7 47 18 00 00 00 00 8b 54 24 

>>EIP; c020609e <ip_frag_queue+20a/260>   <=====
Trace; c020648d <ip_defrag+dd/180>
Trace; c0229262 <ip_ct_gather_frags+2e/ac>
Trace; c0208efc <output_maybe_reroute+0/14>
Trace; c02289c9 <ip_conntrack_in+39/2cc>
Trace; c0208efc <output_maybe_reroute+0/14>
Trace; c0208f10 <ip_finish_output2+0/d4>
Trace; c0208f10 <ip_finish_output2+0/d4>
Trace; c0200517 <nf_hook_slow+3f/b8>
Trace; c0227c3a <ip_conntrack_local+5a/60>
Trace; c0208efc <output_maybe_reroute+0/14>
Trace; c0200298 <nf_iterate+34/88>
Trace; c0208efc <output_maybe_reroute+0/14>
Trace; c0208efc <output_maybe_reroute+0/14>
Trace; c0200517 <nf_hook_slow+3f/b8>
Trace; c0208efc <output_maybe_reroute+0/14>
Trace; c020849b <ip_build_xmit_slow+3cf/4ac>
Trace; c0208efc <output_maybe_reroute+0/14>
Trace; c021e058 <udp_getfrag+0/c4>
Trace; c02085c6 <ip_build_xmit+4e/334>
Trace; c021e058 <udp_getfrag+0/c4>
Trace; ea00000a <END_OF_CODE+18eda587/????>
Trace; c01f8b0e <__kfree_skb+132/138>
Trace; c021e4ee <udp_sendmsg+38a/414>
Trace; c021e058 <udp_getfrag+0/c4>
Trace; ea00000a <END_OF_CODE+18eda587/????>
Trace; ea00000a <END_OF_CODE+18eda587/????>
Trace; ea00000a <END_OF_CODE+18eda587/????>
Trace; c0223c96 <inet_sendmsg+3e/44>
Trace; c01f5c45 <sock_sendmsg+69/88>
Trace; c023ae9a <do_xprt_transmit+14e/3f8>
Trace; c011345d <smp_apic_timer_interrupt+f1/104>
Trace; c016a214 <nfs_xdr_writeargs+0/d8>
Trace; c023dde9 <rpcauth_marshcred+51/58>
Trace; c023ad45 <xprt_transmit+9d/a4>
Trace; c0239043 <call_transmit+3f/68>
Trace; c023c58b <__rpc_execute+c3/338>
Trace; c023c989 <__rpc_schedule+119/15c>
Trace; c023d26e <rpciod+102/274>
Trace; c0107480 <kernel_thread+28/38>
Code;  c020609e <ip_frag_queue+20a/260>
00000000 <_EIP>:
Code;  c020609e <ip_frag_queue+20a/260>   <=====
   0:   8b 40 3c                  mov    0x3c(%eax),%eax   <=====
Code;  c02060a1 <ip_frag_queue+20d/260>
   3:   8b 4c 24 1c               mov    0x1c(%esp,1),%ecx
Code;  c02060a5 <ip_frag_queue+211/260>
   7:   89 41 3c                  mov    %eax,0x3c(%ecx)
Code;  c02060a8 <ip_frag_queue+214/260>
   a:   c7 47 18 00 00 00 00      movl   $0x0,0x18(%edi)
Code;  c02060af <ip_frag_queue+21b/260>
  11:   8b 54 24 00               mov    0x0(%esp,1),%edx

Kernel panic: Aiee, killing interrupt handler!

1 warning issued.  Results may not be reliable.


ksymoops 2.3.4 on i686 2.4.0-test13-pre4.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.0-test13-pre4/ (default)
     -m /boot/System.map-2.4.0-test13-pre4 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Unable to handle kernel paging request at virtual address 400fcab8
c020609e
*pde = 0e6eb067
Oops: 0000
CPU:    1
EIP:    0010:[<c020609e>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010202
eax: 400fca7c   ebx: cf96d8c0   ecx: c89a2024   edx: cf1eae60
esi: 00001720   edi: cf96d820   ebp: 00001158   esp: c898bc4c
ds: 0018   es: 0018   ss: 0018
Process rpciod (pid: 809, stackpage=c898b000)
Stack: cf1eae60 00000000 000082a9 0700000a 00000014 00000000 c020648d cf1eae60 
       cf96d820 c03219ac c898a000 cb0f6120 cf96d820 400fca7c c89a2010 c0229262 
       cf96d820 c898bd48 c0349b38 c0208efc c898bd58 c02289c9 cf96d820 c898bd48 
Call Trace: [<c020648d>] [<c0229262>] [<c0208efc>] [<c02289c9>] [<c0208efc>] [<c0208f10>] [<c0208f10>] 
       [<c0200517>] [<c0227c3a>] [<c0208efc>] [<c0200298>] [<c0208efc>] [<c0208efc>] [<c0200517>] [<c0208efc>] 
       [<c020849b>] [<c0208efc>] [<c021e058>] [<c02085c6>] [<c021e058>] [<ea00000a>] [<c01f8b0e>] [<c021e4ee>] 
       [<c021e058>] [<ea00000a>] [<ea00000a>] [<ea00000a>] [<c0223c96>] [<c01f5c45>] [<c023ae9a>] [<c0205736>] 
       [<c020586c>] [<c0163820>] [<c016cf08>] [<c023dde9>] [<c023ad45>] [<c0239043>] [<c023c58b>] [<c023c989>] 
       [<c023d26e>] [<c0107480>] 
Code: 8b 40 3c 8b 4c 24 1c 89 41 3c c7 47 18 00 00 00 00 8b 54 24 

>>EIP; c020609e <ip_frag_queue+20a/260>   <=====
Trace; c020648d <ip_defrag+dd/180>
Trace; c0229262 <ip_ct_gather_frags+2e/ac>
Trace; c0208efc <output_maybe_reroute+0/14>
Trace; c02289c9 <ip_conntrack_in+39/2cc>
Trace; c0208efc <output_maybe_reroute+0/14>
Trace; c0208f10 <ip_finish_output2+0/d4>
Trace; c0208f10 <ip_finish_output2+0/d4>
Trace; c0200517 <nf_hook_slow+3f/b8>
Trace; c0227c3a <ip_conntrack_local+5a/60>
Trace; c0208efc <output_maybe_reroute+0/14>
Trace; c0200298 <nf_iterate+34/88>
Trace; c0208efc <output_maybe_reroute+0/14>
Trace; c0208efc <output_maybe_reroute+0/14>
Trace; c0200517 <nf_hook_slow+3f/b8>
Trace; c0208efc <output_maybe_reroute+0/14>
Trace; c020849b <ip_build_xmit_slow+3cf/4ac>
Trace; c0208efc <output_maybe_reroute+0/14>
Trace; c021e058 <udp_getfrag+0/c4>
Trace; c02085c6 <ip_build_xmit+4e/334>
Trace; c021e058 <udp_getfrag+0/c4>
Trace; ea00000a <END_OF_CODE+18eda587/????>
Trace; c01f8b0e <__kfree_skb+132/138>
Trace; c021e4ee <udp_sendmsg+38a/414>
Trace; c021e058 <udp_getfrag+0/c4>
Trace; ea00000a <END_OF_CODE+18eda587/????>
Trace; ea00000a <END_OF_CODE+18eda587/????>
Trace; ea00000a <END_OF_CODE+18eda587/????>
Trace; c0223c96 <inet_sendmsg+3e/44>
Trace; c01f5c45 <sock_sendmsg+69/88>
Trace; c023ae9a <do_xprt_transmit+14e/3f8>
Trace; c0205736 <ip_rcv+33e/388>
Trace; c020586c <ip_rcv_finish+0/214>
Trace; c0163820 <nfs_refresh_inode+60/3dc>
Trace; c016cf08 <nfs3_xdr_writeargs+0/108>
Trace; c023dde9 <rpcauth_marshcred+51/58>
Trace; c023ad45 <xprt_transmit+9d/a4>
Trace; c0239043 <call_transmit+3f/68>
Trace; c023c58b <__rpc_execute+c3/338>
Trace; c023c989 <__rpc_schedule+119/15c>
Trace; c023d26e <rpciod+102/274>
Trace; c0107480 <kernel_thread+28/38>
Code;  c020609e <ip_frag_queue+20a/260>
00000000 <_EIP>:
Code;  c020609e <ip_frag_queue+20a/260>   <=====
   0:   8b 40 3c                  mov    0x3c(%eax),%eax   <=====
Code;  c02060a1 <ip_frag_queue+20d/260>
   3:   8b 4c 24 1c               mov    0x1c(%esp,1),%ecx
Code;  c02060a5 <ip_frag_queue+211/260>
   7:   89 41 3c                  mov    %eax,0x3c(%ecx)
Code;  c02060a8 <ip_frag_queue+214/260>
   a:   c7 47 18 00 00 00 00      movl   $0x0,0x18(%edi)
Code;  c02060af <ip_frag_queue+21b/260>
  11:   8b 54 24 00               mov    0x0(%esp,1),%edx

Kernel panic: Aiee, killing interrupt handler!

1 warning issued.  Results may not be reliable.

Regards,
-- 
Jasper Spaans  <jasper@spaans.ds9a.nl>
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
