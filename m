Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261239AbUKWNpm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261239AbUKWNpm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 08:45:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261238AbUKWNo2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 08:44:28 -0500
Received: from mx2.elte.hu ([157.181.151.9]:50617 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261239AbUKWNnz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 08:43:55 -0500
Date: Tue, 23 Nov 2004 15:46:22 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Rui Nuno Capela <rncbc@rncbc.org>
Cc: Florian Schmidt <mista.tapas@gmx.net>, linux-kernel@vger.kernel.org,
       Lee Revell <rlrevell@joe-job.com>, mark_h_johnson@raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       Gunther Persoons <gunther_persoons@spymac.com>, emann@mrv.com,
       Shane Shrybman <shrybman@aei.ca>, Amit Shah <amit.shah@codito.com>,
       Esben Nielsen <simlo@phys.au.dk>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm2-V0.7.30-2
Message-ID: <20041123144622.GA20085@elte.hu>
References: <20041118164612.GA17040@elte.hu> <20041122005411.GA19363@elte.hu> <20041122020741.5d69f8bf@mango.fruits.de> <20041122094602.GA6817@elte.hu> <56781.195.245.190.93.1101119801.squirrel@195.245.190.93> <20041122132459.GB19577@elte.hu> <20041122142744.0a29aceb@mango.fruits.de> <65529.195.245.190.94.1101133129.squirrel@195.245.190.94> <20041122154516.GC2036@elte.hu> <9182.195.245.190.93.1101142412.squirrel@195.245.190.93>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9182.195.245.190.93.1101142412.squirrel@195.245.190.93>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Rui Nuno Capela <rncbc@rncbc.org> wrote:

> OK. I tried 14 instances of jack_test. I even modded Florian's
> original source code, to let each client instance have 4 ins and 4
> outs, and to make things a litle bit heavier, all 4 inputs are mixed
> into each of the 4 outputs.

i tried your new test-client, and i've got a generic question: should a
jack client be able to generate an xrun via, other than via overloading
jackd? E.g. i'm wondering about the following behavior: if start up
jackd in the usual way:

  jackd -R -P20 -dalsa -dhw:0 -r44100 -p64 -n2 -S -P

and then i start a single test-client (jack_test.cpp):

 # ./jack_test
 seconds to run: 60
 client_new: jack_test-4215
 port_register
 set_process_callback
 activate
 running

and then if i now Ctrl-Z the Jack client, i get an immediate xrun
message from jackd:

  **** alsa_pcm: xrun of at least 2.119 msecs

and when i 'fg' the client again then jackd sees a big delay:

  **** alsa_pcm: xrun of at least 742.064 msecs

corresponding the amount of time i waited between the Ctrl-Z and the 
'fg'.

since the client runs as SCHED_OTHER, doesnt this mean that simple
delays between SCHED_OTHER tasks could cause xruns in jackd too? A
SCHED_OTHER task can be delayed indefinitely at any stage. So shouldnt
the test-clients have RT priority as well, to guarantee xrun-less jackd?

	Ingo
