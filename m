Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261680AbUEKASt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261680AbUEKASt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 20:18:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262176AbUEKASt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 20:18:49 -0400
Received: from shellutil.inch.com ([216.223.208.53]:64006 "EHLO util.inch.com")
	by vger.kernel.org with ESMTP id S261680AbUEKASl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 20:18:41 -0400
Date: Mon, 10 May 2004 20:20:08 -0400
From: John McGowan <jmcgowan@inch.com>
To: linux-kernel@vger.kernel.org
Subject: Kernel 2.6.6: Removing the last large file does not reset filesystem properties
Message-ID: <20040511002008.GA2672@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bug: Removing the last large file does not reset filesystem properties

SYSTEM: Pentium III, Fedora Core1 (gcc 3.3.2), Kernel 2.6.6

Symptom: [you can skip this]
----------------------------
 1: For the first week, at least, after installing a new kernel, I set the
    system to force fsck on boot (Fedora Core1, rc.local script to "touch"
    "/forcefsck").

 2: Home system, single user. Turn off at night. Turn off when I go to eat
    lunch. Etc. (reboot at least once each day - silly, but it is a single
    user system and I don't want to waste electricity and it gives better
    protection against storms and line spikes).
    
 3: Was using Gimp 2.0 and used a tool. Got a 6 Gig swap file in /tmp/gimp2
    (there must be a problem with that tool). Closed gimp, got rid of the
    swap file. Upon the next boot I got:
      FAILED!!
      Dropping to root command line for system maintenance
    (such fun ... entering the root password got more error messages about
    missing programmes such as "id" and "test" - well, I have "/usr" on
    another partition and it was not mounted).
  
  4: Typed reboot, everything was fine.
---------------------


CREATING/DUPLICATING THE PROBLEM:
---------------------------------
 So ... I created a 3Gig file, deleted it and booted to my "recovery"
 partition (I haven't removed RH72 yet, so I can boot to that to work
 on the Fedora system partitions without running e2fsck on a mounted,
 active, partition).
 
 I ran:
 
  PREFORCE:  dumpe2fs       on the Fedora Core1 partition
             e2fs -n -f -v  on the Fedora Core1 partition
  
  NOFORCE:   e2fs -v        on the Fedora Core1 partition
  
  FORCE:     e2fs -f -v     on the Fedora Core1 partition
  
  POSTFORCE: dumpe2fs       on the Fedora Core1 partition
             e2fs -n -f -v  on the Fedora Core1 partition

I was happy to see that there is no difference between the "e2fs -n -f -v"
run before and after the force of FSCK.

Running "e2fs -v" (no force, but not a read-only mount) did nothing 
("/1: clean, 35963/1154176 files, 197142/2303910 blocks"
 - by the way, since I still have RH72 on the system, the label of its
 root partition being "/", the root partition for Fedora is "/1")
since it was unmounted cleanly.

I was happy to see only one difference between the "dumpe2fs"
run before and after the force of FSCK (besides the time and mount count)


  AFTER DELETING THE LARGE FILE AND BEFORE FORCING FSCK:
    (dumpe2fs)
    Filesystem features:      has_journal filetype sparse_super large_file
    (e2fs -n -f -v)
    0 large files
  
  AFTER DELETING THE LARGE FILE AND FORCING FSCK:
    (dumpe2fs)
    Filesystem features:      has_journal filetype sparse_super
    (e2fs -n -f -v)
    0 large files

It looks like the only problem is that removing the last large file left the
filesystem thinking it had a large file. The error message given by Fedora
Core1 (if someone forces fsck and seldom has large files, for example, only
created by working on multimedia and they are later deleted) can be somewhat
unnerving.    
