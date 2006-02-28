Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932723AbWB1X1T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932723AbWB1X1T (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 18:27:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932725AbWB1X1T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 18:27:19 -0500
Received: from omta05ps.mx.bigpond.com ([144.140.83.195]:12677 "EHLO
	omta05ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S932723AbWB1X1S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 18:27:18 -0500
Message-ID: <4404DC53.1040409@bigpond.net.au>
Date: Wed, 01 Mar 2006 10:27:15 +1100
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jesper Juhl <jesper.juhl@gmail.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Sam Ravnborg <sam@ravnborg.org>, Andrew Morton <akpm@osdl.org>,
       Paul Fulghum <paulkf@microgate.com>,
       "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>, Ingo Molnar <mingo@elte.hu>,
       Robert Love <rml@tech9.net>
Subject: Re: Odd sched behaviour; It takes 5 threads or more to load 2 CPU
 cores during kernel build
References: <9a8748490602281159u58df3397g1b6b268787146448@mail.gmail.com>
In-Reply-To: <9a8748490602281159u58df3397g1b6b268787146448@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta05ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Tue, 28 Feb 2006 23:27:16 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl wrote:
> Hi everyone,
> 
> This is a continuation of the issue I initially reported in the "make
> -j with j <= 4 seems to only load a single CPU core" thread
> (http://lkml.org/lkml/2006/2/21/231).
> 
> I've now got some more data, so hopefully someone can help me get a
> handle on this thing.
> 
> In a nutshell the problem is that I need to run "make -j N" where N is
> 
>>= 5 in order to put maximum load on both cores of my Athlon 64 X2
> 
> 4400+ when building kernels and with N < 5 the build apears to be
> pretty much done serially and not at all parallel.  This baffles me to
> be honest.
> The expected behaviour is that running with "make -j 2" on an
> otherwise idle machine would schedule a CC to run on each core most of
> the time, and with "make -j 3" & "make -j 4" there should definately
> be something executing on both cores all the time.
> What I see is that unless I bump it up to -j 5 or greater only one
> core seems to be put to work and the other one mostly just sits around
> spinning its wheels doing nothing.

Out of concern that this problem may be caused by the smpnice patches 
(which modify load balancing) I've done some testing on my HT 
workstation (with 2.6.16-rc4 installed).  The short summary of the 
results of my tests is that the smpnice patches do not appear to be at 
fault and that the problem lies in the kernel build mechanism for recent 
kernels.

More detail:

Test 1: build linux-2.6.14 with "make -j 2" and observe the results 
using top with the "latest CPU ran on" column enabled.  Result: both 
channels are being used and the build appears to be running in parallel.

Test 2: do the same test with a 2.6.16-rc5 kernel source.  Result: both 
channels are not being used and the build appears to be running serially.

Hence my conclusion that the problem is caused by recent (since 2.6.14) 
changes to the build mechanism and that it is not a scheduler or load 
balancing problem.

The good news from this is that a binary search trying to find when the 
problem doesn't need to reboot with the kernels each time but just 
evaluate the build process.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
