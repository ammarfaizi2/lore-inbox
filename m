Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129950AbQLSStN>; Tue, 19 Dec 2000 13:49:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130415AbQLSSsy>; Tue, 19 Dec 2000 13:48:54 -0500
Received: from zmamail01.zma.compaq.com ([161.114.64.101]:32780 "HELO
	zmamail01.zma.compaq.com") by vger.kernel.org with SMTP
	id <S129950AbQLSSst>; Tue, 19 Dec 2000 13:48:49 -0500
Message-ID: <3A3FA63A.801@zk3.dec.com>
Date: Tue, 19 Dec 2000 13:17:30 -0500
From: Peter Rival <frival@zk3.dec.com>
Organization: Tru64 QMG Performance Engineering
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.16-22smp i686; en-US; m18) Gecko/20001107 Netscape6/6.0
X-Accept-Language: en
MIME-Version: 1.0
To: cruff@ucar.edu
Cc: linux-kernel@vger.kernel.org, axp-list <axp-list@redhat.com>
Subject: Re: QLogicFC problems with 2.4.x?
In-Reply-To: <3A3E8096.3010606@zk3.dec.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is just to let everyone know that, thanks to Craig Ruff, I now have 
qlogicfc working under 2.4.11 on my ES40 and GS80.  The secret is to set 
CONNECTION_PREFERENCE to P2P_ONLY instead of LOOP_ONLY, and to build it 
in to the kernel instead of as a module.  My problem now is that the 
GS80 oopses when I try to mke2fs the second stripe set on the HSG80.  
This _only_ happens on the second mke2fs, not the first.  Screen dump is 
as follows:

#mke2fs /dev/sde2
....
Writing inode tables: done
Writing superblocks and filesystem accounting information: pci_map_sg 
failed: could not allocate dma page tables
pci_map_sg failed: could not allocate dma page tables
pci_map_sg failed: could not allocate dma page tables
pci_map_sg failed: could not allocate dma page tables
pci_map_sg failed: could not allocate dma page tables
pci_map_sg failed: could not allocate dma page tables
pci_map_sg failed: could not allocate dma page tables
pci_map_sg failed: could not allocate dma page tables
Unable to handle kernel paging request at virtual address 003ffc00001a0000
....
I've inlined the ksymoops output below.  I still haven't gotten the 
qla2x00 driver working... kinda strange...  I'll also be trying Matthew 
Jacob's driver as soon as I get the chance.  Thanks for all the 
suggestions everyone!

  - Pete

ksymoops 0.7c on alpha 2.4.0-test11.  Options used
    -V (default)
    -k /proc/ksyms (default)
    -l /proc/modules (default)
    -o /lib/modules/2.4.0-test11/ (default)
    -m /usr/tmp/System.map (specified)

No modules in ksyms, skipping objects
Warning (read_lsmod): no symbols in lsmod, is /proc/modules a valid 
lsmod file?
Unable to handle kernel paging request at virtual address 003ffc00001a0000
CPU 0 swapper(0): Oops 1
pc = [<fffffc000081ca40>]  ra = [<fffffc000081d4a4>]  ps = 0007
Using defaults from ksymoops -t elf64-alpha -a alpha
Warning (Oops_read): Code line not seen, dumping what data is available

 >>PC;  fffffc000081ca40 <iommu_arena_free+20/40>   <=====

gp = fffffc0000ab9460  sp = fffffc0000a1bd98
Code: fffffc0043f209a1 fffffc0042220642 fffffc00e4200008 
fffffc002fe00000 fffffc0047ff041f fffffc002fe00000 fffffc00b7e20000 
fffffc0040603403

Code;  fffffc000081ca40 <iommu_arena_free+20/40>

0000000000000000 <_PC>:
Code; fffffc000081ca40 <iommu_arena_free+20/40>
0: a1 09 f2 43 cmplt zero,a2,t0
Code; fffffc000081ca44 <iommu_arena_free+24/40>
4: 00 fc ff ff bgt zero,fffffffffffff008 <_PC+0xfffffffffffff008> 
fffffc000081ba48 <smp_call_function+108/140>
Code; fffffc000081ca48 <iommu_arena_free+28/40>
8: 42 06 22 42 s8addq a1,t1,t1
Code; fffffc000081ca4c <iommu_arena_free+2c/40>
c: 00 fc ff ff bgt zero,fffffffffffff010 <_PC+0xfffffffffffff010> 
fffffc000081ba50 <smp_call_function+110/140>
Code; fffffc000081ca50 <iommu_arena_free+30/40>
10: 08 00 20 e4 beq t0,34 <_PC+0x34> fffffc000081ca74 
<pci_map_single+14/1a0>
Code; fffffc000081ca54 <iommu_arena_free+34/40>
14: 00 fc ff ff bgt zero,fffffffffffff018 <_PC+0xfffffffffffff018> 
fffffc000081ba58 <smp_call_function+118/140>
Code; fffffc000081ca58 <iommu_arena_free+38/40>
18: 00 00 e0 2f unop
Code; fffffc000081ca5c <iommu_arena_free+3c/40>
1c: 00 fc ff ff bgt zero,fffffffffffff020 <_PC+0xfffffffffffff020> 
fffffc000081ba60 <smp_call_function+120/140>
Code; fffffc000081ca60 <pci_map_single+0/1a0>
20: 1f 04 ff 47 nop

Code;  fffffc000081ca64 <pci_map_single+4/1a0>
  24:   00 fc ff ff       bgt  zero,fffffffffffff028 
<_PC+0xfffffffffffff028> fffffc000081ba68 <smp_call_function+128/140>
Code;  fffffc000081ca68 <pci_map_single+8/1a0>
  28:   00 00 e0 2f       unop
Code;  fffffc000081ca6c <pci_map_single+c/1a0>
  2c:   00 fc ff ff       bgt  zero,fffffffffffff030 
<_PC+0xfffffffffffff030> fffffc000081ba70 <smp_call_function+130/140>
Code;  fffffc000081ca70 <pci_map_single+10/1a0>
  30:   00 00 e2 b7       stq  zero,0(t1)
Code;  fffffc000081ca74 <pci_map_single+14/1a0>
  34:   00 fc ff ff       bgt  zero,fffffffffffff038 
<_PC+0xfffffffffffff038> fffffc000081ba78 <smp_call_function+138/140>
Code;  fffffc000081ca78 <pci_map_single+18/1a0>
  38:   03 34 60 40       addq t2,0x1,t2
Code;  fffffc000081ca7c <pci_map_single+1c/1a0>
  3c:   00 fc ff ff       bgt  zero,fffffffffffff040 
<_PC+0xfffffffffffff040> fffffc000081ba80 <ipi_imb+0/20>

Aiee, killing interrupt handler
Kernel panic: Attempted to kill the idle task!

2 warnings issued.  Results may not be reliable.

Peter Rival wrote:

> Hi,
> 
>   I was just lent a QLogic ISP2200 FC adapter and have been having a  
> bear of a time trying to get it to work on my Alpha ES40 and GS80.  
> I've  tried both the qlogicfc (with standard kernel) and qla2x00 (from 
> QLogic  and Compaq) driver both built-in and as modules but neither of 
> them are  working.  Has anyone had success with later (I'm using 
> 2.4.0-test11) 2.4  kernels and the QLogic FC adapter?  I'm currently 
> plugged into a Brocade  switch (Plaides I, I believe) which is also 
> attached to two pair of  HSG80 FC RAID controllers.  AFAIK, the 2200 
> is supposed to work with an  FC fabric, so this should work, right?  
> Can anyone offer any  assistance?  Thanks!
> 
> - Pete
> 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
