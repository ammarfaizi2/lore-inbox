Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261733AbUKPNzg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261733AbUKPNzg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 08:55:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261735AbUKPNzg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 08:55:36 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:34209 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S261733AbUKPNz3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 08:55:29 -0500
Date: Tue, 16 Nov 2004 19:22:00 +0530
From: Ravikiran G Thirumalai <kiran@in.ibm.com>
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Kai Makisara <Kai.Makisara@metla.fi>, Willem Riede <osst@riede.org>,
       coda@cs.cmu.edu, Paul Mackerras <paulus@samba.org>
Subject: [patch 0/4] Cleanup file_count usage
Message-ID: <20041116135200.GA23257@impedimenta.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset is an attempt to cleanup some bogus and some not so bogus 
reads to struct file.f_count of the vfs from various subsystems in the 
kernel. This patchset doesn't cleanup uses of f_count completely;
Geting rid of all reads to f_count was suggested by Viro during the discussion
on kref based lockfree fd management sometime back.

This cleans up:
1. Wrong usage of f_count in .open and .release routines of some file
   systems
2. Error messages and warnings based on reads to f_count
3. Redundant check based on file_count in the vfs
4. Usage of file_count in hugetlb to report number of attaches

Patchset to follow.

What remains:
1. Hack to return error code to user space at last close through file_count
   check at the driver's flush routine.  This hack is used in scsi/st.c,
   scsi/osst.c and coda/file.c to return error code through .flush() 
   (Although it is doubtful if applications check for error during close(2)).
   Kai has a patch to cleanup scsi/st.c.  I will make patches to move last 
   close code from .flush() to .release() in the coda filesystem if no one 
   objects to it.  Not sure if you can do anything on errors at close...
   Suggestions on alternatives welcome.
2. Read to f_count at drivers/net/ppp_generic.c:
   The PPPIOCDETACH ioctl is failed if the device fd is duped and
   being polled by another process -- which is determined by a read
   to f_count.  The comments in the code indicate that the PPPIOCDETACH 
   ioctl should be junked and userland can use a workaround
   by closing the fd and reopening /dev/ppp.  I can make a patch to junk
   PPPIOCDETACH, but is it okay to break binary compatibility? Paul?
3. Usage of file_count in the AF_UNIX garbage collector (unix_gc)

Thanks,
Kiran
