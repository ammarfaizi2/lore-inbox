Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750730AbWDRWQn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750730AbWDRWQn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 18:16:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750767AbWDRWQn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 18:16:43 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:45733 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1750730AbWDRWQm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 18:16:42 -0400
Date: Tue, 18 Apr 2006 17:16:23 -0500
From: Robin Holt <holt@sgi.com>
To: Keith Owens <kaos@americas.sgi.com>,
       Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
       prasanna@in.ibm.com, ananth@in.ibm.com, davem@davemloft.net
Cc: tony.luck@intel.com, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: ia64_do_page_fault shows 19.4% slowdown from notify_die.
Message-ID: <20060418221623.GB22514@lnx-holt.americas.sgi.com>
References: <20060417112552.GB4929@lnx-holt.americas.sgi.com> <9758.1145319832@ocs3.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9758.1145319832@ocs3.ocs.com.au>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 18, 2006 at 10:23:52AM +1000, Keith Owens wrote:
> I thought that is what I said in my original response, "kprobes should

I was a little dense and had forgotten that KDB would still need to
register as a debugger.


Some micro-benchmarking has shown this to be very painful.  The average
of 128 iterations with 4194304 faults per iteration using the attached
micro-benchmark showed the following:

499 nSec/fault ia64_do_page_fault notify_die commented out.
501 nSec/fault ia64_do_page_fault with nobody registered.
533 nSec/fault notify_die in and just kprobes.
596 nSec/fault notify_die in and kdb, kprobes, mca, and xpc loaded.

The 596 nSec/fault is a 19.4% slowdown.  This is an upcoming OSD beta
kernel.  It will be representative of what our typical customer will
have loaded.

Is this enough justification for breaking notify_die into
notify_page_fault for the fault path?


> that chain should be optimized away when CONFIG_KPROBES=n or there are
> no active probes".

Having the notify_page_fault() without anybody registered was only a
0.4% slowdown.  I am not sure that justifies the optimize away, but I
would certainly not object.

I think the second and third numbers also indicate strongly that kprobes
should only be registering the notify_page_fault when it actually is
monitoring for a memory access.  I know so little about how kprobes works,
I will stop right there.  Is there anybody who is willing to take that
task or explain why it is impossible?

Thanks,
Robin Holt

------------------ Page fault micro-benchmark  -------------------------

#include <sys/ioctl.h>
#include <sys/mman.h>
#include <sys/prctl.h>
#include <sys/stat.h>
#include <sys/time.h>
#include <sys/types.h>
#include <sys/wait.h>

#include <errno.h>
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>


#define	PAGE_SIZE		getpagesize()
#define STRIDE			PAGE_SIZE
#define	FAULTS_TO_CAUSE		(2048UL * 2048UL)
#define MAPPING_SIZE		FAULTS_TO_CAUSE * STRIDE

#define LOOPS_TO_TIME		128


int main(int argc, char **argv)
{
	long offset, i, j;
	char * mapping;
	volatile char z;
	struct timeval tv;
	unsigned long start_ts, end_ts;
	unsigned long total_uSec;
	struct timezone tz;
	pid_t child;
	int child_status;

	tz.tz_minuteswest = 0;

	total_uSec = 0;

	mapping = mmap(NULL, (size_t) MAPPING_SIZE, PROT_READ,
		       MAP_PRIVATE | MAP_ANONYMOUS, 0, 0);

	if ((unsigned long) mapping == -1UL) {
		perror("Mapping failed.");
		exit(0);
	}

	for (j=0; j < LOOPS_TO_TIME; j++) {
		child = fork();
		if (child > 0) {
			wait(&child_status);
		} else if (child == 0) {
			gettimeofday(&tv, &tz);
			start_ts = tv.tv_sec * 1000000 + tv.tv_usec;

			for (i = 0; i < FAULTS_TO_CAUSE; i++) {
				offset = i * STRIDE;
				z = mapping[offset];
			}

			gettimeofday(&tv, &tz);
			end_ts = tv.tv_sec * 1000000 + tv.tv_usec;
			total_uSec += (end_ts - start_ts);
			printf("Took %ld nSecs per fault\n",
			       (total_uSec*1000) / FAULTS_TO_CAUSE);
			exit(0);
		} else {
			printf ("Fork failed\n");
		}
	}
	munmap(mapping, (size_t) MAPPING_SIZE);
	return 0;
}
