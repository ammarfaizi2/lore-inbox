Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751228AbWDNDT2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751228AbWDNDT2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 23:19:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965075AbWDNDT2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 23:19:28 -0400
Received: from dial169-232.awalnet.net ([213.184.169.232]:29446 "EHLO
	raad.intranet") by vger.kernel.org with ESMTP id S1751223AbWDNDT1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 23:19:27 -0400
From: Al Boldi <a1426z@gawab.com>
To: Con Kolivas <kernel@kolivas.org>
Subject: Re: [patch][rfc] quell interactive feeding frenzy
Date: Fri, 14 Apr 2006 06:16:33 +0300
User-Agent: KMail/1.5
Cc: ck list <ck@vds.kolivas.org>, linux-kernel@vger.kernel.org,
       Mike Galbraith <efault@gmx.de>
References: <200604112100.28725.kernel@kolivas.org> <200604121825.55054.a1426z@gawab.com> <200604132151.22359.kernel@kolivas.org>
In-Reply-To: <200604132151.22359.kernel@kolivas.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_RQxPEi1P/f/JoBh"
Message-Id: <200604140616.33370.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_RQxPEi1P/f/JoBh
Content-Type: text/plain;
  charset="windows-1256"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Con Kolivas wrote:
> On Thursday 13 April 2006 01:25, Al Boldi wrote:
> > Con Kolivas wrote:
> > > Nvidia driver; all separate tasks in top.
> >
> > On a 400MhzP2 i810drm w/ kernel HZ=1000 it stutters.
> > You may want to compensate for nvidia w/ a few cpu-hogs.
>
> I tried adding cpu hogs and it gets extremely slow very soon but still
> doesn't stutter here.
>
> > How many gears fps do you get?
>
> When those 3 are running concurrently (without any other cpu hogs) gears
> is showing 317 fps.

Your machine is probably too fast to show the problem, due to enough 
cpu-cycles/timeslice to complete the request.

Can you try the attached mem-eater passing it the number of kb to be eaten.

        i.e. '# while :; do ./eatm 9999 ; done' 

This will print the number of bytes eaten and the timing in ms.

Assuming timeslice=100, adjust the number of kb to be eaten such that the 
timing will be less than timeslice (something like 60ms).  Switch to another 
vt and start another eatm w/ the number of kb yielding more than timeslice 
(something like 140ms).  This eatm should starve completely after exceeding 
timeslice.

This problem also exists in mainline, but it is able to break out of it to 
some extent.  Setting eatm kb to a timing larger than timeslice does not 
exhibit this problem.

> > > range 63-73 seconds.
> >
> > Could this 10s skew be improved to around 1s to aid smoothness?
>
> I'm happy to try... but I doubt it. 10% difference over 10 tasks over 10
> mins of tasks of that wake/sleep nature is pretty good IMO. I'll see if
> there's anywhere else I can make the cpu accounting any better.

Great!

> As an aside, note that sched_clock and nanosecond timing with TSC isn't
> actually used if you use the pm timer which undoes any high res accounting
> the cpu scheduler can do (I noticed this when playing with pm timer that
> sched_clock just returns jiffies resolution instead of real nanosecond
> res). This could undo any smoothness that good cpu accounting can do.

Yes, pm-timer looks rather broken, at least on my machine.  Too bad it's on 
by default, as I always have to turn it off.

Thanks!

--
Al



--Boundary-00=_RQxPEi1P/f/JoBh
Content-Type: text/x-csrc;
  charset="windows-1256";
  name="eatm.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="eatm.c"

#include <stdio.h>
#include <sys/time.h>

unsigned long elapsed(int start) {

	static struct timeval s,e;

	if (start) return gettimeofday(&s, NULL);

	gettimeofday(&e, NULL);

	return ((e.tv_sec - s.tv_sec) * 1000 + (e.tv_usec - s.tv_usec) / 1000);

}

int main(int argc, char **argv) {

    unsigned long int i,j,max;
    unsigned char *p;

    if (argc>1)
	max=atol(argv[1]);
    else
	max=0x60000;


    elapsed(1); 

    for (i=0;((i<max/1024) && (p = (char *)malloc(1024*1024)));i++) {
        for (j=0;j<1024;p[1024*j++]=0);
	fprintf(stderr,"\r%d MB ",i+1);
    }

    for (j=max-(i*=1024);((i<max) && (p = (char *)malloc(1024)));i++) {
	*p = 0;
    }
    fprintf(stderr,"%d KB ",j-(max-i));

    fprintf(stderr,"eaten in %lu msec (%lu MB/s)\n",elapsed(0),i/(elapsed(0)?:1)*1000/1024);

    return 0;
}

--Boundary-00=_RQxPEi1P/f/JoBh--

