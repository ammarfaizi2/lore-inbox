Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316898AbSGSROk>; Fri, 19 Jul 2002 13:14:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316900AbSGSROk>; Fri, 19 Jul 2002 13:14:40 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:62095 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S316898AbSGSROh>; Fri, 19 Jul 2002 13:14:37 -0400
Date: Fri, 19 Jul 2002 12:17:05 +0000
From: Amos Waterland <apw@us.ibm.com>
To: Jan Hudec <bulb@ucw.cz>, linux-kernel@vger.kernel.org
Cc: Tom Gall <tom_gall@vnet.ibm.com>
Subject: Re: gettimeofday problem
Message-ID: <20020719121705.A11655@kvasir.austin.ibm.com>
References: <3D17BB4B.F5E2571F@sympatico.ca> <200206251043.28051.bhards@bigpond.net.au> <3D17CF60.1DD1B82D@sympatico.ca> <ecmfhuopshut8luclo6asqorsj4b1sa13q@4ax.com> <3D183540.6CA7CB00@sympatico.ca> <20020625100057.GC7500@vagabond>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020625100057.GC7500@vagabond>; from bulb@ucw.cz on Tue, Jun 25, 2002 at 12:00:57PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There may be several distinct errors that people are observing.  I wrote
a program that makes 32 gettimeofday() calls in a tight loop so as to
try to catch rare anomalies, and after running for about 24 hours, it
just triggered a strange problem.

On 2.4.18-3 on a Pentium III, the following output shows a large jump in
the tv_usec value, followed by an immediate return to the monotonically
increasing sequence, but with a large sequence discontinuity.

So in this case the time is not so much "going backwards", but rather
making a huge jump forwards and then returning to the original sequence.
Hope this helps.

% ./test0035
Run: 1844080460; Timer went backwards!; dump:
1027095141 707896
1027095141 707896
1027095141 707897
1027095141 707897
1027095141 707898
1027095141 707898
1027095141 707899
1027095141 707899
1027095141 707900
1027095141 707900
1027095141 707901
1027095141 707901
1027095141 707902
1027095141 707902
1027095141 707903
1027095141 707903
1027095141 852234   <-- this is the anomaly
1027095141 712510   <-- sequence returns with 4607us discontinuity
1027095141 712510
1027095141 712511
1027095141 712511
1027095141 712512
1027095141 712512
1027095141 712513
1027095141 712513
1027095141 712514
1027095141 712514
1027095141 712515
1027095141 712515
1027095141 712516
1027095141 712516
1027095141 712517
% cat test0035.c
/* Test for timer weirdness.
 * Amos Waterland <apw@us.ibm.com>
 * 15 July 2002
 */

#include <errno.h>
#include <error.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/time.h>

int
main (int argc, char *argv[])
{
  int result = 0;

  {
    const int ELEMS = 32;
    struct timeval tm[ELEMS];
    long j, i;

    while (1)
      {
        ++j;

	for (i = 0; i < ELEMS; i++)
	  {
	    gettimeofday (&(tm[i]), NULL);
	  }

	for (i = 1; i < ELEMS; i++)
	  {
	    if ((long) tm[i].tv_sec > (long) tm[i - 1].tv_sec)
                continue;

	    if ((long) tm[i].tv_sec < (long) tm[i - 1].tv_sec ||
                 (long) tm[i].tv_usec < (long) tm[i - 1].tv_usec)
	      {
		printf ("\nRun: %li; Timer went backwards!; dump:\n", j);

		for (i = 0; i < ELEMS; i++)
		  {
		    printf ("%li %li\n",
                            (long) tm[i].tv_sec, (long) tm[i].tv_usec);
		  }
	      }
	  }
      }
  }

  exit (result);
}
 


On Tue, Jun 25, 2002 at 12:00:57PM +0200, Jan Hudec wrote:
> On Tue, Jun 25, 2002 at 05:17:52AM -0400, Christian Robert wrote:
> > John Alvord wrote:
> > > Maybe this is the result of floating point rounding errors. Floating
> > > point is notorious for occaisional strange results. I suggest redoing
> > > the test program to keep all results in integer and seeing what
> > > happens...
> > You were close. 
> > Programming error on my part.
> 
> What about comparing the struct timeval things directly? There is even a
> timercmp macro for that (well I noticed that in the manpage when I
> have olrady had the test written; the macro can only do sharp comparsions).
> 
> Something like this:
> (I am now running it on three machines - Athlon 850, Pentium 1500 and dual
> Pentium III 500 - all seem to be OK so far)
> 
> #include<stdio.h>
> #include<errno.h>
> #include<sys/time.h>
> #include<signal.h>
> 
> volatile int loop = 1;
> 
> void sigint(int foo) {
> 	loop = 0;
> }
> 
> int main(void) {
> 	unsigned long long cnt = 0, bcnt = 0, ecnt = 0;
> 	struct timeval old, new = {0, 0};
> 
> 	signal(SIGINT, sigint);
> 	while(loop && cnt < (1LLU<<54)) {
> 		cnt++;
> 		old = new;
> 		if(gettimeofday(&new, NULL)) {
> 			ecnt++;
> 			printf("Error #%llu: count=%llu"
> 			       " error/count=0.%04llu errno=%i (%s)\n",
> 			       ecnt, cnt, (10000*ecnt)/cnt, errno,
> 			       sys_errlist[errno]);
> 			continue;
> 		}
> 		if((new.tv_sec < old.tv_sec) || ((new.tv_sec ==
> 		old.tv_sec) && (new.tv_usec < old.tv_usec))) { bcnt++;
> 			printf("Skew #%llu: count=%llu errors=%llu"
> 			       " skew/good count=0.%04llu, new=(%li,"
> 			       " %li) old=(%li, %li)\n", bcnt, cnt,
> 			       ecnt, (10000*bcnt)/(cnt-ecnt),
> 			       new.tv_sec, new.tv_usec, old.tv_sec,
> 			       old.tv_usec);
> 		}
> 	}
> 
> 	printf("Counted %llu, errors %llu (0.%04llu), skews %llu"
> 	       " (0.%04llu)\n", cnt, ecnt, (10000*ecnt)/cnt, bcnt,
> 	       (10000*bcnt)/(cnt-ecnt));
> 	return 0;
> }
