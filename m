Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932390AbWDMUgT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932390AbWDMUgT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 16:36:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964956AbWDMUfx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 16:35:53 -0400
Received: from locomotive.csh.rit.edu ([129.21.60.149]:32790 "EHLO
	locomotive.unixthugs.org") by vger.kernel.org with ESMTP
	id S964827AbWDMUft (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 16:35:49 -0400
Date: Thu, 13 Apr 2006 16:35:45 -0400
From: Jeff Mahoney <jeffm@suse.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH 00/08] dm: serious race conditions need addressing
Message-ID: <20060413203545.GA3159@locomotive.unixthugs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Operating-System: Linux 2.6.5-7.201-smp (i686)
X-GPG-Fingerprint: A16F A946 6C24 81CC 99BB  85AF 2CF5 B197 2B93 0FB2
X-GPG-Key: http://www.csh.rit.edu/~jeffm/jeffm.gpg
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 Hi all -

 While recently hunting down a series of different Oopses observed
 in the dm code on multiprocessor systems, I discovered the cause:
 There are serious race conditions in the dm subsystem.

 The biggest is a result of a patch submitted in Aug 2004 that converted
 the minor tracking code from using a dynamically allocated bitmap to
 an IDR. With a bitmap, it was enough to mark a minor as allocated, but
 the IDR patch used the mapped_device itself to mark a minor off.

 I'm surprised we haven't seen many more dm bug reports that we have,
 since the approach has a key problem: It places an incompletely
 initialized structure on a subsystem-wide IDR, and then drops the lock
 protecting the IDR before it completes the initialization. The result is
 that the rest of the subsystem is free to access the mapped_device, and
 the results can vary depending on where in the initialization process the
 mapped_device is.

 cpu1 (dmsetup create)				cpu2 (dmsetup anything else)
 alloc_dev				        
 ->next_free_minor				
   (now is in IDR)				 find_device
   						    -> dm_get_md (looks in IDR)
						 * does something with
						   uninitialized data *
   .. finishes initializing,
   overwriting anything the
   other path has done

 I've observed a number of different faults, including generic bad
 pointer derefs, and BUGs from mempool due to reference count
 corruption resulting in an early deallocation.

 There are other races where dm_get() occurs on pointers obtained from
 the IDR after the _minor_lock has been dropped. The pointer in this case
 could be stale, since the last reference may have been dropped when the
 lock was released.

 The block layer gets a referenceless pointer to the device. In order to
 ensure dm_blk_open isn't occuring while the last reference is being
 dropped, it needs to ensure that the pointer is still valid.

 The final, more minor, race is that the device continues intializing after
 being registered with the block subsystem. A race exists where the event
 generated in register_disk could be handled before the device completes
 initializing.

 In the spirit of submitting patches with small obvious changes, the following
 8 patches fix up reference counting in the dm subsystem.
 01 - adds an idr_replace IDR library function, so a pointer can be replaced
      without needing to do a remove/add pair when a simple traverse-once-
      and-assign function will do the same work.
 02 - uses a placeholder value to indicate a minor is allocated but
      unavailable for use, and then replaces it with the pointer after the
      device is completely initialized.
 03 - idr_pre_get() is supposed to be called outside of locks and handles
      the locking of internal structures itself. This patch moves
      idr_pre_get outside of the _minor_lock, in preparation for patch 04.
 04 - replaces the _minor_lock mutex with a spinlock so that
      atomic_dec_and_lock can be used to properly serialize reference counting
      and deallocation.
 05 - Due to a chicken/egg problem between dm and the block layer,
      gendisk->private_data gets a referenceless pointer to the mapped_device.
      This patch adds a DMF_FREEING flag so that the pointer can be validated
      before use in dm_blk_open().
 06 - In paths where we're searching the IDR, or otherwise holding the
      _minor_lock, take the reference while still holding the lock, so
      we don't race against dm_put.
 07 - Currently, it is possible to unload dm-mod while devices are still in
      use. This patch bumps the reference count on device creation and
      drops it on removal. Taking a self reference is safe, alloc_dev is
      only called from the ioctl path, which must already hold a dm-mod
      reference from opening the control file.
 08 - Move the last bit of mapped_device initialization above the registration
      with the block layer, so that we can ensure the device is completely
      initialized before another path gets to it. add_disk()->register_disk()
      will cause an event to be generated, so it is possible for a race to
      occur given the right conditions.

 -Jeff
