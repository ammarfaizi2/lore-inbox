Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263307AbUDBIO7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 03:14:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263340AbUDBIO7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 03:14:59 -0500
Received: from mxintern.kundenserver.de ([212.227.126.201]:3050 "EHLO
	mxintern.schlund.de") by vger.kernel.org with ESMTP id S263307AbUDBIOz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 03:14:55 -0500
Message-ID: <406D20FE.8040701@snakefarm.org>
Date: Fri, 02 Apr 2004 10:14:54 +0200
From: Carsten Gaebler <ezinye-zinto@snakefarm.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040124
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.4.25 XFS can't create files
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

I have somewhat of an esoteric problem. I can create an XFS on an 
external fibre channel RAID attached to an LSI fibre channel card 
(Fusion MPT driver) but I can't create files or directories on that 
filesystem (Permission denied). ext2/ext3 work fine on the same 
partition, so I suspect this is an XFS+MPT issue.

Here's what I tried:

sq22:~# mkfs.xfs /dev/sdb2
meta-data=/dev/sdb2     isize=256    agcount=140, agsize=1048576 blks
data     =              bsize=4096   blocks=146320896, imaxpct=25
          =              sunit=0      swidth=0 blks, unwritten=0
naming   =version 2     bsize=4096
log      =internal log  bsize=4096   blocks=17861
realtime =none          extsz=65536  blocks=0, rtextents=0
sq22:~# mkdir /mnt/xfs
sq22:~# ls -ld / /mnt/ /mnt/xfs/
drwxr-xr-x   19 root     root         4096 Sep 16  2003 /
drwxr-xr-x    4 root     root         4096 Apr  2 09:26 /mnt/
drwxr-xr-x    2 root     root         4096 Apr  2 09:26 /mnt/xfs/
sq22:~# mount -t xfs /dev/sdb2 /mnt/xfs/
sq22:~# mount | grep xfs
/dev/sdb2 on /mnt/xfs type xfs (rw)
sq22:~# ls -ld /mnt/xfs/
drwxr-xr-x    2 root     root            6 Apr  2 09:25 /mnt/xfs/
sq22:~# touch /mnt/xfs/foo
touch: creating `/mnt/xfs/foo': Permission denied
sq22:~#


Here's some system information:


sq22:~# uname -a
Linux sq22 2.4.25 #3 SMP Fri Mar 19 14:39:04 CET 2004 i686 unknown
sq22:~# lsmod
Module                  Size  Used by    Not tainted
sg                     25092   0
mptscsih               33300   2
ipt_REJECT              3232  13  (autoclean)
iptable_filter          1792   1  (autoclean)
ip_tables              12288   2  [ipt_REJECT iptable_filter]
mptbase                33440   3  [mptscsih]
e1000                  64224   1
sq22:~#


 From lspci:


03:08.0 Fibre Channel: LSI Logic / Symbios Logic (formerly NCR): Unknown 
device 0628
         Subsystem: LSI Logic / Symbios Logic (formerly NCR): Unknown 
device 5030
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
         Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 72 (16000ns min, 2500ns max), cache line size 10
         Interrupt: pin A routed to IRQ 24
         Region 0: I/O ports at 2000 [size=256]
         Region 1: Memory at fe6f0000 (64-bit, non-prefetchable) [size=64K]
         Region 3: Memory at fe6e0000 (64-bit, non-prefetchable) [size=64K]
         Expansion ROM at fe500000 [disabled] [size=1M]
         Capabilities: [50] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
         Capabilities: [58] Message Signalled Interrupts: 64bit+ 
Queue=0/0 Enable-
                 Address: 0000000000000000  Data: 0000
         Capabilities: [68] #07 [0000]


 From dmesg:


Fusion MPT base driver 2.05.11.03
Copyright (c) 1999-2003 LSI Logic Corporation
mptbase: Initiating ioc0 bringup
ioc0: FC919X: Capabilities={Initiator,Target,LAN}
mptbase: 1 MPT adapter found, 1 installed.
Fusion MPT SCSI Host driver 2.05.11.03
scsi1 : ioc0: LSIFC919X, FwRev=01000000h, Ports=1, MaxQ=1023, IRQ=24
blk: queue f7e21018, I/O limit 4294967295Mb (mask 0xffffffffffffffff)
   Vendor: IFT       Model: ES A08F-G         Rev: 331J
   Type:   Direct-Access                      ANSI SCSI revision: 03
blk: queue f7b99e18, I/O limit 4294967295Mb (mask 0xffffffffffffffff)
Attached scsi disk sdb at scsi1, channel 0, id 0, lun 0
SCSI device sdb: 2341134336 512-byte hdwr sectors (1198661 MB)
  sdb: sdb1 sdb2
XFS mounting filesystem sd(8,18)
Ending clean XFS mount for filesystem: sd(8,18)


Any clues?

cg.

