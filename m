Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272151AbRH3J4q>; Thu, 30 Aug 2001 05:56:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272152AbRH3J40>; Thu, 30 Aug 2001 05:56:26 -0400
Received: from wildsau.idv-edu.uni-linz.ac.at ([140.78.40.25]:5393 "EHLO
	wildsau.idv-edu.uni-linz.ac.at") by vger.kernel.org with ESMTP
	id <S272151AbRH3J4Z>; Thu, 30 Aug 2001 05:56:25 -0400
From: Herbert Rosmanith <herp@wildsau.idv-edu.uni-linz.ac.at>
Message-Id: <200108300956.f7U9u7D16494@wildsau.idv-edu.uni-linz.ac.at>
Subject: Re: [IDEA+RFC] Possible solution for min()/max() war
To: linux-kernel@vger.kernel.org
Date: Thu, 30 Aug 2001 11:56:07 +0200 (MET DST)
X-Mailer: ELM [version 2.4ME+ PL37 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Please guys. The issue of sign in comparisons are a LOT more complicated
> than most of you seem to think.

as a friend of mine put it on IRC:
  "Your little brains are not able to grasp the complicated issue of
  sign in comparisons."

If the problem is compiler-related, shouldn't it be forwared to the
gcc-group?

e.g.:

    : void foo() {
    : unsigned int i;
    : signed int j;
    : 
    : 	i=j;
    : }

does not generated a warning even with "-Wall". I think it should print
out something like "warning: sign will be lost in signed to unsigned
assignment".

The rules for signed/unsigned comparison should be:
 o the sign is always "sticky" (i.e. signed/unsigned -> signed)
 o data size is expanded to the size of the larger var.
 o (1) if the larger var is unsigned, data size is expanded
       even further.
   (2) if that's not possible, use carry flag.

However, I noticed that this "value-preserving arithmetic conversion"
is not always performed.

code follows:


    : #include        <stdio.h>
    : 
    : int main() {
    : 
    : unsigned char ca;
    : signed char cb;
    : 
    : unsigned short sa;
    : signed short sb;
    : 
    : unsigned int ia;
    : signed int ib;
    : 
    :         ca=0xff;
    :         cb=0xff;
    :         printf("ca=%u cb=%d\n",ca,cb);
    :         if (ca<cb) printf("ca<cb\n");
    :         else if (ca>cb) printf("ca>cb\n");
    :         else printf("ca==cb\n");
    : 
    :         sa=0xffff;
    :         sb=0xffff;
    :         printf("sa=%u sb=%hd\n",sa,sb);
    :         if (sa<sb) printf("sa<sb\n");
    :         else if (sa>sb) printf("sa>sb\n");
    :         else printf("sa==sb\n");
    : 
    :         ia=0xffffffff;
    :         ib=0xffffffff;
    :         printf("ia=%u ib=%d\n",ia,ib);
    :         if (ia<ib) printf("ia<ib\n");
    :         else if (ia>ib) printf("ia>ib\n");
    :         else printf("ia==ib\n");
    : 
    :         return 0;
    : }

will result to:

    : bash-2.03# cc -Wsign-compare -o cm cm.c
    : cm.c: In function `main':
    : cm.c:32: warning: comparison between signed and unsigned
    : cm.c:33: warning: comparison between signed and unsigned
    : bash-2.03# ./cm
    : ca=255 cb=-1
    : ca>cb
    : sa=65535 sb=-1
    : sa>sb
    : ia=4294967295 ib=-1
    : ia==ib


so, in the "int" case, the result of the comparison is wrong. (shouldnt
it be expanded to long long, or at least use the carry-flag?)
If the min/max macros explicitly cast a signed data-type to an
unsigned one, the meaning of the sign-bit will be lost in any
way, not only in the int-case.



