Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270314AbRIGA6K>; Thu, 6 Sep 2001 20:58:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270224AbRIGA6A>; Thu, 6 Sep 2001 20:58:00 -0400
Received: from tomts8.bellnexxia.net ([209.226.175.52]:36245 "EHLO
	tomts8-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S270154AbRIGA5q>; Thu, 6 Sep 2001 20:57:46 -0400
To: ptb@it.uc3m.es
Cc: "Patrick J. LoPresti" <patl@cag.lcs.mit.edu>, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com
Subject: Re: [IDEA+RFC] Possible solution for min()/max() war
In-Reply-To: <200108302327.f7UNRvl04257@oboe.it.uc3m.es>
From: Bill Pringlemeir <bpringle@sympatico.ca>
Date: 06 Sep 2001 20:52:27 -0400
In-Reply-To: "Peter T. Breuer"'s message of "Fri, 31 Aug 2001 01:27:57 +0200 (MET DST)"
Message-ID: <m2y9nrn7p0.fsf@sympatico.ca>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> Peter T Breuer <ptb@it.uc3m.es> writes:

  > To give you all something definite to look at, here's some test
  > code:


  > // standard good 'ol faithful version
  > #define __MIN(x,y) ({\
  >    typeof(x) _x = x; \
  >    typeof(y) _y = y; \
  >    _x < _y ? _x : _y ; \
  >  })

  > // possible implemetation with type sanity checks - alter to taste
  > #define MIN(x,y) ({\
  >    const typeof(x) _x = ~(typeof(x))0; \
  >    const typeof(y) _y = ~(typeof(y))0; \
  >    void MIN_BUG(); \
  >    if (sizeof(_x) != sizeof(_y)) \
  >      MIN_BUG(); \
  >    if ((_x > 0 && _y < 0) || (_x < 0 && _y > 0)) \
  >      MIN_BUG(); \
  >    __MIN(x,y); \
  >  })

[snip]

Sorry, I have been away for a while.  I think that I was talking about
a similar approach when Linus was away and David introduced the 3 arg
min/max.  I just went through 1800 LKML emails and I am not quite
clear what happened.  I have put my code that I posted earlier at the
end of this email.  This was the result of someone's `fanciful comment'
`what if gcc could handle "if(strcmp(typeof(a),typeof(b))!=0)"'.

So here is the important part.  The code Peter has introduced a cast
in the lines "const typeof(x) _x = ~(typeof(x))0;" etc.  I think that
the approach of declaring a variable of the type and initializing to
zero and then comparing "x - 1" _might_ be better.

The version of min() at the end calls the following an error, were
Peter's does not [after removing the sizeof() restriction].

 unsigned char Cx = 1; unsigned int Ix = 1; unsigned long  Lx = 1;
 Ix = min(Cx,Ix); Lx = min(Cx,Lx); 

Here the unsigned char is being promoted to int as discussed before.
I think that this is `more faithful' as what we are try to achieve is
to check the sign that will be used in the min comparison; almost
like applying a proper warned signed selectively to the min/max
macros.

Otherwise, I think we have independently came up with the same thing
and the `error' throwing can of course be changed to whatever.

fwiw,
Bill Pringlemeir.

[start code]

#define bug_paste_chain(a,b) a##b
#define bug_paste(a) bug_paste_chain(BUG_AT_LINE_,a)
#define min(x,y)                                       \
                                                       \
  ({extern void bug_paste(__LINE__) (void);            \
    typeof(x) _x = 0; typeof(y) _y = 0;                \
    if ((_x-1>0 && _y-1<0) || (_x-1<0 && _y-1>0))      \
            bug_paste(__LINE__)();                     \
        _x = (x), _y = (y); (_x>_y)?_y:_x;             \
   }) 

#include <stdio.h>
int main(int argc, char *argv[])
{
      signed char  cx = 1, cy = 2;
      signed short sx = 1, sy = 2;
      signed int   ix = 1, iy = 2;
      signed long  lx = 1, ly = 2;
    unsigned char  Cx = 1, Cy = 2;
    unsigned short Sx = 1, Sy = 2;
    unsigned int   Ix = 1, Iy = 2;
    unsigned long  Lx = 1, Ly = 2;

    cx = min(cx,cy);    Cx = min(Cy,Cx);    sx = min(sx,sy);
    Sx = min(Sx,Sy);    ix = min(iy,ix);    Ix = min(Iy,Ix);
    lx = min(ly,ly);    Lx = min(Lx,Ly);

    /* No warning. */
/*  Lx = (typeof(Lx))min(Lx,&Ly); */

    printf("%d %d %hd %hd %d %d %ld %ld\n", cx, Cx,
           sx,Sx,ix,Ix,lx,Lx);

    cx = -1;    Cx = 0;
    cx = min(cx,cy);    sx = min(cx,sy);
    ix = min(cx,ix);    lx = min(cx,ly);
    Cx = min(Cx,Cx);    Sx = min(Cx,Sy);
    Ix = min(Ly,Ix);    Lx = min(Ix,Ly);

    /* correctly gives warning! */
/*  Ix = min(Cy,Ix);    Lx = min(Cx,Ly); */

    printf("%d %d %hd %hd %d %d %ld %ld\n", cx, Cx,
           sx,Sx,ix,Ix,lx,Lx);

    min((unsigned)ix,sizeof(ix));
/* BUG? printf ("%d\n", min(Iy, 10)); */
    printf ("%d\n", min(cx, 20));

    printf("min(3,4,5) %d\n", min(min(5,4),3));
    
    return 0;
}
/* gcc -Wall -O2 -o test test.c */

[end code]



