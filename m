Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270227AbRHWTvS>; Thu, 23 Aug 2001 15:51:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270195AbRHWTvN>; Thu, 23 Aug 2001 15:51:13 -0400
Received: from pop.timesn.com ([216.30.51.65]:41973 "EHLO srvaus02.timesn.com")
	by vger.kernel.org with ESMTP id <S270258AbRHWTu5>;
	Thu, 23 Aug 2001 15:50:57 -0400
Message-ID: <3B85615A.58920036@timesn.com>
Date: Thu, 23 Aug 2001 15:02:34 -0500
From: raybry@timesn.com
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.16-22 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Tim Walberg <twalberg@mindspring.com>, linux-kernel@vger.kernel.org
Subject: Re: macro conflict
In-Reply-To: <20010823143440.G20693@mindspring.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Without digging through the archives to see if this has already
been suggested (if so, I apologize), why can't the following be done:

min(x,y) = ({typeof((x)) __x=(x), __y=(y); (__x < __y) ? __x : __y})

That gets you the correct "evaluate the args once" semantics and gives
you control over typing (the comparison is done in the type of the 
first argument) and we don't have to change a zillion drivers.

(typeof() is a gcc extension.)

Tim Walberg wrote:
> 
> There has already been **much** discussion about this, but I think
> that the bottom line is that the new version is safer and more
> robust than the old version, and thus is not likely to be changed
> back.
> 
> Consider what happens if someone writes min(++x,y) - the old
> version expands to (without some of the extra parens):
> 
>         ++x < y ? ++x : y
> 
> which will increment x twice if the condition ++x < y is true.
> There's all kinds of nasty side effects possible with the old
> version, including having x > y at the end of the statement, which
> definitely violates the semantics of min().
> 
> The new version avoids these side effects by only evaluating
> the given arguments once (assigning them to temp variables,
> which will be optimized away in almost all cases anyway), but
> in order to do that, the macro needs to know the variable type,
> hence the additional argument. In C++, this can be done using
> typename or templates, but the kernel's not written in C++
> for a number of very good reasons.
> 
> Bottom line, I think the new version of min() and friends is
> here to stay and is definitely a positive move. One of the down
> sides to that is that a lot of people have a lot of cleaning
> up to do.
> 
>                         tw
> 
> On 08/23/2001 12:03 -0700, J. Imlay wrote:
> >>      IN getting the AFS kernel modules to compile under linux I
> dicovered that
> >>      the were useing the standard min(x,y) macro that whould evaluate
> which one
> >>      is smaller. However sometime between 2.4.6 and 2.4.9 a new macro
> was added
> >>      to linux/kernel.h
> >>
> >>      this one:
> >>
> >>      #define min(type,x,y) \
> >>              ({ type __x = (x), __y = (y); __x < __y ? __x: __y; })
> >>
> >>      the old one is
> >>
> >>      #define min(x,y) ( (x)<(y)?(x):(y) )
> >>
> >>      has been around a lot longer and is in lots of header files.
> >>
> >>      The problem here with AFS is that it needs the old definition
> but the old
> >>      definition is being over written by the new one... you guys
> should know
> >>      all this. But I am just saying that I really think the new macro
> >>      min(type,x,y) should get a new name. like type_min or something.
> >>
> >>      Thanks,
> >>
> >>      Josie Imlay
> >>
> >>      -
> >>      To unsubscribe from this list: send the line "unsubscribe
> linux-kernel" in
> >>      the body of a message to majordomo@vger.kernel.org
> >>      More majordomo info at
> http://vger.kernel.org/majordomo-info.html
> >>      Please read the FAQ at  http://www.tux.org/lkml/
> End of included message
> 
> --
> twalberg@mindspring.com

-- 
----------------------------------------------------------- 
  Ray Bryant,  Linux Performance Analyst, Times N Systems
   1908 Kramer Lane, Bldg. B, Suite P, Austin, TX 78758
              512-977-5366, raybry@timesn.com
-----------------------------------------------------------
