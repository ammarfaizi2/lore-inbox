Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277228AbRJQVTJ>; Wed, 17 Oct 2001 17:19:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277229AbRJQVTA>; Wed, 17 Oct 2001 17:19:00 -0400
Received: from mail3.svr.pol.co.uk ([195.92.193.19]:39200 "EHLO
	mail3.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S277228AbRJQVSw>; Wed, 17 Oct 2001 17:18:52 -0400
Posted-Date: Wed, 17 Oct 2001 21:10:58 GMT
Date: Wed, 17 Oct 2001 22:10:58 +0100 (BST)
From: Riley Williams <rhw@MemAlpha.cx>
Reply-To: Riley Williams <rhw@MemAlpha.cx>
To: Jan Hudec <bulb@ucw.cz>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: proc file system
In-Reply-To: <20011015170239.G2542@artax.karlin.mff.cuni.cz>
Message-ID: <Pine.LNX.4.21.0110172051340.9596-100000@Consulate.UFP.CX>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jan.

>>>> Well, to get tail -f to work, minimally you'll have to support...

>>> ... thus it won't work on char dev at all;-)

>> Why won't it?

> Well, I didn't look thoroughly, so it might. But - it uses stat and
> stat stats the device inode, not the device itself.

I've just checked, and it hangs as you predicted, at least with
/dev/urandom (which is a char device).

However, this part of the discussion appears to be irrelevant to the
main thrust of your argument. As you appear to have problems with the
reasoning I've been offering as to why your argument is false, can I
offer you the challenge of writing a /proc file driver to satisfy a
simple program I've written? I've used /proc/dev as the /proc file in
question in this source code, but you can change that to match whatever
you decide to call it.

 Q> /* Test program to determine if /proc is the equivalent of /dev
 Q>  * (which I do not believe).
 Q>  */
 Q>
 Q> #include <stdio.h>
 Q> #include <stdlib.h>
 Q>
 Q> int main(void) {
 Q>     char test[256];
 Q>     FILE *fp = fopen("/proc/dev","r");
 Q>     int result = 0, N, P, count;
 Q>
 Q>     for (count=1; count<255; count++) {
 Q>         N = (int) (224.0 * rand() / (RAND_MAX + 1.0) + 1.0);
 Q>         fgets( test, N, fp );
 Q>         for (P=0; P<N; P++)
 Q>             if (test[P] != P+32 && )
 Q>                 result++;
 Q>     }
 Q>     fclose( fp );
 Q>     exit( result );
 Q> }

To succeed, it must exit with a return value of 0. The driver can make
the following assumption:

 1. The program will read a series of successive strings from the
    device, these strings being between 1 and 224 characters in
    length.

For the program to return a 0 value, the driver needs to make the
following guarantees:

 A. There will always be at least 224 characters available to read.

 B. No matter what position in the file the program reads from, it
    always receives the same sequence of bytes, where each byte
    contains the value that is 32 higher than its position in the
    string.

Nothing else needs to be guaranteed, and this is a trivial driver to
write as a /dev driver. However, I believe that with the current kernel
design, it is actually impossible to write this as a /proc file driver.

Comments?

Best wishes from Riley.

