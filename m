Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270025AbRIAAkA>; Fri, 31 Aug 2001 20:40:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269971AbRIAAjv>; Fri, 31 Aug 2001 20:39:51 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:21450 "EHLO
	e33.bld.us.ibm.com") by vger.kernel.org with ESMTP
	id <S269962AbRIAAjm>; Fri, 31 Aug 2001 20:39:42 -0400
Subject: Re: [RFD] readonly/read-write semantics
To: Goswin Brederlow <goswin.brederlow@student.uni-tuebingen.de>
Cc: Goswin Brederlow <goswin.brederlow@student-uni-tuebingen.de>,
        linux-fsdevel@vger.kernel.org, linux-fsdevel-owner@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jean-Marc Saffroy <saffroy@ri.silicomp.fr>,
        Linus Torvalds <torvalds@transmeta.com>,
        Alexander Viro <viro@math.psu.edu>
X-Mailer: Lotus Notes Release 5.0.5  September 22, 2000
Message-ID: <OFD8AF2BD0.34BE14E6-ON87256ABA.000279DF@boulder.ibm.com>
From: "Bryan Henderson" <hbryan@us.ibm.com>
Date: Fri, 31 Aug 2001 17:38:19 -0700
X-MIMETrack: Serialize by Router on D03NM088/03/M/IBM(Release 5.0.8 |June 18, 2001) at
 08/31/2001 06:38:22 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> 2) I'd like to see a readonly mount state defined as "the filesystem
will
>> not change.  Period."  Not for system calls in progress, not for cache
>> synchronization, not to set an "unmounted" flag, not for writes that are
>> queued in the device driver or device...
>Thats what readonly does now, isn't it?

No, it's much more sloppy than that today.  The mount is slammed into the
readonly state and writes in progress continue to modify the filesystem
medium.  The remount system call does a weak check to see that there is no
writing going on before proceeding to set the readonly flag on.  A mkdir in
progress continues to complete.  A properly timed open for write could even
slip in.  The the opener can write away while the mount is in "readonly"
state.  And finally, Al points out that a filesystem driver that gets
scared by some consistency error may stamp its foot and declare "readonly"
state right under the nose of of open-for-write file descriptors, which
allow continued writing.

>But you want that also to be
>when the filesystem is writeable but not being written to at the
>moment, i.e. if its in a consistent state or "clean".

Well, no I don't.  That's another state.  And the mount goes in and out of
that state all the time without any help from us, so the only issue would
be detecting the state to make it useful.  I used to think Unix filesystems
always did that, but I don't seem to be able to get an ext2 filesystem
(mounted r/w) into no-fsck-required state without actually unmounting it.


