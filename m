Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135737AbRBEUe3>; Mon, 5 Feb 2001 15:34:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135520AbRBEUeU>; Mon, 5 Feb 2001 15:34:20 -0500
Received: from oxmail4.ox.ac.uk ([163.1.2.33]:58852 "EHLO oxmail.ox.ac.uk")
	by vger.kernel.org with ESMTP id <S131640AbRBEUeJ>;
	Mon, 5 Feb 2001 15:34:09 -0500
Date: Mon, 5 Feb 2001 20:32:37 +0000
From: David Welch <david.welch@st-edmund-hall.oxford.ac.uk>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: Hang umounting filesystem on loop device
Message-ID: <20010205203237.A620@whitehall1-5.seh.ox.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] 

Hang when unmounting filesystem on loop device

[2.] 

Intermittently (once so far) umount hangs when umounting
a filesystem mounted on a loop device. Other processes run until they 
access the filesystem when they hang too. 

[3.] 

loop

[4.] 

Linux version 2.4.2-pre1 
(welch@whitehall1-5.seh.ox.ac.uk) (gcc version 2.96 20000731 (Red Hat 
Linux 7.0)) #1 Sun Feb 4 12:56:22 GMT 2001

[5.] 

I used Alt+SysRq+T to find out where the processes were stopping but
only the output for umount and ps fitted on the screen. The call traces
were :-

umount:
__lock_page
__find_lock_page
grab_cache_page
do_page_fault
lo_send
do_lo_request
__make_request
ext2_get_block
generic_make_request
__refile_buffer
submit_bh
ll_rw_block
__wait_on_buffer
flush_dirty_buffers
__block_commit_write
generic_commit_write
__make_request
__alloc_pages_limit
update_process_times
generic_make_request
bh_action
__refile_buffer
submit_bh
ll_rw_block
ret_from_intr
sync_buffers
get_pipe_inode
fsync_dev
do_umount
sys_umount
system_call

ps:
__lock_page
__find_lock_page
grab_cache_page
__make_request
generic_make_request
__refile_buffer
end_buffer_io_sync
ll_rw_block
flush_dirty_buffer
refill_freelist
getblk
bread
ext2_get_block
create_empty_buffers
block_read_full_page
__alloc_pages
read_cluster_nonblocking
ext2_get_block
do_no_page
filemap_nopage
__alloc_pages
do_no_page
__delete_from_swap_cache
do_page_fault
do_munmap
error_code
insert_vm_struct
do_brk
do_page_fault
bounds
sys_chown16
clear_user
padzero
load_elf_binary
do_ide_request
schedule
load_elf_binary
search_binary_handler
do_execve
getname
sys_execve
system_call

[6.]

#!/bin/sh
echo "Installing to disk."
mount -t vfat /bochs/10M.vga.dos /mnt/floppy -o loop,offset=8704,rw
./install.sh /mnt/floppy
umount /mnt/floppy
echo "Installing to minix disk."
mount -t minix /bochs/10M.vga.minix /mnt/floppy -o loop,offset=8704,rw
./install.sh /mnt/floppy
umount /mnt/floppy

[7.1.]

-- Versions installed: (if some fields are empty or look
-- unusual then possibly you have very old versions)
Linux whitehall1-5.seh.ox.ac.uk 2.4.2-pre1 #1 Sun Feb 4 12:56:22 GMT 2001 i486 unknown
Kernel modules         2.4.0
Gnu C                  2.96
Gnu Make               3.79.1
Binutils               2.10.0.18
Linux C Library        > libc.2.2
Dynamic linker         ldd (GNU libc) 2.2
Procps                 2.0.7
Mount                  2.10m
Net-tools              1.56
Console-tools          0.3.3
Sh-utils               2.0
Modules Loaded         minix loop serial isa-pnp binfmt_misc ne2k-pci 8390 ntfs nls_iso8859-1 nls_cp437 vfat fat

[7.2.]

processor	: 0
vendor_id	: CyrixInstead
cpu family	: 4
model		: 2
model name	: 6x86 1x Core/Bus Clock
stepping	: 6
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: yes
fpu		: yes
fpu_exception	: no
cpuid level	: -1
wp		: yes
flags		: cyrix_arr
bogomips	: 66.15

[7.3.]

minix                  23696   0 (unused)
loop                    7776   0 (unused)
serial                 43792   1
isa-pnp                29040   0 [serial]
binfmt_misc             3664   0
ne2k-pci                4544   1
8390                    6272   0 [ne2k-pci]
ntfs                   37744   1 (autoclean)
nls_iso8859-1           2880   2 (autoclean)
nls_cp437               4384   1 (autoclean)
vfat                   11088   1 (autoclean)
fat                    31712   0 (autoclean) [vfat]

[7.4.]

0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
02f8-02ff : serial(auto)
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
7c00-7cff : ATI Technologies Inc 3D Rage IIC 215IIC [Mach64 GT IIC]
7f80-7f9f : Realtek Semiconductor Co., Ltd. RTL-8029(AS)
  7f80-7f9f : ne2k-pci
ffa0-ffaf : Intel Corporation 82371SB PIIX3 IDE [Natoma/Triton II]

00000000-0009efff : System RAM
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-03ffffff : System RAM
  00100000-001be1e7 : Kernel code
  001be1e8-001fbcaf : Kernel data
fe000000-feffffff : ATI Technologies Inc 3D Rage IIC 215IIC [Mach64 GT IIC]
ffeff000-ffefffff : ATI Technologies Inc 3D Rage IIC 215IIC [Mach64 GT IIC]

[7.5.]

00:00.0 Host bridge: Intel Corporation 430HX - 82439HX TXC [Triton II] (rev 01)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 32

00:07.0 ISA bridge: Intel Corporation 82371SB PIIX3 ISA [Natoma/Triton II] (rev 01)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:07.1 IDE interface: Intel Corporation 82371SB PIIX3 IDE [Natoma/Triton II] (prog-if 80 [Master])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Region 4: I/O ports at ffa0 [size=16]

00:08.0 VGA compatible controller: ATI Technologies Inc 3D Rage IIC 215IIC [Mach64 GT IIC] (rev 3a) (prog-if 00 [VGA])
	Subsystem: ATI Technologies Inc: Unknown device 0088
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (2000ns min), cache line size 04
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at fe000000 (32-bit, prefetchable) [size=16M]
	Region 1: I/O ports at 7c00 [size=256]
	Region 2: Memory at ffeff000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at ffec0000 [disabled] [size=128K]
	Capabilities: [5c] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0a.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8029(AS)
	Subsystem: Realtek Semiconductor Co., Ltd. RT8029(AS)
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at 7f80 [size=32]

[7.6.]

No SCSI devices.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
