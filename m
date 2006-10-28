Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932088AbWJ1ThS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932088AbWJ1ThS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Oct 2006 15:37:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932096AbWJ1ThS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Oct 2006 15:37:18 -0400
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:54987
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S932088AbWJ1ThR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Oct 2006 15:37:17 -0400
From: Rob Landley <rob@landley.net>
To: linux-kernel@vger.kernel.org
Subject: Problems with /proc/mounts and statvfs (implementing df).
Date: Sat, 28 Oct 2006 15:37:06 -0400
User-Agent: KMail/1.9.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610281537.07145.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm trying to implement a df command that works based on /proc/mounts and 
statvfs.  To make this work, I need to be able to detect duplicate mounts 
(including --bind mounts), and I need to be able to detect overmounted 
filesystems.

Problem #1: mount --move doesn't reorder /proc/mounts.

My first naieve idea was to reverse the order of entries in /proc/mounts and 
do simple string comparisons on the directory names to detect overmounts.  An 
example of why this doesn't work is in ubuntu 6.06, where "/proc" and "/sys" 
get mounted from initramfs, then the new root (/dev/hda1 in my case) is 
mounted after that, and the proc and sys mounts are "mount --move"d under 
that.  So they're before the current "/" in the /proc/mounts order, but 
they've been moved under that mount anyway.  It would be really nice if 
mount --move would reorder /proc/mounts when the new parent filesystem is 
after the old one in the list.  (Another thing that depends on this to work 
is "umount -a", which can't umount "/" in this case either because /proc 
and /sys are still under it.)

In theory I can work around this by just having umount -a loop until 
everything's unmounted (which is ugly), and by having df call statvfs on 
everything and discard duplicate f_fsid entries (although with mount --move 
it can still find the wrong entry mounted at a given mount point, but at 
least this can filter sub-mounts and restricts the problem to direct 
overmounts).

Problem #2: statfs() and statvfs() are returning 0 in the f_fsid.

What's the recommended way to detect --bind mounts or duplicate mounts?  A df 
command needs to know "these two mount points are in the same filesystem", 
and according to the man pages there's supposed to be a unique identifier for 
each filesystem.

The man page suggested that this was crippled to work around yet another 
design flaw in NFS, but I tried doing it as root and still got 0 for all the 
filesystems.  (Not that setting the suid bit on the df command struck me as a 
good solution.)

Any suggestions?  (All this was done on the ubuntu 6.06 kernel.  Will it make 
a difference to try 2.6.19-rc3?)

Rob
-- 
"Perfection is reached, not when there is no longer anything to add, but
when there is no longer anything to take away." - Antoine de Saint-Exupery
