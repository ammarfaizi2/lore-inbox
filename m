Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263306AbTHXB2M (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Aug 2003 21:28:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261180AbTHXB2L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Aug 2003 21:28:11 -0400
Received: from vmail.ao.net ([65.205.176.178]:58508 "EHLO aku.ao.net")
	by vger.kernel.org with ESMTP id S262273AbTHXB2F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Aug 2003 21:28:05 -0400
Message-ID: <4878.24.165.250.16.1061688482.squirrel@mail.merillat.org>
Date: Sat, 23 Aug 2003 21:28:02 -0400 (EDT)
Subject: Reiserfs kernel-crashing bug in 2.4.20 (and UML)
From: dan@merillat.org
To: linux-kernel@vger.kernel.org
Cc: harik@chaos.ao.net
User-Agent: SquirrelMail/1.4.0
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
X-Priority: 3
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Let's get this out of the way first: I KNOW IT'S A HARDWARE BUG.  My
system wrote corrupted data to the drive.  I've already recovered the
partition but I have a dd'd copy around to figure this out.

With that out of the way:

I can reliably insta-reboot my kernel or cause user-mode-linux to crash
out when doing a directory lookup in one corrupted directory.

The catch is, (and there's always a catch) neither oopses.  real kernel on
real hardware just flashes the screen and reboots, user-mode-linux just
drops back to the host's shell prompt.

Here's what I've found using UML on it:

The directory is one block, but we're reading data 100+k into it.  Perhaps
a sanity check that we're actually within the buffer we want to be?

In this case, it finds other random kernel or on-disk data, pulls it in
and does bad things with it.  (memcopy -4000 bytes in kernel space, for
instance)

        if (!de_visible (deh))
            /* it is hidden entry */
            continue;
        d_reclen = entry_length (bh, ih, entry_num);
        d_name = B_I_DEH_ENTRY_FILE_NAME (bh, ih, deh);
        if (!d_name[d_reclen - 1])
            d_reclen = strlen (d_name);


        // Note, that we copy name to user space via temporary
        // buffer (local_buf) because filldir will block if
        // user space buffer is swapped out. At that time
        // entry can move to somewhere else
        memcpy (local_buf, d_name, d_reclen); // CRASHES HERE //
        if (filldir (dirent, local_buf, d_reclen, d_off, d_ino,
                     DT_UNKNOWN) < 0) {
            if (local_buf != small_buf) {

d_reclen is a negative number.

Things have gone wrong when we return from search_by_entry_key, since
de.de_entry_num is a huge number (6500 or so) and I_ENTRY_COUNT(ih) is in
the 100k range.

Two sanity checks: I_ENTRY_COUNT(bh) < number of directory entries that
can exist in a given number of blocks, and we verify that entry_length(bh,
ih, entry_num) returns a positive number.

Right now I just patched with the following, but returning -EIO dosn't
mark the inode corrupted so it never gets fixed.  This should NOT be
blindly applied to anyone's tree.  It's just to point out where the
problem is to Hans.

--- dir.c.orig	2003-08-23 15:13:23.000000000 -0400
+++ dir.c	2003-08-23 15:13:55.000000000 -0400
@@ -102,6 +102,8 @@
 		    /* it is hidden entry */
 		    continue;
 		d_reclen = entry_length (bh, ih, entry_num);
+		if (d_reclen < 0)
+			return -EIO;
 		d_name = B_I_DEH_ENTRY_FILE_NAME (bh, ih, deh);
 		if (!d_name[d_reclen - 1])
 		    d_reclen = strlen (d_name);

Also, the corrupted directory entry itself is saved at

http://www.ao.net/~harik/corrupted-directory-entry.gz (1523 bytes)

As you can see, some file data ended up tromping on the directory
structure.  It's doubly obvious because it was a text file.

I'm keeping the on-disk image around for a while if anyone wants to take a
look at it.

--Dan


