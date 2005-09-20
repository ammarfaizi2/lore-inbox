Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965074AbVITSsi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965074AbVITSsi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 14:48:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965079AbVITSsh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 14:48:37 -0400
Received: from ppp-62-11-78-183.dialup.tiscali.it ([62.11.78.183]:14528 "EHLO
	zion.home.lan") by vger.kernel.org with ESMTP id S965074AbVITSsW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 14:48:22 -0400
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH 1/7] Add dm-snapshot tutorial in Documentation
Date: Tue, 20 Sep 2005 20:45:19 +0200
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Message-Id: <20050920184513.14557.8152.stgit@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've recently discovered the real functionality of device-mapper snapshots,
and since they are not well known, I've decided to write some docs for
them.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 Documentation/device-mapper/snapshot.txt |   70 ++++++++++++++++++++++++++++++
 1 files changed, 70 insertions(+), 0 deletions(-)

diff --git a/Documentation/device-mapper/snapshot.txt b/Documentation/device-mapper/snapshot.txt
new file mode 100644
--- /dev/null
+++ b/Documentation/device-mapper/snapshot.txt
@@ -0,0 +1,70 @@
+Device-mapper snapshot support
+==============================
+
+Device-mapper allows you, without massive data copying,
+
+*) to create snapshots of one block device (i.e.  mountable, saved states of
+one block device, which are also writable without interfering with the
+original content),
+*) and to create device "forks", also called COW devices, i.e. multiple
+different versions of the same data stream.
+
+In both cases, dm copies only the changed data (actually, only the changed
+chunks).
+
+There are two available targets, snapshot (for the latter) and snapshot-origin
+(for the former).
+
+*) snapshot <origin> <cow space> <persistent?> <chunksize>
+
+a snapshot is created of the <origin> block device. Changed chunks, wide
+<chunksize> sectors, will be stored on the <cow space> block device. Writes
+will only go to <cow space>, reads will come from <cow space>, or from
+<origin> for unchanged datas. <cow space> will normally be smaller than the
+origin, so if too much data is written on the snapshot, it will start
+returning errors on write. However you can always expand the snapshot later.
+
+<persistent?> is p (persistent) or n(not persistent, will not survive after
+reboot).
+For transient snapshots there is no need to save metadata on disk.
+
+*) snapshot-origin <origin>: <origin> must be a device-mapper block device,
+
+which will normally have one or more snapshots based on it. Reads will be
+mapped directly on backing device; for each write, the original data will be
+saved in the "cow space" of each snapshot to keep their visible content
+unchanged, at least until the cow space fills up.
+
+How this is used at LVM level
+==============================
+When you create a LVM* snapshot of a volume, four dm devices are used:
+
+1) a device containing the original mapping table of the source volume;
+2) a device used as COW space;
+3) a "snapshot" device, combining #1 and #2, which is the visible snapshot
+   volume;
+4) the "original" volume (which keeps the old minor), whose table is replaced
+   by a "snapshot-origin" mapping from device #1.
+
+Fixed name schemes are used, so with the following commands:
+
+lvcreate -L 1G -n base volumeGroup
+lvcreate -L 100M --snapshot -n snap volumeGroup/base
+
+we'll have this situation (with volumes in above order):
+
+# dmsetup table|grep volumeGroup
+
+volumeGroup-base-real: 0 2097152 linear 8:19 384
+volumeGroup-snap-cow: 0 204800 linear 8:19 2097536
+volumeGroup-snap: 0 2097152 snapshot 254:11 254:12 P 16
+volumeGroup-base: 0 2097152 snapshot-origin 254:11
+
+# ll -L /dev/mapper/volumeGroup-*
+brw-------  1 root root 254, 11 29 ago 18:15 /dev/mapper/volumeGroup-base-real
+brw-------  1 root root 254, 12 29 ago 18:15 /dev/mapper/volumeGroup-snap-cow
+brw-------  1 root root 254, 13 29 ago 18:15 /dev/mapper/volumeGroup-snap
+brw-------  1 root root 254, 10 29 ago 18:14 /dev/mapper/volumeGroup-base
+
+* I've verified this with LVM 2.01.09, however I assume this is the LVM2 way
+  of doing this.

