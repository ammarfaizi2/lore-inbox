Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272732AbRIGPsV>; Fri, 7 Sep 2001 11:48:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272733AbRIGPsF>; Fri, 7 Sep 2001 11:48:05 -0400
Received: from e22.nc.us.ibm.com ([32.97.136.228]:23486 "EHLO
	e22.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S272732AbRIGPrp>; Fri, 7 Sep 2001 11:47:45 -0400
Importance: Normal
Subject: Re: Lockmeter Analysis of 2 DDs
To: linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net
Cc: "Hans Tannenberger" <Hans-Joachim.Tannenberger@us.ibm.com>,
        "Ruth Forester" <rsf@us.ibm.com>, "lahr" <lahr@us.ibm.com>,
        "Carbonari, Steven" <steven.carbonari@intel.com>
X-Mailer: Lotus Notes Release 5.0.8  June 18, 2001
Message-ID: <OFBC292301.DC08DA17-ON85256AC0.00555C52@raleigh.ibm.com>
From: "Peter Wong" <wpeter@us.ibm.com>
Date: Fri, 7 Sep 2001 10:47:37 -0500
X-MIMETrack: Serialize by Router on D04NM203/04/M/IBM(Release 5.0.6 |December 14, 2000) at
 09/07/2001 11:47:36 AM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have done some lockmeter analysis on dd under two kernels:
(1) 2.4.5 base kernel and (2) 2.4.5 base kernel + Jens Axboe's
zero-bounce highmem I/O patch + my IPS patch. The data indicate that
the io_request_lock is very hot, especially in case (2).

System Configurations:
  Red Hat 6.2, 2.4.5 kernel, 4-way 500MHz PIII, 2.5GB RAM,
  2MB L2 Cache, 50 disks with 5 ServeRAID 4H controllers

The script to run 10 dds:

dd if=/dev/raw/raw1 of=/dev/null bs=65536 count=2500 &
dd if=/dev/raw/raw4 of=/dev/null bs=65536 count=2500 &
dd if=/dev/raw/raw7 of=/dev/null bs=65536 count=2500 &
dd if=/dev/raw/raw10 of=/dev/null bs=65536 count=2500 &
dd if=/dev/raw/raw13 of=/dev/null bs=65536 count=2500 &
dd if=/dev/raw/raw16 of=/dev/null bs=65536 count=2500 &
dd if=/dev/raw/raw19 of=/dev/null bs=65536 count=2500 &
dd if=/dev/raw/raw22 of=/dev/null bs=65536 count=2500 &
dd if=/dev/raw/raw25 of=/dev/null bs=65536 count=2500 &
dd if=/dev/raw/raw28 of=/dev/null bs=65536 count=2500 &

(1) Under 2.4.5 Base (38 seconds)

SPINLOCKS        HOLD           WAIT
  UTIL  CON   MEAN(  MAX )  MEAN(  MAX )(% CPU)    TOTAL NOWAIT SPIN RJECT

emergency_lock
 23.8%    0% 2.8us(  54us)   0us                 3200001  100%    0%    0%

global_bh_lock
 24.6% 97.8%   80us(4385ms)  0us                  114825  2.2%    0% 97.8%

io_request_lock
 27.6% 11.5% 1.4us(  64us) 5.8us( 115us)( 3.4%)  7633079 88.5% 11.5%    0%

rmqueue+0x2c
  6.7% 13.6% 0.8us( 9.5us) 2.0us(  15us)(0.58%)  3200862 86.4% 13.6%    0%

emergency_lock    23.8 % + 0.00% * 4   = 0.24
global_bh_lock    24.6 % + 0.00% * 4   = 0.25
io_request_lock   27.6 % + 3.40% * 4   = 0.41
rmqueue+0x2c       6.7 % + 0.58% * 4   = 0.09
==================================================
                                 Sum   = 0.99 CPUs


(2) Under 2.4.5 + zero-bounce highmem I/O & IPS patches (22 seconds)

SPINLOCKS         HOLD            WAIT
  UTIL  CON    MEAN(  MAX )   MEAN(  MAX )(% CPU)     TOTAL NOWAIT SPIN
RJECT

global_bh_lock
 35.8%  8.9%  242us(2968us)    0us                    32543 91.1%    0%
8.9%

io_request_lock
 57.7% 59.4%  1.8us( 118us)   10us( 192us)(47.9%)   6914223 40.6% 59.4%
0%

 global_bh_lock    35.8% + 0.00% * 4    = 0.36
 io_request_lock   57.7% + 47.9% * 4    = 2.49
===================================================================
                                 Sum    = 2.85 CPUs


     Indeed, io_request_lock is very hot once the bounce buffers were
eliminated. Is anyone working on a patch for the io_request_lock that
possibly take the global lock and splits it into a per device queue lock?
We understand that getting this patch into 2.4 is unlikely, but it would
be nice to have this patch available on 2.4 for experimental purposes.


Wai Yee Peter Wong
IBM Linux Technology Center, Performance Analysis
email: wpeter@us.ibm.com
Office: (512) 838-9272, T/L 678-9272; Fax: (512) 838-4663

