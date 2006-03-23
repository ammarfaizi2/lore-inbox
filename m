Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030204AbWCWPQv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030204AbWCWPQv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 10:16:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932434AbWCWPQv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 10:16:51 -0500
Received: from mtagate2.uk.ibm.com ([195.212.29.135]:57761 "EHLO
	mtagate2.uk.ibm.com") by vger.kernel.org with ESMTP id S932375AbWCWPQu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 10:16:50 -0500
Message-ID: <4422BBD9.40901@watson.ibm.com>
Date: Thu, 23 Mar 2006 10:16:41 -0500
From: Shailabh Nagar <nagar@watson.ibm.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20051002)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [Patch 0/9] Performance
References: <1142296834.5858.3.camel@elinux04.optonline.net> <20060314192824.GB27012@kroah.com>
In-Reply-To: <20060314192824.GB27012@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Mon, Mar 13, 2006 at 07:40:34PM -0500, Shailabh Nagar wrote:
>
>>This is the next iteration of the delay accounting patches
>>last posted at
>>	http://www.ussg.iu.edu/hypermail/linux/kernel/0602.3/0893.html
>
>
> Do you have any benchmark numbers with this patch applied and with it
> not applied?  Last I heard it was a measurable decrease for some
> "important" benchmark results...
>
> thanks,
>
> greg k-h

Here are some numbers for the latest set of posted patches
using microbenchmarks hackbench, kernbench and lmbench.

I was trying to get the real/big benchmark numbers too but
it looks like getting a run whose numbers can be trusted
will take a bit longer than expected. Preliminary runs of
transaction processing benchmarks indicate that overhead
actually decreases with the patch (as also seen in some of
the lmbench numbers below).

--Shailabh



Results highlights

- Configuring delay accounting adds < 0.5%
  overhead in most cases and even reduces overhead
  in some cases

- Enabling delay accounting has similar results
  with a maximum overhead of 1.2% for hackbench
  , most other overheads < 1% and reduction in
  overhead in some cases



Base
	Vanilla 2.6.16-rc6 kernel
	without any patches applied
+patch	
	Delay accounting configured
	but not enabled at boot
+patch+enable
	Delay accounting enabled at boot
	but no stats read

Hackbench
---------
200 groups, using sockets
Elapsed time, in seconds, lower better

		%Ovhd	Time 	
Base		0	12.468	
+patch		0.4%	12.523	
+patch+enable	1.2%	12.622	

Kernbench
---------
Average of 5 iterations
Elapsed time, in seconds, lower better

		%Ovhd	Elapsed	
Base		0	195.776
+patch		0.2%	196.246
+patch+enable	0.3%	196.282

Lmbench
-------

Processor, Processes - times in microseconds - smaller is better
----------------------------------------------------------------
Host                 OS  Mhz null null      open selct sig  sig  fork exec sh
                             call  I/O stat clos TCP   inst hndl proc proc proc
--------- ------------- ---- ---- ---- ---- ---- ----- ---- ---- ---- ---- ----
base      Linux 2.6.16- 2783 0.17 0.33 5.17 6.49  13.4 0.64 2.61 146. 610. 9376
+patch    Linux 2.6.16- 2781 0.17 0.32 4.75 5.85  13.0 0.64 2.62 145. 628. 9393
+patch+en Linux 2.6.16- 2784 0.17 0.32 4.71 6.14  13.4 0.64 2.60 150. 616. 9402

Context switching - times in microseconds - smaller is better
-------------------------------------------------------------
Host                 OS 2p/0K 2p/16K 2p/64K 8p/16K 8p/64K 16p/16K 16p/64K
                        ctxsw  ctxsw  ctxsw ctxsw  ctxsw   ctxsw   ctxsw
--------- ------------- ----- ------ ------ ------ ------ ------- -------
base      Linux 2.6.16- 4.340 4.9600 7.3300 6.5700   30.3    10.4    36.0
+patch    Linux 2.6.16- 4.390 4.9800 7.3100 6.5900   29.7 9.62000    35.8
+patch+en Linux 2.6.16- 4.560 5.0800 7.2400 5.6900   22.7    10.3    33.8

*Local* Communication latencies in microseconds - smaller is better
-------------------------------------------------------------------
Host                 OS 2p/0K  Pipe AF     UDP  RPC/   TCP  RPC/ TCP
                        ctxsw       UNIX         UDP         TCP conn
--------- ------------- ----- ----- ---- ----- ----- ----- ----- ----
base      Linux 2.6.16- 4.340  15.9 12.2  18.3  24.9  21.5  29.1 45.3
+patch    Linux 2.6.16- 4.390  15.7 11.8  18.6  22.2  22.0  29.1 44.8
+patch+en Linux 2.6.16- 4.560  15.6 12.1  18.9  25.3  21.9  27.1 45.1

File & VM system latencies in microseconds - smaller is better
--------------------------------------------------------------
Host                 OS   0K File      10K File      Mmap    Prot    Page
                        Create Delete Create Delete  Latency Fault   Fault
--------- ------------- ------ ------ ------ ------  ------- -----   -----
base      Linux 2.6.16-   39.8   58.0  112.0   82.6   8417.0 0.838 2.00000
+patch    Linux 2.6.16-   39.6   58.2  111.0   82.3   8392.0 0.864 2.00000
+patch+en Linux 2.6.16-   39.6   59.1  112.8   83.2   8308.0 0.821 2.00000

*Local* Communication bandwidths in MB/s - bigger is better
-----------------------------------------------------------
Host                OS  Pipe AF    TCP  File   Mmap  Bcopy  Bcopy  Mem   Mem
                             UNIX      reread reread (libc) (hand) read write
--------- ------------- ---- ---- ---- ------ ------ ------ ------ ---- -----
base      Linux 2.6.16- 676. 616. 620. 1658.0 2030.6  759.6  825.9 2032 1177.
+patch    Linux 2.6.16- 627. 165. 616. 1649.9 2030.9  766.1  834.1 2030 1187.
+patch+en Linux 2.6.16- 633. 148. 603. 1569.7 2030.9  757.2  835.3 2030 1174.

Memory latencies in nanoseconds - smaller is better
    (WARNING - may not be correct, check graphs)
---------------------------------------------------
Host                 OS   Mhz  L1 $   L2 $    Main mem    Guesses
--------- -------------  ---- ----- ------    --------    -------
base      Linux 2.6.16-  2783 0.719 6.5960  110.5
+patch    Linux 2.6.16-  2781 0.720 6.5980  111.0
+patch+en Linux 2.6.16-  2784 0.720 6.5970  110.7


