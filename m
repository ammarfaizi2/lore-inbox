Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274879AbTHFGg2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 02:36:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274883AbTHFGg2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 02:36:28 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:22692 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id S274879AbTHFGgY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 02:36:24 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Andrew Morton <akpm@osdl.org>
Date: Wed, 6 Aug 2003 16:36:07 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16176.41431.279477.273718@gargle.gargle.HOWL>
Cc: Daniel Jacobowitz <dan@debian.org>, linux-kernel@vger.kernel.org,
       ext3-users@redhat.com
Subject: Re: ext3 badness in 2.6.0-test2
In-Reply-To: message from Andrew Morton on Monday August 4
References: <20030804142245.GA1627@nevyn.them.org>
	<20030804132219.2e0c53b4.akpm@osdl.org>
X-Mailer: VM 7.17 under Emacs 21.3.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday August 4, akpm@osdl.org wrote:
> Daniel Jacobowitz <dan@debian.org> wrote:
> >
> > I came back this morning and found:
> >   EXT3-fs error (device md0) in start_transaction: Journal has aborted
> >   EXT3-fs error (device md0) in start_transaction: Journal has aborted
> >   EXT3-fs error (device md0) in start_transaction: Journal has aborted
> > 
> > Unfortunately, from the very first one, all writes failed; including all
> > writes to syslog.  So I don't know what happened at the beginning.  Is this
> > more likely to be something internal to ext3, or a problem with the RAID
> > layer?
> 
> Could have been an IO error, or the block/MD/device layer returned
> incorrect data.  ext3 used to go BUG a lot in the latter case, but nowadays
> we try to abort the journal and go read-only.
> 
> Without the initial message we do not know.

Can I add a "me too".....

First, I'm using data=journal - is that supposed to work in 2.6 yet?


I have a raid5 array across a bunch of SCSI drives and a separate scsi
drive with boot, swap, and a journal partition.
I have an ext3 filesystem on the raid5 array with an external journal
on the journal partition.

