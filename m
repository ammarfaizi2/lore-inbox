Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu id <154931-8316>; Wed, 9 Sep 1998 01:16:08 -0400
Received: from noc.nyx.net ([206.124.29.3]:4608 "EHLO noc.nyx.net" ident: "mail") by vger.rutgers.edu with ESMTP id <155150-8316>; Tue, 8 Sep 1998 22:33:06 -0400
Date: Tue, 8 Sep 1998 22:46:25 -0600 (MDT)
From: Colin Plumb <colin@nyx.net>
Message-Id: <199809090446.WAA25923@nyx10.nyx.net>
X-Nyx-Envelope-Data: Date=Tue Sep  8 22:46:25 1998, Sender=colin, Recipient=, Valsender=colin@localhost
To: andrejp@luz.fe.uni-lj.si
Subject: Re: GPS Leap Second Scheduled!
Cc: linux-kernel@vger.rutgers.edu
Sender: owner-linux-kernel@vger.rutgers.edu

Ulrich Windl wrote:
> The time in the kernel is seconds since the epoch. To insert a second 
> means that we'll have to delay the next second for another second. 
> The other solution seems to be a clib -> kernel interface that knows 
> that a leap second is active now. Then the clib could possibly 
> convert the seconds to xx:yy:60. (I hope I did not overlook something 
> obvious).

And Andrej Presern replied:
>> Have you considered simply not scheduling any processes for one second and
>> adjusting the time accordingly? (if one second chunk is too big, you can do
>> it in several steps)

The problem is that POSIX is schizophrenic on the subject of leap seconds.
On the one hand, time() returns UTC time.  On the other,

	t = time();
	sec = t % 60;
	t /= 60;
	min = t % 60;
	t /= 60;
	hr = t % 24;
	t /= 24;
	printf("UTC time is %lu days, %02u:%02u:%02u\n", (unsigned long)t, gr, min, sec);

is required to work (since so much code does it.)

Actually, I think Ulrich was present when I proposed a similar solution:
gettimeofday() will not return during 23:59:60.  If a process calls
gettimeofday() during a leap second, then the call will sleep until 0:00:00
when it can return the correct result.

This horrified the real-time people.  It is, however, strictly speaking,
completely correct.

The real-world solution (a.k.a kludge), is to stretch some number of
seconds to cover the n+1 seconds including the leap second.  During
those seconds, gettimeofday() is incorrect, but the error is
well-defined, so two "good" implementations will return "close" values
and you can undo the fudging afterwards if desired.

The only trick is to define the number of seconds n, their position
relative to the leap second, and they type of stretching.  Linear is
obvious, making the 60 seconds leading up to a leap second take 61/60
of the usual time, but you could define a polynomial with higher-order
continuity.
-- 
	-Colin

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/faq.html
