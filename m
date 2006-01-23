Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964775AbWAWUnI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964775AbWAWUnI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 15:43:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964937AbWAWUnH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 15:43:07 -0500
Received: from 1-1-12-13a.han.sth.bostream.se ([82.182.30.168]:48052 "EHLO
	palpatine.hardeman.nu") by vger.kernel.org with ESMTP
	id S964775AbWAWUnF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 15:43:05 -0500
Cc: dhowells@redhat.com, david@2gen.com
Subject: [PATCH 00/04] Add DSA key type
In-Reply-To: <20060123173208.GA23964@2gen.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 23 Jan 2006 21:42:32 +0100
Message-Id: <11380489522362@2gen.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Reply-To: David =?iso-8859-1?Q?H=E4rdeman?= <david@2gen.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
From: David =?iso-8859-1?Q?H=E4rdeman?= <david@2gen.com>
X-SA-Score: -0.8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


david@hardeman.nu, dhowells@redhat.com, david@2gen.com
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
in coredumps.

The patch is split into four sub-patches:

1) Adds the multi-precision-integer maths library which was originally taken
   from GnuPG and ported to the kernel by David Howells in 2004
   (http://people.redhat.com/~dhowells/modsign/modsign-269rc4mm1-2.diff.bz2)

2) Adds dsa cryptographic operations. Since a dsa signature is always two 
   160-bit integer, I've modeled the dsa crypto as a hash algorithm.

3) Changes the keyctl syscall to accept six arguments (is it valid to do so?)
   and adds encryption as one of the supported ops for in-kernel keys.

4) Adds the dsa in-kernel key type.

This is quite some lines of code and may be controversial, so I've donned my
finest asbestos underwear.

Regards,
David Härdeman <david@2gen.com>


 crypto/Kconfig                    |   15 
 crypto/Makefile                   |    2 
 crypto/dsa.c                      |  230 +++++
 crypto/mpi/Makefile               |   31 
 crypto/mpi/generic_mpi-asm-defs.h |   10 
 crypto/mpi/generic_mpih-add1.c    |   65 +
 crypto/mpi/generic_mpih-lshift.c  |   66 +
 crypto/mpi/generic_mpih-mul1.c    |   60 +
 crypto/mpi/generic_mpih-mul2.c    |   63 +
 crypto/mpi/generic_mpih-mul3.c    |   64 +
 crypto/mpi/generic_mpih-rshift.c  |   66 +
 crypto/mpi/generic_mpih-sub1.c    |   63 +
 crypto/mpi/generic_udiv-w-sdiv.c  |  108 ++
 crypto/mpi/longlong.h             | 1502 ++++++++++++++++++++++++++++++++++++++
 crypto/mpi/mpi-add.c              |  247 ++++++
 crypto/mpi/mpi-bit.c              |  255 ++++++
 crypto/mpi/mpi-cmp.c              |   72 +
 crypto/mpi/mpi-div.c              |  350 ++++++++
 crypto/mpi/mpi-gcd.c              |   62 +
 crypto/mpi/mpi-inline.c           |   32 
 crypto/mpi/mpi-inline.h           |  128 +++
 crypto/mpi/mpi-internal.h         |  265 ++++++
 crypto/mpi/mpi-inv.c              |  190 ++++
 crypto/mpi/mpi-mpow.c             |  138 +++
 crypto/mpi/mpi-mul.c              |  203 +++++
 crypto/mpi/mpi-pow.c              |  325 ++++++++
 crypto/mpi/mpi-scan.c             |  143 +++
 crypto/mpi/mpicoder.c             |  390 +++++++++
 crypto/mpi/mpih-cmp.c             |   59 +
 crypto/mpi/mpih-div.c             |  548 +++++++++++++
 crypto/mpi/mpih-mul.c             |  545 +++++++++++++
 crypto/mpi/mpiutil.c              |  237 +++++
 include/linux/compat.h            |    4 
 include/linux/dsa.h               |   39 
 include/linux/key.h               |   11 
 include/linux/keyctl.h            |    1 
 include/linux/mpi.h               |  154 +++
 include/linux/syscalls.h          |    5 
 security/Kconfig                  |    8 
 security/keys/Makefile            |    1 
 security/keys/compat.c            |    9 
 security/keys/dsa_key.c           |  372 +++++++++
 security/keys/keyctl.c            |   72 +
 43 files changed, 7201 insertions(+), 9 deletions(-)
 

