Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261835AbULJWHh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261835AbULJWHh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Dec 2004 17:07:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261839AbULJWHg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Dec 2004 17:07:36 -0500
Received: from dfw-gate2.raytheon.com ([199.46.199.231]:40679 "EHLO
	dfw-gate2.raytheon.com") by vger.kernel.org with ESMTP
	id S261838AbULJWGe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Dec 2004 17:06:34 -0500
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
Date: Fri, 10 Dec 2004 16:06:15 -0600
Message-ID: <OFC6899882.DBD65C9D-ON86256F66.00796C43-86256F66.00796C5C@raytheon.com>
X-MIMETrack: Serialize by Router on RTSHOU-DS01/RTS/Raytheon/US(Release 6.5.2|June 01, 2004) at
 12/10/2004 04:06:19 PM
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
X-SPAM: 0.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is my get_ltrace.sh script (at the end).

So I read the preempt_max_latency (to see if its changed) before
I copy the latency_trace output. I am not so sure that cat is
really doing an "atomic" read when some of the latency traces
are over 300 Kbytes in length.

Also note that some of the files were empty :-(. I don't think
I've seen that symptom before.

Note that the preempt_max_latency value DID match the last line of
the trace output in the example I described. It is just the header
that had some stale data in it.

  --Mark

--- get_ltrace.sh ---

#!/bin/sh

let MAX=`cat /proc/sys/kernel/preempt_max_latency`
let I=0 J=1
let MP=${1:-1000}
echo "Current Maximum is $MAX, limit will be $MP."
while (( I < 100 )) ; do
    sleep 1s
    let NOW=`cat /proc/sys/kernel/preempt_max_latency`
    if (( MAX != NOW )) ; then
        echo "New trace $I w/ $NOW usec latency."
        cat /proc/latency_trace > lt.`printf "%02d" $I`
#       sync ; sync
        let I++
        let MAX=NOW
    elif (( J++ >= 10 )) ; then
        if (( MAX != MP )) ; then
            echo "Resetting max latency from $MAX to $MP."
            echo $MP > /proc/sys/kernel/preempt_max_latency
            let MAX=$MP
        else
            echo "No new latency samples at `date`."
        fi
        let J=1
# else do nothing...
    fi
done

