Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261322AbVFNUOp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261322AbVFNUOp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 16:14:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261325AbVFNUOp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 16:14:45 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:38044 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261322AbVFNUOm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 16:14:42 -0400
Date: Wed, 15 Jun 2005 01:42:13 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: viro@parcelfarce.linux.theplanet.co.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] files: scalable fd management (V4)
Message-ID: <20050614201213.GL4557@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20050614142612.GA4557@in.ibm.com> <20050614130338.70e99074.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050614130338.70e99074.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 14, 2005 at 01:03:38PM -0700, Andrew Morton wrote:
> Dipankar Sarma <dipankar@in.ibm.com> wrote:
> >
> > tiobench on a 4-way ppc64 system :
> >                                          (lockfree)
> >  Test            2.6.10-vanilla  Stdev   2.6.10-fd       Stdev
> >  -------------------------------------------------------------
> >  Seqread         1428            32.47   1475.0          29.11
> >  Randread        1469.2          17.27   1599.6          35.95
> >  Seqwrite        262.06          9.31    246.8           30.94
> >  Randwrite       548.38          12.49   521.4           61.98
> 
> We don't seem to have gained anything?

Look at the read numbers - lockfree is statistically better. The
write numbers varied just too much to mean anything. Besides, this
is on ppc64, with LL/SC type of lock. Here are the x86 numbers -

tiobench on a 4(8)-way (HT) P4 system on ramdisk :
                                                                                
                                        (lockfree)
Test            2.6.10-vanilla  Stdev   2.6.10-fd       Stdev
-------------------------------------------------------------
Seqread         1400.8          11.52   1465.4          34.27
Randread        1594            8.86    2397.2          29.21
Seqwrite        242.72          3.47    238.46          6.53
Randwrite       445.74          9.15    446.4           9.75

The performance improvement is very significant.
We are getting killed by the cacheline bouncing of the files_struct
lock here. Writes on ramdisk (ext2) seems to vary just too
much to get any meaningful number.

Also, With Tridge's thread_perf test on a 4(8)-way (HT) P4 xeon system :
                                                                                
2.6.12-rc5-vanilla :
                                                                                
Running test 'readwrite' with 8 tasks
Threads     0.34 +/- 0.01 seconds
Processes   0.16 +/- 0.00 seconds
                                                                                
2.6.12-rc5-fd :
                                                                                
Running test 'readwrite' with 8 tasks
Threads     0.17 +/- 0.02 seconds
Processes   0.17 +/- 0.02 seconds

Thanks
Dipankar
