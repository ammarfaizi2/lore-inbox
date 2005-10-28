Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030398AbVJ1ROy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030398AbVJ1ROy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 13:14:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030336AbVJ1ROw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 13:14:52 -0400
Received: from smtp3.Stanford.EDU ([171.67.16.138]:8686 "EHLO
	smtp3.Stanford.EDU") by vger.kernel.org with ESMTP id S1030593AbVJ1ROh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 13:14:37 -0400
Subject: Re: 2.6.14-rc4-rt7
From: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: nando@ccrma.Stanford.EDU, Rui Nuno Capela <rncbc@rncbc.org>,
       William Weston <weston@lysdexia.org>, george@mvista.com,
       Ingo Molnar <mingo@elte.hu>, john stultz <johnstul@us.ibm.com>,
       Mark Knecht <markknecht@gmail.com>,
       david singleton <dsingleton@mvista.com>,
       Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
       cc@ccrma.Stanford.EDU
In-Reply-To: <1130435043.21118.115.camel@localhost.localdomain>
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
	 <43608972.6070501@rncbc.org>
	 <1130435043.21118.115.camel@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 28 Oct 2005 10:13:29 -0700
Message-Id: <1130519609.18758.21.camel@cmn3.stanford.edu>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-10-27 at 13:44 -0400, Steven Rostedt wrote:
> On Thu, 2005-10-27 at 09:01 +0100, Rui Nuno Capela wrote:
> 
> > 
> > Don't really know if its consistent, but it does occur on several times, 
> > on only on boot.
> 
> Rui,
> 
> Have you tried the last patch that I sent John?  It may just be a race
> condition in the checking that causes a false positive.  My last patch
> fixes that.

I booted into rc5-rt7 SMP with your patch yesterday and the machine is
still up, which is something :-) No time warp debug messages so far. 

When I logged in today Nautilus died on login. Never happened before.
Logged out, logged in again and it was fine.  Now it looks like things
are "stable" but this happened while Evolution was reading email after
logging in. Running this:

#!/bin/bash

while true ; do
    echo "--- `date`">>time
    START=`date +"%s"`
    strace -o timelog sleep 10
    RES=$?
    if [ "$?" -ne "0" ] ; then
        echo "Error $RES" >>time
        exit
    fi
    if grep -q 516 timelog &>/dev/null ; then
        echo "Found 516 in timelog!" >>time
        exit
    fi
    END=`date +"%s"`
    let DIFF=END-START
    echo "$DIFF" >>time
    echo "---" >>time
done

Got this:

--- Fri Oct 28 09:40:47 PDT 2005
10
---
--- Fri Oct 28 09:40:57 PDT 2005
10
---
--- Fri Oct 28 09:41:07 PDT 2005
10
---
--- Fri Oct 28 09:41:17 PDT 2005
10
---
--- Fri Oct 28 09:41:27 PDT 2005
33
---
--- Fri Oct 28 09:42:00 PDT 2005
10
---
--- Fri Oct 28 09:42:10 PDT 2005
16
---
--- Fri Oct 28 09:42:26 PDT 2005
12
---
--- Fri Oct 28 09:42:38 PDT 2005
10
---
--- Fri Oct 28 09:42:49 PDT 2005
10
---
--- Fri Oct 28 09:42:59 PDT 2005
11
---
--- Fri Oct 28 09:43:10 PDT 2005
11
---
--- Fri Oct 28 09:43:21 PDT 2005
10
---
--- Fri Oct 28 09:43:31 PDT 2005
10
---
--- Fri Oct 28 09:43:41 PDT 2005
10
---
--- Fri Oct 28 09:43:51 PDT 2005
10
---
--- Fri Oct 28 09:44:01 PDT 2005
11
---
--- Fri Oct 28 09:44:12 PDT 2005
10
---
--- Fri Oct 28 09:44:22 PDT 2005
11
---
--- Fri Oct 28 09:44:33 PDT 2005
10
---
--- Fri Oct 28 09:44:43 PDT 2005
10
---
--- Fri Oct 28 09:44:53 PDT 2005
10
---
--- Fri Oct 28 09:45:03 PDT 2005
12
---
--- Fri Oct 28 09:45:15 PDT 2005
10
---
--- Fri Oct 28 09:45:25 PDT 2005
10
---
--- Fri Oct 28 09:45:35 PDT 2005
10
---
--- Fri Oct 28 09:45:45 PDT 2005
10
---

So, it appears I'm not getting short timeouts as I did before but some
of them are too long. 

After the initial startup it looks like now this is not happening again,
at most I'm getting "11" instead of "10". 

The Jack warnings about late interrupts have returned...
-- Fernando


