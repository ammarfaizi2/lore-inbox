Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266354AbTAONN4>; Wed, 15 Jan 2003 08:13:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266363AbTAONN4>; Wed, 15 Jan 2003 08:13:56 -0500
Received: from smtp1.ambisys.net ([210.174.171.87]:57812 "EHLO
	smtp1.ambisys.net") by vger.kernel.org with ESMTP
	id <S266354AbTAONNy>; Wed, 15 Jan 2003 08:13:54 -0500
Date: Wed, 15 Jan 2003 22:22:46 +0900
From: "Eric E. Bowles" <bowles@ambisys.com>
To: linux-kernel@vger.kernel.org
Subject: 2.4.20 crashes when incoming/outgoing interfaces differ
Message-ID: <20030115132246.GA7242%bowles@ambisys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-PGP-Key: http://pgp.mit.edu:11371/pks/lookup?search=0xDF2A5A65&op=index
X-Fingerprint: A021 4BEB 9029 CB6A 9261  E755 76D8 3401 DF2A 5A65
User-Agent: Mutt/1.5.1i-ja.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[I originally sent this to the OpenVPN devel mailing list, and it
 was suggested that I forward it to other lists since it might be a
 problem involving netfilter and/or the kernel, so here goes....]

Hi there,

I've been experiencing kernel crashes with OpenVPN (http://openvpn.sf.net) 
on Linux under a certain set of conditions, and wondered if anybody else can 
reproduce this.

Here are the steps needed to cause the crash:

  1. Create an OpenVPN TUN link between two hosts, Host-A and Host-B.

  2. Add an iptables rule to Host-A to REJECT connections from unauthorized 
     networks, generating an ICMP port unreachable.  Typically, this would
     be the "default deny" rule in a firewall, for example:

       iptables -A reject -j REJECT --reject-with icmp-port-unreachable

  3. Make a TCP connection (e.g., ssh) from Host-B to Host-A's tunnel
     interface, using a source address for which Host-A:
       (a) doesn't have a route directed across the tunnel, and
       (b) doesn't explicitly permit (so that the iptables rule above will 
           apply)

     [The connection doesn't have to be made to Host-A's tunnel interface; it 
      could be to any interface on Host-A that causes the connection to 
      traverse the tunnel from Host-B to Host-A.]

What I think is happening is this: when an incoming connection arrives
on Host-A's TUN interface, the REJECT rule is triggered, causing an 
"ICMP unreachable" to be sent back.  However, since there is no return 
route back across the tunnel, the default route is selected, which causes 
the ICMP packet to be <<returned on an interface that is different from the
incoming interface>> (i.e., the tunnel).  Since the incoming (tun) and 
outgoing (eth) interfaces have different link layer header sizes, the 
kernel is crashing in skb_push().

Software:
  openvpn 1.3.1.7, 1.3.2, 1.3.2.5
  linux kernel 2.4.19, 2.4.20
  iptables 1.2.7a
  iptables patch-o-matic 20020930, 20021127

I've attached the kernel oops output below.

I hope I've provided sufficient information to reproduce the crash.
Please let me know if you need more information, since I'm interested
in helping solve this problem.

Thanks,

--eric

===========================================================================
% kernel BUG at skbuff.c:109!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c01c5627>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010282
eax: 00000028   ebx: 00000000   ecx: cf7d8000   edx: cc52f11c
esi: cc463f00   edi: 00000800   ebp: cf77f000   esp: ce531c68
ds: 0018   es: 0018   ss: 0018
Process openvpn (pid: 3954, stackpage=ce531000)
Stack: c02374a0 c01d0215 00000036 0000000e cf77f000 c01d021e cc463f00
0000000e
       c01d0215 ce927d80 cc463f00 cb58c0c0 cf77f000 c01cca1a cc463f00
cf77f000
       00000800 cb58c0e4 00000000 00000028 cc463f00 00000000 cf77f000
00000000
Call Trace:    [<c01d0215>] [<c01d021e>] [<c01d0215>] [<c01cca1a>]
[<c01ddb05>]
  [<c01cf12e>] [<c01dd975>] [<c01dda78>] [<c01cf12e>] [<d00e3384>]
[<c01dd936>]
  [<d00e7906>] [<d00e3835>] [<d00402e2>] [<d0042660>] [<d0042660>]
[<d0042660>]
  [<c01da0c6>] [<d0044080>] [<d00445c0>] [<c01cee0d>] [<c01da0c6>]
[<c01cf0ee>]
  [<c01da0c6>] [<d0044600>] [<c01d9eb5>] [<c01da0c6>] [<c01da3a9>]
