Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu id <156269-219>; Sat, 12 Dec 1998 17:05:20 -0500
Received: from noc.nyx.net ([206.124.29.3]:1911 "EHLO noc.nyx.net" ident: "mail") by vger.rutgers.edu with ESMTP id <156414-219>; Sat, 12 Dec 1998 13:05:42 -0500
Date: Sat, 12 Dec 1998 11:27:07 -0700 (MST)
From: Colin Plumb <colin@nyx.net>
Message-Id: <199812121827.LAA14426@nyx10.nyx.net>
X-Nyx-Envelope-Data: Date=Sat Dec 12 11:27:07 1998, Sender=colin, Recipient=linux-kernel@vger.rutgers.edu, Valsender=colin@localhost
To: linux-kernel@vger.rutgers.edu
Subject: Re: kernel knowledge of localtime
Sender: owner-linux-kernel@vger.rutgers.edu

The Right Thing to do is to have the timezone of a filesystem be
a mount option.  Then you need a simple localtime/GMT translation
table for the file system and everything can work.

Now, usually the time zone of the file system is the time zone
that the machine is sitting in, but network servers might change
that, and you really would like file timestamps not to suddenly
warp at a DST change (screwing up your file mirroring, backups
and who knows what else).

To steal from the standard user-level Olson time zone facilities, all you
need is a simple table of (localtime,GMT) pairs describing the first
moment of each offset.  In my home town, that's 232 changes in the
span of Unix time_t, so we're talking 1856 bytes.

That could be reduced if necessary, but it's certainly nothing to
panic about.  modprobe could even be hacked (or a wrapper added)
to extract the relevant data out of the user-land time zone files
and stuff it into the kernel on demand.

To translate a time, you look for (binary search) the interval which
starts on or before the time you're looking to translate and ends after
it.  Then you just add the offset computed by subtracting the two
interval start times.

There is always a well-defined local time corresponding to any GMT time.
The other way around, it gets a little more interesting.

There are some local times (such as the hour 1998-04-05 02:xx:xx in
Toronto) that don't exist.  It jumped from 01:59:59 EST to 03:00:00 EDT
between 06:59:59 and 07:00:00 GMT.  Fortunately, there is only one
semi-reasonable thing to do in such a situation, which is to map
the impossible hour to 07:xx:xx GMT, which will get back-mapped
to 03:xx:xx.  Not too awful.

There are other local times (such as 1998-10-25 01:xx:xx in Toronto)
that exist twice, once at 05:xx:xx GMT and once at 06:xx:xx GMT.
Since the file system doesn't distinguish the two, the choice is pretty
arbitrary.  In the implementation I'm thinking of, it turns out to be
simplest to translate it as the later of the two hours.

If you really care about having a 1:1 time code mapping more than
preserving relative order of timestamps, you could map GMT times
in the earlier hour to the previously mentioned impossible local time,
but I think that's better to just mangle he times a little.

(There is a hack that's possible if you want to get really clever
involving stretching one hour to fit two, but I'm not sure
if anyone cares all that much.)
-- 
	-Colin

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
