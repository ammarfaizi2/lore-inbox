Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271368AbRHZSDw>; Sun, 26 Aug 2001 14:03:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271399AbRHZSDd>; Sun, 26 Aug 2001 14:03:33 -0400
Received: from tomts5.bellnexxia.net ([209.226.175.25]:14285 "EHLO
	tomts5-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S271368AbRHZSDZ>; Sun, 26 Aug 2001 14:03:25 -0400
To: Brad Chapman <kakadu_croc@yahoo.com>
Cc: Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org
Subject: Re: [IDEA+RFC] Possible solution for min()/max() war
In-Reply-To: <20010825005302.34876.qmail@web10901.mail.yahoo.com>
From: Bill Pringlemeir <bpringle@sympatico.ca>
Date: 26 Aug 2001 13:59:01 -0400
In-Reply-To: Brad Chapman's message of "Fri, 24 Aug 2001 17:53:02 -0700 (PDT)"
Message-ID: <m2n14mn1ne.fsf@sympatico.ca>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Brad" == Brad Chapman <kakadu_croc@yahoo.com> writes:

 Brad> 	OK. The existing API is wrong and the new min()/max() macros
 Brad> are the right way to properly compare values. However, we could
 Brad> always add a config option to enable a compatibility macro,
 Brad> which would use typeof() on one of the two variables and then
 Brad> call the real min()/max(). Something like this (just an
 Brad> example):

       #ifdef CONFIG_ALLOW_COMPAT_MINMAX
       #define proper_min(t, a, b)	((t)(a) < (t)(b) ? (a) : (b))
       #define proper_max(t, a, b)	((t)(a) > (t)(b) ? (a) : (b))
       #define min(a, b)		proper_min(typeof(a), a, b)
       #define max(a, b)		proper_max(typeof(a), a, b)
       #else
       #define min(t, a, b)		((t)(a) < (t)(b) ? (a) : (b))
       #define max(t, a, b)		((t)(a) < (t)(b) ? (a) : (b))
       #endif

Conditionals are bad.  Casting is bad.  In my opinion the only
semantically correct version would be something like this,

#define min(x,y)                                       \
                                                       \
  ({typeof(x) _x = 0; typeof(y) _y = 0;                \
    if ((_x-1>0 && _y-1<0) || (_x-1<0 && _y-1>0)) {    \
         if((x) < 0 ||  (y) < 0)                       \
                exit(SIGNED_UNSIGNED_CONFLICT);        \
    }                                                  \
        _x = (x), _y = (y); (_x>_y)?_y:_x;             \
   }) 

I think that if you are mixing signed and unsigned you should have had
a check before hand to gaurentee that any casting away of the sign is
ok.  It is ok if the variable is in range, it is not if they are out
of range.  However, this incurs a runtime check which is not
appropriate for kernel level code.

As several other people have noted, the casting is bad from a
maintainability prospective.  This is slapping your best friend in the
face; the compiler.  Also, the three arg macro breaks compatibility
with a long standing `C' min/max macro convention.

Probably we should just shutup for now until Linus can clarify what it
is that he wants to achieve and avoid.  Since there is probably no way
to make a universally correct min/max macro in `C', you need to have
some sort of goal to achieve.

regards,
Bill Pringlemeir.







