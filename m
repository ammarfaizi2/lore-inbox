Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267068AbSLDUOU>; Wed, 4 Dec 2002 15:14:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267070AbSLDUOU>; Wed, 4 Dec 2002 15:14:20 -0500
Received: from hermes.domdv.de ([193.102.202.1]:21516 "EHLO zeus.domdv.de")
	by vger.kernel.org with ESMTP id <S267068AbSLDUOR>;
	Wed, 4 Dec 2002 15:14:17 -0500
Message-ID: <3DEE6533.8070805@domdv.de>
Date: Wed, 04 Dec 2002 21:27:31 +0100
From: Andreas Steinmetz <ast@domdv.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20021020
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, sct@redhat.com,
       akpm@zip.com.au, adilger@clusterfs.com
Subject: [RESEND] 2.4.20: ext3: Assertion failure in journal_forget()/Oops
 on another system
X-Enigmail-Version: 0.65.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------050108060303020109030508"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050108060303020109030508
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

It seems that either my previous post (below) was to vague or it either 
got lost or ignored. Anyway I did hope for a spurious hardware error.

Unfortunately today I got an Oops from a completely different system 
using ext3 on software raid 0 and raid 1 with data=ordered that again 
points to a problem with ext3. The ksymoops output is attached. I'm 
really beginning to get worried.

Below is my previous post.
--------------------------

This started to happen during larger (10MB-420MB) rsync based writes to
a striped ext3 partition (/dev/md11) residing on 4 scsi disks which is
mounted with defaults, i.e. data=ordered (rsync over 100Mbps link):

Dec  1 12:25:43 pollux kernel: EXT3-fs error (device md(9,11)):
ext3_new_block:
Allocating block in system zone - block = 114696
Dec  1 12:25:43 pollux kernel: EXT3-fs error (device md(9,11)):
ext3_new_block:
Allocating block in system zone - block = 114697
Dec  1 12:25:43 pollux kernel: EXT3-fs error (device md(9,11)):
ext3_new_block:
Allocating block in system zone - block = 114700
Dec  1 12:25:43 pollux kernel: EXT3-fs error (device md(9,11)):
ext3_new_block:
Allocating block in system zone - block = 114701
Dec  1 12:25:43 pollux kernel: EXT3-fs error (device md(9,11)):
ext3_new_block:
Allocating block in system zone - block = 114702
Dec  1 12:25:43 pollux kernel: EXT3-fs error (device md(9,11)):
ext3_new_block:
Allocating block in system zone - block = 114706

<snip>

Dec  1 22:17:55 pollux kernel: EXT3-fs error (device md(9,11)):
ext3_free_blocks
: Freeing blocks in system zones - Block = 573501, count = 2
Dec  1 22:17:55 pollux kernel: EXT3-fs error (device md(9,11)):
ext3_free_blocks
: Freeing blocks in system zones - Block = 573552, count = 14
Dec  1 22:17:55 pollux kernel: Assertion failure in journal_forget() at
transaction.c:1225: "!jh->b_committed_data"



Trying to access the partition resulted in processes hanging in D state:

5336 pts/0    D      0:00 ls -a -N --color=tty -T 0 -l /mnt/data8

e2fstools version is 1.32 and the partition was created with this
version using 'mke2fs -j -b 2048 -i 4096 -R stride=16 /dev/md11'.

An earlier dump of the partition data using tune2fs -l gave:

tune2fs 1.32 (09-Nov-2002)
Filesystem volume name:   <none>
Last mounted on:          <not available>
Filesystem UUID:          7c8d7827-4b25-40ab-a3b8-1c4c6e286868
Filesystem magic number:  0xEF53
Filesystem revision #:    1 (dynamic)
Filesystem features:      has_journal filetype needs_recovery sparse_super
Default mount options:    (none)
Filesystem state:         clean with errors
Errors behavior:          Continue
Filesystem OS type:       Linux
Inode count:              2621440
Block count:              5236992
Reserved block count:     261849
Free blocks:              4855697
Free inodes:              2621416
First block:              0
Block size:               2048
Fragment size:            2048
Blocks per group:         16384
Fragments per group:      16384
Inodes per group:         8192
Inode blocks per group:   512
Last mount time:          Sat Nov 30 11:23:59 2002
Last write time:          Sun Dec  1 14:09:55 2002
Mount count:              2
Maximum mount count:      -1
Last checked:             Fri Dec  1 19:18:16 2000
Check interval:           0 (<none>)
Reserved blocks uid:      0 (user root)
Reserved blocks gid:      0 (group root)
First inode:              11
Inode size:               128
Journal UUID:             <none>
Journal inode:            8
Journal device:           0x0000
First orphan inode:       0


Trying 'e2fsck -y /dev/md11' after a reboot showed so many errors and
continued to run for minutes that I aborted e2fsck and do assume that
the file system was completely destroyed.

After recreation of the filesystem on /dev/md11 a rsync run completed
without errors.

As a side note: the system having the rsync sources has an identical
formatted partition (the systems are hardware twins) and doesn't show
any errors.

