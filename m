Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262156AbUB2VnH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Feb 2004 16:43:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262152AbUB2VnG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Feb 2004 16:43:06 -0500
Received: from netti-3-261.dyn.nic.fi ([212.38.238.6]:15796 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262157AbUB2Vmc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Feb 2004 16:42:32 -0500
From: Jan Knutar <jk-lkml@sci.fi>
To: linux-kernel@vger.kernel.org
Subject: Kernel 2.4.25 I/O Error with NFS + VFAT partition
Date: Sun, 29 Feb 2004 21:13:56 +0200
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402292113.57329.jk-lkml@sci.fi>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I use NFS to share a vfat partition. I have a slight fear that vfat over
 nfs maybe only 'accidentally' worked in 2.4.24 and earlier...

In short: VFAT over NFS works in 2.4.24, does not work in 2.4.25,
 (l)stat64 syscalls fail. Tested with both 2.4.24 and 2.4.25 clients.

For example:
Works:
ls --color=no /mnt/d

Lots of Input/Output errors:
ls -lh /mnt/d

/mnt/d is mounted with mount host:/mnt/import/d /mnt/d -o hard,intr
on the client
and is exported as
/mnt/import/d 192.168.42.1(rw,async,no_root_squash)
on the server,  which has /mnt/import/d mounted with:
/dev/hdd5               /mnt/import/d           vfat
in /etc/fstab.

Local access on the server of the filesystem works ok.

With strace of ls I've seen a few syscalls which seem to fail, examples:

lstat64("/mnt/d/putty.exe", 0x805a114)  = -1 EIO (Input/output error)
stat64("/mnt/d/temp", 0x8059654)        = -1 EIO (Input/output error)

In dmesg on the client machine, I find the following:

nfs_stat_to_errno: bad nfs status return value: 45
nfs_stat_to_errno: bad nfs status return value: 45
<repeated many times>

Nothing in dmesg on the server machine.

Setting /proc/sys/sunrpc/nfs*debug to 1 doesn't seem to put anything 
in dmesg on the server, but alot of this on the client:

NFS: lookup(//cd2)
nfs_stat_to_errno: bad nfs status return value: 45
NFS: dentry_delete(//cd2, 0)
NFS: lookup(//cd1)
nfs_stat_to_errno: bad nfs status return value: 45
NFS: dentry_delete(//cd1, 0)

Which doesn't look very helpful.

Setting rpc-debug to 1, and the dmesg has this:

nfs_stat_to_errno: bad nfs status return value: 45
RPC: 23011 release request d1f63074
RPC: 23012 reserved req d1f63074 xid 83f759d9
RPC: 23012 xprt_transmit(83f759d9)
RPC: 23012 xprt_cwnd_limited cong = 0 cwnd = 512
RPC:      xprt_sendmsg(0) = 136
RPC: 23012 xmit complete
RPC:      udp_data_ready...
RPC:      udp_data_ready client d1f63000
RPC: 23012 received reply
RPC:      cong 256, cwnd was 512, now 512
RPC: 23012 has input (28 bytes)
nfs_stat_to_errno: bad nfs status return value: 45

Using ethereal to sniff on the NFS traffic, this is what it thinks of
a "ls /mnt/d/temp" from the server:

192.168.42.1 192.168.42.2 NFS V2 LOOKUP Call, DH:0x042c008a/temp
192.168.42.2 192.168.42.1 NFS V2 LOOKUP Reply (Call in 5) Error:ERR_OPNOTSUP


Any hints on where to go from here?

