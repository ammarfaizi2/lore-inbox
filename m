Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271419AbRHXNeZ>; Fri, 24 Aug 2001 09:34:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271505AbRHXNeP>; Fri, 24 Aug 2001 09:34:15 -0400
Received: from chaos.analogic.com ([204.178.40.224]:65158 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S271419AbRHXNd6>; Fri, 24 Aug 2001 09:33:58 -0400
Date: Fri, 24 Aug 2001 09:34:06 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: David Woodhouse <dwmw2@infradead.org>
cc: Tim Walberg <twalberg@mindspring.com>,
        "J. Imlay" <jimlay@u.washington.edu>, linux-kernel@vger.kernel.org
Subject: Re: macro conflict 
In-Reply-To: <14764.998658214@redhat.com>
Message-ID: <Pine.LNX.3.95.1010824091538.32666A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Aug 2001, David Woodhouse wrote:

> 
> twalberg@mindspring.com said:
> > There has already been **much** discussion about this, but I think
> > that the bottom line is that the new version is safer and more robust
> > than the old version, and thus is not likely to be changed back. 
> 
> That's a completely separate issue. You can fix it while keeping sane 
> semantics for min() and max().
> 
> #define real_min(x,y) ({ typeof((x)) _x = (x); typeof((y)) _y = (y); (_x>_y)?_y:_x; })
> 
> #define min(x,y) ({ if strcmp(STRINGIFY(typeof(x)), STRINGIFY(typeof(y))) BUG(); realmin(x,y) }) 
> 
> /me wonders if gcc would manage to optimise that.
> --
> dwmw2
> 

Looking through the code, min() is most always used to find some value
that will not overflow some buffer, i.e.,

    len = min(user_request_len, sizeof(buffer));

The problem is that sizeof() returns an unsigned int (size_t), and the
user request length may be an integer. Everything works fine until
you get to lengths with the high bit set. Then, you are in trouble.

In this case, you could have a 'min()' that does:

#define min(a,b) (unsigned long)(a) < (unsigned long)(b) ? (a) : (b)

... where the comparison (only) is made unsigned, and you keep the
original values. This should work, perhaps in all the current uses.
However, min() is not the mathematical min() anymore. That's fine,
but it probably should not be called min() unless it is truly a min()
function.

So, I suggest that instead of using some macro in a header, if you
need min() you make one in your code called MIN(). Problem solved.
Your macro will do exactly what you want it to do. If It's broken,
you get to fix it (or keep the pieces).


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


