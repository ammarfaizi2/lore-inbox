Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945942AbWANBMS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945942AbWANBMS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 20:12:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423259AbWANBMS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 20:12:18 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:65453 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1423248AbWANBMR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 20:12:17 -0500
Subject: Fall back io scheduler for 2.6.15?
From: Mingming Cao <cmm@us.ibm.com>
Reply-To: cmm@us.ibm.com
To: Andrew Morton <akpm@osdl.org>
Cc: Seetharami Seelam <seelam@cs.utep.edu>, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net
In-Reply-To: <20060111114303.45540193.akpm@osdl.org>
References: <1112673094.14322.10.camel@mindpipe>
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
	 <1137007032.4395.24.camel@localhost.localdomain>
	 <20060111114303.45540193.akpm@osdl.org>
Content-Type: text/plain
Organization: IBM LTC
Date: Fri, 13 Jan 2006 17:12:15 -0800
Message-Id: <1137201135.4353.81.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-01-11 at 11:43 -0800, Andrew Morton wrote:
> Mingming Cao <cmm@us.ibm.com> wrote:
> >
> > # time ./filetst  -b 1048576 -w -f /mnt/a
> >  	2.6.14		2.6.15
> >  real    0m21.710s	0m25.773s
> >  user    0m0.012s	0m0.004s
> >  sys     0m14.569s	0m15.065s
> 
> That's a big drop.
> 
> Was it doing I/O, or was it all from pagecache?
> 
> >  I also found tiobench(sequential write test) and dbench has similar
> >  regression between 2.6.14 and 2.6.15. Actually I found 2.6.15 rc2
> >  already has the regression.  Is this a known issue?
> 
> No, it is not known.
> 
> > Anyway I will continue looking at the issue...
> 
> Thanks.
Hi, Andrew,

I did some trace, it turns out there isn't regression between 2.6.14 and
2.6.15, and there is no problem in ext3 filesystem.  I am comparing
apple to orange: the tests were run on two different io schedulers. That
makes the bogus throughput difference that I reported to you earlier
this week.

I gave the same boot option "elevator=as" for both 2.6.14 and 2.6.15-rc2
(this has been working for me for a long time to get the anticipatory
scheduler on), but the results are, the io schedulers turned on on the
two kernels are different( see elevator_setup_default()). On 2.6.14, the
fall back io scheduler (if the chosen io scheduler is not found) is set
to the default io scheduler (anticipatory, in this case), but since
2.6.15-rc1, this semanistic is changed to fall back to noop.

Is there any reason to fall back to noop instead of as?  It seems
anticipatory is much better than noop for ext3 with large sequential
write tests (i.e, 1G dd test) ...

Thanks,

Mingming


