Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131530AbRCXB05>; Fri, 23 Mar 2001 20:26:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131534AbRCXB0s>; Fri, 23 Mar 2001 20:26:48 -0500
Received: from www.resilience.com ([209.245.157.1]:41129 "EHLO
	www.resilience.com") by vger.kernel.org with ESMTP
	id <S131530AbRCXB0g>; Fri, 23 Mar 2001 20:26:36 -0500
Message-ID: <3ABBF872.F38FBA8F@resilience.com>
Date: Fri, 23 Mar 2001 17:29:22 -0800
From: Jeff Golds <jgolds@resilience.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Channel bonding kernel crash, workaround
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I heard about this issue, and just joined the mailing list.  I am
working on a driver similar to the bonding driver and am getting the
same results.

If I do the following:
ifconfig fte0 10.0.0.2 up
ifenslave fte0 eth1
ifenslave fte0 eth2
ifconfig fte0 down
ifconfig eth1

I get a kernel panic.  I checked the Oops log and saw the following with
ksymoops:

Oops: 0000
EIP: 0010:[<c020c7c9>]
Using defaults from ksymoops -t elf32-i386 -a i386
Call Trace: [<c0232d52>] [<c0232d80>] [<c02330d6>] [<c02310f7>]
[<c011f1d7>] [<c020a943>] [<c020b9cf>] [<c0230a04>] [<c0206388>]
[<c0142977>] [<c0109127>]
Code: 0f b6 4b 0b 8d 73 04 8b 7c 24 24 fc 39 c9 89 0c 24 f3 a6 0f
 
>>EIP; c020c7c9 <dev_mc_delete+a9/120>   <=====
Trace; c0232d52 <ip_mc_filter_del+32/40>
Trace; c0232d80 <igmp_group_dropped+20/b0>
Trace; c02330d6 <ip_mc_down+56/70>
Trace; c02310f7 <inetdev_event+f7/150>
Trace; c011f1d7 <notifier_call_chain+27/50>
Trace; c020a943 <dev_close+53/80>
Trace; c020b9cf <dev_change_flags+4f/f0>
Trace; c0230a04 <devinet_ioctl+2c4/630>
Trace; c0206388 <sock_ioctl+58/80>
Trace; c0142977 <sys_ioctl+1c7/210>
Trace; c0109127 <system_call+33/38>
Code;  c020c7c9 <dev_mc_delete+a9/120>
00000000 <_EIP>:
Code;  c020c7c9 <dev_mc_delete+a9/120>   <=====
   0:   0f b6 4b 0b               movzbl 0xb(%ebx),%ecx   <=====
Code;  c020c7cd <dev_mc_delete+ad/120>
   4:   8d 73 04                  lea    0x4(%ebx),%esi
Code;  c020c7d0 <dev_mc_delete+b0/120>
   7:   8b 7c 24 24               mov    0x24(%esp,1),%edi
Code;  c020c7d4 <dev_mc_delete+b4/120>
   b:   fc                        cld
Code;  c020c7d5 <dev_mc_delete+b5/120>
   c:   39 c9                     cmp    %ecx,%ecx
Code;  c020c7d7 <dev_mc_delete+b7/120>
   e:   89 0c 24                  mov    %ecx,(%esp,1)
Code;  c020c7da <dev_mc_delete+ba/120>
  11:   f3 a6                     repz cmpsb %es:(%edi),%ds:(%esi)
Code;  c020c7dc <dev_mc_delete+bc/120>
  13:   0f 00 00                  sldt   (%eax)

This is AFTER I removed the code in my driver to set the slave devices'
multicast lists to be equal to the master's.  When I put that code back
in (see bond_set_multicast_list in bonding.c), I get a crash at the same
location, but the call trace is slightly different.

It's looking like the multicast list is either corrupted or the data was
freed elsewhere.

Anyone have any ideas what might be wrong?  The driver I am working on
is a close match to the bonding driver, so that can be used as a
reference.

Thanks for any feedback.

-Jeff

P.S.  I saw the workaround posted earlier, but I am trying to fix this
crash.

-- 
Jeff Golds
jgolds@resilience.com
