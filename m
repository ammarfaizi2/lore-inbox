Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu id <154864-8316>; Wed, 9 Sep 1998 20:05:29 -0400
Received: from neon-best.transmeta.com ([206.184.214.10]:31806 "EHLO neon.transmeta.com" ident: "NO-IDENT-SERVICE[2]") by vger.rutgers.edu with ESMTP id <155316-8316>; Wed, 9 Sep 1998 19:00:38 -0400
To: linux-kernel@vger.rutgers.edu
From: hpa@transmeta.com (H. Peter Anvin)
Subject: Re: GPS Leap Second Scheduled!
Date: 10 Sep 1998 01:37:05 GMT
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <6t7ag1$trf$1@palladium.transmeta.com>
References: <19980909200032.B13292@caffeine.ix.net.nz> <199809092149.RAA06993@hilfy.ece.cmu.edu>
Reply-To: hpa@transmeta.com (H. Peter Anvin)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 1998 H. Peter Anvin - All Rights Reserved
Sender: owner-linux-kernel@vger.rutgers.edu

Followup to:  <199809092149.RAA06993@hilfy.ece.cmu.edu>
By author:    "Brandon S. Allbery KF8NH" <allbery@kf8nh.apk.net>
In newsgroup: linux.dev.kernel
>
> In message <19980909200032.B13292@caffeine.ix.net.nz>, Chris Wedgwood writes:
> +-----
> | On Wed, Sep 09, 1998 at 12:59:47AM +0000, H. Peter Anvin wrote:
> | > The way xntp deals with leap seconds is it lets the epoch float...
> | > i.e. it holds time_t to the same value for two seconds.
> | Cool... so 1970 becomes even longer ago that I would have assumed
> | then?
> +--->8
> 
> That's the only semi-reasonable (I stress *semi-*) interpretation one can 
> give to the current standard.  The other possibilities are worse.
> 

Right.  I think the right solution is one I suggested on c.o.l.d.s
recently:

- time_t being a 64-bit signed integer linked to UTC
- struct timespec (and struct timeval, presumably) having an extra
  field added:

	64-bit seconds field (same as time_t) linked to UTC
	32-bit nanosecond field (microsecond for timeval) linked to TAI
	32-bit integral TAI-UTC difference

That way any moment in time will be uniquely derivable at least, at a
positive leap second, you will see the progression (where T means a
time_t value divisible by 86400):

	tv_sec		tv_delta	UTC

	T-3		N		23:59:57
	T-2		N		23:59:58
	T-1		N		23:59:59
	T-1		N+1		23:59:60
	T		N+1		00:00:00
	T+1		N+1		00:00:01
	T+2		N+1		00:00:02

... and for a negative leap second ...

	tv_sec		tv_delta

	T-3		N		23:59:57
	T-2		N		23:59:58
	T		N-1		00:00:00
	T+1		N-1		00:00:01
	T+2		N-1		00:00:02

We may want to have a testable bit that we're "in" a leap second for
the 23:59:60 case...

	-hpa

-- 
    PGP: 2047/2A960705 BA 03 D3 2C 14 A8 A8 BD  1E DF FE 69 EE 35 BD 74
    See http://www.zytor.com/~hpa/ for web page and full PGP public key
        I am Bahá'í -- ask me about it or see http://www.bahai.org/
   "To love another person is to see the face of God." -- Les Misérables

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/faq.html
