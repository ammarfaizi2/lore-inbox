Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964974AbWDGVlY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964974AbWDGVlY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 17:41:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932451AbWDGVlX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 17:41:23 -0400
Received: from [212.70.37.6] ([212.70.37.6]:63762 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S964977AbWDGVlW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 17:41:22 -0400
From: Al Boldi <a1426z@gawab.com>
To: Peter Williams <pwil3058@bigpond.net.au>
Subject: Re: [ANNOUNCE][RFC] PlugSched-6.3.1 for  2.6.16-rc5
Date: Sat, 8 Apr 2006 00:32:28 +0300
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <200604031459.51542.a1426z@gawab.com> <200604051116.05270.a1426z@gawab.com> <44344A59.9070007@bigpond.net.au>
In-Reply-To: <44344A59.9070007@bigpond.net.au>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_sptNEKoJM+TFhBF"
Message-Id: <200604080032.28911.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_sptNEKoJM+TFhBF
Content-Type: text/plain;
  charset="windows-1256"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Peter Williams wrote:
> Al Boldi wrote:
> > Peter Williams wrote:
> >> Al Boldi wrote:
> >>> Peter Williams wrote:
> >>>> Al Boldi wrote:
> >>>>>>>> Control parameters for the scheduler can be read/set via files
> >>>>>>>> in:
> >>>>>>>>
> >>>>>>>> /sys/cpusched/<scheduler>/
> >>>>>
> >>>>> The default values for spa make it really easy to lock up the
> >>>>> system.
> >>>>
> >>>> Which one of the SPA schedulers and under what conditions?  I've been
> >>>> mucking around with these and may have broken something.  If so I'd
> >>>> like to fix it.
> >>>
> >>> spa_no_frills, with a malloc-hog less than timeslice.  Setting
> >>> promotion_floor to max unlocks the console.
> >>
> >> OK, you could also try increasing the promotion interval.
> >
> > Seems that this will only delay the lock in spa_svr but not inhibit it.
>
> OK. But turning the promotion mechanism off completely (which is what
> setting the floor to the maximum) runs the risk of a runaway high
> priority task locking the whole system up.  IMHO the only SPA scheduler
> where it's safe for the promotion floor to be greater than MAX_RT_PRIO
> is spa_ebs.  So a better solution is highly desirable.

Yes.

> I'd like to fix this problem but don't fully understand what it is.
> What do you mean by a malloc-hog?  Would it possible for you to give me
> an example of how to reproduce the problem?

Can you try the attached mem-eater passing it the number of kb to be eaten.

	i.e. '# while :; do ./eatm 9999 ; done' 

This will print the number of bytes eaten and the timing in ms.

Adjust the number of kb to be eaten such that the timing will be less than 
timeslice (120ms by default for spa).  Switch to another vt and start 
pressing enter.  A console lockup should follow within seconds for all spas 
except ebs.

Thanks!

--
Al



--Boundary-00=_sptNEKoJM+TFhBF
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

--Boundary-00=_sptNEKoJM+TFhBF--

