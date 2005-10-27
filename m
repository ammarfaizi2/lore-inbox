Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751612AbVJ0Wcv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751612AbVJ0Wcv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Oct 2005 18:32:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751613AbVJ0Wcu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Oct 2005 18:32:50 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:26099 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751611AbVJ0Wcu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Oct 2005 18:32:50 -0400
Subject: Re: 2.6.14-rc4-rt7
From: Steven Rostedt <rostedt@goodmis.org>
To: William Weston <weston@lysdexia.org>
Cc: john stultz <johnstul@us.ibm.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       george@mvista.com, Ingo Molnar <mingo@elte.hu>,
       Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Mark Knecht <markknecht@gmail.com>,
       david singleton <dsingleton@mvista.com>,
       Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
       cc@ccrma.Stanford.EDU
In-Reply-To: <Pine.LNX.4.58.0510271443500.26693@echo.lysdexia.org>
References: <1129852531.5227.4.camel@cmn3.stanford.edu>
	 <20051021080504.GA5088@elte.hu> <1129937138.5001.4.camel@cmn3.stanford.edu>
	 <20051022035851.GC12751@elte.hu>
	 <1130182121.4983.7.camel@cmn3.stanford.edu>
	 <1130182717.4637.2.camel@cmn3.stanford.edu>
	 <1130183199.27168.296.camel@cog.beaverton.ibm.com>
	 <20051025154440.GA12149@elte.hu>
	 <1130264218.27168.320.camel@cog.beaverton.ibm.com>
	 <435E91AA.7080900@mvista.com> <20051026082800.GB28660@elte.hu>
	 <435FA8BD.4050105@mvista.com> <435FBA34.5040000@mvista.com>
	 <435FEAE7.8090104@rncbc.org>
	 <Pine.LNX.4.58.0510261449310.20155@echo.lysdexia.org>
	 <1130371042.21118.76.camel@localhost.localdomain>
	 <1130373953.27168.370.camel@cog.beaverton.ibm.com>
	 <1130375244.21118.91.camel@localhost.localdomain>
	 <1130376147.27168.381.camel@cog.beaverton.ibm.com>
	 <1130377056.21118.102.camel@localhost.localdomain>
	 <1130377947.27168.392.camel@cog.beaverton.ibm.com>
	 <1130379107.21118.110.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0510271443500.26693@echo.lysdexia.org>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Thu, 27 Oct 2005 18:32:15 -0400
Message-Id: <1130452335.21118.121.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-10-27 at 15:01 -0700, William Weston wrote:

> Hi Steven.  I think you fixed it!
> 
> The xeon-smt box has been up for over 30 minutes with this patch, and no
> warnings as of yet.  Also, 'rtc_wakeup -f 1024' is reporting a max jitter
> of 131us (decent for this box considering its hardware induced latencies)
> instead of the >500us jitter seen earlier.
> 
> I'll try the patch out on the athlon box (which does mostly audio/midi)
> when I get home.

Yeah, I finally got a machine available that I could run Ingo's RT patch
on.  And with out this fix, I get the warning messages with the
following program, and with the fix I don't.  So I guess that solves it.

-- Steve

#include <stdio.h>
#include <time.h>

/* I'm sure there's a compare for this, but I was to lazy to look */
static inline int comparets(struct timespec *a, struct timespec *b)
{
	return (a->tv_sec < b->tv_sec) ? -1 :
		(a->tv_sec > b->tv_sec) ? 1 :
		(a->tv_nsec < b->tv_nsec) ? -1 :
		(a->tv_nsec > b->tv_nsec) ? 1 :
		0;
}

int main(int argc, char **argv)
{
	struct timespec ts, oldts;
	int i;

	clock_gettime(CLOCK_MONOTONIC, &oldts);
	for (i=0; i < 1000000; i++) {
		clock_gettime(CLOCK_MONOTONIC, &ts);
		if (comparets(&ts,&oldts) < 0) {
			printf("time went backwards from %ld.%09ld to %ld.%09ld\n",
				oldts.tv_sec, oldts.tv_nsec,
				ts.tv_sec, ts.tv_nsec);
		}
		oldts = ts;
	}
	return 0;
}


