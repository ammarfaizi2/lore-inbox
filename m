Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1163493AbWLGWNF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1163493AbWLGWNF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 17:13:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1163492AbWLGWNF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 17:13:05 -0500
Received: from mx1.redhat.com ([66.187.233.31]:56024 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1163493AbWLGWNC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 17:13:02 -0500
Message-ID: <457891E7.10902@redhat.com>
Date: Thu, 07 Dec 2006 17:12:55 -0500
From: Jeff Layton <jlayton@redhat.com>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 0/3] ensure unique i_ino in filesystems without permanent
 inode numbers (introduction)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Apologies for the long email, but I couldn't come up with a way to explain
this in fewer words. Many filesystems that are part of the linux kernel have
problems with how they have assign out i_ino values:

1) on filesystems w/o permanent inode numbers, i_ino values can be
larger than 32 bits, which can cause problems for some 32 bit userspace
programs on a 64 bit kernel. We can't do anything for filesystems that have
actual 64-bit inode numbers, but on filesystems that generate i_ino
values on the fly, we should try to have them fit in 32 bits. We could
trivially fix this by making the static counters in new_inode and iunique
32 bits, but...

2) many filesystems call new_inode and assume that the i_ino values they
are given are unique. They are not guaranteed to be so, since the static
counter can wrap. This problem is exacerbated by the fix for #1.

3) after allocating a new inode, some filesystems call iunique to try to
get a unique i_ino value, but they don't actually add their inodes to
the hashtable, and so they're still not guaranteed to be unique if that
counter wraps. We could hash the inodes to fix this, but...

4) many of these filesystems pin their inodes in memory, and adding them to
the inode hashtable might slow down lookups for "real" filesystems.

The following series of patches aims to correct these problems. It adds
two new functions iunique_register and iunique_unregister, that use IDR
under the hood. Filesystems can call iunique_register at inode creation,
and then at deletion, we'll automatically unregister them. It uses
per-superblock hashes for this. One side effect is that with this patch,
i_ino values are reused rather quickly (i.e. IDR prefers to reuse a number
that has been deallocated rather than assign an unused one).

Because i_ino's can be reused so quickly, we don't want NFS getting
confused when it happens. The patch also adds a new s_generation counter
to the superblock. When iunique_register is called, we'll assign
the s_generation value to the i_generation, and then increment it to
help ensure that we get different filehandles.

Al Viro had expressed some concern with an earlier patch that this method
might slow down pipe creation. I've done some testing and I think the
impact will be minimal. Timing a small program that creates and closes 100
million pipes in a loop:

patched:
-------------
real    8m8.623s
user    0m37.418s
sys     7m31.196s

unpatched:
--------------
real    8m7.150s
user    0m40.943s
sys     7m26.204s

As the number of pipes grows on the system this time may grow somewhat,
but it doesn't seem like it will be terrible.

iunique_unregister is called unconditionally in several places, but filesystems
that don't use this should have empty IDR hashes and return quickly.

3 patches follow:

- a patch to add the new superblock fields and functions and to change the
iunique counter to 32 bits

- a patch to make sure that the inodes allocated by get_sb_pseudo and
simple_fill_super are unique

- a patch to convert pipefs to hash its inode numbers this way

Other patches will follow to fix up other filesystems as I get to them. Once
all of the callers of new_inode have been audited to make sure that they
assign i_ino to a sane value, we can remove the static counter from new_inode.

Many thanks to Eric Sandeen, Joern Engel, Christoph Hellwig, and Al Viro for
guidance on this.

Signed-off-by: Jeff Layton <jlayton@redhat.com>

