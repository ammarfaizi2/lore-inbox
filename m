Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261195AbULJVyx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261195AbULJVyx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Dec 2004 16:54:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261830AbULJVyx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Dec 2004 16:54:53 -0500
Received: from dfw-gate1.raytheon.com ([199.46.199.230]:28138 "EHLO
	dfw-gate1.raytheon.com") by vger.kernel.org with ESMTP
	id S261195AbULJVys (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Dec 2004 16:54:48 -0500
To: Ingo Molnar <mingo@elte.hu>
Cc: Mark_H_Johnson@raytheon.com, Amit Shah <amit.shah@codito.com>,
       Karsten Wiese <annabellesgarden@yahoo.de>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, emann@mrv.com,
       Gunther Persoons <gunther_persoons@spymac.com>,
       "K.R. Foley" <kr@cybsft.com>, linux-kernel@vger.kernel.org,
       Florian Schmidt <mista.tapas@gmx.net>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Shane Shrybman <shrybman@aei.ca>, Esben Nielsen <simlo@phys.au.dk>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
From: Mark_H_Johnson@raytheon.com
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm3-V0.7.32-15
Date: Fri, 10 Dec 2004 15:54:07 -0600
Message-ID: <OF581F8361.CB1F4C7B-ON86256F66.00784FA2-86256F66.00784FB8@raytheon.com>
X-MIMETrack: Serialize by Router on RTSHOU-DS01/RTS/Raytheon/US(Release 6.5.2|June 01, 2004) at
 12/10/2004 03:54:10 PM
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
X-SPAM: 0.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The code does not quite match either pattern but is perhaps
more like your second example.

For reference, the cpu_delay loop looks like this...

  t1 = mygettime();
  for(u=0;u<(loops/1000);u++) {
    t0 = t1;
    if (do_a_trace) {
      gettimeofday(0, (struct timezone*)1);
    }
    for (v=0;v<1000;v++)
      k+=1;
    t1 = mygettime();
    if ((t1-t0)>max_delay){
      delay++;
      if (do_a_trace) {
        gettimeofday(0,0);
        do_a_trace = 0;
        printf("Trace triggered with %f second delay.\n",t1-t0);
      }
    }
  }

I was trying to avoid the extra "rdtsc" overhead (plus the
floating point calculations) so - yes, I could have cases
where the time I measure is not caught by the kernel tracer.

[do some tests...]
Now I'm 5 for 5 with the revised code. Odd that all the numbers
are within about 2 or 3 usec (application measured / kernel measured).
If it was as bad as I was measuring it, I would have expected
one or two to be really off.

  --Mark

