Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287743AbSATAUM>; Sat, 19 Jan 2002 19:20:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287764AbSATAUC>; Sat, 19 Jan 2002 19:20:02 -0500
Received: from pop018pub.verizon.net ([206.46.170.212]:53964 "EHLO
	pop018.verizon.net") by vger.kernel.org with ESMTP
	id <S287743AbSATATr>; Sat, 19 Jan 2002 19:19:47 -0500
Message-ID: <3C4A0D1B.9020605@bellatlantic.net>
Date: Sat, 19 Jan 2002 19:19:39 -0500
From: "James C. Owens" <owensjc@bellatlantic.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7+) Gecko/20020111
X-Accept-Language: en-us
MIME-Version: 1.0
To: mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: Re: [patch] O(1) scheduler updates, -J2
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo,

Tested -J2 on SuSE 6.4 Linux 2.4.17 kernel on my "big" Linux box - Tyan
Tiger MP, 2x Athlon MP 1600+ with 1.25 GB RAM and Mylex AcceleRAID 170 
RAID 5. Default parameters for timeslice, etc in -J2 sched.h were used.

Excellent interactivity maintained with make -j bzImage issued - load
average was about 100. Mozilla 0.9.7 was very usable while this was 
going on.

Kernel compile times:

with no other significant processes (CPU wise) running

                          O(1) J2          default

make bzImage            3 min 45 sec     3 min 36 sec	
make -j2 bzImage        1 min 59 sec     1 min 57 sec
make -j16 bzImage       2 min 02 sec     2 min 01 sec
make -j bzImage         2 min 13 sec     2 min 09 sec
      peak -j load        106              210


with 2 setiathome processes running at nice 19

                          O(1) J2          default

make bzImage            4 min 10 sec     3 min 42 sec
make -j2 bzImage        2 min 56 sec     2 min 17 sec
make -j16 bzImage       2 min 22 sec     2 min 03 sec
make -j bzImage         2 min 24 sec     2 min 11 sec
      peak -j load        100              206

A few things come to my attention with these numbers. It seems as if 
heavily niced processes are still getting too much CPU time. Also, there 
    may be work still needed on the parent-child stuff - Just watching 
the graphical output of xosview and KDE System Guard during make -j2 
with the seti processes running showed that CPU 0 was only being used 
about 50% of the time on average, with sometimes it being totally used 
by the niced SETI process, and other times totally by the compile. The 
fraction of usage for CPU 0 for the non-niced compile processes would 
bounce wildly between 0 and 100% (with the SETI always making up the 
difference). CPU 1 would always remain fully loaded with the compile. 
Dividing the two corresponding times for the make -j2 case 
((1+59/60)/(2+56/60)) gives a CPU usage of 0.68 of available for 
compilation.

Usage this 0.68 as a proportion ratio, this means the SETI process(es) 
were getting 0.32 or 32% of the total processor time on the machine. 
Assigning 0.5 to CPU 1 (which was fully loaded), and subtracting from 
0.68 gives 0.18. Multiplying 0.18 by two to get the fraction on CPU 0 
gives 0.36 or 36%, which means CPU 1 was spending 36% of its time on the 
compile and 64% on SETI. This is in-line with the visual behavior seen 
watching xosview and KDE System Guard.

Do you think this is correct behavior, or is more tuning or adjustment 
to the balancing algorithm in order? Maybe the same issue that is 
causing this is behind getting a peak load of only about 100 doing make 
-j with O(1) versus about 200 with the normal scheduler.

The interactivity is absolutely stunning. The GUI remains extremely 
usable even during the make -j's which brings interactivity to its knees 
with the normal scheduler.

Absolutely *no* stability issues whatsover. Rock-solid.

Hope this provides some useful info.

Jim Owens

