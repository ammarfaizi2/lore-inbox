Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272681AbRIGOop>; Fri, 7 Sep 2001 10:44:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272682AbRIGOof>; Fri, 7 Sep 2001 10:44:35 -0400
Received: from tomts13-srv.bellnexxia.net ([209.226.175.34]:26606 "EHLO
	tomts13-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S272679AbRIGOoW>; Fri, 7 Sep 2001 10:44:22 -0400
To: ptb@it.uc3m.es
Cc: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [IDEA+RFC] Possible solution for min()/max() war
In-Reply-To: <200109071059.MAA23146@nbd.it.uc3m.es>
From: Bill Pringlemeir <bpringle@sympatico.ca>
Date: 07 Sep 2001 10:39:57 -0400
In-Reply-To: "Peter T. Breuer"'s message of "Fri, 7 Sep 2001 12:58:25 +0200 (CEST)"
Message-ID: <m21ylj3w02.fsf@sympatico.ca>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> Peter T Breuer <ptb@it.uc3m.es> writes:

 > If you are interested, the last version I had is the
 > following. The compile_time_assert is linus' idea. We had an
 > illegal assembler statement there originally, containing the line
 > number and the error statement. One or the other will do until gcc
 > gets the __builtin_ct_assert() function.

   #define compile_time_assert(x) \
                   do { switch (0) { case 0: case (x) != 0: ; } } while (0)

   #define __MIN(x,y) ({\
      typeof(x) _x = x; \
      typeof(y) _y = y; \
      _x < _y ? _x : _y ; \
    })
   #define MIN(x,y) ({\
      const typeof(x) _x = ~(typeof(x))0; \
      const typeof(y) _y = ~(typeof(y))0; \
      compile_time_assert(sizeof(_x) == sizeof(_y));\
      compile_time_assert( (_x > (typeof(x))0 && _y > (typeof(y))0) \
                       ||  (_x < (typeof(x))0 && _y < (typeof(y))0)); \
      __MIN(x,y); \
    })

As Horst von Brand noted, most modern machines use 2's complement
arithmetic.  AFAIK, all the Linux targets use 2's complement.  The use
of ones complement, probably pre-dates MMUs.  At any rate, I think
that this might be a little clearer as sign, not complement is what is
being checked.

   #define MIN(x,y) ({\
      const typeof(x) _x = 0; \
      const typeof(y) _y = 0; \
      compile_time_assert(sizeof(_x) == sizeof(_y));\
      compile_time_assert( (_x - 1 > 0 && _y - 1 > 0) \
                       ||  (_x - 1 < 0 && _y - 1 < 0)); \
      __MIN(x,y); \
    })

This should prevent all cases where the __MIN(x,y) macro can screw up
due to sign issues (on that machine).  If you do this, the `sizeof'
check isn't needed.  A MIN(int, long) etc should probably be ok.  The
only caveats are the promotion in the __MIN itself create a sign
mismatch.

However, if the `sizeof' check remains, then you don't have to worry
about this and both versions are equivalent.  Some other things to
worry about is what if the type is already const?  Maybe that works...
What if you try `MIN(x,_x);'.  I think that this is something that
David took care of in the "3 arg min".

regards,
Bill Pringlemeir.









