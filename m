Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266444AbSLDMW0>; Wed, 4 Dec 2002 07:22:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266453AbSLDMW0>; Wed, 4 Dec 2002 07:22:26 -0500
Received: from turn6.biologie.uni-konstanz.de ([134.34.128.74]:24983 "EHLO
	turn6.biologie.uni-konstanz.de") by vger.kernel.org with ESMTP
	id <S266444AbSLDMWY>; Wed, 4 Dec 2002 07:22:24 -0500
Message-ID: <3DEDF543.51C80677@uni-konstanz.de>
Date: Wed, 04 Dec 2002 13:29:55 +0100
From: Kay Diederichs <kay.diederichs@uni-konstanz.de>
Organization: =?iso-8859-1?Q?Universit=E4t?= Konstanz
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.19-mosix i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: stock 2.4.20: loading amd76x_pm makes time jiggle on A7M266-D
Content-Type: multipart/mixed;
 boundary="------------F846291740C78267A8AD2EAE"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------F846291740C78267A8AD2EAE
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

the subject says it all: 

if I use the powersaving module amd76x_pm then the time is not kept. The
hardware is Asus A7M266-D with 2 MP1900 processors, BIOS is 1004 (but I
tried later BIOS versions as well).

Symptoms are:

- ping times vary and there are 'time of day goes back' messages:

64 bytes from xx (1.2.3.4): icmp_seq=4 ttl=64 time=19.549 msec
64 bytes from xx (1.2.3.4): icmp_seq=5 ttl=64 time=2.684 sec
Warning: time of day goes back, taking countermeasures.
64 bytes from xx (1.2.3.4): icmp_seq=6 ttl=64 time=9.799 msec
64 bytes from xx (1.2.3.4): icmp_seq=7 ttl=64 time=88 usec
64 bytes from xx (1.2.3.4): icmp_seq=8 ttl=64 time=20.011 msec
(addresses edited)

- ntpq -p shows a very high jitter:
     remote           refid      st t when poll reach   delay   offset 
jitter
==============================================================================
 loop8.biologie. 134.34.3.18      2 u    6   64   77    0.807  -1920.6
1804.31
 helix1.biologie 134.34.3.18      2 u   13   64   77    0.348  -1914.9
1803.99

- ntpd complains:

Dec  3 19:18:51 turn22 ntpd[730]: synchronisation lost
Dec  3 20:12:15 turn22 ntpd[730]: synchronisation lost
Dec  3 22:50:40 turn22 ntpd[730]: synchronisation lost
Dec  3 23:01:18 turn22 ntpd[730]: synchronisation lost

- the program 'check_time' (attached) which was once posted by R.
Johnson on this list shows that the internal timekeeping is
inconsistent:

Time = 3dedf443
Last = 3dedf440
Time = 3dedf440
Last = 3dedf443
Time = 3dedf443
Last = 3dedf440
Time = 3dedf440
Last = 3dedf443
Time = 3dedf443
Last = 3dedf440
Time = 3dedf440
Last = 3dedf443
Time = 3dedf443
Last = 3dedf440
Time = 3dedf440

Any ideas? Am I really the only one who has seen these problems (on 4
identical machines, BTW)?

Kay
-- 
Kay Diederichs         http://strucbio.biologie.uni-konstanz.de/~kay 
email: Kay.Diederichs@uni-konstanz.de  Tel +49 7531 88 4049 Fax 3183
When replying to my email, please remove the blanks before and after the
"@" !
Fakultaet fuer Biologie, Universitaet Konstanz, Box M656, D-78457
Konstanz
--------------F846291740C78267A8AD2EAE
Content-Type: text/plain; charset=us-ascii;
 name="check_time.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="check_time.c"

#include <stdio.h> 
#include <time.h> 

int main() 
{ 
    time_t tim; 
    time_t last; 
    (void)time(&last); 
    (void)time(&tim); 
    for(;;) 
    { 
        (void)time(&tim); 
        if(tim != last) 
        { 
            if((last +1) != tim) 
            { 
                fprintf(stderr,"Time = %08lx\n", tim); 
                fprintf(stderr,"Last = %08lx\n", last); 
            } 
            last = tim; 
        } 
    } 
} 

--------------F846291740C78267A8AD2EAE--

