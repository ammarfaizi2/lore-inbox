Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <154664-8100>; Thu, 14 Jan 1999 14:38:42 -0500
Received: by vger.rutgers.edu id <153977-8093>; Thu, 14 Jan 1999 14:35:20 -0500
Received: from gilgamesch.bik-gmbh.de ([194.233.237.91]:2745 "EHLO gilgamesch.bik-gmbh.de" ident: "NO-IDENT-SERVICE[2]") by vger.rutgers.edu with ESMTP id <154695-8093>; Thu, 14 Jan 1999 14:10:22 -0500
Message-ID: <19990114200829.A26392@cons.org>
Date: Thu, 14 Jan 1999 20:08:29 +0100
From: Martin Cracauer <cracauer@cons.org>
To: Marc Espie <Marc.Espie@liafa.jussieu.fr>, Thomas Pornin <pornin@bolet.ens.fr>, Marc.Espie@liafa1.liafa.jussieu.fr
Cc: linux-kernel@vger.rutgers.edu
Subject: void* taking functions type-safe in C (Re: C++ in kernel)
References: <19990112101339.A6800@bolet.ens.fr> <19990112104939.20004@liafa1.liafa.jussieu.fr>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="yrj/dFKFPuw6o+aM"
X-Mailer: Mutt 0.93.1i
In-Reply-To: <19990112104939.20004@liafa1.liafa.jussieu.fr>; from Marc Espie on Tue, Jan 12, 1999 at 10:49:39AM +0100
Sender: owner-linux-kernel@vger.rutgers.edu


--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=us-ascii

In <19990112104939.20004@liafa1.liafa.jussieu.fr>, Marc Espie wrote: 
> C++ template expansions can do the exact same things C macros do, with
> strict type-checking

Here is the C scheme I use to make void* - taking Functions type-safe,
without bloating or (even duplicating) the code.

You'd better try the code in the attachment now and read on
afterwards. Trust code, not words :-)

Note that in main() the proper warning is emitted for the safe call,
but that the assembly and object code of the safe and unsafe variants
of the function are *excatly* of the same size. [Don't be mislead by
the file size, the function name is longer. Use size(1) for the object
files and diff for the assembly files.]


.
.
.


OK, for those without mime...

/* This function actually expects a pointer to int */
int libfunc(void *bla1, void *bla2);

static inline int libfunc_int(int *i1, int *i2)
{
  return libfunc(i1, i2);
}

The inline function is *complelety* removed even with gcc-2.7.2
-O. Still, it makes the function type-safe, a warning is emitted if
anything else than an int* pointer is being passed. This is exactly
what we need.

If you don't want to write multiple type-wrappers for you void* -
taking functions, you can accompany each of them with a
function-generating macro like this:

    #define wrapper(mp1, mp2) \
      static inline int mp1 ## _ ## mp2(int *i1, int *i2) \
      { \
        return libfunc(i1, i2); \
      }
and then use or include this before using the function:
      wrapper(libfunc, int);

to get the libfunc_int definition. A matter of taste whether to use
such a macro or not. I usually wouldn't, but used it in the example. 

For compilers that don't have inline declaration you can make a macro
(losing type-safeness) or a real function out of the wrapper. Even
#ifdef-conditionally (safe during development and macro when shipping).

Summary: 

That is *no* need to duplicate your
collections/sorting/generic-read-write functions to make them
type-safe for multiple different client types. Given a descent C
compiler, it is even overhead-free. Possibly slowdown may result when
the inline function prevents further optimization of the surrounding
code. But you could easily compile type-safe once and then #ifdef
these inline functions to straight macros without loosing anything.



For the record, I as well often think "hey, *this* project would
finally gain from C++". I start in C++ until the goal of the program
becomes clear. Then I realize that I needed C++ additional
expressional power (which is surely there) just to approach the
solution further. But once I understood the problem and the solution
approach I think in nothing else than machine terms and C++ goes in
my way. Then I rewrite it in C or ocassionally in Objective-C.

