Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272619AbRHaHE7>; Fri, 31 Aug 2001 03:04:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272621AbRHaHEu>; Fri, 31 Aug 2001 03:04:50 -0400
Received: from wildsau.idv-edu.uni-linz.ac.at ([140.78.40.25]:46098 "EHLO
	wildsau.idv-edu.uni-linz.ac.at") by vger.kernel.org with ESMTP
	id <S272619AbRHaHEf>; Fri, 31 Aug 2001 03:04:35 -0400
From: Herbert Rosmanith <herp@wildsau.idv-edu.uni-linz.ac.at>
Message-Id: <200108310704.f7V74E722212@wildsau.idv-edu.uni-linz.ac.at>
Subject: Re: [IDEA+RFC] Possible solution for min()/max() war
In-Reply-To: <200108302106.f7UL6t917787@oboe.it.uc3m.es> from "Peter T. Breuer" at "Aug 30, 1 11:06:55 pm"
To: ptb@it.uc3m.es
Date: Fri, 31 Aug 2001 09:04:14 +0200 (MET DST)
Cc: herp@wildsau.idv-edu.uni-linz.ac.at, linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL37 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > only problem seems to be signed/unsigned int comparison.
> 
> I don't know how you know that! You could be right - I don't know.

because I asked the only competent instanace around: my computer.

  : ferkel:~ # more sc.c
  : #include        <stdio.h>
  : 
  : int main() {
  : signed char ca;
  : unsigned char cb;
  : 
  : signed int ia;
  : unsigned int ib;
  : 
  :         ca=-1;
  :         cb=2;
  :         if (ca<cb) printf("ca<cb\n");
  :         else if (ca>cb) printf("ca>cb\n");
  :         else printf("ca==cb\n");
  : 
  :         ia=-1;
  :         ib=2;
  :         if (ia<ib) printf("ia<ib\n");
  :         else if (ia>ib) printf("ia>ib\n");
  :         else printf("ia==ib\n");
  : 
  : }

this will give the result:

  : ferkel:~ # ./sc
  : ca<cb
  : ia>ib


you see? 

if you _explictely_ cast the signed value to unsigned, the result will
be wrong just the same way as if you did not cast it at all. if you
cast the unsigned value to signed, you will have the same problem if
the unsigned value is >  0x7fffffff. so the new macros are absolutely
unneccessary, because they do not fix anything.

> for me to be able to begin to formulate a generic solution. I've just
> seen some examples, some more convincing than others.
> 
> > >   const (typeof(a)) _a = ~(typeof(a))0
> > >   const (typeof(b)) _b = ~(typeof(b))0
> > >   if _a < 0 && _b > 0 || _a > 0 && b < 0
> > >       BUG() // one signed, the other unsigned
> > >   standard_max(a,b)
> > 
> > if sizeof(typeof(a))==sizeof(int) && sizeof(typeof(b))==sizeof(int) &&
> >    ( _a < 0 && _b > 0 || _a > 0 && b < 0 )
> > 	BUG() // signed unsigned int compare
> 
> What makes sizeof(int) so magic? Are you saying that the problems
> don't arise between signed long long and unsigned long long? I saw

no, that was just an example. long long doesnt work either.  and the
sizeof(int) is bound to 32bit platforms. unfortunately, I dont have a
64bit CPU around. the problem seems to arise where the size of a datatype
equals or extends the size of a machineword. so, really correct would
be:

  : if sizeof(typeof(a))>=sizeof(machineword) &&
  :    sizeof(typeof(b))>=sizeof(machineword)
   

however I dont know where to get this "machineword".

