Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932423AbWBMPJG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932423AbWBMPJG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 10:09:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932424AbWBMPJF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 10:09:05 -0500
Received: from [202.149.212.34] ([202.149.212.34]:41832 "EHLO cmie.com")
	by vger.kernel.org with ESMTP id S932423AbWBMPJB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 10:09:01 -0500
Date: Mon, 13 Feb 2006 20:38:59 +0530 (IST)
From: Nohez <nohez@cmie.com>
X-X-Sender: nohez@moon.cmie.ernet.in
To: linux-kernel@vger.kernel.org
Subject: Re: OCFS2 Filesystem inconsistency across nodes
Message-ID: <Pine.LNX.4.58.0602132035010.3945@moon.cmie.ernet.in>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

We are testing OCFS2 on a 2 node cluster.  Both the nodes are Sun v40z
with OpenSuSE10.1 Beta3 (x86_64) installed (kernel-smp-2.6.16_rc2_git5-3)
OCFS2 version in OpenSuSE kernel is 1.1.7-SLES.  OCFS2 fences the
system with the default heartbeat threshold.  So heartbeat threshold
is configured to 31 on both the nodes (O2CB_HEARTBEAT_THRESHOLD=31).
Using Sun StorEdge 6920 for shared storage. Have also setup multipath
on both the nodes. Formatted a 200GB shared volume with the following
command:

    mkfs.ocfs2 -b 4K -C 32K -N 4 -L Raid5 /dev/mapper/3600015d00004b200000000000000050e-part1

Performed the following 2 tests:

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Test1
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Mounted the formatted partition on both the nodes.
    sun5:~ # mount /dev/mapper/3600015d00004b200000000000000050e-part1 /raid5 -t ocfs2
    sun4:~ # mount /dev/mapper/3600015d00004b200000000000000050e-part1 /raid5 -t ocfs2

Created a tar file on Sun5.
    sun5:~ # tar cvf /raid5/test.tar /etc

File viewable on both the nodes.
    sun5:~ # ls -l /raid5/test.tar
    -rw-r--r-- 1 root root 21749760 Feb 13 19:57 /raid5/test.tar
    sun4:~ # ls -l /raid5/test.tar
    -rw-r--r-- 1 root root 21749760 Feb 13 19:57 /raid5/test.tar

