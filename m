Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261385AbVDIVgC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261385AbVDIVgC (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Apr 2005 17:36:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261388AbVDIVgC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Apr 2005 17:36:02 -0400
Received: from unthought.net ([212.97.129.88]:54172 "EHLO unthought.net")
	by vger.kernel.org with ESMTP id S261385AbVDIVfv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Apr 2005 17:35:51 -0400
Date: Sat, 9 Apr 2005 23:35:49 +0200
From: Jakob Oestergaard <jakob@unthought.net>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Greg Banks <gnb@sgi.com>, linux-kernel@vger.kernel.org
Subject: Re: bdflush/rpciod high CPU utilization, profile does not make sense
Message-ID: <20050409213549.GW347@unthought.net>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	Trond Myklebust <trond.myklebust@fys.uio.no>,
	Greg Banks <gnb@sgi.com>, linux-kernel@vger.kernel.org
References: <20050406160123.GH347@unthought.net> <20050406231906.GA4473@sgi.com> <20050407153848.GN347@unthought.net> <1112890671.10366.44.camel@lade.trondhjem.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1112890671.10366.44.camel@lade.trondhjem.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 07, 2005 at 12:17:51PM -0400, Trond Myklebust wrote:
> to den 07.04.2005 Klokka 17:38 (+0200) skreiv Jakob Oestergaard:
> 
> > I tweaked the VM a bit, put the following in /etc/sysctl.conf:
> >  vm.dirty_writeback_centisecs=100
> >  vm.dirty_expire_centisecs=200
> > 
> > The defaults are 500 and 3000 respectively...
> > 
> > This improved things a lot; the client is now "almost not very laggy",
> > and load stays in the saner 1-2 range.
> 
> OK. That hints at what is causing the latencies on the server: I'll bet
> it is the fact that the page reclaim code tries to be clever, and uses
> NFSv3 STABLE writes in order to be able to free up the dirty pages
> immediately. Could you try the following patch, and see if that makes a
> difference too?

The patch alone without the tweaked VM settings doesn't cure the lag - I
think it's better than without the patch (I can actually type this mail
with a large copy running). With the tweaked VM settings too, it's
pretty good - still a little lag, but not enough to really make it
annoying.

Performance is pretty much the same as before (copying an 8GiB file with
15-16MiB/sec - about half the performance of what I get locally on the
file server).

Something that worries me;  It seems that 2.4.25 is a lot faster as NFS
client than 2.6.11.6, most notably on writes - see the following
tiobench results (2000 KiB file, tests with 1, 2 and 4 threads) up
against the same NFS server:

2.4.25:  (dual athlon MP 1.4GHz, 1G RAM, Intel e1000)

         File   Block  Num  Seq Read    Rand Read   Seq Write  Rand Write
  Dir    Size   Size   Thr Rate (CPU%) Rate (CPU%) Rate (CPU%) Rate (CPU%)
------- ------ ------- --- ----------- ----------- ----------- -----------
   .     2000   4096    1  58.87 54.9% 5.615 5.03% 44.40 44.2% 4.534 8.41%
   .     2000   4096    2  56.98 58.3% 6.926 6.64% 41.61 58.0% 4.462 10.8%
   .     2000   4096    4  53.90 59.0% 7.764 9.44% 39.85 61.5% 4.256 10.8%


2.6.11.6: (dual PIII 1GHz, 2G RAM, Intel e1000)

         File   Block  Num  Seq Read    Rand Read   Seq Write  Rand Write
  Dir    Size   Size   Thr Rate (CPU%) Rate (CPU%) Rate (CPU%) Rate (CPU%)
------- ------ ------- --- ----------- ----------- ----------- -----------
   .     2000   4096    1  38.34 18.8% 19.61 6.77% 22.53 23.4% 6.947 15.6%
   .     2000   4096    2  52.82 29.0% 24.42 9.37% 24.20 27.0% 7.755 16.7%
   .     2000   4096    4  62.48 34.8% 33.65 17.0% 24.73 27.6% 8.027 15.4%


44MiB/sec for 2.4 versus 22MiB/sec for 2.6 - any suggestions as to how
this could be improved?

(note; the write performance doesn't change notably with VM tuning nor
with the one-liner change that Trond suggested)

-- 

 / jakob

