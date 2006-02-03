Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964862AbWBCDAm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964862AbWBCDAm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 22:00:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964863AbWBCDAm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 22:00:42 -0500
Received: from grunt15.ihug.co.nz ([203.109.254.62]:54675 "EHLO
	grunt15.ihug.co.nz") by vger.kernel.org with ESMTP id S964862AbWBCDAl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 22:00:41 -0500
From: "Gavin Lambert" <gavinl@compacsort.com>
To: <linux-kernel@vger.kernel.org>
Subject: Framebuffer mmaping on nommu
Date: Fri, 3 Feb 2006 16:00:24 +1300
Organization: Compac Sorting Equipment
Message-ID: <00ca01c6286d$fa8f27f0$4800a8c0@gavinlpc>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4024
X-Mimeole: Produced By Microsoft MimeOLE V6.00.2900.2180
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Please CC me; I'm not subscribed because I couldn't handle the list
volume!] :)

I'm trying to write a framebuffer driver for an LCD controller on a
Coldfire-based NOMMU board.  (m68knommu, 5272)

I'm running into some trouble when trying to mmap the framebuffer from
user space, though.

I'm using Linux 2.6.15-1 (with the uClinux uc0 patchset applied).

Problem 1:
  in Documentation/nommu-mmap.txt, it mentions that the framebuffer
driver is one of those that handles get_unmapped_area and passes it on
to the device-specific driver.  I can find no trace of that in
drivers/video/fbmem.c, however -- the only time it implemented
get_unmapped_area is on sparc64, and even then it doesn't pass anything
on to the FB driver itself.

Problem 2:
  I've created a framebuffer chardev node (/dev/fb0) in my romfs
filesystem (uClinux standard setup).  I can open and ioctl the node just
fine.  However, when I try to mmap it I get errors:

  - mmap(NULL, fix.smem_len, PROT_READ | PROT_WRITE, MAP_FILE |
MAP_SHARED, fb_fd, 0)
    returns ENODEV; I've traced this to mm/nommu.c
(validate_mmap_request), where it copies the capabilities out of the
backing_dev_info.  In this case, the only capability provided is
BDI_CAP_MAP_COPY.  The code a bit further down that detects that it's a
chardev won't execute (because it already has nonzero capabilities), and
so since it never adds BDI_CAP_MAP_DIRECT the shared mapping fails.  If
I comment out the code that gets the capabilities from the
backing_dev_info, then the switch executes, it detects that it's a
chardev, and the mapping succeeds.

    I have no idea where this backing_dev_info stuff is coming from; I
haven't encountered it before and I'm not sure what it is.

  - mmap(NULL, fix.smem_len, PROT_READ | PROT_WRITE, MAP_FILE |
MAP_PRIVATE, fb_fd, 0)
    this triggers a BUG (in do_mmap_private), specifically BUG_ON(ret ==
0 && !(vma->vm_flags & VM_MAYSHARE));
    I'm not really expecting this to work (because if the data is copied
then it won't be picked up by the framebuffer any more), but a BUG seems
a little excessive.

Am I just doing something really dumb, or is something a bit b0rken?

