Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262771AbUKRNXm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262771AbUKRNXm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 08:23:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262768AbUKRNWV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 08:22:21 -0500
Received: from mailhub.fr.lyceu.net ([213.193.0.30]:58243 "EHLO
	mailhub.fr.lyceu.net") by vger.kernel.org with ESMTP
	id S262765AbUKRNVc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 08:21:32 -0500
From: Olivier Poitrey <rs@mmania.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
Subject: Kernel panic in tcp_time_to_recover with 2.6.9
Date: Thu, 18 Nov 2004 14:17:27 +0100
Message-ID: <87is83qot4.fsf@ice.aspic.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Got a kernel panic at tcp_time_to_recover+75/1d0 on two nodes
(diskless except for swap) mounting the root fs via NFS
(v3,tcp). Those are linux-vserver hosts.

Although it might be unrelated, the memory usage, which was at
3.5GB total (1.5GB highmem, 2/2 split) showed an abrupt decrease of
cached memory one hour before the panic (about 0.5GB freed) on one
node. No unusual network activity was observed there.

The second node showed a similar decrease about 4 hours before the
crash (dropped from 3.5GB to 2.5GB, again cache was shrinked) half an
hour later, the cache was up and memory usage reached
3.5GB again. during this period the network traffic was higher than
usual in both directions.

You can find memory graphs of those nodes here:
http://rs.rhapsodyk.net/vserver/memory-first.png
http://rs.rhapsodyk.net/vserver/memory-second.png

The first node crashed a few minutes before the second and vservers
where started on the second one at that time (could be a network
attack which caused that)

A similar panic was already reported by George Clover
(2004-10-26 01:11 +200)


Unable to handle kernel NULL pointer dereference at virtual address 00000050
80298795
*pde = 00000000
Oops: 0000 [#1]
CPU:    1
EIP:    0060:[<80298795>]    Not tainted VLI
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246   (2.6.9-vs1.9.3+nfsall-node)
eax: 00000000   ebx: a1a0ac04   ecx: 00000001   edx: 00000000
esi: a1a0a9e0   edi: 00000004   ebp: 00000000   esp: 80407d14
ds: 007b   es: 007b   ss: 0068
Stack: a1a0a9e0 a1a0ac04 03a0a9e0 a1a0ac04 00000000 00000004 a1a0a9e0 802995aa
       a1a0a9e0 a1a0ac04 a1a0acc4 243bd148 03216fc4 00000000 0000010e 00000003
       da0f69ca a1a0ac04 00000001 00000001 0000010e 8029ab70 a1a0a9e0 da0f69ca
Call Trace:
Code: 0f b6 c0 39 c2 0f 8f 20 01 00 00 8b 8b 9c 00 00 00 85 c9 74 2c 8b 96 84


>>EIP; 80298795 <tcp_time_to_recover+75/1d0>   <=====

>>ebx; a1a0ac04 <pg0+215d3c04/7fbc7400>
>>esi; a1a0a9e0 <pg0+215d39e0/7fbc7400>
>>esp; 80407d14 <softirq_stack+1d14/4000>

Code;  80298795 <tcp_time_to_recover+75/1d0>
00000000 <_EIP>:
Code;  80298795 <tcp_time_to_recover+75/1d0>   <=====
   0:   0f b6 c0                  movzbl %al,%eax   <=====
Code;  80298798 <tcp_time_to_recover+78/1d0>
   3:   39 c2                     cmp    %eax,%edx
Code;  8029879a <tcp_time_to_recover+7a/1d0>
   5:   0f 8f 20 01 00 00         jg     12b <_EIP+0x12b>
Code;  802987a0 <tcp_time_to_recover+80/1d0>
   b:   8b 8b 9c 00 00 00         mov    0x9c(%ebx),%ecx
Code;  802987a6 <tcp_time_to_recover+86/1d0>
  11:   85 c9                     test   %ecx,%ecx
Code;  802987a8 <tcp_time_to_recover+88/1d0>
  13:   74 2c                     je     41 <_EIP+0x41>
Code;  802987aa <tcp_time_to_recover+8a/1d0>
  15:   8b 96 84 00 00 00         mov    0x84(%esi),%edx

 <0>Kernel panic - not syncing: Fatal exception in interrupt
  
Unable to handle kernel NULL pointer dereference at virtual address 00000050
80298795
*pde = 00000000
Oops: 0000 [#1]
CPU:    1
EIP:    0060:[<80298795>]    Not tainted VLI
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246   (2.6.9-vs1.9.3+nfsall-node)
eax: 00000000   ebx: a8495044   ecx: 00000001   edx: 00000000
esi: a8494e20   edi: 00000000   ebp: 00000000   esp: 80407d14
ds: 007b   es: 007b   ss: 0068
Stack: a8494e20 a8495044 03494e20 a8495044 00000000 00000000 a8494e20 802995aa
       a8494e20 a8495044 a8495104 243281c7 03000014 00000000 00000106 00000003
       cfd67591 a8495044 00000002 cfd67d78 00000106 8029ab70 a8494e20 cfd67591
Call Trace:
Code: 0f b6 c0 39 c2 0f 8f 20 01 00 00 8b 8b 9c 00 00 00 85 c9 74 2c 8b 96 84


>>EIP; 80298795 <tcp_time_to_recover+75/1d0>   <=====

>>ebx; a8495044 <pg0+2805e044/7fbc7400>
>>esi; a8494e20 <pg0+2805de20/7fbc7400>
>>esp; 80407d14 <softirq_stack+1d14/4000>

Code;  80298795 <tcp_time_to_recover+75/1d0>
00000000 <_EIP>:
Code;  80298795 <tcp_time_to_recover+75/1d0>   <=====
   0:   0f b6 c0                  movzbl %al,%eax   <=====
Code;  80298798 <tcp_time_to_recover+78/1d0>
   3:   39 c2                     cmp    %eax,%edx
Code;  8029879a <tcp_time_to_recover+7a/1d0>
   5:   0f 8f 20 01 00 00         jg     12b <_EIP+0x12b>
Code;  802987a0 <tcp_time_to_recover+80/1d0>
   b:   8b 8b 9c 00 00 00         mov    0x9c(%ebx),%ecx
Code;  802987a6 <tcp_time_to_recover+86/1d0>
  11:   85 c9                     test   %ecx,%ecx
Code;  802987a8 <tcp_time_to_recover+88/1d0>
  13:   74 2c                     je     41 <_EIP+0x41>
Code;  802987aa <tcp_time_to_recover+8a/1d0>
  15:   8b 96 84 00 00 00         mov    0x84(%esi),%edx

 <0>Kernel panic - not syncing: Fatal exception in interrupt

Those are dual PIII machines with 4GB Ram connect with two e1000 NICs,
one in GigE for internal network other in FastE for public network.

Patches used are the linux-vserver vs1.9.3 patch and the NFS_ALL
patches from:
http://linux-nfs.org/Linux-2.6.x/2.6.9/linux-2.6.9-NFS_ALL.dif

--
Olivier Poitrey
