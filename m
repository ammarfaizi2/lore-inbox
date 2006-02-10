Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751119AbWBJFgN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751119AbWBJFgN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 00:36:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751122AbWBJFgM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 00:36:12 -0500
Received: from smtp2.ist.utl.pt ([193.136.128.22]:58009 "EHLO smtp2.ist.utl.pt")
	by vger.kernel.org with ESMTP id S1751119AbWBJFgJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 00:36:09 -0500
From: Claudio Martins <ctpm@rnl.ist.utl.pt>
To: linux-kernel@vger.kernel.org
Subject: OCFS2 Filesystem inconsistency across nodes
Date: Fri, 10 Feb 2006 05:36:02 +0000
User-Agent: KMail/1.9.1
Cc: Mark Fasheh <mark.fasheh@oracle.com>, ocfs2-devel@oss.oracle.com
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602100536.02893.ctpm@rnl.ist.utl.pt>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 (I'm posting this to lkml since ocfs2-users@oss.oracle.com doesn't seem to be 
accepting new subscription requests)

 Hi all

 I'm testing OCFS2 on a 3 node cluster (2 nodes are Dual Xeon 512MB of RAM, 
the third one is a Dual AMD Athlon with 1GB of RAM) with gigabit ethernet 
interconnect and using an iSCSI target box for shared storage. 
 I'm using kernel version 2.6.16-rc2-git3 (gcc 4.0.3 from Debian) and compiled 
the iSCSI modules from the latest open-iscsi tree.
 Ocfs2-tools is version 1.1.5 from Debian distro.
 I followed the procedures for cluster configuration from the "OCFS2 User's 
Guide", onlined the cluster and formated a 2.3TB shared volume with 

 mkfs.ocfs2 -b 4K -C 64K -N 4 -L OCFSTest1 /dev/sda

 So after mounting this shared volume on all three nodes I played with it by 
creating/deleting/writing to files on different nodes. And this is the part 
where the fun begins:

On node1 I can do:

#mkdir dir1
#ls -l
total 4
drwxr-xr-x  2 ctpm ctpm 4096 2006-02-10 04:30 dir1

On node2 I do:

#ls -l
total 4
drwxr-xr-x 2 ctpm ctpm 4096 Feb 10 04:30 dir1

On node3 I do:
#ls -l
total 0

 Whooops!... now that directory should have appeared on all three nodes. It 
doesn't; not even if I wait half an hour. 
 I can reproduce the above behavior touching or writing to files instead of 
directories. It seems to be random, so sometimes it works and the file 
appears on all three nodes and sometimes only on 1 or 2 of them. 
 Node order doesn't seem to matter, so I don't think it's a problem w/ the 
configuration on one of the nodes. 
 Another example is to create a file, write something to it and then try to 
read it from another node (when it happens to be visible at all) with cat 
which results in

cat: file1: Input/output error

and lots of this on dmesg output:

(1925,0):ocfs2_extent_map_lookup_read:362 ERROR: status = -3
(1925,0):ocfs2_extent_map_get_blocks:818 ERROR: status = -3
(1925,0):ocfs2_get_block:166 ERROR: Error -3 from get_blocks(0xd6a7d4bc, 
436976, 1, 0, NULL)
(1925,0):ocfs2_extent_map_lookup_read:362 ERROR: status = -3
(1925,0):ocfs2_extent_map_get_blocks:818 ERROR: status = -3
(1925,0):ocfs2_get_block:166 ERROR: Error -3 from get_blocks(0xd6a7d4bc, 
436977, 1, 0, NULL)
(1925,0):ocfs2_extent_map_lookup_read:362 ERROR: status = -3
(1925,0):ocfs2_extent_map_get_blocks:818 ERROR: status = -3


 At first I thought this might be caused by the metadata info being propagated 
to the other nodes but the caches not being flushed to disk on the node that 
wrote to a file. So I tested this by copying ~2GB sized files to try to cause 
some memory pressure, yet with the same kind of disappointing results.

 Yet another interesting thing results when I create one big file. The file is 
shown on the directory listing on the node that wrote it. The other ones 
don't see it. I umount the filesystem from the nodes one by one starting with 
the one which wrote this file, and then the others. I then remount the 
filesystem on all of them and the file I created is gone. So not even a flush 
caused by unmounting assures that a file gets to persistant storage.

 Note that I'm using regular stuff to write the files, like copy, cat, echo, 
and shell redirects. No fancy mmap stuff or test programs.

 I also tested OCFS2 with a smaller volume over NBD from a remote machine with 
exactly the same kind of behavior, so I don't think this is related with the 
iSCSI target volume or open-iscsi modules or with the disk box (on a side 
node this box from Promise worked flawlessly with XFS and the same open-iscsi 
modules on any machine).

 I'd like to know if anyone on the list has had the opportunity of testing 
OCFS2 or had similar problems. OTOH, if I'm wrongly assuming something about 
OCFS2 which I shouldn't be, please tell me and I'll apologise for wasting 
your time ;-)
 I googled for this subject and found suprisingly few info about real world 
OCFS2 testing. Only lots of happy guys because of it being merged for 
2.6.16 ;-)

 I'm willing to make any tests or apply any patches you want. I'll be trying 
to keep the machines and the disk box for as many days as possible, so please 
try to bug me if you think these are real bugs and you want me to test fixes 
before 2.6.16 comes out.
 If you need kernel .config or any other info please ask.

Thanks

Best regards

Claudio Martins

