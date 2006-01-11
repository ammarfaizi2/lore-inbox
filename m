Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932417AbWAKTVn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932417AbWAKTVn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 14:21:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932388AbWAKTVm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 14:21:42 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:2497 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S932203AbWAKTVk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 14:21:40 -0500
Subject: Re: [PATCH 0/5] multiple block allocation to current ext3
From: Mingming Cao <cmm@us.ibm.com>
Reply-To: cmm@us.ibm.com
To: Andrew Morton <akpm@osdl.org>
Cc: hch@lst.de, pbadari@us.ibm.com, sct@redhat.com,
       linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
In-Reply-To: <20060110212551.411a766d.akpm@osdl.org>
References: <1112673094.14322.10.camel@mindpipe>
	 <1112765751.3874.14.camel@localhost.localdomain>
	 <20050407081434.GA28008@elte.hu>
	 <1112879303.2859.78.camel@sisko.sctweedie.blueyonder.co.uk>
	 <1112917023.3787.75.camel@dyn318043bld.beaverton.ibm.com>
	 <1112971236.1975.104.camel@sisko.sctweedie.blueyonder.co.uk>
	 <1112983801.10605.32.camel@dyn318043bld.beaverton.ibm.com>
	 <1113220089.2164.52.camel@sisko.sctweedie.blueyonder.co.uk>
	 <1113244710.4413.38.camel@localhost.localdomain>
	 <1113249435.2164.198.camel@sisko.sctweedie.blueyonder.co.uk>
	 <1113288087.4319.49.camel@localhost.localdomain>
	 <1113304715.2404.39.camel@sisko.sctweedie.blueyonder.co.uk>
	 <1113348434.4125.54.camel@dyn318043bld.beaverton.ibm.com>
	 <1113388142.3019.12.camel@sisko.sctweedie.blueyonder.co.uk>
	 <1114207837.7339.50.camel@localhost.localdomain>
	 <1114659912.16933.5.camel@mindpipe>
	 <1114715665.18996.29.camel@localhost.localdomain>
	 <1136935562.4901.41.camel@dyn9047017067.beaverton.ibm.com>
	 <20060110212551.411a766d.akpm@osdl.org>
Content-Type: text/plain
Organization: IBM LTC
Date: Wed, 11 Jan 2006 11:17:11 -0800
Message-Id: <1137007032.4395.24.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-01-10 at 21:25 -0800, Andrew Morton wrote:
> Mingming Cao <cmm@us.ibm.com> wrote:
> >
> > Tests done so far includes fsx,tiobench and dbench. The following
> >  numbers collected from Direct IO tests (1G file creation/read)  shows
> >  the system time have been greatly reduced (more than 50% on my 8 cpu
> >  system) with the patches.
> > 
> >  1G file DIO write:
> >  	2.6.15		2.6.15+patches
> >  real    0m31.275s	0m31.161s
> >  user    0m0.000s	0m0.000s
> >  sys     0m3.384s	0m0.564s 
> > 
> > 
> >  1G file DIO read:
> >  	2.6.15		2.6.15+patches
> >  real    0m30.733s	0m30.624s
> >  user    0m0.000s	0m0.004s
> >  sys     0m0.748s	0m0.380s
> > 
> >  Some previous test we did on buffered IO with using multiple blocks
> >  allocation and delayed allocation shows noticeable improvement on
> >  throughput and system time.
> 
> I'd be interested in seeing benchmark results for the common
> allocate-one-block case - just normal old buffered IO without any
> additional multiblock patches.   Would they show any regression?
> 
Hi Andrew, 
  One thing I want to clarify is that: for the buffered IO, even with
mutlipleblock patches, currently ext3 is still allocate one block at a
time.(we will need delayed allocation to make use of the multiple block
allocation)

I did the same test on buffered IO, w/o the patches. Very little
regression(less than 1% could be consider as noise) comparing 2.6.15
kernel w/o patches:

buffered IO write: (no sync)
# time ./filetst  -b 1048576 -w -f /mnt/a
	2.6.15		2.6.15+patches
real    0m25.773s	0m26.102s
user    0m0.004s	0m0.000s
sys     0m15.065s	0m16.053s

buffered IO read (after umount/remount)
# time ./filetst  -b 1048576 -r -f /mnt/a
	2.6.15		2.6.15+patches
real    0m29.257s	0m29.257s
user    0m0.000s	0m0.000s
sys     0m6.996s	0m6.980s


But I do notice regression between vanilla 2.6.14 kernel and vanilla
2.6.15 kernel on buffered IO(about 18%). 

# time ./filetst  -b 1048576 -w -f /mnt/a
	2.6.14		2.6.15
real    0m21.710s	0m25.773s
user    0m0.012s	0m0.004s
sys     0m14.569s	0m15.065s

I also found tiobench(sequential write test) and dbench has similar
regression between 2.6.14 and 2.6.15. Actually I found 2.6.15 rc2
already has the regression.  Is this a known issue? Anyway I will
continue looking at the issue...

Thanks,
Mingming

