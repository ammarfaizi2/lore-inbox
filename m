Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261348AbUKXAJn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261348AbUKXAJn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 19:09:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261405AbUKWRkK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 12:40:10 -0500
Received: from smtp4.netcabo.pt ([212.113.174.31]:24964 "EHLO
	exch01smtp10.hdi.tvcabo") by vger.kernel.org with ESMTP
	id S261372AbUKWQzC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 11:55:02 -0500
Message-ID: <41435.195.245.190.93.1101228794.squirrel@195.245.190.93>
Date: Tue, 23 Nov 2004 16:53:14 -0000 (WET)
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm2-V0.7.30-2
From: "Rui Nuno Capela" <rncbc@rncbc.org>
To: "Ingo Molnar" <mingo@elte.hu>
Cc: "Florian Schmidt" <mista.tapas@gmx.net>, linux-kernel@vger.kernel.org,
       "Lee Revell" <rlrevell@joe-job.com>, mark_h_johnson@raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, "Bill Huey" <bhuey@lnxw.com>,
       "Adam Heath" <doogie@debian.org>,
       "Thomas Gleixner" <tglx@linutronix.de>,
       "Michal Schmidt" <xschmi00@stud.feec.vutbr.cz>,
       "Fernando Pablo Lopez-Lezcano" <nando@ccrma.stanford.edu>,
       "Karsten Wiese" <annabellesgarden@yahoo.de>,
       "Gunther Persoons" <gunther_persoons@spymac.com>, emann@mrv.com,
       "Shane Shrybman" <shrybman@aei.ca>, "Amit Shah" <amit.shah@codito.com>,
       "Esben Nielsen" <simlo@phys.au.dk>
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type: multipart/mixed;boundary="----=_20041123165314_70425"
X-Priority: 3 (Normal)
Importance: Normal
References: <20041122020741.5d69f8bf@mango.fruits.de>   
    <20041122094602.GA6817@elte.hu>   
    <56781.195.245.190.93.1101119801.squirrel@195.245.190.93>   
    <20041122132459.GB19577@elte.hu>   
    <20041122142744.0a29aceb@mango.fruits.de>   
    <65529.195.245.190.94.1101133129.squirrel@195.245.190.94>   
    <20041122154516.GC2036@elte.hu>   
    <9182.195.245.190.93.1101142412.squirrel@195.245.190.93>   
    <20041123135508.GA13786@elte.hu>   
    <29024.195.245.190.94.1101218441.squirrel@195.245.190.94>   
    <20041123154108.GA27413@elte.hu>
In-Reply-To: <20041123154108.GA27413@elte.hu>
X-OriginalArrivalTime: 23 Nov 2004 16:54:55.0621 (UTC) FILETIME=[28A49B50:01C4D17D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_20041123165314_70425
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

Ingo Molnar wrote:
>
> * Rui Nuno Capela wrote:
>
>> Yes, there's a non-official patch to jackd from Lee Revell's. Without
>> that you don't get to read the maximum delay from jackd. Sorry. But if
>> you have the patience to rebuild jack, here comes attached the minimal
>> patch for just that.
>
> thx, it applied cleanly to jack-cvs. Here's the 5-minute idle-system test
> again:
>
>  ************* SUMMARY RESULT ****************
>  Timeout Count . . . . . . . . :(    0)
>  XRUN Count  . . . . . . . . . :     0
>  Delay Count (>spare time) . . :     0
>  Delay Count (>1000 usecs) . . :     0
>  Delay Maximum . . . . . . . . :    28   usecs
>  Cycle Maximum . . . . . . . . :   414   usecs
>  Average DSP Load. . . . . . . :    20.6 %
>  Average CPU System Load . . . :    11.6 %
>  Average CPU User Load . . . . :     8.6 %
>  Average CPU Nice Load . . . . :     0.0 %
>  Average CPU I/O Wait Load . . :     0.0 %
>  Average CPU IRQ Load  . . . . :     0.0 %
>  Average CPU Soft-IRQ Load . . :     0.0 %
>  Average Interrupt Rate  . . . :  1671.7 /sec
>  Average Context-Switch Rate . : 17003.1 /sec
>  *********************************************
>
> but i can reproduce xruns on another, much slower box, using just 3-4
> jack_test clients. The xruns dont seem to be justified, they happen at
> 30-40% CPU utilization already.
>

Now that you're liking, here goes a more contained jackd test-suite (see
attached tarball, jackd_test3.1.tar.gz).

Just launch the provided shell script, from the command line as:

  ./jack_test3_run.sh [secs] [clients] [ports]

where:

  secs    - number of seconds to run jackd workload (default = 300)
  clients - number of test-clients to run (default = 14)
  ports   - number of interface ports per client (default = 4)

As before, each client (jack_test3_client) registers the same number of
input and output ports (default is 4ins x 4outs), where each output is the
audio mix of all inputs.

Note that you can breakup the 14 client barrier, as that limit seems to be
related to the maximum number of client ports jackd can handle by default
(128). The jack_test_run.sh script sets this jackd maximum port limit
number as it sees fit, so any number of clients greater than 14 is
allowed, provided there's enough CPU and/or RAM ;)

Now, with the default workload (14 clients * 4 * 4 ports) I'm reaching 60%
of CPU, and a "fair" number of XRUNs on my P4@2.5G laptop, against the
on-board alsa driver (snd-ali5451), while under RT-V0.7.30-2.

Each test run produces a kernel-timestamped log filename with the complete
captured stdout/err. Consolidated results can be produced by feeding
several of those logfiles into the jack_test3_consolidated.awk script,
just like this:

   cat *.log | awk -f jack_test3_consolidated.awk


Enjoy.
-- 
rncbc aka Rui Nuno Capela
rncbc@rncbc.org

------=_20041123165314_70425
Content-Type: application/x-gzip-compressed; name="jack_test3.1.tar.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="jack_test3.1.tar.gz"

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
------=_20041123165314_70425--


