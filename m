Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270138AbRIECeV>; Tue, 4 Sep 2001 22:34:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269804AbRIECeM>; Tue, 4 Sep 2001 22:34:12 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:49397 "EHLO
	e31.bld.us.ibm.com") by vger.kernel.org with ESMTP
	id <S269404AbRIECeE>; Tue, 4 Sep 2001 22:34:04 -0400
Subject: Re: [RFD] readonly/read-write semantics
To: Alexander Viro <viro@math.psu.edu>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jean-Marc Saffroy <saffroy@ri.silicomp.fr>,
        Linus Torvalds <torvalds@transmeta.com>
X-Mailer: Lotus Notes Release 5.0.5  September 22, 2000
Message-ID: <OF89E1F633.FD6C3C44-ON87256ABE.000D60C3@boulder.ibm.com>
From: "Bryan Henderson" <hbryan@us.ibm.com>
Date: Tue, 4 Sep 2001 19:34:17 -0700
X-MIMETrack: Serialize by Router on D03NM088/03/M/IBM(Release 5.0.8 |June 18, 2001) at
 09/04/2001 08:34:19 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>So the most you would need
>> to wait for in going into the hard "read only" state I defined is for
any
>> page I/O to complete.  And for the "no new writes" state, you just write
>> protect all the pages (and any new ones that fault in too).
>
>It's not that simple.  At the very least you need an equivalent of msync()
>on each of these mappings before you can do anything of that kind.

I agree.  An ordinary remount shouldn't immediately go into hard readonly
state.  It should spend some time in no-new-writes state, during which it
flushes buffered writes, and I include in that dirty VM mapped pages, and
closes the filesystem.

My most basic point underlying all this, though, is that it should _not_
wait for all the files open for write to close (or fail because because
they haven't).

I thought there were also emergency cases where the filesystem driver
didn't want any more writing going on for fear of causing more damage.
That's why I mentioned the case where you might want to go straight to hard
readonly state.

>BTW, for real fun think of the situation when you have one of the swap
>components in a regular file on your filesystem.  Do you seriously want
>do_remount() to do automagical swapoff(2) on relevant swap components?

There are all kinds of ways I can shoot myself in the foot by making a
mount readonly that I really want to be writing through.  Is this one
special?

>IMO it's a userland job.

Sounds right to me.  We weren't going to talk about implementation yet,
though.  For starters, it would just be nice to agree what MS_RDONLY means
(and perhaps a few other similar flags).


