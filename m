Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271147AbRH3VS5>; Thu, 30 Aug 2001 17:18:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272474AbRH3VSv>; Thu, 30 Aug 2001 17:18:51 -0400
Received: from chaos.analogic.com ([204.178.40.224]:58240 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S272477AbRH3VSJ>; Thu, 30 Aug 2001 17:18:09 -0400
Date: Thu, 30 Aug 2001 17:17:50 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Herbert Rosmanith <herp@wildsau.idv-edu.uni-linz.ac.at>
cc: linux-kernel@vger.kernel.org, ptb@it.uc3m.es
Subject: Re: [IDEA+RFC] Possible solution for min()/max() war
In-Reply-To: <200108302044.f7UKi7c20040@wildsau.idv-edu.uni-linz.ac.at>
Message-ID: <Pine.LNX.3.95.1010830171614.18406A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Aug 2001, Herbert Rosmanith wrote:

> 
> >   if sizeof(typeof(a)) != sizeof(typeof(b))
> >       BUG() // sizes differ
> 
> this is not neccessarily a problem. should work with char/short char/int
> short/int comparison.
> 
> only problem seems to be signed/unsigned int comparison.
> 
> >   const (typeof(a)) _a = ~(typeof(a))0
> >   const (typeof(b)) _b = ~(typeof(b))0
> >   if _a < 0 && _b > 0 || _a > 0 && b < 0
> >       BUG() // one signed, the other unsigned
> >   standard_max(a,b)
> 
> if sizeof(typeof(a))==sizeof(int) && sizeof(typeof(b))==sizeof(int) &&
>    ( _a < 0 && _b > 0 || _a > 0 && b < 0 )
> 	BUG() // signed unsigned int compare
> 



The problem really can't be solved with macros. Here is a little script
that you can run, which shows that some versions of gcc don't even
perform macro-expansion correctly.

SNIP-------
#!/bin/bash
cat >/tmp/xxx.c <<EOF
#include <stdio.h>
#undef MIN
#define MIN(a, b) ((unsigned int)(a) < (unsigned int)(b) ? (a) : (b)) 
int main(void);
int main() {
   int i;
   unsigned int j;
   i = j = 0;
   printf("%08x\n", MIN(i, j));
   return 0;
}
EOF
gcc -Wall -Wsign-compare -c -o /dev/null /tmp/xxx.c
rm -f /tmp/xxx.c
gcc --version
SNIP------

Here's a "good" execution:

Script started on Thu Aug 30 17:00:10 2001
# sh -v xxx.sh
#!/bin/bash
cat >/tmp/xxx.c <<EOF
gcc -Wall -Wsign-compare -c -o /dev/null /tmp/xxx.c
rm -f /tmp/xxx.c
gcc --version
egcs-2.91.66
# exit
exit
Script done on Thu Aug 30 17:00:24 2001

Here's a "bad" execution:

Script started on Thu Aug 30 16:55:30 2001
[root@blackhole /root]# sh -v xxx.sh
#!/bin/bash
cat >/tmp/xxx.c <<EOF
gcc -Wall -Wsign-compare -c -o /dev/null /tmp/xxx.c
/tmp/xxx.c: In function `main':
/tmp/xxx.c:9: warning: signed and unsigned type in conditional expression
rm -f /tmp/xxx.c
gcc --version
2.96

[root@blackhole /root]# exit
Script done on Thu Aug 30 16:55:58 2001
This version was shipped with RedHat 7.x

As you can see, the casts are !!!IGNORED!!! in gcc 2.96.

The min() macro is not really used for the mathematical min, anywhere
I've found it in the kernel. It's used as a whatever_will_fit() macro
where the writer wanted to prevent a buffer overflow. In these cases,
the compare should always be unsigned, even if the input values are
signed integers. It is possible to have a buffer of 0xffffffff bytes
in length and certainly 2 bytes will fit into it. Because of the
overloading of common functions to return -1 and other signed values,
it is commonplace to use signed integers to store large values without
regard for sign. Whether or not this is a design error is moot. It's
done "everywhere".

An attempt to discover signed compare problems by redefining a common
macro is doomed to fail. No matter what you do, it can be shown to
be wrong. I suggest we just leave the damn thing alone and fix any
bugs found in the normal way, i.e., "If it ain't broke, don't fix it."

Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


