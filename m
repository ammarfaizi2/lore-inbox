Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269366AbUICQj0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269366AbUICQj0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 12:39:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269369AbUICQj0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 12:39:26 -0400
Received: from adsl-ull-123-100.42-151.net24.it ([151.42.100.123]:58350 "EHLO
	www.gtkperl.org") by vger.kernel.org with ESMTP id S269366AbUICQjT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 12:39:19 -0400
Date: Fri, 3 Sep 2004 18:39:06 +0200
From: Paolo Molaro <lupus@debian.org>
To: Peter Chubb <peterc@gelato.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: incorrect time accouting
Message-ID: <20040903163906.GA2761@debian.org>
Mail-Followup-To: Peter Chubb <peterc@gelato.unsw.edu.au>,
	linux-kernel@vger.kernel.org
References: <75465520@toto.iv> <16695.50657.670300.755315@wombat.chubb.wattle.id.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="8NvZYKFJsRX2Djef"
Content-Disposition: inline
In-Reply-To: <16695.50657.670300.755315@wombat.chubb.wattle.id.au>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--8NvZYKFJsRX2Djef
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On 09/03/04 Peter Chubb wrote:
> Paolo> While benchmarking, a user pointed out that time(1) reported
> Paolo> incorrect user and system times when running mono.
> Paolo> A typical example (running on 2.6.8.1 is):
> 
> This is because mono is multithreaded.  At present, time(1) records
> only the time of the parent thread.  This will change soon (I hope)
> when the Roland McGrath's getrusage() patches are merged.

Thanks for the feedback. This doesn't explain, though, why on 2.4.x and
2.2.x sometimes sensible results are reported and sometimes not and it
doesn't explain the results I got with a simple pthread test case on 2.6.8.1.
[...doing more testing...]
See the attached test case: the results reported are:

$ gcc test-thread-rusage.c -lpthread
$ time ./a.out join
using a subthread
done

real	0m1.469s
user	0m1.461s
sys	0m0.003s
$ time ./a.out sleep
using a subthread

real	0m1.007s
user	0m0.000s
sys	0m0.001s

So it looks like times for subthreads are accounted for, but only when
the thread is joined (or if it is given time to properly exit). I guess
Roland's patch takes care of the case when a subthread is destroyed by
exiting from main() as well?
A little tracing shows that the intermittent 2.4/2.2 results and the
always low timings on 2.6 are probably due to the main program exiting
before the subthread cleaned up after itself (the results are
intermittent because it's a timing issue: we just wait for the subthread
to finish it's work and it's preempted away before it has a chance of
calling pthread_exit()).
Thanks.

lupus

-- 
-----------------------------------------------------------------
lupus@debian.org                                     debian/rules
lupus@ximian.com                             Monkeys do it better

--8NvZYKFJsRX2Djef
Content-Type: text/x-csrc; charset=us-ascii
Content-Disposition: attachment; filename="test-thread-rusage.c"

#include <sys/time.h>
#include <sys/resource.h>
#include <unistd.h>
#include <pthread.h>

void* do_the_work (void *data) {
	int *v = data;
	int i;
	for (i = 0; i < 300000000; ++i) {
		*v = *v + 1;
	}
	printf ("done\n");
	return NULL;
}

int 
main (int argc, char *argv[]) {
	int v = 0;
	pthread_t thread;
	if (argc > 1) {
		printf ("using a subthread\n");
		pthread_create (&thread, NULL, do_the_work, &v);
		/* the loop above takes more than 1 second on my box, 
		 * so this exits before the subthread has finished its work.
		 */
		if (strcmp (argv [1], "sleep") == 0)
			sleep (1);
		else if (strcmp (argv [1], "join") == 0)
			pthread_join (thread, NULL);
	} else {
		printf ("doing the work in main()\n");
		do_the_work (&v);
	}
	return 0;
}

--8NvZYKFJsRX2Djef--
