Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265782AbRFXWzY>; Sun, 24 Jun 2001 18:55:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265783AbRFXWzO>; Sun, 24 Jun 2001 18:55:14 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:61446 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S265782AbRFXWzC>;
	Sun, 24 Jun 2001 18:55:02 -0400
Date: Sun, 24 Jun 2001 18:54:59 -0400 (EDT)
Message-Id: <200106242254.f5OMsxQ405511@saturn.cs.uml.edu>
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
To: linux-kernel@vger.kernel.org
Cc: viro@math.psu.edu, phillips@bonn-fries.net, chaffee@cs.berkeley.edu,
        storner@image.dk, mnalis-umsdos@voyager.hr
Subject: FAT32 superiority over ext2 :-)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


By dumb luck (?), FAT32 is compatible with the phase-tree algorithm
as seen in Tux2. This means it offers full data integrity.
Yep, it whips your typical journalling filesystem. Look at what
we have in the superblock (boot sector):

    __u32  fat32_length;  /* sectors/FAT */
    __u16  flags;         /* bit 8: fat mirroring, low 4: active fat */
    __u8   version[2];    /* major, minor filesystem version */
    __u32  root_cluster;  /* first cluster in root directory */
    __u16  info_sector;   /* filesystem info sector */

All in one atomic write, one can...

1. change the active FAT
2. change the root directory
3. change the free space count

That's enough to atomically move from one phase to the next.
You create new directories in the free space, and make FAT
changes to an inactive FAT copy. Then you write the superblock
to atomically transition to the next phase.

