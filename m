Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268843AbTGMOhc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 10:37:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268853AbTGMOhc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 10:37:32 -0400
Received: from nice-1-a7-62-147-124-190.dial.proxad.net ([62.147.124.190]:41228
	"EHLO monpc") by vger.kernel.org with ESMTP id S268843AbTGMOh1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 10:37:27 -0400
From: Guillaume Chazarain <gfc@altern.org>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux-kernel@vger.kernel.org, phillips@arcor.de, smiler@lanil.mine.nu
Date: Sun, 13 Jul 2003 16:54:40 +0200
X-Priority: 3 (Normal)
Message-Id: <ZTEANKTPFA5YUR93JFQE096KF85YA8.3f1172b0@monpc>
Subject: Re: [RFC][PATCH] SCHED_ISO for interactivity
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
X-Mailer: Opera 6.06 build 1145
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

13/07/03 14:53:12, Con Kolivas <kernel@kolivas.org> wrote:

>On Sun, 13 Jul 2003 20:41, Guillaume Chazarain wrote:
>> Hi Con,
>>
>> I am currently testing SCHED_ISO, but I have noticed a regression:
>> I do a make -j5 in linux-2.5.75/ everything is OK since gcc prio is 25.
>> X and fvwm prio are 15, but when I move a window it's very jerky.
>
>Interesting. I don't know how much smaller the timeslice can be before 
>different hardware will be affected. Can you report what cpu and video card 
>you're using? Unfortunately I don't have a range of hardware to test it on 
>and I chose the aggressive 1/5th timeslice size. Can you try with ISO_PENALTY 
>set to 2 instead?

Pentium3 450, 320 Mo RAM, Voodoo Banshee

Good, with ISO_PENALTY == 2, I can smoothly move big windows (with ISO_PENALTY == 5
it was smooth only with very small windows), but it lets me move them smoothly
during less time than stock :(

>> And btw, as I am interested in scheduler improvements, do you have a
>> testcase where the stock scheduler does the bad thing? Preferably without
>> KDE nor Mozilla (I don't have them installed, and I'll have access to a
>> decent connection in september).
>
>Transparency and antialiased fonts are good triggers. Launcing Xterm with 
>transparency has been known to cause skips. Also the obvious make -j 4 kernel 
>compiles, and 
>while true ; do a=2 ; done
>as a fast onset full cpu hog

Well, I had a hard time at making xmms skip with a transparent gnome-terminal.
I could easily make xmms skip with this, but it's quite artificial.

#include <sys/types.h>
#include <stdio.h>
#include <time.h>
#include <unistd.h>

/* Should be near MAX_SLEEP_AVG. */
#define DELAY 20

/* With how many processes, will xmms resist? */
#define NPROC 4

int main(void)
{
    int i;
    pid_t the_pid, my_pid;

    the_pid = getpid();

    /* Make some friends. */
    for (i = 1; i < NPROC; i++)
        if (fork())
            break;

    my_pid = getpid();

    for (;;) {
        /* Wait, gain interactivity. */
        for (i = DELAY; i >= 0; i--) {
            if (the_pid == my_pid)
                printf("%d\n", i);
            sleep(1);
        }

        /* Attack! */
        if (my_pid == the_pid)
            puts("attack");
        for (i = 0; i < 100000000; i++);
    }

    return 0;
}

>The logical conclusion of this idea where there is a dynamic policy assigned 
>to interactive tasks is a dynamic policy assigned to non interactive tasks 
>that get treated in the opposite way. I'll code something for that soon, now 
>that I've had more feedback on the first part.

Interesting, let's see :)
But as the interactive bonus can already be negative I wonder what use
will have another variable.


Guillaume





