Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272818AbRIGSeo>; Fri, 7 Sep 2001 14:34:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272819AbRIGSee>; Fri, 7 Sep 2001 14:34:34 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:12812 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S272818AbRIGSeY>; Fri, 7 Sep 2001 14:34:24 -0400
Message-ID: <3B991346.7393E7AF@zip.com.au>
Date: Fri, 07 Sep 2001 11:34:46 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.9-ac9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>,
        "ext3-users@redhat.com" <ext3-users@redhat.com>
Subject: ext3-2.4-0.9.9
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patches against 2.4.10-pre4 and 2.4.9-ac9 are at

	http://www.uow.edu.au/~andrewm/linux/ext3/

It's a fairly large change.  The most significant parts are

* the inclusion of Stephen's error-handling work, which is designed to 
  remount the fs read-only in the presence of software and hardware
  errors, rather than forcing a panic.

* Stephen's fix for the journal_revoke assertion failure which
  three people have reported.

There have been two reports of a possible interaction problem with vfat
where a readdir on the vfat mountpoint returns ENOTDIR when ext3 is
present in the kernel.  This has proved elusive and in fact has
been observed on systems where ext3 was never used.  It is probably
a vfat bug.

At the above website there is also a patch from Ted Ts'o which will
provide significant speedups for accessing large directories.  Ted's
equivalent patch for ext2 has already been incorporated into the
official kernel(s).  If possible, please test Ted's patch on top
of ext3 0.9.9.

Detailed changelog:


0.9.7
-----

- Merge in a large batch of changes to allow ext3 to recover gracefully
  from fatal errors.  If the fs is set to remount-readonly on error, then
  we should still be able to unwind cleanly and unmount the filesystem.

- Performance: don't write superblocks synchronously.  This reduces a
  bottleneck in the VM.

  Load the ext3 module with the parameter "do_sync_supers=1" to restore
  the previous behaviour.

- Performance: don't force a new transaction every time we sync (should
  prevent the writes previously happening every 5 seconds, allowing laptop
  drives to spin down again.)

0.9.8
-----

- Fix an NFS oops when doing a local delete on an active, nfs-exported
  file.

- Add proper log levels to a lot of kernel warnings when mounting a bad
  filesystem or a fs with errors

- Make sure we set the error flag both in the journal and fs superblocks
  on error (unless we're doing panic-on-error)

0.9.9
-----

- Fix the buffer-already-revoked assertion failure by looking up an
  aliased buffercache buffer and clearing the revoke bits in there as
  well as in the journalled data buffer.

- Reorganise page truncation code so we don't take the address of
  block_flushpage().  This is to simplify merging with Andrea's
  O_DIRECT patch, which turns block_flushpage() into a macro.


-
