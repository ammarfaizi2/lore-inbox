Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267988AbRHRVXt>; Sat, 18 Aug 2001 17:23:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268100AbRHRVXj>; Sat, 18 Aug 2001 17:23:39 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:29453 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S267988AbRHRVXc>; Sat, 18 Aug 2001 17:23:32 -0400
Message-ID: <3B7EDCC3.15610949@zip.com.au>
Date: Sat, 18 Aug 2001 14:23:15 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>,
        "ext3-users@redhat.com" <ext3-users@redhat.com>
Subject: ext3 0.9.6 for kernel 2.4.9
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is just a rediff and retest - no ext3 changes in this release.

	http://www.uow.edu.au/~andrewm/linux/ext3/

The latest diff is against linux-2.4.9.  The version of ext3 in
-ac kernels is current.

-ac's ext3 has the "buffer tracing" debug code removed from the
non-ext3 files, so the 2.4.9 diff is more useful for bug hunting.

I should generate a diff against -ac to enable buffer tracing, but
there doesn't seem to be a lot of call for it now - ext3 is in
Red Hat's "Rawhide" kernels, is in -ac and downloads from the
above site are still running at >100/day.  The bug report rate from
all of this is exceedingly low.

The current things outstanding for a 1.0 release are:

- There are now two reports of an interaction between ext3 and [v]fat.
  The symptoms are that fatfs decides to return ENOTDIR when its
  root directory is read.  This is rather bizarre - it may be due to
  ext3 leaving some unexpected state in a buffer_head, and fatfs
  is assuming that its buffers are coming in with that state zeroed.

  If anyone can reproduce this, please send me your .config, details
  of mountpoints, filesystem sizes, system config, shoe size, Mother's
  maiden name, etc.  Thanks.

- Two reports of an assertion failure in journal_revoke() - where the
  block was already revoked.  One report was from the intermezzo developers
  who were using `chattr +J' to enable data journalling on just part of a
  filesystem (I really haven't been testing this feature at all).  The
  other reporter had never used `chattr +J'.

  We can make this go away by clearing the revoke bits when refiling
  buffers for checkpoint writeback, but this should not be necessary.
  Still hunting for this one.

- Stephen has been working a largish change to the ext3 error handling.
  At present ext3 tends to go BUG() if any internal inconsistency is
  detected (ext3 is *very* defensive of your data).  But this is rather
  harsh so Stephen's changes are aimed at handling these errors more
  selectively - generally by turning the filesystem read-only when
  an inconsistency is detected.

- Documentation/filesystems/ext3.txt :)

Also, Andreas is working on changes to ext3's external journal
management.  This is post-1.0 material.


-
