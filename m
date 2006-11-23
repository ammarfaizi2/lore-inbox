Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933614AbWKWLYf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933614AbWKWLYf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 06:24:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933627AbWKWLYf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 06:24:35 -0500
Received: from brick.kernel.dk ([62.242.22.158]:20264 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S933614AbWKWLYe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 06:24:34 -0500
Date: Thu, 23 Nov 2006 12:24:29 +0100
From: Jens Axboe <jens.axboe@oracle.com>
To: Jim Schutt <jaschut@sandia.gov>
Cc: linux-kernel@vger.kernel.org
Subject: Re: splice/vmsplice performance test results
Message-ID: <20061123112429.GN4999@kernel.dk>
References: <1163700539.2672.14.camel@sale659.sandia.gov> <20061116202529.GH7164@kernel.dk> <1163784110.8170.8.camel@sale659.sandia.gov> <20061120075941.GF4077@kernel.dk> <20061120082426.GG4077@kernel.dk> <1164037743.19613.5.camel@sale659.sandia.gov> <20061121135454.GV8055@kernel.dk> <1164136669.4265.65.camel@sale659.sandia.gov> <20061122085719.GM8055@kernel.dk> <1164234912.14241.15.camel@sale659.sandia.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1164234912.14241.15.camel@sale659.sandia.gov>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22 2006, Jim Schutt wrote:
> 
> On Wed, 2006-11-22 at 09:57 +0100, Jens Axboe wrote:
> > On Tue, Nov 21 2006, Jim Schutt wrote:
> [snip]
> > > 
> > > Hmmm.  Is it worth me trying to do some sort of kernel 
> > > profiling to see if there is anything unexpected with 
> > > my setup?  If so, do you have a preference as to what 
> > > I would use?  
> > 
> > Not sure that profiling would be that interesting, as the problem
> > probably lies in where we are _not_ spending the time. But it certainly
> > can't hurt. Try to oprofile the kernel for a 10-20 sec interval while
> > the test is running. Do 3 such runs for the two test cases
> > (write-to-file, vmsplice/splice-to-file).
> > 
> 
> OK, I've attached results for 20 second profiles of three
> runs of each test: read-from-socket + write-to-file, and
> read-from-socket + vmsplice/splice-to-file.
> 
> The test case and throughput is in the name: e.g. rvs-1-306MBps
> is trial 1 of read/vmsplice/splice case, which ran at 306 MB/s.
> 
> Let me know if I can help with more testing, and thanks
> again for looking into this.

As I suspected, nothing sticks out in these logs as the problem here is
not due to a maxed out system. The traces look fairly identical, less
time spent in copy_user with the splice approach.

Comparing the generic_file_buffered_write() and splice-to-file path,
there really isn't a whole lot of difference. It would be interesting to
try and eliminate some of the differences between the two approaches -
could you try and change the vmsplice to a write-to-pipe instead? And
add SPLICE_F_NONBLOCK to the splice-to-file as well. Basically I'm
interested in a something that only really tests splice-to-file vs
write-to-file. Perhaps easier if you can just run fio to test that, I'm
inlining a job file to test that specifically.

; -- start job file

[global]
bs=64k
rw=write
overwrite=0
size=16g
end_fsync=1
direct=0
unlink

[write]
ioengine=sync

[splice]
stonewall
ioengine=splice

; -- end job file

You can grab a fio snapshot here:

http://brick.kernel.dk/snaps/fio-git-20061123122325.tar.gz

You probably want to run that a few times to see how stable the results
are, buffered io is always a little problematic from a consistency point
of view in benchmark results.

-- 
Jens Axboe

