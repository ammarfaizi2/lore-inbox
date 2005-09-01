Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965098AbVIANII@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965098AbVIANII (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 09:08:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965100AbVIANII
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 09:08:08 -0400
Received: from ylpvm15-ext.prodigy.net ([207.115.57.46]:30113 "EHLO
	ylpvm15.prodigy.net") by vger.kernel.org with ESMTP id S965098AbVIANIG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 09:08:06 -0400
X-ORBL: [67.117.73.34]
Date: Thu, 1 Sep 2005 16:07:22 +0300
From: Tony Lindgren <tony@atomide.com>
To: Con Kolivas <kernel@kolivas.org>
Cc: vatsa@in.ibm.com, linux-kernel@vger.kernel.org, arjan@infradead.org,
       s0348365@sms.ed.ac.uk, tytso@mit.edu, cfriesen@nortel.com,
       rlrevell@joe-job.com, trenn@suse.de, george@mvista.com,
       johnstul@us.ibm.com, akpm@osdl.org
Subject: Re: Updated dynamic tick patches
Message-ID: <20050901130721.GB10677@atomide.com>
References: <20050831165843.GA4974@in.ibm.com> <200509011523.13994.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="LZvS9be/3tNcYl/X"
Content-Disposition: inline
In-Reply-To: <200509011523.13994.kernel@kolivas.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Con Kolivas <kernel@kolivas.org> [050901 08:22]:
> On Thu, 1 Sep 2005 02:58 am, Srivatsa Vaddagiri wrote:
> > Following patches related to dynamic tick are posted in separate mails,
> > for convenience of review. The first patch probably applies w/o dynamic
> > tick consideration also.
> >
> > Patch 1/3  -> Fixup lost tick calculation in timer_pm.c
> > Patch 2/3  -> Dyn-tick cleanups
> > Patch 3/3  -> Use lost tick information in dyn-tick time recovery
> >
> > These patches are against 2.6.13-rc6-mm2.
> >
> > Con, would be great if you can upload a consolidated new version of
> > dyn-tick patch on your website!
> 
> Great, thanks. I'll wait till 2.6.13-mm1 is out since that's due shortly and 
> I'll resync everything with that and perhaps tweak along the way.

I tried this quickly on a loaner ThinkPad T30, and needed the following
patch to compile. The patch does work with PIT, but with lapic the
system does not wake to timer interrupts :(

I also hacked together a little timer test utility that should go trough
on a completely idle system with no errors. Also posted it to:

http://www.muru.com/linux/dyntick/tools/dyntick-test.c

Srivatsa, could you try the dyntick-test.c on your system after booting
to init=/bin/sh to make the system as idle as possible?

Unfortunately I cannot debug the APIC issue right now, but I seem to
have an issue on ARM OMAP where the timer test occasionally fails on
some longer values, for example 3 second sleep can take 4 seconds.

I don't know yet if this is the problem George Anzinger mentioned with
next_timer_interrupt(), or if this is OMAP specific. But it only seems
to occur with very low idle HZ values. This may be related to the slow
boot time issue I mentioned yesterday.

Regards,

Tony

--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename=patch-fix-up-compile

--- a/arch/i386/kernel/io_apic.c
+++ b/arch/i386/kernel/io_apic.c
@@ -2034,7 +2034,9 @@
 	.disable 	= mask_IO_APIC_irq,
 	.ack 		= ack_edge_ioapic,
 	.end 		= end_edge_ioapic,
+#ifdef CONFIG_SMP
 	.set_affinity 	= set_ioapic_affinity,
+#endif
 };
 #endif
 

--LZvS9be/3tNcYl/X
Content-Type: text/x-csrc; charset=us-ascii
Content-Disposition: inline; filename="dyntick-test.c"

/*
 * Tests timers to make sure dynamic tick works properly
 */

#include <stdio.h>
#include <unistd.h>
#include <sys/time.h>

#define MAX_SLEEP	(10)		/* seconds */
#define MAX_LATENCY	(100 * 1000)	/* usecs */

int test_sleep(unsigned int msec_len)
{
	sleep(msec_len / 1000);
	return 0;
}

int test_select(unsigned int msec_len)
{
	struct timeval tv_sel;

	tv_sel.tv_sec = msec_len / 1000;
	tv_sel.tv_usec = (msec_len % 1000) * 1000;

	return select(0, NULL, NULL, NULL, &tv_sel);
}

int test_usleep(unsigned int msec_len)
{
	usleep(msec_len * 1000);
}

/* This modified from some GNU exsample _not_ to hose y */
int timeval_subtract(struct timeval *result,
		     const struct timeval *x,
		     const struct timeval *y)
{
	struct timeval tmp;

	tmp.tv_sec = y->tv_sec;
	tmp.tv_usec = y->tv_usec;

	/* Perform the carry for the later subtraction */
	if (x->tv_usec < y->tv_usec) {
		int nsec = (y->tv_usec - x->tv_usec) / 1000000 + 1;
		tmp.tv_usec -= 1000000 * nsec;
		tmp.tv_sec += nsec;
	}
	if (x->tv_usec - y->tv_usec > 1000000) {
		int nsec = (x->tv_usec - y->tv_usec) / 1000000;
		tmp.tv_usec += 1000000 * nsec;
		tmp.tv_sec -= nsec;
	}
     
	/* Compute the time remaining to wait.
	   tv_usec is certainly positive. */
	result->tv_sec = x->tv_sec - tmp.tv_sec;
	result->tv_usec = x->tv_usec - tmp.tv_usec;
     
	/* Return 1 if result is negative. */
	return x->tv_sec < tmp.tv_sec;
}

int do_test(char * name, int (* test)(unsigned int len),
	    unsigned int len, int count)
{
	int i, ret;
	struct timeval tv_in;
	struct timeval tv_beg;
	struct timeval tv_end;
	struct timeval tv_len;
	struct timeval tv_lat;
	struct timezone tz;
	char * status = "OK";
	char * latency_type = "";

	tv_in.tv_sec = len / 1000;
	tv_in.tv_usec = (len % 1000) * 1000;

	gettimeofday(&tv_beg, &tz);
	for (i = 0; i < count; i++) {
		ret = test(len);
	}
	gettimeofday(&tv_end, &tz);

	ret = timeval_subtract(&tv_len, &tv_end, &tv_beg);
	if (ret)
		status = "ERROR";

	ret = timeval_subtract(&tv_lat, &tv_len, &tv_in);
	if (ret) {
		latency_type = "-";
		timeval_subtract(&tv_lat, &tv_in, &tv_len);
	}

	if (tv_lat.tv_sec > 0 || tv_lat.tv_usec > MAX_LATENCY)
		status = "ERROR";

	printf("  Test: %6s %4ums time: %2u.%06us "
	       "latency: %1s%u.%06us status: %s\n",
	       name, 
	       (len * count),
	       (unsigned int)tv_len.tv_sec,
	       (unsigned int)tv_len.tv_usec,
	       latency_type,
	       (unsigned int)tv_lat.tv_sec,
	       (unsigned int)tv_lat.tv_usec,
	       status);

	return ret;
}

int main(void)
{
	unsigned int i;
	int max_secs = MAX_SLEEP;

	printf("Testing sub-second select and usleep\n");
	for (i = 0; i < 1000; i += 100) {
		do_test("select", test_select, i, 1);
		do_test("usleep", test_usleep, i, 1);
	}

	printf("Testing multi-second select and sleep\n");
	for (i = 0; i < max_secs; i++) {
		do_test("select", test_select, i * 1000, 1);
		do_test("sleep", test_sleep, i * 1000, 1);
	}

	return 0;
}

--LZvS9be/3tNcYl/X--
