Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275889AbTHOKAD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 06:00:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275890AbTHOKAD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 06:00:03 -0400
Received: from [212.209.10.216] ([212.209.10.216]:17043 "EHLO
	krynn.se.axis.com") by vger.kernel.org with ESMTP id S275889AbTHOJ7n
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 05:59:43 -0400
Message-ID: <D069C7355C6E314B85CF36761C40F9A42E20B6@mailse02.se.axis.com>
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: "'Willy Tarreau'" <willy@w.ods.org>
Cc: "'Timothy Miller'" <miller@techsource.com>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: RE: generic strncpy - off-by-one error
Date: Fri, 15 Aug 2003 11:54:50 +0200
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_000_01C36313.44C70D10"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_01C36313.44C70D10
Content-Type: text/plain

> -----Original Message-----
> From: Willy Tarreau [mailto:willy@w.ods.org] 
> Sent: Thursday, August 14, 2003 21:45
> To: Peter Kjellerstedt
> Cc: 'Timothy Miller'; linux-kernel mailing list
> Subject: Re: generic strncpy - off-by-one error
> 
> On Thu, Aug 14, 2003 at 11:34:50AM +0200, Peter Kjellerstedt wrote:
>  
> > char *strncpy(char *dest, const char *src, size_t count)
> > {
> > 	char *tmp = dest;
> > 
> > 	while (count) {
> > 		if (*src == '\0')
> > 			break;
> > 
> > 		*tmp++ = *src++;
> > 		count--;
> > 	}
> > 
> > 	while (count) {
> > 		*tmp++ = '\0';
> > 		count--;
> > 	}
> > 
> > 	return dest;
> > }
> > 
> > Moving the check for *src == '\0' into the first loop seems
> > to let the compiler reuse the object code a little better
> > (may depend on the optimizer). Also note that your version
> > of the second loop needs an explicit  comparison with -1,
> > whereas mine uses an implicit comparison with 0.
> 
> Well, if you're at this level of comparison, then I may object that
> 'count' is evaluated twice when jumping from one loop to the 
> other one.
> 
> *Algorithmically* speaking, the most optimal code should be :
> 
> char *strncpy(char *dest, const char *src, size_t count)
> {
>         char *tmp = dest;
>         if (unlikely(!count))
>                 goto end;
> loop1:
>         if ((*tmp = *src++) == '\0')
> 		goto next;
>         tmp++;
>         if (likely(--count))
> 		goto loop1;
> 	else
> 		goto end;
> loop2:
>         *tmp = '\0';
> next:
>         tmp++;
>         if (likely(--count))
> 		goto loop2;
> end:
>         return dest;
> }

I hope we do not opt to go with this version. :)

