Return-Path: <linux-kernel-owner+w=401wt.eu-S932220AbXAPCDa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932220AbXAPCDa (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 21:03:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932229AbXAPCDa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 21:03:30 -0500
Received: from 64.221.212.177.ptr.us.xo.net ([64.221.212.177]:25129 "EHLO
	ext.agami.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932220AbXAPCD2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 21:03:28 -0500
X-Greylist: delayed 510 seconds by postgrey-1.27 at vger.kernel.org; Mon, 15 Jan 2007 21:03:27 EST
From: Nate Diller <nate@agami.com>
To: Nate Diller <nate.diller@gmail.com>, Andrew Morton <akpm@osdl.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Benjamin LaHaise <bcrl@kvack.org>,
       Alexander Viro <viro@zeniv.linux.org.uk>,
       Suparna Bhattacharya <suparna@in.ibm.com>,
       Kenneth W Chen <kenneth.w.chen@intel.com>,
       David Brownell <dbrownell@users.sourceforge.net>,
       Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       netdev@vger.kernel.org, ocfs2-devel@oss.oracle.com, linux-aio@kvack.org,
       xfs-masters@oss.sgi.com
Date: Mon, 15 Jan 2007 17:54:50 -0800
Message-Id: <20070116015450.9764.37697.patchbomb.py@nate-64.agami.com>
Subject: [PATCH -mm 0/10][RFC] aio: make struct kiocb private
X-OriginalArrivalTime: 16 Jan 2007 01:54:50.0846 (UTC) FILETIME=[4F25E7E0:01C73911]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This series is an attempt to generalize the async I/O paths to be
implementation agnostic.  It completely eliminates knowledge of
the kiocb structure in the generic code and makes it private within the
current aio code.  Things get noticeably cleaner without that layering
violation.

The new interface takes a file_endio_t function pointer, and a private data
pointer, which would normally be aio_complete and a kiocb pointer,
respectively.  If the aio submission function gets back EIOCBQUEUED, that is
a guarantee that the endio function will be called, or *already has been
called*.  If the file_endio_t pointer provided to aio_[read|write] is NULL,
the FS must block on I/O completion, then return either the number of bytes
read, or an error.

I had to touch more areas that I had originally expected, so there are
changes in a corner of the socket code, and a slight behavior change in the
direct-io completion path with affects XFS and OCFS2.  I would appreciate
further review there, so I copied some extra people I hope can help.

This patch is against 2.6.20-rc4-mm1.  It has been compile-tested at each
stage.  It needs some runtime testing yet, but I prefer to get it out for
commentary and test later.

These patches are for RFC only and have not yet been signed off.

NATE

---

 Documentation/filesystems/Locking |   11 +
 Documentation/filesystems/vfs.txt |   11 +
 arch/s390/hypfs/inode.c           |   16 +-
 drivers/net/pppoe.c               |    8 -
 drivers/net/tun.c                 |   13 +-
 drivers/usb/gadget/inode.c        |  239 +-------------------------------------
 fs/aio.c                          |   74 ++++++-----
 fs/bad_inode.c                    |   10 -
 fs/block_dev.c                    |  109 +++++++++++------
 fs/cifs/cifsfs.c                  |   10 -
 fs/compat.c                       |   56 --------
 fs/direct-io.c                    |   92 ++++++++------
 fs/ecryptfs/file.c                |   16 +-
 fs/ext2/inode.c                   |   12 -
 fs/ext3/file.c                    |    9 -
 fs/ext3/inode.c                   |   11 -
 fs/ext4/file.c                    |    9 -
 fs/ext4/inode.c                   |   11 -
 fs/fat/inode.c                    |   12 -
 fs/fuse/dev.c                     |   13 +-
 fs/gfs2/ops_address.c             |   14 +-
 fs/hfs/inode.c                    |   13 --
 fs/hfsplus/inode.c                |   13 --
 fs/jfs/inode.c                    |   12 -
 fs/nfs/direct.c                   |   92 +++++++-------
 fs/nfs/file.c                     |   62 +++++----
 fs/ntfs/file.c                    |   71 ++---------
 fs/ocfs2/aops.c                   |   24 +--
 fs/ocfs2/aops.h                   |    8 -
 fs/ocfs2/file.c                   |   44 +++---
 fs/ocfs2/inode.h                  |    2 
 fs/pipe.c                         |   12 -
 fs/read_write.c                   |  225 ++++++++++++-----------------------
 fs/read_write.h                   |    8 -
 fs/reiserfs/inode.c               |   13 --
 fs/smbfs/file.c                   |   28 ++--
 fs/udf/file.c                     |   13 +-
 fs/xfs/linux-2.6/xfs_aops.c       |   44 +++---
 fs/xfs/linux-2.6/xfs_file.c       |   58 +++++----
 fs/xfs/linux-2.6/xfs_lrw.c        |   29 ++--
 fs/xfs/linux-2.6/xfs_lrw.h        |   10 -
 fs/xfs/linux-2.6/xfs_vnode.h      |   20 +--
 include/linux/aio.h               |   11 -
 include/linux/fs.h                |  114 +++++++++---------
 include/linux/net.h               |   18 +-
 include/linux/nfs_fs.h            |   12 -
 include/net/bluetooth/bluetooth.h |    2 
 include/net/inet_common.h         |    3 
 include/net/scm.h                 |    2 
 include/net/sock.h                |   45 +------
 include/net/tcp.h                 |    6 
 include/net/udp.h                 |    3 
 mm/filemap.c                      |  109 ++++++++---------
 net/appletalk/ddp.c               |    5 
 net/atm/common.c                  |    6 
 net/atm/common.h                  |    7 -
 net/ax25/af_ax25.c                |    7 -
 net/bluetooth/af_bluetooth.c      |    4 
 net/bluetooth/hci_sock.c          |    7 -
 net/bluetooth/l2cap.c             |    2 
 net/bluetooth/rfcomm/sock.c       |    8 -
 net/bluetooth/sco.c               |    3 
 net/core/sock.c                   |   12 -
 net/dccp/dccp.h                   |    8 -
 net/dccp/probe.c                  |    3 
 net/dccp/proto.c                  |    7 -
 net/decnet/af_decnet.c            |    7 -
 net/econet/af_econet.c            |    7 -
 net/ipv4/af_inet.c                |    5 
 net/ipv4/raw.c                    |    8 -
 net/ipv4/tcp.c                    |    7 -
 net/ipv4/tcp_probe.c              |    3 
 net/ipv4/udp.c                    |    9 -
 net/ipv4/udp_impl.h               |    2 
 net/ipv6/raw.c                    |    6 
 net/ipv6/udp.c                    |   10 -
 net/ipv6/udp_impl.h               |    6 
 net/ipx/af_ipx.c                  |    7 -
 net/irda/af_irda.c                |   29 ++--
 net/key/af_key.c                  |    6 
 net/llc/af_llc.c                  |    7 -
 net/netlink/af_netlink.c          |   24 +--
 net/netrom/af_netrom.c            |    7 -
 net/packet/af_packet.c            |   11 -
 net/rose/af_rose.c                |    7 -
 net/sctp/socket.c                 |    9 -
 net/socket.c                      |  199 +++++++++----------------------
 net/tipc/socket.c                 |   28 +---
 net/unix/af_unix.c                |  116 +++++++-----------
 net/wanrouter/af_wanpipe.c        |    7 -
 net/x25/af_x25.c                  |    6 
 sound/core/pcm_native.c           |   15 +-
 92 files changed, 1009 insertions(+), 1500 deletions(-)
