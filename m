Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261310AbSJUKy2>; Mon, 21 Oct 2002 06:54:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261317AbSJUKy2>; Mon, 21 Oct 2002 06:54:28 -0400
Received: from m029-045.nv.iinet.net.au ([203.217.29.45]:7808 "EHLO localhost")
	by vger.kernel.org with ESMTP id <S261310AbSJUKy0>;
	Mon, 21 Oct 2002 06:54:26 -0400
To: linux-kernel@vger.kernel.org
Subject: ieee1394 Oops with 2.5.44
Message-ID: <87znt8nkvl.fsf@enki.rimspace.net>
From: Daniel Pittman <daniel@rimspace.net>
Organization: Not today, thank you, Mother.
Date: Mon, 21 Oct 2002 21:00:16 +1000
User-Agent: Gnus/5.090008 (Oort Gnus v0.08) XEmacs/21.5 (bamboo,
 i686-pc-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am trying to use a DVD burner in an external ieee-1394 enclosure.
Sadly, trying to scan the bus with either 2.4.42 or 2.4.44 and the
patches from current Linus BK tree fails in the same fashion.

The BUG happens regardless of the presence or absence of a device on the
bus in question:

------------[ cut here ]------------
kernel BUG at kernel/workqueue.c:69!
invalid operand: 0000
 
CPU:    0
EIP:    0060:[<c0126a95>]    Not tainted
EFLAGS: 00010206
EIP is at queue_work+0x25/0x98
eax: 00000000   ebx: c93de000   ecx: c151e900   edx: d57c1f90
esi: d57c1f90   edi: d57c1f94   ebp: c151e900   esp: c93dfde8
ds: 0068   es: 0068   ss: 0068
Process gscanbus (pid: 1520, threadinfo=c93de000 task=caf1a180)
Stack: d57c1f90 dfc0b784 dfc0b784 c9977b80 c0127277 c0230404 dfc0b740 0000ffc0 
       00000206 c02310e0 dfc0b740 00000010 dfd2c000 c9977b90 dfc0b7a4 00000003 
       00000001 dfc0b740 c02315ad dfd2c000 00000006 c9977b80 00000010 c9977b80 
Call Trace:
 [<c0127277>] schedule_work+0xf/0x10
 [<c0230404>] process_complete_tasks+0x2c/0x38
 [<c02310e0>] handle_packet_response+0x270/0x27c
 [<c02315ad>] hpsb_packet_received+0x45/0x7c
 [<c0230dea>] hpsb_send_packet+0x132/0x198
 [<c0230e5b>] send_packet_nocare+0xb/0x20
 [<c0231396>] handle_incoming_packet+0x232/0x404
 [<c02315c0>] hpsb_packet_received+0x58/0x7c
 [<c0230dea>] hpsb_send_packet+0x132/0x198
 [<c023baac>] handle_async_request+0x324/0x364
 [<c023d808>] state_connected+0x1cc/0x1d4
 [<c023d8ec>] raw1394_write+0xdc/0x100
 [<c013f421>] vfs_write+0xc5/0x15c
 [<c013f51e>] sys_write+0x2a/0x3c
 [<c0106f7b>] syscall_call+0x7/0xb

Code: 0f 0b 45 00 9e f7 32 c0 8d 76 00 89 6e 14 9c 5a fa ff 43 10 
 <6>note: gscanbus[1520] exited with preempt_count 1


On the plus side, the external enclosure is identified and returns valid
identifying information:

ieee1394: Host added: Node[01:1023]  GUID[00061b0010003321]  [Linux OHCI-1394]

Rescanning the SCSI bus or using scsi-add to try and have the device
identified correctly fails, however, and I cannot access the hardware.

Rebuilding with excessive debugging output, rebooting and /not/ running
gscanbus gives me no BUG, but no joy with the device either: it still is
not detected.

The following is the log from powering down and then up the device:

ohci1394_0: IntEvent: 00020010
ohci1394_0: irq_handler: Bus reset requested
ohci1394_0: Cancel request received
ohci1394_0: Got RQPkt interrupt status=0x00008409
ohci1394_0: Single packet rcv'd
ohci1394_0: Got phy packet ctx=0 ... discarded
ohci1394_0: IntEvent: 00010000
ohci1394_0: SelfID interrupt received (phyid 1, root)
ohci1394_0: SelfID packet 0x803f8466 received
ieee1394: Including SelfID 0x66843f80
ohci1394_0: SelfID packet 0x817f88d2 received
ieee1394: Including SelfID 0xd2887f81
ohci1394_0: SelfID for this node is 0x817f88d2
ohci1394_0: SelfID complete
ieee1394: selfid_complete called with successful SelfID stage ... irm_id: 0xFFC1 node_id: 0xFFC1
ohci1394_0: Cycle master enabled
ieee1394: NodeMgr: Processing host reset for ohci1394
ohci1394_0: PhyReqFilter=ffffffffffffffff

ieee1394: Initiating ConfigROM request for node 01:1023
ieee1394: send packet local: ffc16940 ffc1ffff f0000400
ieee1394: received packet: ffc16940 ffc1ffff f0000400
ieee1394: send packet local: ffc16960 ffc10000 00000000 fc0d0404
ieee1394: received packet: ffc16960 ffc10000 00000000 fc0d0404
ieee1394: send packet local: ffc16d40 ffc1ffff f0000404
ieee1394: received packet: ffc16d40 ffc1ffff f0000404
ieee1394: send packet local: ffc16d60 ffc10000 00000000 34393331
ieee1394: received packet: ffc16d60 ffc10000 00000000 34393331
ieee1394: send packet local: ffc17140 ffc1ffff f0000408
ieee1394: received packet: ffc17140 ffc1ffff f0000408
ieee1394: send packet local: ffc17160 ffc10000 00000000 02a000e0
ieee1394: received packet: ffc17160 ffc10000 00000000 02a000e0
ieee1394: send packet local: ffc17540 ffc1ffff f000040c
ieee1394: received packet: ffc17540 ffc1ffff f000040c
ieee1394: send packet local: ffc17560 ffc10000 00000000 001b0600
ieee1394: received packet: ffc17560 ffc10000 00000000 001b0600
ieee1394: send packet local: ffc17940 ffc1ffff f0000410
ieee1394: received packet: ffc17940 ffc1ffff f0000410
ieee1394: send packet local: ffc17960 ffc10000 00000000 21330010
ieee1394: received packet: ffc17960 ffc10000 00000000 21330010
ieee1394: Node 00:1023 changed to 01:1023
ohci1394_0: IntEvent: 00020010
ohci1394_0: irq_handler: Bus reset requested
ohci1394_0: Cancel request received
ohci1394_0: Got RQPkt interrupt status=0x00008409
ohci1394_0: Single packet rcv'd
ohci1394_0: Got phy packet ctx=0 ... discarded
ohci1394_0: IntEvent: 00010000
ohci1394_0: SelfID interrupt received (phyid 1, root)
ohci1394_0: SelfID packet 0x803f8466 received
ieee1394: Including SelfID 0x66843f80
ohci1394_0: SelfID packet 0x817f88d0 received
ieee1394: Including SelfID 0xd0887f81
ohci1394_0: SelfID for this node is 0x817f88d0
ohci1394_0: SelfID complete
ieee1394: selfid_complete called with successful SelfID stage ... irm_id: 0xFFC1 node_id: 0xFFC1
ohci1394_0: Cycle master enabled
ieee1394: NodeMgr: Processing host reset for ohci1394
ohci1394_0: PhyReqFilter=ffffffffffffffff
ieee1394: Initiating ConfigROM request for node 01:1023
ieee1394: send packet local: ffc17d40 ffc1ffff f0000400
ieee1394: received packet: ffc17d40 ffc1ffff f0000400
ieee1394: send packet local: ffc17d60 ffc10000 00000000 fc0d0404
ieee1394: received packet: ffc17d60 ffc10000 00000000 fc0d0404
ieee1394: send packet local: ffc18140 ffc1ffff f0000404
ieee1394: received packet: ffc18140 ffc1ffff f0000404
ieee1394: send packet local: ffc18160 ffc10000 00000000 34393331
ieee1394: received packet: ffc18160 ffc10000 00000000 34393331
ieee1394: send packet local: ffc18540 ffc1ffff f0000408
ieee1394: received packet: ffc18540 ffc1ffff f0000408
ieee1394: send packet local: ffc18560 ffc10000 00000000 02a000e0
ieee1394: received packet: ffc18560 ffc10000 00000000 02a000e0
ieee1394: send packet local: ffc18940 ffc1ffff f000040c
ieee1394: received packet: ffc18940 ffc1ffff f000040c
ieee1394: send packet local: ffc18960 ffc10000 00000000 001b0600
ieee1394: received packet: ffc18960 ffc10000 00000000 001b0600
ieee1394: send packet local: ffc18d40 ffc1ffff f0000410
ieee1394: received packet: ffc18d40 ffc1ffff f0000410
ieee1394: send packet local: ffc18d60 ffc10000 00000000 21330010
ieee1394: received packet: ffc18d60 ffc10000 00000000 21330010

          Daniel


-- 
Meetings are an addictive, highly self-indulgent activity that corporations
and other large organizations habitually engage in only because they cannot
actually masturbate.
        -- Dave Barry
