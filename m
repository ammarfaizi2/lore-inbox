Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265725AbTBBXWo>; Sun, 2 Feb 2003 18:22:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265736AbTBBXWo>; Sun, 2 Feb 2003 18:22:44 -0500
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:45462 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S265725AbTBBXWo>; Sun, 2 Feb 2003 18:22:44 -0500
Date: Mon, 3 Feb 2003 00:32:12 +0100 (CET)
From: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
To: linux-kernel@vger.kernel.org
Subject: 2.0, 2.2, 2.4, 2.5: fsync buffer race
Message-ID: <Pine.LNX.4.44.0302022354570.11719-100000@artax.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

there's a race condition in filesystem

let's have a two inodes that are placed in the same buffer.

call fsync on inode 1
it goes down to ext2_update_inode [update == 1]
it calls ll_rw_block at the end
ll_rw_block starts to write buffer
ext2_update_inode waits on buffer

while the buffer is writing, another process calls fsync on inode 2
it goes again to ext2_update_inode
it calls ll_rw_block
ll_rw_block sees buffer locked and exits immediatelly
ext2_update_inode waits for buffer
the first write finished, ext2_update_inode exits and changes made by
second proces to inode 2 ARE NOT WRITTEN TO DISK.

This bug causes that when you simultaneously fsync two inodes in the same
buffer, only the first will be really written to disk.

Mikulas