Created a file on sun4 using touch. 
    sun4:~ # touch /raid5/abcd
    touch: cannot touch `/raid5/abcd': Input/output error

OCFS2 marks the filesystem read only on sun4. Relevant messages from
/var/log/messages of sun4:

<----------------------------------------------------------->
<Sun4 /var/log/messages>
<----------------------------------------------------------->
Feb 13 19:56:18 sun4 klogd: (4200,0):o2net_set_nn_state:418 connected to node sun5 (num 0) at 196.1.1.240:7777
Feb 13 19:56:22 sun4 klogd: OCFS2 1.1.7-SLES Mon Jan 16 11:58:10 PST 2006 (build sles)
Feb 13 19:56:22 sun4 klogd: (4784,3):ocfs2_initialize_super:1379 max_slots for this device: 4
Feb 13 19:56:22 sun4 klogd: (4784,3):ocfs2_fill_local_node_info:1044 I am node 2
Feb 13 19:56:22 sun4 klogd: (4784,3):__dlm_print_nodes:384 Nodes in my domain ("2FC845E5792045B198E42561E9A0C405"):
Feb 13 19:56:22 sun4 klogd: (4784,3):__dlm_print_nodes:388  node 0
Feb 13 19:56:22 sun4 klogd: (4784,3):__dlm_print_nodes:388  node 2
Feb 13 19:56:22 sun4 klogd: (4784,3):ocfs2_find_slot:267 taking node slot 1
Feb 13 19:56:22 sun4 klogd: kjournald starting.  Commit interval 5 seconds
Feb 13 19:56:22 sun4 klogd: ocfs2: Mounting device (253,4) on (node 2, slot 1)
Feb 13 19:58:30 sun4 klogd: OCFS2: ERROR (device dm-4): ocfs2_search_chain: Group Descriptor # 4485090715960753726 has bad signature >>>>>>>
Feb 13 19:58:30 sun4 klogd: File system is now read-only due to the potential of on-disk corruption. Please run fsck.ocfs2 once the file system is unmounted.
Feb 13 19:58:30 sun4 klogd: (4890,0):ocfs2_claim_suballoc_bits:1157 ERROR: status = -5
Feb 13 19:58:30 sun4 klogd: (4890,0):ocfs2_claim_new_inode:1255 ERROR: status = -5
Feb 13 19:58:30 sun4 klogd: (4890,0):ocfs2_mknod_locked:479 ERROR: status = -5
Feb 13 19:58:30 sun4 klogd: (4890,0):ocfs2_mknod:384 ERROR: status = -5
<----------------------------------------------------------->

<----------------------------------------------------------->
<Sun5 /var/log/messages>
<----------------------------------------------------------->
Feb 13 19:56:03 sun5 klogd: OCFS2 1.1.7-SLES Mon Jan 16 11:58:10 PST 2006 (build sles)
Feb 13 19:56:03 sun5 klogd: (4914,2):ocfs2_initialize_super:1379 max_slots for this device: 4
Feb 13 19:56:03 sun5 klogd: (4914,2):ocfs2_fill_local_node_info:1044 I am node 0
Feb 13 19:56:03 sun5 klogd: (4914,2):__dlm_print_nodes:384 Nodes in my domain ("2FC845E5792045B198E42561E9A0C405"):
Feb 13 19:56:03 sun5 klogd: (4914,2):__dlm_print_nodes:388  node 0
Feb 13 19:56:03 sun5 klogd: (4914,2):ocfs2_find_slot:267 taking node slot 0
Feb 13 19:56:03 sun5 klogd: kjournald starting.  Commit interval 5 seconds
Feb 13 19:56:03 sun5 klogd: ocfs2: Mounting device (253,5) on (node 0, slot 0)
Feb 13 19:56:18 sun5 klogd: (4198,0):o2net_set_nn_state:418 accepted connection from node sun4 (num 2) at 196.1.1.229:7777
Feb 13 19:56:22 sun5 klogd: (4198,0):__dlm_print_nodes:384 Nodes in my domain ("2FC845E5792045B198E42561E9A0C405"):
Feb 13 19:56:22 sun5 klogd: (4198,0):__dlm_print_nodes:388  node 0
Feb 13 19:56:22 sun5 klogd: (4198,0):__dlm_print_nodes:388  node 2
<----------------------------------------------------------->




~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Test 2
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Mounted the formatted partition on both the nodes.
This time mounted it first on Sun4 and then on Sun5
    sun4:~ # mount /dev/mapper/3600015d00004b200000000000000050e-part1 /raid5 -t ocfs2
    sun5:~ # mount /dev/mapper/3600015d00004b200000000000000050e-part1 /raid5 -t ocfs2

Created 2 files:
    sun4:~ # touch /raid5/abcd
    sun4:~ # touch /raid5/abcd1

Files viewable on both the nodes.
    sun4:~ # ls -l /raid5/abcd*
    -rw-r--r-- 1 root root 0 Feb 13 20:20 /raid5/abcd
    -rw-r--r-- 1 root root 0 Feb 13 20:20 /raid5/abcd1

    sun5:~ # ls -l /raid5/abcd*
    -rw-r--r-- 1 root root 0 Feb 13 20:20 /raid5/abcd
    -rw-r--r-- 1 root root 0 Feb 13 20:20 /raid5/abcd1

Issued "rm" command on Sun5.
    sun5:~ # rm /raid5/abcd
    sun5:~ # rm /raid5/abcd1

    sun5:~ # ls -l /raid5/abcd*
    /bin/ls: /raid5/abcd*: No such file or directory

This time no error message on Sun5. However files exist on Sun4

    sun4:~ # ls -l /raid5/abcd*
    -rw-r--r-- 1 root root 0 Feb 13 20:20 /raid5/abcd
    -rw-r--r-- 1 root root 0 Feb 13 20:20 /raid5/abcd1

Sun4 kernel reports the following:

<----------------------------------------------------------->
<Sun4 /var/log/messages>
<----------------------------------------------------------->
Feb 13 20:20:18 sun4 klogd: OCFS2 1.1.7-SLES Mon Jan 16 11:58:10 PST 2006 (build sles)
Feb 13 20:20:18 sun4 klogd: (4774,0):ocfs2_initialize_super:1379 max_slots for this device: 4
Feb 13 20:20:18 sun4 klogd: (4774,0):ocfs2_fill_local_node_info:1044 I am node 2
Feb 13 20:20:18 sun4 klogd: (4774,0):__dlm_print_nodes:384 Nodes in my domain ("2FC845E5792045B198E42561E9A0C405"):
Feb 13 20:20:18 sun4 klogd: (4774,0):__dlm_print_nodes:388  node 2
Feb 13 20:20:18 sun4 klogd: (4774,0):ocfs2_find_slot:267 taking node slot 0
Feb 13 20:20:18 sun4 klogd: kjournald starting.  Commit interval 5 seconds
Feb 13 20:20:18 sun4 klogd: ocfs2: Mounting device (253,3) on (node 2, slot 0)
Feb 13 20:20:28 sun4 klogd: (4235,0):o2net_set_nn_state:418 connected to node sun5 (num 0) at 196.1.1.240:7777
Feb 13 20:20:32 sun4 klogd: (4235,0):__dlm_print_nodes:384 Nodes in my domain ("2FC845E5792045B198E42561E9A0C405"):
Feb 13 20:20:32 sun4 klogd: (4235,0):__dlm_print_nodes:388  node 0
Feb 13 20:20:32 sun4 klogd: (4235,0):__dlm_print_nodes:388  node 2
<----------------------------------------------------------->

<----------------------------------------------------------->
<Sun5 /var/log/messages>
<----------------------------------------------------------->
Feb 13 20:20:28 sun5 klogd: (4310,0):o2net_set_nn_state:418 accepted connection from node sun4 (num 2) at 196.1.1.229:7777
Feb 13 20:20:32 sun5 klogd: OCFS2 1.1.7-SLES Mon Jan 16 11:58:10 PST 2006 (build sles)
Feb 13 20:20:32 sun5 klogd: (5284,0):ocfs2_initialize_super:1379 max_slots for this device: 4
Feb 13 20:20:32 sun5 klogd: (5284,2):ocfs2_fill_local_node_info:1044 I am node 0
Feb 13 20:20:32 sun5 klogd: (5284,2):__dlm_print_nodes:384 Nodes in my domain ("2FC845E5792045B198E42561E9A0C405"):
Feb 13 20:20:32 sun5 klogd: (5284,2):__dlm_print_nodes:388  node 0
Feb 13 20:20:32 sun5 klogd: (5284,2):__dlm_print_nodes:388  node 2
Feb 13 20:20:32 sun5 klogd: (5284,2):ocfs2_find_slot:267 taking node slot 1
Feb 13 20:20:32 sun5 klogd: kjournald starting.  Commit interval 5 seconds
Feb 13 20:20:32 sun5 klogd: ocfs2: Mounting device (253,5) on (node 0, slot 1)
<----------------------------------------------------------->

Filesystem is in read-write mode on both the nodes.

Unmounted filesystem on Sun4 and remounted. 
    sun4:~ # umount /raid5
    sun4:~ # mount /dev/mapper/3600015d00004b200000000000000050e-part1 /raid5 -t ocfs2
    sun4:~ # ls -l /raid5/abcd*
    /bin/ls: /raid5/abcd*: No such file or directory

Now the filesystems are in sync on both the nodes. 

~~~~~~~~~~~~~~~~~~~~~~~
/etc/cluster/ocfs2.conf (conf file same on both the servers,
                         sun1 mentioned in conf file is not powered on)
~~~~~~~~~~~~~~~~~~~~~~~
node:
        ip_port = 7777
        ip_address = 196.1.1.240
        number = 0
        name = sun5
        cluster = ocfs2

node:
        ip_port = 7777
        ip_address = 196.1.1.118
        number = 1
        name = sun1
        cluster = ocfs2

node:
        ip_port = 7777
        ip_address = 196.1.1.229
        number = 2
        name = sun4
        cluster = ocfs2

cluster:
        node_count = 3
        name = ocfs2
~~~~~~~~~~~~~~~~~~~~~~~

Regards

Nohez
