Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264368AbTEPHzw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 May 2003 03:55:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264369AbTEPHzw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 May 2003 03:55:52 -0400
Received: from pimout3-ext.prodigy.net ([207.115.63.102]:10955 "EHLO
	pimout3-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S264368AbTEPHzs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 May 2003 03:55:48 -0400
From: Eugene Weiss <eweiss@sbcglobal.net>
Reply-To: eweiss@sbcglobal.net
To: linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] submount: another removeable media handler
Date: Fri, 16 May 2003 01:06:37 -0400
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200305160106.37274.eweiss@sbcglobal.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Submount:  Yet another attempt at solving the removeable media problem.  
 
It has been tested only on 2.5.66 and 2.5.69 so far, but should work on many
earlier 2.5.x kernels as well.  I would greatly appreciate feedback from
anyone who would like to check it out.  It is available at
http://sourceforge.net/projects/submount/ 
 
How it Works: 
 
It is composed of two parts: a kernel module and a userspace program.  
 
The kernel module, titled subfs, implements a dummy filesystem which is
mounted on the desired mountpoint.  Before a process can access a directory,
or any file bellow it, one of two filesystem methods must be called: open() or
lookup().  When subfs gets a call to either of these functions, it calls the
userspace part of submount, which then mounts the appropriate filesystem on
top of the subfs mountpoint, forks off a daemon for unmounting, and exits.  If
the mount was successful, subfs uses the signal handling system to restart the
system call, which then is executed on the real filesystem.  Subfs then
restarts the system calls of any other requests that arrived while the mount
was taking place. 
 
The userspace portion of submount is titled /sbin/submountd.  It is a small
program that does some minimal options processing, and then makes the mount()
system call.  If the mount is successful, it forks off a new process which
enters a one second loop checking whether the filesystem can be unmounted.   
 
 
Advantages: 
 
Small, light, and fast.  The kernel module is about 11kB, the user program
about 21kB. 
 
Requires no changes to the kernel code outside its own module. 
 
The kernel portion is very simple.  The feature set is implemented in
userspace. 
 
All IO is handled through the real filesystem at its full speed.  When the IO
is heaviest, submount imposes no performance penalty at all. 

Flexible.  Another program can be substituted for submountd if the system in
question has particular needs.  One could even use a shell script that calls
the regular mount and umount utilities. 
 
No configuration needed, except fstab. 
 
 
Problems: 
 
Not quite as fast as a permanently mounted filesystem, since the dentry cache
is purged on unmounting.  Directories must be read again each time they are
called after unmounting even though the disk hasn't changed. 
 
Errors are registered quietly.  If the user makes a typo in the mount command,
or in the fstab file, it may be necessary to read the system log to discover
it.  (Perhaps mount could be made to do some syntax checking when a subfs
filesystem is mounted?) 
 
Programs which automatically mount a cdrom directory from fstab can mount a
second subfs directory over the filesystem mounted by the first.  This could
be checked for in subfs, but it would be better to do it in the mount utility. 

 
Installation and usage: 
 
The sources, both kernel and userspace, can be downloaded from
http://sourceforge.net/projects/submount/ .  The userspace program is built in
the usual way, and a makefile is provided for building the kernel module. 
 
To mount a drive under subfs, use the usual syntax, except put subfs in the
filesystem type field, and add the option fs=<fstype> in the options list. 
 
for example	mount -t subfs /dev/scd0 /mnt/cdrom -o fs=iso9660,ro 
or for fstab	/dev/scd0 /mnt/cdrom subfs fs=iso9660,ro 
 
I've copied the function to find the filesystem type by reading the superblock
from mount, so fs=auto will work.  It can, however, cause a noticeable pause,
particularly on floppies, so there is another method for using multiple
filesystems.  If a keyword is used in the fs= option, submountd will attempt
to mount filesystems from a list.  Currently there are two options: 
fs=floppyfss attempts vfat and ext2, and fs=cdfss tries iso9660 and udf. 
Submountd will strip the options "codepage", "iocharset" and "umask" from
filesystems that don't take them, so these can be included in list mounts, or
auto-detected mounts. 
 
These fstab lines should work: 
 
/dev/scd0 /mnt/cdrom subfs fs=cdfss,ro,iocharset=iso8859-1,umask=0 0 0 
/dev/fd0 /mnt/floppy subfs fs=floppyfss,iocharset=iso8859-1,sync,umask=0 0 0 
 
Once this is done, just access the mountpoint directory as usual. 
 
Eugene Weiss <eweiss@NOSPAM.sbcglobal.net> 

