Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965164AbWGKEuv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965164AbWGKEuv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 00:50:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965147AbWGKEuu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 00:50:50 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:56196 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S965169AbWGKEut (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 00:50:49 -0400
Subject: Re: [Patch 0/6] delay accounting & taskstats fixes
From: Shailabh Nagar <nagar@watson.ibm.com>
Reply-To: nagar@watson.ibm.com
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Jay Lan <jlan@sgi.com>,
       Chris Sturtivant <csturtiv@sgi.com>, Paul Jackson <pj@sgi.com>,
       Balbir Singh <balbir@in.ibm.com>,
       Chandra Seetharaman <sekharan@us.ibm.com>
In-Reply-To: <1152591838.14142.114.camel@localhost.localdomain>
References: <1152591838.14142.114.camel@localhost.localdomain>
Content-Type: text/plain
Organization: IBM
Message-Id: <1152593446.14142.151.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Tue, 11 Jul 2006 00:50:46 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-07-11 at 00:23, Shailabh Nagar wrote:
> Some results showing the cpumask feature 
> works as expected will follow separately.

To illustrate the basic premise behind the cpumask changes
namely, reducing the number of cpus results in fewer overflow
conditions, Chandra ran the following experiment on an
8-way PIII box:

- "mkthreads 1000 1000" (the program which only forks/exits) with
minimum time spent inside the thread function. This is basically an exit
rate that is higher than the 1000/cpu/sec discussed earlier.

- A slightly modified version of the getdelays.c example that is 
included in patch 2/6 in this series of postings. Modification was
to print only the number of receives and number of ENOBUFS seen. 

The -m parameter specifies the cpumask, 
-r parameter is the size of the socket receive buffer 
-l results in listening for exit data


The following sets of runs are self-explanatory.
Initial run emulates the earlier behaviour where one listener
receives data for all cpus. As the number of cpus to which it
listens is reduced, the ENOBUFS reduce.

Similarly, increasing the receive buffer size also cuts down 
on the ENOBUFS, further helped by reducing number of cpus listened
to. The final data point, not shown here, is when the receive 
buffer size is set to some high number like 8K when the ENOBUFS aren't
seen at all.


===================================

Each output shows 
stats <number of msgs rcvd> enobufs <num of enobufs seen>
cumulatively

elm3b94:/tmp # ./getdelays -m 0-7 -r 512 -l
cpumask 0-7 maskset 1
receive buf size 512
listen forever
 stats 100000, enobufs 2540
 stats 200000, enobufs 5701
 stats 300000, enobufs 8482
 stats 400000, enobufs 11332
 stats 500000, enobufs 14256
 stats 600000, enobufs 17150
 stats 700000, enobufs 19981
 stats 800000, enobufs 22971
 stats 900000, enobufs 26324
 stats 1000000, enobufs 29291

elm3b94:/tmp # ./getdelays -m 0-3 -r 512 -l
cpumask 0-3 maskset 1
receive buf size 512
listen forever
 stats 100000, enobufs 831
 stats 200000, enobufs 1772
 stats 300000, enobufs 2728
 stats 400000, enobufs 3820
 stats 500000, enobufs 5030
 stats 600000, enobufs 6501
 stats 700000, enobufs 7885
 stats 800000, enobufs 8971
 stats 900000, enobufs 10262
 stats 1000000, enobufs 11786

elm3b94:/tmp # ./getdelays -m 2-3 -r 512 -l
cpumask 2-3 maskset 1
receive buf size 512
listen forever
 stats 100000, enobufs 106
 stats 200000, enobufs 206
 stats 300000, enobufs 313
 stats 400000, enobufs 389
 stats 500000, enobufs 477
 stats 600000, enobufs 676
 stats 700000, enobufs 860
 stats 800000, enobufs 1048
 stats 900000, enobufs 1189
 stats 1000000, enobufs 1303

elm3b94:/tmp # ./getdelays -m 0 -r 512 -l
cpumask 0 maskset 1
receive buf size 512
listen forever
 stats 100000, enobufs 100
 stats 200000, enobufs 162
 stats 300000, enobufs 302
 stats 400000, enobufs 399
 stats 500000, enobufs 507
 stats 600000, enobufs 571
 stats 700000, enobufs 666
 stats 800000, enobufs 725
 stats 900000, enobufs 821
 stats 1000000, enobufs 909

================= with recv buf size 2048

elm3b94:/tmp # ./getdelays -m 0-7 -r 2048 -l
cpumask 0-7 maskset 1
receive buf size 2048
listen forever
 stats 100000, enobufs 35
 stats 200000, enobufs 88
 stats 300000, enobufs 123
 stats 400000, enobufs 138
 stats 500000, enobufs 155
 stats 600000, enobufs 191
 stats 700000, enobufs 223
 stats 800000, enobufs 238
 stats 900000, enobufs 280
 stats 1000000, enobufs 319


elm3b94:/tmp # ./getdelays -m 4-7 -r 2048 -l
cpumask 4-7 maskset 1
receive buf size 2048
listen forever
 stats 100000, enobufs 10
 stats 200000, enobufs 17
 stats 300000, enobufs 28
 stats 400000, enobufs 35
 stats 500000, enobufs 49
 stats 600000, enobufs 63
 stats 700000, enobufs 80
 stats 800000, enobufs 94
 stats 900000, enobufs 114
 stats 1000000, enobufs 138

elm3b94:/tmp # ./getdelays -m 2-3 -r 2048 -l
cpumask 2-3 maskset 1
receive buf size 2048
listen forever
 stats 100000, enobufs 5
 stats 200000, enobufs 6
 stats 300000, enobufs 10
 stats 400000, enobufs 14
 stats 500000, enobufs 19
 stats 600000, enobufs 33
 stats 700000, enobufs 38
 stats 800000, enobufs 43
 stats 900000, enobufs 54
 stats 1000000, enobufs 59


elm3b94:/tmp # ./getdelays -m 1 -r 2048 -l
cpumask 1 maskset 1
receive buf size 2048
listen forever
 stats 100000, enobufs 3
 stats 200000, enobufs 6
 stats 300000, enobufs 19
 stats 400000, enobufs 25
 stats 500000, enobufs 30
 stats 600000, enobufs 31
 stats 700000, enobufs 33
 stats 800000, enobufs 45
 stats 900000, enobufs 48
 stats 1000000, enobufs 52


