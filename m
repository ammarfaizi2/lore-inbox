Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261591AbVBWVKv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261591AbVBWVKv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 16:10:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261590AbVBWVKk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 16:10:40 -0500
Received: from ns1.lanforge.com ([66.165.47.210]:20708 "EHLO www.lanforge.com")
	by vger.kernel.org with ESMTP id S261594AbVBWVIL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 16:08:11 -0500
Message-ID: <421CF0BA.1020100@candelatech.com>
Date: Wed, 23 Feb 2005 13:08:10 -0800
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.3) Gecko/20041020
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: netdev@oss.sgi.com
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Tulip (DFE-570tx) & keyboard lockup in 2.6.9 and other 2.6 kernels.
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I finally had some time to debug this one a little more
thoroughly.  On two different machines (Shuttle SB61G1) I
get the same results, so I do not believe it is bad hardware...

The bug is as follows:

I have 1 4-port tulip NIC in the machine.  If I generate traffic
between two interfaces, it runs fine.  But, if I start running traffic
on all 4 interfaces, the keyboard quits taking input, and ethernet
traffic stops on at least a few of the interfaces.  I can still ssh
into the machine (via the rtl8139 interface), so at least one of the
processors (I'm using SMP on an P4 HT processor) is working.  I also
enabled NMI and that does not trigger.

I ran the tulip-diag tool, and the third interface seems to be in a bad way:

[root@lf61g2-blk root]# tulip-diag
tulip-diag.c:v2.07 3/31/2001 Donald Becker (becker@scyld.com)
  http://www.scyld.com/diag/index.html
Index #1: Found a Digital DS21143 Tulip adapter at 0xc000.
  Port selection is MII, full-duplex.
  Transmit started, Receive started, full-duplex.
   The Rx process state is 'Waiting for packets'.
   The Tx process state is 'Idle'.
   The transmit threshold is 256.
   The NWay status register is 000000c6.
   Internal autonegotiation state is 'Autonegotiation disabled'.
Index #2: Found a Digital DS21143 Tulip adapter at 0xc100.
  Port selection is MII, full-duplex.
  Transmit started, Receive started, full-duplex.
   The Rx process state is 'Waiting for packets'.
   The Tx process state is 'Idle'.
   The transmit threshold is 256.
   The NWay status register is 000000c6.
   Internal autonegotiation state is 'Autonegotiation disabled'.
Index #3: Found a Digital DS21143 Tulip adapter at 0xc200.
  Port selection is MII, full-duplex.
  Transmit started, Receive started, full-duplex.
   The Rx process state is 'Suspended -- no Rx buffers'.
   The Tx process state is 'Idle'.
   The transmit threshold is 128.
   The NWay status register is 000000c6.
   Internal autonegotiation state is 'Autonegotiation disabled'.
Index #4: Found a Digital DS21143 Tulip adapter at 0xc300.
  Port selection is MII, full-duplex.
  Transmit started, Receive started, full-duplex.
   The Rx process state is 'Waiting for packets'.
   The Tx process state is 'Idle'.
   The transmit threshold is 128.
   The NWay status register is 000000c6.
   Internal autonegotiation state is 'Autonegotiation disabled'.


The interrupt count for eth3 is not increasing.  I tried to bring
down the interface with 'ifconfig eth3 down' and that command hung
as well.

I tried getting sysrq to print out the stack for ifconfig, but
I'm not sure it worked:

ifconfig      R running  6128  3692   3631                     (NOTLB)
sshd          S D9717E6C  6488  3693   2193  3695          3629 (NOTLB)
d9717eac 00000082 d9721954 d9717e6c 00000000 c0356580 c0335d00 c0335c80
        00000286 b04a5e80 000f44f5 00000019 de056890 00000008 00000000 c1402980
        c1402020 00000001 00000000 b04a5e80 000f44f5 de056df0 de056f58 00000001
Call Trace:
  [<c02e328b>] schedule_timeout+0xc3/0xc5
  [<c01ffd19>] normal_poll+0x0/0x134
  [<c01f9a61>] tty_ldisc_deref+0x63/0x7d
  [<c01fbe86>] tty_poll+0x90/0xb2
  [<c016ba1e>] do_select+0x193/0x2b9
  [<c016b6f1>] __pollwait+0x0/0xc1
  [<c016bdf4>] sys_select+0x29b/0x50c
  [<c0105f91>] sysenter_past_esp+0x52/0x71
bash          R running  6620  3695   3693                     (NOTLB)


I tried this same hardware running RH9 with the 2.4.27 kernel and
it works like a charm.

This is easily repeatable, so please let me know what information I
can offer to help debug this.

Thanks,
Ben


-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