[<c01cf12e>]
  [<c01da03d>] [<c01da1fa>] [<c01c9780>] [<c01c9889>] [<c01c9983>]
[<c011b6ad>]
  [<d00e1b4c>] [<d00e12d6>] [<c0132c2f>] [<c0108933>]
Code: 0f 0b 6d 00 8b 64 23 c0 83 c4 14 c3 90 a1 28 2c 2a c0 56 03


>>EIP; c01c5627 <skb_under_panic+29/36>   <=====

>>ecx; cf7d8000 <_end+f513308/fd48368>
>>edx; cc52f11c <_end+c26a424/fd48368>
>>esi; cc463f00 <_end+c19f208/fd48368>
>>ebp; cf77f000 <_end+f4ba308/fd48368>
>>esp; ce531c68 <_end+e26cf70/fd48368>

Trace; c01d0215 <eth_header+15d/16e>
Trace; c01d021e <eth_header+166/16e>
Trace; c01d0215 <eth_header+15d/16e>
Trace; c01cca1a <neigh_resolve_output+a6/198>
Trace; c01ddb05 <ip_finish_output2+8d/c4>
Trace; c01cf12e <nf_hook_slow+a0/144>
Trace; c01dd975 <ip_finish_output+3f/44>
Trace; c01dda78 <ip_finish_output2+0/c4>
Trace; c01cf12e <nf_hook_slow+a0/144>
Trace; d00e3384 <[ipt_REJECT]send_reset+308/37e>
Trace; c01dd936 <ip_finish_output+0/44>
Trace; d00e7906 <[ipt_LOG].text.end+ad/1ff>
Trace; d00e3835 <[ipt_REJECT]reject+5f/62>
Trace; d00402e2 <[ip_tables]ipt_do_table+262/2e4>
Trace; d0042660 <[ip_tables]__kstrtab_ipt_register_table+0/0>
Trace; d0042660 <[ip_tables]__kstrtab_ipt_register_table+0/0>
Trace; d0042660 <[ip_tables]__kstrtab_ipt_register_table+0/0>
Trace; c01da0c6 <ip_local_deliver_finish+0/134>
Trace; d0044080 <[iptable_filter]ipt_hook+20/24>
Trace; d00445c0 <[iptable_filter]packet_filter+0/40>
Trace; c01cee0d <nf_iterate+51/86>
Trace; c01da0c6 <ip_local_deliver_finish+0/134>
Trace; c01cf0ee <nf_hook_slow+60/144>
Trace; c01da0c6 <ip_local_deliver_finish+0/134>
Trace; d0044600 <[iptable_filter]ipt_ops+0/48>
Trace; c01d9eb5 <ip_local_deliver+35/54>
Trace; c01da0c6 <ip_local_deliver_finish+0/134>
Trace; c01da3a9 <ip_rcv_finish+1af/1fa>
Trace; c01cf12e <nf_hook_slow+a0/144>
Trace; c01da03d <ip_rcv+169/1f2>
Trace; c01da1fa <ip_rcv_finish+0/1fa>
Trace; c01c9780 <netif_receive_skb+100/1a0>
Trace; c01c9889 <process_backlog+69/104>
Trace; c01c9983 <net_rx_action+5f/ea>
Trace; c011b6ad <do_softirq+89/8c>
Trace; d00e1b4c <[tun]tun_get_user+d0/13f>
Trace; d00e12d6 <[tun]tun_chr_write+28/2c>
Trace; c0132c2f <sys_write+85/ea>
Trace; c0108933 <system_call+33/40>

Code;  c01c5627 <skb_under_panic+29/36>
00000000 <_EIP>:
Code;  c01c5627 <skb_under_panic+29/36>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c01c5629 <skb_under_panic+2b/36>
   2:   6d                        insl   (%dx),%es:(%edi)
Code;  c01c562a <skb_under_panic+2c/36>
   3:   00 8b 64 23 c0 83         add    %cl,0x83c02364(%ebx)
Code;  c01c5630 <skb_under_panic+32/36>
   9:   c4 14 c3                  les    (%ebx,%eax,8),%edx
Code;  c01c5633 <skb_under_panic+35/36>
   c:   90                        nop    
Code;  c01c5634 <alloc_skb+0/1a6>
   d:   a1 28 2c 2a c0            mov    0xc02a2c28,%eax
Code;  c01c5639 <alloc_skb+5/1a6>
  12:   56                        push   %esi
Code;  c01c563a <alloc_skb+6/1a6>
  13:   03 00                     add    (%eax),%eax

 <0>Kernel panic: Aiee, killing interrupt handler!

2 errors issued.  Results may not be reliable.
===========================================================================
