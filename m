Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318703AbSHALij>; Thu, 1 Aug 2002 07:38:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318704AbSHALij>; Thu, 1 Aug 2002 07:38:39 -0400
Received: from sj-msg-core-2.cisco.com ([171.69.24.11]:39129 "EHLO
	sj-msg-core-2.cisco.com") by vger.kernel.org with ESMTP
	id <S318703AbSHALii>; Thu, 1 Aug 2002 07:38:38 -0400
Message-Id: <5.1.0.14.2.20020801190102.0295bea0@mira-sjcm-3.cisco.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Thu, 01 Aug 2002 21:40:29 +1000
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
From: Lincoln Dale <ltd@cisco.com>
Subject: Re: Linux 2.4.19ac3rc3 on IBM x330/x340 SMP - "ps" time skew
Cc: david_luyer@pacific.net.au (David Luyer),
       alan@lxorguk.ukuu.org.uk ('Alan Cox'), linux-kernel@vger.kernel.org
In-Reply-To: <200208010133.g711Xq7338295@saturn.cs.uml.edu>
References: <5.1.0.14.2.20020801094111.02776df0@mira-sjcm-3.cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 09:33 PM 31/07/2002 -0400, Albert D. Cahalan wrote:
> > HZ on x86 is 100 by default.
> > that isn't 100 per CPU, but 100 per second, regardless of whether the 
> timer
> > interrupt is distributed between CPUs or serviced on a single CPU.
>
>No shit. Now, how do you create a ps executable that handles
>a 2.4.xx kernel with a modified HZ value? People did this all
>the time. I got many bug reports from these people, so don't
>go saying they don't exist. Remember: one executable, running
>on both of the these:

thanks for the rant.  most entertaining.  for what its worth, i wasn't 
trolling.

>2.2.xx i386 as shipped by Linus
>2.4.xx i386 with HZ modified

(i assume you mean 2.4.xx i386 as shipped by Linus)

>Come on, write the code if you think it's so easy.
>You get bonus points for supporting 2.0.xx kernels
>and the IA-64 kernel with that same executable.

i suspect you're confusing me with someone else.

in either case, for ELF executables, the kernel puts the CLOCKS_PER_TICK on 
the stack when loading an elf binary.
this is defined to be HZ on all platforms except ia32 where its set to 
100.  one would hope that if you redefine HZ to something else, you also 
remember to redefine CLOCKS_PER_TICK to that same value too.

my tree uses CLOCKS_PER_TICK set to HZ for x86 too.  i also use a tree with 
HZ set to 1000 for a packet-latency-inducer packet-scheduler i use.

the following code determines the value of CLOCKS_PER_TICK in a reliable 
manner on the hosts i have here (2.4.xx, 2.5.xx, ia32):
i don't have any alpha or ia64 boxes here, but i'm confident it'll still 
give you the correct result.


--
         #include <stdio.h>
         #include <unistd.h>

         #define AT_CLKTCK       17              /* Frequency of times() */

         int main(int argc, char *argv[])
         {
                 int i = 0;

                 fprintf(stderr,"sysconf says %u ticks per 
second\n",sysconf(_SC_CLK_TCK));

                 /* loop through command-line and args */
                 while (argv[i] != NULL)
                         i++;

                 /* loop through environment variables */
                 i++;
                 while (argv[i] != NULL)
                         i++;

                 /* now at elf variables */
                 i++;
                 while (argv[i] != NULL) {
                         if ((int)argv[i] != AT_CLKTCK) {
                                 fprintf(stderr,"(elf header entry %d has 
value %d)\n",
                                         (int)argv[i], (int)(argv[(i+1)]));
                         } else {
                                 /* got it */
                                 fprintf(stderr,"eureka, elf header says we 
have %d ticks per second\n",(int)argv[(i+1)]);
                                 break;
                         }
                         i += 2;
                 }
         }
--

the code doesn't work on a 2.2.16 box here, given 2.2.16 doesn't have 
AT_CLKTCK, but i believe that is incidental to this discussion.


cheers,

lincoln.