Martin
-- 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Martin Cracauer <cracauer@cons.org> http://www.cons.org/cracauer/
BSD User Group Hamburg, Germany     http://www.bsdhh.org/

--yrj/dFKFPuw6o+aM
Content-Type: application/x-tar-gz
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="cast-overhead.tar.gz"

H4sIAEU/njYAA+2a/W+bRhjH/Wvur3iUZBV4ceB4lZwm0pptlapNleat+6VSROAcs2JAgNtl
bf/33fHiGoNNoxHcrs9HlsF3z73Yx/d5ngO7TppNorcsWTDHU0aPAhiqbZowAgBq0/wImlEc
C1QAyzJsQxcvbqVZujYC83GmU2eVZk4CMHITx3VWLNllx83m8yEmNCxubf2vX80e4Rp4wPpr
pi3WX9csE9d/CJrr/1sUZf2OQVXVMow966/Tav1VQze4lUFNdQRqv9No5xtf/7+iNyyZKoto
yZTqJxCXATn0xJBBaNE/i6PUz6Lkvq8xOvVvalv6N3nEQP0PQVP5SpzcKRlLM6V2baBD+F/S
1P9PYZb4LO1xjC7965a2kf9ZIv5btoX6HwIl8G/PXUVVvNVyeQ+Zv+TKd5axohBl6fjhrrrU
mbN9dTfvkii822WxCve1L2r39/Cr84bN/YC114ovtWit+hH9WI26/qtftd8xuvRvmnRj/28K
/esG6n8Qrn/+5Yfns8vJS5j86QQBTO4I4cfpFEQKQCHXaQqlYFNIeHaYZIS8fPYCLkHoLILc
T0SFaXEotRtV7aqTqpyQvPcpnEq8I5kcnUrX1zL/VExHhklUjl8akHP3PJ222M3g9CkhbsCc
kFdPkmXZbszHHG/MtzhOG9+nNj0+saOJ58/nDbOrqqOj1P+HbbeCq6oePnwAPofK2HWy6vzQ
C72Duv4Lj9/3GF36N+g6/uviRhFQ3bZ11P8QnPihG6w8Bk/TzPOj88UVIeuy4zyOHhPyLnHi
mCUS/zxfhe4Z+GEmXxDCD7n6pbeR78nkPQGIE144l47/yLUxhe+81+HxWSkVST8zZN5w26zw
C1vGRWGzyWyz3/ZeZ80+mz1y+4RlqyQE9YJ8/FIF+sjU9Z8ng72P0aV/apjr/b9Nxf5ftyje
/xuEptaFpkudQ65rGN8GDj2D9blWKL0Uz1iSRJOxLKxk+L5WoMnfrrS+Cpr6X/Q+Rmf+r+qf
4r9BC/1j/j8Iyhh+XzAQas/8KATHzVY8/78H9nfM3EwE+jGMlU2vsMsp8Ih64vHtY8igyheW
MTdZxpoMr7nD4D9h5ru8y0DY5LlDTOHkBG7EGzcr/IZP8/yCn5Tt3ufva4dTTSO348PmtR8L
x1WmGeK06kaYbNSVOUCrxe62+1oeegn/E3X9b9536W+MLv1r6nr/b6iqeP5rUstA/Q/Bw3L9
3TLIMwIvWt0GDLg3gEteeEG2NXvDraUnotkTboS5weFp6n/4/T817I34X+7/Kep/CB6u/1bl
75S5jzuAL5q6/utPXvoao1P/5qf/f1FbFwWmjvF/ENr3//tS5fZI3/ABGOa/Ctr033cG0Kl/
am7on+bP/yj+/2cQ9un/MyI9RnkEQRAEQRAEQRAEQRAEQRAEQRAEQRAEQZAD8y9rUN76AFAA
AA==

--yrj/dFKFPuw6o+aM--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
