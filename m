Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030226AbWCWLG4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030226AbWCWLG4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 06:06:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030227AbWCWLG4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 06:06:56 -0500
Received: from mail.gmx.de ([213.165.64.20]:11661 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1030226AbWCWLGz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 06:06:55 -0500
X-Authenticated: #14349625
Subject: Re: [interbench numbers] Re: interactive task starvation
From: Mike Galbraith <efault@gmx.de>
To: Con Kolivas <kernel@kolivas.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Willy Tarreau <willy@w.ods.org>,
       Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       bugsplatter@gmail.com, Peter Williams <pwil3058@bigpond.net.au>
In-Reply-To: <1143093229.9303.1.camel@homer>
References: <1142592375.7895.43.camel@homer>
	 <200603230727.51235.kernel@kolivas.org> <1143084178.7665.6.camel@homer>
	 <200603231643.36093.kernel@kolivas.org>  <1143093229.9303.1.camel@homer>
Content-Type: text/plain
Date: Thu, 23 Mar 2006 12:07:25 +0100
Message-Id: <1143112045.9065.15.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-03-23 at 06:53 +0100, Mike Galbraith wrote:
> On Thu, 2006-03-23 at 16:43 +1100, Con Kolivas wrote:
> > On Thu, 23 Mar 2006 02:22 pm, Mike Galbraith wrote:
> > > On Thu, 2006-03-23 at 07:27 +1100, Con Kolivas wrote:
> > > > I wonder why the results are affected even without any throttling
> > > > settings but just patched in? Specifically I'm talking about deadlines
> > > > met with video being sensitive to this. Were there any other config
> > > > differences between the tests? Changing HZ would invalidate the results
> > > > for example. Comments?
> > >
> > > I wondered the same.  The only difference then is the lower idle sleep
> > > prio, tighter timeslice enforcement, and the SMP buglet fix for now <
> > > p->timestamp due to SMP rounding.  Configs are identical.
> > 
> > Ok well if we're going to run with this set of changes then we need to assess 
> > the affect of each change and splitting them up into separate patches would 
> > be appropriate normally anyway. That will allow us to track down which 
> > particular patch causes it. That won't mean we will turn down the change 
> > based on that one result, though, it will just help us understand it better.
> 
> I'm investigating now.

Nothing conclusive.  Some of the difference may be because interbench
has a dependency on the idle sleep path popping tasks in a prio 16
instead of 18.  Some of it may be because I'm not restricting IO, doing
that makes a bit of difference.  Some of it is definitely plain old
jitter.

Six hours is long enough.  I'm all done chasing interbench numbers.

	-Mike

virgin

--- Benchmarking simulated cpu of Video in the presence of simulated ---
Load	Latency +/- SD (ms)  Max Latency   % Desired CPU  % Deadlines Met
None	  0.031 +/- 0.396       16.7		 100	       99.9
X	  0.722 +/- 3.35        30.7		 100	         97
Burn	  0.531 +/- 7.42         246		99.1	         98
Write	  0.302 +/- 2.31        40.4		99.9	       98.5
Read	  0.092 +/- 1.11        32.9		99.9	       99.7
Compile	  0.428 +/- 2.77        36.3		99.9	       97.9
Memload	  0.235 +/- 3.3          104		99.5	       99.1

throttle patches with throttling disabled

--- Benchmarking simulated cpu of Video in the presence of simulated ---
Load	Latency +/- SD (ms)  Max Latency   % Desired CPU  % Deadlines Met
None	  0.185 +/- 1.6         18.8		 100	       99.1
X	   1.27 +/- 4.47          27		 100	       94.3
Burn	   1.57 +/- 13.3         345		98.1	         93
Write	  0.819 +/- 3.76        34.7		99.9	         96
Read	  0.301 +/- 2.05        18.7		 100	       98.5
Compile	   4.22 +/- 12.9         233		92.4	       80.2
Memload	  0.624 +/- 3.46        66.7		99.6	         97

minus idle sleep

--- Benchmarking simulated cpu of Video in the presence of simulated ---
Load	Latency +/- SD (ms)  Max Latency   % Desired CPU  % Deadlines Met
None	  0.222 +/- 1.82        16.8		 100	       98.8
X	   1.02 +/- 3.9         30.7		 100	       95.7
Burn	  0.208 +/- 3.67         141		99.8	       99.3
Write	  0.755 +/- 3.62        37.2		99.9	       96.4
Read	  0.265 +/- 1.94        16.9		 100	       98.6
Compile	   2.16 +/- 15.2         333		96.7	       90.7
Memload	  0.723 +/- 3.5         37.4		99.8	       96.3

minus don't restrict IO

--- Benchmarking simulated cpu of Video in the presence of simulated ---
Load	Latency +/- SD (ms)  Max Latency   % Desired CPU  % Deadlines Met
None	  0.226 +/- 1.82        16.8		 100	       98.8
X	   1.38 +/- 4.68        49.4		99.9	       93.9
Burn	  0.513 +/- 9.62         339		98.8	       98.4
Write	  0.418 +/- 2.7         30.8		99.9	       97.9
Read	  0.565 +/- 2.99        16.7		 100	       96.8
Compile	   1.05 +/- 13.6         545		99.1	       95.1
Memload	  0.345 +/- 3.23        80.5		99.8	       98.5



