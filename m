Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262954AbUCRVCS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 16:02:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262961AbUCRVAp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 16:00:45 -0500
Received: from ns.suse.de ([195.135.220.2]:63981 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262954AbUCRVAa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 16:00:30 -0500
Subject: Re: True  fsync() in Linux (on IDE)
From: Chris Mason <mason@suse.com>
To: Peter Zaitsev <peter@mysql.com>
Cc: Jens Axboe <axboe@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1079642801.2447.369.camel@abyss.local>
References: <1079572101.2748.711.camel@abyss.local>
	 <20040318064757.GA1072@suse.de> <1079639060.3102.282.camel@abyss.local>
	 <20040318194745.GA2314@suse.de>  <1079640699.11062.1.camel@watt.suse.com>
	 <1079641026.2447.327.camel@abyss.local>
	 <1079642001.11057.7.camel@watt.suse.com>
	 <1079642801.2447.369.camel@abyss.local>
Content-Type: text/plain
Message-Id: <1079643740.11057.16.camel@watt.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 18 Mar 2004 16:02:20 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-03-18 at 15:46, Peter Zaitsev wrote:
> On Thu, 2004-03-18 at 12:33, Chris Mason wrote:
> 
> > Some suse 8.2 kernels had write barriers for IDE, some did not.  If
> > you're running any kind of recent suse kernel, you're doing cache
> > flushes on fsync with ext3.
> 
> I have this kernel:
> 
> 
> Linux abyss 2.4.20-4GB #1 Sat Feb 7 02:07:16 UTC 2004 i686 unknown
> unknown GNU/Linux
> 
> I believe it is reasonably  recent one from Hubert's kernels.
> 
> The thing is the performance is different if file grows or it does not.
> If it does - we have some 25 fsync/sec. IF we're writing to existing
> one, we have some 1600 fsync/sec 
> 
> In the former case cache is surely not flushed. 
> 
Hmmm, is it reiser?  For both 2.4 reiserfs and ext3, the flush happens
when you commit.  ext3 always commits on fsync and reiser only commits
when you've changed metadata.

Thanks to Jens, the 2.6 barrier patch has a nice clean way to allow
barriers on fsync, O_SYNC, O_DIRECT, etc, so we can make IDE drives much
safer than the 2.4 code did.  

I had a patch to make fsync always generate the barriers in 2.4, but it
was tricky since it had to figure out the last buffer it was going to
write before it wrote it.  The 2.6 code is much better.

> 2.4 does flush in one case but not in other. 2.6 does not do it in ether
> case.
> 
> I was also surprised to see this simple test case has so different
> performance with default and "deadline" IO scheduler   -  1.6 vs 0.5 sec
> per 1000 fsync's.

Not sure on that one, both cases are generating tons of unplugs, the
drive is just responding insanely fast.

-chris


