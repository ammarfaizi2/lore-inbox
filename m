Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262707AbTJaAXd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Oct 2003 19:23:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262853AbTJaAXd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Oct 2003 19:23:33 -0500
Received: from neors.cat.cc.md.us ([204.153.79.3]:54778 "EHLO
	student.ccbc.cc.md.us") by vger.kernel.org with ESMTP
	id S262707AbTJaAXa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Oct 2003 19:23:30 -0500
Date: Thu, 30 Oct 2003 19:18:39 -0500 (EST)
From: John R Moser <jmoser5@student.ccbc.cc.md.us>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: initrd help -- umounts root after pivot_root
Message-ID: <Pine.A32.3.91.1031030191344.46426A@student.ccbc.cc.md.us>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Been trying with 2.4.20, 2.4.22, 2.6.0-test9, how the heck do I get this 
to work?

I set everthing up on /dev/shm type tmpfs, then 
cd /dev/shm
mkdir initrd
pivot_root . initrd


So yay, it's set up so that the cd is pointed to by a lotta links in 
tmpfs, and the stuff that needs to be rw (like /etc) is on the tmpfs.

That's good.

Of course, the kernel unmounts / and then swears that it can't find init 
when the linuxrc exits.

The documentation says that linuxrc should pivot_root to the real root in 
Documentation/initrd.txt so I thought that's what the script sholud do.  
Apparently the doc is bad/old.

Any ideas?

script follows.


====/linuxrc
#!/bin/sh
                                                                                                                                
# linuxrc for Genoppix initrd
# Basicly mounts the cdrom, sets up rw stuff, spins the root image
# around to the root, and exits.
echo "Genoppix Initrd Loaded, linuxrc executing in 5 seconds..."
sleep 5
mount none -t proc /proc
echo "Mounting cdrom..."
CDROM="/dev/cdrom"
if [ ! -e $CDROM ]; then
  CDROM="/dev/cdroms/cdrom0"
fi
mount $CDROM /mnt/root || (echo "FATAL: Cannot mount cdrom!" && sh)
echo "mounting tmpfs..."
mount none -t tmpfs /dev/shm || (echo "FATAL: Cannot mount tmpfs!" && sh)
echo "Building symlinks to cd root..."
cd /dev/shm
ln -s /mnt/root/* .
sleep 2.5
echo "Setting mnt and home to rw root..."
rm -f root home mnt
mkdir root home mnt
#echo "linking cdroot's new location to what will be cdroot's old 
location..."
#ln -s /mnt/initrd/mnt/root /dev/shm/mnt/root
echo "mounting cdrom at new root..."
mount $CDROM /dev/shm/mnt/root
echo "Pivoting root to shared memory filesystem..."
cd /dev/shm
mkdir initrd
pivot_root . initrd || (echo "Cannot pivot root!" && sh)
mount -t proc none /proc
echo "copying /etc to a rw /etc..."
rm -f etc
mount -t devfs none /dev
cp -R /mnt/root/etc .
echo "Root pivoted, making users..."
sleep 1
echo "creating homes for default users..."
cd /home
mkdir jak
mkdir tails
mkdir fox
mkdir krystal
chgrp users *
chown jak jak
chown tails tails
chown fox fox
chown tails tails
chown krystal krystal
echo "exiting linuxrc and starting init ;)

