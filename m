Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu id <154675-8316>; Wed, 9 Sep 1998 14:10:52 -0400
Received: from noc.nyx.net ([206.124.29.3]:4323 "EHLO noc.nyx.net" ident: "mail") by vger.rutgers.edu with ESMTP id <154797-8316>; Wed, 9 Sep 1998 13:37:56 -0400
Date: Wed, 9 Sep 1998 14:13:42 -0600 (MDT)
From: Colin Plumb <colin@nyx.net>
Message-Id: <199809092013.OAA10252@nyx10.nyx.net>
X-Nyx-Envelope-Data: Date=Wed Sep  9 14:13:42 1998, Sender=colin, Recipient=, Valsender=colin@localhost
To: tytso@MIT.EDU
Subject: Re: GPS Leap Second Scheduled!
Cc: andrejp@luz.fe.uni-lj.si, linux-kernel@vger.rutgers.edu
Sender: owner-linux-kernel@vger.rutgers.edu

> Hence, the above equation would have the same value for 23:59:60 and
> 00:00:00 on the next day.  Hence, time() should return the same value.

The problem becomes more acute for gettimeofday() and the POSIX
ns-resolution equivalent, clock_gettime(CLOCK_REALTIME).

There are a few axioms that you'd like to have hold:

- time() and gettimeofday() return the same time as
  clock_gettime(CLOCK_REALTIME), as far as precision permits.
- gettimeofday() never returns the same value twice (documented BSD behaviour)
- no clock ever runs backwards

This makes the handling of the tv_usec or tv_nsec parts of the time during
a leap second a bit problematic.

One option is to count twice.
One option is to count at half speed during 23:59:60 and 0:00:00.
One option is to use the curve y = 1/4*x^3 - 3/4*x^2 + x to interpolate
y smoothly from 0 to 1 as x goes from 0 to 2.
One option is to freeze the fractional part fr one of the two seconds.
One (pretty rude) option is to count tv_usec from -1000000 to -1
during 23:59:60.  (tv_usec is a *signed* long.)

I don't know of a pretty way.  What I'd like, as I said, is a defined kludge,
so that there is a defined mapping between struct timeval and struct timespec
and UTC in the vicinity of a leap second.  This ensures that timestamps
collected on different machines can at least be compared, even if the
time intervals reported are incorrect.  ("Why were my ping times
half of usual at midnight last night?")
-- 
	-Colin

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/faq.html
