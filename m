Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262369AbTKRHFL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Nov 2003 02:05:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262373AbTKRHFL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Nov 2003 02:05:11 -0500
Received: from bluejay.broadware.com ([209.219.63.5]:64214 "EHLO
	bluejay.broadware.com") by vger.kernel.org with ESMTP
	id S262369AbTKRHE7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Nov 2003 02:04:59 -0500
Message-ID: <001d01c3ada2$275ba310$0200a8c0@vaiors410>
From: "Suman Puthana" <suman@broadware.com>
To: <linux-kernel@vger.kernel.org>
Cc: "Suman Puthana" <suman@broadware.com>
Subject: usleep() bug in kernels > 2.4.18?
Date: Mon, 17 Nov 2003 23:03:59 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm trying to fix a bug in our application which happens when used with
kernels 2.4.19 and thereafter. I've narrowed it down to a problem with the
usleep() call.

What I have noticed is that the usleep() sleeps within 5-10% accuracy for
times > 30 ms in kernels upto 2.4.18 which is good enough.(eg:-32 ms for 30
ms)

But in kernels from 2.4.19 onwards -

    for any value between ( 31-40 ms ), usleep sleeps for 50 ms
    for any value between ( 41-50 ms ), usleep sleeps for 60 ms
    for any value between ( 51-60 ms ), usleep sleeps for 70 ms

and so on...You can see the trend which is kind of strange. I see that some
kind of granularity has been introduced into the newer kernels and I would
like to avoid that if possible.

Is there an easy way to avoid this? I understand that linux is not an RTOS
but something which worked in the previous kernels does not work anymore.
I'm just getting into understanding  low-level linux kernel stuff...So any
input or pointers into understanding this issue would be greatly
appreciated.

The same system (I've attached the ver_linux output at the end) when booted
from a 2.4.18 kernel gives a lot better results for usleep() than when
booted from the 2.4.21 kernel ( results as shown above) . I get the same
results as shown above with 2.4.19 , 2.4.20, 2.4.21 and 2.4.22 kernels. I've
tried this on a few different systems and can reliably reproduce this on the
newer kernels.

Thanks in Advance,
-Suman

++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

Here's the simple program I used to get these results :

#include <stdio.h>
#include <unistd.h>
#include <time.h>
#include <sys/time.h>

#define MILLISEC_DIFF(new, old, diff)   {                              \
        (diff) = (((new).tv_sec  - (old).tv_sec)  * 1000L ) +           \
                 (((new).tv_usec - (old).tv_usec) / 1000L );             \
}

int main(int args, char ** argv) {

        int time = 30;
        struct timeval time1,time2;
        long elapsed;

        if(args < 2) {
                printf("USAGE: sleep <time in milliseconds>\n");
                exit(0);
        }

        time = atoi(argv[1]);

        while(1) {

                gettimeofday(&time1, NULL);
                usleep(time*1000);
                gettimeofday(&time2, NULL);

                MILLISEC_DIFF(time2, time1, elapsed);

                printf("time 1 = <%ld:%ld>, time 2 = <%ld:%ld> ,elapsed =
%ld\n\n",time1.tv_sec, time1.tv_usec, time2.tv_sec, time2.tv_usec, elapsed);
        }
}

++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

Here's the sample output of the program for 30 ms sleep request:

time 1 = <1069136424:911198>, time 2 = <1069136424:951193> ,elapsed = 39

time 1 = <1069136424:951198>, time 2 = <1069136424:991188> ,elapsed = 39

time 1 = <1069136424:991191>, time 2 = <1069136425:31220> ,elapsed = 41

time 1 = <1069136425:31270>, time 2 = <1069136425:71235> ,elapsed = 39

time 1 = <1069136425:71249>, time 2 = <1069136425:111192> ,elapsed = 39

time 1 = <1069136425:111200>, time 2 = <1069136425:151190> ,elapsed = 39

time 1 = <1069136425:151193>, time 2 = <1069136425:191195> ,elapsed = 40

++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

Here's the output of ver_linux:

[root@petey scripts]# ./ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux petey 2.4.21-4.ELsmp #1 SMP Fri Oct 3 17:52:56 EDT 2003 i686 i686 i386
GNU/Linux

Gnu C                  3.2.3
Gnu make               3.79.1
util-linux             2.11y
mount                  2.11y
modutils               2.4.25
e2fsprogs              1.32
jfsutils               1.1.2
reiserfsprogs          3.6.4
pcmcia-cs              3.1.31
PPP                    2.4.1
isdn4k-utils           3.1pre4
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 2.0.13
Net-tools              1.60
Kbd                    1.08
Sh-utils               4.5.3
Modules Loaded         nfs lockd sunrpc ide-cd cdrom sg parport_pc lp
parport autofs e1000 floppy microcode keybdev mousedev hid input usb-uhci
usbcore ext3 jbd qla2300 sd_mod scsi_mod

