Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264844AbTFLPCS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 11:02:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264845AbTFLPCS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 11:02:18 -0400
Received: from pat.uio.no ([129.240.130.16]:1762 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S264844AbTFLPCF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 11:02:05 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16104.39193.319008.89100@charged.uio.no>
Date: Thu, 12 Jun 2003 08:15:37 -0700
To: maneesh@in.ibm.com
Cc: Andrew Morton <akpm@digeo.com>, LKML <linux-kernel@vger.kernel.org>,
       trond.myklebust@fys.uio.no
Subject: [patch] LIST_POISON with rcu
In-Reply-To: <20030612100126.GA1212@in.ibm.com>
References: <20030612100126.GA1212@in.ibm.com>
X-Mailer: VM 7.07 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning.
X-UiO-MailScanner: No virus found
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Maneesh Soni <maneesh@in.ibm.com> writes:

     > LIST_POISON will not work with RCU based lists as we depend on
     > the fact the deleted list element can still point to the
     > existing list.

Then you have a clear problem: you'll need some way of marking the
node as hashed or unhashed, other than testing those pointers.

     > Trond, I am not sure if you are seeing the d_move() oops
     > because of this. It will be nice if you can post the oops
     > message also.

The d_move Oops is not a direct consequence of the hlist_del_rcu
poisoning since d_drop now uses hlist_del_rcu_init. The effect is
the same though, as you can see below.

printing eip:
c019221c
*pde = 00000000
Oops: 0002 [#1]
CPU:    0
EIP:    0060:[<c019221c>]    Not tainted
EFLAGS: 00010246
EIP is at d_move+0x1e8/0x8b2
eax: 00000000   ebx: de8935c0   ecx: de893648 edx: 00000000
esi: de54129c   edi: d6414a80   ebp: d4b01e24  esp: d4b01de8
ds: 007b   es: 007b   ss: 0068
Process mv (pid: 1496, threadinfo=d4b00000 task=dacd1e80)
Stack: 14380000 3ee795f2 d9780000 3ee795f2 d9780000 d4b01e10 c01531b3 d6414b3c
       00000000 ffffffff d4b01e24 0005aad1 d4b01e40 de54129c d6414a80 d4b01e94
       e1a7f254 de8935c0 de54129c d6414a80 d4b01e78 00000002 73666e2e 32313030
Call Trace:
 [<c01531b3>] invalidate_inode_pages+0x21/0x26
 [<e1a7f254>] nfs_sillyrename+0x198/0x214 [nfs]
 [<e1a80585>] nfs_rename+0x41d/0x59c [nfs]
 [<c0185c86>] vfs_rename_other+0xd6/0xda
 [<c0185dcc>] vfs_rename+0x142/0x3a8
 [<c01861db>] sys_rename+0x1a9/0x1d6
 [<c017d0d7>] sys_lstat64+0x35/0x38
 [<c010bdd7>] syscall_call+0x7/0xb

Code: 89 02 74 03 89 50 04 c7 83 88 00 00 00 00 01 10 00 c7 41 04

Cheers,
  Trond
