Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261223AbVHAUO1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261223AbVHAUO1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 16:14:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261219AbVHAUMe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 16:12:34 -0400
Received: from pasta.sw.starentnetworks.com ([12.33.234.10]:17572 "EHLO
	pasta.sw.starentnetworks.com") by vger.kernel.org with ESMTP
	id S261210AbVHAUK1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 16:10:27 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17134.33198.777421.50923@cortez.sw.starentnetworks.com>
Date: Mon, 1 Aug 2005 16:10:22 -0400
From: Dave Johnson <djohnson+linux-kernel@sw.starentnetworks.com>
To: linux-kernel@vger.kernel.org
Subject: Fwd: [PATCH] memory leak in sys_sendmsg()/sys_recvmsg() with MSG_CMSG_COMPAT
In-Reply-To: <17130.36799.356429.894451@cortez.sw.starentnetworks.com>
References: <17130.36799.356429.894451@cortez.sw.starentnetworks.com>
X-Mailer: VM 7.07 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I found this bug while running under mips64, but it also effects
other 64bit architectures that have 32bit userspace compatibility.

I verified the problem exists with 2.6.12 on mips64 and x86_64.

Only kernels with CONFIG_COMPAT enabled should be effected (as
MSG_CMSG_COMPAT is defined as 0 otherwise).

Programs that make use of sendmsg/recvmsg with a large iovec will
cause the leak.  The below test program will cause a OOM DoS rather
quickly.

My original post to linux-mips mailing list follows.

-- 
Dave Johnson
Starent Networks

============

sendmsg()/recvmsg() syscalls from o32/n32 apps to a 64bit kernel will
cause a kernel memory leak if iov_len > UIO_FASTIOV for each syscall!

This is because both sys_sendmsg() and verify_compat_iovec() kmalloc a
new iovec structure.  Only the one from sys_sendmsg() is free'ed.

I wrote a simple test program to confirm this after identifying the
problem:

http://davej.org/programs/testsendmsg.c


Running it shows the leak in the slab:

$ grep '^size-256 ' /proc/slabinfo
size-256           55972  55972    280   14    1 : tunables   32   16    8 : slabdata   3998   3998      0 : globalstat   58914  55972  4001    3    0    0   46    0 : cpustat 3806737   4480 3755027    240
$ ./testsendmsg
iterations=100 vec_size=16 block_size=256
$ grep '^size-256 ' /proc/slabinfo
size-256           56168  56168    280   14    1 : tunables   32   16    8 : slabdata   4012   4012      0 : globalstat   59110  56168  4015    3    0    0   46    0 : cpustat 3853259   4494 3801362    240
$ ./testsendmsg
iterations=100 vec_size=16 block_size=256
$ grep '^size-256 ' /proc/slabinfo
size-256           56378  56378    280   14    1 : tunables   32   16    8 : slabdata   4027   4027      0 : globalstat   59320  56378  4030    3    0    0   46    0 : cpustat 3853910   4509 3801828    240
$ ./testsendmsg
iterations=100 vec_size=16 block_size=256
$ grep '^size-256 ' /proc/slabinfo
size-256           56574  56574    280   14    1 : tunables   32   16    8 : slabdata   4041   4041      0 : globalstat   59516  56574  4044    3    0    0   46    0 : cpustat 3854888   4523 3802620    240
$ ./testsendmsg
iterations=100 vec_size=16 block_size=256
$ grep '^size-256 ' /proc/slabinfo
size-256           56756  56756    280   14    1 : tunables   32   16    8 : slabdata   4054   4054      0 : globalstat   59698  56756  4057    3    0    0   46    0 : cpustat 3856397   4536 3803942    240
$ ./testsendmsg
iterations=100 vec_size=16 block_size=256
$ grep '^size-256 ' /proc/slabinfo
size-256           56966  56966    280   14    1 : tunables   32   16    8 : slabdata   4069   4069      0 : globalstat   59908  56966  4072    3    0    0   46    0 : cpustat 3858528   4551 3805888    240
$ ./testsendmsg
iterations=100 vec_size=16 block_size=256
$ grep '^size-256 ' /proc/slabinfo
size-256           57176  57176    280   14    1 : tunables   32   16    8 : slabdata   4084   4084      0 : globalstat   60118  57176  4087    3    0    0   46    0 : cpustat 3863987   4566 3811162    240
$ ./testsendmsg
iterations=100 vec_size=16 block_size=256
$ grep '^size-256 ' /proc/slabinfo
size-256           57358  57358    280   14    1 : tunables   32   16    8 : slabdata   4097   4097      0 : globalstat   60300  57358  4100    3    0    0   46    0 : cpustat 3864397   4579 3811385    240


Note that the below fix will break solaris_sendmsg()/solaris_recvmsg()
as it also calls verify_compat_iovec() but expects it to malloc
internally.

======================

diff -Nru a/net/compat.c b/net/compat.c
--- a/net/compat.c	2005-07-29 16:12:39 -04:00
+++ b/net/compat.c	2005-07-29 16:12:39 -04:00
@@ -91,20 +91,11 @@
 	} else
 		kern_msg->msg_name = NULL;
 
-	if(kern_msg->msg_iovlen > UIO_FASTIOV) {
-		kern_iov = kmalloc(kern_msg->msg_iovlen * sizeof(struct iovec),
-				   GFP_KERNEL);
-		if(!kern_iov)
-			return -ENOMEM;
-	}
-
 	tot_len = iov_from_user_compat_to_kern(kern_iov,
 					  (struct compat_iovec __user *)kern_msg->msg_iov,
 					  kern_msg->msg_iovlen);
 	if(tot_len >= 0)
 		kern_msg->msg_iov = kern_iov;
-	else if(kern_msg->msg_iovlen > UIO_FASTIOV)
-		kfree(kern_iov);
 
 	return tot_len;
 }

