Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266327AbUAVSWa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 13:22:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266311AbUAVSWa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 13:22:30 -0500
Received: from citrine.spiritone.com ([216.99.193.133]:20163 "EHLO
	citrine.spiritone.com") by vger.kernel.org with ESMTP
	id S266292AbUAVSVs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 13:21:48 -0500
Date: Thu, 22 Jan 2004 10:21:45 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
cc: bernhard_heibler@gmx.de
Subject: [Bug 1936] New: Poor NFS write performance because of	bug in remove_suid 
Message-ID: <2650000.1074795705@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=1936

           Summary: Poor NFS write performance because of bug in remove_suid
    Kernel Version: 2.6.1
            Status: NEW
          Severity: high
             Owner: trond.myklebust@fys.uio.no
         Submitter: bernhard_heibler@gmx.de


Distribution: Suse 9
Hardware Environment: 2 x Pentium 4 Xeon 2.4 GHZ Hyper Threading 
Tyan Tiger i7505 
Software Environment: NFS Client
Problem Description:

The write performance  of the NFS client in Kernel 2.6.1 is poor (about 300
kb/s) if the target file of the copy operation on the server has the execution
rights set. (chmod a+x) The same problem happen if a file with execution rights
is copied onto the server and the file doesn't exist.  The problem happens with
various NFS servers (Kernel 2.6.1, 2.4.xx or Solaris 2.7) The problem is that
during the copy operation the client tries to always remove the suid bit on the
target file. This seams to happen for every block of data transfered to the NFS
server. This will stress the server a lot. At my server the disk gets very busy.

The same problem also happens on local disk but it doesn't seam to hurt the
write performance on local disks much.

I guess the problem is that remove_suid in mm/filemap.c trys to remove the suid
every time but the suid is not set at all. So it tries it every time data is
transfered. 

I just copied the old code from remove_suid of kernel 2.4.21 into the new kernel
 and now the write performance is about 8 MB/s. Thats ok !

Thats the how my solution for this  problem looks like:

void remove_suid(struct dentry *dentry)
{
	struct iattr newattrs;
	struct inode *inode = dentry->d_inode;

# if 0  /* NEW CODE FROM 2.6.1 that is broken */
	unsigned int mode = inode->i_mode & (S_ISUID|S_ISGID|S_IXGRP);
	if (!(mode & S_IXGRP))
		mode &= S_ISUID;
# endif
      
/***************** old code from 2.4.21 that work better */

	/* set S_IGID if S_IXGRP is set, and always set S_ISUID */
	mode = (inode->i_mode & S_IXGRP)*(S_ISGID/S_IXGRP) | S_ISUID;

	/* was any of the uid bits set? */
	mode &= inode->i_mode;
	
/***************** enod of old code from 2.4.21 that work better */

	/* were any of the uid bits set? */
	if (mode && !capable(CAP_FSETID)) {
		newattrs.ia_valid = ATTR_KILL_SUID|ATTR_KILL_SGID|ATTR_FORCE;
		notify_change(dentry, &newattrs);
	}
}


Thats how the stack trace looks like if the  problem happens:

Jan 22 13:30:08 weisnix kernel: NFS call  setattr 
Jan 22 13:30:08 weisnix kernel: attr: setAttr
Jan 22 13:30:08 weisnix kernel: Call Trace:
Jan 22 13:30:08 weisnix kernel:  [notify_change+450/517] notify_change+0x1c2/0x235
Jan 22 13:30:08 weisnix kernel:  [remove_suid+94/99] remove_suid+0x5e/0x63
Jan 22 13:30:08 weisnix kernel:  [generic_file_aio_write_nolock+618/2930]
generic_file_aio_write_nolock+0x26a/0xb72
Jan 22 13:30:08 weisnix kernel:  [file_read_actor+250/260]
file_read_actor+0xfa/0x104
Jan 22 13:30:08 weisnix kernel:  [__generic_file_aio_read+505/555]
__generic_file_aio_read+0x1f9/0x22b
Jan 22 13:30:08 weisnix kernel:  [file_read_actor+0/260] file_read_actor+0x0/0x104
Jan 22 13:30:08 weisnix kernel:  [generic_file_aio_write+126/168]
generic_file_aio_write+0x7e/0xa8
Jan 22 13:30:08 weisnix kernel:  [nfs_file_write+197/244] nfs_file_write+0x95/0xf4
Jan 22 13:30:08 weisnix kernel:  [do_sync_write+139/205] do_sync_write+0x8b/0xcd
Jan 22 13:30:08 weisnix kernel:  [timer_interrupt+85/254] timer_interrupt+0x55/0xfe
Jan 22 13:30:08 weisnix kernel:  [handle_IRQ_event+58/100]
handle_IRQ_event+0x3a/0x64
Jan 22 13:30:08 weisnix kernel:  [do_IRQ+211/368] do_IRQ+0xd3/0x170
Jan 22 13:30:08 weisnix kernel:  [update_wall_time+13/54] update_wall_time+0xd/0x36
Jan 22 13:30:08 weisnix kernel:  [do_timer+76/205] do_timer+0x4c/0xcd
Jan 22 13:30:08 weisnix kernel:  [do_sync_write+0/205] do_sync_write+0x0/0xcd
Jan 22 13:30:08 weisnix kernel:  [vfs_write+177/287] vfs_write+0xb1/0x11f
Jan 22 13:30:08 weisnix kernel:  [sys_write+66/99] sys_write+0x42/0x63
Jan 22 13:30:08 weisnix kernel:  [syscall_call+7/11] syscall_call+0x7/0xb

My mount options:

weisnix:/junk /mnt nfs
rw,v3,rsize=8192,wsize=8192,hard,intr,udp,lock,addr=weisnix 0 0


