Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261776AbTLBKxK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 05:53:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261799AbTLBKxJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 05:53:09 -0500
Received: from zork.zork.net ([64.81.246.102]:20104 "EHLO zork.zork.net")
	by vger.kernel.org with ESMTP id S261776AbTLBKxH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 05:53:07 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs/locks.c fcntl_setlease did not check if a file was
 opened for writing before granting a read lease
References: <000301c3b504$689afbf0$0201a8c0@joe>
	<20031127165043.GA19669@mail.shareable.org>
Reply-To: Sean Neakums <sneakums@zork.net>
From: Sean Neakums <sneakums@zork.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
Date: Tue, 02 Dec 2003 10:53:05 +0000
In-Reply-To: <20031127165043.GA19669@mail.shareable.org> (Jamie Lokier's
 message of "Thu, 27 Nov 2003 16:50:43 +0000")
Message-ID: <6uwu9flcdq.fsf@zork.zork.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier <jamie@shareable.org> writes:

> To detect if anyone has the file open for writing, you'll a new count
> field which keeps track of writer references.  Something like this:
>
> 	if ((arg == F_RDLCK)
> 	    && ((atomic_read(&inode->i_writer_count) != 0)))
>
> You'll also need to modify all the places where that needs to be
> maintained.

Looking at 2.6.0-test11, it seems that its struct inode has such a
field, albeit named i_writecount.  Commentary from fs/namei.c:

/*
 * get_write_access() gets write permission for a file.
 * put_write_access() releases this write permission.
 * This is used for regular files.
 * We cannot support write (and maybe mmap read-write shared) accesses and
 * MAP_DENYWRITE mmappings simultaneously. The i_writecount field of an inode
 * can have the following values:
 * 0: no writers, no VM_DENYWRITE mappings
 * < 0: (-i_writecount) vm_area_structs with VM_DENYWRITE set exist
 * > 0: (i_writecount) users are writing to the file.
 *
 * Normally we operate on that counter with atomic_{inc,dec} and it's safe
 * except for the cases where we don't hold i_writecount yet. Then we need to
 * use {get,deny}_write_access() - these functions check the sign and refuse
 * to do the change if sign is wrong. Exclusion between them is provided by
 * spinlock (arbitration_lock) and I'll rip the second arsehole to the first
 * who will try to move it in struct inode - just leave it here.
 */
