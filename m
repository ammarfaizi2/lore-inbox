Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316637AbSFZPcm>; Wed, 26 Jun 2002 11:32:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316644AbSFZPcl>; Wed, 26 Jun 2002 11:32:41 -0400
Received: from [62.40.73.125] ([62.40.73.125]:45194 "HELO Router")
	by vger.kernel.org with SMTP id <S316637AbSFZPck>;
	Wed, 26 Jun 2002 11:32:40 -0400
Date: Tue, 25 Jun 2002 12:00:57 +0200
From: Jan Hudec <bulb@ucw.cz>
To: linux-kernel@vger.kernel.org
Subject: Re: gettimeofday problem
Message-ID: <20020625100057.GC7500@vagabond>
Reply-To: Jan Hudec <bulb@vagabond.cybernet.cz>
Mail-Followup-To: Jan Hudec <bulb@ucw.cz>, linux-kernel@vger.kernel.org
References: <3D17BB4B.F5E2571F@sympatico.ca> <200206251043.28051.bhards@bigpond.net.au> <3D17CF60.1DD1B82D@sympatico.ca> <ecmfhuopshut8luclo6asqorsj4b1sa13q@4ax.com> <3D183540.6CA7CB00@sympatico.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D183540.6CA7CB00@sympatico.ca>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 25, 2002 at 05:17:52AM -0400, Christian Robert wrote:
> John Alvord wrote:
> > Maybe this is the result of floating point rounding errors. Floating
> > point is notorious for occaisional strange results. I suggest redoing
> > the test program to keep all results in integer and seeing what
> > happens...
> You were close. 
> Programming error on my part.

What about comparing the struct timeval things directly? There is even a
timercmp macro for that (well I noticed that in the manpage when I
have olrady had the test written; the macro can only do sharp comparsions).

Something like this:
(I am now running it on three machines - Athlon 850, Pentium 1500 and dual
Pentium III 500 - all seem to be OK so far)

#include<stdio.h>
#include<errno.h>
#include<sys/time.h>
#include<signal.h>

volatile int loop = 1;

void sigint(int foo) {
	loop = 0;
}

int main(void) {
	unsigned long long cnt = 0, bcnt = 0, ecnt = 0;
	struct timeval old, new = {0, 0};

	signal(SIGINT, sigint);
	while(loop && cnt < (1LLU<<54)) {
		cnt++;
		old = new;
		if(gettimeofday(&new, NULL)) {
			ecnt++;
			printf("Error #%llu: count=%llu"
			       " error/count=0.%04llu errno=%i (%s)\n",
			       ecnt, cnt, (10000*ecnt)/cnt, errno,
			       sys_errlist[errno]);
			continue;
		}
		if((new.tv_sec < old.tv_sec) || ((new.tv_sec == old.tv_sec) && (new.tv_usec < old.tv_usec))) {
			bcnt++;
			printf("Skew #%llu: count=%llu errors=%llu"
			       " skew/good count=0.%04llu, new=(%li,"
			       " %li) old=(%li, %li)\n", bcnt, cnt,
			       ecnt, (10000*bcnt)/(cnt-ecnt),
			       new.tv_sec, new.tv_usec, old.tv_sec,
			       old.tv_usec);
		}
	}

	printf("Counted %llu, errors %llu (0.%04llu), skews %llu"
	       " (0.%04llu)\n", cnt, ecnt, (10000*ecnt)/cnt, bcnt,
	       (10000*bcnt)/(cnt-ecnt));
	return 0;
}



-------------------------------------------------------------------------------
						 Jan 'Bulb' Hudec <bulb@ucw.cz>
