Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261190AbVGNMMm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261190AbVGNMMm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 08:12:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261211AbVGNMMm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 08:12:42 -0400
Received: from ppsw-9.csi.cam.ac.uk ([131.111.8.139]:30911 "EHLO
	ppsw-9.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S261190AbVGNMMg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 08:12:36 -0400
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Date: Thu, 14 Jul 2005 13:12:33 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net
Subject: [2.6-GIT] NTFS: Release 2.1.23.
Message-ID: <Pine.LNX.4.60.0507141310500.29098@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, please pull from

rsync://rsync.kernel.org/pub/scm/linux/kernel/git/aia21/ntfs-2.6.git/HEAD

This is a big NTFS update.  It was meant for as soon as 2.6.12 was released
but it was delayed due to the need for a patch I submitted to Andrew for -mm
to make it to the mainline kernel (which it has as of yesterday).

This update includes lots of fixes including a really nasty deadlock that with
recent kernels was triggered with 100% probability on umount of an NTFS volume
so it is important to go in before 2.6.13 is released.

Please apply.  Thanks!

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/, http://www-stu.christs.cam.ac.uk/~aia21/

This will update the following files:

 Documentation/filesystems/ntfs.txt |   29 +
 fs/ntfs/ChangeLog                  |  179 ++++++++-
 fs/ntfs/Makefile                   |    4 
 fs/ntfs/aops.c                     |  166 +++++---
 fs/ntfs/attrib.c                   |  630 +++++++++++++++++++++++++++++----
 fs/ntfs/attrib.h                   |   16 
 fs/ntfs/compress.c                 |   46 +-
 fs/ntfs/debug.c                    |   15 
 fs/ntfs/dir.c                      |   32 -
 fs/ntfs/file.c                     |    2 
 fs/ntfs/index.c                    |   16 
 fs/ntfs/inode.c                    |  530 ++++++++++++++--------------
 fs/ntfs/inode.h                    |    7 
 fs/ntfs/layout.h                   |   87 ++--
 fs/ntfs/lcnalloc.c                 |   72 +--
 fs/ntfs/logfile.c                  |   11 
 fs/ntfs/mft.c                      |  227 ++++++++----
 fs/ntfs/namei.c                    |   34 +
 fs/ntfs/ntfs.h                     |    8 
 fs/ntfs/runlist.c                  |  278 ++++++++++----
 fs/ntfs/runlist.h                  |   16 
 fs/ntfs/super.c                    |  692 ++++++++++++++++++++++++++++---------
 fs/ntfs/sysctl.c                   |    4 
 fs/ntfs/time.h                     |    4 
 fs/ntfs/types.h                    |   10 
 fs/ntfs/unistr.c                   |    2 
 fs/ntfs/usnjrnl.c                  |   84 ++++
 fs/ntfs/usnjrnl.h                  |  205 ++++++++++
 fs/ntfs/volume.h                   |   12 
 29 files changed, 2522 insertions(+), 896 deletions(-)

through these ChangeSets:

commit ba6d2377c85c9b8a793f455d8c9b6cf31985d70f
tree 21e65c76db693869c84864af02e91c4b997a6ba5
parent af859a42d798f047fbfe198ed315a942662c39d2
author Anton Altaparmakov <aia21@cantab.net> Sun, 26 Jun 2005 22:12:02 +0100
committer Anton Altaparmakov <aia21@cantab.net> Sun, 26 Jun 2005 22:12:02 +0100

    NTFS: Fix a nasty deadlock that appeared in recent kernels.
    The situation: VFS inode X on a mounted ntfs volume is dirty.  For
    same inode X, the ntfs_inode is dirty and thus corresponding on-disk
    inode, i.e. mft record, which is in a dirty PAGE_CACHE_PAGE belonging
    to the table of inodes, i.e. $MFT, inode 0.
    What happens:
    Process 1: sys_sync()/umount()/whatever...  calls
    __sync_single_inode() for $MFT -> do_writepages() -> write_page for
    the dirty page containing the on-disk inode X, the page is now locked
    -> ntfs_write_mst_block() which clears PageUptodate() on the page to
    prevent anyone else getting hold of it whilst it does the write out.
    This is necessary as the on-disk inode needs "fixups" applied before
    the write to disk which are removed again after the write and
    PageUptodate is then set again.  It then analyses the page looking
    for dirty on-disk inodes and when it finds one it calls
    ntfs_may_write_mft_record() to see if it is safe to write this
    on-disk inode.  This then calls ilookup5() to check if the
    corresponding VFS inode is in icache().  This in turn calls ifind()
    which waits on the inode lock via wait_on_inode whilst holding the
    global inode_lock.
    Process 2: pdflush results in a call to __sync_single_inode for the
    same VFS inode X on the ntfs volume.  This locks the inode (I_LOCK)
    then calls write-inode -> ntfs_write_inode -> map_mft_record() ->
    read_cache_page() for the page (in page cache of table of inodes
    $MFT, inode 0) containing the on-disk inode.  This page has
    PageUptodate() clear because of Process 1 (see above) so
    read_cache_page() blocks when it tries to take the page lock for the
    page so it can call ntfs_read_page().
    Thus Process 1 is holding the page lock on the page containing the
    on-disk inode X and it is waiting on the inode X to be unlocked in
    ifind() so it can write the page out and then unlock the page.
    And Process 2 is holding the inode lock on inode X and is waiting for
    the page to be unlocked so it can call ntfs_readpage() or discover
    that Process 1 set PageUptodate() again and use the page.
    Thus we have a deadlock due to ifind() waiting on the inode lock.
    The solution: The fix is to use the newly introduced
    ilookup5_nowait() which does not wait on the inode's lock and hence
    avoids the deadlock.  This is safe as we do not care about the VFS
    inode and only use the fact that it is in the VFS inode cache and the
    fact that the vfs and ntfs inodes are one struct in memory to find
    the ntfs inode in memory if present.  Also, the ntfs inode has its
    own locking so it does not matter if the vfs inode is locked.
    
    Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

commit af859a42d798f047fbfe198ed315a942662c39d2
tree 6c892cbd43284e98cc879f0518dde8efc09740c7
parent 4757d7dff65b56f2115038ad1615725f31806787
author Anton Altaparmakov <aia21@cantab.net> Sat, 25 Jun 2005 21:07:27 +0100
committer Anton Altaparmakov <aia21@cantab.net> Sat, 25 Jun 2005 21:07:27 +0100

    NTFS: Prepare for 2.1.23 release: Update documentation and bump version.
    
    Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

commit 4757d7dff65b56f2115038ad1615725f31806787
tree b4a17ecec51c9b1175a22513699ae97c099c5d63
parent fa3be92317c4ae34edcf5274e8bbeff181e20b7a
author Anton Altaparmakov <aia21@cantab.net> Sat, 25 Jun 2005 17:24:08 +0100
committer Anton Altaparmakov <aia21@cantab.net> Sat, 25 Jun 2005 17:24:08 +0100

    NTFS: Change ntfs_map_runlist_nolock() to only decompress the mapping pairs
    if the requested vcn is inside it.  Otherwise we get into problems
    when we try to map an out of bounds vcn because we then try to map
    the already mapped runlist fragment which causes
    ntfs_mapping_pairs_decompress() to fail and return error.  Update
    ntfs_attr_find_vcn_nolock() accordingly.
    
    Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

commit fa3be92317c4ae34edcf5274e8bbeff181e20b7a
tree 84ae4ace6c891aa95b804950283e1f8f3e46c730
parent 1d58b27b8d77ecb816cfa8f846b78c845675eb89
author Anton Altaparmakov <aia21@cantab.net> Sat, 25 Jun 2005 17:15:36 +0100
committer Anton Altaparmakov <aia21@cantab.net> Sat, 25 Jun 2005 17:15:36 +0100

    NTFS: Add an extra parameter @last_vcn to ntfs_get_size_for_mapping_pairs()
    and ntfs_mapping_pairs_build() to allow the runlist encoding to be
    partial which is desirable when filling holes in sparse attributes.
    Update all callers.
    
    Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

commit 1d58b27b8d77ecb816cfa8f846b78c845675eb89
tree 7c10e4182f87d00511aeb1d0583e3c09eeb807de
parent 3bd1f4a173a3445f9919c21e775de2d8b9deacf8
author Anton Altaparmakov <aia21@cantab.net> Sat, 25 Jun 2005 17:04:55 +0100
committer Anton Altaparmakov <aia21@cantab.net> Sat, 25 Jun 2005 17:04:55 +0100

    NTFS: Change the runlist terminator of the newly allocated cluster(s) to
    LCN_ENOENT in ntfs_attr_make_non_resident().  Otherwise the runlist
    code gets confused.
    
    Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

commit 3bd1f4a173a3445f9919c21e775de2d8b9deacf8
tree 6b32056b5b63d41fc5d032318ed0f94dbc562288
parent ca8fd7a0c6aa835e8014830b290cb965e85ac88e
author Anton Altaparmakov <aia21@cantab.net> Sat, 25 Jun 2005 16:51:58 +0100
committer Anton Altaparmakov <aia21@cantab.net> Sat, 25 Jun 2005 16:51:58 +0100

    NTFS: Fix several occurences of a bug where we would perform 'var & ~const'
    with a 64-bit variable and a int, i.e. 32-bit, constant.  This causes
    the higher order 32-bits of the 64-bit variable to be zeroed.  To fix
    this cast the 'const' to the same 64-bit type as 'var'.
    
    Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

commit ca8fd7a0c6aa835e8014830b290cb965e85ac88e
tree 504929d2a4beacb86fbc420c85f5c102f2a27fed
parent 9f993fe4634b39ca4404ba278053b03f360ec08a
author Anton Altaparmakov <aia21@cantab.net> Sat, 25 Jun 2005 16:31:27 +0100
committer Anton Altaparmakov <aia21@cantab.net> Sat, 25 Jun 2005 16:31:27 +0100

    NTFS: Detect the case when Windows has been suspended to disk on the volume
    to be mounted and if this is the case do not allow (re)mounting
    read-write.  This is done by parsing hiberfil.sys if present.
    
    Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

commit 9f993fe4634b39ca4404ba278053b03f360ec08a
tree 36e62a3d384fa9c313cacd73b7aea086d7f74e82
parent 3f2faef00c6af17542ea8672ed7d09367222b2d0
author Anton Altaparmakov <aia21@cantab.net> Sat, 25 Jun 2005 16:15:36 +0100
committer Anton Altaparmakov <aia21@cantab.net> Sat, 25 Jun 2005 16:15:36 +0100

    NTFS: Fix a bug in address space operations error recovery code paths where
    if the runlist was not mapped at all and a mapping error occured we
    would leave the runlist locked on exit to the function so that the
    next access to the same file would try to take the lock and deadlock.
    
    Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

commit 3f2faef00c6af17542ea8672ed7d09367222b2d0
tree 8b5cf2d76f2af684988d79b04e21ae92aaea8711
parent 38b22b6e9f46ab8f73ef5734f0e0a000766a9258
author Anton Altaparmakov <aia21@cantab.net> Sat, 25 Jun 2005 15:28:56 +0100
committer Anton Altaparmakov <aia21@cantab.net> Sat, 25 Jun 2005 15:28:56 +0100

    NTFS: Stamp the transaction log ($UsnJrnl), aka user space journal, if it
    is active on the volume and we are mounting read-write or remounting
    from read-only to read-write.
    
    Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

commit 442d207eb0b4e7047c4fedccd900c425e689d502
tree 2c23dc98fba6912417164ba65b258a9da1241ae1
parent 2fb21db2548fc8b196eb8d8425f05ee1965d5344
author Anton Altaparmakov <aia21@cantab.net> Fri, 27 May 2005 16:42:56 +0100
committer Anton Altaparmakov <aia21@cantab.net> Fri, 27 May 2005 16:42:56 +0100

    NTFS: Use C99 style structure initialization after memory allocation where
    possible (fs/ntfs/{attrib.c,index.c,super.c}).  Thanks to Al Viro and
    Pekka Enberg.
    
    Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

commit 2fb21db2548fc8b196eb8d8425f05ee1965d5344
tree b319e97bfb3e50bcde9a82cf089d86a7dcb03df5
parent 5eac51462f340b7c4a03b9220cf157c40b4990a5
author Pekka Enberg <penberg@cs.helsinki.fi> Wed, 25 May 2005 21:15:34 +0300
committer Anton Altaparmakov <aia21@cantab.net> Fri, 27 May 2005 16:00:53 +0100

    NTFS: Remove spurious void pointer casts from fs/ntfs/.
    
    Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
    Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

commit d53ee3222459f347cb18985a845864bc81a44eaf
tree e9f8a061e958579a6de1d3ee133fd30ca4139f9c
parent 7fafb8b634121f4fa35ff92f85737f8bc2259f06
author Anton Altaparmakov <aia21@cantab.net> Wed, 06 Apr 2005 16:11:20 +0100
committer Anton Altaparmakov <aia21@cantab.net> Thu, 05 May 2005 11:49:42 +0100

    NTFS: Use MAX_BUF_PER_PAGE instead of variable sized array allocation for
    better code generation and one less sparse warning in fs/ntfs/aops.c.
    
    Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

commit 7fafb8b634121f4fa35ff92f85737f8bc2259f06
tree ed581b567781b6b2a99a9f2059e3f3c324a0c928
parent bb3cf33509009132cf8c7a7729f9d26c0c5fa961
author Anton Altaparmakov <aia21@cantab.net> Wed, 06 Apr 2005 16:09:21 +0100
committer Anton Altaparmakov <aia21@cantab.net> Thu, 05 May 2005 11:48:00 +0100

    NTFS: Minor cleanup: Define and use NTFS_MAX_CLUSTER_SIZE constant instead
    of hard coded 0x10000 in fs/ntfs/super.c.
    
    Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

commit bb3cf33509009132cf8c7a7729f9d26c0c5fa961
tree 1e5a6a8bdf12e158a792b26b1d24b1743ce8a975
parent b0d2374d62faed034dd80e6524efb98a6341597c
author Anton Altaparmakov <aia21@cantab.net> Wed, 06 Apr 2005 13:34:31 +0100
committer Anton Altaparmakov <aia21@cantab.net> Thu, 05 May 2005 11:46:17 +0100

    NTFS: Update attribute definition handling.
    
    Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

commit b0d2374d62faed034dd80e6524efb98a6341597c
tree 99ae91efcc90ead7b8aa1cc44f286a528adc6545
parent 251c8427c9c418674fc3c04a11de95dc3661b560
author Anton Altaparmakov <aia21@cantab.net> Mon, 04 Apr 2005 16:20:14 +0100
committer Anton Altaparmakov <aia21@cantab.net> Thu, 05 May 2005 11:44:41 +0100

    NTFS: Some utilities modify the boot sector but do not update the checksum.
    Thus, relax the checking in fs/ntfs/super.c::is_boot_sector_ntfs() to
    only emit a warning when the checksum is incorrect rather than
    refusing the mount.  Thanks to Bernd Casimir for pointing this
    problem out.
    
    Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

commit 251c8427c9c418674fc3c04a11de95dc3661b560
tree b67bab32762a4a64083de64281b1249bccfd9402
parent 53d59aad9326199ef5749c97513db498309a057e
author Jesper Juhl <juhl-lkml@dif.dk> Mon, 04 Apr 2005 14:59:56 +0100
committer Anton Altaparmakov <aia21@cantab.net> Thu, 05 May 2005 11:42:27 +0100

    NTFS: Remove checks for NULL before calling kfree() since kfree() does the
    checking itself.  (Jesper Juhl)
    
    Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>
    Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

commit 53d59aad9326199ef5749c97513db498309a057e
tree 3fc3e99673cf5c5c8f275cca1ec7ed2dfe5fa192
parent 1ef334d372d6a7006e20f56f7e85d8f4ec32e3c2
author Anton Altaparmakov <aia21@cantab.net> Thu, 17 Mar 2005 10:51:33 +0000
committer Anton Altaparmakov <aia21@cantab.net> Thu, 05 May 2005 11:39:30 +0100

    NTFS: Fix compilation when configured read-only.
    
    - Add ifdef NTFS_RW around write specific code if fs/ntfs/runlist.[hc] and
    fs/ntfs/attrib.[hc].
    - Minor bugfix to fs/ntfs/attrib.c::ntfs_attr_make_non_resident() where the
    runlist was not freed in all error cases.
    - Add fs/ntfs/runlist.[hc]::ntfs_rl_find_vcn_nolock().
    
    Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

commit 1ef334d372d6a7006e20f56f7e85d8f4ec32e3c2
tree 5b03ef9048fec32ebd7b1d75686b1dc73599c661
parent 905685f68fc72844b8c2689c39a5c6c35e840152
author Anton Altaparmakov <aia21@cantab.net> Mon, 04 Apr 2005 14:59:42 +0100
committer Anton Altaparmakov <aia21@cantab.net> Thu, 05 May 2005 11:27:45 +0100

    NTFS: Include linux/swap.h in fs/ntfs/attrib.c for mark_page_accessed().
    
    Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

commit 905685f68fc72844b8c2689c39a5c6c35e840152
tree 0ff1d145a7771b24643c1b685ecbb3f791cda6fb
parent 43b01fda8b17b2b63e7dcdeed11c2ebba56b1fc9
author Anton Altaparmakov <aia21@cantab.net> Thu, 10 Mar 2005 11:06:19 +0000
committer Anton Altaparmakov <aia21@cantab.net> Thu, 05 May 2005 11:26:01 +0100

    NTFS: - Modify ->readpage and ->writepage (fs/ntfs/aops.c) so they detect
    and handle the case where an attribute is converted from resident
    to non-resident by a concurrent file write.
    - Reorder some operations when converting an attribute from resident
    to non-resident (fs/ntfs/attrib.c) so it is safe wrt concurrent
    ->readpage and ->writepage.
    
    Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

commit 43b01fda8b17b2b63e7dcdeed11c2ebba56b1fc9
tree fd925e409efa2787469689180afa78152947c4a0
parent 2bfb4fff3e9731ecfe745881e53cfb2e646c47bb
author Anton Altaparmakov <aia21@cantab.net> Wed, 09 Mar 2005 15:18:43 +0000
committer Anton Altaparmakov <aia21@cantab.net> Thu, 05 May 2005 11:23:20 +0100

    NTFS: Fix sign of various error return values to be negative in
    fs/ntfs/lcnalloc.c.
    
    Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

commit 2bfb4fff3e9731ecfe745881e53cfb2e646c47bb
tree a607df8a7d0532803584dab19bf13b69acbb668d
parent c0c1cc0e46b36347f11b566f99087dc5e6fc1b89
author Anton Altaparmakov <aia21@cantab.net> Wed, 09 Mar 2005 15:15:06 +0000
committer Anton Altaparmakov <aia21@cantab.net> Thu, 05 May 2005 11:22:07 +0100

    NTFS: Add fs/ntfs/attrib.[hc]::ntfs_attr_make_non_resident().
    
    Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

commit c0c1cc0e46b36347f11b566f99087dc5e6fc1b89
tree 773105bdde7454d10dccc127048a9847f7e01f11
parent 271849a98849394ea85fa7caa8a1aaa2b3a849b7
author Anton Altaparmakov <aia21@cantab.net> Mon, 07 Mar 2005 21:43:38 +0000
committer Anton Altaparmakov <aia21@cantab.net> Thu, 05 May 2005 11:20:49 +0100

    NTFS: - Fix bug in fs/ntfs/attrib.c::ntfs_find_vcn_nolock() where after
    dropping the read lock and taking the write lock we were not checking
    whether someone else did not already do the work we wanted to do.
    - Rename ntfs_find_vcn_nolock() to ntfs_attr_find_vcn_nolock().
    - Tidy up some comments in fs/ntfs/runlist.c.
    - Add LCN_ENOMEM and LCN_EIO definitions to fs/ntfs/runlist.h.
    
    Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

commit 271849a98849394ea85fa7caa8a1aaa2b3a849b7
tree 08e932656e463845faaa3610059c67e16aa92b7d
parent 7e693073a940c7484c0c21e3e1603e29ce46f30c
author Anton Altaparmakov <aia21@cantab.net> Mon, 07 Mar 2005 21:36:18 +0000
committer Anton Altaparmakov <aia21@cantab.net> Thu, 05 May 2005 11:18:43 +0100

    NTFS: Add fs/ntfs/attrib.[hc]::ntfs_attr_vcn_to_lcn_nolock() used by the new
    write code.
    
    Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

commit 7e693073a940c7484c0c21e3e1603e29ce46f30c
tree 865f7c9374fd2c4f072c17b97aff2225bfc06a75
parent 9451f8519c5e6d5d064c30033fc3d4ce77de321c
author Anton Altaparmakov <aia21@cantab.net> Thu, 03 Mar 2005 16:38:59 +0000
committer Anton Altaparmakov <aia21@cantab.net> Thu, 05 May 2005 11:17:08 +0100

    NTFS: Add AT_EA in addition to AT_DATA to whitelist for being allowed to be
    non-resident in fs/ntfs/attrib.c::ntfs_attr_can_be_non_resident().
    
    Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

commit 9451f8519c5e6d5d064c30033fc3d4ce77de321c
tree 104eedf065c4091838a27f6e674875a035c30820
parent 413826868fb49d200b741bcaeaf58ea5c5e45321
author Anton Altaparmakov <aia21@cantab.net> Thu, 03 Mar 2005 14:43:43 +0000
committer Anton Altaparmakov <aia21@cantab.net> Thu, 05 May 2005 11:15:46 +0100

    NTFS: Correct sparse file handling.  The compressed values need to be
    checked and set in the ntfs inode as done for compressed files
    and the compressed size needs to be used for vfs inode->i_blocks
    instead of the allocated size, again, as done for compressed files.
    
    Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

commit 413826868fb49d200b741bcaeaf58ea5c5e45321
tree a106b6e0bae52a68a0b824f1999ab694d894a1f2
parent 8907547d4b099e67762ea4891c127ea1f6dd1cb7
author Anton Altaparmakov <aia21@cantab.net> Thu, 03 Mar 2005 13:44:15 +0000
committer Anton Altaparmakov <aia21@cantab.net> Thu, 05 May 2005 11:13:56 +0100

    NTFS: Make fs/ntfs/namei.c::ntfs_get_{parent,dentry} static and move the
    definition of ntfs_export_ops from fs/ntfs/super.c to namei.c.
    Also, declare ntfs_export_ops in fs/ntfs/ntfs.h.
    
    Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

commit 8907547d4b099e67762ea4891c127ea1f6dd1cb7
tree 74fa9c887db8a7915325ad9a76d874ed134c0d9a
parent 5ae9fcf8f329baba4bada8719cb0337eef083a1a
author Randy Dunlap <rddunlap@osdl.org> Thu, 03 Mar 2005 11:19:53 +0000
committer Anton Altaparmakov <aia21@cantab.net> Thu, 05 May 2005 11:11:47 +0100

    NTFS: Fix printk format warnings on ia64. (Randy Dunlap)
    
    Signed-off-by: Randy Dunlap <rddunlap@osdl.org>
    Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

commit 5ae9fcf8f329baba4bada8719cb0337eef083a1a
tree 28f268908b5bd780a114825879d7bc35d98d9dca
parent 37e4c13b987a7923ec13bda7368901b3e094fecb
author Anton Altaparmakov <aia21@cantab.net> Wed, 02 Mar 2005 17:03:24 +0000
committer Anton Altaparmakov <aia21@cantab.net> Thu, 05 May 2005 11:04:54 +0100

    NTFS: - Set the ntfs_inode->allocated_size to the real allocated size in the
    mft record for resident attributes (fs/ntfs/inode.c).
    - Small readability cleanup to use "a" instead of "ctx->attr"
    everywhere (fs/ntfs/inode.c).
    
    Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

commit 37e4c13b987a7923ec13bda7368901b3e094fecb
tree 781dcc0990fc42c26492206261d4b5f325715821
parent d8ec785e0bf2941ed546711c2f240a3e030c39c7
author Anton Altaparmakov <aia21@cantab.net> Fri, 18 Feb 2005 10:03:13 +0000
committer Anton Altaparmakov <aia21@cantab.net> Thu, 05 May 2005 11:03:01 +0100

    NTFS: Fix a nasty runlist merge bug when merging two holes.
    
    Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

commit d8ec785e0bf2941ed546711c2f240a3e030c39c7
tree c4b69ce75a331731d9616fa9868cceba4e90325e
parent b6ad6c52fe36ab35d0fe28c064f59de2ba670c2a
author Anton Altaparmakov <aia21@cantab.net> Fri, 18 Feb 2005 09:23:39 +0000
committer Anton Altaparmakov <aia21@cantab.net> Thu, 05 May 2005 11:01:13 +0100

    NTFS: Change time to u64 in time.h::ntfs2utc() as it otherwise generates a
    warning in the do_div() call on sparc32.  Thanks to Meelis Roos for the
    report and analysis of the warning.
    
    Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

commit b6ad6c52fe36ab35d0fe28c064f59de2ba670c2a
tree d888c28a2c3c7fa733045dc7dc9c9bc7f157bf4a
parent 1a0df15acdae065789446aca83021c72b71db9a5
author Anton Altaparmakov <aia21@cantab.net> Tue, 15 Feb 2005 10:08:43 +0000
committer Anton Altaparmakov <aia21@cantab.net> Thu, 05 May 2005 10:56:31 +0100

    NTFS: - Split ntfs_map_runlist() into ntfs_map_runlist() and a non-locking
    helper ntfs_map_runlist_nolock() which is used by ntfs_map_runlist().
    This allows us to map runlist fragments with the runlist lock already
    held without having to drop and reacquire it around the call.  Adapt
    all callers.
    - Change ntfs_find_vcn() to ntfs_find_vcn_nolock() which takes a locked
    runlist.  This allows us to find runlist elements with the runlist
    lock already held without having to drop and reacquire it around the
    call.  Adapt all callers.
    
    Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

commit 1a0df15acdae065789446aca83021c72b71db9a5
tree bb3bf97da4f2753aba46e1dd4855c0ef9f7c55b8
parent c002f42543e155dd2b5b5039ea2637ab26c82513
author Anton Altaparmakov <aia21@cantab.net> Thu, 03 Feb 2005 12:04:36 +0000
committer Anton Altaparmakov <aia21@cantab.net> Thu, 05 May 2005 10:54:37 +0100

    NTFS: Fix a bug in fs/ntfs/runlist.c::ntfs_mapping_pairs_decompress() in
    the creation of the unmapped runlist element for the base attribute
    extent.
    
    Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

commit c002f42543e155dd2b5b5039ea2637ab26c82513
tree ea408493d2e0e9096166ab39a8657689c15c7dfa
parent f40661be038ce6ed9ef6a8b80307a9153bd95769
author Anton Altaparmakov <aia21@cantab.net> Thu, 03 Feb 2005 12:02:56 +0000
committer Anton Altaparmakov <aia21@cantab.net> Thu, 05 May 2005 10:53:01 +0100

    NTFS: - Add disable_sparse mount option together with a per volume sparse
    enable bit which is set appropriately and a per inode sparse disable
    bit which is preset on some system file inodes as appropriate.
    - Enforce that sparse support is disabled on NTFS volumes pre 3.0.
    
    Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

commit f40661be038ce6ed9ef6a8b80307a9153bd95769
tree 61c9c81643c96ffa7cdb186b10e5e2f141493b56
parent 946929d813a3bde095678526dd037ab9ac6efe35
author Anton Altaparmakov <aia21@cantab.net> Thu, 13 Jan 2005 16:03:38 +0000
committer Anton Altaparmakov <aia21@cantab.net> Thu, 05 May 2005 10:48:11 +0100

    NTFS: Optimise/reorganise some error handling code in fs/ntfs/aops.c.
    
    Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

commit 946929d813a3bde095678526dd037ab9ac6efe35
tree eb2601dc94364d9d376be372ccaadb304c921653
parent 3834c3f227725e2395840aed82342bda4ee9d379
author Anton Altaparmakov <aia21@cantab.net> Thu, 13 Jan 2005 15:26:29 +0000
committer Anton Altaparmakov <aia21@cantab.net> Thu, 05 May 2005 10:47:05 +0100

    NTFS: Fixup the resident attribute resizing code in
    fs/ntfs/aops.c::ntfs_{prepare,commit}_write()() and re-enable it.
    It should be safe now.  (Famous last words...)
    
    Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

commit 3834c3f227725e2395840aed82342bda4ee9d379
tree 7a145a78efc44cb5ddce614cdd2618c710c8e3b7
parent 149f0c5200188a43f1fc11ca2fb14d8183013d10
author Anton Altaparmakov <aia21@cantab.net> Thu, 13 Jan 2005 11:04:39 +0000
committer Anton Altaparmakov <aia21@cantab.net> Thu, 05 May 2005 10:45:36 +0100

    NTFS: Fix stupid bug in fs/ntfs/mft.c introduced in last changeset.
    
    Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

commit 149f0c5200188a43f1fc11ca2fb14d8183013d10
tree 6fed760d28b70790e26803f6f18a663eb487764c
parent 07a4e2da7dd3c9345f84b2552872f9d38c257451
author Anton Altaparmakov <aia21@cantab.net> Wed, 12 Jan 2005 13:52:30 +0000
committer Anton Altaparmakov <aia21@cantab.net> Thu, 05 May 2005 10:43:29 +0100

    NTFS: Repeat a failed ntfs_truncate() in fs/ntfs/aops.c::ntfs_writepage()
    and abort if it fails again.
    
    Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

commit 07a4e2da7dd3c9345f84b2552872f9d38c257451
tree 8fbd4c3e11196752ae8ff7944ccb26b93cafbb1c
parent f50f3ac51983025405a71b70b033cc6bcb0d1fc1
author Anton Altaparmakov <aia21@cantab.net> Wed, 12 Jan 2005 13:08:26 +0000
committer Anton Altaparmakov <aia21@cantab.net> Thu, 05 May 2005 10:39:08 +0100

    NTFS: Use i_size_{read,write}() in fs/ntfs/{aops.c,mft.c} and protect
    access to the i_size and other size fields using the size_lock.
    
    Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

commit f50f3ac51983025405a71b70b033cc6bcb0d1fc1
tree 98c9e85271354a878237d77c30a144680cbc1bb1
parent 218357ff1b1b2f1bfdce89d608dbe33dd2f9f14b
author Anton Altaparmakov <aia21@cantab.net> Fri, 19 Nov 2004 22:16:00 +0000
committer Anton Altaparmakov <aia21@cantab.net> Thu, 05 May 2005 10:37:22 +0100

    NTFS: Use i_size_read() in fs/ntfs/inode.c once and then use the cached value
    afterwards when reading the size of the bitmap inode.
    
    Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

commit 218357ff1b1b2f1bfdce89d608dbe33dd2f9f14b
tree b7621daec3c516507fed85a25e9e82198589f216
parent 206f9f35b2348b7b966ff18a5564b8a3ca325ed5
author Anton Altaparmakov <aia21@cantab.net> Thu, 18 Nov 2004 20:34:59 +0000
committer Anton Altaparmakov <aia21@cantab.net> Thu, 05 May 2005 10:34:45 +0100

    NTFS: - Use i_size_read() in fs/ntfs/super.c once and then use the cached
    value afterwards.  Cache the initialized_size in the same way and
    protect access to the two sizes using the size_lock.
    - Minor optimization to fs/ntfs/super.c::ntfs_statfs() and its helpers.
    
    Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

commit 206f9f35b2348b7b966ff18a5564b8a3ca325ed5
tree 2f221334cf8b1b9756a58e323b5fba2cdd4dc583
parent 367636772f094fd840d2d79e75257bcfaa28e70f
author Anton Altaparmakov <aia21@cantab.net> Thu, 18 Nov 2004 15:01:06 +0000
committer Anton Altaparmakov <aia21@cantab.net> Thu, 05 May 2005 10:32:43 +0100

    NTFS: In fs/ntfs/dir.c, use i_size_read() once and then the cached value
    afterwards.
    
    Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

commit 367636772f094fd840d2d79e75257bcfaa28e70f
tree a8d8f3154eea80710a8cad2b7de082046aa012f0
parent 899101aebb9ab3692aa8efe2805174ee0ee3edb5
author Anton Altaparmakov <aia21@cantab.net> Thu, 18 Nov 2004 13:46:45 +0000
committer Anton Altaparmakov <aia21@cantab.net> Thu, 05 May 2005 10:30:29 +0100

    NTFS: - In fs/ntfs/compress.c, use i_size_read() at the start and then use the
    cached value everywhere.  Cache the initialized_size in the same way
    and protect the critical region where the two sizes are read using the
    new size_lock of the ntfs inode.
    - Add the new size_lock to the ntfs_inode structure (fs/ntfs/inode.h)
    and initialize it (fs/ntfs/inode.c).
    
    Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

commit d4b9ba7bf6f38cff55b5d95a0db7dd91311ce20a
tree b86c83f8c04e159bb8f806990cbf61e88ceebf30
parent db30d160cd8dfe1e53435fd76f4189778f1c728e
author Anton Altaparmakov <aia21@cantab.net> Wed, 17 Nov 2004 15:45:08 +0000
committer Anton Altaparmakov <aia21@cantab.net> Wed, 04 May 2005 17:02:25 +0100

    NTFS: Use i_size_read() in fs/ntfs/file.c::ntfs_file_open().
    
    Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

commit db30d160cd8dfe1e53435fd76f4189778f1c728e
tree add695bfe2311c653143b08fa717ad909bf48f5c
parent 66129f88c4cc719591f687e5c8c764fe9d3e437a
author Anton Altaparmakov <aia21@cantab.net> Thu, 11 Nov 2004 12:42:00 +0000
committer Anton Altaparmakov <aia21@cantab.net> Wed, 04 May 2005 17:00:18 +0100

    NTFS: Use i_size_read() once and then use the cached value in
    fs/ntfs/lcnalloc.c::ntfs_cluster_alloc().
    
    Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

commit 66129f88c4cc719591f687e5c8c764fe9d3e437a
tree 3fc9f181a1666eff445bdb6a243dd4e080c233f9
parent da28438cae9a271c5c232177f81dfb243de9b7fa
author Anton Altaparmakov <aia21@cantab.net> Thu, 11 Nov 2004 12:34:00 +0000
committer Anton Altaparmakov <aia21@cantab.net> Wed, 04 May 2005 16:57:47 +0100

    NTFS: Use i_size_read() in fs/ntfs/logfile.c::ntfs_{check,empty}_logfile().
    
    Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

commit da28438cae9a271c5c232177f81dfb243de9b7fa
tree 40817e52c229dbb288f6425b2056c1ad61ad6470
parent 8800cea62025a5209d110c5fa5990429239d6eee
author Anton Altaparmakov <aia21@cantab.net> Thu, 11 Nov 2004 11:18:10 +0000
committer Anton Altaparmakov <aia21@cantab.net> Wed, 04 May 2005 14:24:16 +0100

    NTFS: Use i_size_read() in fs/ntfs/attrib.c::ntfs_attr_set().
    
    Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

