Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266321AbRGTAEu>; Thu, 19 Jul 2001 20:04:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266330AbRGTAEl>; Thu, 19 Jul 2001 20:04:41 -0400
Received: from cvo-ext.roguewave.com ([12.22.36.198]:65071 "EHLO
	cvo-exchange.cvo.roguewave.com") by vger.kernel.org with ESMTP
	id <S266321AbRGTAEd>; Thu, 19 Jul 2001 20:04:33 -0400
Message-ID: <F888C30C3021D411B9DA00B0D0209BE801B4A839@cvo-exchange.roguewave.com>
From: Poul Petersen <petersp@roguewave.com>
To: linux-xfs@oss.sgi.com,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Oops (NULL pointer dereference) with 2.4.5+xfs-1.0.1
Date: Thu, 19 Jul 2001 17:04:25 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

	I'm running RedHat 7.1 with the manually patched 2.4.5 kernel and
xfs-1.0.1 on a dual PII (400) with 1 Gig of RAM. The XFS filesystems are
located on a SAN RAID device accessed through a qlogic 2100 Fibre Channel
card (using the qla2x00 module provided by Qlogic, ver 4.25). This system
acts as a "gateway" by mounting the disks from the SAN and then exporting
them to an array of hosts (Solaris, IRIX, Linux, AIX, etc) via NFS. The
system has been stable through heavy read/write testing that moved
approximately 5TB of data. Then we got an oops and the system locked up - we
don't have the kernel debugger loaded and syslog didn't catch it, so I don't
have a record of that oops. We hard rebooted the system and within 10
minutes while authenticating mount requests we got the same oops - 

rpc.mountd: authenticated mount request from 10.68.9.3:1022 for
/san/devbuild (/san/devbuild)
kernel: Unable to handle kernel NULL pointer dereference at virtual address
0000009c
kernel:  printing eip:
kernel: c01f1e98
kernel: *pde = 00000000
kernel: Oops: 0002
kernel: CPU:    0
kernel: EIP:    0010:[<c01f1e98>]
kernel: EFLAGS: 00010002
kernel: eax: 00000074   ebx: 00000074   ecx: 00000004   edx: ffffffe8
kernel: esi: ffffffe8   edi: c01c88a9   ebp: f3f9a54c   esp: f4ae5aac
kernel: ds: 0018   es: 0018   ss: 0018
kernel: Process nfsd (pid: 682, stackpage=f4ae5000)
kernel: Stack: 00000004 ffffffe8 c01c88a9 c01c8d94 00000074 00000288
ffffffe8 f3f9a560
kernel:        c033bf20 c01c8de3 ffffffe8 00000004 c01c88a9 c01c88a9
ffffffe8 00000004
kernel:        00000000 00000000 10130323 f7c5d800 f3d14e40 00000004
c01ddb16 f7c5d800
kernel: Call Trace: [<c01c88a9>] [<c01c8d94>] [<c01c8de3>] [<c01c88a9>]
[<c01c88a9>] [<c01ddb16>] [<c01ca7db>]
kernel:        [<c01de60c>] [<c018e811>] [<c01e317e>] [<c019c239>]
[<c01eb692>] [<c019371d>] [<c019371d>] [<c027dd6e>]
kernel:        [<c02896c3>] [<c02a1d1e>] [<c028a35b>] [<c02a21b1>]
[<c02a1cd0>] [<c01eb858>] [<c013e06d>] [<c016c740>]
kernel:        [<c016aa24>] [<c0171062>] [<c0168671>] [<c02b63c3>]
[<c0168489>] [<c0105546>] [<c0168290>]
kernel:
kernel: Code: f0 fe 4b 28 0f 88 1a f3 0c 00 8b 0b 85 c9 74 20 8d 7b 28 8d

	This time the system did not crash, but the nfsd (pid 682) died and
nfs was altogether broken. Since we couldn't get nfs to shut down, we
rebooted again. At this point we reviewed changes to the system since the
5TB testing period and the only thing changed was we enabled quotas on one
of the XFS partitions (Some of the testing was with quotas on, but not all).
So, we removed "usrquota,grpquota" from /etc/fstab for that partition and
the system has been fine since (31 hours now). I've dug through a vast
amount of mailing list archives for both XFS and knfsd, but all of the
similar problems were resolved with patches which seem to already be
included in 2.4.5 and xfs-1.0.1 (I checked the code). We have since brought
up another system with the same software configuration (hardware is a single
PII-333 with 196 MB RAM). On this machine we enabled quotas and started
hammering on it. It has been running for 24 hours and has moved almost 3/4
of a TB without any problems, so I'm not convinced that quotas was the
problem. I'm not even really certain that this is an XFS problem, except we
haven't seen this problem on other non-XFS files servers that we have and
this problem seemed at least similar to a previous XFS problem:
http://search.luky.org/linux-kernel.2001/msg12490.html

Any insight would be greatly appreciated.

Thanks,

-poul
