Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu id <153945-8316>; Wed, 9 Sep 1998 13:30:44 -0400
Received: from SOUTH-STATION-ANNEX.MIT.EDU ([18.72.1.2]:1544 "HELO MIT.EDU" ident: "NO-IDENT-SERVICE[2]") by vger.rutgers.edu with SMTP id <154683-8316>; Wed, 9 Sep 1998 12:32:41 -0400
Date: Wed, 9 Sep 1998 15:08:33 -0400
Message-Id: <199809091908.PAA23948@dcl.MIT.EDU>
From: "Theodore Y. Ts'o" <tytso@MIT.EDU>
To: Colin Plumb <colin@nyx.net>
Cc: andrejp@luz.fe.uni-lj.si, linux-kernel@vger.rutgers.edu
In-Reply-To: Colin Plumb's message of Tue, 8 Sep 1998 22:46:25 -0600 (MDT), <199809090446.WAA25923@nyx10.nyx.net>
Subject: Re: GPS Leap Second Scheduled!
Address: 1 Amherst St., Cambridge, MA 02139
Phone: (617) 253-8091
Sender: owner-linux-kernel@vger.rutgers.edu

   Date: 	Tue, 8 Sep 1998 22:46:25 -0600 (MDT)
   From: Colin Plumb <colin@nyx.net>

   The problem is that POSIX is schizophrenic on the subject of leap seconds.
   On the one hand, time() returns UTC time.  

Yep.  See POSIX 4.5.1.2, 2.2.2.77, 2.2.2.24, and the rationale for
Epoch, found in B.2.2.2).

    On the other,

	   t = time();
	   sec = t % 60;
	   t /= 60;
	   min = t % 60;
	   t /= 60;
	   hr = t % 24;
	   t /= 24;
	   printf("UTC time is %lu days, %02u:%02u:%02u\n", (unsigned long)t, gr, min, sec);

   is required to work (since so much code does it.)

In fact, POSIX requires this (see 2.2.2.77).

   Actually, I think Ulrich was present when I proposed a similar solution:
   gettimeofday() will not return during 23:59:60.  If a process calls
   gettimeofday() during a leap second, then the call will sleep until 0:00:00
   when it can return the correct result.

The other possibility is for gettimeofday() to return the same value for
23:59:60 and 00:00:00.  This would also strictly speaking be correct.
time() is specified as returning "seconds since the Epoch", which is
defined as:

	tm_sec + tm_min*60 + tm_hour*3600 + tm_yday*86400 +
		(tm_year-70)*31536000 + ((tm_year-64)/4*86400)

where tm_sec, tm_min, tm_hour, etc. together form a Curridnated
Universal Time name.

Hence, the above equation would have the same value for 23:59:60 and
00:00:00 on the next day.  Hence, time() should return the same value.

						- Ted

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/faq.html
