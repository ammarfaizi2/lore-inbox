Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132039AbRDNMGJ>; Sat, 14 Apr 2001 08:06:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132042AbRDNMF7>; Sat, 14 Apr 2001 08:05:59 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:55301 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S132039AbRDNMFs>; Sat, 14 Apr 2001 08:05:48 -0400
Date: Sat, 14 Apr 2001 07:24:42 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: "Stephen C. Tweedie" <sct@redhat.com>, Alexander Viro <viro@math.psu.edu>,
        lkml <linux-kernel@vger.kernel.org>
Subject: generic_osync_inode/ext2_fsync_inode still not safe
Message-ID: <Pine.LNX.4.21.0104140632300.1615-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

As described earlier, code which wants to write an inode cannot rely on
the I_DIRTY bits (on inode->i_state) being clean to guarantee that the
inode and its dirty pages, if any, are safely synced on disk.

The reason for that is sync_one() --- it cleans the I_DIRTY bits of an
inode, sets the I_LOCK and starts a writeout. 

If sync_one() is called to write an inode _asynchronously_, there is no
guarantee that an inode will have its data fully synced on disk even if
the inode gets unlocked, which means the previous fix to
generic_osync_inode() is not safe.

The easy and safe fix is to simply remove the I_DIRTY_* checks from
generic_osync_inode and ext2_fsync_inode. Easy but slow. Another fix would
be to make sync_one() unconditionally synchronous... slow.

Any suggestion for a fast, safe, but simple fix to this bug?


