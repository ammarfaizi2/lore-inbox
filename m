Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278105AbRJKFWq>; Thu, 11 Oct 2001 01:22:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278104AbRJKFWh>; Thu, 11 Oct 2001 01:22:37 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:38674 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S278100AbRJKFW2>; Thu, 11 Oct 2001 01:22:28 -0400
Message-ID: <3BC52CA6.71A8CC0@zip.com.au>
Date: Wed, 10 Oct 2001 22:22:46 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.10-ac7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>,
        "ext3-users@redhat.com" <ext3-users@redhat.com>
Subject: ext3 0.9.12 for 2.4.10-ac11
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

An ext3 update for Alan's latest kernel is at

	http://www.uow.edu.au/~andrewm/linux/ext3/

The version of ext3 in -ac kernels currently stands at 0.9.6, so
this is a fairly large diff.  However most of this code has had a
decent amount of external testing via the 0.9.9 patch.  The changelog
since 0.9.6 is below.

Please test it if you can, and all being well we shall ask Alan
to merge it a few days hence.

Most ext3 work at present is concentrating on -ac kernels.  The
change rate in Linus' kernels seems to have slowed now, so we'll 
try to get a 2.4.11 version of ext3 ready for next week.

There is a core kernel change in this diff which should be
described:

generic_file_write() has been altered so that it always calls
commit_write(), even if the copy_from_user() faulted. This change
is already present in Linus' kernel - it is a generic bugfix which
prevents leakage of stale disk data in rare circumstances.

lo_send() has also been changed so that it too calls commit_write()
if prepare_write() succeeded.

The net result is that all prepare_write()/commit_write() calls
are now balanced, so the abort_write() a_op (which was introduced
to cope with the perpare-but-no-commit error case) has been
removed.

This is an internal kernel API change!  All callers of prepare_write()
must now call commit_write() if the prepare_write() succeeded.


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

0.9.10
------

- Fix an oops which could occur at unmount time due to non-empty
  orphan list.  This could be triggered by an earlier error during a
  truncate.

- Merge Ted's directory scan speedup heuristic.

- Remove the abort_write() address_space_operation() by ensuring that
  all prepare_write() callers always call commit_write().

- A number of changes to suit the new 2.4.10 VM and buffer-layer design.

0.9.11
------

- Fix CONFIG_BUFFER_DEBUG builds

- Fix truncate deadlock

- Fix bmap oops on data-journaled filesystems

- Add MODULE_LICENSE tags

- Cleanup some error messages

0.9.12
------

- Fix oops in directory readahead on empty (ie. deleted) directories

- Handle new S_NOQUOTA flag for 2.4.10+ quota code

- Revert i_truncate_sem vs i_sem lock ordering to original design.  This
  fixes an obscure deadlock, but will deadlock 2.4.11's shmem.c.  It's safe
  with 2.4.10-ac11's shmem.c
