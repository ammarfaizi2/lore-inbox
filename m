Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133028AbRDLAL2>; Wed, 11 Apr 2001 20:11:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133029AbRDLALR>; Wed, 11 Apr 2001 20:11:17 -0400
Received: from code.and.org ([63.113.167.33]:42682 "EHLO mail.and.org")
	by vger.kernel.org with ESMTP id <S133028AbRDLALA>;
	Wed, 11 Apr 2001 20:11:00 -0400
To: "Stephen D. Williams" <sdw@lig.net>
Cc: Michael Lindner <mikel@att.net>, Chris Wedgwood <cw@f00f.org>,
        Dan Maas <dmaas@dcine.com>, Edgar Toernig <froese@gmx.de>,
        linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: select() on TCP socket sleeps for 1 tick even if data     available
In-Reply-To: <fa.nc2eokv.1dj8r80@ifi.uio.no> <fa.dcei62v.1s5scos@ifi.uio.no>
	<015e01c082ac$4bf9c5e0$0701a8c0@morph> <3A69361F.EBBE76AA@att.net>
	<20010120200727.A1069@metastasis.f00f.org> <3A694254.B52AE20B@att.net>
	<3A6A09F2.8E5150E@gmx.de> <022f01c08342$088f67b0$0701a8c0@morph>
	<20010121133433.A1112@metastasis.f00f.org> <3A6A558D.5E0CF29E@att.net>
	<3AD1CD13.F1A917FA@lig.net> <nnbsq5opdz.fsf@code.and.org>
	<3AD35119.D1C5E90D@lig.net> <nng0fgmri0.fsf@code.and.org>
	<3AD4C6A6.AB6F23F8@lig.net>
From: James Antill <james@and.org>
Content-Type: text/plain; charset=US-ASCII
Date: 11 Apr 2001 20:09:20 -0400
In-Reply-To: "Stephen D. Williams"'s message of "Wed, 11 Apr 2001 17:03:34 -0400"
Message-ID: <nnhezvkmhb.fsf@code.and.org>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Capitol Reef)
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Stephen D. Williams" <sdw@lig.net> writes:

> James Antill wrote:
> ...
> > >                                                                    The
> > > time went from 3.7 to 4.4 seconds per 100000.
> > 
> >  Ok here's a quick test that I've done. This passes data between 2
> > processes. Obviously you can't compare this to your code or Michael's,
> > however...
> 
> I've attached my version of his code with your suggested change. 
> Possibly I didn't do it correctly.

 It's not a code thing, but I think you are measuring the wrong thing
(at least in relation to the original question). Given the below
diff...

--- sdw-sockperf.c-orig	Wed Apr 11 18:30:28 2001
+++ sdw-sockperf.c	Wed Apr 11 18:33:09 2001
@@ -17,6 +17,7 @@
 #include <unistd.h>
 #include <netinet/tcp.h>
 
+#define USE_DOUBLE_SELECT 0
 
 #ifndef INADDR_NONE
 #define INADDR_NONE     ~0
@@ -147,7 +148,8 @@
         int pings = 0;
 	struct timeval zerotime;
 	int ret;
-
+        unsigned int misses = 0;
+        
         FD_ZERO(&fds);
         FD_SET(r, &fds);
         gettimeofday(&then, 0);
@@ -163,8 +165,10 @@
 	//	if (!(ret = select( ... , &zerotime)))
 	//  ret = select( ... , NULL);
 	//        while ((readfds=fds, ret = select(r+1, &readfds, 0, 0, 0)) ) {-	while ((ret = select(r+1, &readfds, 0, 0, &zerotime)) ||
-	       (readfds=fds, ret = select(r+1, &readfds, 0, 0, 0)) ) {
+	while ((USE_DOUBLE_SELECT &&
+                (ret = select(r+1, &readfds, 0, 0, &zerotime))) ||
+	       (++misses &&
+                (readfds=fds, ret = select(r+1, &readfds, 0, 0, 0)) )) {
 	       if (FD_ISSET(r, &readfds)) {
                         char buf[1];
                         int n = read(r, buf, sizeof(buf));
@@ -186,6 +190,8 @@
                 readfds = fds;
         }
         gettimeofday(&now, 0);
+        fprintf(stderr, "USE_DOUBLE_SELECT=%d\n", USE_DOUBLE_SELECT);
+        fprintf(stderr, "misses=%u\n", misses);
         fprintf(stderr, "elapsed time for 100000 pingpongs is %g\n", now.tv_sec - then.tv_sec + (now.tv_usec -
 then.tv_usec) / 1000000.0);
         fprintf(stderr, "closing %d\n", r);

...I get constitently better results for "localhost 45644 45644 a"
with USE_DOUBLE_SELECT=1 worth noting is that misses == 0 was always
true. However if I have 2 programs, one doing "localhost 45642 45643"
and one doing "localhost 45643 45642 a" then I get better results for
USE_DOUBLE_SELECT=0[1] and misses is 80-90 thousand (Ie. it has to do 2
select calls 80-90 % of the time).

 Please note that the original question was, select/poll does a small
schedule if you specify a timeout and that's bad. However in the two
process case you _need_ the schedule, because there isn't any data
there yet.
 So again given the original assumtion that data is available on one
of the fd's then doing the double select is better, but if it isn't
then you're wasting time no matter what you do.

 As to why my test code got good results even though it uses 2
processes, I used PF_LOCAL/AF_LOCAL sockets not PF_INET/AF_INET and
those are fast enough at transfering the data that you don't need the
schedule (misses == 0, if you add similar code to above).

[1] This is on a real computer, on a 486 with 8Meg of RAM I still get
better results with USE_DOUBLE_SELECT=1, and there are still 80%
misses (no idea why).

-- 
# James Antill -- james@and.org
:0:
* ^From: .*james@and\.org
/dev/null
