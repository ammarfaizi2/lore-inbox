Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318333AbSHEISm>; Mon, 5 Aug 2002 04:18:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318338AbSHEISm>; Mon, 5 Aug 2002 04:18:42 -0400
Received: from pimout3-ext.prodigy.net ([207.115.63.102]:8420 "EHLO
	pimout3-int.prodigy.net") by vger.kernel.org with ESMTP
	id <S318333AbSHEISl>; Mon, 5 Aug 2002 04:18:41 -0400
Message-Id: <200208050822.g758MGa443212@pimout3-int.prodigy.net>
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: linux-kernel@vger.kernel.org
Subject: Is there a way to move an existing mount point?
Date: Sun, 4 Aug 2002 22:23:47 -0400
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've got a boot script that mounts an ext3 partition, and out of that 
loopback mounting a zisofs image to be the system's root partition.  (Sort of 
a firmware setup: the whole OS can be upgraded atomically by replacing one 
file, which rsyncs against a copy of itself fairly nicely.)

The partition the zisofs image lives in is going to become the "var" 
partition when the system's the rest of the way up, and I'd like to move the 
existing mount to newmount/var.  Right now I'm mounting /var, loopback 
mounting /zisofs, doing an "exec chroot zisofs /sbin/init auto", and just 
leaving a couple of inaccessable mount points cluttering up the start of 
/proc/mounts.

This works fine, but it's ugly.  I'm in the process of switching to using a 
ramdisk for the boot loader, and in the process I was hoping to actually 
relocate the first /var mount down under the zisofs/var.

Here's why pivot_root doesn't work: I have to mount the var partition before 
I can loopback mount the zisofs (firmware) root partition out of it.  Once 
the zisofs image is mounted, the var partition is busy (due to loop0 holding 
a file open), and pivot_root won't relocate it (on 2.4.18 anyway).  In 
theory, the zisofs image should point to the same inode out of the same 
superblock, so it shouldn't mind moving the mount as long as I don't UNMOUNT 
it.  But for some reason pivot_root is mad anyway.

pivot_root is even less useful when booting from an initrd, since the var 
partition (mounted onto a directory of the ramdisk) is never actually the 
root partition anyway.  What I WANT is some kind of "move_mount path1 path2".

"mount -o remount" explicitly doesn't change the mount point.  "mount --bind 
oldmout newmount" just makes duplicate mounts (of subdirectories, which is 
cool, but not what I'm looking for.  Mounting the same partition again in a 
new location (creating a duplicate mount) doesn't allow the first one to 
become un-busy and thus be unmounted, even though the reference count of the 
superblock should be increased.

Is this a toolchain problem, or a kernel problem, or a documentation problem, 
or a "I just don't know what I'm doing yet" problem?  I THINK it's a kernel 
problem because things seem to be happening per mount that should probably be 
happening per superblock (now that superblocks may be multiply mounted and 
reference counted), but my understanding of this part of the code is still 
very incomplete.

Anybody have any suggestions?

Rob

(P.S.  Zisofs is really cool.  Thanks HPA.  :)
