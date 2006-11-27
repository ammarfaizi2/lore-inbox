Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933351AbWK0U5S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933351AbWK0U5S (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 15:57:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933644AbWK0U5S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 15:57:18 -0500
Received: from mm04snlnto.sandia.gov ([132.175.109.21]:8 "EHLO
	sentry.sandia.gov") by vger.kernel.org with ESMTP id S933351AbWK0U5R
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 15:57:17 -0500
X-Server-Uuid: 0D2F78EE-7D53-4621-AAFC-6A86EB50E29B
Subject: Re: splice/vmsplice performance test results
From: "Jim Schutt" <jaschut@sandia.gov>
To: "Jens Axboe" <jens.axboe@oracle.com>
cc: linux-kernel@vger.kernel.org
In-Reply-To: <20061123112429.GN4999@kernel.dk>
References: <1163700539.2672.14.camel@sale659.sandia.gov>
 <20061116202529.GH7164@kernel.dk>
 <1163784110.8170.8.camel@sale659.sandia.gov>
 <20061120075941.GF4077@kernel.dk> <20061120082426.GG4077@kernel.dk>
 <1164037743.19613.5.camel@sale659.sandia.gov>
 <20061121135454.GV8055@kernel.dk>
 <1164136669.4265.65.camel@sale659.sandia.gov>
 <20061122085719.GM8055@kernel.dk>
 <1164234912.14241.15.camel@sale659.sandia.gov>
 <20061123112429.GN4999@kernel.dk>
Date: Mon, 27 Nov 2006 13:57:09 -0700
Message-ID: <1164661029.4237.10.camel@sale659.sandia.gov>
MIME-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-27.rhel4.6)
X-TMWD-Spam-Summary: TS=20061127205712; SEV=2.2.0; DFV=B2006112710;
 IFV=2.0.4,4.0-9; AIF=B2006112710; RPD=5.02.0004; ENG=IBF; RPDID=NA;
 CAT=NONE; CON=NONE
X-MMS-Spam-Filter-ID: B2006112710_5.02.0004_4.0-9
X-WSS-ID: 69758EAC26S5089305-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-11-23 at 12:24 +0100, Jens Axboe wrote: 
> On Wed, Nov 22 2006, Jim Schutt wrote:
> > 
> > On Wed, 2006-11-22 at 09:57 +0100, Jens Axboe wrote:
> > > On Tue, Nov 21 2006, Jim Schutt wrote:
> > [snip]
> > > > 
> > > > Hmmm.  Is it worth me trying to do some sort of kernel 
> > > > profiling to see if there is anything unexpected with 
> > > > my setup?  If so, do you have a preference as to what 
> > > > I would use?  
> > > 
> > > Not sure that profiling would be that interesting, as the problem
> > > probably lies in where we are _not_ spending the time. But it certainly
> > > can't hurt. Try to oprofile the kernel for a 10-20 sec interval while
> > > the test is running. Do 3 such runs for the two test cases
> > > (write-to-file, vmsplice/splice-to-file).
> > > 
> > 
> > OK, I've attached results for 20 second profiles of three
> > runs of each test: read-from-socket + write-to-file, and
> > read-from-socket + vmsplice/splice-to-file.
> > 
> > The test case and throughput is in the name: e.g. rvs-1-306MBps
> > is trial 1 of read/vmsplice/splice case, which ran at 306 MB/s.
> > 
> > Let me know if I can help with more testing, and thanks
> > again for looking into this.
> 
> As I suspected, nothing sticks out in these logs as the problem here is
> not due to a maxed out system. The traces look fairly identical, less
> time spent in copy_user with the splice approach.
> 
> Comparing the generic_file_buffered_write() and splice-to-file path,
> there really isn't a whole lot of difference. It would be interesting to
> try and eliminate some of the differences between the two approaches -
> could you try and change the vmsplice to a write-to-pipe instead? And
> add SPLICE_F_NONBLOCK to the splice-to-file as well. Basically I'm
> interested in a something that only really tests splice-to-file vs
> write-to-file. Perhaps easier if you can just run fio to test that, I'm
> inlining a job file to test that specifically.
> 

Sorry for the delayed reply.

Here's results from three fio runs, using the job file
you gave me, and fio-git-20061124142507.tar.gz:

---
write: (g=0): rw=write, odir=0, bs=64K-64K/64K-64K, rate=0,
ioengine=sync, iodepth=1
splice: (g=1): rw=write, odir=0, bs=64K-64K/64K-64K, rate=0,
ioengine=splice, iodepth=1
write: (g=0): rw=write, odir=0, bs=64K-64K/64K-64K, rate=0,
ioengine=sync, iodepth=1
splice: (g=1): rw=write, odir=0, bs=64K-64K/64K-64K, rate=0,
ioengine=splice, iodepth=1
write: (g=0): rw=write, odir=0, bs=64K-64K/64K-64K, rate=0,
ioengine=sync, iodepth=1
splice: (g=1): rw=write, odir=0, bs=64K-64K/64K-64K, rate=0,
ioengine=splice, iodepth=1
write: (groupid=0): err= 0:
  write: io= 16384MiB, bw=558404KiB/s, runt= 30766msec
    slat (msec): min=    0, max=    0, avg= 0.00, dev= 0.00
    clat (msec): min=    0, max=   35, avg= 0.00, dev= 0.08
    bw (KiB/s) : min=    0, max=644481, per=98.90%, avg=552243.95,
dev=561417.03
  cpu          : usr=0.91%, sys=85.03%, ctx=14121
splice: (groupid=1): err= 0:
  write: io= 16384MiB, bw=486144KiB/s, runt= 35339msec
    slat (msec): min=    0, max=    0, avg= 0.00, dev= 0.00
    clat (msec): min=    0, max=   30, avg= 0.00, dev= 0.10
    bw (KiB/s) : min=    0, max=555745, per=99.06%, avg=481567.28,
dev=488565.60
  cpu          : usr=0.85%, sys=88.87%, ctx=12956

Run status group 0 (all jobs):
  WRITE: io=16384MiB, aggrb=558404, minb=558404, maxb=558404,
mint=30766msec, maxt=30766msec

Run status group 1 (all jobs):
  WRITE: io=16384MiB, aggrb=486144, minb=486144, maxb=486144,
mint=35339msec, maxt=35339msec

Disk stats (read/write):
  md0: ios=20/270938, merge=0/0, ticks=0/0, in_queue=0, util=0.00%
---
write: (g=0): rw=write, odir=0, bs=64K-64K/64K-64K, rate=0,
ioengine=sync, iodepth=1
splice: (g=1): rw=write, odir=0, bs=64K-64K/64K-64K, rate=0,
ioengine=splice, iodepth=1
write: (g=0): rw=write, odir=0, bs=64K-64K/64K-64K, rate=0,
ioengine=sync, iodepth=1
splice: (g=1): rw=write, odir=0, bs=64K-64K/64K-64K, rate=0,
ioengine=splice, iodepth=1
write: (g=0): rw=write, odir=0, bs=64K-64K/64K-64K, rate=0,
ioengine=sync, iodepth=1
splice: (g=1): rw=write, odir=0, bs=64K-64K/64K-64K, rate=0,
ioengine=splice, iodepth=1
write: (groupid=0): err= 0:
  write: io= 16384MiB, bw=547234KiB/s, runt= 31394msec
    slat (msec): min=    0, max=    1, avg= 0.00, dev= 0.00
    clat (msec): min=    0, max=   57, avg= 0.00, dev= 0.14
    bw (KiB/s) : min=    0, max=662568, per=98.94%, avg=541406.71,
dev=550958.67
  cpu          : usr=0.79%, sys=82.80%, ctx=16560
splice: (groupid=1): err= 0:
  write: io= 16384MiB, bw=473313KiB/s, runt= 36297msec
    slat (msec): min=    0, max=    1, avg= 0.00, dev= 0.00
    clat (msec): min=    0, max=   27, avg= 0.00, dev= 0.11
    bw (KiB/s) : min=    0, max=562298, per=99.12%, avg=469142.21,
dev=476426.36
  cpu          : usr=1.05%, sys=84.78%, ctx=16043

Run status group 0 (all jobs):
  WRITE: io=16384MiB, aggrb=547234, minb=547234, maxb=547234,
mint=31394msec, maxt=31394msec

Run status group 1 (all jobs):
  WRITE: io=16384MiB, aggrb=473313, minb=473313, maxb=473313,
mint=36297msec, maxt=36297msec

Disk stats (read/write):
  md0: ios=17/270784, merge=0/0, ticks=0/0, in_queue=0, util=0.00%
---
write: (g=0): rw=write, odir=0, bs=64K-64K/64K-64K, rate=0,
ioengine=sync, iodepth=1
splice: (g=1): rw=write, odir=0, bs=64K-64K/64K-64K, rate=0,
ioengine=splice, iodepth=1
write: (g=0): rw=write, odir=0, bs=64K-64K/64K-64K, rate=0,
ioengine=sync, iodepth=1
splice: (g=1): rw=write, odir=0, bs=64K-64K/64K-64K, rate=0,
ioengine=splice, iodepth=1
write: (g=0): rw=write, odir=0, bs=64K-64K/64K-64K, rate=0,
ioengine=sync, iodepth=1
splice: (g=1): rw=write, odir=0, bs=64K-64K/64K-64K, rate=0,
ioengine=splice, iodepth=1
write: (groupid=0): err= 0:
  write: io= 16384MiB, bw=561140KiB/s, runt= 30616msec
    slat (msec): min=    0, max=    1, avg= 0.00, dev= 0.00
    clat (msec): min=    0, max=   26, avg= 0.00, dev= 0.08
    bw (KiB/s) : min=    0, max=665976, per=98.94%, avg=555198.98,
dev=564632.52
  cpu          : usr=0.82%, sys=85.12%, ctx=14287
splice: (groupid=1): err= 0:
  write: io= 16384MiB, bw=487192KiB/s, runt= 35263msec
    slat (msec): min=    0, max=    0, avg= 0.00, dev= 0.00
    clat (msec): min=    0, max=   29, avg= 0.00, dev= 0.09
    bw (KiB/s) : min=    0, max=566099, per=99.08%, avg=482706.32,
dev=489726.36
  cpu          : usr=0.85%, sys=86.96%, ctx=13072

Run status group 0 (all jobs):
  WRITE: io=16384MiB, aggrb=561140, minb=561140, maxb=561140,
mint=30616msec, maxt=30616msec

Run status group 1 (all jobs):
  WRITE: io=16384MiB, aggrb=487192, minb=487192, maxb=487192,
mint=35263msec, maxt=35263msec

Disk stats (read/write):
  md0: ios=18/270851, merge=0/0, ticks=0/0, in_queue=0, util=0.00%
---

Do these results give you something to work with, or would 
you like me to run some other tests?

Let me know.

Thanks -- Jim Schutt

