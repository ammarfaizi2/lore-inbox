Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751188AbVIYGnR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751188AbVIYGnR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Sep 2005 02:43:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751189AbVIYGnR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Sep 2005 02:43:17 -0400
Received: from zproxy.gmail.com ([64.233.162.197]:32093 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751188AbVIYGnQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Sep 2005 02:43:16 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:user-agent:content-type:subject:message-id:date;
        b=kqeCiiHKYqZVO73UFZjr22oraQRDQ/flvX+X/DlXg2O7FEp6bfSO/VBYlCdA7CEFoFbuO7VdGvX5jTL73L4kJAinVhkg+OPte3HaJJKzfh/dXJC6fjwXQgv3qYp+nfusYSBawO6vZaM8PHbPDEEsddzfI5438pgyaH5A47MunJU=
From: Tejun Heo <htejun@gmail.com>
To: zwane@linuxpower.ca, viro@zeniv.linux.org.uk
Cc: linux-kernel@vger.kernel.org
User-Agent: lksp 0.3
Content-Type: text/plain; charset=US-ASCII
Subject: [PATCH linux-2.6 00/04] brsem: [RFC] big reader semaphore
Message-ID: <20050925064218.E7558977@htj.dyndns.org>
Date: Sun, 25 Sep 2005 15:43:07 +0900 (KST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Hello, guys.

 This patchset implements brsem - big reader semaphore.  This is
similar to the late big reader lock in its concept.  Reader side tries
to do as little as possible while writer side takes over all the
overhead.  brsem is to be used for cases where...

 a. writer operation is *extremely* rare compared to read ops

 b. both readers and writers should be able to sleep

 c. stale data or reader-side retry is impossible or impractical

 Device or subsystem hotplug/unplug synchronization fits very well to
above criteria.  Plugging and unplugging occur very rarely but they
still need stringent synchronization.

 brsem is implemented while trying to solve the following race
condition in the vfs layer.

 super->s_umount rwsem proctects filesystem unmounts and remounts
against other operations.  When remounting a rw filesystem ro, after
write-locking s_umount, do_remount_sb() is invoked, which scans all
open files and either refuses to remount or bang all write-open files
depending on force argument.  After that, the filesystem is remounted
ro.

 The problem is that a file can be opened rw after all open files are
scanned but before the filesystem is remounted ro.  This can be easily
exposed by adding msleep(2000) between open file scan and remount_fs()
and doing the following in the user space.  An ext2 fs is mounted on
tmp.

# mount -o remount,ro tmp& sleep 1; cat >> tmp/asdf

 This leaves us with a write-opened file on a ro filesystem.  ext2
happily writes data to disk.  I've only verified open(2) but this race
probably exists for other file operations, too.

 I'll post a patch to add 2s sleep during remounting and test results
in a reply to this mail.

  The solution is to make permission check and the rest of open atomic
against remounting by read-locking s_umount rwsem.  This probably
should be done for most file operations including write(2) (maybe even
when committing dirty pages to fs for rw-mmapped files in 'force'
case).  This is an expensive overhead to pay for such rare cases and
seqlock / rcupdate cannot be used here.

 So, brsem is implemented.  Read locking and unlocking involve only
local_bh_disable/enable, a few local arithmetics and conditionals - no
atomic ops, no shared word, no memory barrier.  Writer operations are
*very* expensive.  They have to issue workqueue works to each cpu
using smp_call_function and wait for them.

 This patchset also converts cpucontrol semaphore which protects cpu
hotplug/unplugging events, which obviously occur very rarely.

[ Start of patch descriptions ]

01_brsem_implement_brsem.patch
	: implement big reader semaphore

	This patch implements big reader semaphore - a rwsem with very
	cheap reader-side operations and very expensive writer-side
	operations.  For details, please read comments at the top of
	kern/brsem.c.

02_brsem_convert-s_umount-to-brsem.patch
	: convert super_block->s_umount to brsem

	Convert super_block->s_umount from rwsem to brsem.

03_brsem_fix-remount-open-race.patch
	: fix ro-remount <-> open race condition

	A file can be opened rw while ro-remounting is in progress
	resulting in open rw file on ro mounted filesystem.  This
	patch kills the race by making permission check and the rest
	of open atomic w.r.t. remounting.  Other file operations also
	have this race condition and should be fixed in similar
	manner.

04_brsem_convert-cpucontrol-to-brsem.patch
	: convert cpucontrol to brsem

	cpucontrol synchronizes cpu hotplugging and used to be a
	semaphore.  This patch converts it to brsem.

[ End of patch descriptions ]

 Thanks.

--
tejun

