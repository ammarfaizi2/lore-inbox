Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129026AbRBHAyh>; Wed, 7 Feb 2001 19:54:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129027AbRBHAyS>; Wed, 7 Feb 2001 19:54:18 -0500
Received: from snowbird.megapath.net ([216.200.176.7]:35080 "EHLO
	megapathdsl.net") by vger.kernel.org with ESMTP id <S129026AbRBHAyL>;
	Wed, 7 Feb 2001 19:54:11 -0500
Message-ID: <3A81ED46.956D041E@trustcommerce.com>
Date: Wed, 07 Feb 2001 16:50:14 -0800
From: Orion Henry <orion@trustcommerce.com>
Organization: TrustCommerce
X-Mailer: Mozilla 4.73 [en] (X11; U; Linux 2.2.16-9mdk i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Problem: OOPS in getblk in 2.2.16-3smp - may be software RAID related
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I sent this oops to the file system and a raid maintainer asking for
more 
info and received no response.  Please let mw know if there is a better
place to send it.

I received a kernel oops in the file system layer on my dual PIII w/
software Raid5
running RedHat 6.2 with the redhat kernel 2.2.16-3smp. I took down all
the system
info that I thought would be relevant, if I missed anything let me know.
The oops occurred suddenly after doing what it had been doing for 6
solid months
and has not given me any grief since.

If there are known errors that could have caused this in the kernel I am
running
please let me know.

Please CC me on any responses.

	Much thanks
	Orion Henry

Jan  8 19:18:30 aule kernel: Unable to handle kernel paging request at
virtual address 00020078
Jan  8 19:18:30 aule kernel: current->tss.cr3 = 0e52f000, %%cr3 =
0e52f000
Jan  8 19:18:30 aule kernel: *pde = 00000000
Jan  8 19:18:30 aule kernel: Oops: 0002
Jan  8 19:18:30 aule kernel: CPU:    0
Jan  8 19:18:30 aule kernel: EIP:    0010:[getblk+205/324]
Jan  8 19:18:30 aule kernel: EFLAGS: 00010207
Jan  8 19:18:30 aule kernel: eax: c11e00e0   ebx: c11e06e0   ecx:
0000000c   edx: 00020040
Jan  8 19:18:30 aule kernel: esi: 00001000   edi: 0000000c   ebp:
00000900   esp: ce613d9c
Jan  8 19:18:30 aule kernel: ds: 0018   es: 0018   ss: 0018
Jan  8 19:18:30 aule kernel: Process spawn (pid: 28305, process nr: 45,
stackpage=ce613000)
Jan  8 19:18:30 aule kernel: Stack: 00000900 000003a9 0000000c c0141ee7
00000900 004503a9 00001000 00450000
Jan  8 19:18:30 aule kernel:        ce613f08 dce91100 dce91100 00000e75
00001000 00000008 000003b0 00000e75
Jan  8 19:18:30 aule kernel:        00000900 de14c480 ce613e24 00008000
de14c480 ce612000 00000008 00000e75
Jan  8 19:18:30 aule kernel: Call Trace: [ext2_new_block+2291/2756]
[ext2_alloc_block+344/356] [inode_getblk+205/392] [ext2_getblk+194/524]
[ext2_file_write+1308/1584] [refile_buffer+86/184]
[locks_delete_lock+52/128]

The Offending Code is Here
--------------------------------------------------
>From /usr/src/linux-2.2.16/fs/buffer.c:
--------------------------------------------------

/*
 * Ok, this is getblk, and it isn't very clear, again to hinder
 * race-conditions. Most of the code is seldom used, (ie repeating),
 * so it should be much more efficient than it looks.
 *
 * The algorithm is changed: hopefully better, and an elusive bug
removed.
 *
 * 14.02.92: changed it to sync dirty buffers a bit: better performance
 * when the filesystem starts to get full of dirty blocks (I hope).
 */
struct buffer_head * getblk(kdev_t dev, int block, int size)
{
        struct buffer_head * bh;
        int isize;

repeat:
        bh = get_hash_table(dev, block, size);
        if (bh) {
                if (!buffer_dirty(bh)) {
                        bh->b_flushtime = 0;
                }
                return bh;
        }

        isize = BUFSIZE_INDEX(size);
get_free:
        bh = free_list[isize];
        if (!bh)
                goto refill;
        remove_from_free_list(bh);

        /* OK, FINALLY we know that this buffer is the only one of its
kind,
         * and that it's unused (b_count=0), unlocked, and clean.
         */
        init_buffer(bh, dev, block, end_buffer_io_sync, NULL);
        bh->b_state=0;
        insert_into_queues(bh);
        return bh;

        /*
         * If we block while refilling the free list, somebody may
         * create the buffer first ... search the hashes again.
         */
refill:
        refill_freelist(size);
        if (!find_buffer(dev,block,size))
                goto get_free;
        goto repeat;
}

--------------------------------------------------

And it looks like this in the debugger:

$ gdb /boot/vmlinux-2.2.16-3
GNU gdb 5.0
Copyright 2000 Free Software Foundation, Inc.
GDB is free software, covered by the GNU General Public License, and you
are
welcome to change it and/or distribute copies of it under certain
conditions.
Type "show copying" to see the conditions.
There is absolutely no warranty for GDB.  Type "show warranty" for
details.
This GDB was configured as "i386-redhat-linux"...
(no debugging symbols found)...
(gdb) disas getblk
Dump of assembler code for function getblk:
0xc012765c <getblk>:    sub    $0x4,%esp
0xc012765f <getblk+3>:  push   %ebp
0xc0127660 <getblk+4>:  push   %edi
0xc0127661 <getblk+5>:  push   %esi
0xc0127662 <getblk+6>:  push   %ebx
0xc0127663 <getblk+7>:  xor    %ebp,%ebp
0xc0127665 <getblk+9>:  mov    0x20(%esp,1),%esi
0xc0127669 <getblk+13>: mov    0x18(%esp,1),%bp
0xc012766e <getblk+18>: push   %esi
0xc012766f <getblk+19>: mov    0x20(%esp,1),%edi
0xc0127673 <getblk+23>: push   %edi
0xc0127674 <getblk+24>: push   %ebp
0xc0127675 <getblk+25>: call   0xc01272f4 <get_hash_table>
0xc012767a <getblk+30>: mov    %eax,%ebx
0xc012767c <getblk+32>: add    $0xc,%esp
0xc012767f <getblk+35>: test   %ebx,%ebx
0xc0127681 <getblk+37>: je     0xc0127698 <getblk+60>
0xc0127683 <getblk+39>: mov    0x18(%ebx),%eax
0xc0127686 <getblk+42>: test   $0x2,%al
0xc0127688 <getblk+44>: jne    0xc0127691 <getblk+53>
0xc012768a <getblk+46>: movl   $0x0,0x2c(%ebx)
0xc0127691 <getblk+53>: mov    %ebx,%eax
0xc0127693 <getblk+55>: jmp    0xc0127798 <getblk+316>
0xc0127698 <getblk+60>: mov    %esi,%eax
0xc012769a <getblk+62>: sar    $0x9,%eax
0xc012769d <getblk+65>: movsbl 0xc021b500(%eax),%eax
0xc01276a4 <getblk+72>: shl    $0x2,%eax
0xc01276a7 <getblk+75>: mov    %eax,0x10(%esp,1)
0xc01276ab <getblk+79>: mov    0x10(%esp,1),%edi
0xc01276af <getblk+83>: mov    0xc021b55c(%edi),%ebx
0xc01276b5 <getblk+89>: test   %ebx,%ebx
0xc01276b7 <getblk+91>: je     0xc0127774 <getblk+280>
0xc01276bd <getblk+97>: mov    0x8(%ebx),%eax
0xc01276c0 <getblk+100>:        shr    $0x9,%eax
0xc01276c3 <getblk+103>:        mov    0x38(%ebx),%edx
0xc01276c6 <getblk+106>:        movsbl 0xc021b500(%eax),%ecx
0xc01276cd <getblk+113>:        test   %edx,%edx
0xc01276cf <getblk+115>:        je     0xc01276d8 <getblk+124>
0xc01276d1 <getblk+117>:        mov    0x1c(%ebx),%eax
0xc01276d4 <getblk+120>:        test   %eax,%eax
0xc01276d6 <getblk+122>:        jne    0xc01276e4 <getblk+136>
0xc01276d8 <getblk+124>:        push   $0xc01d9d20
0xc01276dd <getblk+129>:        call   0xc0113c28 <panic>
0xc01276e2 <getblk+134>:        mov    %esi,%esi
0xc01276e4 <getblk+136>:        cmpw   $0xffff,0xc(%ebx)
0xc01276ea <getblk+142>:        je     0xc01276f8 <getblk+156>
0xc01276ec <getblk+144>:        push   $0xc01d9d3f
0xc01276f1 <getblk+149>:        call   0xc0113c28 <panic>
0xc01276f6 <getblk+154>:        mov    %esi,%esi
0xc01276f8 <getblk+156>:        shl    $0x2,%ecx
0xc01276fb <getblk+159>:        cmpl   $0x0,0xc021b55c(%ecx)
0xc0127702 <getblk+166>:        jne    0xc0127710 <getblk+180>
0xc0127704 <getblk+168>:        push   $0xc01d9d53
0xc0127709 <getblk+173>:        call   0xc0113c28 <panic>
0xc012770e <getblk+178>:        mov    %esi,%esi
0xc0127710 <getblk+180>:        cmp    %ebx,%eax
0xc0127712 <getblk+182>:        jne    0xc0127720 <getblk+196>
0xc0127714 <getblk+184>:        movl   $0x0,0xc021b55c(%ecx)
0xc012771e <getblk+194>:        jmp    0xc012773d <getblk+225>
0xc0127720 <getblk+196>:        mov    %eax,0x1c(%edx)
0xc0127723 <getblk+199>:        mov    0x1c(%ebx),%edx
0xc0127726 <getblk+202>:        mov    0x38(%ebx),%eax
0xc0127729 <getblk+205>:        mov    %eax,0x38(%edx)          <---
FAULT
0xc012772c <getblk+208>:        cmp    %ebx,0xc021b55c(%ecx)
0xc0127732 <getblk+214>:        jne    0xc012773d <getblk+225>
0xc0127734 <getblk+216>:        mov    0x1c(%ebx),%eax
0xc0127737 <getblk+219>:        mov    %eax,0xc021b55c(%ecx)
0xc012773d <getblk+225>:        movl   $0x0,0x38(%ebx)
0xc0127744 <getblk+232>:        movl   $0x0,0x1c(%ebx)
0xc012774b <getblk+239>:        push   $0x0
0xc012774d <getblk+241>:        push   $0xc0127630
0xc0127752 <getblk+246>:        mov    0x24(%esp,1),%edi
0xc0127756 <getblk+250>:        push   %edi
0xc0127757 <getblk+251>:        push   %ebp
0xc0127758 <getblk+252>:        push   %ebx
0xc0127759 <getblk+253>:        call   0xc01275f4 <init_buffer>
0xc012775e <getblk+258>:        movl   $0x0,0x18(%ebx)
0xc0127765 <getblk+265>:        push   %ebx
0xc0127766 <getblk+266>:        call   0xc0127154 <insert_into_queues>
0xc012776b <getblk+271>:        mov    %ebx,%eax
0xc012776d <getblk+273>:        add    $0x18,%esp
0xc0127770 <getblk+276>:        jmp    0xc0127798 <getblk+316>
0xc0127772 <getblk+278>:        mov    %esi,%esi
0xc0127774 <getblk+280>:        push   %esi
0xc0127775 <getblk+281>:        call   0xc01275bc <refill_freelist>
0xc012777a <getblk+286>:        push   %esi
0xc012777b <getblk+287>:        mov    0x24(%esp,1),%edi
0xc012777f <getblk+291>:        push   %edi
0xc0127780 <getblk+292>:        push   %ebp
0xc0127781 <getblk+293>:        call   0xc0127264 <find_buffer>
0xc0127786 <getblk+298>:        add    $0x10,%esp
0xc0127789 <getblk+301>:        test   %eax,%eax
0xc012778b <getblk+303>:        je     0xc01276ab <getblk+79>
0xc0127791 <getblk+309>:        jmp    0xc012766e <getblk+18>
0xc0127796 <getblk+314>:        mov    %esi,%esi
0xc0127798 <getblk+316>:        pop    %ebx
0xc0127799 <getblk+317>:        pop    %esi
0xc012779a <getblk+318>:        pop    %edi
0xc012779b <getblk+319>:        pop    %ebp
0xc012779c <getblk+320>:        pop    %ecx
0xc012779d <getblk+321>:        ret    
0xc012779e <getblk+322>:        mov    %esi,%esi
End of assembler dump.
(gdb) quit

--------------------------------------------------

# uname -a
Linux aule 2.2.16-3smp #1 SMP Mon Jun 19 19:00:35 EDT 2000 i686 unknown

# cat /proc/version
Linux version 2.2.16-3smp (root@porky.devel.redhat.com) (gcc version
egcs-2.91.66 19990314/Linux (egcs-1.1.2 release)) #1 SMP Mon Jun 19
19:00:35 EDT 2000

# lsmod
Module                  Size  Used by
3c59x                  20016   1  (autoclean)
raid5                  19372   1 
aic7xxx               137464   4 

# df
Filesystem           1k-blocks      Used Available Use% Mounted on
/dev/hda1              2071384   1107980    858180  56% /
/dev/hda6             13251000     11832  12566048   0% /home
/dev/hda7              2071384        20   1966140   0% /tmp
/dev/md0              26470460    348136  24777700   1% /var
/dev/hda5              2071384         8   1966152   0% /mnt/backup

# cat /etc/fstab
/dev/hda1               /                       ext2    defaults       
1 1
/dev/hda6               /home                   ext2    defaults       
1 2
/dev/hda7               /tmp                    ext2    defaults       
1 2
/dev/md0                /var                    ext2    defaults       
1 2
/dev/hda5               /mnt/backup             ext2    defaults       
1 2
/dev/fd0                /mnt/floppy             auto    noauto,owner   
0 0
/dev/cdrom              /mnt/cdrom              iso9660 noauto,owner,ro
0 0
none                    /proc                   proc    defaults       
0 0
none                    /dev/pts                devpts  gid=5,mode=620 
0 0
/dev/hda8               swap                    swap    defaults       
0 0


# cat /dev/raidtab
# /etc/raidtab
# $Id: raidtab,v 1.1 2000/04/16 23:27:07 root Exp root $

# RAID-5 configuration
raiddev                 /dev/md0
raid-level              5
nr-raid-disks   4
chunk-size              16

# Parity placement algorithm

#parity-algorithm       left-asymmetric

#
# the best one for maximum performance:
#
parity-algorithm        left-symmetric

#parity-algorithm       right-asymmetric
#parity-algorithm       right-symmetric

# Spare disks for hot reconstruction
nr-spare-disks          0

device                  /dev/sda1
raid-disk               0

device                  /dev/sdb1
raid-disk               1

device                  /dev/sdc1
raid-disk               2

device                  /dev/sdd1
raid-disk               3


# cat cpuinfo 
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 1
cpu MHz         : 546.881
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
sep_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 3
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 pn mmx fxsr xmm
bogomips        : 1091.17

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 1
cpu MHz         : 546.881
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
sep_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 3
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 pn mmx fxsr xmm
bogomips        : 1091.17

# cat pci 
PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: Intel Unknown device (rev 1).
      Vendor id=8086. Device id=1a21.
      Fast devsel.  Fast back-to-back capable.  Master Capable.  No
bursts.  
      Prefetchable 32 bit memory at 0xf0000000 [0xf0000008].
  Bus  0, device   1, function  0:
    PCI bridge: Intel Unknown device (rev 1).
      Vendor id=8086. Device id=1a23.
      Fast devsel.  Fast back-to-back capable.  Master Capable. 
Latency=64.  Min Gnt=11.
  Bus  0, device   2, function  0:
    PCI bridge: Intel Unknown device (rev 1).
      Vendor id=8086. Device id=1a24.
      Fast devsel.  Fast back-to-back capable.  Master Capable. 
Latency=64.  Min Gnt=3.
  Bus  0, device  30, function  0:
    PCI bridge: Intel Unknown device (rev 2).
      Vendor id=8086. Device id=2418.
      Fast devsel.  Fast back-to-back capable.  Master Capable.  No
bursts.  Min Gnt=3.
  Bus  0, device  31, function  0:
    ISA bridge: Intel Unknown device (rev 2).
      Vendor id=8086. Device id=2410.
      Medium devsel.  Fast back-to-back capable.  Master Capable.  No
bursts.  
  Bus  0, device  31, function  1:
    IDE interface: Intel Unknown device (rev 2).
      Vendor id=8086. Device id=2411.
      Medium devsel.  Fast back-to-back capable.  Master Capable.  No
bursts.  
      I/O at 0xffa0 [0xffa1].
  Bus  0, device  31, function  3:
    SM Bus: Intel Unknown device (rev 2).
      Vendor id=8086. Device id=2413.
      Medium devsel.  Fast back-to-back capable.  IRQ 17.  
      I/O at 0xefa0 [0xefa1].
  Bus  0, device  31, function  5:
    Multimedia audio controller: Intel Unknown device (rev 2).
      Vendor id=8086. Device id=2415.
      Medium devsel.  Fast back-to-back capable.  IRQ 17.  Master
Capable.  No bursts.  
      I/O at 0xe800 [0xe801].
      I/O at 0xef00 [0xef01].
  Bus  4, device   0, function  0:
    VGA compatible controller: S3 Inc. Unknown device (rev 2).
      Vendor id=5333. Device id=8a13.
      Medium devsel.  Master Capable.  Latency=64.  Min Gnt=4.Max
Lat=255.
      Non-prefetchable 32 bit memory at 0xf8000000 [0xf8000000].
  Bus  2, device  31, function  0:
    PCI bridge: Intel Unknown device (rev 2).
      Vendor id=8086. Device id=1360.
      Fast devsel.  Master Capable.  No bursts.  Min Gnt=3.Max Lat=128.
  Bus  3, device   0, function  0:
    PIC: Intel Unknown device (rev 1).
      Vendor id=8086. Device id=1161.
      Fast devsel.  Master Capable.  No bursts.  
      Non-prefetchable 32 bit memory at 0xf68fe000 [0xf68fe000].
  Bus  3, device   4, function  0:
    SCSI storage controller: Adaptec AIC-7892 (rev 2).
      Medium devsel.  Fast back-to-back capable.  BIST capable.  IRQ
32.  Master Capable.  Latency=64.  Min Gnt=40.Max Lat=25.
      I/O at 0xb800 [0xb801].
      Non-prefetchable 64 bit memory at 0xf68ff000 [0xf68ff004].
  Bus  1, device   1, function  0:
    Ethernet controller: 3Com 3C905B 100bTX (rev 48).
      Medium devsel.  IRQ 17.  Master Capable.  Latency=64.  Min
Gnt=10.Max Lat=10.
      I/O at 0xac00 [0xac01].
      Non-prefetchable 32 bit memory at 0xf67fef80 [0xf67fef80].
  Bus  1, device   8, function  0:
    Ethernet controller: Intel 82557 (rev 8).
      Medium devsel.  Fast back-to-back capable.  IRQ 16.  Master
Capable.  Latency=64.  Min Gnt=8.Max Lat=56.
      Non-prefetchable 32 bit memory at 0xf67ff000 [0xf67ff000].
      I/O at 0xaf00 [0xaf01].
      Non-prefetchable 32 bit memory at 0xf6600000 [0xf6600000].


# cat /proc/scsi/scsi 
Attached devices: 
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: SEAGATE  Model: ST39236LW        Rev: 0004
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi0 Channel: 00 Id: 01 Lun: 00
  Vendor: SEAGATE  Model: ST39236LW        Rev: 0004
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi0 Channel: 00 Id: 02 Lun: 00
  Vendor: SEAGATE  Model: ST39236LW        Rev: 0004
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi0 Channel: 00 Id: 03 Lun: 00
  Vendor: SEAGATE  Model: ST39236LW        Rev: 0004
  Type:   Direct-Access                    ANSI SCSI revision: 03
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