The raid5 was rebuilding a spare and I was pounding the filesystem
over NFS using the SPEC SFS benchmark program (ofcourse the raid5
rebuild killed the performance reported by SFS, but I expected that.

Shortly after the rebuild finished, I got an ext3 error (see log
below) and the journal aborted, and then nfsd Oopsed inside ext3.

I rebooted and fscked the filesystem and it found nothing interesting
- see output below.

So I suspect ext3 has a problem somewhere.  
I'll see if I can break it again :-)

NeilBrown



Aug  6 15:22:05 adams kernel: EXT3-fs error (device md1): ext3_add_entry: bad entry in directory #41
009295: rec_len is smaller than minimal - offset=0, inode=3265411686, rec_len=0, name_len=0
Aug  6 15:22:05 adams kernel: Aborting journal on device sda4.
Aug  6 15:22:05 adams kernel: ext3_abort called.
Aug  6 15:22:05 adams kernel: EXT3-fs abort (device md1): ext3_journal_start: Detected aborted journ
al
Aug  6 15:22:05 adams kernel: Remounting filesystem read-only
Aug  6 15:22:05 adams kernel: Unable to handle kernel NULL pointer dereference at virtual address 00
000000
Aug  6 15:22:05 adams kernel:  printing eip:
Aug  6 15:22:05 adams kernel: c01b1e61
Aug  6 15:22:05 adams kernel: *pde = 00000000
Aug  6 15:22:05 adams kernel: Oops: 0000 [#1]
Aug  6 15:22:05 adams kernel: CPU:    1
Aug  6 15:22:05 adams kernel: EIP:    0060:[<c01b1e61>]    Not tainted
Aug  6 15:22:05 adams kernel: EFLAGS: 00010286
Aug  6 15:22:05 adams kernel: do_journal_get_write_access: aborting transaction: Journal has aborted
 in __ext3_journal_get_write_access<2>EXT3-fs error (device md1) in ext3_prepare_write: Journal has 
aborted
Aug  6 15:22:05 adams kernel: EXT3-fs error (device md1) in start_transaction: Journal has aborted
Aug  6 15:22:05 adams kernel: EIP is at do_get_write_access+0x11/0x770
Aug  6 15:22:05 adams kernel: eax: e8888a64   ebx: f066f8a4   ecx: 00000004   edx: 00000dab
Aug  6 15:22:05 adams kernel: esi: f2eae000   edi: 00000000   ebp: c46208a4   esp: f19378d4
Aug  6 15:22:05 adams kernel: ds: 007b   es: 007b   ss: 0068
Aug  6 15:22:05 adams kernel: Process nfsd (pid: 732, threadinfo=f1936000 task=f1969000)
Aug  6 15:22:05 adams kernel: Stack: e1f155e4 e1f15d64 e1f15d24 e1f15624 e1f159a4 c95d71a4 e171a364 
f066f8a4 
Aug  6 15:22:05 adams kernel:        00000008 c371d780 f066f8a4 c01634e3 f066f8a4 0000001b 00000000 
00001000 
Aug  6 15:22:05 adams kernel:        00000000 0000001b 00000000 0000001b 00000000 f066f8a4 f2eae000 
f066f8a4 
Aug  6 15:22:05 adams kernel: Call Trace:
Aug  6 15:22:05 adams kernel:  [<c01634e3>] __find_get_block+0x73/0x100
Aug  6 15:22:05 adams kernel:  [<c01b290d>] journal_get_undo_access+0x3d/0x170
Aug  6 15:22:05 adams kernel:  [<c01a2a34>] ext3_try_to_allocate+0xc4/0x240
Aug  6 15:22:05 adams kernel:  [<c01a2db4>] ext3_new_block+0x204/0x740
Aug  6 15:22:05 adams kernel:  [<c0163439>] bh_lru_install+0xb9/0xf0
Aug  6 15:22:05 adams kernel:  [<c01a5a57>] ext3_alloc_block+0x37/0x40
Aug  6 15:22:05 adams kernel:  [<c01a5dfa>] ext3_alloc_branch+0x4a/0x2c0
Aug  6 15:22:05 adams kernel:  [<c0119eb5>] __change_page_attr+0x25/0x1e0
Aug  6 15:22:05 adams kernel:  [<c01a63fc>] ext3_get_block_handle+0x18c/0x340
Aug  6 15:22:05 adams kernel:  [<c0165d3c>] alloc_buffer_head+0x1c/0x50
Aug  6 15:22:05 adams kernel:  [<c0165d61>] alloc_buffer_head+0x41/0x50
Aug  6 15:22:05 adams kernel:  [<c0162e0a>] create_buffers+0x6a/0xc0
Aug  6 15:22:05 adams kernel:  [<c01a6614>] ext3_get_block+0x64/0xb0
Aug  6 15:22:05 adams kernel:  [<c016404b>] __block_prepare_write+0x20b/0x490
Aug  6 15:22:05 adams kernel:  [<c011bc70>] default_wake_function+0x0/0x30
Aug  6 15:22:05 adams kernel:  [<c0164bb4>] block_prepare_write+0x34/0x50
Aug  6 15:22:05 adams kernel:  [<c01a65b0>] ext3_get_block+0x0/0xb0
Aug  6 15:22:05 adams kernel:  [<c01a6bcf>] ext3_prepare_write+0x5f/0x110
Aug  6 15:22:05 adams kernel:  [<c01a65b0>] ext3_get_block+0x0/0xb0
Aug  6 15:22:05 adams kernel:  [<c013f0e2>] generic_file_aio_write_nolock+0x412/0xbd0
Aug  6 15:22:05 adams kernel:  [<c017c0ed>] d_alloc_anon+0x2d/0x240
Aug  6 15:22:05 adams kernel:  [<c034bf0f>] sock_alloc_send_skb+0x2f/0x40
Aug  6 15:22:05 adams kernel:  [<c0366ceb>] ip_append_data+0x6db/0x780
Aug  6 15:22:05 adams kernel:  [<c013f91e>] generic_file_write_nolock+0x7e/0xa0
Aug  6 15:22:05 adams kernel:  [<c038867a>] udp_sendmsg+0x41a/0xb40
Aug  6 15:22:05 adams kernel:  [<c02a4136>] e1000_xmit_frame+0x516/0x680
Aug  6 15:22:05 adams kernel:  [<c01df6b0>] exp_find_key+0x60/0x70
Aug  6 15:22:05 adams kernel:  [<c013fb7c>] generic_file_writev+0x5c/0x80
Aug  6 15:22:05 adams kernel:  [<c016068f>] do_readv_writev+0x23f/0x2d0
Aug  6 15:22:05 adams kernel:  [<c0160040>] do_sync_write+0x0/0xc0
Aug  6 15:22:05 adams kernel:  [<c016108d>] open_private_file+0x9d/0xa0
Aug  6 15:22:05 adams kernel:  [<c01607e8>] vfs_writev+0x58/0x70
Aug  6 15:22:05 adams kernel:  [<c01dbdcf>] nfsd_write+0x11f/0x380
Aug  6 15:22:05 adams kernel:  [<c011bc9a>] default_wake_function+0x2a/0x30
Aug  6 15:22:05 adams kernel:  [<c011bcda>] __wake_up_common+0x3a/0x70
Aug  6 15:22:05 adams kernel:  [<c01d8808>] nfsd_proc_write+0xa8/0x130
Aug  6 15:22:05 adams kernel:  [<c01d7818>] nfsd_dispatch+0xe8/0x1f5
Aug  6 15:22:05 adams kernel:  [<c01d7730>] nfsd_dispatch+0x0/0x1f5
Aug  6 15:22:05 adams kernel:  [<c03b8120>] svc_process+0x480/0x64c
Aug  6 15:22:05 adams kernel:  [<c01d747b>] nfsd+0x26b/0x520
Aug  6 15:22:05 adams kernel:  [<c010b356>] work_resched+0x5/0x16
Aug  6 15:22:05 adams kernel:  [<c01d7210>] nfsd+0x0/0x520
Aug  6 15:22:05 adams kernel:  [<c01d7210>] nfsd+0x0/0x520
Aug  6 15:22:05 adams kernel:  [<c0108e35>] kernel_thread_helper+0x5/0x10
Aug  6 15:22:05 adams kernel: 
Aug  6 15:22:05 adams kernel: Code: 8b 37 c7 44 24 20 00 00 00 00 c7 44 24 1c 00 00 00 00 8d 96 
Aug  6 15:22:05 adams kernel:  <1>Unable to handle kernel NULL pointer dereference at virtual addres
s 00000000
Aug  6 15:22:05 adams kernel:  printing eip:
Aug  6 15:22:05 adams kernel: journal commit I/O error
Aug  6 15:22:05 adams kernel: c01b1e61
Aug  6 15:22:05 adams kernel: journal commit I/O error


-----------------------------------------------------
adams # fsck -n /dev/md1
fsck 1.34-WIP (21-May-2003)
e2fsck 1.34-WIP (21-May-2003)
Warning: skipping journal recovery because doing a read-only filesystem check.
/dev/md1 contains a file system with errors, check forced.
Pass 1: Checking inodes, blocks, and sizes
Pass 2: Checking directory structure
Pass 3: Checking directory connectivity
Pass 4: Checking reference counts
Unattached zero-length inode 47710329.  Clear? no

Unattached inode 47710329
Connect to /lost+found? no

Pass 5: Checking group summary information

/dev/md1: ********** WARNING: Filesystem still has errors **********

/dev/md1: 235617/53362688 files (11.7% non-contiguous), 3139703/106699200 blocks
adams # fsck /dev/md1
fsck 1.34-WIP (21-May-2003)
e2fsck 1.34-WIP (21-May-2003)
/dev/md1: recovering journal
/dev/md1: clean, 235617/53362688 files, 3139703/106699200 blocks
adams # fsck /dev/md1
fsck 1.34-WIP (21-May-2003)
e2fsck 1.34-WIP (21-May-2003)
/dev/md1: clean, 235617/53362688 files, 3139703/106699200 blocks
adams # fsck -f /dev/md1
fsck 1.34-WIP (21-May-2003)
e2fsck 1.34-WIP (21-May-2003)
Pass 1: Checking inodes, blocks, and sizes
Pass 2: Checking directory structure
Pass 3: Checking directory connectivity
Pass 4: Checking reference counts
Pass 5: Checking group summary information
Free blocks count wrong for group #2532 (8073, counted=8075).
Fix<y>? yes

Free blocks count wrong (103559497, counted=103559499).
Fix<y>? yes

Free inodes count wrong for group #2912 (16263, counted=16264).
Fix<y>? yes

Free inodes count wrong (53127071, counted=53127072).
Fix<y>? yes


/dev/md1: ***** FILE SYSTEM WAS MODIFIED *****
/dev/md1: 235616/53362688 files (11.7% non-contiguous), 3139701/106699200 blocks
