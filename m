Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933340AbWKNJXe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933340AbWKNJXe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 04:23:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933342AbWKNJXe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 04:23:34 -0500
Received: from relay.uni-heidelberg.de ([129.206.100.212]:28364 "EHLO
	relay.uni-heidelberg.de") by vger.kernel.org with ESMTP
	id S933340AbWKNJXd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 04:23:33 -0500
Message-ID: <45598B07.6080401@uni-hd.de>
Date: Tue, 14 Nov 2006 10:23:19 +0100
From: Martin Braun <mbraun@uni-hd.de>
Reply-To: mbraun@uni-hd.de
User-Agent: Thunderbird 1.5.0.8 (X11/20061025)
MIME-Version: 1.0
To: David Chinner <dgc@sgi.com>
CC: linux-kernel@vger.kernel.org, xfs@oss.sgi.com
Subject: Re: xfs kernel BUG again in 2.6.17.11
References: <44E1D9CA.30805@uni-hd.de> <20060816101122.E2740551@wobbly.melbourne.sgi.com> <44EB228F.6020903@uni-hd.de> <20060823134211.E2968256@wobbly.melbourne.sgi.com> <45583ABE.6080909@uni-hd.de> <20061114040053.GD8394166@melbourne.sgi.com>
In-Reply-To: <20061114040053.GD8394166@melbourne.sgi.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,


> Have you managed to repair the filesystem since you first
> reported this problem? I don't know the history of the bug
that's something I am not sure about, I have used the newest xfs_repair
tools and it found and repaired some inodes. And for about two months
there weren't any crashes.

> you are seeing othat than what you included, so can you
> give us a more complete picture of your hardware and
> what sort of workload you are doing that triggers this
> problem?
The main workload of this machine is high samba activity with few
clients but many IO tasks (i.e. Photoshop batch  processing on many 3-6
MB Images). The XFS Partition is on an easy-RAID 16 P. Other Partitions
are EXT3. There are also 2 iSCSI-Partitions with XFS.  For Hardware
Information, see below.
After the crash I did an xfs_repair and it found corrupt directory inode
and moved it to lost+found as " 254474253".

Normally  the Kernel freezes/hangs completely, but I found two new
Kernel BUG (see below) in the log-messages (without a freeze), the
corresponding java-program was building an lucene-index from a
mysql-database.

It seems that xfs_repair (2.8.10), did not find all of the errors of the FS.
Is there a way to be sure that the FS is clean?

>
> FWIW, are there any I/o errors being reported in dmesg or syslog?
There weren't any  I/o errors.

Nov 13 14:16:28 pers109 kernel: ------------[ cut here ]------------
Nov 13 14:16:28 pers109 kernel: kernel BUG at :29837!
Nov 13 14:16:28 pers109 kernel: invalid opcode: 0000 [#1]
Nov 13 14:16:28 pers109 kernel: SMP
Nov 13 14:16:28 pers109 kernel: CPU:    2
Nov 13 14:16:28 pers109 kernel: EIP:    0060:[<c0171eea>]    Not tainted VLI
Nov 13 14:16:28 pers109 kernel: EFLAGS: 00210202   (2.6.17.11 #1)
Nov 13 14:16:28 pers109 kernel: EIP is at generic_delete_inode+0xf1/0xf9
Nov 13 14:16:28 pers109 kernel: eax: c2001e80   ebx: ecadeca0   ecx:
00000003   edx: ecadedd8
Nov 13 14:16:28 pers109 kernel: esi: 00000000   edi: ecadeca0   ebp:
d8699f4c   esp: d8699f18
Nov 13 14:16:28 pers109 kernel: ds: 007b   es: 007b   ss: 0068
Nov 13 14:16:28 pers109 kernel: Process java (pid: 15883,
threadinfo=d8698000 task=d6c78a10)
Nov 13 14:16:28 pers109 kernel: Stack: ecadeca0 00000000 00000000
ecadeca0 d7ce4000 c01720cd ecadeca0 c04738dc
Nov 13 14:16:28 pers109 kernel:        00000000 c01683fc ecadeca0
f1862094 f1862094 c92b5114 c214c0c0 4859aa9a
Nov 13 14:16:28 pers109 kernel:        00000008 d7ce4029 00000010
00000000 00000000 00000000 00000000 c214c0c0
Nov 13 14:16:28 pers109 kernel: Call Trace:
Nov 13 14:16:28 pers109 kernel:  <c01720cd> iput+0x5f/0x74  <c01683fc>
do_unlinkat+0xc9/0x107
Nov 13 14:16:28 pers109 kernel:  <c015739a> filp_close+0x44/0x6c
<c0168481> sys_unlink+0x17/0x1b
Nov 13 14:16:28 pers109 kernel:  <c01027ef> sysenter_past_esp+0x54/0x75
Nov 13 14:16:28 pers109 kernel: Code: f0 ff ff 8d 83 a8 00 00 00 c7 44
24 04 00 00 00 00 c7 44 24 08 00 00 00 00 89 04 24 e8 b1 fb fc ff 8
9 1c 24 e8 aa f1 ff ff eb 89 <0f> 0b 8d 74 26 00 eb c2 56 53 83 ec 0c 8b
5c 24 18 8b 53 04 8b
Nov 13 14:16:28 pers109 kernel: EIP: [<c0171eea>]
generic_delete_inode+0xf1/0xf9 SS:ESP 0068:d8699f18


Nov 13 20:22:28 pers109 kernel: ------------[ cut here ]------------
Nov 13 20:22:28 pers109 kernel: kernel BUG at :29837!
Nov 13 20:22:28 pers109 kernel: invalid opcode: 0000 [#2]
Nov 13 20:22:28 pers109 kernel: SMP
Nov 13 20:22:28 pers109 kernel: CPU:    3
Nov 13 20:22:28 pers109 kernel: EIP:    0060:[<c0171eea>]    Not tainted VLI
Nov 13 20:22:28 pers109 kernel: EFLAGS: 00010202   (2.6.17.11 #1)
Nov 13 20:22:28 pers109 kernel: EIP is at generic_delete_inode+0xf1/0xf9
Nov 13 20:22:28 pers109 kernel: eax: c2001f10   ebx: d6c586a0   ecx:
00000003   edx: d6c587d8
Nov 13 20:22:28 pers109 kernel: esi: 00000000   edi: d6c586a0   ebp:
d2cd9f4c   esp: d2cd9f18
Nov 13 20:22:28 pers109 kernel: ds: 007b   es: 007b   ss: 0068
Nov 13 20:22:28 pers109 kernel: Process java (pid: 19824,
threadinfo=d2cd8000 task=d1f575a0)
Nov 13 20:22:28 pers109 kernel: Stack: d6c586a0 00000000 00000000
d6c586a0 d5144000 c01720cd d6c586a0 c04738dc
Nov 13 20:22:28 pers109 kernel:        00000000 c01683fc d6c586a0
dd28e794 dd28e794 f69dd894 c214c0c0 281c233e
Nov 13 20:22:28 pers109 kernel:        00000009 d5144029 00000010
00000000 00000000 00000000 00000000 c214c0c0
Nov 13 20:22:28 pers109 kernel: Call Trace:
Nov 13 20:22:28 pers109 kernel:  <c01720cd> iput+0x5f/0x74  <c01683fc>
do_unlinkat+0xc9/0x107
Nov 13 20:22:28 pers109 kernel:  <c015739a> filp_close+0x44/0x6c
<c0168481> sys_unlink+0x17/0x1b
Nov 13 20:22:28 pers109 kernel:  <c01027ef> sysenter_past_esp+0x54/0x75
Nov 13 20:22:28 pers109 kernel: Code: f0 ff ff 8d 83 a8 00 00 00 c7 44
24 04 00 00 00 00 c7 44 24 08 00 00 00 00 89 04 24 e8 b1 fb fc ff 8
9 1c 24 e8 aa f1 ff ff eb 89 <0f> 0b 8d 74 26 00 eb c2 56 53 83 ec 0c 8b
5c 24 18 8b 53 04 8b
________
Hardware Info:
________
(Output of cpu0 from 4 (virtual, 2 physical cpus)
cat /proc/cpuinfo

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Xeon(TM) CPU 2.80GHz
stepping        : 7
cpu MHz         : 1595.120
cache size      : 512 KB
physical id     : 0
siblings        : 2
core id         : 0
cpu cores       : 1
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid
bogomips        : 3193.91

__________

uname -a
Linux pers109 2.6.17.11 #1 SMP Mon Aug 28 10:45:48 CEST 2006 i686 i686
i386 GNU/Linux

----------------------
cat /etc/SuSE-release
SuSE Linux 9.3 (i586)
VERSION = 9.3
---------------------
lspci

0000:00:00.0 Host bridge: Intel Corporation E7501 Memory Controller Hub
(rev 01)
0000:00:02.0 PCI bridge: Intel Corporation E7500/E7501 Hub Interface B
PCI-to-PCI Bridge (rev 01)
0000:00:1d.0 USB Controller: Intel Corporation 82801CA/CAM USB (Hub #1)
(rev 02)
0000:00:1d.1 USB Controller: Intel Corporation 82801CA/CAM USB (Hub #2)
(rev 02)
0000:00:1d.2 USB Controller: Intel Corporation 82801CA/CAM USB (Hub #3)
(rev 02)
0000:00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev 42)
0000:00:1f.0 ISA bridge: Intel Corporation 82801CA LPC Interface
Controller (rev 02)
0000:00:1f.1 IDE interface: Intel Corporation 82801CA Ultra ATA Storage
Controller (rev 02)
0000:01:1c.0 PIC: Intel Corporation 82870P2 P64H2 I/OxAPIC (rev 04)
0000:01:1d.0 PCI bridge: Intel Corporation 82870P2 P64H2 Hub PCI Bridge
(rev 04)
0000:01:1e.0 PIC: Intel Corporation 82870P2 P64H2 I/OxAPIC (rev 04)
0000:01:1f.0 PCI bridge: Intel Corporation 82870P2 P64H2 Hub PCI Bridge
(rev 04)
0000:02:05.0 SCSI storage controller: Adaptec AIC-7902 U320 (rev 03)
0000:02:05.1 SCSI storage controller: Adaptec AIC-7902 U320 (rev 03)
0000:03:03.0 Ethernet controller: Intel Corporation 82544GC Gigabit
Ethernet Controller (LOM) (rev 02)
0000:04:01.0 Ethernet controller: Intel Corporation 82540EM Gigabit
Ethernet Controller (rev 02)
0000:04:02.0 VGA compatible controller: ATI Technologies Inc Rage XL
(rev 27)

cat /proc/scsi/scsi
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: IBM      Model: DCAS-34330W      Rev: S65A
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 04 Lun: 00
  Vendor: easyRAID Model:  16P             Rev: 0001
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi1 Channel: 00 Id: 04 Lun: 01
  Vendor: easyRAID Model:  16P             Rev: 0001
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi1 Channel: 00 Id: 06 Lun: 00
  Vendor: easyRAID Model:  X16P            Rev: 0001
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi1 Channel: 00 Id: 06 Lun: 01
  Vendor: easyRAID Model:  X16P            Rev: 0001
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi2 Channel: 00 Id: 00 Lun: 00
  Vendor: LITE-ON  Model: LTR-48246K       Rev: SKS7
  Type:   CD-ROM                           ANSI SCSI revision: ffffffff
Host: scsi3 Channel: 00 Id: 00 Lun: 00
  Vendor: HITACHI  Model: DF600F           Rev: 0000
  Type:   Direct-Access                    ANSI SCSI revision: 04
Host: scsi3 Channel: 00 Id: 00 Lun: 01
  Vendor: HITACHI  Model: DF600F           Rev: 0000
  Type:   Direct-Access                    ANSI SCSI revision: 03
------------

free
             total       used       free     shared    buffers     cached
Mem:       2075168    2022916      52252          0       4480    1848936
-/+ buffers/cache:     169500    1905668
Swap:      1959920    1782356     177564


> 
> Cheers,
> 
> Dave.
> 
>>> On Tue, Aug 22, 2006 at 05:28:15PM +0200, Martin Braun wrote:
>>>> Hi Nathan,
>>>>
>>>> since I haven't repaired the fs we had a crash again (see below).
>>>>
>>>> unfortunately we copied at the time of the crash over iscsi some files
>>>> to an xfs-fs on a nas.
>>>> and the directory was completely deleted. neither a xfs-check or a
>>>> xfs_repair did find something. was that due to the combination of iscsi
>>>> and xfs?
>>> Sorry for not getting back to you earlier, I've been too busy. :(
>>>
>>> I think you will need to clear out the affected inode (looks like a
>>> form of corruption that repair doesn't know about today) - you'll
>>> need to forcibly remove that inode via xfs_db, something like:
>>>
>>> # xfs_db -x -c 'inode 35141650' -c 'write core.mode 0' /dev/sdc1
>>> # xfs_repair /dev/sdc1
>>>
>>> cheers.
>>>
>>> ps: Barry, looks like repair needs some work in this area...
>>>
>>>> Aug 22 12:48:12 pers109 kernel: Access to block zero: fs: <sdc1> inode:
>>>> 35141650 start_block : 0 start_off : 3a1531 blkcnt : c
>>>>  extent-state : 0
>>>> Aug 22 12:48:12 pers109 kernel: ------------[ cut here ]------------
>>>> Aug 22 12:48:12 pers109 kernel: kernel BUG at <bad filename>:50307!
>>>> Aug 22 12:48:12 pers109 kernel: invalid opcode: 0000 [#1]
>>>> Aug 22 12:48:12 pers109 kernel: SMP
>>>> Aug 22 12:48:12 pers109 kernel: Modules linked in: iscsi_tcp libiscsi
>>>> scsi_transport_iscsi
>>>> Aug 22 12:48:12 pers109 kernel: CPU:    0
>>>> Aug 22 12:48:12 pers109 kernel: EIP:    0060:[<c025cb74>]    Not tainted VLI
>>>> Aug 22 12:48:12 pers109 kernel: EFLAGS: 00010246   (2.6.17.8 #5)
>>>> Aug 22 12:48:12 pers109 kernel: EIP is at cmn_err+0xa0/0xaa
>>>> Aug 22 12:48:12 pers109 kernel: eax: c048a2c4   ebx: c04359e4   ecx:
>>>> c047c9bc   edx: 00000282
>>>> Aug 22 12:48:12 pers109 kernel: esi: e595dcb0   edi: c056a120   ebp:
>>>> 00000000   esp: e595db70
>>>> Aug 22 12:48:12 pers109 kernel: ds: 007b   es: 007b   ss: 0068
>>>> Aug 22 12:48:12 pers109 kernel: Process smbd (pid: 25510,
>>>> threadinfo=e595c000 task=d9628a90)
>>>> Aug 22 12:48:12 pers109 kernel: Stack: c044497a c0427525 c056a120
>>>> 00000282 f3507260 e595dcb0 00000000 d9f9de00
>>>> Aug 22 12:48:12 pers109 kernel:        c0202f0d 00000000 c04359e4
>>>> f686cba0 02183812 00000000 00000000 00000000
>>>> Aug 22 12:48:12 pers109 kernel:        003a1531 00000000 0000000c
>>>> 00000000 00000000 e595dcb0 00000000 00000000
>>>> Aug 22 12:48:12 pers109 kernel: Call Trace:
>>>> Aug 22 12:48:12 pers109 kernel:  <c0202f0d>
>>>> xfs_bmap_search_extents+0xf5/0xf7  <c0204407> xfs_bmapi+0x229/0x162c
>>>> Aug 22 12:48:12 pers109 kernel:  <c039d890> dev_queue_xmit+0x1f4/0x26f
>>>> <c03b8660> ip_output+0x189/0x270
>>>> Aug 22 12:48:12 pers109 kernel:  <c012018e> __do_softirq+0x6e/0xdc
>>>> <c0104d7a> do_IRQ+0x1e/0x24
>>>> Aug 22 12:48:12 pers109 kernel:  <c0103222> common_interrupt+0x1a/0x20
>>>> <c0259e03> xfs_zero_eof+0x1ca/0x340
>>>> Aug 22 12:48:12 pers109 kernel:  <c039a342> memcpy_toiovec+0x37/0x5c
>>>> <c01762b3> file_update_time+0xa1/0xc0
>>>> Aug 22 12:48:12 pers109 kernel:  <c025a463> xfs_write+0x4ea/0xda5
>>>> <c0393654> sock_aio_read+0x83/0x8e
>>>> Aug 22 12:48:12 pers109 kernel:  <c016e098> fasync_helper+0x4b/0xd3
>>>> <c028dc12> copy_to_user+0x3c/0x4a
>>>> Aug 22 12:48:12 pers109 kernel:  <c025572f> xfs_file_aio_write+0x8f/0x9a
>>>>  <c015ba73> do_sync_write+0xd5/0x130
>>>> Aug 22 12:48:12 pers109 kernel:  <c012de03>
>>>> autoremove_wake_function+0x0/0x4b  <c015bb99> vfs_write+0xcb/0x195
>>>> Aug 22 12:48:12 pers109 kernel:  <c015be3e> sys_pwrite64+0x73/0x80
>>>> <c01027ef> sysenter_past_esp+0x54/0x75
>>>> Aug 22 12:48:12 pers109 kernel: Code: c0 c7 44 24 08 20 a1 56 c0 c7 04
>>>> 24 7a 49 44 c0 89 44 24 04 e8 ab eb eb ff b8 c4 a2 48 c
>>>> 0 8b 54 24 0c e8 fc 95 1a 00 85 ed 75 02 <0f> 0b 83 c4 10 5b 5e 5f 5d c3
>>>> 55 b8 07 00 00 00 57 bf 20 a1 56
>>>> Aug 22 12:48:12 pers109 kernel: EIP: [<c025cb74>] cmn_err+0xa0/0xaa
>>>> SS:ESP 0068:e595db70
>>>>
>>>>
>>>>
>>>>
>>>>
>>>>
>>>>  Scott schrieb:
>>>>> Hi Martin,
>>>>>
>>>>> On Tue, Aug 15, 2006 at 04:27:22PM +0200, Martin Braun wrote:
>>>>>> ...
>>>>>> What does this bug mean?
>>>>>> ...
>>>>>> Aug 15 15:01:02 pers109 kernel: Access to block zero: fs: <sdc1> inode:
>>>>>> 254474718 start_block : 0 start_off : c0a0b0e8a099
>>>>>> 0 blkcnt : 90000 extent-state : 0
>>>>>> Aug 15 15:01:02 pers109 kernel: ------------[ cut here ]------------
>>>>>> Aug 15 15:01:02 pers109 kernel: kernel BUG at <bad filename>:50307!
>>>>> It means XFS detected ondisk corruption in inode# 254474718, and
>>>>> paniced your system (stupidly; a fix for this is around, will be
>>>>> merged with the next mainline update).  For me, a more interesting
>>>>> question is how that inode got into this state... have you had any
>>>>> crashes recently (i.e. has the filesystem journal needed to be
>>>>> replayed recently?)  Can you send the output of:
>>>>>
>>>>> 	# xfs_db -c 'inode 254474718' -c print /dev/sdc1
>>>>>
>>>>> You'll need to run xfs_repair on that filesystem to fix this up,
>>>>> but please send us that output first.
>>>>>
>>>>> thanks.
>>>>>
>> -
>> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at  http://www.tux.org/lkml/
> 


-- 
Universitaetsbibliothek Heidelberg   Tel: +49 6221 54-2580
Ploeck 107-109, D-69117 Heidelberg   Fax: +49 6221 54-2623
