Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132871AbRDUUHF>; Sat, 21 Apr 2001 16:07:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132875AbRDUUG4>; Sat, 21 Apr 2001 16:06:56 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:19630 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S132871AbRDUUGj>;
	Sat, 21 Apr 2001 16:06:39 -0400
Date: Sat, 21 Apr 2001 16:06:37 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Roman Zippel <zippel@fh-brandenburg.de>
cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Races in affs_unlink(), affs_rmdir() and affs_rename()
In-Reply-To: <Pine.GSO.4.10.10012311256180.19210-100000@zeus.fh-brandenburg.de>
Message-ID: <Pine.GSO.4.21.0104211457420.25186-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mkdir /A
mkdir /B
mkdir /C
touch /A/a
ln /A/a /B/b
ln /A/a /C/c
rm /A/a &
rm /B/b

can corrupt filesystem. Scenario:

unlink("/B/b") locks /B, removes "b" and unlocks /B. Then it calls
affs_remove_link(), which blocks.

unlink("/A/a") locks /A, removes "a" and unlocks /A. Then it calls
affs_remove_link(). Which locks /B, renames removed entry into "b",
removes old "b" and inserts renamed "a" into /B.

The rest is irrelevant - we're already in it.

Similar race exists between unlink() and rename();

mkdir /A
mkdir /B
mkdir /C
touch /A/a
touch /B/a
ln /A/a /B/b
ln /A/a /C/c
rm /A/a &
mv /B/a /B/b
- similar scenario, different source of affs_remove_header().

Another one: unlink() and rmdir():
mkdir /A
mkdir /B
touch /A/a
ln /A/a /B/a
rm /A/a &
rmdir /B

Since you don't lock /B for affs_empty_dir(), you can hit the
window between removing old /B/a and inserting renamed /A/a into /B.
Notice that VFS _does_ lock /B (->i_zombie), but affs_remove_link()
for /A/a doesn't even look at it.

Same thing for rename()/rmdir() (rmdir victim contains a link to rename
target, apply the previous scenario).
								Al

