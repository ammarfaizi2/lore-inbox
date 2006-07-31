Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751492AbWGaFge@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751492AbWGaFge (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 01:36:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751495AbWGaFge
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 01:36:34 -0400
Received: from mail.clusterfs.com ([206.168.112.78]:50914 "EHLO
	mail.clusterfs.com") by vger.kernel.org with ESMTP id S1751492AbWGaFgd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 01:36:33 -0400
Date: Sun, 30 Jul 2006 23:36:30 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Michael Deegan <michael@ucc.gu.uwa.edu.au>,
       "Stephen C. Tweedie" <sct@redhat.com>,
       "ext2-devel@lists.sourceforge.net" <ext2-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org, Al Viro <viro@ftp.linux.org.uk>
Subject: Re: [Ext2-devel] BUG: __d_find_alias went POP! (was: BUG: lock held at task exit	time!)
Message-ID: <20060731053630.GA5757@schatzie.adilger.int>
Mail-Followup-To: Steven Rostedt <rostedt@goodmis.org>,
	Michael Deegan <michael@ucc.gu.uwa.edu.au>,
	"Stephen C. Tweedie" <sct@redhat.com>,
	"ext2-devel@lists.sourceforge.net" <ext2-devel@lists.sourceforge.net>,
	linux-kernel@vger.kernel.org, Al Viro <viro@ftp.linux.org.uk>
References: <20060722032533.GZ3874@wibble> <1153885899.4017.21.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1153885899.4017.21.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul 25, 2006  23:51 -0400, Steven Rostedt wrote:
> Actually the lock held at exit time was caused by the BUG, it wasn't the
> bug itself.  Seems you got a bad pointer which killed a task that
> happened to be holding a lock.  And that's why you got the bug from your
> subject.
> 
> It looks like there was something fishy going on in __d_find_alias (like
> a corrupted inode?).  Don't know for sure but since this looks like it's
> splice related or something wrong with general VFS, I CC'd Al Viro, and
> since it came from ext3, I CC'd Stephen Tweedie and the ext2-devel list.
> 
> Could a corrupted filesystem cause this oops?

The filesystem is definitely corrupted a bit.  At offset 12 in a directory
is normally the ".." entry, which would match the name_len=2 value, and the
fact that the (presumably parent) inode is one lower than the bad directory.
What the actual value should be isn't clear, but it needs to be an integer
between 12 and 4096, not 12320.  The hex value of 12320 is 0x3020, which is
also ASCII for " 0", though I'm not sure if this is relevant or not.

If "find" is doing a filesystem traversal it is definitely going to detect
any such corruption.  Whether the oops is directly related to this error,
or only some later fallout because the filesystem is read-only is unclear.

> On Sat, 2006-07-22 at 11:25 +0800, Michael Deegan wrote:
> > Hi,
> > 
> > I think somehere might be interested in this, though I'm not sure who. I do
> > not have the knowledge to say whether it originates within ext3, VFS, or
> > elsewhere.
> > 
> > Anyway, I discovered an OOPS spammed into my ssh sessions to this machine,
> > and kern.log contained:
> > 
> > Jul 22 06:26:55 localhost kernel: EXT3-fs error (device sda2): ext3_readdir: bad entry in directory #691212: directory entry across blocks - offset=12, inode=691211, rec_len=12320, name_len=2
> > Jul 22 06:26:55 localhost kernel: Remounting filesystem read-only
> > Jul 22 06:27:47 localhost kernel: Unable to handle kernel paging request at virtual address 0017e95a
> > Jul 22 06:27:47 localhost kernel:  printing eip:
> > Jul 22 06:27:47 localhost kernel: c01502c1
> > Jul 22 06:27:47 localhost kernel: *pde = 00000000
> > Jul 22 06:27:47 localhost kernel: Oops: 0000 [#1]
> > Jul 22 06:27:47 localhost kernel: Modules linked in: i2c_via dm_mod
> > Jul 22 06:27:47 localhost kernel: CPU:    0
> > Jul 22 06:27:47 localhost kernel: EIP:    0060:[<c01502c1>]    Not tainted VLI
> > Jul 22 06:27:47 localhost kernel: EFLAGS: 00010203   (2.6.16.18 #1)
> > Jul 22 06:27:47 localhost kernel: EIP is at __d_find_alias+0x14/0x9a
> > Jul 22 06:27:47 localhost kernel: eax: 00008000   ebx: 0017e95a   ecx: 0017e95a   edx: c73ed128
> > Jul 22 06:27:47 localhost kernel: esi: 00000000   edi: c73ec0ec   ebp: c73ed110   esp: c4d0ede4
> > Jul 22 06:27:47 localhost kernel: ds: 007b   es: 007b   ss: 0068
> > Jul 22 06:27:47 localhost kernel: Process find (pid: 27598, threadinfo=c4d0e000 task=c63eba90)
> > Jul 22 06:27:47 localhost kernel: Stack: <0>00000001 c73ed110 c6c0b878 c6c0b878 c73ed364 c0150743 c73ed110 c13eb600
> > Jul 22 06:27:47 localhost kernel:        c6c0b878 c017145b c3c67818 c03d65e0 c6c0b878 c73ed2f4 c0148d04 c4d0ee70
> > Jul 22 06:27:47 localhost kernel:        c4d0ee64 c4d0ef1c c1145da0 95ca2dfe c73ed2f4 c67f2000 c4d0ef1c c0149435
> > Jul 22 06:27:47 localhost kernel: Call Trace:
> > Jul 22 06:27:47 localhost kernel:  [<c0150743>] d_splice_alias+0x19/0xb2
> > Jul 22 06:27:47 localhost kernel:  [<c017145b>] ext3_lookup+0x72/0x77
> > Jul 22 06:27:47 localhost kernel:  [<c0148d04>] do_lookup+0xa3/0x137
> > Jul 22 06:27:47 localhost kernel:  [<c0149435>] __link_path_walk+0x69d/0xa77
> > Jul 22 06:27:47 localhost kernel:  [<c01525ef>] mntput_no_expire+0x11/0x52
> > Jul 22 06:27:47 localhost kernel:  [<c01498be>] link_path_walk+0xaf/0xb9
> > Jul 22 06:27:47 localhost kernel:  [<c0359f7c>] __mutex_lock_slowpath+0x1d0/0x276
> > Jul 22 06:27:47 localhost kernel:  [<c0149856>] link_path_walk+0x47/0xb9
> > Jul 22 06:27:47 localhost kernel:  [<c0149c74>] do_path_lookup+0x17f/0x19f
> > Jul 22 06:27:47 localhost kernel:  [<c014a15a>] __user_walk_fd+0x2a/0x3f
> > Jul 22 06:27:47 localhost kernel:  [<c0144f65>] vfs_lstat_fd+0x12/0x39
> > Jul 22 06:27:47 localhost kernel:  [<c01455e9>] sys_lstat64+0xf/0x23
> > Jul 22 06:27:47 localhost kernel:  [<c0102409>] syscall_call+0x7/0xb
> > Jul 22 06:27:47 localhost kernel: Code: 8d 4b c4 8b 59 3c 8d 74 26 00 8d 51 3c 8d 46 18 39 c2 75 96 5b 5e c3 55 89 c5 57 56 31 f6 53 51 89 14 24 8b 48 18 8d 50 18 eb 53 <8b> 19 8d 74 26 00 0f b7 45 28 8d 79 c4 25 00 f0 00 00 3d 00 40
> > Jul 22 06:27:47 localhost kernel:  BUG: find/27598, lock held at task exit time!
> > Jul 22 06:27:47 localhost kernel:  [c73ed364] {inode_init_once}
> > Jul 22 06:27:47 localhost kernel: .. held by:              find:27598 [c63eba90, 126]
> > Jul 22 06:27:47 localhost kernel: ... acquired at:               do_lookup+0x69/0x137
> > 
> > /dev/sda2 is my root partition. Fortunately /var was on a different partition.
> > Unsurprisingly the root partition contains errors:
> > 
> >     Pass 1: Checking inodes, blocks, and sizes
> >     Inode 114510 has illegal block(s).  Clear? no
> > 
> >     Illegal block #8 (3342783228) in inode 114510.  IGNORED.
> >     Inodes that were part of a corrupted orphan linked list found.  Fix? no
> > 
> >     Inode 318876 was part of the orphaned inode list.  IGNORED.
> >     Inode 351606 was part of the orphaned inode list.  IGNORED.
> >     Inode 491835 was part of the orphaned inode list.  IGNORED.
> >     Deleted inode 556073 has zero dtime.  Fix? no
> > 
> > I am of course assuming that the mere presence of filesystem errors
> > shouldn't cause the kernel to oops.
> > 
> > Output of ver_linux (keeping in mind I can't tell what has been apt-get
> > upgraded since the kernel was compiled):
> > 
> >     Linux plugh 2.6.16.18 #1 Sun May 28 01:17:17 WST 2006 i586 GNU/Linux
> > 
> >     Gnu C                  4.0.4
> >     Gnu make               3.81
> >     binutils               2.17
> >     util-linux             2.12r
> >     mount                  2.12r
> >     module-init-tools      3.2.2
> >     e2fsprogs              1.39
> >     reiserfsprogs          line
> >     reiser4progs           line
> >     PPP                    2.4.4b1
> >     Linux C Library        2.3.6
> >     Dynamic linker (ldd)   2.3.6
> >     Procps                 3.2.7
> >     Net-tools              1.60
> >     Console-tools          0.2.3
> >     Sh-utils               5.96
> >     Modules Loaded         i2c_via dm_mod
> > 
> > The machine is my household webserver (128MiB K6II-500, Debian
> > testing/etch). It is still performing normally, despite a read only root fs
> > (including /tmp). I'm happy to keep the machine in this state if further
> > diagnostics are required; otherwise I'll eventually just build a new kernel
> > and reboot it.
> > 
> > I'm not on the list, so please CC replies (though I'll probably check the
> > archives from time to time anyway).
> > 
> > Thanks,
> > 
> > -MD
> 
> 
> 
> -------------------------------------------------------------------------
> Take Surveys. Earn Cash. Influence the Future of IT
> Join SourceForge.net's Techsay panel and you'll get the chance to share your
> opinions on IT & business topics through brief surveys -- and earn cash
> http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
> _______________________________________________
> Ext2-devel mailing list
> Ext2-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ext2-devel

Cheers, Andreas
--
Andreas Dilger
Principal Software Engineer
Cluster File Systems, Inc.

