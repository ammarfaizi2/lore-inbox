Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu id <971129-15443>; Sun, 19 Jul 1998 04:43:50 -0400
Received: from [192.116.142.129] ([192.116.142.129]:63995 "EHLO blinky.bfr.co.il" ident: "hjstein") by vger.rutgers.edu with ESMTP id <970893-15443>; Sun, 19 Jul 1998 04:43:35 -0400
To: Linus Torvalds <torvalds@transmeta.com>
Cc: "Harvey J. Stein" <hjstein@bfr.co.il>, linux-kernel@vger.rutgers.edu
Subject: Probability of being unable to allocate w/o swapping.
References: <Pine.LNX.3.96.980715094419.10708F-100000@penguin.transmeta.com> <m2ww9fdphk.fsf@blinky.bfr.co.il>
CC: hjstein@bfr.co.il
From: hjstein@bfr.co.il (Harvey J. Stein)
Date: 19 Jul 1998 13:03:40 +0300
In-Reply-To: hjstein@bfr.co.il's message of "15 Jul 1998 19:54:15 +0300"
Message-ID: <m2k95anon7.fsf_-_@blinky.bfr.co.il>
X-Mailer: Gnus v5.6.4/Emacs 19.34
Sender: owner-linux-kernel@vger.rutgers.edu

hjstein@bfr.co.il (Harvey J. Stein) writes:

 > Linus Torvalds <torvalds@transmeta.com> writes:
 > 
 >  > On 15 Jul 1998, Harvey J. Stein wrote:
 >  > > The math isn't quite right.  Consider:
 >  > > 
 >  > > 1st hole placed on 1st page.
 >  > > 
 >  > > 2nd hole placed on 4th page.
 >  > > 
 >  > > There are now x-5 places to place the 3rd hole, not x-4.
 >  > 
 >  > No, the thing is that you also have to worry about the alignement: we get
 >  > a 8kB area only if we have two consecutive 4kB holes that are also
 >  > aligned. 
 >  > 
 >  > As such 0+1 would be a 8kB area, and 4+5 would be one, but 3+4 and 1+2
 >  > would not.
 > 
 > Ok.  In that case I'm not counting the right thing.  I'll redo my
 > computations and see what happens.

Ok.  I worked it out (with the help of my office mate).  Memory looks
like this:

  -- -- | -- -- | -- -- | ...

The -- represent pages.  The | just divide all pages into pairs (which
I'll call buckets).

Suppose there are x pages (x/2 buckets).  Suppose that y pages are
free.

We can make a 2 page allocation iff there are 2 consecutive aligned
pages.  The latter holds iff there are 2 free pages in one of the
above buckets.

Thus, the number of memory configurations in which we can't make a 2
page allocation is the number of ways to place the free pages such
that there's at most 1 free page in each bucket.

The number of ways to do this, not counting the position of the free
page in each bucket, is just the number of ways to choose y buckets,
which is x/2 choose y.

The number of ways to do this, accounting for the free page internal
bucket position is (x/2 choose y) * 2^y.  I.e. - multiply by the
number of ways to arrange the free pages in the chosen buckets.

The total number of ways to allocate the free pages is just (x choose
y).

Thus, the probability of having to swap is:

   (x/2 choose y) * 2^y
   --------------------
       (x choose y)

(where x choose y = x!/(y!(x-y)!) = the number of ways to select y
items from a set of x items).

I've appended Linus' original table along with the percentage of "bad"
configurations as computed by the above formula.  BTW, the numbers
start out higher & drop off slower (as X increases with Y/X = %
free memory/100 held constant).  Actually, the old numbers for X total
pages are almost identical to the new numbers for 2X total pages, so
any arguments about machines with n MB will basically carry over to
machines with 2*n MB.  The "Orig %" & "By above" columns are the
% chance that there are no pair of free pages that are adjacent &
aligned.

  total pgs  free pgs  tot mb  % free     Orig %    By above
  X =  1024, Y =   20 (  4MB, 2% free) = 68.6673%   82.765%
  X =  1024, Y =   51 (  4MB, 5% free) =  7.6047%   26.974%
  X =  1024, Y =   81 (  4MB, 8% free) =  0.1245%    3.212%
     			     
  X =  2048, Y =   40 (  8MB, 2% free) = 46.2224%   67.816%
  X =  2048, Y =  102 (  8MB, 5% free) =  0.5488%    7.083%
  X =  2048, Y =  163 (  8MB, 8% free) =  0.0001%    0.090%
     			     
  X =  4096, Y =   81 ( 16MB, 2% free) = 20.1256%   44.623%
  X =  4096, Y =  204 ( 16MB, 5% free) =  0.0029%    0.488%
  X =  4096, Y =  327 ( 16MB, 8% free) =  0.0000%    0.00007101%
     			     
  X =  8192, Y =  163 ( 32MB, 2% free) =  3.8125%   19.312%
  X =  8192, Y =  409 ( 32MB, 5% free) =  0.0000%    0.0021999%
  X =  8192, Y =  655 ( 32MB, 8% free) =  0.0000%    0.4401e-10%
     			     
  X = 16384, Y =  327 ( 64MB, 2% free) =  0.1368%    3.6167%
  X = 16384, Y =  819 ( 64MB, 5% free) =  0.0000%    0.4463e-7%
  X = 16384, Y = 1310 ( 64MB, 8% free) =  0.0000%    0.1851e-22%
     			     
  X = 32768, Y =  655 (128MB, 2% free) =  0.0002%    0.1268%
  X = 32768, Y = 1638 (128MB, 5% free) =  0.0000%    0.1939e-16%
  X = 32768, Y = 2621 (128MB, 8% free) =  0.0000%    0.2989e-47%
     			     
  X = 65536, Y = 1310 (256MB, 2% free) =  0.0000%    0.0001592%
  X = 65536, Y = 3276 (256MB, 5% free) =  0.0000%    0.3659e-35%
  X = 65536, Y = 5242 (256MB, 8% free) =  0.0000%    0.8538e-97%

-- 
Harvey J. Stein
BFM Financial Research
hjstein@bfr.co.il

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.altern.org/andrebalsa/doc/lkml-faq.html
