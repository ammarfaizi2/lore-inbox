Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262659AbTDIBZP (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 21:25:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262663AbTDIBZP (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 21:25:15 -0400
Received: from lists.asu.edu ([129.219.13.98]:32142 "EHLO lists.asu.edu")
	by vger.kernel.org with ESMTP id S262659AbTDIBZO (for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Apr 2003 21:25:14 -0400
Date: Tue, 08 Apr 2003 18:36:52 -0700 (MST)
From: Shesha@asu.edu
Subject: Re: readprofile: 0 total     nan (fwd)
To: linux-kernel@vger.kernel.org, kernelnewbies@nl.linux.org
Message-id: <Pine.GSO.4.21.0304081836190.25278-100000@general3.asu.edu>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello All

I am not very sure that it is readprofile application problem. I downloaded
readprofile source and I compiled it. It worked fine on x86 machine running
2.4.7-10 kernel. I cross compiled it for xscale processor running 2.4.18 it
is not working.

Any Input?


On Tue, 8 Apr 2003, Andy Pfiffer wrote:

> On Tue, 2003-04-08 at 15:41, Shesha@asu.edu wrote:
> > I am running 2.4.18 kernel for ARM. I have one of the boot parameters
> > "profile=2". The size of the /proc/profile file is shown as 16MB. But when I
> > execute "readprofile" the output is ...  
> > 0 total                                         nan
> > 
> > If I cat the file it just give me a ".". Can anyone suggest what i am doing
> > wrong?
> 
> [ I swear I was just talking about this problem with someone else... ]
> 
> 1. /proc/profile is a binary file.  cat won't show you anything
> meaningful.
> 
> 2. the 0 output by readprofile is a problem with the automatic
> byte-order detection heuristic built into the code.  Try invoking
> readprofile with the "-n" option, and see if your problem goes away.
> 
> FYI: For those that might also run into this, the essence of the problem
> is this piece of code in readprofile.c (fragmented for clarity):
> 
> "optNative" is 0.
> "buf" is an unsigned int *.
> 
> 
> if (!optNative) {
>         int entries = len/sizeof(*buf);
>         int big = 0,small = 0,i;
>         unsigned *p;
> 
>         for (p = buf+1; p < buf+entries; p++)
>                 if (*p) {
>                         if (*p >= 1 << (sizeof(*buf)/2)) big++;
>                         else small++;
>                 }       
>         if (big > small) {
>                 fprintf(stderr,"Assuming reversed byte order. "
>                    "Use -n to force native byte order.\n");
>                 <snipped>
>                 .
>                 .
>                 .
>         }       
> }
> 
> Based on my read of the code, "big" will be incremented if *p >= 4,
> otherwise "small" will be incremented.  I can't see how this would ever
> detect the byte order...
> 
> Werner proposed this as a solution, but it could still fail to correctly
> detect the byteorder (although with much less frequency):
> 
> 
> 


