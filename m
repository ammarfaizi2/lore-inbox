Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751437AbWAZV6b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751437AbWAZV6b (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 16:58:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751436AbWAZV6b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 16:58:31 -0500
Received: from 1-1-12-13a.han.sth.bostream.se ([82.182.30.168]:1986 "EHLO
	palpatine.hardeman.nu") by vger.kernel.org with ESMTP
	id S1751437AbWAZV63 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 16:58:29 -0500
Cc: dhowells@redhat.com, keyrings@linux-nfs.org, david@2gen.com
Subject: [PATCH 00/04] Add DSA key type
X-Mailer: gregkh_patchbomb
Date: Thu, 26 Jan 2006 22:58:14 +0100
Message-Id: <1138312694656@2gen.com>
Mime-Version: 1.0
Reply-To: David =?iso-8859-1?Q?H=E4rdeman?= <david@2gen.com>
Content-Type: text/plain; charset=utf-8
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
From: David =?iso-8859-1?Q?H=E4rdeman?= <david@2gen.com>
X-SA-Score: -0.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The following four patches add support for DSA keys to the in-kernel key 
management system. 

In-kernel dsa keys allows a process to use the request_key mechanism to 
request such keys on demand. One such example is a backup script that,
when done, could issue a request for an appropriate ssh key. The request
would then be forwarded by /sbin/request-key to the appropriate user who
could supply the key which is in turn used by the backup script to transfer
the results to a backup server. This allows for much more flexible and
interesting solutions than passwordless ssh key files or shared ssh
agents would ever be able to support. (I have a separate patch for 
openssh which allows ssh-add and ssh to work with in-kernel keys).

In addition, the in-kernel keys have the advantage of being non-ptraceable, 
will not be swapped out to disk, and does not run the risk of being included
in coredumps. The functionality added by these patches should also be 
interesting to some other security features (such as signed modules, signed
binaries and possibly some encrypted filesystems).

The patch is split into four sub-patches:

1) Adds a multi-precision-integer maths library

2) Adds dsa cryptographic operations. Since a dsa signature is always two 
   160-bit integer, I've modeled the dsa crypto as a hash algorithm.

3) Adds encryption as one of the supported ops for in-kernel keys.

4) Adds the dsa in-kernel key type.

This is the second version of these patches with the following changes from 
the first version:

* Make sure all functions have proper dsa_ prefixes
* Use kenter/kleave/kdebug in dsa_key.c instead of duplicated versions
* Let key type decide which locking to use for encrypt ops (semaphore or rcu)
* Add KERN_XXX levels for printk's
* Merge newer mpilib from Fedora kernel 2.6.15-1.1871_FC5
* Change some non-tab whitespace to tabs
* Change mpilib exports from EXPORT_SYMBOL to EXPORT_SYMBOL_GPL
* Change crypto/dsa.c to copy key instead of referencing it
* Add documentation

Regards,
David Härdeman

--
 Documentation/keys.txt            |   77 +
 crypto/Kconfig                    |   15 
 crypto/Makefile                   |    2 
 crypto/dsa.c                      |  265 ++++++
 crypto/mpi/Makefile               |   31 
 crypto/mpi/generic_mpi-asm-defs.h |   10 
 crypto/mpi/generic_mpih-add1.c    |   64 +
 crypto/mpi/generic_mpih-lshift.c  |   66 +
 crypto/mpi/generic_mpih-mul1.c    |   60 +
 crypto/mpi/generic_mpih-mul2.c    |   63 +
 crypto/mpi/generic_mpih-mul3.c    |   64 +
 crypto/mpi/generic_mpih-rshift.c  |   66 +
 crypto/mpi/generic_mpih-sub1.c    |   63 +
 crypto/mpi/generic_udiv-w-sdiv.c  |  108 ++
 crypto/mpi/longlong.h             | 1502 ++++++++++++++++++++++++++++++++++++++
 crypto/mpi/mpi-add.c              |  241 ++++++
 crypto/mpi/mpi-bit.c              |  240 ++++++
 crypto/mpi/mpi-cmp.c              |   70 +
 crypto/mpi/mpi-div.c              |  342 ++++++++
 crypto/mpi/mpi-gcd.c              |   62 +
 crypto/mpi/mpi-inline.c           |   32 
 crypto/mpi/mpi-inline.h           |  128 +++
 crypto/mpi/mpi-internal.h         |  265 ++++++
 crypto/mpi/mpi-inv.c              |  189 ++++
 crypto/mpi/mpi-mpow.c             |  136 +++
 crypto/mpi/mpi-mul.c              |  199 +++++
 crypto/mpi/mpi-pow.c              |  324 ++++++++
 crypto/mpi/mpi-scan.c             |  127 +++
 crypto/mpi/mpicoder.c             |  388 +++++++++
 crypto/mpi/mpih-cmp.c             |   58 +
 crypto/mpi/mpih-div.c             |  545 +++++++++++++
 crypto/mpi/mpih-mul.c             |  537 +++++++++++++
 crypto/mpi/mpiutil.c              |  224 +++++
 include/linux/compat.h            |    4 
 include/linux/dsa.h               |   33 
 include/linux/key.h               |   10 
 include/linux/keyctl.h            |    1 
 include/linux/mpi.h               |  154 +++
 include/linux/syscalls.h          |    5 
 security/Kconfig                  |    8 
 security/keys/Makefile            |    1 
 security/keys/compat.c            |    9 
 security/keys/dsa_key.c           |  376 +++++++++
 security/keys/keyctl.c            |   67 +
 44 files changed, 7221 insertions(+), 10 deletions(-)

