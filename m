Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267662AbRGZH1u>; Thu, 26 Jul 2001 03:27:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267672AbRGZH1l>; Thu, 26 Jul 2001 03:27:41 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:9735 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S267662AbRGZH1c>; Thu, 26 Jul 2001 03:27:32 -0400
Message-ID: <3B5FC7FB.D5AF0932@zip.com.au>
Date: Thu, 26 Jul 2001 17:34:19 +1000
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>,
        "ext3-users@redhat.com" <ext3-users@redhat.com>
Subject: ext3-2.4-0.9.4
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

An update to the ext3 filesystem for 2.4 kernels is available at

	http://www.uow.edu.au/~andrewm/linux/ext3/

The diffs are against linux-2.4.7 and linux-2.4.6-ac5.

The changelog is there.  One rarely-occurring but oopsable bug
was fixed and several quite significant performance enhancements
have been made.  These are in addition to the performance fixes
which went into 0.9.3.

Ted has put out a prelease of e2fsprogs-1.23 which supports
filesystem type `auto' in /etc/fstab, so it is now possible to
switch between ext3- and non-ext3-kernels without changing
any configuration.

It is recommended that users of earlier ext3 releases upgrade
to 0.9.4.

For people who are undertaking performance testing, it is perhaps
useful to point out that ext3 operates in one of three different
journalling modes, and that these modes have very different
functionality and very different performance characteristics.
Really, you need to test all three and balance the functionality
which each mode offers against the throughput which you obtain
in your application.


The modes are:

data=writeback

  This is classic metadata-only journalling.  File data is written
  back to the main fs lazily.  After a crash+recovery the fs's
  structural integrity is preserved, but the *contents* of files
  can and will contain old, stale data.  Potentially hundreds of
  megabytes of it.

  This is the fastest mode for normal filesystem applications.

data=ordered

  The fs ensures that file data is written into the main fs prior
  to committing its metadata.  Hence after a crash+recovery, your
  files will contain the correct data.

  This is the default operating mode and throughput is good. It
  adds about one second to a four minute kernel compile when
  compared with ext2.   Under heavier loads the difference
  becomes larger.

data=journal

  All data (as well as to metadata) is written to the journal
  before it is released to the main fs for writeback.
  
  This is a specialised mode - for normal fs usage you're better
  off using ordered data, which has the same benefits of not corrupting
  data after crash+recovery.  However for applications which require
  synchronous operation such as mail spools and synchronously exported
  NFS servers, this can be a performance win.  I have seen dbench
  figures in this mode (where the files were opened O_SYNC) running
  at ten times the throughput of ext2.  Not that this is the expected
  benefit for other applications!


Looking at the above issues, one may initially think that the
post-recovery data corruption is a serious issue with writeback mode,
and that there are big advantages to using journalled or ordered data.

However, even in these modes the affected files may be shorter-than-expected
after recovery, because the app hadn't finished writing them yet.  And
usually, a truncated file is just as useless as one which contains
garbage - it needs to be deleted.

It's not really as simple as that - for small (< a few hundred k) files,
it tends to be the case that either the whole file is intact after a crash,
or none of it is.  This is because the journalling mechanism starts a
new transaction every five seconds, and a typical open/write/close operation
usually fits entirely inside this window.

There is also a security issue to be considered: a recovered writeback-mode
filesystem will expose other people's old data to unintended recipients.


Hopefully this description will help people make their deployment choices.
If not, assistance is available on the ext3-users@redhat.com mailing list.

-
