Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267571AbUHJTXn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267571AbUHJTXn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 15:23:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267609AbUHJTXm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 15:23:42 -0400
Received: from mx1.redhat.com ([66.187.233.31]:8357 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267571AbUHJTWo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 15:22:44 -0400
Date: Tue, 10 Aug 2004 15:22:19 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@dhcp83-76.boston.redhat.com
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Kurt Garloff <garloff@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Chris Wright <chrisw@osdl.org>, Stephen Smalley <sds@epoch.ncsc.mil>,
       Greg KH <greg@kroah.com>
Subject: Re: [PATCH] [LSM] Rework LSM hooks
In-Reply-To: <1092150120.16939.25.camel@localhost.localdomain>
Message-ID: <Xine.LNX.4.44.0408101512520.9121-100000@dhcp83-76.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Aug 2004, Alan Cox wrote:

> On Maw, 2004-08-10 at 15:16, James Morris wrote:
> > On Tue, 10 Aug 2004, Kurt Garloff wrote:
> > 
> > > * Even with selinux=0 and capability loaded, the kernel takes a 
> > >   few percents in networking benchmarks (measured by HP on ia64); 
> > >   this is caused by the slowliness of indirect jumps on ia64.
> > 
> > Is this just an ia64 issue?  If so, then perhaps we should look at only
> > penalising ia64?  Otherwise, loading an LSM module is going to cause
> > expensive false unlikely() on _every_ LSM hook.
> 
> I see this on x86-32 to an extent. Its quite visible with gigabit as
> you'd expect. ia64 ought to be less affected providing the compiler is
> doing the right things with the unconditional jumps.

I did some benchmarking (full results below), and I'm not seeing anything
significant on a P4 Xeon.

For a vanilla kernel (no LSM):

  Looback TCP bandwidth = 305.9 MB/s over ten lmbench runs.
  Apachebench loobpack, 100k requests for a 50k file: 2045.70 reqs/s

For a kernel with LSM + networking hooks + capability module:

  Looback TCP bandwidth = 305.8 MB/s
  pachebench loobpack, 100k requests for a 50k file: 2044.29 req/s

The overhead of LSM on networking performance in these tests is in the 
noise.  The ab test was even done with httpd logging enabled on ext3.


- James
-- 
James Morris
<jmorris@redhat.com>


Full benchmark results:

--------------------------------------------------------------------------------
'Vanilla' kernel, no Netfilter, No LSM
--------------------------------------------------------------------------------

1) Apachebench loopback

# ab -n 100000 -c 2 http://localhost/index.html
This is ApacheBench, Version 2.0.40-dev <$Revision: 1.141 $> apache-2.0
Copyright (c) 1996 Adam Twiss, Zeus Technology Ltd, http://www.zeustech.net/
Copyright (c) 1998-2002 The Apache Software Foundation, http://www.apache.org/

Benchmarking localhost (be patient)
Completed 10000 requests
Completed 20000 requests
Completed 30000 requests
Completed 40000 requests
Completed 50000 requests
Completed 60000 requests
Completed 70000 requests
Completed 80000 requests
Completed 90000 requests
Finished 100000 requests


Server Software:        Apache/2.0.49
Server Hostname:        localhost
Server Port:            80

Document Path:          /index.html
Document Length:        51200 bytes

Concurrency Level:      2
Time taken for tests:   48.882919 seconds
Complete requests:      100000
Failed requests:        0
Write errors:           0
Total transferred:      851732704 bytes
HTML transferred:       825032704 bytes
Requests per second:    2045.70 [#/sec] (mean)
Time per request:       0.978 [ms] (mean)
Time per request:       0.489 [ms] (mean, across all concurrent requests)
Transfer rate:          17015.55 [Kbytes/sec] received

Connection Times (ms)
               min  mean[+/-sd] median   max
Connect:        0    0   0.0      0       1
Processing:     0    0   1.0      0     159
Waiting:        0    0   0.8      0     158
Total:          0    0   1.0      0     159
              
Percentage of the requests served within a certain time (ms)
50%      0
66%      0
75%      0
80%      0
90%      0
95%      1
98%      1
99%      1
100%    159 (longest request)
                               

2) lmbench loopback TCP peformance:

bw_tcp

0.065536 303.62 MB/sec
0.065536 306.19 MB/sec
0.065536 309.81 MB/sec
0.065536 309.18 MB/sec
0.065536 303.98 MB/sec
0.065536 305.58 MB/sec
0.065536 305.86 MB/sec
0.065536 301.23 MB/sec
0.065536 306.08 MB/sec
0.065536 307.63 MB/sec
av. = 305.9 MB/s


--------------------------------------------------------------------------------
'Test' kernel, no Netfilter, LSM with networking hooks + static capability mod
--------------------------------------------------------------------------------

1) Apachebench loobpack:

ab -n 100000 -c 2 http://localhost/index.html
This is ApacheBench, Version 2.0.40-dev <$Revision: 1.141 $> apache-2.0
Copyright (c) 1996 Adam Twiss, Zeus Technology Ltd, http://www.zeustech.net/
Copyright (c) 1998-2002 The Apache Software Foundation, http://www.apache.org/

Benchmarking localhost (be patient)
Completed 10000 requests
Completed 20000 requests
Completed 30000 requests
Completed 40000 requests
Completed 50000 requests
Completed 60000 requests
Completed 70000 requests
Completed 80000 requests
Completed 90000 requests
Finished 100000 requests


Server Software:        Apache/2.0.49
Server Hostname:        localhost
Server Port:            80

Document Path:          /index.html
Document Length:        51200 bytes

Concurrency Level:      2
Time taken for tests:   48.916767 seconds
Complete requests:      100000
Failed requests:        0
Write errors:           0
Total transferred:      851732704 bytes
HTML transferred:       825032704 bytes
Requests per second:    2044.29 [#/sec] (mean)
Time per request:       0.978 [ms] (mean)
Time per request:       0.489 [ms] (mean, across all concurrent requests)
Transfer rate:          17003.78 [Kbytes/sec] received

Connection Times (ms)
              min  mean[+/-sd] median   max
Connect:        0    0   0.0      0       1
Processing:     0    0   1.3      0     260
Waiting:        0    0   1.2      0     260
Total:          0    0   1.3      0     260
              
Percentage of the requests served within a certain time (ms)
50%      0
66%      0
75%      0
80%      0
90%      0
95%      1
98%      1
99%      1
100%    260 (longest request)



2) lmbench loopback TCP peformance:

bw_tcp

0.065536 306.08 MB/sec
0.065536 304.87 MB/sec
0.065536 302.42 MB/sec
0.065536 306.08 MB/sec
0.065536 306.24 MB/sec
0.065536 305.61 MB/sec
0.065536 307.04 MB/sec
0.065536 308.74 MB/sec
0.065536 305.97 MB/sec
0.065536 304.57 MB/sec
av. = 305.8 MB/s












