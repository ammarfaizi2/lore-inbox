Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269787AbRHaXgc>; Fri, 31 Aug 2001 19:36:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269786AbRHaXgX>; Fri, 31 Aug 2001 19:36:23 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:34557 "EHLO
	e32.bld.us.ibm.com") by vger.kernel.org with ESMTP
	id <S269756AbRHaXgP>; Fri, 31 Aug 2001 19:36:15 -0400
Subject: Re: [RFD] readonly/read-write semantics
To: Alexander Viro <viro@math.psu.edu>
Cc: linux-fsdevel@vger.kernel.org, linux-fsdevel-owner@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jean-Marc Saffroy <saffroy@ri.silicomp.fr>,
        Linus Torvalds <torvalds@transmeta.com>
X-Mailer: Lotus Notes Release 5.0.5  September 22, 2000
Message-ID: <OF8E62B3C8.CD1E8E23-ON87256AB9.007E8B1A@boulder.ibm.com>
From: "Bryan Henderson" <hbryan@us.ibm.com>
Date: Fri, 31 Aug 2001 16:35:07 -0700
X-MIMETrack: Serialize by Router on D03NM088/03/M/IBM(Release 5.0.8 |June 18, 2001) at
 08/31/2001 05:35:09 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


1) I want to see files open for write have nothing to do with it.  Unix
open/close is not a transaction, it's just a connection.  Some applications
manage to use open/close as a transaction, but we're seeing less and less
of that as more sophisticated facilities for transactions become available.

How many times have we all been frustrated trying to remount read only when
some log file that hasn't been written to for hours is open for write?

A file write is in progress when a write() system call hasn't returned, not
when the file is open for write.

Someone who wants to coordinate his mounts with the applications that use
them should use an external locking scheme.

2) I'd like to see a readonly mount state defined as "the filesystem will
not change.  Period."  Not for system calls in progress, not for cache
synchronization, not to set an "unmounted" flag, not for writes that are
queued in the device driver or device.  (That last one may stretch
feasability, but it's a worthy goal anyway).

3) A system call to put a mount into readonly state should not return until
all writes in progress have completed out to the medium, and the cache is
clean.  It should sync the cache, of course, and do whatever closing of the
filesystem an unmount would do.  Any attempt to start a new write during
this wait (which constitutes another mount state) should fail.

I was thinking an option to fail immediately instead of waiting for writes
to complete might be useful, but then I couldn't think of any write in
progress that would take enough time to make it worthwhile.  As long as any
new system call counts as a new write.

The same thinking applies to an option to kill writes in progress without
waiting.  Unless maybe it means to skip the cache synchronization.

4) I don't think it has any semantic relevance, but as part of this, I'd
also like to see the FS implementation stop considering read only mount
status to be a file permission issue.  (Today, it does in some places, but
doesn't in others).

I don't know enough about how filesystem drivers use the "readonly" state
today for damage control when errors happen, so I won't give an opinion on
that.  But it sounds like it would probably be that quiescing state I
mentioned in (3), not the readonly state I mentioned in (2).


