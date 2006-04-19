Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751115AbWDSRSw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751115AbWDSRSw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 13:18:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751118AbWDSRSv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 13:18:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:40089 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751115AbWDSRSv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 13:18:51 -0400
From: Chris Mason <mason@suse.com>
To: linux-kernel@vger.kernel.org, akpm@osdl.org, andrea@suse.de
Subject: [RFC] copy_from_user races with readpage
Date: Wed, 19 Apr 2006 13:18:45 -0400
User-Agent: KMail/1.9.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604191318.45738.mason@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone,

I've been working with IBM on a long standing bug where zeros unexpectedly pop 
up during a disk certification test.  We tracked it down to copy_from_user.  
A simplified form of the test works like this:

memset(buffer, 0x5a, 4096);
fd = open("/dev/some_disk", O_RDWR);
write(fd, buffer, 4096);
pid = fork();
if (pid) {
    while(1) {
        lseek(fd, 0, 0);
        read(fd, buf2, 4096);
    }
} else {
    while(1) {
        lseek(fd, 0, 0);
        write(fd, buffer, 4096);
    }
}

First we fill a given block in the file with a specific pattern.  Then we 
fork.  One proc writes that exact same pattern over and over, and the other 
proc reads from the block over and over.

The reads and writes race, but you would expect the read to always see the 
0x5a pattern.  If we introduce enough memory pressure, sometimes the read 
sees zeros instead of the pattern because of kmap_atomic:

cpu1                                            cpu2
file_write 
(page now up to date)
file_write                                     file_read
__copy_from_user (atomic)
                                                   file_read_actor
                                                   copy_to_user
__copy_from_user (non-atomic)

The first copy_from_user fails because of a page fault.  So, the destination
page is zero filled, which is the data found by file_read_actor().  The second 
copy_from_user succeeds and puts the proper data in the page.

The solution seems to be a non-zeroing copy_from_user, but this is only 
required on arches where kmap_atomic incs the preemption count.  Andrea has a 
patch for i386 that does this (small and obvious), along with some memsets to 
zero out the kernel page when copy_from_user fails.

This feature has been present for quite a while, and I think it should be 
fixed.  But before we go through making a patch for ppc (any other arches 
affected?) I wanted to poll here and make sure people agreed the zeros are 
not correct.

-chris