> (sorry for those who hate gotos). Look at it : no test is 
> performed twice, no byte is read nor written twice in any 
> case. The assembly code produced is optimal on x86 (well, 
> in fact we could delete exactly one conditionnal jump because 
> the compiler doesn't know how to reuse them for several tests).
> 16 inlinable instructions (= excluding function in/out) which 
> can be executed 2 at a time if your CPU has 2 pipelines. about
> 3 cycles/copied byte, 2 cycles/filled byte.

It does not give optimal code for CRIS for the second loop.
It can easily be fixed by combining loop2 and next (which
will cause tmp to be assigned twice when changing loop),
but I know this was not the intent of this exercise.

> Unfortunately, it fools branch predictors and prefetch 
> mechanisms found in today's processors, so it results in 
> slower code than yours (at least on athlon and P3). Perhaps 
> it would be fast on older processors, I don't know.
> 
> All that demonstrates that whatever your efforts in helping 
> the optimizer, the only meaningful result is the benchmark. 
> Number of bytes and speculations on the reusability of 
> information between lines of codes are not what makes our
> programs fast anymore :-(

It was easier some years ago, wasn't it? ;)

> > Testing on the CRIS architecture, your version is 24 instructions,
> > whereas mine is 18. For comparison, Eric's one is 12 and the
> > currently used implementation is 26 (when corrected for the
> > off-by-one error by comparing with > 1 rather than != 0 in the
> > second loop).
> 
> Just out of curiosity, can the CRIS architecture execute 
> multiple instructions per cycle ? have you tried to determine 

No it cannot. :( Our ETRAX 100LX processor which uses the
CRIS architecture is a 100 MIPS processor without most of
today's fancy processor optimizations like multiple instructions,
branch prediction etc. It is designed for embedded products.

> the dependencies between the instructions ? Did you time the 
> different functions ? (yours is rather fast on x86 BTW).

No I didn't, but I have done it now.

I made a program that called the respective strncpy() 
implementation a number of times copying a 100 byte string
into a 1000 byte buffer. For each function I tested with
copying 50, 100, 200 and 1000 bytes. I have attached the 
source to this mail if anyone wants to make sure I did not
screw up the benchmarking too much... ;)

This table shows the times in seconds to call each function
500,000 times for CRIS:

                   50         100         200        1000
Original        3.123906    6.138616    9.146204   33.323051  
Eric's          2.602632    5.105367    9.637701   45.910798  
Timothy's       3.125003    6.128571    9.147905   33.325337  
My first        2.868396    5.626149    8.138134   28.276760  
My second (for) 2.622412    5.129988    7.636364   27.786745  
Algorithmic     2.597808    5.119332    7.627300   27.785999  

Going by these numbers, Eric's version is a good candidate 
for the copying phase, but loses out badly when it comes to
the filling. The best versions here seem to be my version
with the for loops and your algorithmic version which both
give almost identical numbers (but look below for more on
the algorithmic version).

This table shows the times in seconds to call each function
20,000,000 times for my P4 2.53GHz:

                   50         100         200        1000
Original        2.900444    5.475311    9.095701   37.462796  
Eric's          2.988404    5.637352    9.576857   37.580639  
Timothy's       2.929508    5.534824    9.157147   36.836899  
My first        2.951068    5.511169    8.321381   29.669017  
My second (for) 2.921675    5.531486    8.296728   28.940855  
Algorithmic     3.911937    7.343235   12.699275   54.288284  

The interesting thing here is that the original code wins
the copying phase. But the numbers for the copying phase for
the first five versions are so similar, that I doubt one can 
say one is better than the other. However, when it comes to
the filling phase my versions are back in the lead. These 
numbers also shows very clearly what you stated above about
branch predictions, as the algorithmic version loses out
badly here.

All these numbers taken together, I would say that my version
with the for loops seems to be the overall winner. :)

> To conclude, I would say that if we want to implement really 
> fast low-level primitives such as str*, mem*, ... there's 
> nothing better than assembly associated with benchmarks on 
> different CPU architectures and models.
> 
> But I don't know if strncpy() is used enough to justify that...

I agree

> Regards,
> Willy

//Peter


------_=_NextPart_000_01C36313.44C70D10
Content-Type: application/octet-stream;
	name="testa.c"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="testa.c"

#include <stdio.h>=0A=
#include <stdlib.h>=0A=
#include <string.h>=0A=
#include <errno.h>=0A=
#include <sys/types.h>=0A=
=0A=
#include <sys/time.h>=0A=
=0A=
char *strncpy0(char *dest, const char *src, size_t count)=0A=
{=0A=
  char *tmp =3D dest;=0A=
=0A=
  while (count-- && (*tmp++ =3D *src++) !=3D '\0')=0A=
    /* nothing */;=0A=
=0A=
  return dest;=0A=
}=0A=
=0A=
char *strncpy0a(char *dest, const char *src, size_t count)=0A=
{=0A=
  char *tmp =3D dest;=0A=
=0A=
  while (count && (*dest++ =3D *src++) !=3D '\0')=0A=
    count--;=0A=
=0A=
  while (count > 1)=0A=
  {=0A=
    *dest++ =3D 0;=0A=
    count--;=0A=
  }=0A=
=0A=
  return tmp;=0A=
}=0A=
=0A=
char *strncpy0b(char *dest, const char *src, size_t count)=0A=
{=0A=
  char *tmp =3D dest;=0A=
=0A=
  while (count && (*tmp++ =3D *src++) !=3D '\0')=0A=
    count--;=0A=
=0A=
  while (count > 1)=0A=
  {=0A=
    *tmp++ =3D 0;=0A=
    count--;=0A=
  }=0A=
=0A=
  return dest;=0A=
}=0A=
=0A=
char *strncpy0x(char *dest, const char *src, size_t count)=0A=
{=0A=
  char *tmp =3D dest;=0A=
=0A=
  while (count)=0A=
  {=0A=
    if (!(*tmp =3D *src++))=0A=
      break;=0A=
    tmp++;=0A=
=0A=
    count--;=0A=
  }=0A=
=0A=
  return dest;=0A=
}=0A=
=0A=
char *strncpy1(char *dest, const char *src, size_t count)=0A=
{=0A=
  char *tmp =3D dest;=0A=
=0A=
  while (count)=0A=
  {=0A=
    if ((*tmp =3D *src))=0A=
      src++;=0A=
    tmp++;=0A=
=0A=
    count--;=0A=
  }=0A=
=0A=
  return dest;=0A=
}=0A=
=0A=
char *strncpy1x(char *dest, const char *src, size_t count)=0A=
{=0A=
  char *tmp =3D dest;=0A=
=0A=
  for (; count; count--)=0A=
  {=0A=
    if ((*tmp =3D *src))=0A=
      src++;=0A=
    tmp++;=0A=
  }=0A=
=0A=
  return dest;=0A=
}=0A=
=0A=
char *strncpy2(char *dest, const char *src, size_t count)=0A=
{=0A=
  char *tmp =3D dest;=0A=
=0A=
  while (count--)=0A=
  {=0A=
    if ((*tmp++ =3D *src))=0A=
      src++;=0A=
  }=0A=
=0A=
  return dest;=0A=
}=0A=
=0A=
char *strncpy3(char *dest, const char *src, size_t count)=0A=
{=0A=
   if (count)=0A=
   {=0A=
      char *tmp =3D dest;=0A=
=0A=
      while (1)=0A=
      {=0A=
         *tmp =3D *src;=0A=
         if (*src)=0A=
           src++;=0A=
         tmp++;=0A=
         if (!count--)=0A=
           break;=0A=
      }=0A=
   }=0A=
=0A=
   return dest;=0A=
}=0A=
=0A=
char *strncpy4(char *dest, const char *src, size_t count)=0A=
{=0A=
   if (count)=0A=
   {=0A=
      char *tmp =3D dest;=0A=
=0A=
      do=0A=
      {=0A=
         if ((*tmp =3D *src))=0A=
           ++src;=0A=
         ++tmp;=0A=
      } while (--count);=0A=
   }=0A=
=0A=
   return dest;=0A=
}=0A=
=0A=
char *strncpy5(char *dest, const char *src, size_t count)=0A=
{=0A=
  char *tmp =3D dest;=0A=
=0A=
  while (count && *src)=0A=
  {=0A=
    count--;=0A=
    *tmp++ =3D *src++;=0A=
  }=0A=
=0A=
  while (count--)=0A=
  {=0A=
    *tmp++ =3D 0;=0A=
  }=0A=
=0A=
  return dest;=0A=
}=0A=
=0A=
char *strncpy5w(char *dest, const char *src, size_t count)=0A=
{=0A=
  char *tmp =3D dest;=0A=
=0A=
  while (count)=0A=
  {=0A=
    if (*src =3D=3D '\0')=0A=
      break;=0A=
=0A=
    *tmp++ =3D *src++;=0A=
    count--;=0A=
  }=0A=
=0A=
  while (count)=0A=
  {=0A=
    *tmp++ =3D 0;=0A=
    count--;=0A=
  }=0A=
=0A=
  return dest;=0A=
}=0A=
=0A=
char *strncpy5x(char *dest, const char *src, size_t count)=0A=
{=0A=
  char *tmp =3D dest;=0A=
=0A=
  while (count)=0A=
  {=0A=
    count--;=0A=
    if (!(*tmp++ =3D *src++))=0A=
      break;=0A=
  }=0A=
=0A=
  while (count)=0A=
  {=0A=
    count--;=0A=
    *tmp++ =3D 0;=0A=
  }=0A=
=0A=
  return dest;=0A=
}=0A=
=0A=
char *strncpy5y(char *dest, const char *src, size_t count)=0A=
{=0A=
  char *tmp =3D dest;=0A=
=0A=
  for (; count && *src; count--)=0A=
    *tmp++ =3D *src++;=0A=
=0A=
  for (; count; count--)=0A=
    *tmp++ =3D '\0';=0A=
=0A=
  return dest;=0A=
}=0A=
=0A=
#define likely(x)    __builtin_expect(!!(x),1)=0A=
#define unlikely(x)  __builtin_expect(!!(x),0)=0A=
=0A=
char *strncpy6(char *dest, const char *src, size_t count)=0A=
{=0A=
  char *tmp =3D dest;=0A=
=0A=
  if (unlikely(!count))=0A=
    goto end;=0A=
=0A=
loop1:=0A=
  if ((*tmp =3D *src++) =3D=3D '\0')=0A=
    goto next;=0A=
  tmp++;=0A=
  if (likely(--count))=0A=
    goto loop1;=0A=
  else=0A=
    goto end;=0A=
=0A=
loop2:=0A=
  *tmp =3D '\0';=0A=
next:=0A=
  tmp++;=0A=
  if (likely(--count))=0A=
    goto loop2;=0A=
=0A=
end:=0A=
  return dest;=0A=
}=0A=
=0A=
char *strncpy6x(char *dest, const char *src, size_t count)=0A=
{=0A=
  char *tmp =3D dest;=0A=
=0A=
  if (unlikely(!count))=0A=
    goto end;=0A=
=0A=
loop1:=0A=
  if ((*tmp =3D *src++) =3D=3D '\0')=0A=
    goto loop2;=0A=
  tmp++;=0A=
  if (likely(--count))=0A=
    goto loop1;=0A=
  else=0A=
    goto end;=0A=
=0A=
loop2:=0A=
  *tmp++ =3D '\0';=0A=
  if (likely(--count))=0A=
    goto loop2;=0A=
=0A=
end:=0A=
  return dest;=0A=
}=0A=
=0A=
void time_it(char *(*func)(char *dest, const char *src, size_t =
count),=0A=
             size_t size)=0A=
{=0A=
  struct timeval start;=0A=
  struct timeval end;=0A=
  long sec, usec;=0A=
  static char *string =3D "asdl hfaslkfh alksjfh laksjh =
lkajsdflkasflksdf ljhfljshf laksflaksfhlaksjhflaksfh lakshf lkds =
hflsd";=0A=
  static char buffer[1000];=0A=
#ifdef __CRIS__=0A=
  int count =3D 500000;=0A=
#else=0A=
  int count =3D 20000000;=0A=
#endif=0A=
=0A=
  if (size > sizeof buffer)=0A=
  {=0A=
    fprintf(stderr, "Buffer too small!\n");=0A=
    exit(1);=0A=
  }=0A=
=0A=
  gettimeofday(&start, NULL);=0A=
=0A=
  while (count)=0A=
  {=0A=
    func(buffer, string, size);=0A=
    count--;=0A=
  }=0A=
=0A=
  gettimeofday(&end, NULL);=0A=
=0A=
  sec =3D end.tv_sec - start.tv_sec;=0A=
  if ((usec =3D end.tv_usec - start.tv_usec) < 0)=0A=
  {=0A=
    sec--;=0A=
    usec +=3D 1000000;=0A=
  }=0A=
=0A=
  printf("%3ld.%06ld  ", sec, usec);=0A=
  fflush(stdout);=0A=
}=0A=
=0A=
void do_it(const char *name,=0A=
           char *(*func)(char *dest, const char *src, size_t count))=0A=
{=0A=
  printf("%-12s  ", name);=0A=
  fflush(stdout);=0A=
  time_it(func, 50);=0A=
  time_it(func, 100);=0A=
  time_it(func, 200);=0A=
  time_it(func, 1000);=0A=
  printf("\n");=0A=
}=0A=
=0A=
#define TIME_IT(func) time_it(#func, func)=0A=
=0A=
int main(int argc, char* argv[])=0A=
{=0A=
  do_it("Original", strncpy0a);=0A=
  do_it("Eric's", strncpy1);=0A=
  do_it("Timothy's", strncpy5);=0A=
  do_it("My first", strncpy5x);=0A=
  do_it("For loops", strncpy5y);=0A=
  do_it("Algorithmic", strncpy6);=0A=
=0A=
  exit(0);=0A=
}=0A=

------_=_NextPart_000_01C36313.44C70D10--
