Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265230AbSK1Hri>; Thu, 28 Nov 2002 02:47:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265236AbSK1Hri>; Thu, 28 Nov 2002 02:47:38 -0500
Received: from bgp996345bgs.nanarb01.mi.comcast.net ([68.40.49.89]:3456 "EHLO
	syKr0n.mine.nu") by vger.kernel.org with ESMTP id <S265230AbSK1Hrg>;
	Thu, 28 Nov 2002 02:47:36 -0500
Subject: [OOPS] IDE-SCSI module corrupts further module loading on 2.5.50
From: Mohamed El Ayouty <melayout@umich.edu>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 27 Nov 2002 02:55:30 -0500
Message-Id: <1038383730.1526.0.camel@syKr0n.mine.nu>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Problem: 

When IDE-SCSI is compiled as a module, loading the module corrupts
further module loading in 2 situations: 

1. On a freshly booted kernel, if IDE-SCSI is loaded first, it loads
successfully, my cdroms appear under /dev/scsi and to unload
successfully I have to rmmod 0x21. Then any further attempts to load
other modules cause the console to fail with a "Segmentation fault" at
first, then just hangs and leaves a stale process that needs a restart
to get rid off. 

dmesg's output for this situation: 

ERROR: SCSI host `ide-scsi' has no error handling 
ERROR: This is not a safe way to run your SCSI host 
ERROR: The error handling must be added to this driver 
Call Trace: 
[<c02241ae>] scsi_register+0x7a/0x30c 
[<c022446f>] scsi_register_host+0x2f/0xc4 
[<c01240af>] sys_init_module+0xbf/0x18c 
[<c010893b>] syscall_call+0x7/0xb 

scsi0 : SCSI host adapter emulation for IDE ATAPI devices 
  Vendor: SAMSUNG   Model: DVD-ROM SD-612    Rev: 0.5 
  Type:   CD-ROM                             ANSI SCSI revision: 02 
  Vendor: LG        Model: CD-RW CED-8080B   Rev: 1.07 
  Type:   CD-ROM                             ANSI SCSI revision: 02 
scsi scan: host 0 channel 0 id 1 lun 0 identifier too long, length 60,
max 50. D                             
evice might be improperly identified. 
scsi : 0 hosts left. 
end_request: I/O error, dev hdd, sector 0 
end_request: I/O error, dev hdd, sector 0 
hdd: ATAPI 32X CD-ROM CD-R/RW drive, 2048kB Cache, DMA 
Uniform CD-ROM driver Revision: 3.12 
hdc: ATAPI 32X DVD-ROM drive, 512kB Cache, UDMA(33) 
end_request: I/O error, dev hdc, sector 0 
Unable to handle kernel paging request at virtual address e08ad4c0 
printing eip: 
c01a3ee5 
*pde = 0156c067 
*pte = 00000000 
Oops: 0002 
CPU:    0 
EIP:    0060:[<c01a3ee5>]    Not tainted 
EFLAGS: 00010246 
EIP is at kobject_add+0x75/0xbc 
eax: e08c9240   ebx: e08c922c   ecx: e08ad4c0   edx: c032ae7c 
esi: c032ae54   edi: 00000000   ebp: c032ae84   esp: d3d7bf38 
ds: 0068   es: 0068   ss: 0068 
Process modprobe (pid: 1554, threadinfo=d3d7a000 task=d3d79980) 
Stack: c032ae00 e08c922c e08c923c e08c920c c01a3f42 e08c922c e08c922c
c032ae00 
       e08cbeb4 c01ea092 e08c922c c0424448 e08c91c0 d3d7bfa0 e08c920c
c0424448 
       e08c922c c032ae34 c01ea43c e08c920c c021bd55 e08c920c d3d7a000
e08a6000 
Call Trace: 
[<c01a3f42>] kobject_register+0x16/0x34 
[<c01ea092>] bus_add_driver+0x66/0xb4 
[<c01ea43c>] driver_register+0x34/0x38 
[<c021bd55>] ide_register_driver+0xf9/0x104 
[<c01240af>] sys_init_module+0xbf/0x18c 
[<c010893b>] syscall_call+0x7/0xb 

Code: 89 01 56 e8 ff 00 00 00 89 43 1c 83 c4 04 89 e8 ba ff ff 00 



2. On a freshly booted kernel, any modules other than IDE-SCSI, like
IDE-CD load and unload successfully. Then, if I try to load the IDE-SCSI
module it fails to the with a "Segmentation fault" at first, then just
hangs and leaves a stale process that needs a restart to get rid off. 

dmesg's output for this situation: 

Unable to handle kernel paging request at virtual address e08c9240 
printing eip: 
c01a3ee5 
*pde = 0156c067 
*pte = 00000000 
Oops: 0002 
CPU:    0 
EIP:    0060:[<c01a3ee5>]    Not tainted 
EFLAGS: 00010246 
EIP is at kobject_add+0x75/0xbc 
eax: e08bb4c0   ebx: e08bb4ac   ecx: e08c9240   edx: c032ae7c 
esi: c032ae54   edi: 00000000   ebp: c032ae84   esp: d0fa3f38 
ds: 0068   es: 0068   ss: 0068 
Process modprobe (pid: 1609, threadinfo=d0fa2000 task=d0f31880) 
Stack: c032ae00 e08bb4ac e08bb4bc e08bb48c c01a3f42 e08bb4ac e08bb4ac
c032ae00 
       e08bba03 c01ea092 e08bb4ac c0424448 e08bb440 d0fa3fa0 e08bb48c
c0424448 
       e08bb4ac c032ae34 c01ea43c e08bb48c c021bd55 e08bb48c d0fa2000
e08a6000 
Call Trace: 
[<c01a3f42>] kobject_register+0x16/0x34 
[<c01ea092>] bus_add_driver+0x66/0xb4 
[<c01ea43c>] driver_register+0x34/0x38 
[<c021bd55>] ide_register_driver+0xf9/0x104 
[<c01240af>] sys_init_module+0xbf/0x18c 
[<c010893b>] syscall_call+0x7/0xb 

Code: 89 01 56 e8 ff 00 00 00 89 43 1c 83 c4 04 89 e8 ba ff ff 00 


I experienced this on 2.5.48,49,50, and I dont know if it occurs on
2.5.47 or earlier. 

I'm using rusty's mod utils 8. 

I'm on a Pentium 3 with gcc-2.95.3. 

I will gladly send anybody my .config, whole dmesg output and lspci -vvv
if needed and so as to avoid bloating everybody's mailboxes. 

Mohamed
