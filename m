Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751175AbWBKFlG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751175AbWBKFlG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Feb 2006 00:41:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751199AbWBKFlG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Feb 2006 00:41:06 -0500
Received: from smtp2.ist.utl.pt ([193.136.128.22]:17028 "EHLO smtp2.ist.utl.pt")
	by vger.kernel.org with ESMTP id S1751175AbWBKFlF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Feb 2006 00:41:05 -0500
From: Claudio Martins <ctpm@rnl.ist.utl.pt>
To: Mark Fasheh <mark.fasheh@oracle.com>
Subject: Re: OCFS2 Filesystem inconsistency across nodes
Date: Sat, 11 Feb 2006 05:40:57 +0000
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, ocfs2-devel@oss.oracle.com
References: <200602100536.02893.ctpm@rnl.ist.utl.pt> <20060210064612.GE12046@ca-server1.us.oracle.com>
In-Reply-To: <20060210064612.GE12046@ca-server1.us.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602110540.57573.ctpm@rnl.ist.utl.pt>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Friday 10 February 2006 06:46, Mark Fasheh wrote:
> Great. We'll keep things simple at first. If I could get a copy of the
> /etc/ocfs2/cluster.conf files from each node that'd be great. A full log of
> the OCFS2 messages you see on each node, starting from mount to unmount
> would also help. That includes any dlm_* messages - in particular the ones
> printed when a node mounts and unmounts. If you're using any mount options
> it'd be helpful to know those too.

 Hi again,

This is my /etc/ocfs2/cluster.conf on every node:

cluster:
        node_count = 3
        name = oratest

node:
        ip_port = 7777
        ip_address = 192.168.100.30
        number = 0
        name = iscsi-teste
        cluster = oratest

node:
        ip_port = 7777
        ip_address = 192.168.100.31
        number = 1
        name = orateste1
        cluster = oratest

node:
        ip_port = 7777
        ip_address = 192.168.100.32
        number = 2
        name = orateste2
        cluster = oratest

------------------------------------------

 So today I rebooted the machines and started over and formatted the volume 
again from node 0 with 

iscsi-teste:~# mkfs.ocfs2 -b 4K -C 64K -N 4 -L OCFSTest1 /dev/sda
mkfs.ocfs2 1.1.5
Filesystem label=OCFSTest1
Block size=4096 (bits=12)
Cluster size=65536 (bits=16)
Volume size=2489995755520 (37994320 clusters) (607909120 blocks)
1178 cluster groups (tail covers 29008 clusters, rest cover 32256 clusters)
Journal size=33554432
Initial number of node slots: 4
WARNING: bitmap is very large, consider using a larger cluster size and/or
a smaller volume
Creating bitmaps: done
Initializing superblock: done
Writing system files: done
Writing superblock: done
Writing lost+found: done
mkfs.ocfs2 successful


 (By the way, I didn't use a bigger cluster size because we plan to use this 
fs to store mainly lots of small files)

 I then mounted the fs (with default options:rw,_netdev,heartbeat=local) on 
node 0 and node 2 and started the usual tests by creating, writing and 
copying files. 
 Later I also mounted the volume on node 1. By this time, node 0 and node 2 
showed completely different files on the same directory. After mounting, I 
could see on node 1 the files I had created from node 0 but not the ones 
created from node 2. After some more file tests I unmounted on all nodes and 
then remounted on all of them.

 I can get an interesting result by creating several large files from *node 0* 
and md5sum them; I list the same directory on node 2, the files are not 
visible there; so I also create several large files from *node 2*; then I 
md5sum the files I created from node 1 again and the md5sums are changed.
 So I think that node 2 was allocating and writing to space that was already 
allocated by node 0, overwriting files that were already there.
 I can reproduce this easily with any pair of nodes. Kernel messages follow 
for each node, though for most of the time there are no special error 
messages. In the end there are some on node 0, when I was copying files and 
extracting tarballs on all three nodes concurrently. I put the logs online to 
avoid upsetting lkml.

dmesg from iscsi-teste (node 0):
http://coyote.ist.utl.pt/ocfs2/dmesg_iscsi-teste.txt

dmesg from orateste1 (node 1):
http://coyote.ist.utl.pt/ocfs2/dmesg_orateste1.txt

dmesg from orateste2 (node 2):
http://coyote.ist.utl.pt/ocfs2/dmesg_orateste2.txt

 These are the logs from yesterday's tests, also with some interesting error 
messages on node 2 (the only difference yesterday was that I had the SCTP 
module loaded, but that doesn't seem to change the results):

http://coyote.ist.utl.pt/ocfs2/kern.log-iscsi-teste.txt
http://coyote.ist.utl.pt/ocfs2/kern.log-orateste1.txt
http://coyote.ist.utl.pt/ocfs2/kern.log-orateste2.txt

 And the kernel config files:

http://coyote.ist.utl.pt/ocfs2/config-2.6.16-rc2-git3-XEON.txt
http://coyote.ist.utl.pt/ocfs2/config-2.6.16-rc2-git3-AMD.txt

 If you need the files emailed to you just tell me. 
 Let me know if you need more tests/info.

 Thanks for the help.

Best regards

Claudio