Some final information about the raid configuration of /dev/md11:

raiddev /dev/md11
           raid-level              0
           nr-raid-disks           4
           nr-spare-disks          0
           chunk-size              32
           persistent-superblock   1
           device                  /dev/sda13
           raid-disk               0
           device                  /dev/sdb13
           raid-disk               1
           device                  /dev/sdc15
           raid-disk               2
           device                  /dev/sdd15
           raid-disk               3
-- 
Andreas Steinmetz
D.O.M. Datenverarbeitung GmbH



--------------050108060303020109030508
Content-Type: text/plain;
 name="ext3-oops.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ext3-oops.txt"

ksymoops 2.4.8 on i686 2.4.20.  Options used
     -V (default)
     -k /proc/ksyms (specified)
     -l /proc/modules (default)
     -o /lib/modules/2.4.20/ (default)
     -m /boot/System.map (default)

Dec  4 16:19:59 tux kernel: Unable to handle kernel paging request at virtual address 6574616c
Dec  4 16:19:59 tux kernel: c0185102
Dec  4 16:19:59 tux kernel: *pde = 00000000
Dec  4 16:19:59 tux kernel: Oops: 0000
Dec  4 16:19:59 tux kernel: CPU:    0
Dec  4 16:19:59 tux kernel: EIP:    0010:[<c0185102>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Dec  4 16:19:59 tux kernel: EFLAGS: 00013a87
Dec  4 16:19:59 tux kernel: eax: 00000001   ebx: 65746144   ecx: c12c09bc   edx: 65746144
Dec  4 16:19:59 tux kernel: esi: c0007e00   edi: 00000001   ebp: 00000000   esp: c1595ef0
Dec  4 16:19:59 tux kernel: ds: 0018   es: 0018   ss: 0018
Dec  4 16:19:59 tux kernel: Process kswapd (pid: 5, stackpage=c1595000)
Dec  4 16:19:59 tux kernel: Stack: c010bb08 c0512890 c102c01c 00003202 00003296 00000000 c12c09bc 000001d0 
Dec  4 16:19:59 tux kernel:        00003d6d c0512890 c017bccd c4119680 c12c09bc 000001d0 c014d672 c12c09bc 
Dec  4 16:19:59 tux kernel:        000001d0 00000000 c12c09bc c0140895 c12c09bc 000001d0 c1594000 00000200 
Dec  4 16:19:59 tux kernel: Call Trace:    [<c010bb08>] [<c017bccd>] [<c014d672>] [<c0140895>] [<c0140a93>]
Dec  4 16:19:59 tux kernel:   [<c0140b16>] [<c0140c2c>] [<c0140ca8>] [<c0140ddd>] [<c0105000>] [<c010578e>]
Dec  4 16:19:59 tux kernel:   [<c0140d40>]
Dec  4 16:19:59 tux kernel: Code: 8b 5b 28 f6 42 19 02 75 26 39 f3 75 f1 f7 44 24 34 50 00 00 


>>EIP; c0185102 <journal_try_to_free_buffers+32/c0>   <=====

>>ecx; c12c09bc <_end+d15204/2038c8a8>
>>esp; c1595ef0 <_end+fea738/2038c8a8>

Trace; c010bb08 <call_do_IRQ+5/d>
Trace; c017bccd <ext3_releasepage+2d/40>
Trace; c014d672 <try_to_release_page+52/70>
Trace; c0140895 <shrink_cache+265/310>
Trace; c0140a93 <shrink_caches+63/b0>
Trace; c0140b16 <try_to_free_pages_zone+36/50>
Trace; c0140c2c <kswapd_balance_pgdat+5c/b0>
Trace; c0140ca8 <kswapd_balance+28/40>
Trace; c0140ddd <kswapd+9d/c0>
Trace; c0105000 <_stext+0/0>
Trace; c010578e <kernel_thread+2e/40>
Trace; c0140d40 <kswapd+0/c0>

Code;  c0185102 <journal_try_to_free_buffers+32/c0>
00000000 <_EIP>:
Code;  c0185102 <journal_try_to_free_buffers+32/c0>   <=====
   0:   8b 5b 28                  mov    0x28(%ebx),%ebx   <=====
Code;  c0185105 <journal_try_to_free_buffers+35/c0>
   3:   f6 42 19 02               testb  $0x2,0x19(%edx)
Code;  c0185109 <journal_try_to_free_buffers+39/c0>
   7:   75 26                     jne    2f <_EIP+0x2f>
Code;  c018510b <journal_try_to_free_buffers+3b/c0>
   9:   39 f3                     cmp    %esi,%ebx
Code;  c018510d <journal_try_to_free_buffers+3d/c0>
   b:   75 f1                     jne    fffffffe <_EIP+0xfffffffe>
Code;  c018510f <journal_try_to_free_buffers+3f/c0>
   d:   f7 44 24 34 50 00 00      testl  $0x50,0x34(%esp,1)
Code;  c0185116 <journal_try_to_free_buffers+46/c0>
  14:   00 


--------------050108060303020109030508--

