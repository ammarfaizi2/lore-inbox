Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261859AbREQTra>; Thu, 17 May 2001 15:47:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261866AbREQTrK>; Thu, 17 May 2001 15:47:10 -0400
Received: from wombat.educ.indiana.edu ([129.79.219.48]:62345 "EHLO
	wombat.educ.indiana.edu") by vger.kernel.org with ESMTP
	id <S261859AbREQTrH>; Thu, 17 May 2001 15:47:07 -0400
From: Brian Wheeler <bdwheele@wombat.educ.indiana.edu>
Message-Id: <200105172000.f4HK00V19810@wombat.educ.indiana.edu>
Subject: Re: LANANA: To Pending Device Number Registrants
To: linux-kernel@vger.kernel.org
Date: Thu, 17 May 2001 15:00:00 -0500 (EST)
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ I normally just lurk and read the archives, but...here's where I get into
  trouble! ]

It seems to me that there are several issues that have come up in this thread,
but here are my thoughts on some of them:

* Identifying hardware:
	Since we don't want to use topology as the primary method of 
  identifying a device, perhaps it could be the secondary method.  If a device
  id consisted of several parts, userspace could make an educated guess about
  which devices correspond to which names, across reboots.  Consider an ID
  consisting of:
	* vendor 
	* model 
	* serial number 
	* content-cookie 
	* topology-cookie 
  The two cookie values are opaque, but reproducable.  The content cookie might
  be an MD5 of the partition table of a disk, or its serial number, or 
  something to that effect.  The topology cookie would some topology 
  parameters (such as mem address, irq, io ports, slot #, etc) which could be 
  used to identify the device later.  These are only used for identification, 
  not for discovering topology.

  If all 5 fields match, then we know what it is.  If only topology-cookie is 
  different, then it just moved.  If content-cookie is different then it might
  be a different device  (There's a trickyness to partitioning, I suppose).

  I suppose these ID fields could also be used by a userspace tool to 
  load/unload drivers as necessary.

  The id could also determine the device is only inaccessable (not removed)
  when it disappears.  So, if disk5 disappeared on reboot, the next disk
  added would be given an ID at the end of the list, while disk5 would remain
  unused.  Only on a 'cleanup' would disk5 become reassignable.  This fixes
  issues like a device being unpowered on boot and a new one being powered up.


* User-space device naming
  I think the diskN naming is nice.  "randomly assigned" major ids won't be a
  problem, except on NFS mounted /dev directories.  If the kernel maintained
  a filesystem (like devfs or proc) which always managed the "currently 
  available" devices the only problem to solve would be dealing with software
  which opens the /dev node to get a driver loaded.

  <pipe_dream>
  It would be very cool if the dev filesystem could be exported to other linux
  boxes, so you could transparently have access to block devices (like nbd does
  now) and character devices (like the sound card)

  mount -t dev -o other_machine /dev/other_machine
  cat foo.au > /dev/other_machine/audio &
  </pipe_dream>


* IOCTL
  Since ioctl() is commonly regarded as a kluge, is there any reason why it
  couldn't be replaced by the /dev/fb0/frame0 thing that was described earlier?
  The libc implementation of ioctl could convert the binary data back into 
  text calls.  Gross, but possible...though it would probably be better to just
  depreciate the ioctl mechanism.   It could also package it for remote 
  usage (see my pipe_dream above).

  If device info/controls are tied to subdirectory entries, it would be nice
  to be able to get a device's capabilities via existance checking...
  I.E. '-e /dev/disk0/eject' could check of the device is ejectable.


Brian Wheeler
bdwheele@indiana.edu
